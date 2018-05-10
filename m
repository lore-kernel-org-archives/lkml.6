Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1523401-1525931304-2-13808625217468540469
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
    1525931303; b=eGDhAVvUG1L7NgXqG0uStxN46SZT2SCLfv9aQL5RMvlkalGL4K
    5jjAkgm5Y4X7xQaaWXzRI62IC7iJZ34rgqW0YY9XvMU5yE+TjmaIbqsgl6VNbDWz
    4DSfNZ3VAyjY24aJhwPWXyTHLTN/UufOgeTkDopfvo/dbltaPAhE2qZZzh37zG1c
    y6Y/FZz9/gXvdnslNd2eU/+r/U6g+Uj4YSWZphJqKAo+nvo7Zn5vlo1ZVbEQuzEN
    UKTDRU8RiZYJYpOAO0rsh/131WHBOzzHTurLKMcfipAZdqdEhhNUjpESOfZWS+z5
    L75z6w31d2AhMkRxTziPpjLgTEpCdnlL3KsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525931303; bh=53eXuGoaobT0QRSjn+KAx5I8IZlv79
    UeYH2V2vzMJik=; b=hSnnfqdQUmoGZ7V7NYgOKVmP/jT3qbFBAQaSMsdKEYwmiU
    bV/r/6pc0H0VsdVShPplxCfp/Z9/MJxwJ++0Ra6V/b+Vt5ib3zw27pL4eL7sukkb
    /SnqYrCQEiab70+0U40Dn4NNzO0eUs6Do7kktcInkkPNdpW7nnHfWcbIsO00K9XW
    Pe2JFLJI26mX7at1qjfJr+WfQCHmn3Gay/pppbLv7SaLkoQF4MxRZyr8i175dh5t
    wrun3ozRaVKZqZs77CCDtD1Ef4yBfJ52X65gjrqLlmdN41cO61ZBzoZiBI5G2IyA
    sof0j5Q0YB5SjwcbMDasZ9gfj5YkzlelD79Mtvuw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfOd9W1jDGPGlerok7w1mFkcn4ZQDCoWrOOiwzC0gcsVdbHChvsyWfXZVEdHSkVh5rPKt1QHe0sz0gAdd1eqbGQ5oY9oFqG8DcwbnNCVPh6ISai+B4nsF
    5Ztjki4tIKTQP9dc3vp/gjmfVvPEemQUNVC3rv4ylxtTC5+6NHeJGATE7fLrhSpIutCJmz1RaXK6qkBv3fCvD4dUr2L1+74grpr6lZ7+ARrtN8bIR//JX2/4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=mXlQRWcQvAOLPvNSrNUA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756569AbeEJFsT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 01:48:19 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:50849 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756501AbeEJFrc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 01:47:32 -0400
X-UUID: b697d99f450d43fbb78745a43d8b7a19-20180510
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 4/7] usb: mtu3: fix operation failure when test TEST_J/K
Date: Thu, 10 May 2018 13:47:09 +0800
Message-ID: <572648c3e38d9d7947ecc397eb964178e140e40d.1525930818.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
References: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
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
v2:
    1. reset test_mode as default value when controller is reset
    2. use readl_poll_timeout_atomic()
---
 drivers/usb/mtu3/mtu3_gadget.c     |  1 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index de0de01..5c60a8c 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -719,4 +719,5 @@ void mtu3_gadget_reset(struct mtu3 *mtu)
 	mtu->u1_enable = 0;
 	mtu->u2_enable = 0;
 	mtu->delayed_status = false;
+	mtu->test_mode = false;
 }
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index d67b540..d3fc51b 100644
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
+	/* wait for ACK status sent by host, ignore timeout error */
+	readl_poll_timeout_atomic(mbase + U3D_EP0CSR, value,
+			!(value & EP0_DATAEND), 100, 5000);
+
 	mtu3_writel(mbase, U3D_USB2_TEST_MODE, mtu->test_mode_nr);
 
 	mtu->ep0_state = MU3D_EP0_STATE_SETUP;
-- 
1.9.1

