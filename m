Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C50CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6928215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6928215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHRTEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeHRTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:20 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1799ABE1;
        Sat, 18 Aug 2018 15:56:04 +0000 (UTC)
Date:   Sat, 18 Aug 2018 17:55:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver patches for 4.19-rc1
Message-ID: <20180818155559.GA22411@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.19-rc1

for you to fetch changes up to 29c692c96b3a39cd1911fb79cd2505af8d070f07:

  USB: serial: pl2303: add a new device id for ATEN (2018-08-02 10:37:04 +0200)

----------------------------------------------------------------
USB/PHY patches for 4.19-rc1

Here is the big USB and phy driver patch set for 4.19-rc1.

Nothing huge but there was a lot of work that happened this development
cycle:
	- lots of type-c work, with drivers graduating out of staging,
	  and displayport support being added.
	- new PHY drivers
	- the normal collection of gadget driver updates and fixes
	- code churn to work on the urb handling path, using irqsave()
	  everywhere in anticipation of making this codepath a lot
	  simpler in the future.
	- usbserial driver fixes and reworks
	- other misc changes

Full details are in the shortlog.

All of these have been in linux-next with no reported issues for a
while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (4):
      USB: Report wakeup events on root-hub ports
      USB: ehci-hcd: Add get_resuming_ports method
      USB: xhci-hcd: Add get_resuming_ports method
      USB: gadget: Document that certain ep operations can be called in interrupt context

Aleksander Morgado (1):
      USB: option: add support for DW5821e

Andy Shevchenko (3):
      usb: dwc3: Describe 'wakeup_work' field of struct dwc3_pci
      usb: dwc3: pci: Supply device properties via driver data
      usb: dwc3: pci: Intel Merrifield can be host

Antoine Tenart (1):
      phy: mvebu-cp110-comphy: switch to SPDX identifier

Anton Vasilyev (1):
      uwb: hwa-rc: fix memory leak at probe

Anurag Kumar Vulisha (1):
      usb: dwc3: core: Enable AutoRetry feature in the controller

Arnd Bergmann (2):
      USB: mon: use ktime_get_real_ts64 instead of getnstimeofday64
      usb: typec: avoid format-overflow warning

Avi Fishman (2):
      USB host: Add USB ehci support for nuvoton npcm7xx platform
      dt-bindings: usb: new ehci-npcm7xx dt

Chengguang Xu (1):
      USB: serial: cast sizeof() to int when comparing with error code

Chunfeng Yun (5):
      phy: phy-mtk-tphy: use SPDX license tag
      dt-bindings: phy-mtk-tphy: add optional properties for u2phy
      phy: phy-mtk-tphy: add properties for eye diagram test
      phy: phy-mtk-tphy: add property for BC12
      MAINTAINERS: update files of MediaTek USB3 PHYs

Colin Ian King (13):
      usb: typec: fix dereference before null check on adev
      usb: typec: unlock dp->lock on error exit path, and also zero ret if successful
      usb: usbip: remove redundant pointer ep
      usb: misc: uss720: remove redundant pointer usbdev
      usb-misc: sisusbvga: remove redundant variable modey
      usb: isp1760: remove redundant variable 'selector'
      usb: xhci: dbc: remove redundant pointer dbc
      USB: host: whci: remove redundant variable t
      usb: host: u132-hcd: remove redundant variable num_ports
      usb: host: ehci-sched: remove redundant pointer dev
      usb: dwc3: gadget: remove redundant variable maxpacket
      USB: serial: mos7720: remove redundant variables iflag, mask and serial
      usb: gadget: tcm: fix spelling mistake: "Manufactor" -> "Manufacturer"

Dan Carpenter (1):
      USB: host: ehci-npcm7xx: Fix some error codes in probe

Douglas Anderson (5):
      phy: qcom-qmp: Fix dts bindings to reflect reality
      usb: dwc2: Turn on uframe_sched on "bcm" platforms
      usb: dwc2: Turn on uframe_sched on "his" platforms
      usb: dwc2: Turn on uframe_sched on "amlogic" platforms
      usb: dwc2: Turn on uframe_sched on "stm32f4x9_fsotg" platforms

Enric Balletbo i Serra (1):
      usb: dwc3: of-simple: reset host controller at suspend/resume

Erich E. Hoover (1):
      usb: dwc3: change stream event enable bit back to 13

Gevorg Sahakyan (4):
      usb: dwc2: Move dwc2_readl/writel functions after hsotg structure
      usb: dwc2: Modify dwc2_readl/writel functions prototype
      usb: dwc2: replace ioread32/iowrite32_rep with dwc2_readl/writel_rep
      usb: dwc2: Make dwc2_readl/writel functions endianness-agnostic.

Greg Kroah-Hartman (7):
      Merge 4.18-rc3 into usb-next
      Merge 4.18-rc5 into usb-next
      Merge tag 'usb-serial-4.19-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge tag 'phy-for-4.19' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge tag 'usb-ci-v4.19-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next
      Merge 4.18-rc7 into usb-next
      Merge tag 'usb-for-v4.19' of git://git.kernel.org/.../balbi/usb into usb-next

Guido Kiener (7):
      usb: usbtmc: Support Read Status Byte with SRQ per file
      usb: usbtmc: use consistent timeout error
      usb: usbtmc: Add ioctls to set/get usb timeout
      usb: usbtmc: Add ioctl for trigger
      usb: usbtmc: Add ioctl for EOM bit
      usb: usbtmc: Add ioctl for termination character
      usb: usbtmc: Add support for 32 bit compat applications

Gustavo A. R. Silva (3):
      USB: musb: mark expected switch fall-throughs
      USB: mark expected switch fall-throughs
      phy: qcom-usb-hs: Mark expected switch fall-through

Hans de Goede (4):
      USB: typec: fsusb302: Drop empty set_current_limit implementation
      usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources
      usb: dwc3: pci: Enable ULPI Refclk on platforms where the firmware does not
      usb: dwc3: pci: Use devm functions to get the phy GPIOs

Heikki Krogerus (8):
      usb: pd: include kernel.h
      usb: typec: function for checking cable plug orientation
      usb: typec: mux: Get the mux identifier from function parameter
      usb: typec: Register a device for every mode
      usb: typec: Bus type for alternate modes
      usb: typec: Add driver for DisplayPort alternate mode
      usb: typec: pi3usb30532: Start using generic state values
      usb: typec: tcpm: Support for Alternate Modes

Jaejoong Kim (3):
      usb: cdc-acm: Decrement tty port's refcount if probe() fail
      usb: gadget: storage: Add error handling for no memory
      usb: gadget: storage: Remove reference counting

Jerry Zhang (1):
      usb: gadget: f_fs: Only return delayed status when len is 0

Jisheng Zhang (1):
      phy: berlin: switch to SPDX license identifier

Johan Hovold (11):
      USB: serial: digi_acceleport: rename tty flag variable
      USB: serial: kobil_sct: fix modem-status error handling
      USB: serial: kobil_sct: add missing version error handling
      USB: serial: kl5kusb105: remove KLSI device id
      USB: serial: clean up kl5kusb105 documentation
      USB: serial: iuu_phoenix: drop unused driver-data baud rate
      USB: serial: iuu_phoenix: drop redundant input-speed re-encoding
      USB: serial: cp210x: make line-speed quantisation data driven
      USB: serial: cp210x: honour device-type maximum line speed
      USB: serial: cp210x: generalise CP2102N line-speed handling
      USB: serial: cp210x: improve line-speed handling for CP2104 and CP2105

John Ogness (14):
      USB: serial: cyberjack: use irqsave() in USB's complete callback
      USB: serial: digi_acceleport: use irqsave() in USB's complete callback
      USB: serial: io_edgeport: use irqsave() in USB's complete callback
      USB: serial: io_ti: use irqsave() in USB's complete callback
      USB: serial: mos7720: use irqsave() in USB's complete callback
      USB: serial: mos7840: use irqsave() in USB's complete callback
      USB: serial: quatech2: use irqsave() in USB's complete callback
      USB: serial: sierra: fix potential deadlock at close
      USB: serial: sierra: use irqsave() in USB's complete callback
      USB: serial: symbolserial: use irqsave() in USB's complete callback
      USB: serial: ti_usb_3410_5052: use irqsave() in USB's complete callback
      USB: serial: usb_wwan: use irqsave() in USB's complete callback
      usb: usb-skeleton: use irqsave() in USB's complete callback
      usb: wusbcore: remove excessive irqsave

Julia Lawall (1):
      usb: wusbcore: security: cast sizeof to int for comparison

Karoly Pados (2):
      USB: serial: cp210x: improve baudrate support for CP2102N
      USB: serial: cp210x: implement GPIO support for CP2102N

Kees Cook (1):
      usb: typec: tps6598x: Remove VLA usage

Kieran Bingham (1):
      usb: gadget: uvc: Expose configuration name through video node

Kuninori Morimoto (1):
      usb: renesas_usbhs: Kconfig: convert to SPDX identifiers

Laurent Pinchart (4):
      usb: gadget: uvc: Move userspace API definition to public header
      usb: gadget: uvc: Minimize #include in headers
      usb: gadget: uvc: Move trace parameter to function module
      usb: gadget: uvc: configfs: Move function to avoid forward declaration

Li Jun (13):
      dt-bindings: connector: add properties for typec
      dt-bindings: usb: add documentation for typec port controller(TCPCI)
      staging: typec: tcpci: add compatible string for nxp ptn5110
      usb: typec: add fwnode to tcpc
      usb: typec: add API to get typec basic port power and data config
      usb: typec: tcpm: support get typec and pd config from device properties
      staging: typec: tcpci: remove unused tcpci_tcpc_config
      staging: typec: tcpci: use IS_ERR() instead of PTR_ERR_OR_ZERO()
      staging: typec: tcpci: enable vbus detection
      typec: tcpm: add starting value for drp toggling
      staging: typec: tcpci: keep the disconnected cc line open
      staging: typec: tcpci: Only touch target bit when enable vconn
      staging: typec: tcpci: move tcpci drivers out of staging

Marcel Ziswiler (1):
      usb: chipidea: tegra: Use aligned DMA on Tegra114/124

Minas Harutyunyan (1):
      usb: dwc2: gadget: ISOC's starting flow improvement

Movie Song (1):
      USB: serial: pl2303: add a new device id for ATEN

Parth Y Shah (1):
      usb: gadget: configfs: avoid spaces for indentation

Pengbo Mu (3):
      usb: dwc3: add global soc bus configuration reg0
      usb: dwc3: Enable undefined length INCR burst type
      arm64: dts: dwc3: description of incr burst type

Peter Chen (1):
      staging: typec: tcpci: register port before request irq

Peter Senna Tschudin (1):
      tools: usb: ffs-test: Fix build on big endian systems

Randy Dunlap (1):
      usb/phy: fix PPC64 build errors in phy-fsl-usb.c

Ray Jui (2):
      dt-bindings: phy: Add binding doc for Stingray PCIe PHY
      phy: bcm-sr-pcie: Add Stingray PCIe PHY driver

Sebastian Andrzej Siewior (13):
      usb: cdc-acm: use irqsave() in USB's complete callback
      usb: core: use irqsave() in sg_complete() complete callback
      usb: usbfs: use irqsave() in USB's complete callback
      usb: usblp: use irqsave() in USB's complete callback
      usb: adutux: use irqsave() in USB's complete callback
      usb: iowarrior: remove intr_idx_lock
      usb: ldusb: use irqsave() in USB's complete callback
      usb: legousbtower: use irqsave() in USB's complete callback
      USB: cdc-wdm: don't enable interrupts in USB-giveback
      NFC: nfcmrvl_usb: use irqsave() in USB's complete callback
      usb: cdc-wdm: use irqsave() in USB's complete callback
      usb: usbtest: use irqsave() in USB's complete callback
      usb: usbtest: use irqsave() in USB's complete callback

Sergei Shtylyov (2):
      dt-bindings: phy: Renesas R-Car Gen3 PCIe PHY bindings
      phy: Renesas R-Car gen3 PCIe PHY driver

Shuah Khan (Samsung OSG) (1):
      selftests: usbip: remove test_bitmap noise

Stephen Rothwell (1):
      usb: update for tcpci drivers moving out of staging

Thinh Nguyen (3):
      usb: dwc3: Add a glue driver for Synopsys HAPS platform
      usb: dwc3: Set default mode for dwc_usb31
      usb: dwc3: gadget: Check MaxPacketSize from descriptor

Yoshihiro Shimoda (6):
      usb: host: xhci-plat: add firmware_name for R-Car Gen3
      usb: host: xhci-rcar: Simplify getting the firmware name for R-Car Gen3
      usb: host: xhci-rcar: Add a condition check about PLL active
      dt-bindings: usb-xhci: Add r8a77990 support
      dt-bindings: rcar-gen3-phy-usb2: Add bindings for r8a77990
      usb: gadget: udc: renesas_usb3: Add register of usb role switch

 Documentation/ABI/obsolete/sysfs-class-typec       |  48 ++
 Documentation/ABI/testing/configfs-usb-gadget-uvc  |   5 +
 Documentation/ABI/testing/sysfs-bus-typec          |  51 ++
 Documentation/ABI/testing/sysfs-class-typec        |  62 +--
 .../ABI/testing/sysfs-driver-typec-displayport     |  49 ++
 .../bindings/connector/usb-connector.txt           |  44 ++
 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   |  41 ++
 .../devicetree/bindings/phy/phy-mtk-tphy.txt       |   6 +
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |  14 +-
 .../devicetree/bindings/phy/rcar-gen3-phy-pcie.txt |  24 +
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   2 +
 Documentation/devicetree/bindings/usb/dwc3.txt     |   6 +
 .../devicetree/bindings/usb/npcm7xx-usb.txt        |  18 +
 .../devicetree/bindings/usb/typec-tcpci.txt        |  49 ++
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 Documentation/driver-api/usb/typec_bus.rst         | 136 +++++
 Documentation/usb/usb-serial.txt                   |   9 -
 MAINTAINERS                                        |  15 +-
 drivers/nfc/nfcmrvl/usb.c                          |   5 +-
 drivers/phy/broadcom/Kconfig                       |  10 +
 drivers/phy/broadcom/Makefile                      |   2 +
 drivers/phy/broadcom/phy-bcm-sr-pcie.c             | 305 +++++++++++
 drivers/phy/marvell/phy-berlin-sata.c              |   5 +-
 drivers/phy/marvell/phy-berlin-usb.c               |   5 +-
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c       |   5 +-
 drivers/phy/mediatek/Makefile                      |   1 +
 drivers/phy/mediatek/phy-mtk-tphy.c                |  85 ++-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c             |   1 +
 drivers/phy/renesas/Kconfig                        |   7 +
 drivers/phy/renesas/Makefile                       |   1 +
 drivers/phy/renesas/phy-rcar-gen3-pcie.c           | 151 ++++++
 drivers/staging/Kconfig                            |   2 -
 drivers/staging/Makefile                           |   1 -
 drivers/staging/typec/Kconfig                      |  23 -
 drivers/staging/typec/Makefile                     |   2 -
 drivers/staging/typec/TODO                         |   5 -
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   4 +-
 drivers/usb/class/cdc-acm.c                        |  40 +-
 drivers/usb/class/cdc-wdm.c                        |  47 +-
 drivers/usb/class/usblp.c                          |  10 +-
 drivers/usb/class/usbtmc.c                         | 320 ++++++++++--
 drivers/usb/core/devio.c                           |   5 +-
 drivers/usb/core/hub.c                             |  42 ++
 drivers/usb/core/message.c                         |   9 +-
 drivers/usb/dwc2/core.c                            | 241 ++++-----
 drivers/usb/dwc2/core.h                            | 109 ++--
 drivers/usb/dwc2/core_intr.c                       | 118 ++---
 drivers/usb/dwc2/debugfs.c                         |  55 +-
 drivers/usb/dwc2/gadget.c                          | 531 +++++++++----------
 drivers/usb/dwc2/hcd.c                             | 459 ++++++++--------
 drivers/usb/dwc2/hcd.h                             |  10 +-
 drivers/usb/dwc2/hcd_ddma.c                        |  10 +-
 drivers/usb/dwc2/hcd_intr.c                        |  96 ++--
 drivers/usb/dwc2/hcd_queue.c                       |  10 +-
 drivers/usb/dwc2/params.c                          |  24 +-
 drivers/usb/dwc2/platform.c                        |  19 +
 drivers/usb/dwc3/Kconfig                           |  13 +-
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            | 118 +++++
 drivers/usb/dwc3/core.h                            |  17 +
 drivers/usb/dwc3/dwc3-haps.c                       | 137 +++++
 drivers/usb/dwc3/dwc3-of-simple.c                  |  29 ++
 drivers/usb/dwc3/dwc3-pci.c                        | 223 ++++----
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/dwc3/gadget.h                          |   2 +-
 drivers/usb/gadget/configfs.c                      |   4 +-
 drivers/usb/gadget/function/f_mass_storage.c       |  31 +-
 drivers/usb/gadget/function/f_mass_storage.h       |   4 -
 drivers/usb/gadget/function/f_uvc.c                |  31 +-
 drivers/usb/gadget/function/f_uvc.h                |   6 +-
 drivers/usb/gadget/function/u_uvc.h                |   5 +-
 drivers/usb/gadget/function/uvc.h                  |  53 +-
 drivers/usb/gadget/function/uvc_configfs.c         |  12 +-
 drivers/usb/gadget/function/uvc_queue.h            |  12 +-
 drivers/usb/gadget/function/uvc_v4l2.c             |   3 +-
 drivers/usb/gadget/function/uvc_video.h            |   2 +
 drivers/usb/gadget/legacy/tcm_usb_gadget.c         |   2 +-
 drivers/usb/gadget/legacy/webcam.c                 |   4 -
 drivers/usb/gadget/udc/Kconfig                     |   1 +
 drivers/usb/gadget/udc/core.c                      |  18 +
 drivers/usb/gadget/udc/renesas_usb3.c              |  84 ++-
 drivers/usb/host/Kconfig                           |   8 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ehci-hcd.c                        |   1 +
 drivers/usb/host/ehci-hub.c                        |   8 +
 drivers/usb/host/ehci-npcm7xx.c                    | 212 ++++++++
 drivers/usb/host/ehci-sched.c                      |   4 -
 drivers/usb/host/u132-hcd.c                        |   2 -
 drivers/usb/host/whci/pzl.c                        |   2 -
 drivers/usb/host/xhci-dbgcap.c                     |   2 -
 drivers/usb/host/xhci-hub.c                        |  11 +
 drivers/usb/host/xhci-plat.c                       |   1 +
 drivers/usb/host/xhci-rcar.c                       |  43 +-
 drivers/usb/host/xhci.c                            |   1 +
 drivers/usb/host/xhci.h                            |   2 +
 drivers/usb/isp1760/isp1760-hcd.c                  |   2 -
 drivers/usb/misc/adutux.c                          |  10 +-
 drivers/usb/misc/appledisplay.c                    |   1 +
 drivers/usb/misc/iowarrior.c                       |   5 -
 drivers/usb/misc/ldusb.c                           |   7 +-
 drivers/usb/misc/legousbtower.c                    |   5 +-
 drivers/usb/misc/sisusbvga/sisusb.c                |   4 +-
 drivers/usb/misc/usbtest.c                         |  10 +-
 drivers/usb/misc/uss720.c                          |   2 -
 drivers/usb/mon/mon_bin.c                          |   8 +-
 drivers/usb/musb/musb_dsps.c                       |   2 +-
 drivers/usb/musb/musb_host.c                       |   1 +
 drivers/usb/renesas_usbhs/Kconfig                  |   1 +
 drivers/usb/renesas_usbhs/mod_gadget.c             |   1 +
 drivers/usb/serial/cp210x.c                        | 421 ++++++++++++---
 drivers/usb/serial/cyberjack.c                     |  17 +-
 drivers/usb/serial/digi_acceleport.c               |  35 +-
 drivers/usb/serial/io_edgeport.c                   |  17 +-
 drivers/usb/serial/io_ti.c                         |   5 +-
 drivers/usb/serial/ir-usb.c                        |   2 +-
 drivers/usb/serial/iuu_phoenix.c                   |   5 -
 drivers/usb/serial/kl5kusb105.c                    |   1 -
 drivers/usb/serial/kl5kusb105.h                    |   3 -
 drivers/usb/serial/kobil_sct.c                     |  24 +-
 drivers/usb/serial/mos7720.c                       |  14 +-
 drivers/usb/serial/mos7840.c                       |   5 +-
 drivers/usb/serial/option.c                        |   4 +
 drivers/usb/serial/pl2303.c                        |   2 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/quatech2.c                      |   7 +-
 drivers/usb/serial/sierra.c                        |  13 +-
 drivers/usb/serial/ssu100.c                        |   2 +-
 drivers/usb/serial/symbolserial.c                  |   5 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |   9 +-
 drivers/usb/serial/usb_wwan.c                      |   5 +-
 drivers/usb/typec/Kconfig                          |  18 +
 drivers/usb/typec/Makefile                         |   5 +-
 drivers/usb/typec/altmodes/Kconfig                 |  14 +
 drivers/usb/typec/altmodes/Makefile                |   2 +
 drivers/usb/typec/altmodes/displayport.c           | 580 +++++++++++++++++++++
 drivers/usb/typec/bus.c                            | 402 ++++++++++++++
 drivers/usb/typec/bus.h                            |  38 ++
 drivers/usb/typec/class.c                          | 544 +++++++++++++------
 drivers/usb/typec/fusb302/fusb302.c                |  12 -
 drivers/usb/typec/mux.c                            |   6 +-
 drivers/usb/typec/mux/pi3usb30532.c                |  13 +-
 drivers/{staging => usb}/typec/tcpci.c             |  66 ++-
 drivers/{staging => usb}/typec/tcpci.h             |   0
 drivers/{staging => usb}/typec/tcpci_rt1711h.c     |   0
 drivers/usb/typec/tcpm.c                           | 330 +++++++++---
 drivers/usb/typec/tps6598x.c                       |  11 +-
 drivers/usb/usb-skeleton.c                         |  10 +-
 drivers/usb/usbip/vudc_dev.c                       |   2 -
 drivers/usb/wusbcore/security.c                    |   2 +-
 drivers/usb/wusbcore/wa-xfer.c                     |   8 +-
 drivers/uwb/hwa-rc.c                               |   1 +
 include/dt-bindings/usb/pd.h                       |  62 +++
 include/linux/mod_devicetable.h                    |  15 +
 include/linux/usb/hcd.h                            |   1 +
 include/linux/usb/pd.h                             |   1 +
 include/linux/usb/tcpm.h                           |  11 +-
 include/linux/usb/typec.h                          |  55 +-
 include/linux/usb/typec_altmode.h                  | 160 ++++++
 include/linux/usb/typec_dp.h                       |  95 ++++
 include/linux/usb/typec_mux.h                      |   2 +-
 include/uapi/linux/usb/g_uvc.h                     |  39 ++
 include/uapi/linux/usb/tmc.h                       |  13 +
 scripts/mod/devicetable-offsets.c                  |   4 +
 scripts/mod/file2alias.c                           |  13 +
 .../selftests/drivers/usb/usbip/usbip_test.sh      |   2 -
 165 files changed, 5847 insertions(+), 1813 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-class-typec
 create mode 100644 Documentation/ABI/testing/sysfs-bus-typec
 create mode 100644 Documentation/ABI/testing/sysfs-driver-typec-displayport
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/typec-tcpci.txt
 create mode 100644 Documentation/driver-api/usb/typec_bus.rst
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-pcie.c
 create mode 100644 drivers/phy/renesas/phy-rcar-gen3-pcie.c
 delete mode 100644 drivers/staging/typec/Kconfig
 delete mode 100644 drivers/staging/typec/Makefile
 delete mode 100644 drivers/staging/typec/TODO
 create mode 100644 drivers/usb/dwc3/dwc3-haps.c
 create mode 100644 drivers/usb/host/ehci-npcm7xx.c
 create mode 100644 drivers/usb/typec/altmodes/Kconfig
 create mode 100644 drivers/usb/typec/altmodes/Makefile
 create mode 100644 drivers/usb/typec/altmodes/displayport.c
 create mode 100644 drivers/usb/typec/bus.c
 create mode 100644 drivers/usb/typec/bus.h
 rename drivers/{staging => usb}/typec/tcpci.c (92%)
 rename drivers/{staging => usb}/typec/tcpci.h (100%)
 rename drivers/{staging => usb}/typec/tcpci_rt1711h.c (100%)
 create mode 100644 include/dt-bindings/usb/pd.h
 create mode 100644 include/linux/usb/typec_altmode.h
 create mode 100644 include/linux/usb/typec_dp.h
 create mode 100644 include/uapi/linux/usb/g_uvc.h
