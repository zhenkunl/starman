class Pgi < Package
  if OS.linux?
    url 'https://download.pgroup.com/secure/pgilinux-2018-184-x86-64.tar.gz?Q097P6Z3vZtCfBXNitlkv0Vae12a0TJ-SblG4raK1vuXj75UgouyESuq9O4iIwhLktb0FR-RPSM6fQsDmSxqxghVKYT9Z7Wr1Xkyk7JVS9eIpNSI5-B5-GvzsPJIOGe_3Y-uGWk'
    sha256 '9da8f869fb9b70c0c4423c903d40a9e22d54b997af359a43573c0841165cd1b6'
    file_name 'pgilinux-2018-184-x86_64.tar.gz'
  end
  version '18.04'

  label :compiler

  option 'with-nvidia', 'Install NVIDIA components, such as CUDA.'
  option 'with-amd', 'Install AMD components.'
  option 'with-java', 'Install JRE for PGI debugger and profiler.'
  option 'with-mpi', 'Install precompiled OpenMPI (not recommended).'
  option 'with-mpi-gpu', 'Install NVIDIA GPU support in OpenMPI.'

  link "#{prefix}/linux86-64/#{version}/bin/*", 'bin'

  def install
    ENV['PGI_SILENT'] = 'true'
    ENV['PGI_ACCEPT_EULA'] = 'accept'
    ENV['PGI_INSTALL_DIR'] = prefix
    ENV['PGI_INSTALL_TYPE'] = 'network'
    ENV['PGI_INSTALL_LOCAL_DIR'] = '/var/pgi'
    ENV['PGI_INSTALL_NVIDIA'] = with_nvidia?.to_s
    ENV['PGI_INSTALL_AMD'] = with_amd?.to_s
    ENV['PGI_INSTALL_JAVA'] = with_java?.to_s
    ENV['PGI_INSTALL_MPI'] = with_mpi?.to_s
    ENV['PGI_MPI_GPU_SUPPORT'] = with_mpi_gpu?.to_s
    run './install'
  end
end
