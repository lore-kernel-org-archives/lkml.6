Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521860-1525931295-2-14711580568150947903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525931295; b=lmL3T3Yr3oXB81SF7SeqHHfmINPFK3gH/ZNgHHSPyCXE2CaT/o
    Q50gJAezSEsQ2Sr+/bS8l4XjSLDGmHkkiF3qda4fH53enTEAC72uwowYN+1L7ri9
    zR080nDRBar+/DJHsC7RZirlt5QlLhZXLvYfLCDzX+bLR2Hr6bhhygFRbvkyo1R7
    FvLQl+wktCSLh8JNEZs/AycrBlIPW/wXwOIQVyNip+zObPgGinDEInwz5O2EbPnD
    DmS1Dve+OFs4XdhJQrQ2DR8paJe29mbTrHMSZyZdN70DjmpSQH6RUIB9td3SmkNb
    /CFTgB2EOTGSJmJ6Oi0UfQqdiScDnFNi37og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525931295; bh=wI24xgCPzU5BG2ROwifYwc8YALal2/
    f1YjrSkcqxbc0=; b=niRPD1Bbor9S5FY92IDEGHc0XRUo4JUzfQRRaI9zLWmgc5
    WrOBQ0bEkiWJ3kemnzXA1/uwUXl3gcbeaWsyhu+C0ZDhI5PMIhtPZszFa1XuEhqm
    cZS/IYVFCswIKX8JI2H8YnzRsl/MyIsWuUK6QJa3k6Bw70uVAYXquLIrWrtcopzO
    AJ4yVDcpfUgEqLkn9op+HC3rIUrYmZAJ3YNxkhrojV1fIzhetWHgXWu4a3qPiiR0
    koRaj+iY/7xWQ/LEEwzsgCLWdiHtXoKUbeHjOizvPARRRVTmdAqsK97T99SUeQlE
    oEjtEaPn3CjOYqjwuL+OKaDW3nPqOONSFbymImuA==
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
X-CM-Envelope: MS4wfADAQOfUAcwYV+VVOjqPdmBV7qm8MY+zdkSbVI+FRIIDsF8tEOzv+iPjE2BwDLKSIhsgGycw50rhSSAFCHc8vbtADiBiud787wY5UpCIgE0MbtDzrYL3
    CXtGZSFY6d4pDBBzcg09rmdSxky7YsZb1t2lQzAqKmdy8NXQFvwsobOBW1dMBZSwMsQ7vt0fe22TJppascOl4YdU0MOhYfjvW6RMzaNXrvEnEFZynVKV0zvS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=cK3XXfsq7Xt1azUJewEA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756667AbeEJFrd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 01:47:33 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52603 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756660AbeEJFrb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 01:47:31 -0400
X-UUID: cc21a87463e241f19a4ed1af1cad3267-20180510
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 7/7] usb: mtu3: fix uncontinuous SeqN issue after disable EP
Date: Thu, 10 May 2018 13:47:12 +0800
Message-ID: <5d0d535b9a86a07d9b1bddfbca62b54e7d96a702.1525930818.git.chunfeng.yun@mediatek.com>
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

Reset EP when disable it to reset data toggle for U2 EP, and
SeqN, flow control status etc for U3 EP, this can avoid
issue of uncontinuous SeqN

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2:
    add this patch
---
 drivers/usb/mtu3/mtu3_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index 65ff53a..0bc2b39 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -400,6 +400,10 @@ void mtu3_deconfig_ep(struct mtu3 *mtu, struct mtu3_ep *mep)
 		mtu3_setbits(mbase, U3D_QIECR0, QMU_RX_DONE_INT(epnum));
 	}
 
+	/* reset: u2 - data toggle, u3 - SeqN, flow control status etc */
+	mtu3_setbits(mbase, U3D_EP_RST, EP_RST(mep->is_in, epnum));
+	mtu3_clrbits(mbase, U3D_EP_RST, EP_RST(mep->is_in, epnum));
+
 	ep_fifo_free(mep);
 
 	dev_dbg(mtu->dev, "%s: %s\n", __func__, mep->name);
-- 
1.9.1

