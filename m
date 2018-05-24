Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527163956-2-11130984748936247612
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163955; b=IYmco9IfdUiD8fZYl3yYQHCCJX7zjz1Vqlu6jVM1N9NxGHORwm
    SjLsKheIqg1mk2oN+rNRPsYWRFhJK2zTm5C6doDQeBn37aZAsO4FHGYoNeqHeW19
    tzj4zpKCjgo+LA6bnj+1mq4+FtO8apladpkUGUuPDQgIc1YcdUl1ViFvVGmChIK6
    JCYJA1pKYkUYejK/wUXpPsyTKUOf1AgqUGW9+Yej6HMOGzJ4n9jViVtcGWO2QS1d
    kI6AonRczWncfzRRD0IFwI2zBvRVpGVl3lEYiDBrEOYfScW4OQNpPUdCkUuc1HOq
    V3rBSkXb3UAiqnl0lD3ZWCUL30akSSOI92eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163955; bh=LJwOwB5BVr597gUVhLKh20HMVtxT9x
    Q6+illsYoYas8=; b=LYolKh6T4hoMsNOoN/eRLyBZoHK3hLwNWibYot6TYtPBkt
    8VYJxGFgOLYQDHZSS91hCyPdDmVMLcCI07Jw1F1cna7limYTHLsjBhg76LWGPSv/
    fSpcXOmpufYu6GlNIg9xENwJIo3I2GCTgPtya2ZlNFG9xH/+nrgwMEUe6qW6qz82
    /CGvsrtH89+I73RflGsnq/PP5PB3q8BsiPyPC8lY8wy2kfTuCsqIgjDWJUj4WqU1
    XnQhLT5ITGaIjDyK8SQdltZT4EwBWMISx0ZXhbC7UA8voWwYdKXYYF4IR1/10zCa
    Me4KnHi9DEq0sTkZFZciIdy551VkClOPGBcSNuuw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1M6cTS0T x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1M6cTS0T x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJ7vAmgTc+LW+XGlIbqeJDpSLtREkssrEpLOfFlXyU/t6MJ+q5BkjGDo4JHZPIubySX0BIUu9SK/rc05qgcwKp5pj4lj+bUXQacch13n0atK9Sp903PM
    D4x1TMQ5wARQIx7QNqMAJOJ4dy0sCo9zmBwdol8HY2I6TnMkZj/DtlAu6tcrv50vsfpotAhOh0E8MJv1fTcARiXQPj6ZJq9gc43FrjMG3qMCTDpPsrEcRKjd
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=lwUTBHgXNb4A:10
    a=VUJBJC2UJ8kA:10 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=u197ufFuNqZpRoOgcbsA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966374AbeEXMMb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966400AbeEXJmx (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 01/92] 8139too: Use disable_irq_nosync() in rtl8139_poll_controller()
Date: Thu, 24 May 2018 11:37:38 +0200
Message-Id: <20180524093159.394587696@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2229,7 +2229,7 @@ static void rtl8139_poll_controller(stru
 	struct rtl8139_private *tp = netdev_priv(dev);
 	const int irq = tp->pci_dev->irq;
 
-	disable_irq(irq);
+	disable_irq_nosync(irq);
 	rtl8139_interrupt(irq, dev);
 	enable_irq(irq);
 }
