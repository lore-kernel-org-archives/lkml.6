Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40039C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BEF20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546011289;
	bh=+U82JrGHn0krwaLqKHOgMdstA2XAo8GnHlIGth9ifYc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2udf1knUw8ZU4vtRWOQhpfmfCjCL2EGVRhup4hwzBfCB60iQ9MEG7DwVBcno3DEus
	 3yTUL2j3BJXDRt8XLZ5TNfCZeUIIIR9cy6j/TZp5yLiUz4tovcws4qaMz1GhOgNTYf
	 a3uvGgp+//CPtZm9C9x/ugST3NfJ8zT0yFcfNoiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeL1Per (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:34:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeL1Peq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:34:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5923F20869;
        Fri, 28 Dec 2018 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546011284;
        bh=+U82JrGHn0krwaLqKHOgMdstA2XAo8GnHlIGth9ifYc=;
        h=Date:From:To:Cc:Subject:From;
        b=mMQA8NR2lAi9fLJh1pX4EbygkZ9+cwQpkz7/ApZnzns44prIUo5t+mpbtChrsk+Fl
         zFP0DFBvsxySJHHKPbrrOqeyBMRVBCz001uxOqIoxXnXeK5bJnyoL6rlBizzwb6AcI
         QXO9UuVLhCPxB2FXB2IRmy8jEDarhdop/9d9anwM=
Date:   Fri, 28 Dec 2018 16:34:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver patches for 4.21-rc1
Message-ID: <20181228153442.GA23402@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 177c459b08a34dcf004aa9a4c1f1d8be682ff3af:

  Merge tag 'usb-4.20-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2018-12-20 07:27:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.21-rc1

for you to fetch changes up to 4b2c01ad902ec02fa962b233decd2f14be3714ba:

  USB: serial: option: add Fibocom NL678 series (2018-12-21 16:47:02 +0100)

----------------------------------------------------------------
USB/PHY patches for 4.21-rc1

Here is the big set of USB and PHY driver patches for 4.21-rc1.

All of the usual bits are in here:
  - loads of USB gadget driver updates and additions
  - new device ids
  - phy driver updates
  - xhci reworks and new features
  - typec updates

Full details are in the shortlog.

All of these have been in linux-next for a long time with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Douglas (2):
      dt-bindings: phy: Document cadence Sierra PHY bindings
      phy: cadence: Add driver for Sierra PHY

Alexander Theissen (2):
      usb: appledisplay: Set urb transfer_flags to URB_NO_TRANSFER_DMA_MAP
      usb: appledisplay: Remove unnecessary spinlock

Andrzej Pietrasiewicz (1):
      usb: gadget: f_fs: Allow scatter-gather buffers

Andy Shevchenko (4):
      usb: dwc3: drd: Switch to device property for 'extcon' handling
      usb: dwc3: drd: Add support for DR detection through extcon
      staging: typec: fusb302: Rename fcs,extcon-name to linux,extcon-name
      usb: dwc3: trace: add missing break statement to make compiler happy

Anurag Kumar Vulisha (3):
      usb: dwc3: update stream id in depcmd
      usb: dwc3: don't issue no-op trb for stream capable endpoints
      usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()

Arnd Bergmann (1):
      usb: renesas_usbhs: mark PM functions as __maybe_unused

Artur Petrosyan (2):
      usb: dwc2: gadget: Fix WkupAlert interrupt handler.
      usb: dwc2: gadget: Accept LPM token when TxFIFO is not empty

Badhri Jagan Sridharan (3):
      dt-bindings: connector: Add self-powered property
      usb: typec: tcpm: Do not disconnect link for self powered devices
      usb: typec: tcpm: charge current handling for sink during hard reset

Bin Liu (2):
      usb: musb: dsps: fix otg state machine
      usb: musb: dsps: fix runtime pm for peripheral mode

Brian Norris (1):
      usb: dwc3: don't log probe deferrals; but do log other error codes

Chengguang Xu (1):
      usb: host: remove unnecessary condition check

Christoph Hellwig (1):
      USB: remove the unused struct hcd_timeout definition

Chunfeng Yun (10):
      usb: mtu3: remove QMU checksum
      usb: mtu3: enable hardware remote wakeup from L1 automatically
      usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)
      usb: mtu3: enable SETUPENDISR interrupt
      usb: mtu3: clear SOFTCONN when clear USB3_EN if work as HS mode
      usb: mtu3: remove QMU checksum
      usb: mtu3: enable hardware remote wakeup from L1 automatically
      usb: mtu3: fix the issue about SetFeature(U1/U2_Enable)
      usb: mtu3: enable SETUPENDISR interrupt
      usb: mtu3: clear SOFTCONN when clear USB3_EN if work as HS mode

Colin Ian King (5):
      uwb: clean an indentation issue, remove extraneous tab
      USB: gadget: udc: fix spelling mistake "intrerrupt" -> "interrupt"
      USB: ene_usb6250: add missing indentation
      drivers: usb: early: clean up indentation, remove extraneous tabs
      usb: gadget: udc: fix spelling mistake "intrerrupt" -> "interrupt"

Evan Green (4):
      dt-bindings: phy-qcom-qmp: Fix register underspecification
      phy: qcom-qmp: Utilize fully-specified DT registers
      dt-bindings: phy-qcom-qmp: Move #clock-cells to child
      phy: qcom-qmp: Expose provided clocks to DT

Fabrizio Castro (1):
      usb: renesas_usbhs: add support for RZ/G2E

Felipe Balbi (11):
      usb: dwc3: gadget: combine unaligned and zero flags
      usb: dwc3: gadget: track number of TRBs per request
      usb: dwc3: gadget: use num_trbs when skipping TRBs on ->dequeue()
      usb: dwc3: gadget: extract dwc3_gadget_ep_skip_trbs()
      usb: dwc3: gadget: introduce cancelled_list
      usb: dwc3: gadget: move requests to cancelled_list
      usb: dwc3: gadget: remove wait_end_transfer
      usb: dwc3: gadget: return errors from __dwc3_gadget_start_isoc()
      usb: dwc3: trace: log ep commands in hex
      usb: dwc3: gadget: remove unnecessary dev_info()
      usb: dwc3: gadget: check if dep->frame_number is still valid

Greg Kroah-Hartman (8):
      Merge 4.20-rc4 into usb-next
      Merge 4.20-rc5 into usb-next
      Merge 4.20-rc6 into usb-next
      Merge tag 'phy-for-4.21_v1' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge tag 'usb-for-v4.21' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge tag 'usb-ci-v4.21-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next
      Merge tag 'usb-serial-4.21-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge USB 4.20-rc8 mergepoint into usb-next

Grygorii Strashko (9):
      phy: core: rework phy_set_mode to accept phy mode and submode
      phy: core: add PHY_MODE_ETHERNET
      phy: ocelot-serdes: convert to use eth phy mode and submode
      phy: mvebu-cp110-comphy: convert to use eth phy mode and submode
      phy: core: clean up unused ethernet specific phy modes
      dt-bindings: phy: add cpsw port interface mode selection phy bindings
      phy: ti: introduce phy-gmii-sel driver
      dt-bindings: net: ti: cpsw: switch to use phy-gmii-sel phy
      net: ethernet: ti: cpsw: add support for port interface mode selection phy

Heikki Krogerus (2):
      usb: roles: Add a description for the class to Kconfig
      usb: typec: Improve Alt Mode documentation

Hsin-Yi, Wang (2):
      usb/mtu3: power down device ip at setup
      usb/mtu3: power down device ip at setup

Icenowy Zheng (3):
      dt-bindings: phy: add binding for Allwinner H6 USB2 PHY
      phy: sun4i-usb: add support for missing USB PHY index
      phy: sun4i-usb: add support for H6 USB2 PHY

JackyChou (2):
      USB: serial: mos7840: clean up register handling
      USB: serial: mos7840: add a product ID for the new product

Jarkko Nikula (1):
      usb: renesas_usbhs: Remove dummy runtime PM callbacks

Ji-Ze Hong (Peter Hong) (1):
      USB: serial: f81534: fix reading old/new IC config

Jia-Ju Bai (1):
      usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()

Julia Lawall (2):
      usb: gadget: aspeed-vhub: constify usb_gadget_ops structure
      usb: gadget: uvc: constify vb2_ops structure

Jörgen Storvist (1):
      USB: serial: option: add Fibocom NL678 series

Kyle Tso (1):
      usb: typec: tcpm: Extend the matching rules on PPS APDO selection

Li Jun (1):
      phy: add driver for Freescale i.MX8MQ USB3 PHY

Lucas Stach (1):
      dt-bindings: phy: add binding for Freescale i.MX8MQ USB3 PHY

Macpaul Lin (1):
      cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Marek Szyprowski (1):
      usb: dwc2: Disable power down feature on Samsung SoCs

Martin Blumenstingl (1):
      usb: dwc2: disable power_down on Amlogic devices

Mathias Nyman (8):
      usb: hub: delay hub autosuspend if USB3 port is still link training
      xhci: move bus_state structure under the xhci_hub structure.
      xhci: remove unused hcd_index()
      xhci: move usb3 speficic bits to own function in get_port_status call
      xhci: move usb2 speficic bits to own function in get_port_status call
      xhci: cleanup code that sets portstatus and portchange bits
      xhci: refactor U0 link state handling in get_port_status
      xhci: move usb2 get port status link resume handling to its own function

Maxime Ripard (4):
      phy: Add MIPI D-PHY mode
      phy: Add configuration interface
      phy: Add MIPI D-PHY configuration options
      phy: dphy: Add configuration helpers

Minas Harutyunyan (1):
      usb: dwc2: Fix disable all EP's on disconnect

Miquel Raynal (1):
      phy: mvebu-cp110-comphy: fix spelling in structure name

Nikolaj Fogh (1):
      USB: serial: ftdi_sio: use rounding when calculating baud rate divisors

Peter Chen (4):
      usb: chipidea: add flag for imx hsic implementation
      usb: chipidea: imx: add HSIC support
      usb: chipidea: host: override ehci->hub_control
      doc: usb: ci-hdrc-usb2: Add pinctrl properties for HSIC pin groups

Rob Herring (2):
      MAINTAINERS: Add Kishon as maintainer of PHY bindings
      phy: Use of_node_name_eq for node name comparisons

Roger Quadros (1):
      usb: ehci-omap: Fix deferred probe for phy handling

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Stephan Gerhold (1):
      Revert "usb: dwc3: pci: Use devm functions to get the phy GPIOs"

Suwan Kim (1):
      usb: core: Remove unnecessary memset()

Tejas Joglekar (1):
      usb: dwc3: gadget: Disable CSP for stream OUT ep

Terin Stock (1):
      usb: dwc2: host: use hrtimer for NAK retries

Thinh Nguyen (14):
      usb: dwc3: debugfs: Properly name Tx/RxFIFO
      usb: dwc3: debugfs: Print eps Tx/RxFIFO in bytes
      usb: dwc3: debugfs: Dump internal LSP and ep registers
      usb: dwc3: debugfs: Properly print/set link state for HS
      usb: dwc3: debugfs: Print/set link state for peripheral mode
      usb: dwc3: Set GUSB2PHYCFG.ENBLSLPM
      usb: dwc3: Add a property to disable USB2 LPM
      usb: dwc3: Support option to disable USB2 LPM
      usb: dwc3: Set default mode for DWC_usb3 v3.30a and higher
      usb: dwc3: Track DWC_usb31 VERSIONTYPE
      usb: dwc3: Add disabling of start_transfer failure quirk
      usb: dwc3: Add workaround for isoc start transfer failure
      usb: gadget: Introduce frame_number to usb_request
      usb: dwc3: gadget: Report isoc transfer frame number

Thiébaud Weksteen (1):
      Documentation/usb: Fix typo

Tony Lindgren (1):
      phy: mapphone-mdm6600: Improve phy related runtime PM calls

Uwe Kleine-König (3):
      usb: chipidea: imx: support configuring for active low oc signal
      usb: chipidea: imx: Warn if oc polarity isn't specified
      usb: chipidea: imx: allow to configure oc polarity on i.MX25

Vincent Pelletier (1):
      usb: gadget: f_fs: Add support for CCID descriptors.

Yangtao Li (2):
      USB: gadget: udc: s3c2410_udc: convert to DEFINE_SHOW_ATTRIBUTE
      usb: host: isp1362-hcd: convert to DEFINE_SHOW_ATTRIBUTE

Yoshihiro Shimoda (3):
      usb: gadget: udc: renesas_usb3: add a safety connection way for forced_b_device
      usb: renesas_usbhs: Use SIMPLE_DEV_PM_OPS macro
      phy: renesas: rcar-gen3-usb2: follow the hardware manual procedure

YueHaibing (4):
      USB: serial: quatech2: remove set but not used variable 'port_priv'
      USB: serial: mos7840: remove set but not used variables 'st, data1, iflag'
      usb: mtu3: fix dbginfo in qmu_tx_zlp_error_handler
      USB: serial: mos7840: remove set but not used variables 'number, serial'

Zeng Tao (1):
      xhci: remove the unused sw_lpm_support

kbuild test robot (1):
      phy: ti: fix semicolon.cocci warnings

 .../bindings/connector/usb-connector.txt           |   2 +
 Documentation/devicetree/bindings/net/cpsw.txt     |   8 +-
 .../devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt |  17 +
 .../devicetree/bindings/phy/phy-cadence-sierra.txt |  67 ++++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |  77 +++-
 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |   8 +-
 .../devicetree/bindings/phy/ti-phy-gmii-sel.txt    |  68 ++++
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |  36 +-
 Documentation/devicetree/bindings/usb/dwc3.txt     |   4 +
 Documentation/driver-api/usb/index.rst             |   1 +
 Documentation/driver-api/usb/typec.rst             |   1 +
 Documentation/driver-api/usb/typec_bus.rst         |  24 +-
 Documentation/usb/authorization.txt                |   2 +-
 MAINTAINERS                                        |   1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  19 +-
 drivers/net/ethernet/mscc/ocelot.c                 |   9 +-
 drivers/net/ethernet/ti/cpsw.c                     |  19 +-
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   2 +
 drivers/phy/allwinner/phy-sun4i-usb.c              |  29 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |   5 +-
 drivers/phy/amlogic/phy-meson-gxl-usb3.c           |   5 +-
 drivers/phy/cadence/Kconfig                        |   9 +-
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c           | 395 +++++++++++++++++++++
 drivers/phy/freescale/Kconfig                      |   5 +
 drivers/phy/freescale/Makefile                     |   1 +
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         | 127 +++++++
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c       |  97 ++---
 drivers/phy/mediatek/phy-mtk-tphy.c                |   2 +-
 drivers/phy/mediatek/phy-mtk-xsphy.c               |   2 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |  71 ++--
 drivers/phy/mscc/phy-ocelot-serdes.c               |  24 +-
 drivers/phy/phy-core-mipi-dphy.c                   | 166 +++++++++
 drivers/phy/phy-core.c                             |  70 +++-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  77 +++-
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c       |   3 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c       |   3 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c             |   3 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |  17 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   6 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          |   4 +-
 drivers/phy/ti/Kconfig                             |  10 +
 drivers/phy/ti/Makefile                            |   1 +
 drivers/phy/ti/phy-da8xx-usb.c                     |   3 +-
 drivers/phy/ti/phy-gmii-sel.c                      | 349 ++++++++++++++++++
 drivers/phy/ti/phy-tusb1210.c                      |   2 +-
 drivers/platform/x86/intel_cht_int33fe.c           |   2 +-
 drivers/usb/Kconfig                                |   4 -
 drivers/usb/chipidea/ci_hdrc_imx.c                 | 158 +++++++--
 drivers/usb/chipidea/ci_hdrc_imx.h                 |  17 +-
 drivers/usb/chipidea/host.c                        |  92 +++++
 drivers/usb/chipidea/usbmisc_imx.c                 | 183 +++++++++-
 drivers/usb/class/cdc-acm.c                        |  10 +
 drivers/usb/class/cdc-acm.h                        |   1 +
 drivers/usb/common/Makefile                        |   1 -
 drivers/usb/core/hcd.c                             |   2 -
 drivers/usb/core/hub.c                             |  10 +
 drivers/usb/dwc2/gadget.c                          |  44 ++-
 drivers/usb/dwc2/hcd.h                             |   2 +-
 drivers/usb/dwc2/hcd_queue.c                       |  19 +-
 drivers/usb/dwc2/hw.h                              |   2 +
 drivers/usb/dwc2/params.c                          |  11 +-
 drivers/usb/dwc3/core.c                            |  19 +-
 drivers/usb/dwc3/core.h                            |  60 +++-
 drivers/usb/dwc3/debug.h                           |  29 ++
 drivers/usb/dwc3/debugfs.c                         | 201 ++++++++++-
 drivers/usb/dwc3/drd.c                             |  15 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   8 +-
 drivers/usb/dwc3/gadget.c                          | 342 +++++++++++-------
 drivers/usb/dwc3/gadget.h                          |  15 +
 drivers/usb/dwc3/host.c                            |   5 +-
 drivers/usb/dwc3/trace.h                           |   4 +-
 drivers/usb/early/ehci-dbgp.c                      |  38 +-
 drivers/usb/gadget/function/f_fs.c                 | 122 ++++++-
 drivers/usb/gadget/function/uvc_queue.c            |   2 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c           |   2 +-
 drivers/usb/gadget/udc/pch_udc.c                   |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |  15 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |  17 +-
 drivers/usb/host/ehci-omap.c                       |   7 +-
 drivers/usb/host/isp1362-hcd.c                     |  16 +-
 drivers/usb/host/ohci-mem.c                        |  12 +-
 drivers/usb/host/r8a66597-hcd.c                    |   5 +-
 drivers/usb/host/xhci-hub.c                        | 351 ++++++++++--------
 drivers/usb/host/xhci-mem.c                        |  30 +-
 drivers/usb/host/xhci-ring.c                       |   2 +-
 drivers/usb/host/xhci.c                            |  22 +-
 drivers/usb/host/xhci.h                            |  13 +-
 drivers/usb/misc/appledisplay.c                    |   8 +-
 drivers/usb/mtu3/mtu3_core.c                       |  20 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |  14 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |   6 +
 drivers/usb/mtu3/mtu3_plat.c                       |   8 +
 drivers/usb/mtu3/mtu3_qmu.c                        |  28 +-
 drivers/usb/musb/musb_dsps.c                       |  21 +-
 drivers/usb/renesas_usbhs/common.c                 |  27 +-
 drivers/usb/roles/Kconfig                          |  13 +
 drivers/usb/roles/Makefile                         |   4 +-
 drivers/usb/{common/roles.c => roles/class.c}      |   0
 drivers/usb/serial/f81534.c                        |  20 +-
 drivers/usb/serial/ftdi_sio.c                      |   6 +-
 drivers/usb/serial/mos7840.c                       |  71 ++--
 drivers/usb/serial/option.c                        |   4 +
 drivers/usb/serial/pl2303.c                        |   5 +
 drivers/usb/serial/pl2303.h                        |   5 +
 drivers/usb/serial/quatech2.c                      |   3 -
 drivers/usb/storage/ene_ub6250.c                   |   2 +-
 drivers/usb/typec/tcpm/fusb302.c                   |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  56 ++-
 drivers/uwb/i1480/dfu/usb.c                        |   2 +-
 include/linux/phy/phy-mipi-dphy.h                  | 285 +++++++++++++++
 include/linux/phy/phy.h                            |  83 ++++-
 include/linux/usb/ccid.h                           |  51 +++
 include/linux/usb/chipidea.h                       |   3 +
 include/linux/usb/gadget.h                         |   4 +
 include/linux/usb/hcd.h                            |   5 -
 include/linux/usb/tcpm.h                           |   1 +
 119 files changed, 3695 insertions(+), 838 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
 create mode 100644 drivers/phy/cadence/phy-cadence-sierra.c
 create mode 100644 drivers/phy/freescale/Kconfig
 create mode 100644 drivers/phy/freescale/Makefile
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8mq-usb.c
 create mode 100644 drivers/phy/phy-core-mipi-dphy.c
 create mode 100644 drivers/phy/ti/phy-gmii-sel.c
 rename drivers/usb/{common/roles.c => roles/class.c} (100%)
 create mode 100644 include/linux/phy/phy-mipi-dphy.h
 create mode 100644 include/linux/usb/ccid.h
