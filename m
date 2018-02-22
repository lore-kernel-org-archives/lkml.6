Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-524998-1519316417-2-15709499165735381194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519316417; b=dTql4Ds67iEi0Ld2GNUYbRhj09rcuoewLfGJ3Cz7mcBOSkf
    Iy5FT2kSIwzU51BLyfgACCQkzbqSXfu9emAfPcQuUmltg77kXlc8GuvgeLh0u349
    nyf0kQA9Tw6eTVk2WNhb9NTrs4NXXYGHYu9o0Gm5izDqzqh+qm6WlkzAc5zZReHl
    BnkgJt+Za3IqMq8NcDxD48u2MRy/tBuWp45l5oLHC0VZmJwdvF/5JgQVxM/1cl73
    IrzK0v72vHaGhEqhcz4ZWHS22mZe9/itVZExErElmzpJQvT6UBLJPr9GsZK3kJY1
    MY8iiOQ63EqYxHgJANxG4YcHmTblhBfB7bgsl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519316417; bh=NfVvBVGBp+BypgsY1Jo2nANHsL
    mECAWm1jNyExo97h8=; b=AEIZq9+AiRI/jeJdCZk9zHj+NfYeeM096Iht+U/MfF
    6HsrY0yB1bXUgZ5D01i51+nZ6EOgY0fv3E06zyPgQY/5dhil+h3MnwiRSPUVblzb
    IcUiyWX4l/eF9YNY4ZKUW5sYYsinUmVBn68SWdv/14ONLjHFMJzbml2HXRUuzTPw
    YxLwJ+yyk3OSt30RKGiJEG8+JsJfv9/JSOasYRmKPCkQREgjuBcrCbr97BZ9bwG6
    zKwAMU/PJ1FeErFqn0HBogoBgNpXryYXXt47ROI6MHz1DYGpcFkvbIek3TEfQrVv
    +FHVavJ4OYgf9mNRblpIWPTf+Gg9M1ACYbjy6svRrUkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933155AbeBVQT5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 11:19:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39532 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeBVQT4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Feb 2018 11:19:56 -0500
Date: Thu, 22 Feb 2018 17:19:50 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] usb: hcd: complete URBs in threaded-IRQ context
 instead of tasklet
Message-ID: <20180222161949.3prjzbvkss4hjj2c@linutronix.de>
References: <20180216203808.23mvv4mtz6khhwfv@linutronix.de>
 <Pine.LNX.4.44L0.1802161623550.1402-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802161623550.1402-100000@iolanthe.rowland.org>
User-Agent: NeoMutt/20171215
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-16 16:46:41 [-0500], Alan Stern wrote:
> > The theaded interrupt runs SCHED_FIFO priority 50 by default. The only
> > thing that can interrupt it are interrupts, a softirq (not ksoftirqd)
> > and other tasks with a higher priority than 50.
> > There should be no downside performance wise.
> 
> Maybe.  It would be nice to see some real measurements.

I had an usb3 flash stick behind the EHCI controller which was passed
through from the host to a kvm guest. The performance numbers in the
guest were equal (some noise was there) with and without the patch.
The numbers with the patch were worse if lockdep was enabled which isn't
much of a surprise.
If you have anything specific requirements for a measurement then please
let me know and I see what I can do.

> Alan Stern

Sebastian
