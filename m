Date: Wed, 4 Apr 2018 12:32:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core updates for 4.17-rc1
Message-ID: <20180404103246.GA12602@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/ tags/driver-core-4.17-rc1

for you to fetch changes up to 1fe56e0cafd7e4cf26f3582aad0c7705fceff498:

  drivers: base: remove check for callback in coredump_store() (2018-03-23 18:08:02 +0100)

----------------------------------------------------------------
Driver core patches for 4.17-rc1

Here is the "big" set of driver core patches for 4.17-rc1.

There's really not much here, just a bunch of firmware code refactoring
from Luis as he attempts to wrangle that codebase into something that is
managable, along with a bunch of userspace tests for it.  Other than
that, a handful of small bugfixes and reverts of things that didn't work
out.

Full details are in the shortlog, it's not all that much.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      lib/kobject: Join string literals back

Arend van Spriel (2):
      drivers: base: add description for .coredump() callback
      drivers: base: remove check for callback in coredump_store()

Arvind Yadav (4):
      base: soc: use put_device() instead of kfree()
      driver core: platform: use put_device() if device_register fail
      driver core: node: use put_device() if device_register fail
      driver core: cpu: use put_device() if device_register fail

Gaku Inami (1):
      Revert "base: arch_topology: fix section mismatch build warnings"

Luis R. Rodriguez (21):
      test_firmware: add simple firmware firmware test library
      test_firmware: enable custom fallback testing on limited kernel configs
      test_firmware: replace syfs fallback check with kconfig_has helper
      firmware: enable to split firmware_class into separate target files
      firmware: simplify CONFIG_FW_LOADER_USER_HELPER_FALLBACK further
      firmware: use helpers for setting up a temporary cache timeout
      firmware: move loading timeout under struct firmware_fallback_config
      firmware: split firmware fallback functionality into its own file
      firmware: move firmware loader into its own directory
      firmware: enable run time change of forcing fallback loader
      firmware: enable to force disable the fallback mechanism at run time
      test_firmware: expand on library with shared helpers
      test_firmware: test three firmware kernel configs using a proc knob
      rename: _request_firmware_load() fw_load_sysfs_fallback()
      firmware: fix checking for return values for fw_add_devm_name()
      firmware: add helper to check to see if fw cache is setup
      test_firmware: modify custom fallback tests to use unique files
      firmware: ensure the firmware cache is not used on incompatible calls
      firmware: fix typo on pr_info_once() when ignore_sysfs_fallback is used
      firmware: add firmware_request_cache() to help with cache on reboot
      mt7601u: use firmware_request_cache() to address cache on reboot

Stephen Rothwell (1):
      firmware: explicitly include vmalloc.h

 .../driver-api/firmware/fallback-mechanisms.rst    |   2 +-
 .../driver-api/firmware/request_firmware.rst       |  14 +
 MAINTAINERS                                        |   2 +-
 drivers/base/Makefile                              |   2 +-
 drivers/base/arch_topology.c                       |  12 +-
 drivers/base/cpu.c                                 |   4 +-
 drivers/base/dd.c                                  |   3 +-
 drivers/base/firmware_loader/Makefile              |   7 +
 drivers/base/firmware_loader/fallback.c            | 675 +++++++++++++++++
 drivers/base/firmware_loader/fallback.h            |  67 ++
 drivers/base/firmware_loader/fallback_table.c      |  55 ++
 drivers/base/firmware_loader/firmware.h            | 115 +++
 .../{firmware_class.c => firmware_loader/main.c}   | 833 ++-------------------
 drivers/base/node.c                                |   4 +-
 drivers/base/platform.c                            |   4 +-
 drivers/base/soc.c                                 |   2 +
 drivers/net/wireless/mediatek/mt7601u/mcu.c        |   2 +-
 include/linux/device.h                             |   1 +
 include/linux/firmware.h                           |   3 +
 kernel/sysctl.c                                    |  11 +
 lib/kobject.c                                      |  39 +-
 tools/testing/selftests/firmware/Makefile          |   2 +-
 tools/testing/selftests/firmware/config            |   4 +
 tools/testing/selftests/firmware/fw_fallback.sh    |  65 +-
 tools/testing/selftests/firmware/fw_filesystem.sh  |  72 +-
 tools/testing/selftests/firmware/fw_lib.sh         | 194 +++++
 tools/testing/selftests/firmware/fw_run_tests.sh   |  70 ++
 27 files changed, 1370 insertions(+), 894 deletions(-)
 create mode 100644 drivers/base/firmware_loader/Makefile
 create mode 100644 drivers/base/firmware_loader/fallback.c
 create mode 100644 drivers/base/firmware_loader/fallback.h
 create mode 100644 drivers/base/firmware_loader/fallback_table.c
 create mode 100644 drivers/base/firmware_loader/firmware.h
 rename drivers/base/{firmware_class.c => firmware_loader/main.c} (60%)
 create mode 100755 tools/testing/selftests/firmware/fw_lib.sh
 create mode 100755 tools/testing/selftests/firmware/fw_run_tests.sh
