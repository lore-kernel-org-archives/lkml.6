Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F480C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77AE20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546011419;
	bh=cJKQ2jtBI9ciGAp2fb9hlCgLuN+RCuGKR/pBvzDVQwE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cN13m/dmBJXLd2Obd8j6kEZOBvO7hR3u++JWbarU5/kUdXVIZOn0uXFjNCG7CRqct
	 IV6Ae08VjjGT6tLPbeOo99NewQyvooRD3ckD/At8xRWy3z/g+lGxRETvpzBmGqsZii
	 yoP7dEZe7cwmptNKRZ+zgzweligz6gvt+Aae6sco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeL1Pg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:36:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeL1Pg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:36:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B576C20869;
        Fri, 28 Dec 2018 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546011416;
        bh=cJKQ2jtBI9ciGAp2fb9hlCgLuN+RCuGKR/pBvzDVQwE=;
        h=Date:From:To:Cc:Subject:From;
        b=qk29qa1UJ3QWUTYF/3GpyiE/XoBaxzGszE66+HklNI+jg5Ti0ZF+ce3kI0XJWk7Wj
         sDmRhC1e7nn7UH8xpiRyyXKiXzgNRy/9I1/EGgiAK1P3NKkUuknrlNJY/c73juEDhX
         mN5nadXHlfANt1QX0SWZInAKRAQGoIewop+J1YQE=
Date:   Fri, 28 Dec 2018 16:36:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver patches for 4.21-rc1
Message-ID: <20181228153653.GA23909@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.21-rc1

for you to fetch changes up to fbc4904c287778ddb74bf6060ac9dec51992fc53:

  MAINTAINERS: add another Android binder maintainer (2018-12-21 08:35:45 +0100)

----------------------------------------------------------------
Char/Misc driver patches for 4.21-rc1

Here is the big set of char and misc driver patches for 4.21-rc1.

Lots of different types of driver things in here, as this tree seems to
be the "collection of various driver subsystems not big enough to have
their own git tree" lately.

Anyway, some highlights of the changes in here:
  - binderfs: is it a rule that all driver subsystems will eventually
    grow to have their own filesystem?  Binder now has one to handle the
    use of it in containerized systems.  This was discussed at the
    Plumbers conference a few months ago and knocked into mergable shape
    very fast by Christian Brauner.  Who also has signed up to be
    another binder maintainer, showing a distinct lack of good judgement :)
  - binder updates and fixes
  - mei driver updates
  - fpga driver updates and additions
  - thunderbolt driver updates
  - soundwire driver updates
  - extcon driver updates
  - nvmem driver updates
  - hyper-v driver updates
  - coresight driver updates
  - pvpanic driver additions and reworking for more device support
  - lp driver updates.  Yes really, it's _finally_ moved to the proper
    parallal port driver model, something I never thought I would see
    happen.  Good stuff.
  - other tiny driver updates and fixes.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Tull (3):
      dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
      arm64: dts: stratix10: add fpga manager and region
      fpga: add intel stratix10 soc fpga manager driver

Alban Bedel (1):
      mtd: add support for reading MTD devices via the nvmem API

Alexander Shishkin (3):
      stm class: Fix a module refcount leak in policy creation error path
      stm class: Add a reference to the SyS-T document
      intel_th: msu: Fix an off-by-one in attribute store

Alexander Usyskin (4):
      mei: flush queues by the host client only
      mei: expedite ioctl return on the notify set operation error
      mei: bump hbm version to 2.1
      mei: me: mark CNP devices as having dma support

Alexandre Belloni (1):
      nvmem: add type attribute

Anatolij Gustschin (3):
      fpga: altera-cvp: fix 'bad IO access' on x86_64
      fpga: altera-cvp: fix probing for multiple FPGAs on the bus
      fpga: mgr: altera-ps-spi: enable usage on non-dt platforms

Andreas Puhm (1):
      fpga: altera-cvp: Fix registration for CvP incapable devices

Andrey Smirnov (1):
      tools: Add 'firmware' category and add ihex2fw tool

Andy Shevchenko (1):
      nvmem: Move nvmem_type_str array to its only user

Arnd Bergmann (1):
      vbox: fix link error with 'gcc -Og'

Bartosz Golaszewski (1):
      nvmem: add new config option

Christian Borntraeger (1):
      genwqe: Fix size check

Christian Brauner (2):
      binder: implement binderfs
      MAINTAINERS: add another Android binder maintainer

Colin Ian King (5):
      tlclk: clean an indentation issue, remove extraneous tabs
      altera-stapl: check for a null key before strcasecmp'ing it
      coresight: fix spelling mistake "deffered" -> "deferred"
      slimbus: ngd: fix spelling mistake "exeeds" -> "exceeds"
      misc: ti-st: make array read_ver_cmd static, shrinks object size

Dan Carpenter (3):
      misc/pvpanic: fix a NULL vs IS_ERR() check
      misc: vexpress: Off by one in vexpress_syscfg_exec()
      ptp: fix an IS_ERR() vs NULL check

Dexuan Cui (3):
      Drivers: hv: kvp: Use %u to print U32
      Tools: hv: kvp: Fix a warning of buffer overflow with gcc 8.0.1
      Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoing_channel()

Greg Kroah-Hartman (6):
      Merge 4.20-rc4 into char-misc-next
      Merge 4.20-rc5 into char-misc-next
      Merge tag 'soundwire-4.21-rc1' of git://git.kernel.org/.../vkoul/soundwire into char-misc-next
      Merge 4.20-rc6 into char-misc-next
      Merge tag 'thunderbolt-for-v4.21' of git://git.kernel.org/.../westeri/thunderbolt into char-misc-next
      Merge tag 'extcon-next-for-4.21' of git://git.kernel.org/.../chanwoo/extcon into char-misc-next

Gustavo A. R. Silva (1):
      parport: parport_pc: Mark expected switch fall-through

Haiyang Zhang (1):
      hv_utils: update name in struct hv_driver util_drv

Ioana Ciornei (1):
      bus: fsl-mc: explicitly define the fsl_mc_command endianness

Jerome Brunet (3):
      nvmem: meson-efuse: add error message on user_max failure.
      nvmem: meson-efuse: bindings: add peripheral clock
      nvmem: meson-efuse: add peripheral clock

Julia Lawall (1):
      soundwire: intel: constify snd_soc_dai_ops structures

K. Y. Srinivasan (1):
      Drivers: hv: vmbus: Get rid of unnecessary state in hv_context

Leo Yan (1):
      coresight: tmc: Fix bad register address for CLAIM

Lu Baolu (1):
      iommu/vt-d: Force IOMMU on for platform opt in hint

Marek Szyprowski (5):
      extcon: max77843: Avoid forcing UART path on drive probe
      extcon: max77693: Avoid forcing UART path on drive probe
      extcon: max14577: Avoid forcing UART path on drive probe
      extcon: max8997: Avoid forcing UART path on drive probe
      extcon: max8997: Fix lack of path setting in USB device mode

Mathieu Poirier (5):
      MAINTAINERS: Add reviewer for CoreSight sub-system
      coresight: etb10: Add support for CLAIM tag
      coresight: etf: Release CLAIM tag after disabling the HW
      coresight: etm3x: Deal with CLAIM tag before and after accessing HW
      coresight: etm3x: Release CLAIM tag when operated from perf

Mika Westerberg (3):
      PCI / ACPI: Identify untrusted PCI devices
      iommu/vt-d: Do not enable ATS for untrusted devices
      thunderbolt: Export IOMMU based DMA protection support to userspace

Mike Looijmans (1):
      zynq-fpga: Only route PR via PCAP when required

Moritz Fischer (2):
      fpga: dfl-fme-region: Use platform_get_drvdata()
      fpga: of-fpga-region: Use platform_set_drvdata

Nicolas Saenz Julienne (1):
      firmware: stratix10-svc: fix wrong of_node_put() in init function

Niklas Cassel (1):
      slimbus: ngd: QCOM_QMI_HELPERS has to be selected

Peng Hao (12):
      pvpanic: move pvpanic to misc as common driver
      misc/pvpanic: simplify the code using acpi_dev_resource_io
      misc/pvpanic: add MMIO support
      dt-bindings: misc/pvpanic: add document for pvpanic-mmio
      misc/pvpanic: add support to get pvpanic device info FDT
      misc/pvpanic : grouping ACPI related stuff
      misc/pvpanic : break dependency on ACPI
      misc/pvpanic: remove unnecessary header file
      misc/pvpanic: change header file sort style
      misc/pvpanic: convert to SPDX license tags
      misc/pvpanic: remove a redundant comma
      misc/pvpanic: resolve compile errors for arch=um

Richard Gong (5):
      dt-bindings, firmware: add Intel Stratix10 service layer binding
      arm64: dts: stratix10: add stratix10 service driver binding to base dtsi
      firmware: add Intel Stratix10 service layer driver
      Documentation: driver-api: add stratix10 service layer
      firmware: add remote status update client support

Rob Herring (2):
      misc: cxl: Use device_type helpers to access the node type
      char/rtc: Use of_node_name_eq for node name comparisons

Srinivas Kandagatla (1):
      slimbus: ngd: Fix build error on x86

Sudip Mukherjee (11):
      char: lp: remove trailing whitespace
      char: lp: move trailing statement to next line
      char: lp: do not use return as a function
      char: lp: use tabs instead of spaces
      char: lp: fix whitespace with pointers
      char: lp: fix spacing style before open parenthesis
      char: lp: introduce list to save port number
      char: lp: detach the device when parallel port is removed
      char: lp: use first unused lp number while registering
      char: lp: properly count the lp devices
      char: lp: use new parport device model

Todd Kjos (4):
      binder: fix sparse warnings on locking context
      binder: fix kerneldoc header for struct binder_buffer
      binder: filter out nodes when showing binder procs
      binder: fix use-after-free due to ksys_close() during fdget()

Tomas Winkler (6):
      mei: hbm: drop BUG() from the hbm handler
      mei: dma ring buffers allocation
      mei: hbm: setup dma ring
      mei: hw: add dma ring control block
      mei: dma ring: implement rx circular buffer logic
      mei: dma ring: implement transmit flow

Wen Yang (1):
      VMCI: Use memdup_user() rather than duplicating its implementation

Wenwen Wang (1):
      misc: mic: fix a DMA pool free failure

Wolfram Sang (2):
      uio: uio_fsl_elbc_gpcm: simplify getting .driver_data
      slimbus: qcom-ctrl: simplify getting .driver_data

Xavier Deguillard (1):
      vmw_balloon: update maintainers list

Yangtao Li (3):
      binder: remove BINDER_DEBUG_ENTRY()
      char: virtio: Change to use DEFINE_SHOW_ATTRIBUTE macro
      misc: remove GENWQE_DEBUGFS_RO()

YueHaibing (4):
      fpga: dfl: fme: remove set but not used variable 'priv'
      pps: using ERR_PTR instead of NULL while pps_register_source fails
      bus: fsl-mc: remove duplicated include files
      bus: qcom: remove duplicated include from qcom-ebi2.c

Zhaolong Zhang (1):
      uio: dismiss waiters on device unregistration

 Documentation/ABI/testing/sysfs-bus-thunderbolt    |    9 +
 Documentation/admin-guide/thunderbolt.rst          |   20 +
 .../bindings/firmware/intel,stratix10-svc.txt      |   57 ++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt |   17 +
 .../devicetree/bindings/misc/pvpanic-mmio.txt      |   29 +
 .../devicetree/bindings/nvmem/amlogic-efuse.txt    |    3 +
 .../driver-api/firmware/other_interfaces.rst       |   30 +
 Documentation/trace/index.rst                      |    1 +
 MAINTAINERS                                        |    4 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   33 +
 drivers/acpi/property.c                            |   11 +
 drivers/android/Kconfig                            |   12 +
 drivers/android/Makefile                           |    1 +
 drivers/android/binder.c                           |  182 +++-
 drivers/android/binder_alloc.c                     |    1 +
 drivers/android/binder_alloc.h                     |   20 +-
 drivers/android/binder_internal.h                  |   49 +
 drivers/android/binderfs.c                         |  544 ++++++++++
 drivers/bus/fsl-mc/dpbp.c                          |    1 -
 drivers/bus/fsl-mc/dpcon.c                         |    1 -
 drivers/bus/qcom-ebi2.c                            |    1 -
 drivers/char/lp.c                                  |  278 +++---
 drivers/char/rtc.c                                 |    4 +-
 drivers/char/tlclk.c                               |   87 +-
 drivers/char/virtio_console.c                      |   17 +-
 drivers/extcon/extcon-max14577.c                   |   15 +-
 drivers/extcon/extcon-max77693.c                   |   16 +-
 drivers/extcon/extcon-max77843.c                   |   18 +-
 drivers/extcon/extcon-max8997.c                    |   25 +-
 drivers/firmware/Kconfig                           |   12 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/stratix10-svc.c                   | 1041 ++++++++++++++++++++
 drivers/fpga/Kconfig                               |    6 +
 drivers/fpga/Makefile                              |    1 +
 drivers/fpga/altera-cvp.c                          |   49 +-
 drivers/fpga/altera-ps-spi.c                       |   40 +-
 drivers/fpga/dfl-fme-pr.c                          |    2 -
 drivers/fpga/dfl-fme-region.c                      |    2 +-
 drivers/fpga/of-fpga-region.c                      |    2 +-
 drivers/fpga/stratix10-soc.c                       |  535 ++++++++++
 drivers/fpga/zynq-fpga.c                           |    4 +
 drivers/hv/channel.c                               |    1 -
 drivers/hv/channel_mgmt.c                          |   44 -
 drivers/hv/hv.c                                    |   10 +-
 drivers/hv/hv_kvp.c                                |    2 +-
 drivers/hv/hv_util.c                               |    2 +-
 drivers/hv/hyperv_vmbus.h                          |    2 -
 drivers/hwtracing/coresight/coresight-etb10.c      |   23 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      |   12 +-
 drivers/hwtracing/coresight/coresight-stm.c        |    2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |    2 +-
 drivers/hwtracing/intel_th/msu.c                   |    3 +-
 drivers/hwtracing/stm/policy.c                     |   12 +-
 drivers/iommu/dmar.c                               |   25 +
 drivers/iommu/intel-iommu.c                        |   56 +-
 drivers/misc/Kconfig                               |    8 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/altera-stapl/altera.c                 |    3 +-
 drivers/misc/cxl/pci.c                             |    4 +-
 drivers/misc/genwqe/card_debugfs.c                 |   85 +-
 drivers/misc/genwqe/card_utils.c                   |    2 +-
 drivers/misc/mei/Makefile                          |    1 +
 drivers/misc/mei/client.c                          |   91 +-
 drivers/misc/mei/dma-ring.c                        |  269 +++++
 drivers/misc/mei/hbm.c                             |   92 +-
 drivers/misc/mei/hbm.h                             |    2 +
 drivers/misc/mei/hw-me.c                           |    6 +
 drivers/misc/mei/hw.h                              |   29 +-
 drivers/misc/mei/init.c                            |    2 +-
 drivers/misc/mei/interrupt.c                       |   41 +-
 drivers/misc/mei/mei_dev.h                         |   26 +-
 drivers/misc/mei/pci-me.c                          |    4 +-
 drivers/misc/mic/card/mic_debugfs.c                |   24 +-
 drivers/misc/mic/cosm/cosm_debugfs.c               |   39 +-
 drivers/misc/mic/host/mic_debugfs.c                |   62 +-
 drivers/misc/mic/scif/scif_debugfs.c               |   44 +-
 drivers/misc/mic/scif/scif_fence.c                 |   22 +-
 drivers/misc/mic/scif/scif_rma.h                   |   13 +
 drivers/misc/mic/vop/vop_debugfs.c                 |   40 +-
 drivers/misc/pvpanic.c                             |  192 ++++
 drivers/misc/ti-st/st_kim.c                        |   36 +-
 drivers/misc/vexpress-syscfg.c                     |    2 +-
 drivers/misc/vmw_balloon.c                         |   13 +-
 drivers/misc/vmw_vmci/vmci_host.c                  |   18 +-
 drivers/mtd/Kconfig                                |    1 +
 drivers/mtd/mtdcore.c                              |   56 ++
 drivers/nvmem/core.c                               |   31 +-
 drivers/nvmem/meson-efuse.c                        |   29 +-
 drivers/parport/parport_pc.c                       |    2 +-
 drivers/pci/pci-acpi.c                             |   19 +
 drivers/pci/probe.c                                |   15 +
 drivers/platform/x86/Kconfig                       |    8 -
 drivers/platform/x86/Makefile                      |    1 -
 drivers/platform/x86/pvpanic.c                     |  124 ---
 drivers/pps/clients/pps-gpio.c                     |    4 +-
 drivers/pps/clients/pps-ktimer.c                   |    4 +-
 drivers/pps/clients/pps-ldisc.c                    |    4 +-
 drivers/pps/clients/pps_parport.c                  |    2 +-
 drivers/pps/kapi.c                                 |    5 +-
 drivers/ptp/ptp_clock.c                            |    3 +-
 drivers/slimbus/Kconfig                            |    5 +-
 drivers/slimbus/qcom-ctrl.c                        |    6 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |    7 +-
 drivers/soundwire/intel.c                          |    4 +-
 drivers/thunderbolt/domain.c                       |   17 +
 drivers/uio/uio.c                                  |   19 +-
 drivers/uio/uio_fsl_elbc_gpcm.c                    |    6 +-
 drivers/virt/vboxguest/vboxguest_core.c            |    2 +-
 fs/file.c                                          |   29 +
 include/linux/dmar.h                               |    8 +
 include/linux/fdtable.h                            |    1 +
 include/linux/firmware/intel/stratix10-smc.h       |  312 ++++++
 .../linux/firmware/intel/stratix10-svc-client.h    |  217 ++++
 include/linux/fsl/mc.h                             |   12 +-
 include/linux/hyperv.h                             |   17 -
 include/linux/mtd/mtd.h                            |    2 +
 include/linux/nvmem-provider.h                     |   11 +
 include/linux/pci.h                                |    8 +
 include/uapi/linux/android/binder_ctl.h            |   35 +
 include/uapi/linux/magic.h                         |    1 +
 tools/Makefile                                     |    7 +-
 tools/firmware/Makefile                            |   13 +
 tools/firmware/ihex2fw.c                           |  281 ++++++
 tools/hv/hv_kvp_daemon.c                           |   15 +-
 124 files changed, 4973 insertions(+), 918 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
 create mode 100644 Documentation/devicetree/bindings/misc/pvpanic-mmio.txt
 create mode 100644 drivers/android/binder_internal.h
 create mode 100644 drivers/android/binderfs.c
 create mode 100644 drivers/firmware/stratix10-svc.c
 create mode 100644 drivers/fpga/stratix10-soc.c
 create mode 100644 drivers/misc/mei/dma-ring.c
 create mode 100644 drivers/misc/pvpanic.c
 delete mode 100644 drivers/platform/x86/pvpanic.c
 create mode 100644 include/linux/firmware/intel/stratix10-smc.h
 create mode 100644 include/linux/firmware/intel/stratix10-svc-client.h
 create mode 100644 include/uapi/linux/android/binder_ctl.h
 create mode 100644 tools/firmware/Makefile
 create mode 100644 tools/firmware/ihex2fw.c
