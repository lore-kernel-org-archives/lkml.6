Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3571199-1526631412-2-5455776123970751996
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526631412; b=X/CGQbSSaDNn8DgU/bDwchsiiWohFlm9iuP+/WIIEboVWXkUlZ
    DYuYysIyQy0Qd4DTlvF4Rbbe8PoGdkuvS50hWihUrsMOLLdb2NVDsOOvOZBytAL/
    a7v3S0a1EHrnkfUPrz3Iails3t15Xc5wzsuzZlWOj4KoXgP2o3o2rUBG6SsMmzS7
    +UmMMumZLnkjX6OrTQDoZWT559+2H8rTfmI3fZC4tpi20J45dld3wbizKqX3GfHz
    XgYpQRU72bsgZLlVhCWXNOgWOQpaQdeoAlQdxbvmt6Rl42oLjsepn29jWEh8fxnU
    nrl6u4jgHJ7nNJ0ogpPCij8ze2WJ9pjhSYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526631412; bh=E2LO7DZ2wmC+iJtM6Z6f3Z64m9SSUL
    yUXyQ4RzI3ZDQ=; b=WxatzNKnZ2NInKXSHsJf++rxpS8cKARPhHVAb5WrYzocHe
    xUPq9dsYW/cOCCl9ej+TCQeLwceztfgiQWMuwC8YFB+qps8nGFTnnPioYSjmSjAF
    D3DbBWfgCzoMxyyAEhZ8ehr0cUy2oEHb2/WcG7ylYOWrFL6IPxhDJUA/H8Waia+k
    07bzWo1itsEqjrzwa7f0WywaZCfs38SeWpb+JaO5RgBWKHYplmv1QkvKgPtxjvRO
    sBWUGuS+inwUO17eQnLDGY5vKdKAuZXTv+81KgH5JP84O03/SvsUhPxrxV2orRgR
    644H3u4Qu4A2EN2Az0bSIT3N83YbCOYLTInfavHw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=YiEwFRC9 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=YiEwFRC9 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGLOXKAViPSmllWvqlZOna4GXjIneZlQG2ASL2Fo2pG5y8igbaCe2WjNifLjWGgAE6ZXD7KBqQjnSMEUEBlB0xcWR6vbyUBwlYef2G2vw46yU0Ozyxx0
    gSdlguRIjEki4KN4BTU7y0XZpNGgEEh35fivCyZGChp8b2sd9zHJo0SVZN5mEGhteTG2FevBF1snT/oT3LN76qsrIO9Kg1vcIPhbteFLkyOh3/XBjTpw/1Ks
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=RZdeXJz5dscA:10
    a=VUJBJC2UJ8kA:10 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=u197ufFuNqZpRoOgcbsA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeERIQt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 04:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeERIQs (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:16:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 01/55] 8139too: Use disable_irq_nosync() in rtl8139_poll_controller()
Date: Fri, 18 May 2018 10:14:57 +0200
Message-Id: <20180518081457.483457953@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@elte.hu>

[ Upstream commit af3e0fcf78879f718c5f73df0814951bd7057d34 ]

Use disable_irq_nosync() instead of disable_irq() as this might be
called in atomic context with netpoll.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/8139too.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -2224,7 +2224,7 @@ static void rtl8139_poll_controller(stru
 	struct rtl8139_private *tp = netdev_priv(dev);
 	const int irq = tp->pci_dev->irq;
 
-	disable_irq(irq);
+	disable_irq_nosync(irq);
 	rtl8139_interrupt(irq, dev);
 	enable_irq(irq);
 }
