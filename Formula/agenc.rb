class Agenc < Formula
  desc "Daemon-backed, terminal-native coding agent"
  homepage "https://github.com/tetsuo-ai/agenc-releases"
  url "https://github.com/tetsuo-ai/agenc-releases/releases/download/agenc-v0.6.1/agenc-installer.tar.gz"
  sha256 "849e1bd3955e6d20567547d57c8aebf1a96551271ec003ff334fa1a0dbc532bc"
  version "0.6.1"
  license "MIT"

  depends_on "node"
  depends_on "ripgrep"

  def install
    # The installer speaks the shared runtime-manager contract: manifest
    # fetch, sha256 verify, extract to AGENC_HOME/runtime/<version>/, wrapper.
    system "sh", "install.sh",
           "--prefix", prefix.to_s,
           "--no-daemon",
           "--version", version.to_s
  end

  def caveats
    <<~EOS
      Start the daemon as a user service:
        agenc daemon start
      Guided setup:
        agenc onboard
      Security posture:
        agenc security audit
    EOS
  end

  test do
    assert_match "agenc", shell_output("#{bin}/agenc --version")
  end
end
