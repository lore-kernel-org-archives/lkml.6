Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1031722-1525486961-2-17398831704321563988
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525486960; b=S29lVQBzOf8R/UJXA/vUDkjP8gz7MSPmSXu8jzWrlg34PtpAJJ
    zTsjyOC1+cRI7yUr4ngYUCYEoeNMUEw2207ggmGYrJ97scgPzHY32XBwmYbYhBIs
    Mi9NctZ0IHJdlYo1w48XxrqQtkYRxbzKaxZlb+34x7T2oF6w0QqOy33B/pQvscqO
    VAPTHpC0es9D/A3e1HznNAstjUUBtW1RzsiAu/GxaKAeHj8eTXbNP1C7taYGX4g8
    Ejt8wpwwt6/9W8oaKzWMOv4a8Ec+esecl90Tp3Ktw/Qrn8AmzWx68NLmiis6ZrWQ
    qGSW1Wobl1LVx4sbfiFNl08JlAMEY7VqMmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525486960; bh=d3jrdG/py/PvhBeJLR2GcbQLr2cqkT
    JB67gUgG+Nqqk=; b=NYV9dLdqIPcJZd0n8BD/jJJw007Hm9f7g/kxQQEFVcCJTa
    uxCISsfJo5EiKncDqTHo/vZf/TgRYv5wXaWF9Kqf1LhRB64XLV1GW+d0K957WQyO
    ANVxvqcCLa2BqR3VsI1cwsyMmuv9kuQzaa5q05HwsRncXxrFweAEqgIulShM4E4C
    09e6bkDs6upqMbi2xDK+l1T9GWSpCyZiDA9ALflvRrkDGI/CORL9TxTiODzKixPh
    CU4AOajXpEL15Olj7xx9mgPS3GwuOcVTRpVN3Di6YlnRc9abx42hLXCtNyLvSwRf
    JDaEz5DBsd5TcQd7JXVK1PjpTg4IAV0CknyglnIA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPZfHyy4Pk8LWaCVOqh9Ue3b69wluhF/JqEw7q4pmny5P5xeHLz3LmKQYmeuaClNbhFUMTHKy/5ZjzOhgN8k8GVIttGVtbTdnRiixPlqUdps5PJHt6ww
    3EKiGLy9X4u+/F+YVHrf4DvjRFPiP8sTmiu8isFF3QPSMD6wwCw21QY5dVCYSF4rcHO9KzQJUrszO6Tlhkpp3IOe21bA07etTKU2fMRXkphlzb/sfDExCmWC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=m-Vw8LavUTyuxteSGH4A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEECWY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 22:22:24 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61946 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751775AbeEECVe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 22:21:34 -0400
X-UUID: 19a430aa20d44f7a8ee3c8e27aaf1b13-20180505
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND PATCH 5/5] usb: mtu3: make USB_MTU3_DUAL_ROLE depend on EXTCON but not USB_MTU3
Date: Sat, 5 May 2018 10:21:20 +0800
Message-ID: <9d0d09a973c6a7d76088f6cf557bb052d02dd440.1525486663.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1525486663.git.chunfeng.yun@mediatek.com>
References: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1525486663.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In fact the driver depends on EXTCON only when it's configed as
USB_MTU3_DUAL_ROLE, so make USB_MTU3_DUAL_ROLE depend on EXTCON but
not USB_MTU3.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/Kconfig b/drivers/usb/mtu3/Kconfig
index 25cd619..8daf277 100644
--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -2,7 +2,7 @@
 
 config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
-	depends on EXTCON && (USB || USB_GADGET) && HAS_DMA
+	depends on (USB || USB_GADGET) && HAS_DMA
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
@@ -40,6 +40,7 @@ config USB_MTU3_GADGET
 config USB_MTU3_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on ((USB=y || USB=USB_MTU3) && (USB_GADGET=y || USB_GADGET=USB_MTU3))
+	depends on (EXTCON=y || EXTCON=USB_MTU3)
 	help
 	  This is the default mode of working of MTU3 controller where
 	  both host and gadget features are enabled.
-- 
1.9.1

