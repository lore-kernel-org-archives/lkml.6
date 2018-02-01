Date: Thu, 1 Feb 2018 12:08:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core updates for 4.16-rc1
Message-ID: <20180201110824.GA29150@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/ tags/driver-core-4.16-rc1

for you to fetch changes up to c505cbd45f6e9c539d57dd171d95ec7e5e9f9cd0:

  device property: Define type of PROPERTY_ENRTY_*() macros (2018-01-25 13:44:20 +0100)

----------------------------------------------------------------
Driver Core updates for 4.16-rc1

Here is the set of "big" driver core patches for 4.16-rc1.

The majority of the work here is in the firmware subsystem, with reworks
to try to attempt to make the code easier to handle in the long run, but
no functional change.  There's also some tree-wide sysfs attribute
fixups with lots of acks from the various subsystem maintainers, as well
as a handful of other normal fixes and changes.

And finally, some license cleanups for the driver core and sysfs code.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (3):
      device property: Move property_entry_free_data() upper
      device property: Reuse property_entry_free_data()
      device property: Define type of PROPERTY_ENRTY_*() macros

Arend van Spriel (2):
      sysfs: add attribute specification for /sysfs/devices/.../coredump
      drivers: base: add coredump driver ops

Benjamin Gilbert (3):
      USB: serial: keyspan: Drop firmware Kconfig options
      firmware: Drop FIRMWARE_IN_KERNEL Kconfig option
      firmware: Fix up docs referring to FIRMWARE_IN_KERNEL

Gimcuan Hui (1):
      drivers: base: omit redundant interations

Greg Kroah-Hartman (10):
      kobject: add SPDX identifiers to all kobject files
      kobject: Remove redundant license text
      driver core: add SPDX identifiers to all driver core files
      drivers: core: arch_topology.c: move SPDX tag to top of the file
      driver core: Remove redundant license text
      Merge 4.15-rc3 into driver-core-next
      Merge 4.15-rc6 into driver-core-next
      sysfs: turn WARN() into pr_warn()
      sysfs: use SPDX identifiers
      sysfs: remove DEBUG defines

Joe Perches (4):
      sysfs.h: Use octal permissions
      treewide: Use DEVICE_ATTR_RW
      treewide: Use DEVICE_ATTR_RO
      treewide: Use DEVICE_ATTR_WO

Luis R. Rodriguez (20):
      firmware: add helper to unregister pm ops
      firmware: fix capturing errors on fw_cache_init() on early init
      firmware: provide helpers for registering the syfs loader
      firmware: fix detecting error on register_reboot_notifier()
      test_firmware: fix setting old custom fw path back on exit
      firmware: rename struct firmware_priv to struct fw_sysfs
      firmware: rename struct firmware_buf to struct fw_priv
      firmware: rename struct fw_priv->fw_id to fw_name
      firmware: move core data structures to the top of file
      firmware: remove duplicate fw_state_aborted()
      firmware: remove unused __fw_state_is_done()
      firmware: use static inlines for state machine checking
      firmware: rename sysfs state checks with sysfs prefix
      firmware: use static inline for to_fw_priv()
      firmware: add helper to copy built-in data to pre-alloc buffer
      firmware: provide helper for FW_OPT_USERHELPER
      firmware: replace #ifdef over FW_OPT_FALLBACK with function checks
      test_firmware: wrap sysfs timeout test into helper
      test_firmware: wrap basic sysfs fallback tests into helper
      test_firmware: wrap custom sysfs load tests into helper

Maciej Purski (1):
      component: add debugfs support

Masanari Iida (1):
      firmware: Fix a typo in fallback-mechanisms.rst

Paul Gortmaker (1):
      bus: simple-pm-bus: convert bool SIMPLE_PM_BUS to tristate

Vasyl Gomonovych (2):
      sysfs: Use PTR_ERR_OR_ZERO()
      PNP: pnpbios: Use PTR_ERR_OR_ZERO()

Wei Yongjun (2):
      test_firmware: make local symbol test_fw_config static
      test_firmware: fix missing unlock on error in config_num_requests_store()

 Documentation/ABI/testing/sysfs-devices-coredump   |  10 +
 Documentation/driver-api/firmware/built-in-fw.rst  |   7 +-
 .../driver-api/firmware/fallback-mechanisms.rst    |   2 +-
 Documentation/x86/microcode.txt                    |   5 +-
 arch/arc/configs/axs101_defconfig                  |   1 -
 arch/arc/configs/axs103_defconfig                  |   1 -
 arch/arc/configs/axs103_smp_defconfig              |   1 -
 arch/arc/configs/haps_hs_defconfig                 |   1 -
 arch/arc/configs/haps_hs_smp_defconfig             |   1 -
 arch/arc/configs/hsdk_defconfig                    |   1 -
 arch/arc/configs/nsim_700_defconfig                |   1 -
 arch/arc/configs/nsim_hs_defconfig                 |   1 -
 arch/arc/configs/nsim_hs_smp_defconfig             |   1 -
 arch/arc/configs/nsimosci_defconfig                |   1 -
 arch/arc/configs/nsimosci_hs_defconfig             |   1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig         |   1 -
 arch/arc/configs/tb10x_defconfig                   |   1 -
 arch/arc/configs/vdk_hs38_defconfig                |   1 -
 arch/arc/configs/vdk_hs38_smp_defconfig            |   1 -
 arch/arm/configs/cns3420vb_defconfig               |   1 -
 arch/arm/configs/magician_defconfig                |   1 -
 arch/arm/configs/mini2440_defconfig                |   1 -
 arch/arm/configs/mv78xx0_defconfig                 |   1 -
 arch/arm/configs/mxs_defconfig                     |   1 -
 arch/arm/configs/orion5x_defconfig                 |   1 -
 arch/arm/configs/tegra_defconfig                   |   1 -
 arch/arm/configs/vf610m4_defconfig                 |   1 -
 arch/arm/mach-pxa/sharpsl_pm.c                     |   4 +-
 arch/m68k/configs/amiga_defconfig                  |   1 -
 arch/m68k/configs/apollo_defconfig                 |   1 -
 arch/m68k/configs/atari_defconfig                  |   1 -
 arch/m68k/configs/bvme6000_defconfig               |   1 -
 arch/m68k/configs/hp300_defconfig                  |   1 -
 arch/m68k/configs/mac_defconfig                    |   1 -
 arch/m68k/configs/multi_defconfig                  |   1 -
 arch/m68k/configs/mvme147_defconfig                |   1 -
 arch/m68k/configs/mvme16x_defconfig                |   1 -
 arch/m68k/configs/q40_defconfig                    |   1 -
 arch/m68k/configs/sun3_defconfig                   |   1 -
 arch/m68k/configs/sun3x_defconfig                  |   1 -
 arch/mips/configs/ar7_defconfig                    |   1 -
 arch/mips/configs/ath25_defconfig                  |   1 -
 arch/mips/configs/ath79_defconfig                  |   1 -
 arch/mips/configs/pic32mzda_defconfig              |   1 -
 arch/mips/configs/qi_lb60_defconfig                |   1 -
 arch/mips/configs/rm200_defconfig                  |   9 -
 arch/mips/configs/rt305x_defconfig                 |   1 -
 arch/mips/configs/xway_defconfig                   |   1 -
 arch/mn10300/configs/asb2364_defconfig             |   1 -
 arch/powerpc/configs/44x/warp_defconfig            |   1 -
 arch/powerpc/configs/c2k_defconfig                 |  12 -
 arch/powerpc/configs/g5_defconfig                  |  12 -
 arch/powerpc/configs/maple_defconfig               |  12 -
 arch/powerpc/configs/mpc512x_defconfig             |   1 -
 arch/powerpc/configs/pmac32_defconfig              |  12 -
 arch/powerpc/configs/ppc6xx_defconfig              |   1 -
 arch/powerpc/configs/ps3_defconfig                 |   1 -
 arch/powerpc/configs/wii_defconfig                 |   1 -
 arch/s390/configs/zfcpdump_defconfig               |   1 -
 arch/s390/kernel/smp.c                             |   2 +-
 arch/s390/kernel/topology.c                        |   3 +-
 arch/sh/configs/polaris_defconfig                  |   1 -
 arch/sh/drivers/push-switch.c                      |   2 +-
 arch/tile/configs/tilegx_defconfig                 |   1 -
 arch/tile/configs/tilepro_defconfig                |   1 -
 arch/tile/kernel/sysfs.c                           |  12 +-
 arch/x86/Kconfig                                   |   6 +-
 arch/x86/kernel/cpu/microcode/core.c               |   2 +-
 drivers/acpi/device_sysfs.c                        |   6 +-
 drivers/base/Kconfig                               |  28 +-
 drivers/base/arch_topology.c                       |   8 +-
 drivers/base/attribute_container.c                 |   3 +-
 drivers/base/bus.c                                 |   6 +-
 drivers/base/cacheinfo.c                           |  13 +-
 drivers/base/class.c                               |   4 +-
 drivers/base/component.c                           |  83 +-
 drivers/base/container.c                           |   5 +-
 drivers/base/core.c                                |   6 +-
 drivers/base/cpu.c                                 |   1 +
 drivers/base/dd.c                                  |  43 +-
 drivers/base/devcoredump.c                         |  17 +-
 drivers/base/devres.c                              |   3 +-
 drivers/base/dma-contiguous.c                      |   6 +-
 drivers/base/dma-mapping.c                         |   3 +-
 drivers/base/driver.c                              |   6 +-
 drivers/base/firmware.c                            |   3 +-
 drivers/base/firmware_class.c                      | 859 ++++++++++++---------
 drivers/base/hypervisor.c                          |   3 +-
 drivers/base/init.c                                |   3 +-
 drivers/base/isa.c                                 |   1 +
 drivers/base/map.c                                 |   2 +-
 drivers/base/module.c                              |   4 +-
 drivers/base/pinctrl.c                             |   3 +-
 drivers/base/platform-msi.c                        |  13 +-
 drivers/base/platform.c                            |   3 +-
 drivers/base/property.c                            |  73 +-
 drivers/base/soc.c                                 |   2 +-
 drivers/base/syscore.c                             |   3 +-
 drivers/base/test/test_async_driver_probe.c        |  10 +-
 drivers/base/topology.c                            |  17 +-
 drivers/base/transport_class.c                     |   3 +-
 drivers/bus/Kconfig                                |   2 +-
 drivers/char/ipmi/ipmi_msghandler.c                |  17 +-
 drivers/gpu/drm/i915/i915_sysfs.c                  |  12 +-
 drivers/input/touchscreen/elants_i2c.c             |   2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   2 +-
 drivers/net/wimax/i2400m/sysfs.c                   |   3 +-
 drivers/nvme/host/core.c                           |  10 +-
 drivers/platform/x86/compal-laptop.c               |  18 +-
 drivers/pnp/pnpbios/core.c                         |   5 +-
 drivers/s390/cio/css.c                             |   8 +-
 drivers/s390/cio/device.c                          |  10 +-
 drivers/s390/crypto/ap_card.c                      |   2 +-
 drivers/scsi/hpsa.c                                |  10 +-
 drivers/scsi/lpfc/lpfc_attr.c                      |  64 +-
 drivers/thermal/thermal_sysfs.c                    |  17 +-
 drivers/tty/serial/sh-sci.c                        |   2 +-
 drivers/usb/phy/phy-tahvo.c                        |   2 +-
 drivers/usb/serial/Kconfig                         |  78 --
 drivers/video/fbdev/auo_k190x.c                    |   4 +-
 drivers/video/fbdev/w100fb.c                       |   4 +-
 fs/sysfs/dir.c                                     |   9 +-
 fs/sysfs/file.c                                    |   3 +-
 fs/sysfs/group.c                                   |   6 +-
 fs/sysfs/mount.c                                   |   5 +-
 fs/sysfs/symlink.c                                 |   3 +-
 fs/sysfs/sysfs.h                                   |   3 +-
 include/linux/device.h                             |   5 +-
 include/linux/kobject.h                            |   3 +-
 include/linux/kobject_ns.h                         |   3 +-
 include/linux/property.h                           |  10 +-
 include/linux/sysfs.h                              |  14 +-
 lib/kobject.c                                      |   4 +-
 lib/kobject_uevent.c                               |   3 +-
 lib/test_firmware.c                                |  17 +-
 lib/test_kmod.c                                    |  14 +-
 samples/kobject/kobject-example.c                  |   4 +-
 samples/kobject/kset-example.c                     |   4 +-
 sound/soc/omap/mcbsp.c                             |   4 +-
 sound/soc/soc-core.c                               |   2 +-
 sound/soc/soc-dapm.c                               |   2 +-
 tools/testing/selftests/firmware/fw_fallback.sh    | 172 +++--
 tools/testing/selftests/firmware/fw_filesystem.sh  |   5 +-
 143 files changed, 921 insertions(+), 1053 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-coredump
