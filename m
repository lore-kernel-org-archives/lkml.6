Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3317868-1523887287-2-9344603391895290054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523887287; b=Zch1JsaZqB9VvFsxFHN0TWoxCik6guiAUV8VS/h29cz843u+Et
    k1Ce9pjkx/I2AkTbrNpb00Q4o1lbmvhUiQ9o2QGqwFk0AWQDdAPi1tOhRwwqTYZj
    DHDhOBuWtWOFgbYkTOxcIbnN7PFXVFQDm1nx2qDJe4wZqrAyDoaL8LOUuQ5rPWJY
    N7vYYej4ycQd0+UmuGfjHbWV+Id4fWg6LoIUltrx8Ofxu2Kvz5wWB5TCKOUY44NR
    bq1pjgtHeW3NzOSvAxt7yk/+hNUZHihnGKINFN14KFTH+QyqnJj4nt+8tJHZZ6A/
    pHNWtvskprPTiLn7JoxQGRSqxjjOYXb7eROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523887287; bh=Epc36/GsnMrS9Ggc3TppQ1rSr3wm9n
    sbLFAml5ClnzU=; b=I/fGM0UAfPt8rxKkGZZEgBeFeYFwmcPW7roIfz0R6/sSM5
    KGsJuxxujgNib5FtESD+PUppR/O8mk6D2uhbgRdFDOsKl5opN/6X4fUvhKWLzNb1
    36CFAj/67/EIIe3maoBk7NaLdoN+q0AqcWe9jOdgN5CTPIuipWzGN+Ge8W+cFB5q
    sdzD29Q/JfdAR6qSx2IPNY9bBbfJl9cqmMETQel4p+g7Tv6LE1QiYr2qkNl7DNH2
    PMFMWx+F7/2w8dLv3tn84zfSomlMzXmIDzyu123tV+O+KkCMzlCBIX7WX9y9bZKB
    ZigTxJyuVDEYBDyixjiZ8q7OizKdRbZIHnGgcT/w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD8B0mK+SSNTU9ncNnI1d5qbzY3z/scgTOP7kPTzLHNkahMl9e29yObIvSuIurbLMeYo9NHSuguOu7HzV7UYwWE5vzs87fYLamyTaGrbdqP1kENEMGe7
    W14rcmuG3yZxCN0Oa4hZ+hM7zS+52mCWnCxPw1+l6GKubtHNoKB2h0ET+RpxZPiGbLzvkTKgjG/MZgzzTdhZ4EO7WnhuH8vqmz2xmRVcS9e6m6PVaBXgzAL7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=w3DoHHLawtSICG2qJXIA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbeDPOBR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 10:01:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755108AbeDPOBP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 10:01:15 -0400
Date: Mon, 16 Apr 2018 16:01:04 +0200
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
Message-ID: <20180416140103.33s2xarrxxeecttk@linutronix.de>
References: <20180216170450.yl5owfphuvltstnt@breakpoint.cc>
 <20180227143934.2aa847ac@vento.lan>
 <20180308095739.okdn7ghvlpy4oiy5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308095739.okdn7ghvlpy4oiy5@linutronix.de>
User-Agent: NeoMutt/20180323
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-08 10:57:39 [+0100], To Mauro Carvalho Chehab wrote:
> On 2018-02-27 14:39:34 [-0300], Mauro Carvalho Chehab wrote:
> > Hi Sebastian,
> Hi Mauro,
> 
> > Sorry for taking some time to test it, has been busy those days...
> :)
> 
> > Anyway, I tested it today. Didn't work. It keep losing data.
> 
> Okay, this was unexpected. What I learned from the thread is that you
> use the dwc2 controller and once upgrade to a kernel which completes the
> URBs in BH context then you starting losing data from your DVB-s USB
> device. And it was assumed that this is because BH/ksoftirq is getting
> "paused" if it is running for too long. If that is the case then a
> revert of "let us complete the URB in BH context" should get it working
> again. Is that so?

ping

Sebastian
