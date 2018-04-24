Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2218510-1524538484-2-10341548985284811889
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524538483; b=Wr4FVMKpt2AGCwP//ikyAi2h1uoCETy7pr7pXf/l4d8bQQ0bKB
    dVSXvvYuIFOS3Rc3D7lX2/2Oo0Fg2Uu07qI073hh6TtF2f7FN/Kjg/SzYksf+agt
    gIsMA/nYaWAwuyVa0y13IpCXbop4yIaGpwNyS85AR9xmIleZ1UGNnzXGjj8W6kfj
    rCG3cZuCb4OuXmGBlRZfG9hkJBt1UiEKvxNk73fjL/jN4qQtum3HGRT4Wd4PPu4P
    NIJbun1jBFdYErAO1gyTsLcHBR1l7CGhXA1Yoz07/oi529/8Rro9yH6YJioOX4JF
    d0qj1nynGrDtojxaRwxCICAqiEflRc4q32Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524538483; bh=d3jrdG/py/PvhBeJLR2GcbQLr2cqkT
    JB67gUgG+Nqqk=; b=OMIYEsOYDxuc3SFJxKOBB2kG3itou9hzhDmoUYW12ozrLV
    6QChsvHxup0BJBPdm7XgE1OwlHXGEGfi00ZY/Od8NotH8Opy3o3RZCwGb2fd73p0
    D22ipCF7SFpkCVtNXrRo4CArjl9eqzf31wpHGIs/Af+nPVCWSMqdCUE8JIraYW0D
    TmNcjRgvlf/bFLzT5wBNjQjJfvWXRGHloHeRD0Z2Qg3xC0Gj/6xwZilcGlZ78lUS
    +Z80NDxXcq2dmIiBPBVxWvC5azxo87I0z577dFCOJrUGvdBVXaaEGmm7kFvz3+c6
    VzQWtm6DIj7QgyTi0Qk1rgxytwJU8VLOMIQ4hlQw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA93QoafwuKAFdNbqkr7JNtXpYs33wuIqXi+QjrIz+W4ekgKs6zDUa7lAlORoSGXhE7OIl4W/rX6DX6F7QOHtNZmWcwWL07QAvEjCkIw12zdnuJP6ClI
    kEjYNzexPQCGd79hz5iSHwEDCdDoz4Matzf/czr7Urp0oVc6eZ/GTMYu4sSTj70ldhyv23L0u3a+ngMnEa2EwgwHrSkQ/cRMHWRUyMxWYY6kq0g2oRxBCHHX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=m-Vw8LavUTyuxteSGH4A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbeDXCyP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:54:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:45677 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932784AbeDXCxf (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 22:53:35 -0400
X-UUID: d219e3651bd346febef54731aa3a4f3b-20180424
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 5/5] usb: mtu3: make USB_MTU3_DUAL_ROLE depend on EXTCON but not USB_MTU3
Date: Tue, 24 Apr 2018 10:52:50 +0800
Message-ID: <9d0d09a973c6a7d76088f6cf557bb052d02dd440.1524537854.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
References: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
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

