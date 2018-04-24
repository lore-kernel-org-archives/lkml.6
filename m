Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2218510-1524538492-2-831534922130605724
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
    1524538491; b=NHyjNvJ39c9gA4sfFFqqWP66h8YPv9fhxeAlYtiaZdS5nrmh+m
    yw/xJySKLoaT5cBln/IUl5H5Ex55/3PxDrKB9LwroofVj3gHNCVyO0ksyk2O4nx8
    oIzYZ54VQq9/SkopDkBCYhz26hQ6JD5Nd+s4lDOvLvsyYf0qFFcPgviQzP2hWLTu
    eLgi3Z9inVXBnXLpgnl4A6LwvJ8EpCSWHTkheZyDCoB21fYw1dgJdCTpmRJBkzM/
    bN2cgtegUOiu69a5Pz7zdt/pWsUWV2JlZDTukIFGcwGwF/uCQL6uw0+NW1AyyJX7
    oWMZyrGygCPKQEQ+LE8daluXIfjpxavd44Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524538491;
    bh=IkcNOoNnDohw33axN+w9eB4aP3Qsk2NY/v9edIP3XKQ=; b=n2+Y/NoU8X3H
    TWb/U5i6LJX7CuvFqlphxh7GeUXXHj0INNg3fD8452psNKhSfywE7GHhH+ziU11Q
    tun5pLD7VRfGD0woRabUDT1WEO8I1X7MsDOS6BnvmFb6OYWap13mJkJ3g4tP79Nf
    e4/swETHPu3oasS4UAXgj1lTeylSHzdgH9U7iQgYcPf9Y7MXAmC0SHT2QFEGMtbW
    0qvp/GfmdFJvjSqX+jXUeJGJ6fF9gIMgQzfkzL6UM3TKIw1eTxulHlEYzx0xV7tr
    TynJ01lxTt0qBmoDeLMO9I/uHvfkiMbhM29DOshF9L6lbQ6X0GbjhUxvOrg4xK67
    fl0ZxCM6Ew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfLlHEdIFkEisM5xIEDr2dMf44guD5qoLVssvdlQN/fz4KMUntSXJpm+Zb8f+2dMst7rJEUgRUW0Uzwv1r/qIkZM3J3muOx+6UFypGS97lmN8y/Tr956y
    30lgK3ZwrmtnN5ndIWkApf+kCm7NIY7GpdmPsHzj3kKRJp80cSkYlMfUV2EIJjkz+yO3t5RijNvpFQSv1GsxoWJbtbFVOAi5hdEUG8GKE/obVWkFra9mPJBw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=Ij6qccZBKdxcU9xWfWgA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932770AbeDXCxe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:53:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:63440 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932750AbeDXCxd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 22:53:33 -0400
X-UUID: e766611cc9db41e59641833063401b5b-20180424
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/5] usb: mtu3: avoid TX data length truncated in SS/SSP mode
Date: Tue, 24 Apr 2018 10:52:46 +0800
Message-ID: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1524537854.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The variable of 'count' is declared as u8, this will cause an issue
due to value truncated when works in SS or SSP mode and data length
is greater than 255, so change it as u32.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index ebdcf7a..d67b540 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -546,7 +546,7 @@ static void ep0_tx_state(struct mtu3 *mtu)
 	struct usb_request *req;
 	u32 csr;
 	u8 *src;
-	u8 count;
+	u32 count;
 	u32 maxp;
 
 	dev_dbg(mtu->dev, "%s\n", __func__);
-- 
1.9.1

