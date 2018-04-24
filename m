Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2218510-1524538449-2-10652201153350288191
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524538449; b=W2srJ1NPABEWIQdrDDjkaAyTBwhTjoUkrQ8HOIMTTmNYzyA9p5
    Yx5B1u61CSBibDu4wxruQD2ZzgsLRKEuhGNuBCXCZO3VUAymHw4qANm+fah2IGpb
    oQ6hUz7YUiFRdIADliDmmf3OmJGc13aXTiv/KzCwpS8LbtngBRssllJ9fsLcP4/T
    agFi63t6V+onXqBtBrlwgVdguggvwvnox3OzISL0Cn9hBgwwczzg2mFR5Qp9/A1m
    M0e72R4FeSG33Wms0ecmka/2VSqlv9WPyvN6tV0voIp1jUFhYUpEhk5njOqUJD8T
    rfJqB4tkDmgJtYVYg91nb8UsCfdPB6TrpiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524538449; bh=J8i/jKsXDum+Iu7BBwXHXqSr0BSHhX
    CNN9lH+c0yp5s=; b=cJWTkAMv1lBujyJ0d5MLZ9NxBKggtiv3swZMKyM0I4JTsc
    xUCH4RgsDsoHQkDS15GLXcDmvdUgGKihk7zntsbMTHV/AT6EBH3xEHtVa4yt4vUk
    PVAvlRv+ptLBSIUSYy5l5e2FEggeaK3IJFrKVSJ8ntq4A3z4uXFCZHZ0hjdS9UWS
    +9TJqTds7zirnqoZ/+qZJjehshoxPwJD+GFmWMW5eRLcFhpp+h9ih/BQ590KTWQ4
    QbhhcM1LUl09WVTQLMTPr+tr1dyxJCdDT3FYi4UcWVZ0Fn5OakL7wVxpfC9eMXJZ
    lSQ3YWDjACFQCpI/Y7RjZw+dsQBMs8jbL9v7n0Wg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfFx78d0f5UcSaJrNqIeXDI65nbHTk//PGgyFSHDnPeOTtqqAoCZ9UO3uUBmx8PxJCDQA4yZO2+ojsngAfmkkMa4ime7c5UKOCgw3V0nEHdZ3msd1/ZQo
    S4HArMp0BYMM+2DkZ2s9Wm7f7yJoQl6hSCYMSLJTn6fSMAYq+O+UGeut/7/i/zvJzhU92iOEkrSZNcn+udaWn33aGjt+yey7Qxxxk/29QJuDudpsWpyCW+/U
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=XIH-nN3N98XKPuz2ek8A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932853AbeDXCxy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:53:54 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:7918 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932815AbeDXCxg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 22:53:36 -0400
X-UUID: f77dc0c4ef08422abab35dccbcf8621f-20180424
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 4/5] usb: mtu3: fix operation failure when test TEST_J/K
Date: Tue, 24 Apr 2018 10:52:49 +0800
Message-ID: <4c41c6c4230ac6f19643007540e786bc55a38a89.1524537854.git.chunfeng.yun@mediatek.com>
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

