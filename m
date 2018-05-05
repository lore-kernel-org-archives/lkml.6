Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1031722-1525486942-2-5857964136392148027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525486942; b=jOJg6dmr28xqYz5e9aMQiewmSFgUT4K46hBh/AfeqG7bal0n1t
    zrqKWD9G+6oGPwbVXhjeM09rGwYaiSHxMTtowlr1XEz46cp4A32m6LAwvF3KzDF4
    GPjXwZoOULz3eoncHwjXzJREBmwrDbzXLKrlWPdQL2gxXbXNE7aHuerz7wnVtjMb
    fyRnRD191POMvPGTQr7Rte7wX3H2RrRCCyvM/s4/QkgAsyIWM+CCyXGM3+clWNeF
    Baqy/jDgqtdvx6k501SpFiCCmFFEfOAvX3QdydZybYCQG+r0A37lYHmrMKIyGuzR
    EbnBw7a6Wy77X3WGxjPT9fVOOC4srO/tg6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525486942; bh=J8i/jKsXDum+Iu7BBwXHXqSr0BSHhX
    CNN9lH+c0yp5s=; b=V+/q0DEU4JYOzbzsBjN0rWZDIT7HSB6lgxzYO/h/hfoifA
    7OgRSZUZ91qTNdnL1N+PuZaVLLHm6bOfGn1GLG2IGNA+AHfWpEA0SJwn0SG3sXDv
    5cZzM1cdo+rbVTFABPYptdNjRHCUK18qJ8V6ls2CJShmuRla+wyVVMvpbYFiowa/
    lk8Vyz6BQiqhh4qLiuI+Jen7kWLo1j1UTkre9nR72Z3kHmyUKXWK3Ab8zqYwZ8fW
    lLg2pKWQkLVNhXiuAbl8ihSqe2UTM9puxqOi0DNwfeMh94TUA4Km7p2hQWd0JMXN
    r5kAqmaJLrXqgIN/dB2em+lY7BBRmrCiyv/LdH/w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfBXtdxvO4TisnpzulXSFSJ+/HRPZ5etSih63sYEtvuA03+Ccj1FCP9jSPX0eQ+mPBXGWLtQsQy2jYitaiTy80WiOIuJPtrmfpxzh+KqEKo+vUeJWOHd2
    Qu9WxG3e9wNa7y15HcUYtT69Fnh6BqWZlJwM/tYKKZ/A+ZNNznMIY8zHM70qO3tact6R+RM8m+oBuSwRPCor/B39ZctQ+ypTgdlPfXrskuhTd23qeZhp5Und
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=XIH-nN3N98XKPuz2ek8A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEECWH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 22:22:07 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:62945 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751874AbeEECVe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 22:21:34 -0400
X-UUID: f6cdf00a8b3443b2862ad2c89b126959-20180505
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND PATCH 4/5] usb: mtu3: fix operation failure when test TEST_J/K
Date: Sat, 5 May 2018 10:21:19 +0800
Message-ID: <4c41c6c4230ac6f19643007540e786bc55a38a89.1525486663.git.chunfeng.yun@mediatek.com>
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

There is an error dialog popped up in PC when test TEST_J/K
by EHSETT tool, due to not waiting for the completion of
control transfer. Here fix it by entering test mode after
Status Stage finish.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index d67b540..0d2b1cf 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -7,6 +7,7 @@
  * Author:  Chunfeng.Yun <chunfeng.yun@mediatek.com>
  */
 
+#include <linux/iopoll.h>
 #include <linux/usb/composite.h>
 
 #include "mtu3.h"
@@ -263,6 +264,7 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 {
 	void __iomem *mbase = mtu->mac_base;
 	int handled = 1;
+	u32 value;
 
 	switch (le16_to_cpu(setup->wIndex) >> 8) {
 	case TEST_J:
@@ -292,6 +294,14 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 	if (mtu->test_mode_nr == TEST_PACKET_MODE)
 		ep0_load_test_packet(mtu);
 
+	/* send status before entering test mode. */
+	value = mtu3_readl(mbase, U3D_EP0CSR) & EP0_W1C_BITS;
+	mtu3_writel(mbase, U3D_EP0CSR, value | EP0_SETUPPKTRDY | EP0_DATAEND);
+
+	/* wait for ACK status sent by host */
+	readl_poll_timeout(mbase + U3D_EP0CSR, value,
+			!(value & EP0_DATAEND), 100, 5000);
+
 	mtu3_writel(mbase, U3D_USB2_TEST_MODE, mtu->test_mode_nr);
 
 	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
-- 
1.9.1

