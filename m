Date: Thu, 1 Feb 2018 12:08:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 4.16-rc1
Message-ID: <20180201110845.GA29271@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-4.16-rc1

for you to fetch changes up to 9ff6576e124b1227c27c1da43fe5f8ee908263e0:

  char: lp: use true or false for boolean values (2018-01-25 10:56:02 +0100)

----------------------------------------------------------------
Char/Misc driver patches for 4.16-rc1

Here is the big pull request for char/misc drivers for 4.16-rc1.

There's a lot of stuff in here.  Three new driver subsystems were added
for various types of hardware busses:
	- siox
	- slimbus
	- soundwire
as well as a new vboxguest subsystem for the VirtualBox hypervisor
drivers.

There's also big updates from the FPGA subsystem, lots of Android binder
fixes, the usual handful of hyper-v updates, and lots of other smaller
driver updates.

All of these have been in linux-next for a long time, with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaron Sierra (1):
      misc: ds1682: Show device registers as unsigned

Alan Tull (18):
      fpga: bridge: support getting bridge from device
      fpga: mgr: API change to replace fpga load functions with single function
      fpga: mgr: separate getting/locking FPGA manager
      fpga: region: use dev_err instead of pr_err
      fpga: region: remove unneeded of_node_get and put
      fpga: region: get mgr early on
      fpga: region: check for child regions before allocing image info
      fpga: region: fix slow warning with more than one overlay
      fpga: region: use image info as parameter for programming region
      fpga: region: separate out code that parses the overlay
      fpga: region: add fpga-region.h header
      fpga: region: rename some functions prior to moving
      fpga: region: add register/unregister functions
      fpga: region: add fpga_region_class_find
      fpga: region: move device tree support to of-fpga-region.c
      fpga: of-fpga-region: accept overlays that don't program FPGA
      fpga: clean up fpga Kconfig
      fpga: add attribute groups

Alexey Khoroshilov (1):
      fpga: socfpga-a10: disable clk on error in socfpga_a10_fpga_probe()

Arnd Bergmann (5):
      lp: support 64-bit time_t user space
      virt: vbox: use %pap format for printing resource_size_t
      slimbus: qcom-ctrl: use normal allocation
      uio_hv_generic: fix type mismatch warnings
      uio_hv_generic: fix new type mismatch warnings

Arvind Yadav (4):
      extcon: adc-jack: Fix platform_get_irq's error checking
      misc: enclosure: Fix space before '[' error
      misc: enclosure: Remove unnecessary error check
      extcon: axp288:: Handle return value of platform_get_irq

Benson Leung (1):
      extcon: usbc-cros-ec: add support to notify USB type cables.

Chanwoo Choi (1):
      Merge branch 'ib-extcon-mfd-4.16' into extcon-next

Colin Ian King (8):
      misc: mic: remove unused label 'done'
      mei: fix spelling mistake: "botther" -> "bother"
      mei: fix incorrect logical operator in if statement
      soundwire: fix sign extension when shifting buf[2] 24 places
      soundwire: intel: fix missing assignment to ret
      slimbus: avoid null pointer dereference on msg
      slimbus: fix retries comparison to correctly identify failed allocation
      slimbus: make functions slim_ack_txn and slim_alloc_txbuf static

Corentin Labbe (1):
      misc: remove AVR32 dependencies

Dan Carpenter (2):
      mei: fix an && vs || typo
      soundwire: Fix a signedness bug

Dhaval Shah (10):
      misc: hpilo: Use SPDX-License-Identifier
      misc: isl29003: Missing a blank line after declarations
      misc: ad525x_dpot: Unnecessary space before function pointer arguments
      misc: ics932s401: Missing a blank line after declarations
      misc: ics932s401: please, no space before tabs
      misc: ics932s401: open brace should be on the previous line
      misc: apds990x: Missing a blank line after declarations.
      misc: ad525x_dpot: Prefer 'unsigned int' to bare use of 'unsigned'
      misc: ad525x_dpot: please, no space before tabs
      misc: ad525x_dpot: macros should not use a trailing semicolon

Elad Wexler (1):
      android: binder: Prefer __func__ to using hardcoded function name

Finley Xiao (2):
      nvmem: rockchip-efuse: parse 'rockchip,efuse-size'
      nvmem: rockchip-efuse: add support for rk3328-efuse

Ganesh Mahendran (1):
      android: binder: use VM_ALLOC to get vm area

Geert Uytterhoeven (2):
      MAINTAINERS: Remove bogus wildcards for CHAR and MISC DRIVERS
      eeprom: at25: Add DT support for EEPROMs with odd address bits

Greg Kroah-Hartman (3):
      Merge 4.15-rc3 into char-misc-next
      Merge 4.15-rc6 into char-misc-next
      Merge tag 'extcon-next-for-4.16' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next

Guilherme G. Piccoli (3):
      genwqe: Remove unused variable and rename function
      genwqe: Make defines uppercase
      genwqe: Remove unused parameter in some functions

Gustavo A. R. Silva (4):
      fpga: fpga-mgr: remove unnecessary code in __fpga_mgr_get
      fpga: fpga-bridge: remove unnecessary null check in of_fpga_bridge_get
      android: binder: Use true and false for boolean values
      char: lp: use true or false for boolean values

Hans de Goede (8):
      virt: Add vboxguest driver for Virtual Box Guest integration UAPI
      virt: Add vboxguest VMMDEV communication code
      virt: Add vboxguest driver for Virtual Box Guest integration
      extcon: axp288: Remove unused extcon_nb struct member
      extcon: axp288: Remove unused platform data
      extcon: axp288: Redo charger type detection a couple of seconds after probe()
      extcon: axp288: Handle reserved charger-type values better
      virt: vbox: Add error mapping for VERR_INVALID_NAME and VERR_NO_MORE_FILES

Harsh Shandilya (1):
      android: binder: Use octal permissions

Heiner Kallweit (2):
      nvmem: core: let stride and word_size default to 1
      nvmem: core: switch to device_property_present for reading property "read-only"

Ian Abbott (1):
      fpga: region: release of_parse_phandle nodes after use

Ivan Delalande (1):
      lkdtm: fix handle_irq_event symbol for INT_HW_IRQ_EN

Jesse Chan (1):
      auxdisplay: img-ascii-lcd: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jia-Ju Bai (1):
      vme: Fix a possible sleep-in-atomic bug in vme_tsi148

Kees Cook (1):
      /dev/mem: Add bounce buffer for copy-out

Kunihiko Hayashi (1):
      nvmem: uniphier: change access unit from 32bit to 8bit

Ladislav Michl (2):
      EISA: Whitespace cleanup
      EISA: Delete error message for a failed memory allocation in eisa_probe()

Lukas Wunner (2):
      coresight: Deduplicate bus_find_device() by name matching
      nvmem: core: Deduplicate bus_find_device() by name matching

Markus Elfring (2):
      extcon: max77693: Delete unneeded initialization in max77693_muic_set_path()
      extcon: max8997: Delete unneeded initialization in max8997_muic_set_path()

Martijn Coenen (4):
      ANDROID: binder: show high watermark of alloc->pages.
      ANDROID: binder: Add thread->process_todo flag.
      ANDROID: binder: remove waitqueue when thread exits.
      ANDROID: binder: Remove obsolete proc waitqueue.

Michael Kelley (1):
      Drivers: hv: vmbus: Remove x86-isms from arch independent drivers

Peter Rosin (1):
      mux: add SPDX identifiers to all mux source files

Pravin Shedge (1):
      coresight: etb10: remove duplicate includes

Rob Herring (1):
      char: xillybus: remove direct dependency on DT functions

Robert Walker (1):
      coresight: Fix disabling of CoreSight TPIU

Sagar Dharia (9):
      Documentation: Add SLIMbus summary
      dt-bindings: Add SLIMbus bindings
      slimbus: Add SLIMbus bus type
      slimbus: core: Add slim controllers support
      slimbus: Add messaging APIs to slimbus framework
      slimbus: Add support for 'clock-pause' feature
      dt-bindings: Add qcom slimbus controller bindings
      slimbus: qcom: Add Qualcomm Slimbus controller driver
      slimbus: qcom: Add runtime-pm support using clock-pause

Sanyog Kale (4):
      Documentation: Add SoundWire summary
      soundwire: Add SoundWire MIPI defined registers
      soundwire: Add Slave status handling helpers
      soundwire: cdns: Add sdw_master_ops and IO transfer support

Shreyas NC (1):
      soundwire: Fix incorrect return value check

Sinan Kaya (1):
      i7300_idle: remove unused file

Srinivas Kandagatla (6):
      slimbus: core: add support to device tree helper
      regmap: add SLIMbus support
      slimbus: core: add common defines required for controllers
      MAINTAINERS: Add SLIMbus maintainer
      slimbus: qcom: fix incompatible pointer warning
      slimbus: qcom: add HAS_IOMEM dependency

Stephen Hemminger (11):
      vmbus: make channel attributes static
      uio_hv_generic: fix configuration comments
      uio_hv_generic: use standard mmap for resources
      uio_hv_generic: use ISR callback method
      vmbus: fix ABI documentation
      vmbus: add monitor_id and subchannel_id to sysfs per channel
      doc: fix documentation about uio_hv_generic
      uio: document uio_hv_generic regions
      uio_hv_generic: create send and receive buffers
      uio_hv_generic: check that host supports monitor page
      uio_hv_generic: add rescind support

Tejas Upadhyay (1):
      misc: fsa9480: Add blank line after declarations.

Tetsuo Handa (1):
      android: binder: Check for errors in binder_alloc_shrinker_init().

Thomas VanSelus (1):
      misc: ds1682: Ignore update-in-progress ETC reads

Tomas Winkler (2):
      mei: speed up the power down flow
      mei: me: allow runtime pm for platform with D0i3

Uwe Kleine-König (4):
      siox: new driver framework for eckelmann SIOX
      siox: add support for tracing
      siox: add gpio bus driver
      MAINTAINERS: Add entry for SIOX

Vasyl Gomonovych (4):
      lkdtm: Missing kmalloc check
      misc: vexpress: Use PTR_ERR_OR_ZERO()
      misc: mic: Use memdup_user() as a cleanup
      coresight: Use PTR_ERR_OR_ZERO()

Vincent Legoll (1):
      fsi: Make FSI a menuconfig to ease disabling it all

Vinod Koul (11):
      soundwire: Add SoundWire bus type
      soundwire: Add Master registration
      soundwire: Add MIPI DisCo property helpers
      soundwire: Add IO transfer
      soundwire: Add slave status handling
      soundwire: cdns: Add cadence library
      soundwire: intel: Add Intel Master driver
      soundwire: intel: Add Intel init module
      MAINTAINERS: Add SoundWire entry
      soundwire: Add Pierre as reviewer
      soundwire: select REGMAP_SOUNDWIRE

Vitaly Kuznetsov (1):
      tools/hv: add install target to Makefile

Wei Yongjun (4):
      soundwire: Fix typo in return value check of sdw_read()
      slimbus: Use GFP_ATOMIC under spin lock
      slimbus: Fix missing unlock on error in slim_msg_response()
      slimbus: qcom: Fix return value check in qcom_slim_probe()

Xiongwei Song (1):
      ANDROID: binder: make binder_alloc_new_buf_locked static and indent its arguments

 Documentation/ABI/stable/sysfs-bus-vmbus           |   53 +-
 Documentation/ABI/testing/sysfs-bus-siox           |   87 ++
 Documentation/devicetree/bindings/eeprom/at25.txt  |    4 +-
 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |    5 +
 .../bindings/siox/eckelmann,siox-gpio.txt          |   19 +
 Documentation/devicetree/bindings/slimbus/bus.txt  |   50 +
 .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |   39 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 Documentation/driver-api/index.rst                 |    2 +
 Documentation/driver-api/slimbus.rst               |  127 ++
 Documentation/driver-api/soundwire/index.rst       |   15 +
 Documentation/driver-api/soundwire/summary.rst     |  207 +++
 Documentation/driver-api/uio-howto.rst             |   26 +-
 Documentation/fpga/fpga-mgr.txt                    |  132 +-
 Documentation/fpga/fpga-region.txt                 |   95 ++
 Documentation/fpga/overview.txt                    |   23 +
 MAINTAINERS                                        |   38 +-
 arch/x86/hyperv/hv_init.c                          |   21 +-
 arch/x86/include/asm/mshyperv.h                    |    4 +-
 drivers/Kconfig                                    |    6 +
 drivers/Makefile                                   |    3 +
 drivers/android/binder.c                           |  196 ++-
 drivers/android/binder_alloc.c                     |   29 +-
 drivers/android/binder_alloc.h                     |    4 +-
 drivers/auxdisplay/img-ascii-lcd.c                 |    4 +
 drivers/base/regmap/Kconfig                        |    4 +
 drivers/base/regmap/Makefile                       |    1 +
 drivers/base/regmap/regmap-slimbus.c               |   80 +
 drivers/char/lp.c                                  |   69 +-
 drivers/char/mem.c                                 |   27 +-
 drivers/char/xillybus/Kconfig                      |    4 +-
 drivers/char/xillybus/xillybus_of.c                |   12 +-
 drivers/eisa/eisa-bus.c                            |   62 +-
 drivers/eisa/pci_eisa.c                            |   10 +-
 drivers/eisa/virtual_root.c                        |   19 +-
 drivers/extcon/extcon-adc-jack.c                   |    2 +-
 drivers/extcon/extcon-axp288.c                     |   75 +-
 drivers/extcon/extcon-max77693.c                   |    2 +-
 drivers/extcon/extcon-max8997.c                    |    2 +-
 drivers/extcon/extcon-usbc-cros-ec.c               |  142 +-
 drivers/fpga/Kconfig                               |  103 +-
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/fpga-bridge.c                         |  113 +-
 drivers/fpga/fpga-mgr.c                            |  123 +-
 drivers/fpga/fpga-region.c                         |  464 +-----
 drivers/fpga/of-fpga-region.c                      |  504 +++++++
 drivers/fpga/socfpga-a10.c                         |    8 +-
 drivers/fsi/Kconfig                                |    6 +-
 drivers/hv/hv.c                                    |    3 -
 drivers/hv/vmbus_drv.c                             |   40 +-
 .../coresight/coresight-dynamic-replicator.c       |    4 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |    1 -
 drivers/hwtracing/coresight/coresight-funnel.c     |    4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |   17 +-
 drivers/hwtracing/coresight/coresight.c            |   25 +-
 drivers/misc/Kconfig                               |    4 +-
 drivers/misc/ad525x_dpot.c                         |   30 +-
 drivers/misc/ad525x_dpot.h                         |   12 +-
 drivers/misc/apds990x.c                            |   11 +
 drivers/misc/ds1682.c                              |   35 +-
 drivers/misc/eeprom/at25.c                         |    3 +
 drivers/misc/enclosure.c                           |   12 +-
 drivers/misc/fsa9480.c                             |    1 +
 drivers/misc/genwqe/card_base.c                    |   16 +-
 drivers/misc/genwqe/card_base.h                    |   20 +-
 drivers/misc/genwqe/card_ddcb.c                    |   22 +-
 drivers/misc/genwqe/card_debugfs.c                 |    2 +-
 drivers/misc/genwqe/card_dev.c                     |   19 +-
 drivers/misc/genwqe/card_utils.c                   |   25 +-
 drivers/misc/hpilo.c                               |    5 +-
 drivers/misc/hpilo.h                               |    5 +-
 drivers/misc/ics932s401.c                          |    8 +-
 drivers/misc/isl29003.c                            |    7 +
 drivers/misc/lkdtm_core.c                          |    2 +-
 drivers/misc/lkdtm_heap.c                          |    4 +
 drivers/misc/mei/bus.c                             |   10 +-
 drivers/misc/mei/hw-me.c                           |    4 +-
 drivers/misc/mei/hw-txe.c                          |    4 +-
 drivers/misc/mei/init.c                            |    4 +-
 drivers/misc/mei/pci-me.c                          |    5 +-
 drivers/misc/mic/vop/vop_vringh.c                  |   22 +-
 drivers/misc/vexpress-syscfg.c                     |    4 +-
 drivers/mux/Kconfig                                |    1 +
 drivers/mux/Makefile                               |    1 +
 drivers/mux/adg792a.c                              |    5 +-
 drivers/mux/core.c                                 |    5 +-
 drivers/mux/gpio.c                                 |    5 +-
 drivers/mux/mmio.c                                 |    5 +-
 drivers/nvmem/core.c                               |   17 +-
 drivers/nvmem/rockchip-efuse.c                     |   70 +-
 drivers/nvmem/uniphier-efuse.c                     |   10 +-
 drivers/siox/Kconfig                               |   18 +
 drivers/siox/Makefile                              |    2 +
 drivers/siox/siox-bus-gpio.c                       |  172 +++
 drivers/siox/siox-core.c                           |  934 ++++++++++++
 drivers/siox/siox.h                                |   49 +
 drivers/slimbus/Kconfig                            |   24 +
 drivers/slimbus/Makefile                           |   10 +
 drivers/slimbus/core.c                             |  480 ++++++
 drivers/slimbus/messaging.c                        |  332 +++++
 drivers/slimbus/qcom-ctrl.c                        |  747 ++++++++++
 drivers/slimbus/sched.c                            |  121 ++
 drivers/slimbus/slimbus.h                          |  261 ++++
 drivers/soundwire/Kconfig                          |   37 +
 drivers/soundwire/Makefile                         |   18 +
 drivers/soundwire/bus.c                            |  997 +++++++++++++
 drivers/soundwire/bus.h                            |   71 +
 drivers/soundwire/bus_type.c                       |  193 +++
 drivers/soundwire/cadence_master.c                 |  751 ++++++++++
 drivers/soundwire/cadence_master.h                 |   48 +
 drivers/soundwire/intel.c                          |  345 +++++
 drivers/soundwire/intel.h                          |   23 +
 drivers/soundwire/intel_init.c                     |  198 +++
 drivers/soundwire/mipi_disco.c                     |  401 +++++
 drivers/soundwire/slave.c                          |  114 ++
 drivers/uio/uio_hv_generic.c                       |  138 +-
 drivers/virt/Kconfig                               |    1 +
 drivers/virt/Makefile                              |    1 +
 drivers/virt/vboxguest/Kconfig                     |   18 +
 drivers/virt/vboxguest/Makefile                    |    3 +
 drivers/virt/vboxguest/vboxguest_core.c            | 1571 ++++++++++++++++++++
 drivers/virt/vboxguest/vboxguest_core.h            |  174 +++
 drivers/virt/vboxguest/vboxguest_linux.c           |  466 ++++++
 drivers/virt/vboxguest/vboxguest_utils.c           |  803 ++++++++++
 drivers/virt/vboxguest/vboxguest_version.h         |   19 +
 drivers/virt/vboxguest/vmmdev.h                    |  449 ++++++
 drivers/vme/vme.c                                  |    2 +-
 include/linux/fpga/fpga-bridge.h                   |   14 +-
 include/linux/fpga/fpga-mgr.h                      |   39 +-
 include/linux/fpga/fpga-region.h                   |   40 +
 include/linux/i7300_idle.h                         |   84 --
 include/linux/mfd/axp20x.h                         |    5 -
 include/linux/mfd/cros_ec_commands.h               |   17 +
 include/linux/mod_devicetable.h                    |   19 +
 include/linux/mux/consumer.h                       |    5 +-
 include/linux/mux/driver.h                         |    5 +-
 include/linux/regmap.h                             |   18 +
 include/linux/siox.h                               |   77 +
 include/linux/slimbus.h                            |  164 ++
 include/linux/soundwire/sdw.h                      |  479 ++++++
 include/linux/soundwire/sdw_intel.h                |   24 +
 include/linux/soundwire/sdw_registers.h            |  194 +++
 include/linux/soundwire/sdw_type.h                 |   19 +
 include/linux/vbox_utils.h                         |   79 +
 include/trace/events/siox.h                        |   66 +
 include/uapi/linux/lp.h                            |   12 +-
 include/uapi/linux/vbox_err.h                      |  151 ++
 include/uapi/linux/vbox_vmmdev_types.h             |  226 +++
 include/uapi/linux/vboxguest.h                     |  330 ++++
 scripts/mod/devicetable-offsets.c                  |    4 +
 scripts/mod/file2alias.c                           |   15 +
 security/Kconfig                                   |    1 +
 tools/hv/Makefile                                  |   23 +-
 153 files changed, 14447 insertions(+), 1186 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-siox
 create mode 100644 Documentation/devicetree/bindings/siox/eckelmann,siox-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
 create mode 100644 Documentation/driver-api/slimbus.rst
 create mode 100644 Documentation/driver-api/soundwire/index.rst
 create mode 100644 Documentation/driver-api/soundwire/summary.rst
 create mode 100644 Documentation/fpga/fpga-region.txt
 create mode 100644 Documentation/fpga/overview.txt
 create mode 100644 drivers/base/regmap/regmap-slimbus.c
 create mode 100644 drivers/fpga/of-fpga-region.c
 create mode 100644 drivers/siox/Kconfig
 create mode 100644 drivers/siox/Makefile
 create mode 100644 drivers/siox/siox-bus-gpio.c
 create mode 100644 drivers/siox/siox-core.c
 create mode 100644 drivers/siox/siox.h
 create mode 100644 drivers/slimbus/Kconfig
 create mode 100644 drivers/slimbus/Makefile
 create mode 100644 drivers/slimbus/core.c
 create mode 100644 drivers/slimbus/messaging.c
 create mode 100644 drivers/slimbus/qcom-ctrl.c
 create mode 100644 drivers/slimbus/sched.c
 create mode 100644 drivers/slimbus/slimbus.h
 create mode 100644 drivers/soundwire/Kconfig
 create mode 100644 drivers/soundwire/Makefile
 create mode 100644 drivers/soundwire/bus.c
 create mode 100644 drivers/soundwire/bus.h
 create mode 100644 drivers/soundwire/bus_type.c
 create mode 100644 drivers/soundwire/cadence_master.c
 create mode 100644 drivers/soundwire/cadence_master.h
 create mode 100644 drivers/soundwire/intel.c
 create mode 100644 drivers/soundwire/intel.h
 create mode 100644 drivers/soundwire/intel_init.c
 create mode 100644 drivers/soundwire/mipi_disco.c
 create mode 100644 drivers/soundwire/slave.c
 create mode 100644 drivers/virt/vboxguest/Kconfig
 create mode 100644 drivers/virt/vboxguest/Makefile
 create mode 100644 drivers/virt/vboxguest/vboxguest_core.c
 create mode 100644 drivers/virt/vboxguest/vboxguest_core.h
 create mode 100644 drivers/virt/vboxguest/vboxguest_linux.c
 create mode 100644 drivers/virt/vboxguest/vboxguest_utils.c
 create mode 100644 drivers/virt/vboxguest/vboxguest_version.h
 create mode 100644 drivers/virt/vboxguest/vmmdev.h
 create mode 100644 include/linux/fpga/fpga-region.h
 delete mode 100644 include/linux/i7300_idle.h
 create mode 100644 include/linux/siox.h
 create mode 100644 include/linux/slimbus.h
 create mode 100644 include/linux/soundwire/sdw.h
 create mode 100644 include/linux/soundwire/sdw_intel.h
 create mode 100644 include/linux/soundwire/sdw_registers.h
 create mode 100644 include/linux/soundwire/sdw_type.h
 create mode 100644 include/linux/vbox_utils.h
 create mode 100644 include/trace/events/siox.h
 create mode 100644 include/uapi/linux/vbox_err.h
 create mode 100644 include/uapi/linux/vbox_vmmdev_types.h
 create mode 100644 include/uapi/linux/vboxguest.h
