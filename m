Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92AFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23FA214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AGvU7tBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfAJNZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:25:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37371 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfAJNZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:25:35 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so16166128iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GD460gEP7FnZL80eaz0o9tm8fvvmnxawgy5o76W5YpM=;
        b=AGvU7tBBSh/FBdc83RAVHJzgv/C4bfYMoYqHHiFgTYDBpnBUshQDa+IGOcNyds+H+M
         2AZAibK+WHuMDtcmywtWb9uVWKcAxO8i4+VX4+JPXKF8In9rVqcQdAQTzcqTFWfCi9zr
         7JzJIxZ3rJcuCInz+zMUhztHstmAQAGd2cX8dK0wfd8r7rRRDPmjDc40KJSNAjO1LO2b
         T+UWHA94b46o7a3UQXNaDx2RefkK9wMfi1znxe3Q9wDvT8AVMOklyPEJjDMda0YVZNMR
         F8cAm8egaTvCsxr42gMlwKNV6CBhH43WeMFVhjoSyPk5ox7eYLD3+O27OyWLUKVfWdpB
         WScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GD460gEP7FnZL80eaz0o9tm8fvvmnxawgy5o76W5YpM=;
        b=aXvkQURiW5aq92Ps6xWmiPVxXXxmTGOINAjyZGHagMRJhSJWM8oEPUO8xG8Ggi4QnX
         OXOABdnibJ2nxcwhW5IXoW65/Dfo0y/7PpTa4Dk0cnScVVQfYAPbnnq37VioP4yAaH0u
         BsdSgKeAxIvl2Ifn5MR1xraiuh23Y0nq2DmgWRD6iZ2gJlF13QyS/kNDTKSutzFch9jz
         tpIqkpsnkGNTS5EdLpYcfMoYLbdMXz3WKgSnIz87sofLB4ucGhejVJQsFvWRC7IeLbV7
         OxpZ6jd5mpIw+kTuIi2lk6ObuBz3+aBYRLJ/qS2Y4oWEwG5FuWOW71Mqer4fy85TpD5D
         9cMg==
X-Gm-Message-State: AJcUukenIMPd1UoTvikmgGkPyyEkN5s8g0TX1GVG+ybkGhFhWfSrVU0r
        C1xVNRdHuc87+mcWkawCNZI1S0dBkMS4NH1bIN9C4g==
X-Google-Smtp-Source: ALg8bN6y5IWbRiSWyQwXtjauyODUAxAWXUifLg2uPKkav8TtPihdx1KeWmTz63LLBy4FNAjwiCxKvw4j89qASj9z280=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr6472289iti.166.1547126732395;
 Thu, 10 Jan 2019 05:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20190109000214.GA5907@andrea> <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea> <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
 <20190109121126.GA7141@andrea> <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
 <20190109171053.GY1215@linux.ibm.com> <CACT4Y+ZZYxE5z4_wZ_Na3z6Y-RmhfrHt3y3sQzUcdUuR35Xc_g@mail.gmail.com>
 <20190110123008.GA13625@andrea> <CACT4Y+ZMcQ3aF+mJws2mzbHww=ZGB9XQkPU5YUsicNS9SKwD_A@mail.gmail.com>
 <20190110124655.GA13986@andrea>
In-Reply-To: <20190110124655.GA13986@andrea>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Jan 2019 14:25:20 +0100
Message-ID: <CACT4Y+ZBfHPEk3yff1pdGUra=tiZxdGprrb7OedoLvg2VHaVKQ@mail.gmail.com>
Subject: Re: seqcount usage in xt_replace_table()
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
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

On Thu, Jan 10, 2019 at 1:47 PM Andrea Parri
<andrea.parri@amarulasolutions.com> wrote:
>
> On Thu, Jan 10, 2019 at 01:38:11PM +0100, Dmitry Vyukov wrote:
> > On Thu, Jan 10, 2019 at 1:30 PM Andrea Parri
> > <andrea.parri@amarulasolutions.com> wrote:
> > >
> > > > For seqcounts we currently simply ignore all accesses within the read
> > > > section (thus the requirement to dynamically track read sections).
> > > > What does LKMM say about seqlocks?
> > >
> > > LKMM does not currently model seqlocks, if that's what you're asking;
> > > c.f., tools/memory-model/linux-kernel.def for a list of the currently
> > > supported synchronization primitives.
> > >
> > > LKMM has also no notion of "data race", it insists that the code must
> > > contain no unmarked accesses; we have been discussing such extensions
> > > since at least Dec'17 (we're not quite there!, as mentioned by Paul).
> >
> > How does it call cases that do contain unmarked accesses then? :)
>
> "work-in-progress" ;), or "limitation" (see tools/memory-model/README)

Let's call it /data race/ interim then :)
Which also have literally undefined behavior in LKMM. Which now
precisely matches the implementation language (C) definitions. Which
is nice.

> > > My opinion is that ignoring all accesses within a given read section
> > > _can_ lead to false negatives
> >
> > Absolutely. But this is a deliberate decision.
> > For our tools we consider priority 1: no false positives. Period.
> > Priority 2: also report some true positives in best effort manner.
>
> This sound reasonable to me.  But please don't overlook the fact that
> to be able to talk about "false positive" and "false negative" (for a
> data race detector) we need to agree about "what a data race is".

Having a formal model would be undoubtedly good.
But in practice things are much simpler. The complex cases that
majority of LKMM deals with are <<1% of kernel concurrency. The
majority of kernel cases are "no concurrent accesses at all", "always
protected by a mutex", "passed as argument to a new thread", "the
canonical store-release/load-acquire synchronization". For these I
hope there is no controversy across C, POSIX, gcc, clang, kernel.
Handling these cases in a race detector brings 99.9% of benefit. And
for more complex cases (like seqlock) we can always approximate as "no
races there" which inevitably satisfy our priorities (if you report
nothing, you don't report false positives).

But I am much more concerned about actual kernel code and behavior wrt
a memory model. We are talking about interaction between LKMM <->
KTSAN. When a way more important question is LKMM <-> actual kernel
behavior. KTSAN is really a secondary thing in this picture. So if
anything needs a memory model, or needs to be blocked on a memory
model, that's writing kernel code ;)


> (The hope, of course, is that the LKMM will have a say soon here ...)
>
>   Andrea
>
>
> >
> > > (in every possible definition of "data
> > > race" and "read sections" I can think of at the moment ;D):
> > >
> > >         P0                              P1
> > >         read_seqbegin()                 x = 1;
> > >         r0 = x;
> > >         read_seqretry() // =0
> > >
> > > ought to be "racy"..., right?  (I didn't audit all the callsites for
> > > read_{seqbegin,seqretry}(), but I wouldn't be surprised to find such
> > > pattern ;D ... "legacy", as you recalled).
> > >
> > >   Andrea
