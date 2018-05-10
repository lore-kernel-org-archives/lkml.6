Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521860-1525931354-2-9283420661751027882
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
    1525931353; b=VRqwtvDaZAyDpHVkGx0/LICmmqPa3376qSaGStv6cjvNR/5GMR
    deU46S6kKkEt5qQHpjpdFkE1ZmQkIDA1+LOS1fN1V1BTSXzWHlYnycBXF9XGUNPK
    HsStw20yKkOMatluroPwlFcMGfG3WynELwtvbKsAB0GTgOwvSgx+AIT/Yqx8zYyI
    Lit4HTygbY17V2+EFChHEmhMCKm1aNBP+Q885hko7FVr6jlDASwVr0mTT5hA4H8k
    bZSsFdr4OeKR2sZIlHOhuXPH+dvnLq6eKlAnqY1icgUSmBK6AuZ7TAJ2dLc/cHeS
    qDGJsB/2g799H8aZ8H+ZjaOLvvxyy5Ub+vwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525931353;
    bh=IkcNOoNnDohw33axN+w9eB4aP3Qsk2NY/v9edIP3XKQ=; b=HQD8CIpky//C
    TrqALorYB6BwVL73hdmJxCDafwtJF52fp/bKGupuBAO8qEnYvMKI1eatEYKQ/LC/
    JlgtgLiu/W3aNN+Mei2UGklzLWNwoqkt69uCQt5BWUoioxbDWOK9sWzXS/M1zoaq
    psNaZHoF+AdODoRm1uMkQLDIiwdqFmqW0vmDQC0B4cuN2XCpPUhWMmKeMScFkzOq
    kwKoaVQ8wAusGSey1FCm5TcLqxvrgMV3JH/3hc3K6bYi0ERKAyhhQI+SJfGqmJtn
    FWErQLOeswHutArrZs9wOPYJlTdCRzMaUMfrlSoeMbkeJRn9o2B/I3dx9TngKLEV
    wnsBnfP3uw==
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
X-CM-Envelope: MS4wfOpWi+xNbXxTRfQ855R9s7qoRMekpMZVT+fSMAYVmgvc1sTRVl6oF4WVCSfRR5FYBC6mte0qf7cGPc85Z0LAmUQDfRl59jXflkFzuZcEmlmEyw3yyfM8
    TbzZchctRNdeY1a4y0xJTQ6v6ATJGZ8uXLRMv2kN3bT1BuoLDmjn4mkicByW/2Vitxhet4ovEHcpfG1UUroLCt9hDBtuZdu/w6BiH4eMRsrjFGWi9B7fSJ3u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=Ij6qccZBKdxcU9xWfWgA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756444AbeEJFrX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 01:47:23 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:43407 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753633AbeEJFrX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 01:47:23 -0400
X-UUID: f8e5ca9d4cdc4e3a89cd9232a9b43039-20180510
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/7] usb: mtu3: avoid TX data length truncated in SS/SSP mode
Date: Thu, 10 May 2018 13:47:06 +0800
Message-ID: <6b82c11302a81368bd6936424d081ede3340b431.1525930818.git.chunfeng.yun@mediatek.com>
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

