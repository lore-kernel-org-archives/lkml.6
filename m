Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1560392-1520503082-2-688803135119781081
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520503081; b=tEvTr3kEeySG7ZJ/4PjHoIcAVxuq7C0Pf91e36UCP22vqJ/
    J3i7tm5A38hTGlzYl4q3AM+2advkBnqGfuo1ewLzdUiDOw9KF1tDTwzmRzHpMA/L
    6NIEM9z8XQSd0hsqY1zRQftSEwukZex0HLc1Oa5ReGL5e16cL9mI1Ppm4FMdXYWs
    zsp+pYOwzO/96dWrcLLayCt3UVV0Xkr/6E3/mx04JPfOjzgop8t9jbNFNyAuSSCU
    SukKImHQHZadWCB+1z9Q6cYXqf0elD6BVtmYY2WjLd/xWSpoXbp0E+5noKrx89kW
    WuCyU+R/CgUbkHjOjnZuK8h8mvVxDW/Ci0CZ11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520503081; bh=Ct2XdzfD8OvkLHmjQsD1omKy7Z
    LKIoSrtgfi7dRU+v0=; b=EveL0tddCTho/Q7qvk1zSB6ZLFF21AcCUFF6fxHzpO
    mdda2gUAP5IZ7fTQr0aJUWXa/Hq0r28PaJMDGwU5Ts1m0mwd5IylYHL7oIp7/4Qu
    5oLULkGkjIk5OvLpgg8s/VX1U1i3A2l3ks01L65PZ2QtjiyJCqfHNGwgnaNPZAfC
    AA+CzBABomlb6FOAig12T0/E0xYAbzj4nyDZnvMrMZwBaYDl+DwxTdDdogGJSWDl
    q94G9xhFa4zm8gHzI5bN1t4IIcXl7TRMQaTLlZ53Yx9/MNHXLy27xQ4CS4m+RML+
    kjoW6TrJfaVDwQyV0WY3pOArOuTb9CDIzjcQNyYrAZJg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755256AbeCHJ5r (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 04:57:47 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38310 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeCHJ5q (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 04:57:46 -0500
Date: Thu, 8 Mar 2018 10:57:39 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] usb: hcd: complete URBs in threaded-IRQ context
 instead of tasklet
Message-ID: <20180308095739.okdn7ghvlpy4oiy5@linutronix.de>
References: <20180216170450.yl5owfphuvltstnt@breakpoint.cc>
 <20180227143934.2aa847ac@vento.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227143934.2aa847ac@vento.lan>
User-Agent: NeoMutt/20171215
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-27 14:39:34 [-0300], Mauro Carvalho Chehab wrote:
> Hi Sebastian,
Hi Mauro,

> Sorry for taking some time to test it, has been busy those days...
:)

> Anyway, I tested it today. Didn't work. It keep losing data.

Okay, this was unexpected. What I learned from the thread is that you
use the dwc2 controller and once upgrade to a kernel which completes the
URBs in BH context then you starting losing data from your DVB-s USB
device. And it was assumed that this is because BH/ksoftirq is getting
"paused" if it is running for too long. If that is the case then a
revert of "let us complete the URB in BH context" should get it working
again. Is that so?

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4287,7 +4287,9 @@ void dwc2_host_complete(struct dwc2_hsotg *hsotg, struct dwc2_qtd *qtd,
 	kfree(qtd->urb);
 	qtd->urb = NULL;
 
+	spin_unlock(&hsotg->lock);
 	usb_hcd_giveback_urb(dwc2_hsotg_to_hcd(hsotg), urb, status);
+	spin_lock(&hsotg->lock);
 }
 
 /*
@@ -4968,7 +4970,7 @@ static struct hc_driver dwc2_hc_driver = {
 	.hcd_priv_size = sizeof(struct wrapper_priv_data),
 
 	.irq = _dwc2_hcd_irq,
-	.flags = HCD_MEMORY | HCD_USB2 | HCD_BH,
+	.flags = HCD_MEMORY | HCD_USB2,
 
 	.start = _dwc2_hcd_start,
 	.stop = _dwc2_hcd_stop,
-- 
2.16.2


> Regards,

Sebastian
