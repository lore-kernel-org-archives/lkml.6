Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B2C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510812082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly6E0O6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510812082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJZSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeJZSiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:38:55 -0400
Received: from localhost (unknown [80.169.156.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5DA20848;
        Fri, 26 Oct 2018 10:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540548146;
        bh=LGq60uFI1x9o5hNZlGlq0YHY6GrAh01UVlXNSTbVQ7Y=;
        h=Date:From:To:Cc:Subject:From;
        b=Ly6E0O6F0CHGdEq53yfYlzk12Pv0rTbWJVZiDWpOkYrIDUotI/PsuKoIEYrBIfpGH
         8e8kwed6fpdTHWxt36Swh8Wz7/JC9nXZ4bV6AtlvRdM7vIAOgfnD3rqyn/NS65UU76
         h64k1ugfR2v0FbGhyTHkIOvAUrOJn0XEo1ArYh2I=
Date:   Fri, 26 Oct 2018 11:02:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver patches for 4.20-rc1
Message-ID: <20181026100224.GA13038@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.20-rc1

for you to fetch changes up to b8d9ee24493d862fbfeb3d209c032647f6073d5d:

  usb: phy: ab8500: silence some uninitialized variable warnings (2018-10-18 19:44:39 +0200)

----------------------------------------------------------------
USB/PHY patches for 4.20-rc1

Here is the big USB/PHY driver patches for 4.20-rc1

Lots of USB changes in here, primarily in these areas:
  - typec updates and new drivers
  - new PHY drivers
  - dwc2 driver updates and additions (this old core keeps getting added
    to new devices.)
  - usbtmc major update based on the industry group coming together and
    working to add new features and performance to the driver.
  - USB gadget additions for new features
  - USB gadget configfs updates
  - chipidea driver updates
  - other USB gadget updates
  - USB serial driver updates
  - renesas driver updates
  - xhci driver updates
  - other tiny USB driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Thomson (7):
      dt-bindings: connector: Add support for USB-PD PPS APDOs to bindings
      dt-bindings: usb: fusb302: Use usb-connector bindings for configuration
      usb: typec: fusb302: Populate tcpc fwnode for TCPM property handling
      usb: typec: fusb302: Correct spelling mistake for toggling state
      usb: typec: fusb302: Resolve fixed power role contract setup
      usb: typec: tcpm: Fix APDO PPS order checking to be based on voltage
      usb: typec: tcpm: Report back negotiated PPS voltage and current

Alan Stern (3):
      USB: OHCI: Remove USB bus reset delay from OHCI handover code
      USB: gadget core: Issue ->disconnect() callback from usb_gadget_disconnect()
      USB: net2280: Remove ->disconnect() callback from net2280_pullup()

Alexandre Belloni (1):
      usb: gadget: udc: atmel: handle at91sam9rl PMC

Andreas Kemnade (1):
      phy: phy-twl4030-usb: fix denied runtime access

Andreas Pape (1):
      usb: gadget: f_uac2: disable IN/OUT ep if unused

Andy Shevchenko (1):
      USB: wusbcore: Switch to bitmap_zalloc()

Anshuman Gupta (1):
      xhci: Avoid USB autosuspend when resuming USB2 ports.

Arnd Bergmann (1):
      usb: dwc3: add EXTCON dependency for qcom

Biju Das (2):
      dt-bindings: usb: renesas_usbhs: Add support for r8a7744
      dt-bindings: usb-xhci: Document r8a7744 support

Bjørn Mork (1):
      usb: export firmware port location in sysfs

Can Guo (4):
      phy: Update PHY power control sequence
      phy: General struct and field cleanup
      phy: Add QMP phy based UFS phy support for sdm845
      dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845

Chunfeng Yun (8):
      usb: mtu3: disable vbus rise/fall interrupts of ltssm
      usb: core: phy: clean up return value check about devm_of_phy_get_by_index()
      usb: xhci-mtk: use maximum ESIT payload of endpiont context
      usb: xhci-mtk: fix ISOC error when interval is zero
      usb: xhci-mtk: improve bandwidth scheduling
      usb: xhci-mtk: supports bandwidth scheduling with multi-TT
      usb: xhci-mtk: supports SSP without external USB3 gen2 hub
      usb: mtu3: disable vbus rise/fall interrupts of ltssm

Colin Ian King (8):
      USB: typec: fsusb302: remove unused variables snk_pdo and toggling_mode_name
      usb: phy: mxs: fix spelling mistake "stardard" -> "standard"
      USB: serial: cypress_m8: fix spelling mistake "retreiving" -> "retrieving"
      usb: gadget: fix spelling mistakeis "[En]queing" -> "[En]queuing"
      usb: phy: mxs: fix spelling mistake "stardard" -> "standard"
      usb: gadget: fix spelling mistakeis "[En]queing" -> "[En]queuing"
      usb: core: fix memory leak on port_dev_path allocation
      usbip: tools: fix atoi() on non-null terminated string

Corentin Labbe (1):
      usb: host: Replace empty define with do while

Dan Carpenter (1):
      usb: phy: ab8500: silence some uninitialized variable warnings

Ding Xiang (1):
      usb: misc: fix obsolete function

Douglas Anderson (3):
      dt-bindings: phy: qcom-qmp: Cleanup the 'reg' documentation as per review
      phy: qcom-qmp: Quiet -EPROBE_DEFER from qcom_qmp_phy_probe()
      phy: qcom-qusb2: Quiet -EPROBE_DEFER from qusb2_phy_probe()

Fabrice Gasnier (4):
      usb: dwc2: get optional vbus-supply regulator once
      usb: dwc2: fix a race with external vbus supply
      usb: dwc2: fix call to vbus supply exit routine, call it unlocked
      usb: dwc2: fix unbalanced use of external vbus-supply

Fabrizio Castro (6):
      dt-bindings: usb-xhci: Add r8a774a1 support
      dt-bindings: usb: renesas_usbhs: Add r8a774a1 support
      usb: gadget: udc: renesas_usb3: Add r8a774a1 support
      dt-bindings: rcar-gen3-phy-usb2: Add r8a774a1 support
      dt-bindings: rcar-gen3-phy-usb3: Add r8a774a1 support
      usb: gadget: udc: renesas_usb3: Add r8a774a1 support

Faisal Mehmood (1):
      usb: dwc3: Fix spelling of 'optimizations'

Felipe Balbi (1):
      Merge tag 'uvcg-20180925' of git://linuxtv.org/pinchartl/media into testing/next

Florian Fainelli (3):
      dt-bindings: phy: Document BCM63138 compatible string
      phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
      phy: brcm-sata: Add BCM63138 (DSL) PHY init sequence

Greg Kroah-Hartman (7):
      Merge 4.19-rc4 into usb-next
      Merge 4.19-rc6 into usb-next
      Merge tag 'phy-for-4.20' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge tag 'usb-for-v4.20' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge 4.19-rc7 into usb-next
      Merge tag 'usb-ci-v4.20-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-testing
      Merge tag 'usb-serial-4.20-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next

Grigor Tovmasyan (9):
      usb: dwc2: Update registers definitions to support service interval
      usb: dwc2: Add core parameter for service interval support
      usb: dwc2: Add dwc2_gadget_dec_frame_num_by_one() function
      usb: dwc2: Update target (u)frame calculation
      usb: dwc2: Add definitions for new registers
      usb: dwc2: gadget: Add parameters for GREFCLK register
      usb: dwc2: gadget: Program GREFCLK register
      usb: dwc2: gadget: enable WKUP_ALERT interrupt
      usb: dwc2: gadget: Add handler for WkupAlert interrupt

Guido Kiener (26):
      usb: usbtmc: Add ioctl for generic requests on control
      usb: usbtmc: Add ioctl for vendor specific write
      usb: usbtmc: Add ioctl USBTMC_IOCTL_WRITE_RESULT
      usb: usbtmc: Add ioctl for vendor specific read
      usb: usbtmc: Add ioctl USBTMC_IOCTL_CANCEL_IO
      usb: usbtmc: Add ioctl USBTMC_IOCTL_CLEANUP_IO
      usb: usbtmc: Fix suspend/resume
      usb: usbtmc: Add ioctl USBTMC488_IOCTL_WAIT_SRQ
      usb: usbtmc: add ioctl USBTMC_IOCTL_MSG_IN_ATTR
      usb: usbtmc: Add ioctl USBTMC_IOCTL_AUTO_ABORT
      usb: usbtmc: Optimize usbtmc_write
      usb: usbtmc: Optimize usbtmc_read
      usb: usbtmc: Fix ioctl USBTMC_IOCTL_CLEAR
      usb: usbtmc: Fix ioctl USBTMC_IOCTL_ABORT_BULK_IN
      usb: usbtmc: Fix ioctl USBTMC_IOCTL_ABORT_BULK_OUT
      usb: usbtmc: Replace USBTMC_TIMEOUT macros for control messages
      usb: usbtmc: Add ioctl USBTMC_IOCTL_API_VERSION
      usb: usbtmc: Update ioctl-number.txt
      usb: usbtmc: Remove redundant code
      usb: usbtmc: Remove redundant macro USBTMC_SIZE_IOBUFFER
      usb: usbtmc: Fix split quoted string in debug message
      usb: usbtmc: Remove sysfs group TermChar and auto_abort
      usb: usbtmc: Fix memory leak in usbtmc_ioctl_request
      usb: usbtmc: uninitialized symbol 'actual' in usbtmc_read
      usb: usbtmc: uninitialized symbol 'actual' in usbtmc_ioctl_clear
      usb: usbtmc: uninitialized symbol 'actual' in usbtmc_ioctl_abort_bulk_in_tag

Gustavo A. R. Silva (1):
      usb: iowarrior: replace kmalloc with kmalloc_array

Hans Ulli Kroll (1):
      usb: host: add DT bindings for faraday fotg2

Hauke Mehrtens (1):
      phy: lantiq: Fix compile warning

Heikki Krogerus (9):
      platform: x86: intel_cht_int33fe: Add dependency on muxes
      drivers: base: Helpers for adding device connection descriptions
      platform: x86: intel_cht_int33fe: Register all connections at once
      platform: x86: intel_cht_int33fe: Add connection for the DP alt mode
      platform: x86: intel_cht_int33fe: Add connections for the USB Type-C port
      usb: typec: class: Don't use port parent for getting mux handles
      platform: x86: intel_cht_int33fe: Remove the old connections for the muxes
      usb: typec: fusb302: reorganizing the probe function a little
      usb: typec: Group all TCPCI/TCPM code together

Heiko Stuebner (1):
      phy: rockchip-usb: add usb-uart setup for rk3188

Jagdish Tirumala (1):
      USB: STORAGE: ISD200 Fixed coding style issue "space required in for loop"

Jia-Ju Bai (1):
      usb: gadget: udc: fotg210-udc: Fix a sleep-in-atomic-context bug in fotg210_get_status()

Joel Pepper (2):
      usb: gadget: uvc: configfs: Add bFrameIndex attributes
      usb: gadget: uvc: configfs: Prevent format changes after linking header

Johan Hovold (3):
      USB: serial: ftdi_sio: fix gpio name collisions
      USB: serial: ftdi_sio: add support for FT232R CBUS gpios
      USB: serial: cypress_m8: fix interrupt-out transfer length

Jon Flatley (1):
      usb: core: added uevent for over-current

Jon Hunter (2):
      usb: xhci: tegra: Power-off power-domains on removal
      usb: xhci: tegra: Add genpd support

Josh Abraham (1):
      usb: dwc2: remove set but unused variable

Karoly Pados (1):
      USB: serial: ftdi_sio: implement GPIO support for FT-X devices

Kunihiko Hayashi (6):
      dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
      phy: socionext: add USB3 PHY driver for UniPhier SoC
      dt-bindings: phy: add DT bindings for UniPhier USB2 PHY driver
      phy: socionext: add USB2 PHY driver for UniPhier SoC
      dt-bindings: phy: add UniPhier PCIe PHY description
      phy: socionext: add PCIe PHY driver support

Kuninori Morimoto (2):
      usb: ehci-sh: convert to SPDX identifiers
      phy: renesas: convert to SPDX identifiers

Laurent Pinchart (14):
      usb: gadget: uvc: configfs: Don't wrap groups unnecessarily
      usb: gadget: uvc: configfs: Add section header comments
      usb: gadget: uvc: configfs: Drop leaked references to config items
      usb: gadget: uvc: configfs: Allocate groups dynamically
      usb: gadget: uvc: configfs: Add interface number attributes
      usb: gadget: uvc: configfs: Add bFormatIndex attributes
      usb: gadget: uvc: Factor out video USB request queueing
      usb: gadget: uvc: Only halt video streaming endpoint in bulk mode
      usb: gadget: uvc: Replace plain printk() with dev_*()
      usb: gadget: uvc: Remove uvc_set_trace_param() function
      usb: video: Fix endianness mismatches in descriptor structures
      usb: gadget: uvc: configfs: Fix operation on big endian platforms
      usb: gadget: uvc: configfs: Simplify attributes macros
      usb: gadget: uvc: configfs: Use %u to print unsigned int values

Linus Walleij (2):
      usb: host: fotg2: add silicon clock handling
      usb: host: fotg2: Fix potential NULL dereference

Loic Poulain (4):
      usb: chipidea: Add dynamic pinctrl selection
      doc: usb: ci-hdrc-usb2: Add pinctrl properties definition
      usb: chipidea: Prevent unbalanced IRQ disable
      usb: chipidea: Fix otg event handler

Lubomir Rintel (6):
      USB: EHCI: make ehci-mv a separate driver
      USB: EHCI: ehci-mv: remove private_init
      USB: EHCI: ehci-mv: use phy-pxa-usb
      USB: EHCI: ehci-mv: add DT support
      dt-bindings: ehci-mv: add bindings
      phy: phy-pxa-usb: add a new driver

Maciej Żenczykowski (1):
      usbip: fix vhci_hcd controller counting

Marcus Folkesson (2):
      usb: chipidea: imx: do not use preprocessor conditionals for PM
      usb: chipidea: imx: make MODULE_LICENCE and SPDX-identifier match

Marek Szyprowski (3):
      usb: dwc3: exynos: Remove dead code
      usb: dwc3: exynos: Rework clock handling and prepare for new variants
      usb: dwc3: exynos: Add support for Exynos5433 variant with all clocks

Mathias Nyman (2):
      xhci: Use soft retry to recover faster from transaction errors
      xhci-pci: allow host runtime PM as default for Intel Alpine and Titan Ridge

Mattias Jacobsson (1):
      USB: misc: appledisplay: fix backlight update_status return code

Minas Harutyunyan (1):
      usb: dwc2: Disable all EP's on disconnect

Nathan Chancellor (1):
      usb: gadget: udc: Remove unnecessary parentheses

Nicholas Mc Guire (2):
      usb: gadget: fsl_udc_core: check allocation return value and cleanup on failure
      usb: gadget: fsl_udc_core: fixup struct_udc_setup documentation

Nicolas Adell (1):
      usb: chipidea: imx: enable OTG overcurrent in case USB subsystem is already started

Paul Elder (1):
      usb: gadget: uvc: configfs: Sort frame intervals upon writing

Peter Chen (1):
      usb: host: xhci-plat: add platform TPL support

Rob Herring (2):
      phy: Convert to using %pOFn instead of device_node.name
      usb: gadget: atmel: remove pointless retrieval of DT name property

Salil Kapur (1):
      USB: Removing NULL check for pool since dma_pool_destroy is safe

Saranya Gopal (1):
      usbcore: Select UAC3 configuration for audio if present

Scott Telford (2):
      dt-bindings: phy: Document Cadence MHDP DisplayPort PHY bindings
      phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY

Sebastian Andrzej Siewior (4):
      media: em28xx-audio: use irqsave() in USB's complete callback
      media: tm6000: use irqsave() in USB's complete callback
      usb: core: remove local_irq_save() around ->complete() handler
      usb: core: remove flags variable in __usb_hcd_giveback_urb()

Shuah Khan (Samsung OSG) (1):
      usbip:vudc: BUG kmalloc-2048 (Not tainted): Poison overwritten

SolidHal (1):
      usb: dwc2: disable power_down on rockchip devices

Stephen Boyd (1):
      usb: typec: Fix copy/paste on typec_set_vconn_role() kerneldoc

Thierry Reding (1):
      usb: xhci: tegra: Firmware header is little endian

Thinh Nguyen (1):
      usb: dwc3: gadget: Check ENBLSLPM before sending ep command

Tudor.Ambarus@microchip.com (1):
      usb: host: ohci-at91: fix request of irq for optional gpio

Vivek Gautam (3):
      phy: qcom-ufs: Remove stale methods that handle ref clk
      scsi/ufs: qcom: Remove ufs_qcom_phy_*() calls from host
      phy: qcom-ufs: Declare 20nm qcom ufs qmp phy as Broken

Vladimir Zapolskiy (2):
      usb storage: group dependent USB storage Kconfig entries together
      usb storage: remove inherited SCSI dependency for USB_STORAGE_ENE_UB6250

Wolfram Sang (1):
      phy: renesas: use SPDX identifier for Renesas drivers

Yoshihiro Shimoda (29):
      dt-bindings: usb: ehci: Add clocks description for R-Car Gen3
      dt-bindings: usb: ohci: Add clocks description for R-Car Gen3
      usb: renesas_usbhs: Add reset_control
      dt-bindings: usb: renesas_usbhs: add clock-names property
      usb: renesas_usbhs: Add multiple clocks management
      dt-bindings: rcar-gen3-phy-usb2: add no-otg-pins property
      phy: renesas: rcar-gen3-usb2: fix vbus_ctrl for role sysfs
      phy: renesas: rcar-gen3-usb2: Rename has_otg_pins to uses_otg_pins
      phy: renesas: rcar-gen3-usb2: Check a property to use otg pins
      phy: renesas: rcar-gen3-usb2: unify OBINTEN handling
      phy: renesas: rcar-gen3-usb2: change a condition "dr_mode"
      phy: renesas: rcar-gen3-usb2: add conditions for uses_otg_pins == false
      phy: renesas: rcar-gen3-usb2: add is_otg_channel to use "role" sysfs
      Revert "usb: renesas_usbhs: add extcon notifier to set mode for non-otg channel"
      Revert "usb: renesas_usbhs: set the mode by using extcon state for non-otg channel"
      usb: renesas_usbhs: rcar3: Use OTG mode for R-Car D3
      dt-bindings: usb: renesas_usbhs: add bindings for r8a77990
      usb: renesas_usbhs: add support for R-Car E3
      Revert "usb: renesas_usbhs: add extcon notifier to set mode for non-otg channel"
      usb: renesas_usbhs: Add reset_control
      dt-bindings: usb: renesas_usbhs: add clock-names property
      usb: renesas_usbhs: Add multiple clocks management
      Revert "usb: renesas_usbhs: set the mode by using extcon state for non-otg channel"
      usb: renesas_usbhs: rcar3: Use OTG mode for R-Car D3
      dt-bindings: usb: renesas_usbhs: add bindings for r8a77990
      usb: renesas_usbhs: add support for R-Car E3
      usb: gadget: udc: renesas_usb3: Fix b-device mode for "workaround"
      dt-bindings: usb: renesas_usb3: add bindings for r8a77990
      usb: gadget: udc: renesas_usb3: add support for r8a77990

YueHaibing (4):
      usb: typec: remove set but not used variables 'snk_ma, min_mv'
      USB: serial: cypress_m8: remove set but not used variable 'iflag'
      USB: core: remove set but not used variable 'udev'
      usb/early: remove set but not used variable 'remain_length'

Zeng Tao (1):
      usb: hub: try old enumeration scheme first for high speed devices

Zheng Yang (2):
      dt-bindings: add binding for Rockchip hdmi phy using an Innosilicon IP
      phy: add Rockchip Innosilicon hdmi phy

zhong jiang (2):
      phy:phy-brcm-usb: Use PTR_ERR_OR_ZERO to replace the open coded version
      phy:phy-lantiq-rcu-usb2: Use PTR_ERR_OR_ZERO to replace the open coded version

 Documentation/ABI/stable/sysfs-driver-usb-usbtmc   |   35 -
 Documentation/ABI/testing/configfs-usb-gadget-uvc  |   24 +
 Documentation/ABI/testing/sysfs-bus-usb            |   19 +-
 Documentation/admin-guide/kernel-parameters.txt    |    3 +-
 .../bindings/connector/usb-connector.txt           |    8 +-
 .../devicetree/bindings/phy/brcm-sata-phy.txt      |    1 +
 .../devicetree/bindings/phy/phy-cadence-dp.txt     |   30 +
 .../bindings/phy/phy-rockchip-inno-hdmi.txt        |   43 +
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   23 +-
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |   11 +-
 .../devicetree/bindings/phy/rcar-gen3-phy-usb3.txt |   10 +-
 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  |   31 +
 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  |   45 +
 .../bindings/phy/uniphier-usb3-hsphy.txt           |   69 +
 .../bindings/phy/uniphier-usb3-ssphy.txt           |   57 +
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |    2 +
 Documentation/devicetree/bindings/usb/dwc3.txt     |    1 +
 Documentation/devicetree/bindings/usb/ehci-mv.txt  |   23 +
 .../devicetree/bindings/usb/exynos-usb.txt         |    2 +
 .../devicetree/bindings/usb/faraday,fotg210.txt    |   35 +
 .../devicetree/bindings/usb/fcs,fusb302.txt        |   32 +-
 .../devicetree/bindings/usb/renesas_usb3.txt       |    6 +-
 .../devicetree/bindings/usb/renesas_usbhs.txt      |   11 +-
 Documentation/devicetree/bindings/usb/usb-ehci.txt |    6 +-
 Documentation/devicetree/bindings/usb/usb-ohci.txt |    6 +-
 Documentation/devicetree/bindings/usb/usb-xhci.txt |    5 +-
 Documentation/ioctl/ioctl-number.txt               |    2 +-
 MAINTAINERS                                        |    6 +
 arch/arm/mach-mmp/devices.c                        |   11 +-
 drivers/media/usb/em28xx/em28xx-audio.c            |    5 +-
 drivers/media/usb/em28xx/em28xx-core.c             |    5 +-
 drivers/media/usb/tm6000/tm6000-video.c            |    5 +-
 drivers/phy/Kconfig                                |    2 +
 drivers/phy/Makefile                               |    2 +
 drivers/phy/broadcom/Kconfig                       |    3 +-
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c         |    4 +-
 drivers/phy/broadcom/phy-brcm-sata.c               |   74 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |    4 +-
 drivers/phy/cadence/Kconfig                        |   10 +
 drivers/phy/cadence/Makefile                       |    1 +
 drivers/phy/cadence/phy-cadence-dp.c               |  541 +++++++
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           |    5 +-
 drivers/phy/marvell/Kconfig                        |   11 +
 drivers/phy/marvell/Makefile                       |    1 +
 drivers/phy/marvell/phy-berlin-sata.c              |    6 +-
 drivers/phy/marvell/phy-pxa-usb.c                  |  345 +++++
 drivers/phy/qualcomm/Kconfig                       |   17 +
 drivers/phy/qualcomm/Makefile                      |    4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  222 ++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   15 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |    4 +-
 drivers/phy/qualcomm/phy-qcom-ufs-i.h              |    2 +-
 drivers/phy/qualcomm/phy-qcom-ufs.c                |   50 -
 drivers/phy/renesas/Kconfig                        |    1 +
 drivers/phy/renesas/Makefile                       |    1 +
 drivers/phy/renesas/phy-rcar-gen2.c                |    5 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   86 +-
 drivers/phy/renesas/phy-rcar-gen3-usb3.c           |    5 +-
 drivers/phy/rockchip/Kconfig                       |    8 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-emmc.c           |    4 +-
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c      | 1277 ++++++++++++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    8 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          |    8 +-
 drivers/phy/rockchip/phy-rockchip-usb.c            |  145 +-
 drivers/phy/socionext/Kconfig                      |   34 +
 drivers/phy/socionext/Makefile                     |    8 +
 drivers/phy/socionext/phy-uniphier-pcie.c          |  240 +++
 drivers/phy/socionext/phy-uniphier-usb2.c          |  244 +++
 drivers/phy/socionext/phy-uniphier-usb3hs.c        |  422 ++++++
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |  349 +++++
 drivers/phy/tegra/xusb.c                           |    4 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |   29 +
 drivers/platform/x86/Kconfig                       |    2 +
 drivers/platform/x86/intel_cht_int33fe.c           |   27 +-
 drivers/scsi/ufs/ufs-qcom.c                        |   28 +-
 drivers/scsi/ufs/ufs-qcom.h                        |    5 -
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   19 +-
 drivers/usb/chipidea/core.c                        |   19 +
 drivers/usb/chipidea/host.c                        |    9 +
 drivers/usb/chipidea/otg.c                         |    9 +-
 drivers/usb/chipidea/otg.h                         |    3 +-
 drivers/usb/chipidea/udc.c                         |    9 +
 drivers/usb/chipidea/usbmisc_imx.c                 |    4 +-
 drivers/usb/class/usbtmc.c                         | 1585 +++++++++++++++-----
 drivers/usb/core/buffer.c                          |    8 +-
 drivers/usb/core/driver.c                          |    3 -
 drivers/usb/core/generic.c                         |   27 +
 drivers/usb/core/hcd.c                             |   14 -
 drivers/usb/core/hub.c                             |   42 +-
 drivers/usb/core/phy.c                             |    7 +-
 drivers/usb/core/port.c                            |   10 +
 drivers/usb/dwc2/core.h                            |   29 +
 drivers/usb/dwc2/debugfs.c                         |    1 +
 drivers/usb/dwc2/gadget.c                          |  121 +-
 drivers/usb/dwc2/hcd.c                             |   48 +-
 drivers/usb/dwc2/hw.h                              |   15 +
 drivers/usb/dwc2/params.c                          |    7 +
 drivers/usb/dwc2/platform.c                        |    8 +
 drivers/usb/dwc3/Kconfig                           |    2 +-
 drivers/usb/dwc3/core.c                            |    2 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |  212 ++-
 drivers/usb/dwc3/gadget.c                          |   29 +-
 drivers/usb/early/xhci-dbc.c                       |    3 -
 drivers/usb/gadget/function/f_uac2.c               |  216 ++-
 drivers/usb/gadget/function/f_uvc.c                |   57 +-
 drivers/usb/gadget/function/u_uvc.h                |    3 +
 drivers/usb/gadget/function/uvc.h                  |   16 +-
 drivers/usb/gadget/function/uvc_configfs.c         | 1168 +++++++++------
 drivers/usb/gadget/function/uvc_v4l2.c             |    4 +-
 drivers/usb/gadget/function/uvc_video.c            |   48 +-
 drivers/usb/gadget/function/uvc_video.h            |    2 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |    2 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |    8 +-
 drivers/usb/gadget/udc/core.c                      |    9 +-
 drivers/usb/gadget/udc/fotg210-udc.c               |    2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |   36 +-
 drivers/usb/gadget/udc/mv_udc_core.c               |    2 +-
 drivers/usb/gadget/udc/net2280.c                   |    3 -
 drivers/usb/gadget/udc/renesas_usb3.c              |   14 +
 drivers/usb/gadget/udc/udc-xilinx.c                |    2 +-
 drivers/usb/host/Kconfig                           |    2 +-
 drivers/usb/host/Makefile                          |    1 +
 drivers/usb/host/ehci-hcd.c                        |   11 +-
 drivers/usb/host/ehci-mv.c                         |  181 ++-
 drivers/usb/host/ehci-q.c                          |    4 +-
 drivers/usb/host/ehci-timer.c                      |    2 +-
 drivers/usb/host/ehci.h                            |    4 +-
 drivers/usb/host/fotg210-hcd.c                     |   50 +-
 drivers/usb/host/fotg210.h                         |    7 +-
 drivers/usb/host/ohci-at91.c                       |    2 +
 drivers/usb/host/pci-quirks.c                      |   12 +-
 drivers/usb/host/xhci-hub.c                        |    5 +
 drivers/usb/host/xhci-mtk-sch.c                    |  429 +++++-
 drivers/usb/host/xhci-mtk.h                        |   23 +
 drivers/usb/host/xhci-pci.c                        |   24 +
 drivers/usb/host/xhci-plat.c                       |    3 +
 drivers/usb/host/xhci-ring.c                       |   20 +
 drivers/usb/host/xhci-tegra.c                      |  144 +-
 drivers/usb/host/xhci.h                            |    3 +
 drivers/usb/misc/appledisplay.c                    |    7 +-
 drivers/usb/misc/iowarrior.c                       |    4 +-
 drivers/usb/misc/trancevibrator.c                  |    4 +-
 drivers/usb/mtu3/mtu3_core.c                       |    4 +-
 drivers/usb/mtu3/mtu3_gadget.c                     |   22 +-
 drivers/usb/phy/phy-ab8500-usb.c                   |    8 +-
 drivers/usb/phy/phy-mxs-usb.c                      |    2 +-
 drivers/usb/renesas_usbhs/common.c                 |  113 +-
 drivers/usb/renesas_usbhs/common.h                 |    5 +-
 drivers/usb/renesas_usbhs/rcar3.c                  |   27 +-
 drivers/usb/serial/cypress_m8.c                    |    7 +-
 drivers/usb/serial/ftdi_sio.c                      |  391 ++++-
 drivers/usb/serial/ftdi_sio.h                      |   28 +-
 drivers/usb/storage/Kconfig                        |   23 +-
 drivers/usb/storage/isd200.c                       |    2 +-
 drivers/usb/typec/Kconfig                          |   45 +-
 drivers/usb/typec/Makefile                         |    6 +-
 drivers/usb/typec/class.c                          |   40 +-
 drivers/usb/typec/fusb302/Kconfig                  |    7 -
 drivers/usb/typec/fusb302/Makefile                 |    2 -
 drivers/usb/typec/tcpm/Kconfig                     |   52 +
 drivers/usb/typec/tcpm/Makefile                    |    7 +
 drivers/usb/typec/{fusb302 => tcpm}/fusb302.c      |   75 +-
 drivers/usb/typec/{fusb302 => tcpm}/fusb302_reg.h  |    0
 drivers/usb/typec/{ => tcpm}/tcpci.c               |    0
 drivers/usb/typec/{ => tcpm}/tcpci.h               |    0
 drivers/usb/typec/{ => tcpm}/tcpci_rt1711h.c       |    0
 drivers/usb/typec/{ => tcpm}/tcpm.c                |   17 +-
 drivers/usb/typec/{typec_wcove.c => tcpm/wcove.c}  |    0
 drivers/usb/usbip/vudc_main.c                      |   10 +-
 drivers/usb/wusbcore/wa-rpipe.c                    |    6 +-
 include/dt-bindings/usb/pd.h                       |   26 +
 include/linux/device.h                             |   24 +
 include/linux/phy/phy-qcom-ufs.h                   |   38 -
 include/linux/platform_data/ehci-sh.h              |   16 +-
 include/linux/platform_data/mv_usb.h               |    1 -
 include/linux/usb/chipidea.h                       |    6 +
 include/uapi/linux/usb/tmc.h                       |   41 +
 include/uapi/linux/usb/video.h                     |  304 ++--
 tools/usb/usbip/libsrc/usbip_host_common.c         |    6 +-
 tools/usb/usbip/libsrc/vhci_driver.c               |    2 +-
 181 files changed, 8788 insertions(+), 2190 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ehci-mv.txt
 create mode 100644 Documentation/devicetree/bindings/usb/faraday,fotg210.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/marvell/phy-pxa-usb.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-pcie.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb2.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c
 delete mode 100644 drivers/usb/typec/fusb302/Kconfig
 delete mode 100644 drivers/usb/typec/fusb302/Makefile
 create mode 100644 drivers/usb/typec/tcpm/Kconfig
 create mode 100644 drivers/usb/typec/tcpm/Makefile
 rename drivers/usb/typec/{fusb302 => tcpm}/fusb302.c (98%)
 rename drivers/usb/typec/{fusb302 => tcpm}/fusb302_reg.h (100%)
 rename drivers/usb/typec/{ => tcpm}/tcpci.c (100%)
 rename drivers/usb/typec/{ => tcpm}/tcpci.h (100%)
 rename drivers/usb/typec/{ => tcpm}/tcpci_rt1711h.c (100%)
 rename drivers/usb/typec/{ => tcpm}/tcpm.c (99%)
 rename drivers/usb/typec/{typec_wcove.c => tcpm/wcove.c} (100%)
 delete mode 100644 include/linux/phy/phy-qcom-ufs.h
