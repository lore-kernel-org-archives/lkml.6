Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E13FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E921D20665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ex+AJ+0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfAIM3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:29:15 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:39003 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfAIM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:29:15 -0500
Received: by mail-io1-f41.google.com with SMTP id k7so5848889iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 04:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xz9XvYQlPvtu4VoTjEIXbUhWo6snBECT8rAgO58gWDg=;
        b=ex+AJ+0FKnLs9vD70L3Xo63cVdbFSWEkgkHY0G3o8fuUfepJSFscTI6WUu/cavuEWk
         fdxRFiujxgZoK5kuUN9ZVmXFE//KW4Cx/C2yENDCBAc1ujXV4tA3HAkciW5iFR1YUZBj
         GPUd4LkQ/b3ztba8UstVzPEKqPE06IRw92TDGYxDwLQYPwqoTymh6tCDdANACDFt52rR
         rH5/Glv4TaAc5kBJmY3KHVcMArOvOnl1znFc8dzPooEHK+HBGuk1MZBspZx4E67gDXid
         zAfYSbEctwH81CM3PZE5LrbC0nbQkK/dn8y20zWN236qJuysxzq7ngFVYeRkQLD4L8Yb
         7nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xz9XvYQlPvtu4VoTjEIXbUhWo6snBECT8rAgO58gWDg=;
        b=D4M0XyL/Bkg0oKQkj8NICQQDnY38HYLU1CSZQ7Rp7gQlyCLCyKpatksiruIn5LOafY
         7ssAcUh0wgoqM0uYXPnMCGoIpViXTApSJU0Xz8GZEt4GbsChdeJI2BilBmtv6zZSCJXK
         jldAWln12xqBkBcy49YvYT/YfG0oaP6m8nHhD49+any4cLjN+7T/kxE42Be0wha3TdxV
         F3UXc99Y8tTblAHuG/TaE+4Y6wBwSQC9b4H69QEGe+1zGQK7FJUPSgWcAyDqG5Mwc2At
         IMivswkHzmiVrcdCZiFNMJVuyGmJonDMHtPqUktSbJcZbyKbtbHF7+9e6KdUu6Aik/Ck
         FuRg==
X-Gm-Message-State: AJcUukeLlMmru4URcNsJCnBEzRVDBe05I9Ewd6HZGFQkR1ldTsQYUBzT
        SF2mnUWrbftctpxUF22FDiBkc+nXrroE0Gtw2gagXA==
X-Google-Smtp-Source: ALg8bN6lu20Dy2TMqL70IOmfmpZ0loSv8YGjTy01I7L0EI7kGUXcK4sOHp8ckGfQK+UvZurLUE2xfAmM0X7VLWExIKo=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr3070950ior.282.1547036953894;
 Wed, 09 Jan 2019 04:29:13 -0800 (PST)
MIME-Version: 1.0
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea> <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea> <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
 <20190109121126.GA7141@andrea>
In-Reply-To: <20190109121126.GA7141@andrea>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Jan 2019 13:29:02 +0100
Message-ID: <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Paul McKenney <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:11 PM Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> On Wed, Jan 09, 2019 at 12:55:27PM +0100, Dmitry Vyukov wrote:
> > On Wed, Jan 9, 2019 at 12:24 PM Andrea Parri
> > <andrea.parri@amarulasolutions.com> wrote:
> > >
> > > On Tue, Jan 08, 2019 at 04:36:46PM -0800, Anatol Pomozov wrote:
> > > > Hello
> > > >
> > > > On Tue, Jan 8, 2019 at 4:02 PM Andrea Parri
> > > > <andrea.parri@amarulasolutions.com> wrote:
> > > > >
> > > > > Hi Anatol,
> > > > >
> > > > > On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > > > > > Hello folks,
> > > > > >
> > > > > > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > > > > > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > > > > > and makes sure it is accessed in a thread-safe manner.
> > > > >
> > > > > Interesting!  FYI, some LKMM's maintainers (Paul included) had and
> > > > > continued to have some "fun" discussing topics related to "thread-
> > > > > safe memory accesses": I'm sure that they'll be very interested in
> > > > > such work of yours and eager to discuss your results.
> > > >
> > > > Thread Sanitizer is a great tool to find thread-safety issues with
> > > > user-space code. The tool been developed by a team of smart people
> > > > from Google [1].
> > > >
> > > > KTSAN is an attempt to bring the same ideas to Linux kernel [2]. A
> > > > bunch of work been done there but the project is still at
> > > > proof-of-concept point.
> > >
> > > Yes, I have been aware of these tools since at least  ;-)
> > >
> > >   https://groups.google.com/forum/#!msg/ktsan/bVZ1c6H2NE0/Dxrw55bfBAAJ
> > >
> > >
> > > >
> > > > I am not a part of Google's dynamic tools team. But I've decided to
> > > > pick something to do during the New Year holidays so started porting
> > > > KTSAN from v4.2 to v4.20. The work is "almost completed" but I need to
> > > > fix a few crashes [3].
> > >
> > > I guess my first reaction would remain
> > >
> > >   "it's kind of hard (to use an euphemism) to review 7,582 additions
> > >   or so for a data race detector without a clear/an accepted (by the
> > >   community) notion of data race..."
> >
> > Tsan's notion of a data race is basically the C/C++'s notion:
> > concurrent/unsynchronized non-atomic access in different threads at
> > least one of which is a write.
>
> Yeah, I think that this notion needs to be detailed, discussed,
> documented, and discussed again. ;-)
>
>
> > Tremendous (for such a project) benefits of automatic data race
> > detection is a good motivation to finally agree on and accept a
> > practically useful notion of a data race.
>
> Agreed.


While having a 100% formal definition of a data race upfront would be
useful, I don't think this is a hard requirement for deployment of
KTSAN. What I think is required is:
1. Agree that the overall direction is right.
2. Agree that we want to enable data race detection and resolve
problems as they appear in a practical manner (rather than block whole
effort on every small thing).
We deployed TSAN in user-space in much larger code bases than kernel,
and while we had the C/C++ formal definition of a data race, practical
and legacy matters were similar to that of the kernel (lots of legacy
code, different opinions, etc). Doing both things in tandem (defining
a memory model and deploying a data race detector) can actually have
benefits as a race detector may point to under-defined or
impractically defined areas, and will otherwise help to validate that
the model works and is useful.
KTSAN is not fixed as well. We adopted it as we gathered more
knowledge and understanding of the kernel. So it's not that we have to
commit to something upfront.
