Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1031722-1525486966-2-611193234680943133
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
    1525486966; b=XNXnS+9jZTNwrWx/D/iE730+J1uKjsjEgR4tNHquyQ27r54jLR
    X/566UfrkJcD+pFmKjukZ++jnIgZ6OHtPF2lS8iTNBhX+NQQiVmA4/FLa9BgTXvq
    HeyOTM58ZGRVteXCLzAyF5ErJb9XEZyNZwM/q+QmdTaDOorgHYlz9SyLA3Cl5QNU
    KPXVFdkEGoIHQFKO21aBVMFW0yw+j4PyhsdA2G6XEuA63PlsjrWXXEXeJsZ3yqjQ
    NR84z4tBn2IcuWbExy4AnoI9gknggvztfWgeXdpk2zu59j8KHa1chqHDAWfhiW5k
    6h6x2gzHvz98CpiDGdFusUoWD9NMcIiA+VRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525486966;
    bh=IkcNOoNnDohw33axN+w9eB4aP3Qsk2NY/v9edIP3XKQ=; b=CVgNP2ES1SI5
    Stqa/W9Hk+wyoUPkNAKblwNcNRIp0A7H08dzM4UTqVY8Tux+3GtjhqbqZT+NZ9sB
    as4Ny8GJhk3TrtHvk6gBZ3kMk7B/mphQSTm7BHJUJp6QWldwCqM5jMlxJHU98hhe
    RhcJF7fuG8H2UtOOUj7yNbOC3Jbw/hh0gkHXPJUlG2nSSvVuXa6gK6Rer3sD19Uz
    YjpeL2HihxdYJXrQ4AFgE6dHEKWkoMilRBKn+lMxYBHN3dGG+97nBVS4Wpz9t+xF
    0bHTDvyO6KspjmrvKiMLdFqT2ja3B6BlUtTz5YhBXb9604MOZT18SDsIDhWCIuLZ
    8geMH5mUZw==
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
X-CM-Envelope: MS4wfHkr/yvMMSe6r5MxC3OrKnQaSKPTJWyKROkYX16cBQx2HeX9c2oqrQs1uLrAf3aDcVtX6QeqPaF1A4XAhcI03Um87ftnQKSuffbCkvsXbKDXngAVf9m7
    KwD1pHS4epWUmuhqsATdstDNjqKZ7vy1anqdbbkCfW6KplYjcbKZW9j/sU/x/YwtB2I19mwdP/dTwNbgUpT7KnKhhapYZ/JQ590xMwzYhm8ZXsi1Lp6Rc9wR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=Ij6qccZBKdxcU9xWfWgA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeEECVc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 22:21:32 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19901 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751775AbeEECVa (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 22:21:30 -0400
X-UUID: e73e903969d04fcf8f1b67e79565c6d9-20180505
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND PATCH 1/5] usb: mtu3: avoid TX data length truncated in SS/SSP mode
Date: Sat, 5 May 2018 10:21:16 +0800
Message-ID: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1525486663.git.chunfeng.yun@mediatek.com>
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

