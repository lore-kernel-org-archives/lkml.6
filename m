Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeFES6Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeFES6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:58:23 -0400
Date: Tue, 5 Jun 2018 20:58:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 4.18-rc1
Message-ID: <20180605185800.GB24892@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-4.18-rc1

for you to fetch changes up to b23220fe054e92f616b82450fae8cd3ab176cc60:

  vmw_balloon: fixing double free when batching mode is off (2018-06-02 19:34:13 +0200)

----------------------------------------------------------------
Char/Misc driver patches for 4.18-rc1

Here is the "big" char and misc driver patches for 4.18-rc1.

It's not a lot of stuff here, but there are some highlights:
	- coreboot driver updates
	- soundwire driver updates
	- android binder updates
	- fpga big sync, mostly documentation
	- lots of minor driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Tull (15):
      fpga: fpga-region: comment on fpga_region_program_fpga locking
      fpga: region: don't use drvdata in common fpga code
      fpga: manager: change api, don't use drvdata
      fpga: bridge: change api, don't use drvdata
      fpga: region: change api, add fpga_region_create/free
      fpga: use SPDX
      fpga: mgr: kernel-doc fixes
      fpga: bridge: kernel-doc fixes
      fpga: region: kernel-doc fixes
      Documentation: fpga: move fpga overview to driver-api
      documentation: fpga: move fpga-mgr.txt to driver-api
      documentation: fpga: add bridge document to driver-api
      documentation: fpga: move fpga-region.txt to driver-api
      fpga: clarify that unregister functions also free
      MAINTAINERS: Add driver-api/fpga path

Alexander Kapshuk (2):
      ver_linux: Move stderr redirection from function parameter to function body
      ver_linux: Drop redundant calls to system() to test if file is readable

Andrew F. Davis (1):
      rpmsg: Correct support for MODULE_DEVICE_TABLE()

Andrew Lunn (1):
      drivers: nvmem: Export nvmem_add_cells()

Andrey Smirnov (2):
      dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
      nvmem: Add RAVE SP EEPROM driver

Arvind Yadav (1):
      coresight: use put_device() instead of kfree()

Bryant G. Ly (1):
      misc: IBM Virtual Management Channel Driver (VMC)

Dan Carpenter (1):
      ANDROID: binder: re-order some conditions

Dexuan Cui (2):
      Drivers: hv: vmbus: enable VMBus protocol version 5.0
      Drivers: hv: vmbus: Removed an unnecessary cast from void *

Fabio Estevam (1):
      uio: uio_fsl_elbc_gpcm: Remove owner assignment from platform_driver

Finn Thain (1):
      nubus: Call bus_register unconditionally

Geert Uytterhoeven (2):
      fpga: Remove depends on HAS_DMA in case of platform dependency
      ARM: amba: Fix wrong indentation in driver_override_store()

Gil Kupfer (1):
      vmw_balloon: fixing double free when batching mode is off

Greg Kroah-Hartman (2):
      Merge 4.17-rc3 into char-misc-next
      Merge tag 'soundwire-streaming' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next

Hamish Martin (2):
      uio: Reduce return paths from uio_write()
      uio: Prevent device destruction while fds are open

Ingo Flaschberger (1):
      1wire: family module autoload fails because of upper/lower case mismatch.

Jerome Brunet (3):
      nvmem: meson-efuse: remove econfig global
      nvmem: meson-efuse: simplify read callback
      nvmem: meson-efuse: add write support

Jia-Ju Bai (1):
      misc: ti-st: Replace GFP_ATOMIC with GFP_KERNEL in kim_probe

Laura Abbott (1):
      misc: tifm: Remove VLA

Leo Yan (1):
      coresight: Remove %px for printing pcsr value

Luc Van Oostenryck (1):
      sgi-xp: fix xpnet_dev_hard_start_xmit()'s return type

Martijn Coenen (1):
      ANDROID: binder: remove 32-bit binder interface.

Mathieu Malaterre (1):
      nvmem: properly handle returned value nvmem_reg_read

Mathieu Poirier (4):
      coresight: Moving framework and drivers to SPDX identifier
      coresight tmc etr: Make memory check consistent in the same function
      coresight tmc etr: Fix uninitialised variable
      coresight tmc etr: Removing extra newline

Minchan Kim (1):
      ANDROID: binder: change down_write to down_read

Paolo Pisati (2):
      dt: bindings: fpga: add lattice machxo2 slave spi binding description
      fpga: lattice machxo2: Add Lattice MachXO2 support

Peter Rosin (1):
      mux: adg792a: switch to using .probe_new

Samuel Holland (5):
      firmware: coreboot: Expose the coreboot table as a bus
      firmware: memconsole: Probe via coreboot bus
      firmware: vpd: Probe via coreboot bus
      firmware: coreboot: Remove unused coreboot_table_find
      firmware: coreboot: Add coreboot framebuffer driver

Sanyog Kale (7):
      Documentation: soundwire: Add more documentation
      soundwire: Add support for SoundWire stream management
      soundwire: Add support for port management
      soundwire: Add Master and Slave port programming
      soundwire: Add helpers for ports operations
      soundwire: Add bank switch routine
      soundwire: Add stream configuration APIs

Shreyas NC (2):
      ASoC: Add SoundWire stream programming interface
      soundwire: Remove cdns_master_ops

Souptick Joarder (5):
      misc: cxl: Change return type to vm_fault_t
      uio: Change return type to vm_fault_t
      char: mspec: change return type to vm_fault_t
      android: binder: Change return type to vm_fault_t
      misc: sgi-gru: Change return type to vm_fault_t

Srinivas Kandagatla (2):
      nvmem: core: describe add missing dev function parameter
      slimbus: qcom: remove unused variable

Stefan Potyra (1):
      w1: mxc_w1: Enable clock before calling clk_get_rate() on it

Stephen Hemminger (1):
      doc: fix sysfs ABI documentation

Vinod Koul (5):
      soundwire: Update email address for Vinod
      soundwire: cdns: Add port routines
      soundwire: cdns: Add stream routines
      soundwire: intel: Add stream initialization
      soundwire: intel: Add audio DAI ops

Wenwen Wang (1):
      virt: vbox: Only copy_from_user the request-header once

宋金时 (1):
      ANDROID: binder: correct the cmd print for BINDER_WORK_RETURN_ERROR

 Documentation/ABI/stable/sysfs-bus-vmbus           |   40 +-
 .../bindings/fpga/lattice-machxo2-spi.txt          |   29 +
 .../bindings/nvmem/zii,rave-sp-eeprom.txt          |   40 +
 Documentation/driver-api/fpga/fpga-bridge.rst      |   49 +
 Documentation/driver-api/fpga/fpga-mgr.rst         |  220 ++
 Documentation/driver-api/fpga/fpga-region.rst      |  102 +
 Documentation/driver-api/fpga/index.rst            |   13 +
 Documentation/driver-api/fpga/intro.rst            |   54 +
 Documentation/driver-api/index.rst                 |    1 +
 .../driver-api/soundwire/error_handling.rst        |   65 +
 Documentation/driver-api/soundwire/index.rst       |    3 +
 Documentation/driver-api/soundwire/locking.rst     |  106 +
 Documentation/driver-api/soundwire/stream.rst      |  372 +++
 Documentation/fpga/fpga-mgr.txt                    |  199 --
 Documentation/fpga/fpga-region.txt                 |   95 -
 Documentation/fpga/overview.txt                    |   23 -
 Documentation/ioctl/ioctl-number.txt               |    1 +
 Documentation/misc-devices/ibmvmc.rst              |  226 ++
 Documentation/trace/coresight-cpu-debug.txt        |    4 +-
 MAINTAINERS                                        |    9 +-
 arch/powerpc/include/asm/hvcall.h                  |    1 +
 drivers/amba/bus.c                                 |    4 +-
 drivers/android/Kconfig                            |   15 +-
 drivers/android/binder.c                           |   17 +-
 drivers/android/binder_alloc.c                     |    6 +-
 drivers/char/mspec.c                               |   11 +-
 drivers/firmware/google/Kconfig                    |    8 +
 drivers/firmware/google/Makefile                   |    1 +
 drivers/firmware/google/coreboot_table-acpi.c      |    2 +-
 drivers/firmware/google/coreboot_table-of.c        |    2 +-
 drivers/firmware/google/coreboot_table.c           |  130 +-
 drivers/firmware/google/coreboot_table.h           |   72 +-
 drivers/firmware/google/framebuffer-coreboot.c     |  115 +
 drivers/firmware/google/memconsole-coreboot.c      |   49 +-
 drivers/firmware/google/vpd.c                      |   43 +-
 drivers/fpga/Kconfig                               |    8 +-
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/altera-cvp.c                          |   19 +-
 drivers/fpga/altera-fpga2sdram.c                   |   34 +-
 drivers/fpga/altera-freeze-bridge.c                |   35 +-
 drivers/fpga/altera-hps2fpga.c                     |   37 +-
 drivers/fpga/altera-pr-ip-core-plat.c              |   13 +-
 drivers/fpga/altera-pr-ip-core.c                   |   31 +-
 drivers/fpga/altera-ps-spi.c                       |   20 +-
 drivers/fpga/fpga-bridge.c                         |   86 +-
 drivers/fpga/fpga-mgr.c                            |  129 +-
 drivers/fpga/fpga-region.c                         |   91 +-
 drivers/fpga/ice40-spi.c                           |   21 +-
 drivers/fpga/machxo2-spi.c                         |  415 ++++
 drivers/fpga/of-fpga-region.c                      |   28 +-
 drivers/fpga/socfpga-a10.c                         |   28 +-
 drivers/fpga/socfpga.c                             |   32 +-
 drivers/fpga/ts73xx-fpga.c                         |   20 +-
 drivers/fpga/xilinx-pr-decoupler.c                 |   22 +-
 drivers/fpga/xilinx-spi.c                          |   20 +-
 drivers/fpga/zynq-fpga.c                           |   14 +-
 drivers/hv/connection.c                            |   44 +-
 drivers/hv/hyperv_vmbus.h                          |    3 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   16 +-
 .../coresight/coresight-dynamic-replicator.c       |   10 +-
 drivers/hwtracing/coresight/coresight-etb10.c      |   13 +-
 drivers/hwtracing/coresight/coresight-etm-cp14.c   |   13 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   13 +-
 drivers/hwtracing/coresight/coresight-etm-perf.h   |   13 +-
 drivers/hwtracing/coresight/coresight-etm.h        |   13 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   13 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |   13 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   13 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   13 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   13 +-
 drivers/hwtracing/coresight/coresight-funnel.c     |   13 +-
 drivers/hwtracing/coresight/coresight-priv.h       |   13 +-
 drivers/hwtracing/coresight/coresight-replicator.c |   13 +-
 drivers/hwtracing/coresight/coresight-stm.c        |   13 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   13 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   20 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |   10 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |   13 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |   13 +-
 drivers/hwtracing/coresight/coresight.c            |   21 +-
 drivers/hwtracing/coresight/of_coresight.c         |   13 +-
 drivers/hwtracing/stm/ftrace.c                     |   10 +-
 drivers/misc/Kconfig                               |   14 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/cxl/context.c                         |    7 +-
 drivers/misc/ibmvmc.c                              | 2418 ++++++++++++++++++++
 drivers/misc/ibmvmc.h                              |  209 ++
 drivers/misc/sgi-gru/grumain.c                     |    2 +-
 drivers/misc/sgi-gru/grutables.h                   |    3 +-
 drivers/misc/sgi-xp/xpnet.c                        |    2 +-
 drivers/misc/ti-st/st_kim.c                        |    2 +-
 drivers/misc/tifm_7xx1.c                           |    6 +-
 drivers/misc/vmw_balloon.c                         |   23 +-
 drivers/mux/adg792a.c                              |    5 +-
 drivers/nubus/bus.c                                |   19 +-
 drivers/nubus/nubus.c                              |    2 +-
 drivers/nvmem/Kconfig                              |    6 +
 drivers/nvmem/Makefile                             |    3 +
 drivers/nvmem/core.c                               |   33 +-
 drivers/nvmem/meson-efuse.c                        |   41 +-
 drivers/nvmem/rave-sp-eeprom.c                     |  357 +++
 drivers/slimbus/qcom-ctrl.c                        |    3 +-
 drivers/soundwire/Kconfig                          |    2 +-
 drivers/soundwire/Makefile                         |    2 +-
 drivers/soundwire/bus.c                            |   43 +
 drivers/soundwire/bus.h                            |   72 +
 drivers/soundwire/cadence_master.c                 |  451 +++-
 drivers/soundwire/cadence_master.h                 |  151 ++
 drivers/soundwire/intel.c                          |  525 ++++-
 drivers/soundwire/intel.h                          |    4 +
 drivers/soundwire/intel_init.c                     |    3 +
 drivers/soundwire/stream.c                         | 1479 ++++++++++++
 drivers/uio/uio.c                                  |  123 +-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |    1 -
 drivers/virt/vboxguest/vboxguest_linux.c           |    4 +-
 drivers/w1/masters/mxc_w1.c                        |   20 +-
 drivers/w1/w1.c                                    |    2 +-
 include/linux/coresight.h                          |   13 +-
 include/linux/fpga/altera-pr-ip-core.h             |   13 +-
 include/linux/fpga/fpga-bridge.h                   |    9 +-
 include/linux/fpga/fpga-mgr.h                      |   23 +-
 include/linux/fpga/fpga-region.h                   |   13 +-
 include/linux/hyperv.h                             |   26 +-
 include/linux/nubus.h                              |    2 +-
 include/linux/nvmem-provider.h                     |   11 +
 include/linux/soundwire/sdw.h                      |  332 ++-
 include/linux/soundwire/sdw_intel.h                |   14 +
 include/linux/uio_driver.h                         |    4 +-
 include/sound/soc-dai.h                            |   23 +
 scripts/mod/devicetable-offsets.c                  |    3 +
 scripts/mod/file2alias.c                           |   11 +
 scripts/ver_linux                                  |   81 +-
 132 files changed, 8981 insertions(+), 1234 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
 create mode 100644 Documentation/driver-api/fpga/fpga-bridge.rst
 create mode 100644 Documentation/driver-api/fpga/fpga-mgr.rst
 create mode 100644 Documentation/driver-api/fpga/fpga-region.rst
 create mode 100644 Documentation/driver-api/fpga/index.rst
 create mode 100644 Documentation/driver-api/fpga/intro.rst
 create mode 100644 Documentation/driver-api/soundwire/error_handling.rst
 create mode 100644 Documentation/driver-api/soundwire/locking.rst
 create mode 100644 Documentation/driver-api/soundwire/stream.rst
 delete mode 100644 Documentation/fpga/fpga-mgr.txt
 delete mode 100644 Documentation/fpga/fpga-region.txt
 delete mode 100644 Documentation/fpga/overview.txt
 create mode 100644 Documentation/misc-devices/ibmvmc.rst
 create mode 100644 drivers/firmware/google/framebuffer-coreboot.c
 create mode 100644 drivers/fpga/machxo2-spi.c
 create mode 100644 drivers/misc/ibmvmc.c
 create mode 100644 drivers/misc/ibmvmc.h
 create mode 100644 drivers/nvmem/rave-sp-eeprom.c
 create mode 100644 drivers/soundwire/stream.c
