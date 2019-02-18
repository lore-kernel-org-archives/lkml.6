Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11294C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD13E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfBRUhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:37:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33858 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfBRUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:37:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id w4so20757524qtc.1;
        Mon, 18 Feb 2019 12:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKzlvpPCBfl/HspEfo61GVQogaZ+wGy+HESxChrvz/4=;
        b=mSNHqZ/QKfHVLu+B1vDkjtt5yC+z2uhcK8+ZnibRNkKEgKMc7wzPQcr5u1osZ9bIB8
         PqfZx2ikFbtYN1gJyP3BxpTEVk50U7bh/5bqbYLEA3gfZsnxJBycs2c8WWqDXpzh+OJL
         PM0mAU4mzHVBZy1A2/l0CNMbaIetE7vAyQHMI4HRPfYG7GDNaaewI7VWGpU0nZZIB2UL
         dRV3XXOYHEC/E0pi79rMd8JoOmXby3Coxb6iQELyQP8uV0pTP5hJsS8nLd+ZI1sI++gp
         yUAJbbK6wUC4qjS08Exw328glNz3OKOss22SUAz43WPHTZv/PLxayj33kJtmo2RuyM5u
         EcCQ==
X-Gm-Message-State: AHQUAuYqJJFV5F4L7vHNstdJDLzk1JzSGB0C2+Ij1VkPkxFFutywumCQ
        5xBUbW2qvq16HBtgoa84CN2y1KLvLHpR5b2r8FI=
X-Google-Smtp-Source: AHgI3IZnd346+DQECP+ADDSsCH9kiGtCJblvuGer6EDdlx2/LUKdYeBFiLnjWli2BWR/+UbufjYelw5o+ONVEVOHgkc=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr19070263qtm.96.1550522261697;
 Mon, 18 Feb 2019 12:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20190211172948.3322-1-will.deacon@arm.com> <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
 <20190218162954.GB16713@fuggles.cambridge.arm.com> <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
 <20190218175625.GD16713@fuggles.cambridge.arm.com>
In-Reply-To: <20190218175625.GD16713@fuggles.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 21:37:25 +0100
Message-ID: <CAK8P3a2mjjr94hwj_eXxfyKDKDuA=MogXW7xJygh-X0Hqgf6rg@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O BARRIER
 EFFECTS" section
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 6:56 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Mon, Feb 18, 2019 at 05:59:13PM +0100, Arnd Bergmann wrote:
> > On Mon, Feb 18, 2019 at 5:30 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > >
> > > > ioremap_wc() in turn is used almost exclusively to map RAM behind
> > > > a bus, (typically for frame buffers) and we may be better off not
> > > > assuming any particular MMIO barrier semantics for it at all, but possibly
> > > > audit the few uses that are not frame buffers.
> > >
> > > Right, my expectation is actually that you very rarely need ordering
> > > guarantees for wc mappings, and so saying "relaxed + mandatory barriers"
> > > is the best thing to say for portable driver code. I'm deliberately /not/
> > > trying to enumerate arch or device-specific behaviours.
> >
> > That's fine, my worry is more that you are already saying too much
> > by describing a behavior for ioremap_wc+relaxed+barrier that is
> > neither a good idea or guaranteed to do what you describe.
>
> I could drop the mention of relaxed accessors here for now, if you like?
> For example:
>
>   "__iomem pointers obtained with non-default attributes (e.g. those returned
>    by ioremap_wc()) are unlikely to provide many of these guarantees. If
>    ordering is required for such mappings, then the mandatory barriers should
>    be used."
>
> which we could flesh out if/when we have a notion of the portable semantics.

I'd go further then and drop the second sentence entirely until we are sure
what portable behaviour would be.

> >
> > I would say we should strengthen the behavior of outX() where possible.
> > I don't know if arm64 actually has a way of doing that, my understanding
> > earlier was that the AXI bus was already posted, so there is not much
> > you can do here to define __io_paw() in a way that will prevent posted
> > writes.
>
> If we could map I/O space using different page table attributes (probably by
> hacking pci_remap_iospace() ?) then we could disable the
> early-write-acknowledge hint and implement __io_paw() as a completion
> barrier, although it would be at the mercy of the system as to whether or
> not that requires a response from the RC.

Ah, it seems we actually do that on 32-bit ARM, at least on one platform,
see 6a02734d420f ("ARM: mvebu: map PCI I/O regions strongly ordered")
and prior commits.

> I would still prefer to document the weaker semantics as the portable
> interface, unless there are portable drivers relying on this today (which
> would imply that it's widely supported by other architectures).

I don't know of any portable driver that actually relies on it, but
that's mainly because there are very few portable drivers that
use inb()/outb() in the first place. How many of those require
the non-posted behavior I don't know

Adding Thomas, Gregory and Russell to Cc, as they were involved
in the discussion that led to the 32-bit change, maybe they are
aware of a specific example.

       Arnd
