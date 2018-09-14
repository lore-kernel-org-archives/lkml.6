Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D86ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF26620881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF26620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeINQkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:40:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeINQkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:40:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4DD8C8A;
        Fri, 14 Sep 2018 11:26:47 +0000 (UTC)
Date:   Fri, 14 Sep 2018 13:26:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.19-rc4
Message-ID: <20180914112645.GA27911@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.19-rc4

for you to fetch changes up to df3aa13c7bbb307e172c37f193f9a7aa058d4739:

  Revert "cdc-acm: implement put_char() and flush_chars()" (2018-09-10 20:40:29 +0200)

----------------------------------------------------------------
USB fixes for 4.19-rc4

Here are a number of small USB driver fixes for -rc4.

The usual suspects of gadget, xhci, and dwc2/3 are in here, along with
some reverts of reported problem changes, and a number of build
documentation warning fixes.  Full details are in the shortlog.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: net2280: Fix erroneous synchronization change

Anton Vasilyev (1):
      usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Anurag Kumar Vulisha (1):
      usb: host: xhci-plat: Iterate over parent nodes for finding quirks

Arnd Bergmann (1):
      usb: dwc3: of-simple: avoid unused function warnings

Ben Hutchings (2):
      USB: yurex: Fix buffer over-read in yurex_write()
      USB: yurex: Check for truncation in yurex_read()

Bruno Meirelles Herrera (1):
      usb: dwc2: Fix call location of dwc2_check_core_endianness

Chunfeng Yun (2):
      usb: mtu3: fix error of xhci port id when enable U3 dual role
      usb: xhci: fix interrupt transfer error happened on MTK platforms

Greg Kroah-Hartman (2):
      Merge tag 'usb-serial-4.19-rc3' of https://git.kernel.org/.../johan/usb-serial into usb-linus
      Merge tag 'fixes-for-v4.19-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus

Jia-Ju Bai (3):
      usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_frame()
      usb: misc: uss720: Fix two sleep-in-atomic-context bugs
      usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()

Johan Hovold (2):
      USB: serial: io_ti: fix array underflow in completion handler
      USB: serial: ti_usb_3410_5052: fix array underflow in completion handler

Mathias Nyman (3):
      xhci: Fix use after free for URB cancellation on a reallocated endpoint
      usb: Don't die twice if PCI xhci host is not responding in resume
      usb: Avoid use-after-free by flushing endpoints early in usb_set_interface()

Maxence Duprès (1):
      USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB controller

Oliver Neukum (2):
      usb: uas: add support for more quirk flags
      Revert "cdc-acm: implement put_char() and flush_chars()"

Randy Dunlap (4):
      usb/dwc3/gadget: fix kernel-doc parameter warning
      usb: typec: fix kernel-doc parameter warning
      usb/typec: fix kernel-doc notation warning for typec_match_altmode
      linux/mod_devicetable.h: fix kernel-doc missing notation for typec_device_id

Tim Anderson (1):
      USB: Add quirk to support DJI CineSSD

Wei Yongjun (1):
      usb: dwc3: pci: Fix return value check in dwc3_byt_enable_ulpi_refclock()

Yoshihiro Shimoda (2):
      usb: gadget: udc: renesas_usb3: fix maxpacket size of ep0
      usb: Change usb_of_get_companion_dev() place to usb/common

 drivers/usb/class/cdc-acm.c           | 73 -----------------------------------
 drivers/usb/class/cdc-acm.h           |  1 -
 drivers/usb/class/cdc-wdm.c           |  2 +-
 drivers/usb/common/common.c           | 25 ++++++++++++
 drivers/usb/core/hcd-pci.c            |  2 -
 drivers/usb/core/message.c            | 11 ++++++
 drivers/usb/core/of.c                 | 26 -------------
 drivers/usb/core/quirks.c             |  7 ++++
 drivers/usb/dwc2/platform.c           |  4 +-
 drivers/usb/dwc3/dwc3-of-simple.c     | 10 ++---
 drivers/usb/dwc3/dwc3-pci.c           |  4 +-
 drivers/usb/dwc3/gadget.c             |  1 -
 drivers/usb/gadget/udc/fotg210-udc.c  | 15 ++++---
 drivers/usb/gadget/udc/net2280.c      | 16 +++++++-
 drivers/usb/gadget/udc/renesas_usb3.c |  5 ++-
 drivers/usb/host/u132-hcd.c           |  2 +-
 drivers/usb/host/xhci-mem.c           |  4 ++
 drivers/usb/host/xhci-plat.c          | 27 +++++++------
 drivers/usb/host/xhci.c               | 30 ++++++++++++++
 drivers/usb/misc/uss720.c             |  4 +-
 drivers/usb/misc/yurex.c              |  8 +++-
 drivers/usb/mtu3/mtu3_core.c          |  6 ++-
 drivers/usb/mtu3/mtu3_hw_regs.h       |  1 +
 drivers/usb/serial/io_ti.h            |  2 +-
 drivers/usb/serial/ti_usb_3410_5052.c |  2 +-
 drivers/usb/storage/scsiglue.c        |  9 +++++
 drivers/usb/storage/uas.c             | 21 ++++++++++
 drivers/usb/storage/unusual_devs.h    |  7 ++++
 drivers/usb/typec/bus.c               |  7 ++--
 drivers/usb/typec/class.c             |  1 -
 include/linux/mod_devicetable.h       |  1 +
 31 files changed, 189 insertions(+), 145 deletions(-)
