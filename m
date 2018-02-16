Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1024438-1518813511-2-17206139636868502142
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518813511; b=AF7AAKBBZ6WpRIw6B3cOsfHJFmsgQD2p71fpjHAn0h9lXeL
    D+d75qoSrRBdQnBvzO7rP2RDJ1dRLkudJwm+UwtrAxKRlO94gHURvf21bbIcj8GM
    Wb/YM9nOY3As3GKVugQlyPr5uK156ZLnO2wo3xvxV6PtS7G7zKlgvZibith+GHgZ
    vWWDBZZl4cf3CzApohN8hpnZULy+QCYkB6v/GjqNCKDgalS95LjMPz5dOm0+50Uj
    GnENZw/4Y7R/QO8eAwrihTAGzUf2X6vYGy7P3ax3URFKXb131uiTK+OJx+DItFVW
    Oa0KaylvbGFCQB02uZhbmsj/F0ziUkFM8NJ3gXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518813511; bh=VYfwHWw/0l0XyCODLKNfFDi8c1
    XkwOX/ndJvKzvawH8=; b=uCzjyhn7s4cTnGmDb86b4ujfst7ycV7VQCDAuSNWYg
    A9jN+3MO17L5tv4wBHLN5aebmeT1wkldDsKRixpWqWLSI8gwKLPiX+A0h1oi12zB
    ljpDLrUarLofh3l0+pnbr41WlPVhq3Spo4fFFj7xcIf/qm0iVmDcgfx4LDqwqWlW
    S3XAsqrtUSyBrIzgk6vp66ds84xiGN8/79UyawCNpAbwXHcQAcRgCKYXagimkFJ1
    Fud+aA5SeI2pm0Ua4J/mv/046w3NFKZhKtlTwwhEu1Z6KB0nA9J1KC37cnksTgXO
    k7CteAMpIlBoZ5ggSVK9hT/iPmEeJO0JTzKiMNDPW5qA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeBPUiP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 15:38:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57296 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeBPUiO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 15:38:14 -0500
Date: Fri, 16 Feb 2018 21:38:08 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH] usb: hcd: complete URBs in threaded-IRQ context
 instead of tasklet
Message-ID: <20180216203808.23mvv4mtz6khhwfv@linutronix.de>
References: <20180216170450.yl5owfphuvltstnt@breakpoint.cc>
 <Pine.LNX.4.44L0.1802161325050.1402-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1802161325050.1402-100000@iolanthe.rowland.org>
User-Agent: NeoMutt/20171215
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-16 13:29:01 [-0500], Alan Stern wrote:
> We originally used tasklets because we didn't want to incur the delays 
> associated with running in a process context.  It seems odd to be 
> reversing that decision now.

The theaded interrupt runs SCHED_FIFO priority 50 by default. The only
thing that can interrupt it are interrupts, a softirq (not ksoftirqd)
and other tasks with a higher priority than 50.
There should be no downside performance wise.

> > The URBs from the root-hub never create an interrupt so I currently
> > process them in a workqueue (I'm not sure if an URB-enqueue in the
> > completion handler would break something).
> 
> It worked okay before we changed over to using tasklets.

Ah okay. I've seen that HCDs were no longer dropping their internal lock
and I wasn't sure if such a change was also applied in RH-code.

> Alan Stern

Sebastian
