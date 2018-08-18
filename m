Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F883C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0699F2178F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0699F2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeHRTG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:06:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeHRTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:06:58 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB993BD4;
        Sat, 18 Aug 2018 15:58:46 +0000 (UTC)
Date:   Sat, 18 Aug 2018 17:58:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 4.19-rc1
Message-ID: <20180818155844.GA22720@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.19-rc1

for you to fetch changes up to 128f38041035001276e964cda1cf951f218d965d:

  android: binder: Rate-limit debug and userspace triggered err msgs (2018-08-08 11:05:47 +0200)

----------------------------------------------------------------
Char/Misc driver patches for 4.19-rc1

Here is the bit set of char/misc drivers for 4.19-rc1

There is a lot here, much more than normal, seems like everyone is
writing new driver subsystems these days...  Anyway, major things here
are:
	- new FSI driver subsystem, yet-another-powerpc low-level
	  hardware bus
	- gnss, finally an in-kernel GPS subsystem to try to tame all of
	  the crazy out-of-tree drivers that have been floating around
	  for years, combined with some really hacky userspace
	  implementations.  This is only for GNSS receivers, but you
	  have to start somewhere, and this is great to see.
Other than that, there are new slimbus drivers, new coresight drivers,
new fpga drivers, and loads of DT bindings for all of these and existing
drivers.

Full details of everything is in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Tull (1):
      Documentation: fpga: cleanup

Alexander Kapshuk (2):
      ver_linux: Process input coming from procmaps that matches libc only
      ver_linux: Do not check for ver_linux pattern in version function

Alexander Usyskin (5):
      mei: remove unused MEI_IAMTHIF_STALL_TIMER define
      mei: add optional timeout to internal bus recv
      mei: expose fw version to sysfs
      mei: don't update offset in write
      mei: define dma ring buffer sizes for PCH12 HW and newer

Andrew Jeffery (2):
      fsi: gpio: Trace busy count
      fsi: gpio: Remove unused 'id' variable

Anson Huang (2):
      dt-bindings: nvmem: imx-ocotp: add compatible string for imx6sll
      nvmem: imx-ocotp: add support for imx6sll

Anton Vasilyev (2):
      firmware: vpd: Fix section enabled flag on vpd_section_destroy
      misc: ti-st: Fix memory leak in the error path of probe()

Arjan van de Ven (1):
      use the new async probing feature for the hyperv drivers

Arnd Bergmann (4):
      misc: mic: fix passing the current time
      headers: fix linux/mod_devicetable.h inclusions
      extcon: max3355: include mod_devicetable.h
      coresight: include vmalloc.h for vmap/vunmap

Baolin Wang (1):
      dt-bindings: nvmem: Add Spreadtrum SC27XX efuse controller documentation

Benjamin Herrenschmidt (46):
      fsi/fsi-master-gpio: Sample input data on different clock phase
      fsi/fsi-master-gpio: Add "no-gpio-delays" option
      fsi/fsi-master-gpio: Reduce turnaround clocks
      fsi/fsi-master-gpio: Reduce dpoll clocks
      fsi/fsi-master-gpio: Delay sampling of FSI data input
      fsi/fsi-master-gpio: Implement CRC error recovery
      fsi/fsi-master-gpio: More error handling cleanup
      fsi/sbefifo: Add driver for the SBE FIFO
      fsi: sbefifo: Remove unneeded semicolon
      fsi: scom: Add mutex around FSI2PIB accesses
      fsi: scom: Whitespace fixes
      fsi: scom: Fixup endian annotations
      fsi: scom: Add register definitions
      fsi: scom: Major overhaul
      gpio: aspeed: Rework register type accessors
      gpio: aspeed: Add "Read Data" register to read the write latch
      gpio: aspeed: Add command source registers
      gpio: aspeed: Add interfaces for co-processor to grab GPIOs
      fsi: sbefifo: Fix checker warning about late NULL check
      fsi: Move code around to avoid forward declaration
      fsi: Add mechanism to set the tSendDelay and tEchoDelay values
      fsi: master-gpio: Rename and adjust send delay
      fsi: master-gpio: Add support for link_config
      fsi: master-gpio: Add more tracepoints
      fsi: master-gpio: Remove unused definitions
      fsi: master-gpio: Remove "GPIO" prefix on some definitions
      fsi: Don't use device_unregister() in fsi_master_register()
      fsi: master-gpio: Add missing release function
      fsi: Move various master definitions to a common header
      Merge remote-tracking branch 'gpio/ib-aspeed' into upstream-ready
      devres: Add devm_of_iomap()
      dt-bindings: fsi: Document binding for the fsi-master-ast-cf "device"
      fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire
      fsi: sbefifo: Fix inconsistent use of ffdc mutex
      dt-bindings: fsi: Add optional chip-id to CFAMs
      fsi: Add support for device-tree provided chip IDs
      fsi: master-ast-cf: Fix build warnings on 64-bit platforms
      fsi: master-ast-cf: Mask unused bits in RTAG/RCRC
      fsi: master-ast-cf: Rename dump_trace() to avoid name collision
      fsi: Add new central chardev support
      fsi: sbefifo: Convert to use the new chardev
      fsi: scom: Convert to use the new chardev
      fsi: Add cfam char devices
      fsi: Prevent multiple concurrent rescans
      fsi: scom: Fix NULL dereference
      fsi: sbefifo: Bump max command length

Chanwoo Choi (1):
      extcon: Release locking when sending the notification of connector state

Colin Ian King (13):
      misc: genwqe: remove several redundant variables
      sgi-xp: remove redundant pointers ch and rp
      misc: ti-st: remove redundant variable 'type'
      misc: vmci: remove redundant variable is_local
      misc: rtsx: make several functions static
      w1: ds2482: make module parameter extra_config static
      goldfish_pipe: make tasklet goldfish_interrupt_tasklet static
      hpet: remove redundant pointer hpet
      char: pcmcia: remove redundant pointer dev
      eeprom: idt_89hpesx: remove redundant variable csrval_len
      vme: ca91cx42: remove redundant variable i
      gnss: ubx: make struct ubx_gserial_ops static
      thunderbolt: Remove redundant variable 'approved'

Dan Carpenter (7):
      vmci: type promotion bug in qp_host_get_user_memory()
      mei: bus: type promotion bug in mei_nfc_if_version()
      gnss: fix potential error pointer dereference
      uio: pruss: fix error handling in probe
      eeprom: idt_89hpesx: clean up an error pointer vs NULL inconsistency
      uio: potential double frees if __uio_register_device() fails
      misc: mic: SCIF Fix scif_get_new_port() error handling

Dexuan Cui (2):
      Drivers: hv: vmbus: Fix the offer_in_progress in vmbus_process_offer()
      Drivers: hv: vmbus: Reset the channel callback in vmbus_onoffer_rescind()

Eddie James (2):
      fsi: scom: Remove PIB reset during probe
      fsi: sbefifo: Add missing mutex_unlock

Enric Balletbo i Serra (2):
      extcon: usbc-cros-ec: Make license text and module license match.
      extcon: usbc-cros-ec: Switch to SPDX identifier.

Freeman Liu (1):
      nvmem: Add Spreadtrum SC27XX efuse support

Geert Uytterhoeven (3):
      MAINTAINERS: Add file patterns for w1 device tree bindings
      android: binder: Drop dependency on !M68K
      misc: ti-st: Allow compile test of GPIO consumers if !GPIOLIB

Greg Kroah-Hartman (8):
      Merge tag 'fsi-updates-2018-06-12' of https://git.kernel.org/.../benh/linux-fsi into char-misc-next
      Merge tag 'fsi-updates-2018-07-12' of git://git.kernel.org/.../benh/linux-fsi into char-misc-next
      eventpoll.h: wrap casts in () properly
      Merge 4.18-rc5 into char-misc-next
      Merge tag 'extcon-next-for-4.19' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next
      Merge tag 'fsi-updates-2018-07-24' of git://git.kernel.org/.../benh/linux-fsi into char-misc-testing
      Merge tag 'fsi-updates-2018-07-27' of git://git.kernel.org/.../benh/linux-fsi into char-misc-next
      Merge tag 'fsi-updates-2018-08-08' of git://git.kernel.org/.../benh/linux-fsi into char-misc-next

Guenter Roeck (3):
      fsi/sbefifo: Add dependency on OF_ADDRESS
      android: binder_alloc: Include asm/cacheflush.h after linux/ include files
      android: binder: Include asm/cacheflush.h after linux/ include files

Gustavo A. R. Silva (7):
      /dev/mem: Mark expected switch fall-through
      eeprom: at25: mark expected switch fall-throughs
      sgi-xp: xpc_partition: mark expected switch fall-throughs
      misc: mic: mark expected switch fall-through
      parport: ieee1284: mark expected switch fall-throughs
      fsi: master-ast-cf: Fix memory leak
      genwqe: card_base: Use true and false for boolean values

Hailong Liu (1):
      uio: fix wrong return value from uio_mmap()

Henriette Hofmeier (3):
      ds2490.c: Add required spaces
      ds2490.c: Remove unnecessary whitespace
      ds2490.c: Move struct open braces to previous line

Jeremy Kerr (4):
      fsi: gpio: Use a mutex to protect transfers
      fsi/gpio: Include command build in locked section
      fsi/gpio: Use relative-addressing commands
      fsi/master-gpio: Replace bit_bit lock with IRQ disable/enable

Joel Stanley (3):
      fsi: sbefifo: Fix sparse warnings
      fsi: master-hub: Fix sparse warnings
      fsi: core: Fix sparse warnings

Johan Hovold (11):
      gnss: add GNSS receiver subsystem
      dt-bindings: add generic gnss binding
      gnss: add generic serial driver
      dt-bindings: gnss: add u-blox binding
      gnss: add driver for u-blox receivers
      dt-bindings: gnss: add sirfstar binding
      gnss: add driver for sirfstar-based receivers
      gnss: add receiver type support
      misc: sram: fix resource leaks in probe error path
      misc: sram: enable clock before registering regions
      dt-bindings: vendor-prefixes: fix bad merge

Julia Lawall (1):
      parport: sunbpp: fix error return code

Kang Luwei (3):
      fpga: dfl: add FPGA Management Engine driver basic framework
      fpga: dfl: fme: add header sub feature support
      fpga: dfl: fme: add partial reconfiguration sub feature support

Kees Cook (1):
      nvmem: rave-sp-eeprom: Remove VLA usage

Mariusz Bialonczyk (1):
      w1: fix w1_ds2438 documentation

Mathieu Poirier (3):
      coresight: etm3x: Don't use contextID with PID namespaces
      coresight: etm4x: Don't use contextID with PID namespaces
      coresight: Remove function coresight_vpid_to_pid()

Matt Ranostay (1):
      tsl2550: fix lux1_input error in low light

Michael Kelley (6):
      x86/hyperv: Add interrupt handler annotations
      Drivers: hv: vmbus: Add comments on ring buffer signaling
      Drivers: hv: vmbus: Remove x86 MSR refs in arch independent code
      Drivers: hv: vmbus: Make TLFS #define names architecture neutral
      Drivers: hv: vmbus: Remove use of slow_virt_to_phys()
      Drivers: hv: vmbus: Cleanup synic memory free path

Mika Westerberg (5):
      thunderbolt: Use 64-bit DMA mask if supported by the platform
      thunderbolt: Do not unnecessarily call ICM get route
      thunderbolt: No need to take tb->lock in domain suspend/complete
      thunderbolt: Use correct ICM commands in system suspend
      thunderbolt: Add support for runtime PM

Mircea Caprioru (2):
      dt-bindings: mux: add adi,adgs1408
      mux: adgs1408: new driver for Analog Devices ADGS1408/1409 mux

Nadav Amit (7):
      vmw_balloon: fix inflation of 64-bit GFNs
      vmw_balloon: do not use 2MB without batching
      vmw_balloon: VMCI_DOORBELL_SET does not check status
      vmw_balloon: fix VMCI use when balloon built into kernel
      vmw_balloon: remove inflation rate limiting
      vmw_balloon: update copyright message
      vmw_balloon: update maintainers list

Nathan Ciobanu (1):
      thunderbolt: Fix small typo in variable name

Olaf Hering (1):
      tools: hv: update lsvmbus to be compatible with python3

Parth Y Shah (2):
      misc: eeprom: assignment outside the if statement
      misc: cxl: changed asterisk position

Randy Dunlap (2):
      headers: separate linux/mod_devicetable.h from linux/platform_device.h
      headers: fix build error in arch/arm/plat-samsung/adc.c, add <linux/mod_devicetable.h>

Robert Lippert (1):
      drivers/misc: Aspeed LPC snoop output using misc chardev

Robin Murphy (1):
      coresight: tpiu: Fix disabling timeouts

Roman Kiryanov (3):
      goldfish: Add missing includes to goldfish.h
      goldfish: Use dedicated macros instead of manual bit shifting
      platform: goldfish: Retire pdev_bus

Sherry Yang (2):
      android: binder: Show extra_buffers_size in trace
      android: binder: Rate-limit debug and userspace triggered err msgs

Srinivas Kandagatla (13):
      slimbus: messaging: pass correct wbuf
      slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
      slimbus: messaging: initialize completion correctly
      slimbus: qcom: remove redundant depends in Kconfig
      slimbus: core: add of_slim_device_get() helper
      slimbus: core: rearrange slim_eaddr structure
      slimbus: messaging: add slim_alloc/free_txn_tid()
      slimbus: ngd: dt-bindings: Add slim ngd dt bindings
      slimbus: ngd: Add qcom SLIMBus NGD driver
      slimbus: stream: add stream support
      slimbus: ngd: add stream support
      nvmem: core: remove unused nvmem_device ncells member
      slimbus: stream: Fix htmldocs warnings

Stephen Hemminger (3):
      uio: add SPDX license tag
      uio: add SPDX license tags
      Drivers: hv: vmbus: add numa_node to sysfs

Sudeep Holla (1):
      misc: vexpress/syscfg: Use devm_ioremap_resource() to map memory

Sunil Muthuswamy (4):
      Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic
      Drivers: hv: vmus: Fix the check for return value from kmsg get dump buffer
      Drivers: hv: vmbus: Fix the issue with freeing up hv_ctl_table_hdr
      Drivers: hv: vmbus: Get rid of MSR access from vmbus_drv.c

Suzuki K Poulose (20):
      coresight: ETM: Add support for Arm Cortex-A73 and Cortex-A35
      coresight: tmc: Hide trace buffer handling for file read
      coresight: tmc-etr: Do not clean trace buffer
      coresight: tmc-etr: Disallow perf mode
      coresight: Add helper for inserting synchronization packets
      dts: bindings: Restrict coresight tmc-etr scatter-gather mode
      coresight: Add generic TMC sg table framework
      coresight: Add support for TMC ETR SG unit
      coresight: tmc-etr: Add transparent buffer management
      coresight: tmc-etr buf: Add TMC scatter gather mode backend
      coresight: tmc: Add configuration support for trace buffer size
      coresight: Fix check in coresight_tmc_etr_buf_insert_barrier_packet
      coresight: Cleanup platform description data
      coresight: Handle errors in finding input/output ports
      coresight: Cleanup device subtype struct
      coresight: Add helper device type
      coresight: Introduce support for Coresight Address Translation Unit
      dts: bindings: Document device tree binding for CATU
      coresight: catu: Add support for scatter gather tables
      coresight: catu: Plug in CATU as a backend for ETR buffer

Tomas Winkler (12):
      mei: bus: type promotion bug in mei_fwver()
      mei: check for error returned from mei_hbuf_empty_slots()
      mei: use correct type for counter variable in for loops
      mei: fix ssize_t to int assignment in read and write ops.
      mei: bus: suppress sign-compare warnings
      mei: cleanup slots to data conversions
      mei: move hbuf_depth from the mei device to the hw modules
      mei: add mei_msg_hdr_init wrapper.
      mei: add support for variable length mei headers.
      mei: hbm: define dma ring setup protocol
      mei: hbm: introduce dma bit in the message header
      mei: restrict dma ring support to hbm version 2.1

Tuomas Tynkkynen (1):
      virtio: virtconsole: Use seq_file for debugfs operations

Uwe Kleine-König (2):
      siox: treat type errors as status errors
      siox: don't create a thread without starting it

Vitaly Kuznetsov (1):
      Tools: hv: vss: fix loop device detection

Wei Yongjun (1):
      misc: ibmvmc: Use GFP_ATOMIC under spin lock

Wolfram Sang (1):
      extcon: int3496: Use proper GPIO include

Wu Hao (23):
      docs: fpga: add a document for FPGA Device Feature List (DFL) Framework Overview
      fpga: mgr: add region_id to fpga_image_info
      fpga: mgr: add status for fpga-manager
      fpga: mgr: add compat_id support
      fpga: region: add compat_id support
      fpga: add device feature list support
      fpga: dfl: add chardev support for feature devices
      fpga: dfl: add dfl_fpga_cdev_find_port
      fpga: dfl: add dfl_fpga_port_ops support.
      fpga: dfl: add dfl_fpga_check_port_id function.
      fpga: dfl-pci: add enumeration for feature devices
      fpga: dfl: fme: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
      fpga: dfl: add fpga manager platform driver for FME
      fpga: dfl: fme-mgr: add compat_id support
      fpga: dfl: add fpga bridge platform driver for FME
      fpga: dfl: add fpga region platform driver for FME
      fpga: dfl: fme-region: add support for compat_id
      fpga: dfl: add FPGA Accelerated Function Unit driver basic framework
      fpga: dfl: afu: add port ops support
      fpga: dfl: afu: add header sub feature support
      fpga: dfl: afu: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
      fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support
      MAINTAINERS: add entry for FPGA DFL drivers

Xiao Guangrong (2):
      fpga: dfl: add feature device infrastructure
      fpga: dfl: afu: add afu sub feature support

Xiubo Li (1):
      uio: fix possible circular locking dependency

Zhang Yi (1):
      fpga: add FPGA DFL PCIe device driver

Zhouyang Jia (1):
      ipack: add error handling for ioremap_nocache

 Documentation/ABI/stable/sysfs-bus-vmbus           |    7 +
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |    8 +
 Documentation/ABI/testing/sysfs-class-fpga-manager |   24 +
 Documentation/ABI/testing/sysfs-class-fpga-region  |    9 +
 Documentation/ABI/testing/sysfs-class-gnss         |   15 +
 Documentation/ABI/testing/sysfs-class-mei          |   11 +
 Documentation/ABI/testing/sysfs-platform-dfl-fme   |   23 +
 Documentation/ABI/testing/sysfs-platform-dfl-port  |   16 +
 .../devicetree/bindings/arm/coresight.txt          |   58 +-
 .../devicetree/bindings/fsi/fsi-master-ast-cf.txt  |   36 +
 Documentation/devicetree/bindings/fsi/fsi.txt      |    5 +
 Documentation/devicetree/bindings/gnss/gnss.txt    |   36 +
 .../devicetree/bindings/gnss/sirfstar.txt          |   45 +
 Documentation/devicetree/bindings/gnss/u-blox.txt  |   44 +
 .../devicetree/bindings/mux/adi,adgs1408.txt       |   48 +
 .../devicetree/bindings/nvmem/imx-ocotp.txt        |    3 +-
 .../devicetree/bindings/nvmem/sc27xx-efuse.txt     |   52 +
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   84 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    3 +
 Documentation/driver-api/fpga/fpga-mgr.rst         |   12 +-
 Documentation/driver-api/fpga/fpga-region.rst      |   12 +-
 Documentation/driver-api/fpga/intro.rst            |   14 +-
 Documentation/driver-api/slimbus.rst               |    5 +
 Documentation/fpga/dfl.txt                         |  285 ++++
 Documentation/ioctl/ioctl-number.txt               |    1 +
 Documentation/sysctl/kernel.txt                    |   11 +
 Documentation/w1/slaves/w1_ds2438                  |    2 +-
 MAINTAINERS                                        |   25 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |    1 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |    1 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |    1 +
 arch/arm/mach-mmp/sram.c                           |    1 +
 arch/arm/plat-samsung/adc.c                        |    1 +
 arch/x86/hyperv/hv_init.c                          |   31 +-
 arch/x86/include/asm/hyperv-tlfs.h                 |   17 +-
 arch/x86/include/asm/mshyperv.h                    |   16 +-
 arch/x86/kernel/cpu/mshyperv.c                     |    6 +-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/android/Kconfig                            |    2 +-
 drivers/android/binder.c                           |    9 +-
 drivers/android/binder_alloc.c                     |   43 +-
 drivers/android/binder_trace.h                     |    7 +-
 drivers/ata/pata_imx.c                             |    1 +
 drivers/ata/pata_samsung_cf.c                      |    1 +
 drivers/auxdisplay/hd44780.c                       |    1 +
 drivers/char/hpet.c                                |    2 -
 drivers/char/hw_random/atmel-rng.c                 |    1 +
 drivers/char/hw_random/exynos-trng.c               |    1 +
 drivers/char/hw_random/imx-rngc.c                  |    1 +
 drivers/char/hw_random/powernv-rng.c               |    1 +
 drivers/char/mem.c                                 |    1 +
 drivers/char/pcmcia/cm4000_cs.c                    |    4 -
 drivers/char/virtio_console.c                      |   60 +-
 drivers/crypto/mediatek/mtk-platform.c             |    1 +
 drivers/crypto/qce/core.c                          |    1 +
 drivers/crypto/stm32/stm32_crc32.c                 |    1 +
 drivers/crypto/ux500/cryp/cryp_core.c              |    1 +
 drivers/crypto/ux500/hash/hash_core.c              |    1 +
 drivers/devfreq/tegra-devfreq.c                    |    1 +
 drivers/dma/ep93xx_dma.c                           |    1 +
 drivers/dma/s3c24xx-dma.c                          |    1 +
 drivers/extcon/extcon-intel-cht-wc.c               |    1 +
 drivers/extcon/extcon-intel-int3496.c              |    2 +-
 drivers/extcon/extcon-max3355.c                    |    1 +
 drivers/extcon/extcon-qcom-spmi-misc.c             |    1 +
 drivers/extcon/extcon-usbc-cros-ec.c               |   22 +-
 drivers/extcon/extcon.c                            |    3 +-
 drivers/firmware/google/vpd.c                      |    5 +-
 drivers/firmware/qemu_fw_cfg.c                     |    1 +
 drivers/fpga/Kconfig                               |   68 +
 drivers/fpga/Makefile                              |   14 +
 drivers/fpga/dfl-afu-dma-region.c                  |  463 ++++++
 drivers/fpga/dfl-afu-main.c                        |  636 ++++++++
 drivers/fpga/dfl-afu-region.c                      |  166 +++
 drivers/fpga/dfl-afu.h                             |  100 ++
 drivers/fpga/dfl-fme-br.c                          |  114 ++
 drivers/fpga/dfl-fme-main.c                        |  279 ++++
 drivers/fpga/dfl-fme-mgr.c                         |  349 +++++
 drivers/fpga/dfl-fme-pr.c                          |  479 ++++++
 drivers/fpga/dfl-fme-pr.h                          |   84 ++
 drivers/fpga/dfl-fme-region.c                      |   89 ++
 drivers/fpga/dfl-fme.h                             |   38 +
 drivers/fpga/dfl-pci.c                             |  243 ++++
 drivers/fpga/dfl.c                                 | 1044 +++++++++++++
 drivers/fpga/dfl.h                                 |  410 ++++++
 drivers/fpga/fpga-mgr.c                            |   28 +
 drivers/fpga/fpga-region.c                         |   22 +
 drivers/fsi/Kconfig                                |   32 +
 drivers/fsi/Makefile                               |    2 +
 drivers/fsi/cf-fsi-fw.h                            |  157 ++
 drivers/fsi/fsi-core.c                             |  590 ++++++--
 drivers/fsi/fsi-master-ast-cf.c                    | 1440 ++++++++++++++++++
 drivers/fsi/fsi-master-gpio.c                      |  471 ++++--
 drivers/fsi/fsi-master-hub.c                       |    5 +-
 drivers/fsi/fsi-master.h                           |   37 +
 drivers/fsi/fsi-sbefifo.c                          | 1066 ++++++++++++++
 drivers/fsi/fsi-scom.c                             |  558 ++++++-
 drivers/gnss/Kconfig                               |   43 +
 drivers/gnss/Makefile                              |   16 +
 drivers/gnss/core.c                                |  420 ++++++
 drivers/gnss/serial.c                              |  275 ++++
 drivers/gnss/serial.h                              |   47 +
 drivers/gnss/sirf.c                                |  408 ++++++
 drivers/gnss/ubx.c                                 |  153 ++
 drivers/gpio/gpio-aspeed.c                         |  426 +++++-
 drivers/gpu/drm/mediatek/mtk_cec.c                 |    1 +
 drivers/gpu/drm/sun4i/sun6i_drc.c                  |    1 +
 drivers/hid/hid-hyperv.c                           |    3 +
 drivers/hsi/controllers/omap_ssi_port.c            |    1 +
 drivers/hv/channel.c                               |   67 +-
 drivers/hv/channel_mgmt.c                          |   10 +-
 drivers/hv/hv.c                                    |   44 +-
 drivers/hv/hv_balloon.c                            |    3 +
 drivers/hv/hv_util.c                               |    3 +
 drivers/hv/ring_buffer.c                           |   65 +-
 drivers/hv/vmbus_drv.c                             |  120 +-
 drivers/hwmon/max197.c                             |    1 +
 drivers/hwmon/mc13783-adc.c                        |    1 +
 drivers/hwtracing/coresight/Kconfig                |   11 +
 drivers/hwtracing/coresight/Makefile               |    1 +
 drivers/hwtracing/coresight/coresight-catu.c       |  577 ++++++++
 drivers/hwtracing/coresight/coresight-catu.h       |  119 ++
 drivers/hwtracing/coresight/coresight-etb10.c      |   12 +-
 drivers/hwtracing/coresight/coresight-etm.h        |    3 -
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |   43 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |    4 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   47 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |   31 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |    3 -
 drivers/hwtracing/coresight/coresight-priv.h       |   10 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |   45 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    | 1074 ++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.c        |   83 +-
 drivers/hwtracing/coresight/coresight-tmc.h        |  113 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |    7 +-
 drivers/hwtracing/coresight/coresight.c            |   53 +-
 drivers/input/serio/hyperv-keyboard.c              |    3 +
 drivers/ipack/carriers/tpci200.c                   |    7 +
 drivers/media/platform/coda/imx-vdoa.c             |    1 +
 drivers/media/platform/davinci/vpbe_osd.c          |    1 +
 drivers/media/platform/davinci/vpbe_venc.c         |    1 +
 drivers/media/platform/qcom/venus/vdec.c           |    1 +
 drivers/media/platform/qcom/venus/venc.c           |    1 +
 drivers/media/platform/rcar-fcp.c                  |    1 +
 drivers/media/platform/sti/hva/hva-v4l2.c          |    1 +
 drivers/media/platform/vimc/vimc-capture.c         |    1 +
 drivers/media/platform/vimc/vimc-debayer.c         |    1 +
 drivers/media/platform/vimc/vimc-scaler.c          |    1 +
 drivers/media/platform/vimc/vimc-sensor.c          |    1 +
 drivers/memory/tegra/tegra186.c                    |    1 +
 drivers/mfd/atmel-hlcdc.c                          |    1 +
 drivers/mfd/cros_ec_dev.c                          |    1 +
 drivers/misc/aspeed-lpc-snoop.c                    |   84 +-
 drivers/misc/cardreader/rtsx_pcr.c                 |   12 +-
 drivers/misc/cxl/fault.c                           |    2 +-
 drivers/misc/eeprom/at25.c                         |    4 +
 drivers/misc/eeprom/idt_89hpesx.c                  |    6 +-
 drivers/misc/eeprom/max6875.c                      |    3 +-
 drivers/misc/genwqe/card_base.h                    |    2 +-
 drivers/misc/genwqe/card_debugfs.c                 |    4 -
 drivers/misc/genwqe/card_dev.c                     |    5 -
 drivers/misc/ibmvmc.c                              |    2 +-
 drivers/misc/mei/bus-fixup.c                       |   92 +-
 drivers/misc/mei/bus.c                             |   36 +-
 drivers/misc/mei/client.c                          |  128 +-
 drivers/misc/mei/client.h                          |    2 +-
 drivers/misc/mei/debugfs.c                         |    2 +
 drivers/misc/mei/hbm.c                             |   37 +-
 drivers/misc/mei/hw-me.c                           |   77 +-
 drivers/misc/mei/hw-me.h                           |    6 +
 drivers/misc/mei/hw-txe.c                          |   66 +-
 drivers/misc/mei/hw.h                              |   73 +-
 drivers/misc/mei/interrupt.c                       |   17 +-
 drivers/misc/mei/main.c                            |   41 +-
 drivers/misc/mei/mei_dev.h                         |   77 +-
 drivers/misc/mic/cosm/cosm_main.h                  |    5 +-
 drivers/misc/mic/cosm/cosm_scif_server.c           |    6 +-
 drivers/misc/mic/cosm_client/cosm_scif_client.c    |    6 +-
 drivers/misc/mic/scif/scif_api.c                   |   21 +-
 drivers/misc/sgi-xp/xpc_channel.c                  |    3 -
 drivers/misc/sgi-xp/xpc_partition.c                |    5 +-
 drivers/misc/sram.c                                |   18 +-
 drivers/misc/ti-st/Kconfig                         |    3 +-
 drivers/misc/ti-st/st_kim.c                        |    7 +-
 drivers/misc/tsl2550.c                             |    2 +-
 drivers/misc/vexpress-syscfg.c                     |   10 +-
 drivers/misc/vmw_balloon.c                         |  181 +--
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |    9 +-
 drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c       |    1 +
 drivers/mux/Kconfig                                |   10 +
 drivers/mux/Makefile                               |    2 +
 drivers/mux/adgs1408.c                             |  131 ++
 drivers/net/ethernet/calxeda/xgmac.c               |    1 +
 drivers/net/ethernet/faraday/ftmac100.c            |    1 +
 drivers/net/hyperv/netvsc_drv.c                    |    3 +
 drivers/net/wireless/ath/ath9k/ahb.c               |    1 +
 drivers/net/wireless/ti/wl12xx/main.c              |    1 +
 drivers/net/wireless/ti/wl18xx/main.c              |    1 +
 drivers/nvmem/Kconfig                              |   11 +
 drivers/nvmem/Makefile                             |    3 +-
 drivers/nvmem/core.c                               |    2 -
 drivers/nvmem/imx-ocotp.c                          |    7 +
 drivers/nvmem/lpc18xx_eeprom.c                     |    1 +
 drivers/nvmem/mtk-efuse.c                          |    1 +
 drivers/nvmem/qfprom.c                             |    1 +
 drivers/nvmem/rave-sp-eeprom.c                     |    6 +-
 drivers/nvmem/sc27xx-efuse.c                       |  264 ++++
 drivers/nvmem/uniphier-efuse.c                     |    1 +
 drivers/parport/ieee1284.c                         |    3 +-
 drivers/parport/parport_sunbpp.c                   |    8 +-
 drivers/perf/arm-ccn.c                             |    1 +
 drivers/pinctrl/intel/pinctrl-merrifield.c         |    1 +
 drivers/pinctrl/pinctrl-u300.c                     |    1 +
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c         |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c   |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c   |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c    |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c   |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c   |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c   |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c   |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c   |    1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c   |    1 +
 drivers/platform/goldfish/Kconfig                  |    5 -
 drivers/platform/goldfish/Makefile                 |    1 -
 drivers/platform/goldfish/goldfish_pipe.c          |    3 +-
 drivers/platform/goldfish/pdev_bus.c               |  232 ---
 drivers/platform/x86/intel_bxtwc_tmu.c             |    1 +
 drivers/platform/x86/intel_punit_ipc.c             |    1 +
 drivers/power/avs/smartreflex.c                    |    1 +
 drivers/power/reset/ltc2952-poweroff.c             |    1 +
 drivers/power/supply/max8998_charger.c             |    1 +
 drivers/power/supply/olpc_battery.c                |    1 +
 drivers/ptp/ptp_dte.c                              |    1 +
 drivers/regulator/tps65912-regulator.c             |    1 +
 drivers/reset/reset-ath79.c                        |    1 +
 drivers/reset/reset-axs10x.c                       |    1 +
 drivers/reset/reset-imx7.c                         |    1 +
 drivers/rtc/rtc-coh901331.c                        |    1 +
 drivers/rtc/rtc-cpcap.c                            |    1 +
 drivers/rtc/rtc-ftrtc010.c                         |    1 +
 drivers/rtc/rtc-mc13xxx.c                          |    1 +
 drivers/rtc/rtc-mxc_v2.c                           |    1 +
 drivers/rtc/rtc-r7301.c                            |    1 +
 drivers/rtc/rtc-sh.c                               |    1 +
 drivers/rtc/rtc-tegra.c                            |    1 +
 drivers/scsi/storvsc_drv.c                         |    3 +
 drivers/siox/siox-bus-gpio.c                       |    1 +
 drivers/siox/siox-core.c                           |   30 +-
 drivers/slimbus/Kconfig                            |   12 +-
 drivers/slimbus/Makefile                           |    5 +-
 drivers/slimbus/core.c                             |   41 +
 drivers/slimbus/messaging.c                        |   79 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    | 1526 ++++++++++++++++++++
 drivers/slimbus/slimbus.h                          |  198 +++
 drivers/slimbus/stream.c                           |  477 ++++++
 drivers/thunderbolt/domain.c                       |   55 +-
 drivers/thunderbolt/icm.c                          |  174 ++-
 drivers/thunderbolt/nhi.c                          |   46 +-
 drivers/thunderbolt/switch.c                       |   65 +-
 drivers/thunderbolt/tb.h                           |   10 +
 drivers/thunderbolt/tb_msgs.h                      |    4 +
 drivers/thunderbolt/tb_regs.h                      |    2 +-
 drivers/thunderbolt/xdomain.c                      |   18 +
 drivers/tty/goldfish.c                             |    1 +
 drivers/tty/serial/8250/8250_em.c                  |    1 +
 drivers/tty/serial/sccnxp.c                        |    1 +
 drivers/uio/uio.c                                  |   24 +-
 drivers/uio/uio_cif.c                              |    4 +-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |    1 +
 drivers/uio/uio_hv_generic.c                       |    4 +-
 drivers/uio/uio_netx.c                             |    3 +-
 drivers/uio/uio_pci_generic.c                      |    3 +-
 drivers/uio/uio_pruss.c                            |   69 +-
 drivers/uio/uio_sercos3.c                          |    1 +
 drivers/usb/gadget/udc/fsl_mxc_udc.c               |    1 +
 drivers/video/fbdev/hyperv_fb.c                    |    6 +
 .../omap2/omapfb/displays/encoder-tpd12s015.c      |    1 +
 drivers/vme/bridges/vme_ca91cx42.c                 |    2 -
 drivers/w1/masters/ds2482.c                        |    2 +-
 drivers/w1/masters/ds2490.c                        |   16 +-
 drivers/w1/masters/mxc_w1.c                        |    1 +
 drivers/watchdog/coh901327_wdt.c                   |    1 +
 drivers/watchdog/davinci_wdt.c                     |    1 +
 drivers/watchdog/imgpdc_wdt.c                      |    1 +
 drivers/watchdog/max63xx_wdt.c                     |    1 +
 drivers/watchdog/max77620_wdt.c                    |    1 +
 drivers/watchdog/moxart_wdt.c                      |    1 +
 drivers/watchdog/omap_wdt.c                        |    1 +
 drivers/watchdog/tangox_wdt.c                      |    1 +
 include/linux/coresight.h                          |   68 +-
 include/linux/device.h                             |    4 +
 include/linux/fpga/fpga-mgr.h                      |   24 +
 include/linux/fpga/fpga-region.h                   |    2 +
 include/linux/fsi-sbefifo.h                        |   33 +
 include/linux/fsi.h                                |   12 +-
 include/linux/gnss.h                               |   75 +
 include/linux/goldfish.h                           |   14 +-
 include/linux/gpio/aspeed.h                        |   15 +
 include/linux/hyperv.h                             |   33 +-
 include/linux/platform_device.h                    |    2 +-
 include/linux/slimbus.h                            |   60 +-
 include/trace/events/fsi_master_ast_cf.h           |  150 ++
 include/trace/events/fsi_master_gpio.h             |  102 ++
 include/uapi/linux/eventpoll.h                     |    8 +-
 include/uapi/linux/fpga-dfl.h                      |  179 +++
 include/uapi/linux/fsi.h                           |   58 +
 lib/devres.c                                       |   36 +
 scripts/ver_linux                                  |   14 +-
 tools/hv/hv_vss_daemon.c                           |   65 +-
 tools/hv/lsvmbus                                   |   12 +-
 312 files changed, 18533 insertions(+), 1618 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region
 create mode 100644 Documentation/ABI/testing/sysfs-class-gnss
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-fme
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-port
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt
 create mode 100644 Documentation/devicetree/bindings/mux/adi,adgs1408.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 create mode 100644 Documentation/fpga/dfl.txt
 create mode 100644 drivers/fpga/dfl-afu-dma-region.c
 create mode 100644 drivers/fpga/dfl-afu-main.c
 create mode 100644 drivers/fpga/dfl-afu-region.c
 create mode 100644 drivers/fpga/dfl-afu.h
 create mode 100644 drivers/fpga/dfl-fme-br.c
 create mode 100644 drivers/fpga/dfl-fme-main.c
 create mode 100644 drivers/fpga/dfl-fme-mgr.c
 create mode 100644 drivers/fpga/dfl-fme-pr.c
 create mode 100644 drivers/fpga/dfl-fme-pr.h
 create mode 100644 drivers/fpga/dfl-fme-region.c
 create mode 100644 drivers/fpga/dfl-fme.h
 create mode 100644 drivers/fpga/dfl-pci.c
 create mode 100644 drivers/fpga/dfl.c
 create mode 100644 drivers/fpga/dfl.h
 create mode 100644 drivers/fsi/cf-fsi-fw.h
 create mode 100644 drivers/fsi/fsi-master-ast-cf.c
 create mode 100644 drivers/fsi/fsi-sbefifo.c
 create mode 100644 drivers/gnss/Kconfig
 create mode 100644 drivers/gnss/Makefile
 create mode 100644 drivers/gnss/core.c
 create mode 100644 drivers/gnss/serial.c
 create mode 100644 drivers/gnss/serial.h
 create mode 100644 drivers/gnss/sirf.c
 create mode 100644 drivers/gnss/ubx.c
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.c
 create mode 100644 drivers/hwtracing/coresight/coresight-catu.h
 create mode 100644 drivers/mux/adgs1408.c
 create mode 100644 drivers/nvmem/sc27xx-efuse.c
 delete mode 100644 drivers/platform/goldfish/pdev_bus.c
 create mode 100644 drivers/slimbus/qcom-ngd-ctrl.c
 create mode 100644 drivers/slimbus/stream.c
 create mode 100644 include/linux/fsi-sbefifo.h
 create mode 100644 include/linux/gnss.h
 create mode 100644 include/linux/gpio/aspeed.h
 create mode 100644 include/trace/events/fsi_master_ast_cf.h
 create mode 100644 include/uapi/linux/fpga-dfl.h
 create mode 100644 include/uapi/linux/fsi.h
