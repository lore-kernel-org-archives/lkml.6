Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1031722-1525486914-2-1044276046212686875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525486914; b=ldfuxhpGK9K6LFJshBHg6BtNQJn4PxaRG/lElNjOZhBLhXxz4n
    NHPriQDUS5XrMW57nzrMGhFozF9HbyOTOZ/1+/wswQkrw18KyxxAkP2UYc6nsnxm
    t6m2sK8tox2YE+2rVaKyQ9hIjxInH3XphUsfM92Jl6vIFyvMATk6ppCL9IPMpL5E
    0yyOCWdBkyoENbYQM62an+y8YoxHZBMHrY32kDcCfOc5t2GaLXMRSy/EnRHnlVCj
    gw/nVBwz/wHHIFd9BNfUmsw0tzwYWf2V0PXXFYMEPxVGZ+1ZruVkIR4+JroAnySX
    MjYfD6Z3LYxp2trA6yjqElerwYvfOdG/+bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525486914; bh=ESMZiEzRZiUJnOf/tuNRWGZZHMekog
    D+HUboMET18ps=; b=YFUYNc2d2IYFYsKGVXe6BZAxDG5i9toD5NHyeyEZ9jMcqn
    KM2fZyb5AmLEe3e3OWZAEMLn43IqN6vypjp9gD2I8yi4kX4s9p8fucPvE5d3c8Jp
    SvKT+gZtTcYrGccMzldFk/KT7KjSHl3WytLqaCJqNN/LfZJLGbvivVSqguoQ6VtV
    Le6isscnbxfdli5jSa+HGeA6RJRsktGmqme0dwWjI5gmmBQKZHrEuTW7KEnk8rFR
    jkUe8blHvFgIfUnDy8a8FQoB941zkOqhuxpaA4A7CxE0RqczaTPiQ0WHl95Hcmz5
    IPWqFSS05JTGFr5sGEkYMaeVIeYsXiq0u3btSF4w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfIm5EwGH4Lt5zdNDPIIMf8wTsvrpMN7hB9DUVjLUQL+T9S7gYewoltoBs9JxhNHAKrOOaLdxbbDX/FsOKGeCCNK3Fmss0wbQI2V5OQAneDa1v+vT1I/m
    1+z6a2CDVtp44svTI23p9gCZe7v4rbCR5a/ptNP0DUdfIC0xP+5FTQPS3dPOJU9NJCxNZmdRY+FgcbGeFX5Am6a62PKJkAFcN5OVE2sxsETc+pxclyZhZ3iq
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=xiyLrrtsVy6n212a4k8A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeEECVg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 22:21:36 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61946 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751805AbeEECVd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 22:21:33 -0400
X-UUID: 9206dbb57cb747408556afa0ae5a8a2a-20180505
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND PATCH 2/5] usb: mtu3: remove repeated setting of gadget state
Date: Sat, 5 May 2018 10:21:17 +0800
Message-ID: <e570f74b9ef18b0de5fc2bf660c547028a22743e.1525486663.git.chunfeng.yun@mediatek.com>
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

