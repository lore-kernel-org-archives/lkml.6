Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1542408-1521027049-2-13720365617747888599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521027049; b=AepXasOOFToRwpyRJ2IdbpbmIaRo/tKRpsjYC+yFfCq3rKd
    gbzyzGo+5EFBoAfcmea9EE0Vdl0uP3+1yE6ErxCn2RAC1L1kR2p5/ub9GxqsZ1+I
    4JlyjKQUK/5+K6w07q1qMWEIdQNREr8GvMUtmC9lud0++eCY1Z938ZZ4IcRS5dSG
    MgGSumbKxDstAVBPche7C9ymYhFZhiaSGnirSRVvOeN2kOaXqT/DhciO/5Npi+mJ
    JKCuCcV/SLlo8jgruxfnoeG6keSX6ZQIkEs2c/Lmjit8e+onZapyx+Ezin2MN18W
    46CRMrZprC5R1ZhbTwtKGCGXH7N5TTtYN2ppL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521027049; bh=mA5MbhiM7aMruNmdO/+RySUDtDWpK6RQYqH6jrZh4rI=; b=r
    W8Au4sfsxYCPI05U7BJ4WT3xi9qfeYXwdBz2EosaNUq/1U3NOLT9AKmxzoboaXGM
    flOyf2zskn0E524CZcRRE4VUG3SWn9VeABLWc6gfaiNTDnzNuQcVewx//SIh0lTM
    vHn657NvjZb/DkUmEvYbHh6+oILwGn/dVAmttJpUAdfHBnu0TvQ67mAOS5g8wHHN
    HY1eoweriMxYnk8XjtPxR2I9YYs9cdQFkN+n8JpQ/+XtX1h23SyoZtLdFjpFCAdU
    3s98AF5UoR/r0UGUjSFL9+AVAk0jVQHND+3HkPqbUDYc1+dXBNDu7FZJEPzf3Hfa
    1G6Ol1UmvtpNRK7UsvFPg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeCNLad (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 07:30:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbeCNLab (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 07:30:31 -0400
Date: Wed, 14 Mar 2018 12:30:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 4.16-rc6
Message-ID: <20180314113030.GA23868@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/usb-4.16-rc6

for you to fetch changes up to 94e46a4f2d5eb14059e42f313c098d4854847376:

  usb: musb: Fix external abort in musb_remove on omap2430 (2018-03-13 16:36:59 +0100)

----------------------------------------------------------------
USB fixes for 4.16-rc6

Here are a small clump of USB fixes for 4.16-rc6.

Nothing major, just a number of fixes in lots of different drivers, as
well as a PHY driver fix that snuck into this tree.  Full details are in
the shortlog.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amelie Delaunay (2):
      dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding
      usb: dwc2: fix STM32F7 USB OTG HS compatible

Arnd Bergmann (1):
      phy: qcom-ufs: add MODULE_LICENSE tag

Colin Ian King (1):
      usbip: vudc: fix null pointer dereference on udc->lock

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20

Fredrik Noring (1):
      USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM

Greg Kroah-Hartman (2):
      Merge tag 'fixes-for-v4.16-rc4' of git://git.kernel.org/.../balbi/usb into usb-linus
      Merge tag 'phy-for-4.16-rc' of git://git.kernel.org/.../kishon/linux-phy into usb-linus

Hans de Goede (2):
      Revert "typec: tcpm: Only request matching pdos"
      usb: typec: tcpm: fusb302: Do not log an error on -EPROBE_DEFER

Kai-Heng Feng (1):
      xhci: Fix front USB ports on ASUS PRIME B350M-A

Lu Baolu (1):
      usb: xhci: dbc: Fix lockdep warning

Mathias Nyman (1):
      xhci: fix endpoint context tracer output

Merlijn Wajer (2):
      usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers
      usb: musb: Fix external abort in musb_remove on omap2430

Oliver Neukum (1):
      uas: fix comparison for error code

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size

Roger Quadros (1):
      usb: dwc3: Fix lock-up on ID change during system suspend/resume

Teijo Kinnunen (1):
      USB: storage: Add JMicron bridge 152d:2567 to unusual_devs.h

Xinyong (1):
      usb: gadget: f_fs: Fix use-after-free in ffs_fs_kill_sb()

Yoshihiro Shimoda (4):
      usb: renesas_usbhs: add binding for r8a77965
      usb: gadget: udc: renesas_usb3: add binging for r8a77965
      usb: host: xhci-rcar: add support for r8a77965
      usb: host: xhci-plat: revert "usb: host: xhci-plat: enable clk in resume timing"

 Documentation/devicetree/bindings/usb/dwc2.txt     |   2 +-
 .../devicetree/bindings/usb/renesas_usb3.txt       |   1 +
 .../devicetree/bindings/usb/renesas_usbhs.txt      |   1 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 drivers/phy/qualcomm/phy-qcom-ufs.c                |   5 +
 drivers/usb/core/message.c                         |   4 +
 drivers/usb/core/quirks.c                          |   3 +-
 drivers/usb/dwc2/params.c                          |   6 +-
 drivers/usb/dwc3/core.c                            |   2 +-
 drivers/usb/gadget/function/f_fs.c                 |   1 -
 drivers/usb/host/ohci-hcd.c                        |   3 +-
 drivers/usb/host/xhci-dbgcap.c                     |  20 ++-
 drivers/usb/host/xhci-dbgtty.c                     |  20 ++-
 drivers/usb/host/xhci-pci.c                        |   3 +
 drivers/usb/host/xhci-plat.c                       |  11 +-
 drivers/usb/host/xhci-rcar.c                       |   4 +
 drivers/usb/host/xhci.c                            |   3 +
 drivers/usb/host/xhci.h                            |  23 +--
 drivers/usb/mon/mon_text.c                         | 126 ++++++++++------
 drivers/usb/musb/musb_core.c                       |   4 +-
 drivers/usb/storage/uas.c                          |   2 +-
 drivers/usb/storage/unusual_devs.h                 |   7 +
 drivers/usb/typec/fusb302/fusb302.c                |   3 +-
 drivers/usb/typec/tcpm.c                           | 163 ++++++---------------
 drivers/usb/usbip/vudc_sysfs.c                     |   8 +-
 include/linux/usb/quirks.h                         |   3 +
 26 files changed, 211 insertions(+), 218 deletions(-)
