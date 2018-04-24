Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2218510-1524538433-2-4144452936245687257
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524538433; b=seN8mL1zqWEwXQ5WgcN2SG2h50p/uuYiLjMDNWejvlzEYr1DlZ
    p7u0h0k1kU7e3R5SNH0oWuEUrTB24QQfmPv/jVXSW3VnIg1TpAUj+vPaUylzq3zQ
    eu+oi4Aq1ih3c3yc0ODfC7qPkfPYRlcY46zFXSiugLXNzNG0EBYVdrtPEDwsCVcs
    VGdNO+tzXikbvLcjuJ5EC6y8Sutgkq+fcPEIn73WPSVKmtErn80cDUDgjHvzAtKR
    hqbvgMiL9bpaCHaX2505ycp+nNVw/LgpY+K4q+82RJvYbfYAE4DNecT+SBgXyGI5
    OZc9geIBxtQ+qSs9oqrNoK9Bq6O0yctitLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524538433; bh=ESMZiEzRZiUJnOf/tuNRWGZZHMekog
    D+HUboMET18ps=; b=STYN/IjVcEQ+ki1BblRu7ehRcxc2SUWk/IyK0r3TuAMWvc
    NW+Ne1Y2iumuS6EeYamK6KDhaYosriVJD9l8abXHNnmcMrtLgIgY1DytQWeDXerd
    5VtW2IIjp4Whx20L2Or+It5EKf/wmeJKEDVEg1U4yJ998b128bM+xlyfaEyzpgYY
    KjcUyYvXSlQg8mTdmAKtKHiO/DAfxUXA1UbcNjIkKM6HDsOw0qg5/cYAN0F9OFCZ
    86vmwjlW6lMe0g6N9B1UTYgvu+OSCtKDQ7ESeua+yKTZkgN1DgKG+GKcgMlZ6Wiz
    +lutYL7dN4G/Sm9GpHBz37L6Dd1TmbQriymxRdlQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNoOZTk23QhVhF6Y1aSMWQtQEP3+rvsBO2SKHAxij0imxYP7t/ZCsE+dwloX2pRFWX9sNd/DxYaK8LSVKUjIeGPcI+FLNbBSmU7KImUEoNzFqDYmT1ik
    O0ISkPsy3PZ/y08HRkyJUl3GrAHEVM0oTNF/TPSPesGoySvrNb5QUINK2LRuYzdFa+kqtEOhHvvTs08s/SIwjaPuBoBaRWQvumnZxhrTxyyDtVsb2eaKa68U
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=xiyLrrtsVy6n212a4k8A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbeDXCxh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:53:37 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:45677 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932721AbeDXCxe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 22:53:34 -0400
X-UUID: 02e5aabc6d424d3b83470ed67bb32168-20180424
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/5] usb: mtu3: remove repeated setting of gadget state
Date: Tue, 24 Apr 2018 10:52:47 +0800
Message-ID: <e570f74b9ef18b0de5fc2bf660c547028a22743e.1524537854.git.chunfeng.yun@mediatek.com>
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

The usb_add_gadget_udc() will set the gadget state as
USB_STATE_NOTATTACHED, so we needn't set it again.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index f05f10f..de0de01 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -660,14 +660,10 @@ int mtu3_gadget_setup(struct mtu3 *mtu)
 	mtu3_gadget_init_eps(mtu);
 
 	ret = usb_add_gadget_udc(mtu->dev, &mtu->g);
-	if (ret) {
+	if (ret)
 		dev_err(mtu->dev, "failed to register udc\n");
-		return ret;
-	}
 
-	usb_gadget_set_state(&mtu->g, USB_STATE_NOTATTACHED);
-
-	return 0;
+	return ret;
 }
 
 void mtu3_gadget_cleanup(struct mtu3 *mtu)
-- 
1.9.1

