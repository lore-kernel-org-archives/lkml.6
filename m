Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E358BC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBA623E74
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBA623E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeGAIjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:39:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeGAIjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:39:44 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8154BBD4;
        Sun,  1 Jul 2018 08:39:43 +0000 (UTC)
Date:   Sun, 1 Jul 2018 10:39:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.18-rc3
Message-ID: <20180701083941.GA11417@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.18-rc3

for you to fetch changes up to 226e2d2d31b1606c5fa8fb285b11e38badbad259:

  Merge tag 'usb-serial-4.18-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2018-06-28 19:19:10 +0900)

----------------------------------------------------------------
USB fixes for 4.18-rc3

Here is a number of USB gadget and other driver fixes for 4.18-rc3.

There's a bunch of them here, most of them being gadget driver and xhci
host controller fixes for reported issues (as normal), but there are
also some new device ids, and some fixes for the typec code.

There is an acpi core patch in here that was acked by the acpi
maintainer as it is needed for the typec fixes in order to properly
solve a problem in that driver.

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Gupta (1):
      usb: xhci: increase CRS timeout value

Arnd Bergmann (1):
      usb: dwc3: qcom: mark PM functions as __maybe_unused

Artur Petrosyan (1):
      usb: dwc2: Fix host exit from hibernation flow.

Chunfeng Yun (1):
      usb: gadget: composite: fix delayed_status race condition when set_interface

Dan Carpenter (1):
      typec: tcpm: Fix a msecs vs jiffies bug

Dongjiu Geng (1):
      usb: xhci: remove the code build warning

Greg Kroah-Hartman (2):
      Merge tag 'fixes-for-v4.18-rc1' of git://git.kernel.org/.../balbi/usb into usb-linus
      Merge tag 'usb-serial-4.18-rc3' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Grigor Tovmasyan (1):
      usb: gadget: dwc2: fix memory leak in gadget_init()

Hans de Goede (2):
      usb: dwc3: Only call clk_bulk_get() on devicetree instantiated devices
      NFC: pn533: Fix wrong GFP flag usage

Heikki Krogerus (4):
      usb: dwc3: pci: add support for Intel IceLake
      acpi: Add helper for deactivating memory region
      usb: typec: ucsi: acpi: Workaround for cache mode issue
      usb: typec: ucsi: Fix for incorrect status data issue

Houston Yaroschoff (1):
      usb: cdc_acm: Add quirk for Uniden UBC125 scanner

Jaejoong Kim (1):
      doc: usb: Fix typo in gadget_configfs documentation

Johan Hovold (2):
      USB: serial: cp210x: add CESINEL device ids
      usb: dwc3: of-simple: fix use-after-free on remove

Karoly Pados (1):
      USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Mathias Nyman (1):
      xhci: Fix perceived dead host due to runtime suspend race with event handler

Minas Harutyunyan (3):
      usb: dwc2: gadget: Fix issue in dwc2_gadget_start_isoc()
      usb: dwc2: gadget: fix packet drop issue for ISOC OUT transfers
      dwc2: gadget: Fix ISOC IN DDMA PID bitfield value calculation

Peter Chen (2):
      usb: typec: tcpm: fix logbuffer index is wrong if _tcpm_log is re-entered
      usb: chipidea: host: fix disconnection detect issue

Randy Dunlap (1):
      staging/typec: fix tcpci_rt1711h build errors

Stefan Agner (1):
      usb: xhci: tegra: fix runtime PM error handling

Vincent Pelletier (1):
      usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers

Wei Yongjun (1):
      usb: dwc3: Fix error return code in dwc3_qcom_probe()

William Wu (3):
      usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub
      usb: dwc2: alloc dma aligned buffer for isoc split in
      usb: dwc2: fix isoc split in transfer with no data

Zeng Tao (1):
      usb: dwc2: gadget: fix packet drop issue in dwc2_gadget_handle_nak

Zhengjun Xing (1):
      xhci: Fix kernel oops in trace_xhci_free_virt_device

 Documentation/usb/gadget_configfs.txt |  2 +-
 drivers/acpi/osl.c                    | 72 +++++++++++++++++++++++++++
 drivers/nfc/pn533/usb.c               |  4 +-
 drivers/staging/typec/Kconfig         |  1 +
 drivers/usb/chipidea/host.c           |  5 +-
 drivers/usb/class/cdc-acm.c           |  3 ++
 drivers/usb/dwc2/core.h               |  3 ++
 drivers/usb/dwc2/gadget.c             | 20 +++++---
 drivers/usb/dwc2/hcd.c                | 93 ++++++++++++++++++++++++++++++++---
 drivers/usb/dwc2/hcd.h                |  8 +++
 drivers/usb/dwc2/hcd_intr.c           | 11 ++++-
 drivers/usb/dwc2/hcd_queue.c          |  5 +-
 drivers/usb/dwc3/core.c               | 23 +++++----
 drivers/usb/dwc3/dwc3-of-simple.c     |  3 +-
 drivers/usb/dwc3/dwc3-pci.c           |  2 +
 drivers/usb/dwc3/dwc3-qcom.c          | 13 ++---
 drivers/usb/gadget/composite.c        |  3 ++
 drivers/usb/gadget/function/f_fs.c    | 26 +++++++---
 drivers/usb/host/xhci-mem.c           |  4 +-
 drivers/usb/host/xhci-tegra.c         |  6 +--
 drivers/usb/host/xhci-trace.h         | 36 ++++++++++++--
 drivers/usb/host/xhci.c               | 47 ++++++++++++++++--
 drivers/usb/host/xhci.h               |  4 ++
 drivers/usb/serial/cp210x.c           | 14 ++++++
 drivers/usb/typec/tcpm.c              | 10 ++--
 drivers/usb/typec/ucsi/ucsi.c         | 13 +++++
 drivers/usb/typec/ucsi/ucsi_acpi.c    |  5 ++
 include/linux/acpi.h                  |  3 ++
 28 files changed, 373 insertions(+), 66 deletions(-)
