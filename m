Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-793053-1519325128-2-7263601565190917190
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519325127; b=bQ6jtiR7C/gCFjX2Kyo92hzJGEQwfU08iY4CcmyG53RLrD0
    W9qIr8+avO/S2c5bHHUzG5XHk2fWBaQXVsPP1idUSP3+OVRxMJgMeTCYYaLIJim4
    5CcAdXM9ds3aNGxrFasM34YOx3cdJRRfhg9eecoyGhh2CfV5WblxqhT0HMJ65J1b
    3dFZLdPPc+bByfpZczdB7d+IX8mgzGArxWWFULxjay+cDNNsi2FsEPhFjsne6X/Z
    P6Cp9m4BPI4Cm7qyIsYfQ/TbTQs3581qolb+hUlPVdBEZderKOojcyvRJ9ThXt0+
    1qWqLC6t7yqu/v63a1J90WUcS1S3DMXCXlNOfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=arctest;
    t=1519325127; bh=bodfI+8+XUKSt/k6AytBMA6ZUauynrlgxH/v3qEew7w=; b=
    Fkx7Pb2MKPXisl3b/oAGETqNFIML1FAZJrVKQ9FsOfjCaQKorAz0Uk7Sq34xFU4d
    cxU91HT/YtIs3kf3d77G1cgSvXyZQv3nnxa4Bdc30lG8+3bGLyKnnxjxr7W5xaPs
    U1X8juXuMILBHSunDNH4yJMHErOvD3GB7WlasTVHN9VEcRuUVA+oac0Qytedagaa
    LMR8nQUWvLQrqAFj2zKYmmvDEJP12M3JCi8mkC46LC3m62Lrd0Rm2vKYb6VUjdlr
    H8klJmbF4KO1JopYep9/zXicN7bj1r0Lh+YUtCAYq7stmIIzIq9W2++cBJVntKZR
    lpSkjYEBuQLsMVZdXg0epQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750816AbeBVSpL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 13:45:11 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:48438 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1750725AbeBVSpL (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Feb 2018 13:45:11 -0500
Date: Thu, 22 Feb 2018 13:45:09 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: hcd: complete URBs in threaded-IRQ context
 instead of tasklet
In-Reply-To: <20180222161949.3prjzbvkss4hjj2c@linutronix.de>
Message-ID: <Pine.LNX.4.44L0.1802221336520.1295-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018, Sebastian Andrzej Siewior wrote:

> On 2018-02-16 16:46:41 [-0500], Alan Stern wrote:
> > > The theaded interrupt runs SCHED_FIFO priority 50 by default. The only
> > > thing that can interrupt it are interrupts, a softirq (not ksoftirqd)
> > > and other tasks with a higher priority than 50.
> > > There should be no downside performance wise.
> > 
> > Maybe.  It would be nice to see some real measurements.
> 
> I had an usb3 flash stick behind the EHCI controller which was passed
> through from the host to a kvm guest. The performance numbers in the
> guest were equal (some noise was there) with and without the patch.
> The numbers with the patch were worse if lockdep was enabled which isn't
> much of a surprise.
> If you have anything specific requirements for a measurement then please
> let me know and I see what I can do.

No, I didn't have anything more specific in mind.

In principle then, using threaded-interrupt bottom halves instead of
tasklets should be fine.  I don't object to making such a change.

However, using a work queue for root-hub URBs is pretty ugly.  It would
be better to reinstate the code that dropped hcd_root_hub_lock around
root-hub givebacks, which was removed by commit 94dfd7edfd5c ("USB:
HCD: support giveback of URB in tasklet context"); then it would be 
safe to give back those URBs in the bottom half.

Alan Stern

