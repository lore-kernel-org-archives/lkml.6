Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3457164-1517483240-2-4993519817715827252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517483239; b=mvoTChHNZxEfB+4GMZnRdN3/jFMNOTD+RRBzAw7d4Wb1rX0
    G9rJN0RJYH4vq4U6zd7sX2ZCU+QKnIggfjrhJaiskd8yq/o6XsNc88wXbotMPEkA
    YvAueS2kqKp4hDoGpn7+Tw3sDou4/4M2F5Mnt/X/O2hOvuVyG/fiXDumTwTiWCPG
    ygeVLtI2I9u5vPoaLp1RxS8PqMGiWko8t9LtuBLQLMaC4JNzX+zg5tAzNl7IIQZS
    vwCuMYEP501pm8bHCr+lJtdV8B8oapQNCWHQ6AEA/0sq0eKrXHHy6q8pOnXp55Wm
    flyQlVfUPJ0QIrG9C2glvqSkMqq+Z6TI4NG2V6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1517483239; bh=Z5Fc+0ihEJKl1zHFM1FpUkovFn
    ucIX3UJBbYPfEv+3Q=; b=B7bdraxp1ArGMpz/Xpqomlb3tRiziZl+gcT9Ms10ch
    ZJMW3/C8T1vrPkfWLpvMLGLoJadHIxR8ubQ+nkYaLktURmnnrCB9xlwBiyMpdrRb
    zjP6z+cB60uzu4j1gTNR5w34MGcfV5ZT1NVhaa0emmn76uZhy1ldRJdEyKTTftv/
    ucWaMRW9CbpY53UJ5PuuBDx9RcuXfJCcO4GexgzfTYiZDf9pnP2rwUnMumpKEYFM
    COD+lD/z7ZB2D99nDzFwMNpn81VqcG8Nk7/oaattsnZN9eSo6M3pMNLI8CB5bMow
    hADH0hq1wKSbirV6O4RdoG6Yirch7bhkncg7Zs1xEqyA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeBALHA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 06:07:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeBALGz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Feb 2018 06:06:55 -0500
Date: Thu, 1 Feb 2018 12:06:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY updates for 4.16-rc1
Message-ID: <20180201110651.GA28445@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit a8750ddca918032d6349adbf9a4b6555e7db20da:

  Linux 4.15-rc8 (2018-01-14 15:32:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.16-rc1

for you to fetch changes up to d08dd3f3dd2ae351b793fc5b76abdbf0fd317b12:

  USB: serial: pl2303: new device id for Chilitag (2018-01-25 10:39:59 +0100)

----------------------------------------------------------------
USB/PHY updates for 4.16-rc1

Here is the big USB and PHY driver update for 4.16-rc1.

Along with the normally expected XHCI, MUSB, and Gadget driver patches,
there are some PHY driver fixes, license cleanups, sysfs attribute
cleanups, usbip changes, and a raft of other smaller fixes and
additions.

Full details are in the shortlog.

All of these have been in the linux-next tree for a long time with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Thomson (1):
      typec: tcpm: fusb302: Resolve out of order messaging events

Adam Wallis (1):
      usb: xhci: allow imod-interval to be configurable

Al Cooper (4):
      phy: phy-brcm-usb: Fix two DT properties to match bindings doc
      phy: phy-brcm-usb-init: Some Low Speed keyboards fail on 7271
      phy: phy-brcm-usb-init: Power down USB 3.0 PHY when XHCI disabled
      phy: phy-brcm-usb-init: DRD mode can cause crash on startup

Alan Stern (1):
      USB: remove the URB_NO_FSBR flag

Andy Shevchenko (1):
      uwb: Replace mac address parsing

Arnd Bergmann (1):
      usb: mtu3: fix ssusb_wakeup_set dummy

Badhri Jagan Sridharan (2):
      typec: tcpm: Validate source and sink caps
      typec: tcpm: Only request matching pdos

Baolin Wang (1):
      usb: phy: Factor out the usb charger initialization

Benjamin Herrenschmidt (2):
      usb: uhci: Add clk support to uhci-platform
      usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()

Chris Brandt (3):
      usb: renesas_usbhs: Add support for RZ/A1
      dt-bindings: usb: renesas_usbhs: Add support for RZ/A1
      ARM: dts: r7s72100: add USB device to device tree

Chunfeng Yun (9):
      phy: phy-mtk-tphy: use auto instead of force to bypass utmi signals
      phy: phy-mtk-tphy: make shared banks optional for V1 TPHY
      phy: phy-mtk-tphy: use of_device_get_match_data()
      usb: mtu3: fix error code for getting extcon device
      usb: mtu3: supports remote wakeup for mt2712 with two SSUSB IPs
      dt-bindings: usb: mtu3: update USB wakeup properties
      usb: xhci-mtk: supports remote wakeup for mt2712 with two xHCI IPs
      dt-bindings: usb: mtk-xhci: update USB wakeup properties
      arm64: dts: mt8173: update properties about USB wakeup

Colin Ian King (10):
      USB: serial: iuu_phoenix: remove redundant assignment of DIV to itself
      USB: host: whci: remove redundant variable t
      USB: usbip: fix spelling mistake: "synchronuously" -> "synchronously"
      USB: gadget: udc: fix spelling mistake "unexpect" -> "unexpected"
      USB: gadget: legacy: remove redundant zero assignment to variable 'value'
      usb: gadget: udc-xilinx: remove redundant pointer udc
      usb: gadget: pxa27x: Remove redundant assignment to is_short and dev
      usb: xhci: make function xhci_dbc_free_req static
      usbip: vhci: fix spelling mistake: "synchronuously" -> "synchronously"
      USB: serial: remove redundant initializations of 'mos_parport'

Corentin Labbe (6):
      usb: xhci: remove unused variable last_freed_endpoint
      usb: xhci: remove unused variable ep
      usb: xhci: remove unused variable urb_priv
      usb: xhci: remove unused variable ep_ring
      usb: musb: remove unused frame variable
      usb: musb: remove unused pipe variable

David Lechner (3):
      USB: musb: da8xx: remove clock con_id
      USB: ohci: da8xx: remove clk con_id
      ARM: da8xx: remove con_id from USB clocks

Dinh Nguyen (1):
      usb: dwc2: add optional usb ecc reset bit

Dmitry Osipenko (1):
      usb: chipidea: tegra: Use aligned DMA on Tegra30

Douglas Anderson (1):
      usb: dwc2: host: Don't retry NAKed transactions right away

Elad Wexler (2):
      tools: usb: usbip_device_driver: prefer 'unsigned int' to 'unsigned'
      tools: usb: usbip: fix fd leak in case of 'fread' failure

Fabio Estevam (1):
      doc: usb: chipidea: Fix typo in 'enumerate'

Fabrizio Castro (1):
      dt-bindings: usb-xhci: Document r8a7743 support

Felipe Balbi (4):
      usb: dwc3: debug: decode a few more features
      usb: gadget: add isoch_delay member
      usb: dwc3: ep0: use gadget->isoch_delay for isoch_delay value
      usb: core: add support for USB_REQ_SET_ISOCH_DELAY

Fengguang Wu (2):
      usb: mtu3: fix semicolon.cocci warnings
      usb: xhci-mtk: fix semicolon.cocci warnings

Gimcuan Hui (1):
      USB: serial: ark3116: clean up return values of register accessors

Greg Kroah-Hartman (17):
      Merge 4.15-rc4 into usb-next
      Merge 4.15.0-rc6 into usb-next
      Merge tag 'usb-for-v4.16' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge tag 'phy-for-4.16' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Revert "ARM: dts: r7s72100: add USB device to device tree"
      Merge tag 'usb-ci-v4.16-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next
      Merge tag 'usb-serial-4.16-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge 4.15-rc8 into usb-next
      USB: storage: remove invalid URL from drivers
      USB: storage: remove old wording about how to submit a change
      USB: move many drivers to use DEVICE_ATTR_RW
      USB: move many drivers to use DEVICE_ATTR_RO
      USB: move many drivers to use DEVICE_ATTR_WO
      USB: atm: fix up some remaining DEVICE_ATTR() usage
      USB: musb: fix up one odd DEVICE_ATTR() usage
      USB: misc: fix up some remaining DEVICE_ATTR() usages
      USB: serial: pl2303: new device id for Chilitag

Gustavo A. R. Silva (3):
      USB: usbip: remove useless call in usbip_recv
      usb: gadget: compress return logic into one line
      USB: misc: chaoskey: Use true and false for boolean values

Hans de Goede (2):
      uas: Remove US_FL_NO_ATA_1X unusual device entries for Seagate devices
      USB: cdc-acm: Do not log urb submission errors on disconnect

Heikki Krogerus (2):
      usb: typec: wcove: fix the sink capabilities
      usb: pd: fix the offset for SVID specific commands

Hemant Kumar (1):
      usb: f_fs: Prevent gadget unbind if it is already unbound

Himanshu Jha (1):
      USB: host: Use zeroing memory allocator rather than allocator/memset

Hugh Sipière (2):
      uwb: fix brace coding style issue in drp-ie.c
      uwb: remove trailing whitespace for coding style

Ji-Ze Hong (Peter Hong) (6):
      USB: serial: f81534: add high baud rate support
      USB: serial: f81534: add auto RTS direction support
      USB: serial: f81534: add output pin control
      USB: serial: f81534: only read configuration once
      USB: serial: f81534: add H/W disable port support
      USB: serial: f81534: fix tx error on some baud rate

Jia-Ju Bai (1):
      USB: serial: io_edgeport: fix possible sleep-in-atomic

Joe Perches (1):
      usb: core: Fix logging messages with spurious periods after newlines

Johan Hovold (5):
      dt-bindings: usb: add interface binding
      USB: add device-tree support for interfaces
      USB: ledtrig-usbport: fix of-node leak
      USB: of: clean up device-node helper
      USB: serial: simple: add Motorola Tetra driver

Julien BOIBESSOT (1):
      tools/usbip: fixes build with musl libc toolchain

Kai-Heng Feng (1):
      usb: core: lower log level when device is not able to deal with string

Ladislav Michl (1):
      usb: ehci-omap: don't complain on -EPROBE_DEFER when no PHY found

Lu Baolu (6):
      usb: early: Correct the endpoint type value for bulk in endpoint
      usb: xhci: Make some static functions global
      usb: xhci: Add DbC support in xHCI driver
      usb: xhci: Cleanup printk debug message for registers
      usb: xhci: Cleanup printk debug message for ERST
      usb: gadget: u_serial: Use kfifo instead of homemade circular buffer

Markus Elfring (1):
      usb: gadget: bcm63xx_udc: Use common error handling code in bcm63xx_udc_probe()

Mathias Nyman (8):
      usb: Don't print a warning if interface driver rebind is deferred at resume
      xhci: add helper to allocate command with input context
      xhci: remove unnecessary boolean parameter from xhci_alloc_command
      xhci: add port status tracing for Get Port Status hub requests
      xhci: add port status tracing for Get Hub Status requests
      xhci: fixup incorrect memset size parameter when clearing up DbC on exit.
      usb: usbtest: Add TEST 29, toggle sync, Clear toggle between bulk writes
      USB: clarify USB_DT_USB_SSP_CAP_SIZE(ssac) definition

Mats Karrman (1):
      typec: fusb302: Use dev_err during probe

Matthieu CASTET (1):
      gadget event trace : add request pointer

Mikhail Zaytsev (3):
      USB: storage: Remove obsolete "FIXME"
      USB: serial: ark3116: remove dummy TIOCSSERIAL ioctl
      USB: serial: ark3116: move TIOCGSERIAL ioctl case to function

OKAMOTO Yoshiaki (1):
      usb: option: Add support for FS040U modem

Oliver Neukum (2):
      usb: uas: unconditionally bring back host after reset
      CDC-ACM: apply quirk for card reader

Pravin Shedge (1):
      usb: typec: remove duplicate includes

Roger Quadros (3):
      USB: dummy-hcd: don't set gadget.speed in dummy_hub_control()
      USB: dummy-hcd: Adapt dummy_udc_set_speed()
      usb: dwc3: Allow disabling of metastability workaround

Shuah Khan (3):
      usbip: vhci_hcd: update 'status' file header and format
      usbip: prevent bind loops on devices attached to vhci_hcd
      usbip: list: don't list devices attached to vhci_hcd

Vasyl Gomonovych (1):
      usb: host: fotg210: Use dma_pool_zalloc

Vincent Pelletier (2):
      usb: dwc3: Make sparse a bit happier
      usb: gadget: ffs: Make sparse happier

Vivek Gautam (1):
      phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800

Yoshihiro Shimoda (7):
      usb: renesas_usbhs: remove redundant polling in usbhsf_fifo_barrier()
      usb: renesas_usbhs: add usbhs_pipe_clear_without_sequence() function
      usb: renesas_usbhs: use PIPEnCLR.ACLRM instead of {C,Dn}FIFOCTR.BCLR in usbhs_pkt_pop()
      usb: renesas_usbhs: Add a function to write the UGCTRL2 register
      usb: renesas_usbhs: add a new callback for extcon notifier
      usb: renesas_usbhs: set the mode by using extcon state for non-otg channel
      usb: renesas_usbhs: add extcon notifier to set mode for non-otg channel

 .../ABI/testing/sysfs-bus-pci-drivers-xhci_hcd     |  25 +
 Documentation/devicetree/bindings/usb/dwc3.txt     |   2 +
 .../devicetree/bindings/usb/mediatek,mtk-xhci.txt  |  18 +-
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |  15 +-
 .../devicetree/bindings/usb/renesas_usbhs.txt      |   2 +
 .../devicetree/bindings/usb/usb-device.txt         |  68 +-
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   5 +-
 Documentation/usb/chipidea.txt                     |  12 +-
 Documentation/usb/usbip_protocol.txt               |   1 -
 arch/arm/mach-davinci/da830.c                      |   4 +-
 arch/arm/mach-davinci/da850.c                      |   4 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   2 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  12 +-
 drivers/phy/broadcom/phy-brcm-usb-init.c           |  22 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |   4 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                |  35 +-
 drivers/phy/samsung/phy-exynos5-usbdrd.c           | 183 ++++
 drivers/usb/atm/cxacru.c                           |  18 +-
 drivers/usb/atm/ueagle-atm.c                       |  18 +-
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   2 +-
 drivers/usb/chipidea/core.c                        |   6 +-
 drivers/usb/chipidea/otg_fsm.c                     |  23 +-
 drivers/usb/class/cdc-acm.c                        |  17 +-
 drivers/usb/class/usblp.c                          |   4 +-
 drivers/usb/core/devio.c                           |   2 -
 drivers/usb/core/driver.c                          |  10 +-
 drivers/usb/core/hub.c                             |  47 +-
 drivers/usb/core/ledtrig-usbport.c                 |  10 +-
 drivers/usb/core/message.c                         |  50 +-
 drivers/usb/core/of.c                              |  95 +-
 drivers/usb/core/urb.c                             |   3 -
 drivers/usb/core/usb.c                             |   3 +-
 drivers/usb/core/usb.h                             |   1 +
 drivers/usb/dwc2/core.h                            |   2 +
 drivers/usb/dwc2/hcd.c                             |   7 +
 drivers/usb/dwc2/hcd.h                             |   9 +
 drivers/usb/dwc2/hcd_intr.c                        |  20 +
 drivers/usb/dwc2/hcd_queue.c                       |  81 +-
 drivers/usb/dwc2/platform.c                        |  10 +
 drivers/usb/dwc3/core.c                            |   5 +
 drivers/usb/dwc3/core.h                            |   5 +-
 drivers/usb/dwc3/debug.h                           |   9 +
 drivers/usb/dwc3/ep0.c                             |   6 +-
 drivers/usb/dwc3/gadget.c                          |   6 +-
 drivers/usb/dwc3/trace.h                           |   4 +-
 drivers/usb/early/xhci-dbc.c                       |   2 +-
 drivers/usb/gadget/function/f_fs.c                 |  12 +-
 drivers/usb/gadget/function/u_serial.c             | 192 +---
 drivers/usb/gadget/legacy/inode.c                  |   1 -
 drivers/usb/gadget/legacy/ncm.c                    |   6 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |  16 +-
 drivers/usb/gadget/udc/core.c                      |  10 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |  16 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |   2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |   3 -
 drivers/usb/gadget/udc/trace.h                     |   6 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |   2 -
 drivers/usb/host/Kconfig                           |   8 +
 drivers/usb/host/Makefile                          |   5 +
 drivers/usb/host/ehci-omap.c                       |   3 +-
 drivers/usb/host/ehci-sysfs.c                      |  12 +-
 drivers/usb/host/fotg210-hcd.c                     |  14 +-
 drivers/usb/host/ohci-da8xx.c                      |   2 +-
 drivers/usb/host/uhci-hcd.c                        |   3 +-
 drivers/usb/host/uhci-hcd.h                        |   3 +
 drivers/usb/host/uhci-platform.c                   |  23 +-
 drivers/usb/host/uhci-q.c                          |   3 +-
 drivers/usb/host/whci/asl.c                        |   2 -
 drivers/usb/host/xhci-dbg.c                        | 261 ------
 drivers/usb/host/xhci-dbgcap.c                     | 996 +++++++++++++++++++++
 drivers/usb/host/xhci-dbgcap.h                     | 229 +++++
 drivers/usb/host/xhci-dbgtty.c                     | 497 ++++++++++
 drivers/usb/host/xhci-hub.c                        |   8 +-
 drivers/usb/host/xhci-mem.c                        | 132 +--
 drivers/usb/host/xhci-mtk.c                        | 186 ++--
 drivers/usb/host/xhci-mtk.h                        |   6 +-
 drivers/usb/host/xhci-pci.c                        |   3 +
 drivers/usb/host/xhci-plat.c                       |   5 +
 drivers/usb/host/xhci-ring.c                       |  14 +-
 drivers/usb/host/xhci-trace.h                      |  69 ++
 drivers/usb/host/xhci.c                            |  48 +-
 drivers/usb/host/xhci.h                            |  30 +-
 drivers/usb/misc/chaoskey.c                        |   6 +-
 drivers/usb/misc/cypress_cy7c63.c                  |  12 +-
 drivers/usb/misc/cytherm.c                         |  45 +-
 drivers/usb/misc/trancevibrator.c                  |   6 +-
 drivers/usb/misc/usbsevseg.c                       |  24 +-
 drivers/usb/misc/usbtest.c                         |  70 ++
 drivers/usb/mtu3/mtu3.h                            |  11 +-
 drivers/usb/mtu3/mtu3_dr.h                         |  10 +-
 drivers/usb/mtu3/mtu3_host.c                       | 115 ++-
 drivers/usb/mtu3/mtu3_plat.c                       |  10 +-
 drivers/usb/musb/da8xx.c                           |   2 +-
 drivers/usb/musb/musb_core.c                       |  17 +-
 drivers/usb/musb/musb_host.c                       |   5 -
 drivers/usb/phy/phy-mv-usb.c                       |  18 +-
 drivers/usb/phy/phy-tahvo.c                        |   6 +-
 drivers/usb/phy/phy-twl6030-usb.c                  |   4 +-
 drivers/usb/phy/phy.c                              |  14 +-
 drivers/usb/renesas_usbhs/Makefile                 |   2 +-
 drivers/usb/renesas_usbhs/common.c                 |  22 +
 drivers/usb/renesas_usbhs/common.h                 |   7 +
 drivers/usb/renesas_usbhs/fifo.c                   |  21 +-
 drivers/usb/renesas_usbhs/pipe.c                   |  19 +-
 drivers/usb/renesas_usbhs/pipe.h                   |   2 +
 drivers/usb/renesas_usbhs/rcar3.c                  |  35 +-
 drivers/usb/renesas_usbhs/rza.c                    |  52 ++
 drivers/usb/renesas_usbhs/rza.h                    |   4 +
 drivers/usb/serial/Kconfig                         |   1 +
 drivers/usb/serial/ark3116.c                       |  49 +-
 drivers/usb/serial/f81534.c                        | 392 +++++---
 drivers/usb/serial/ftdi_sio.c                      |   4 +-
 drivers/usb/serial/io_edgeport.c                   |   1 -
 drivers/usb/serial/iuu_phoenix.c                   |   1 -
 drivers/usb/serial/mos7720.c                       |   4 +-
 drivers/usb/serial/option.c                        |   5 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/usb-serial-simple.c             |   7 +
 drivers/usb/storage/debug.c                        |   3 -
 drivers/usb/storage/debug.h                        |   3 -
 drivers/usb/storage/initializers.c                 |   3 -
 drivers/usb/storage/initializers.h                 |   3 -
 drivers/usb/storage/protocol.c                     |   3 -
 drivers/usb/storage/protocol.h                     |   3 -
 drivers/usb/storage/scsiglue.c                     |   3 -
 drivers/usb/storage/scsiglue.h                     |   3 -
 drivers/usb/storage/sierra_ms.c                    |   4 +-
 drivers/usb/storage/transport.c                    |   3 -
 drivers/usb/storage/transport.h                    |   3 -
 drivers/usb/storage/uas.c                          |   7 +-
 drivers/usb/storage/unusual_devs.h                 |   8 +-
 drivers/usb/storage/unusual_uas.h                  |  63 --
 drivers/usb/storage/usb.c                          |  11 +-
 drivers/usb/storage/usb.h                          |   3 -
 drivers/usb/storage/usual-tables.c                 |   3 -
 drivers/usb/typec/fusb302/fusb302.c                |  39 +-
 drivers/usb/typec/tcpm.c                           | 293 ++++--
 drivers/usb/typec/typec_wcove.c                    |   4 +-
 drivers/usb/usbip/stub_dev.c                       |   4 +-
 drivers/usb/usbip/stub_rx.c                        |   3 -
 drivers/usb/usbip/usbip_common.c                   |   1 -
 drivers/usb/usbip/vhci_rx.c                        |   2 +-
 drivers/usb/usbip/vhci_sysfs.c                     |  20 +-
 drivers/usb/usbip/vudc_sysfs.c                     |   4 +-
 drivers/uwb/Kconfig                                |   1 +
 drivers/uwb/address.c                              |  14 +-
 drivers/uwb/drp-ie.c                               |  13 +-
 include/linux/usb.h                                |   7 +-
 include/linux/usb/gadget.h                         |   2 +
 include/linux/usb/of.h                             |  21 +-
 include/linux/usb/pd.h                             |   2 +
 include/linux/usb/pd_vdo.h                         |   2 +-
 include/linux/usb/renesas_usbhs.h                  |   9 +
 include/linux/usb/tcpm.h                           |  16 +-
 include/uapi/linux/usb/ch9.h                       |   4 +-
 include/uapi/linux/usbdevice_fs.h                  |   2 +-
 tools/usb/usbip/libsrc/usbip_device_driver.c       |   7 +-
 tools/usb/usbip/src/usbip_bind.c                   |   9 +
 tools/usb/usbip/src/usbip_list.c                   |   9 +
 tools/usb/usbip/src/usbipd.c                       |   2 +-
 161 files changed, 3881 insertions(+), 1460 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-drivers-xhci_hcd
 create mode 100644 drivers/usb/host/xhci-dbgcap.c
 create mode 100644 drivers/usb/host/xhci-dbgcap.h
 create mode 100644 drivers/usb/host/xhci-dbgtty.c
 create mode 100644 drivers/usb/renesas_usbhs/rza.c
 create mode 100644 drivers/usb/renesas_usbhs/rza.h
