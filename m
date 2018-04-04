Date: Wed, 4 Apr 2018 12:33:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 4.17-rc1
Message-ID: <20180404103310.GA13881@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-4.17-rc1

for you to fetch changes up to 86f690e8bfd124c38940e7ad58875ef383003348:

  Merge tag 'stm-intel_th-for-greg-20180329' of git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm into char-misc-next (2018-03-29 14:15:13 +0200)

----------------------------------------------------------------
Char/Misc patches for 4.17-rc1

Here is the big set of char/misc driver patches for 4.17-rc1.

There are a lot of little things in here, nothing huge, but all
important to the different hardware types involved:
	- thunderbolt driver updates
	- parport updates (people still care...)
	- nvmem driver updates
	- mei updates (as always)
	- hwtracing driver updates
	- hyperv driver updates
	- extcon driver updates
	- and a handfull of even smaller driver subsystem and individual
	  driver updates

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Gerasiov (1):
      parport_pc: Add support for WCH CH382L PCI-E single parallel port card.

Alexander Shishkin (9):
      MAINTAINERS: Bestow upon myself the care for drivers/hwtracing
      stm class: Add SPDX GPL-2.0 header to replace GPLv2 boilerplate
      stm class: Make dummy's master/channel ranges configurable
      intel_th: Add SPDX GPL-2.0 header to replace GPLv2 boilerplate
      intel_th: Use correct method of finding hub
      intel_th: Don't touch switch routing in host mode
      intel_th: Pick up irq number from resources
      intel_th: Allow forcing host mode through drvdata
      intel_th: Add ACPI glue layer

Alexander Usyskin (1):
      mei: limit the number of queued writes

Alexandre Belloni (1):
      char: nvram: disable on ARM

Andrey Smirnov (21):
      nvmem: Document struct nvmem_config
      nvmem: core: Allow specifying device name verbatim
      nvmem: Introduce devm_nvmem_(un)register()
      nvmem: vf610-ocotp: Convert to use devm_nvmem_register()
      nvmem: imx-ocotp: Convert to use devm_nvmem_register()
      nvmem: uniphier-efuse: Convert to use devm_nvmem_register()
      nvmem: snvs_lgpr: Convert to use devm_nvmem_register()
      nvmem: rockchip-efuse: Convert to use devm_nvmem_register()
      nvmem: mtk-efuse: Convert to use devm_nvmem_register()
      nvmem: meson-mx-efuse: Convert to use devm_nvmem_register()
      nvmem: meson-efuse: Convert to use devm_nvmem_register()
      nvmem: lpc18xx_otp: Convert to use devm_nvmem_register()
      nvmem: imx-iim: Convert to use devm_nvmem_register()
      nvmem: bcm-ocotp: Convert to use devm_nvmem_register()
      nvmem: qfprom: Convert to use devm_nvmem_register()
      nvmem: snvs_lpgpr: Convert commas to semicolons
      nvmem: rockchip-efuse: Make use of of_device_get_match_data()
      nvmem: vf610-ocotp: Do not use "&pdev->dev" explicitly
      nvmem: rockchip-efuse: Do not use "&pdev->dev" explicitly
      nvmem: imx-iim: Do not use "&pdev->dev" explicitly
      nvmem: bcm-ocotp: Do not use "&pdev->dev" explicitly

Andrey Yurovsky (1):
      nvmem: add i.MX7 support to snvs-lpgpr

Andrzej Hajda (3):
      dt-bindings: add bindings for USB physical connector
      dt-bindings: add bindings for Samsung micro-USB 11-pin connector
      extcon: add possibility to get extcon device by OF node

Andy Shevchenko (9):
      parport: Add support for BrainBoxes PX272/PX306 MIO card
      parport: PCI core handles power state for us
      parport: Convert to use managed functions pcim_* and devm_*
      parport: Don't shadow error codes in ->probe()
      parport: Convert printk(KERN_WARN) to dev_warn()
      parport: Switch to use module_pci_driver() macro
      parport: Sort headers alphabetically
      parport: Replace short License header by SPDX identifier
      extcon: int3496: Ignore incorrect IoRestriction for ID pin

Arvind Yadav (4):
      w1: use put_device() if device_register() fail
      slimbus: core: use put_device() instead of kfree()
      misc: mic: Release reference count and memory for VOP device
      misc: ocxl: use put_device() instead of device_unregister()

Bartosz Golaszewski (21):
      eeprom: at24: disable regmap locking
      eeprom: at24: remove nvmem_config from at24_data
      eeprom: at24: arrange local variables
      eeprom: at24: remove code separators
      eeprom: at24: drop redundant variable in at24_read()
      eeprom: at24: drop redundant variable in at24_write()
      eeprom: at24: make struct initialization uniform in at24_probe()
      eeprom: at24: don't check if byte_len is a power of 2
      eeprom: at24: rename at24_get_pdata()
      eeprom: at24: rename chip to pdata in at24_probe()
      eeprom: at24: use a helper variable for dev
      eeprom: at24: readability tweak in at24_probe()
      eeprom: at24: provide and use at24_base_client_dev()
      eeprom: at24: switch to using probe_new() from the i2c framework
      eeprom: at24: move platform data processing into a separate routine
      eeprom: at24: remove at24_platform_data from at24_data
      eeprom: at24: refactor at24_probe()
      eeprom: at24: tweak newlines
      eeprom: at24: fix a line break
      eeprom: at24: simplify the i2c functionality checking
      eeprom: at24: use SPDX identifier instead of GPL boiler-plate

Bo Yan (1):
      coresight: etm4x: Fix bit shifting

Chanwoo Choi (1):
      Merge branch 'ib-extcon-drm-dt-v4.17' into extcon-next

Christopher Bostic (3):
      fsi: core: Reduce console output during normal scan
      dt-bindings: fsi: Add optional property no-scan-on-init
      fsi: core: Add check for master property no-scan-on-init

Colin Ian King (2):
      mei: remove dev_err message on an unsupported ioctl
      misc: rtsx: make various functions static

Devang Panchal (1):
      eeprom: at25: sizeof t should be sizeof(t)

Dexuan Cui (3):
      tools: hv: fix compiler warnings about major/target_fname
      Drivers: hv: vmbus: respect what we get from hv_get_synint_state()
      Drivers: hv: vmbus: do not mark HV_PCIE as perf_device

Dong Aisheng (2):
      dt-bindings: nvmem: imx-ocotp: update the binding to reflect data cells
      nvmem: imx-ocotp: remove unused dead code

Eddie James (1):
      fsi: Fix one and two byte bus reads/writes

Gavin Schenk (1):
      siox: fix possible buffer overflow in device_add_store

Greg Kroah-Hartman (4):
      Merge tag 'thunderbolt-for-v4.17' of git://git.kernel.org/.../westeri/thunderbolt into char-misc-next
      Merge tag 'extcon-next-for-4.17' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge 4.16-rc7 into char-misc-next
      Merge tag 'stm-intel_th-for-greg-20180329' of git://git.kernel.org/.../ash/stm into char-misc-next

Haiyang Zhang (2):
      tools/hv: Fix IP reporting by KVP daemon with SRIOV
      hv_vmbus: Correct the stale comments regarding cpu affinity

Hans de Goede (1):
      extcon: intel-cht-wc: Set direction and drv flags for V5 boost GPIO

Icenowy Zheng (1):
      nvmem: sunxi-sid: fix H3 SID controller support

Jeremy Kerr (6):
      fsi: Add fsi_master_rescan()
      fsi: master-gpio: Add locking during break and link enable
      fsi: master-gpio: Add external mode
      dt-bindings: fsi: Add specification for FSI busses
      fsi: Match fsi slaves and engines to available dt nodes
      fsi: master: Clarify master lifetimes & fix use-after-free in hub master

Jia-Ju Bai (1):
      hyper-v: use GFP_KERNEL for hv_context.hv_numa_map

Joe Perches (1):
      hv: Synthetic typo correction

Joel Stanley (3):
      dt-bindings: aspeed-lpc: Document LPC Host Interface Controller
      misc: aspeed-lpc: Request and enable LPC clock
      misc: aspeed-lpc-ctrl: Enable FWH and A2H bridge cycles

Johannes Thumshirn (2):
      PCI: Add Altera vendor ID
      mcb: add Altera PCI ID to mcb-pci

Kees Cook (3):
      lkdtm: Relocate code to subdirectory
      lkdtm: Add missing SPDX-License-Identifier line
      /dev/mem: Avoid overwriting "err" in read_mem()

Leo Yan (1):
      coresight: Use %px to print pcsr instead of %p

Linus Walleij (3):
      extcon: gpio: Localize platform data
      extcon: gpio: Move platform data into state container
      extcon: gpio: Convert to fully use GPIO descriptor

Maciej Purski (1):
      drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

Markus Elfring (3):
      parport: ax88796: Delete an error message for a failed memory allocation in parport_ax88796_probe()
      parport: ax88796: Improve a size determination in parport_ax88796_probe()
      parport: ax88796: Delete an unnecessary variable initialisation in parport_ax88796_probe()

Michael Kelley (1):
      Drivers: hv: vmbus: Implement Direct Mode for stimer0

Mika Westerberg (14):
      thunderbolt: Resume control channel after hibernation image is created
      thunderbolt: Serialize PCIe tunnel creation with PCI rescan
      thunderbolt: Handle connecting device in place of host properly
      thunderbolt: Do not overwrite error code when domain adding fails
      thunderbolt: Wait a bit longer for root switch config space
      thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
      thunderbolt: Handle rejected Thunderbolt devices
      thunderbolt: Factor common ICM add and update operations out
      thunderbolt: Add tb_switch_get()
      thunderbolt: Add constant for approval timeout
      thunderbolt: Move driver ready handling to struct icm
      thunderbolt: Add support for preboot ACL
      thunderbolt: Introduce USB only (SL4) security level
      thunderbolt: Prevent crash when ICM firmware is not running

Olaf Hering (1):
      tools: hv: include string.h in hv_fcopy_daemon

Radion Mirchevsky (4):
      thunderbolt: Correct function name in kernel-doc comment
      thunderbolt: Add tb_switch_find_by_route()
      thunderbolt: Add tb_xdomain_find_by_route()
      thunderbolt: Add support for Intel Titan Ridge

Randy Dunlap (1):
      hwtracing: Add HW tracing support menu

Srivatsa S. Bhat (2):
      char_dev: Fix off-by-one bugs in find_dynamic_major()
      block, char_dev: Use correct format specifier for unsigned ints

Stephen Hemminger (3):
      uio_hv_generic: support sub-channels
      hv: add SPDX license to trace
      hv: add SPDX license id to Kconfig

Sudip Mukherjee (2):
      pps: client: use new parport device model
      pps: generator: use new parport device model

Tomas Winkler (1):
      mei: make module referencing local to the bus.c

Ulf Magnusson (1):
      misc: atmel: Remove CPU_AT32AP700X (AVR32) reference

Vitaly Kuznetsov (4):
      hv_balloon: fix printk loglevel
      hv_balloon: simplify hv_online_page()/hv_page_online_one()
      hv_balloon: fix bugs in num_pages_onlined accounting
      hv_balloon: trace post_status

Yehezkel Bernat (1):
      thunderbolt: Add 'boot' attribute for devices

Yisheng Xie (1):
      devres: combine function devm_ioremap*

 Documentation/ABI/stable/sysfs-bus-vmbus           |   7 +
 Documentation/ABI/testing/sysfs-bus-thunderbolt    |  33 +
 Documentation/ABI/testing/sysfs-class-mei          |   9 +
 .../ABI/testing/sysfs-driver-fsi-master-gpio       |  10 +
 Documentation/admin-guide/thunderbolt.rst          |  15 +-
 .../connector/samsung,usb-connector-11pin.txt      |  49 ++
 .../bindings/connector/usb-connector.txt           |  75 ++
 Documentation/devicetree/bindings/fsi/fsi.txt      | 151 ++++
 .../devicetree/bindings/mfd/aspeed-lpc.txt         |  41 ++
 .../devicetree/bindings/nvmem/imx-ocotp.txt        |  23 +-
 .../devicetree/bindings/nvmem/snvs-lpgpr.txt       |   3 +-
 Documentation/driver-api/uio-howto.rst             |   5 +
 MAINTAINERS                                        |   7 +-
 arch/x86/entry/entry_32.S                          |   3 +
 arch/x86/entry/entry_64.S                          |   3 +
 arch/x86/include/asm/hardirq.h                     |   1 +
 arch/x86/include/asm/irq_vectors.h                 |   3 +-
 arch/x86/include/asm/mshyperv.h                    |  13 +
 arch/x86/include/uapi/asm/hyperv.h                 |   3 +
 arch/x86/kernel/cpu/mshyperv.c                     |  40 ++
 arch/x86/kernel/irq.c                              |   7 +
 block/genhd.c                                      |  19 +-
 drivers/Kconfig                                    |   4 +-
 drivers/char/Kconfig                               |   2 +-
 drivers/char/mem.c                                 |   6 +-
 drivers/char/xillybus/xillybus_pcie.c              |   1 -
 drivers/extcon/extcon-gpio.c                       | 103 ++-
 drivers/extcon/extcon-intel-cht-wc.c               |  11 +-
 drivers/extcon/extcon-intel-int3496.c              |   9 +-
 drivers/extcon/extcon.c                            |  44 +-
 drivers/fpga/altera-cvp.c                          |   2 -
 drivers/fsi/Kconfig                                |   1 +
 drivers/fsi/fsi-core.c                             | 129 +++-
 drivers/fsi/fsi-master-gpio.c                      |  89 ++-
 drivers/fsi/fsi-master-hub.c                       |  27 +-
 drivers/fsi/fsi-master.h                           |  17 +
 drivers/gpu/drm/bridge/sil-sii8620.c               |  97 ++-
 drivers/hv/Kconfig                                 |   2 +
 drivers/hv/Makefile                                |   1 +
 drivers/hv/channel_mgmt.c                          |   8 +-
 drivers/hv/hv.c                                    |  64 +-
 drivers/hv/hv_balloon.c                            | 121 +++-
 drivers/hv/hv_trace.c                              |   2 +
 drivers/hv/hv_trace.h                              |   2 +
 drivers/hv/hv_trace_balloon.h                      |  48 ++
 drivers/hv/hyperv_vmbus.h                          |   4 +-
 drivers/hwtracing/Kconfig                          |   7 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   2 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   4 +-
 drivers/hwtracing/intel_th/Kconfig                 |  12 +
 drivers/hwtracing/intel_th/Makefile                |   3 +
 drivers/hwtracing/intel_th/acpi.c                  |  79 +++
 drivers/hwtracing/intel_th/core.c                  |  31 +-
 drivers/hwtracing/intel_th/debug.c                 |  10 +-
 drivers/hwtracing/intel_th/debug.h                 |  10 +-
 drivers/hwtracing/intel_th/gth.c                   |  10 +-
 drivers/hwtracing/intel_th/gth.h                   |  10 +-
 drivers/hwtracing/intel_th/intel_th.h              |  14 +-
 drivers/hwtracing/intel_th/msu.c                   |  10 +-
 drivers/hwtracing/intel_th/msu.h                   |  10 +-
 drivers/hwtracing/intel_th/pci.c                   |  10 +-
 drivers/hwtracing/intel_th/pti.c                   |  10 +-
 drivers/hwtracing/intel_th/pti.h                   |  10 +-
 drivers/hwtracing/intel_th/sth.c                   |  10 +-
 drivers/hwtracing/intel_th/sth.h                   |  10 +-
 drivers/hwtracing/stm/console.c                    |  10 +-
 drivers/hwtracing/stm/core.c                       |  10 +-
 drivers/hwtracing/stm/dummy_stm.c                  |  34 +-
 drivers/hwtracing/stm/heartbeat.c                  |  10 +-
 drivers/hwtracing/stm/policy.c                     |  10 +-
 drivers/hwtracing/stm/stm.h                        |  10 +-
 drivers/mcb/mcb-pci.c                              |   1 +
 drivers/misc/Kconfig                               |   1 -
 drivers/misc/Makefile                              |  20 +-
 drivers/misc/aspeed-lpc-ctrl.c                     |  44 +-
 drivers/misc/cardreader/rts5260.c                  |  12 +-
 drivers/misc/eeprom/at24.c                         | 293 ++++----
 drivers/misc/eeprom/at25.c                         |   2 +-
 drivers/misc/lkdtm/Makefile                        |  20 +
 drivers/misc/{lkdtm_bugs.c => lkdtm/bugs.c}        |   0
 drivers/misc/{lkdtm_core.c => lkdtm/core.c}        |   0
 drivers/misc/{lkdtm_heap.c => lkdtm/heap.c}        |   0
 drivers/misc/{ => lkdtm}/lkdtm.h                   |   0
 drivers/misc/{lkdtm_perms.c => lkdtm/perms.c}      |   0
 .../misc/{lkdtm_refcount.c => lkdtm/refcount.c}    |   1 +
 drivers/misc/{lkdtm_rodata.c => lkdtm/rodata.c}    |   0
 .../misc/{lkdtm_usercopy.c => lkdtm/usercopy.c}    |   0
 drivers/misc/mei/bus.c                             |  83 ++-
 drivers/misc/mei/client.c                          |  87 ++-
 drivers/misc/mei/debugfs.c                         |   7 +-
 drivers/misc/mei/init.c                            |   1 +
 drivers/misc/mei/main.c                            |  66 +-
 drivers/misc/mei/mei_dev.h                         |  10 +-
 drivers/misc/mic/bus/vop_bus.c                     |   6 +-
 drivers/misc/ocxl/pci.c                            |   2 +-
 drivers/nvmem/Kconfig                              |   4 +-
 drivers/nvmem/bcm-ocotp.c                          |  15 +-
 drivers/nvmem/core.c                               |  70 +-
 drivers/nvmem/imx-iim.c                            |  18 +-
 drivers/nvmem/imx-ocotp.c                          |  18 +-
 drivers/nvmem/lpc18xx_otp.c                        |  16 +-
 drivers/nvmem/meson-efuse.c                        |  16 +-
 drivers/nvmem/meson-mx-efuse.c                     |  16 +-
 drivers/nvmem/mtk-efuse.c                          |  16 +-
 drivers/nvmem/qfprom.c                             |  16 +-
 drivers/nvmem/rockchip-efuse.c                     |  32 +-
 drivers/nvmem/snvs_lpgpr.c                         |  53 +-
 drivers/nvmem/sunxi_sid.c                          |  71 +-
 drivers/nvmem/uniphier-efuse.c                     |  16 +-
 drivers/nvmem/vf610-ocotp.c                        |  24 +-
 drivers/parport/parport_ax88796.c                  |   8 +-
 drivers/parport/parport_pc.c                       |   4 +
 drivers/parport/parport_serial.c                   | 122 ++--
 drivers/pps/clients/pps_parport.c                  |  21 +-
 drivers/pps/generators/pps_gen_parport.c           |  12 +-
 drivers/siox/siox-core.c                           |   2 +-
 drivers/slimbus/core.c                             |   2 +-
 drivers/thunderbolt/dma_port.c                     |  28 +-
 drivers/thunderbolt/domain.c                       | 130 +++-
 drivers/thunderbolt/icm.c                          | 764 ++++++++++++++++++---
 drivers/thunderbolt/nhi.c                          |   5 +-
 drivers/thunderbolt/nhi.h                          |   5 +
 drivers/thunderbolt/switch.c                       |  61 +-
 drivers/thunderbolt/tb.h                           |  14 +
 drivers/thunderbolt/tb_msgs.h                      | 180 ++++-
 drivers/thunderbolt/xdomain.c                      |  47 +-
 drivers/uio/uio_hv_generic.c                       |  89 +++
 drivers/w1/w1.c                                    |   1 +
 fs/char_dev.c                                      |  10 +-
 include/linux/extcon.h                             |   6 +
 include/linux/extcon/extcon-gpio.h                 |  47 --
 include/linux/hyperv.h                             |   2 +-
 include/linux/nvmem-provider.h                     |  42 ++
 include/linux/pci_ids.h                            |   2 +
 include/linux/stm.h                                |  10 +-
 include/linux/thunderbolt.h                        |  19 +
 include/uapi/linux/stm.h                           |  13 +-
 lib/devres.c                                       |  78 +--
 tools/hv/hv_fcopy_daemon.c                         |   4 +-
 tools/hv/hv_kvp_daemon.c                           | 138 ++--
 tools/hv/hv_vss_daemon.c                           |   1 +
 141 files changed, 3377 insertions(+), 1207 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-fsi-master-gpio
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi.txt
 create mode 100644 drivers/hv/hv_trace_balloon.h
 create mode 100644 drivers/hwtracing/Kconfig
 create mode 100644 drivers/hwtracing/intel_th/acpi.c
 create mode 100644 drivers/misc/lkdtm/Makefile
 rename drivers/misc/{lkdtm_bugs.c => lkdtm/bugs.c} (100%)
 rename drivers/misc/{lkdtm_core.c => lkdtm/core.c} (100%)
 rename drivers/misc/{lkdtm_heap.c => lkdtm/heap.c} (100%)
 rename drivers/misc/{ => lkdtm}/lkdtm.h (100%)
 rename drivers/misc/{lkdtm_perms.c => lkdtm/perms.c} (100%)
 rename drivers/misc/{lkdtm_refcount.c => lkdtm/refcount.c} (99%)
 rename drivers/misc/{lkdtm_rodata.c => lkdtm/rodata.c} (100%)
 rename drivers/misc/{lkdtm_usercopy.c => lkdtm/usercopy.c} (100%)
 delete mode 100644 include/linux/extcon/extcon-gpio.h
