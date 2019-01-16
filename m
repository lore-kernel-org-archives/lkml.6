Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA84C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFED206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+GQ0YfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390427AbfAPPdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:33:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36150 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387579AbfAPPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:33:17 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so3233615itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0zWnXlOnwcet+NgieNEljMhsmXrykLXl7dsbLMVIW0=;
        b=k+GQ0YfOjUEu4m0r1/YAADSoHjK9TJLu1xZstkNVhBejlXTInaIEJsoU31ou4XpTnj
         avBVpe6U901fbMglNt4OQsvy7Nf5JVeTK2jrgs630q2ppiNIgM0whwpXVvB3ByMfvJzb
         NP94/pFnnMTpRqXTN/0fNBL2g7N4b/vaCOhXfi5xAAo9F6qwX2nl9F88//h4H8Yg6pEd
         M/iD+J1wUcTnEGezwv9aJSHaS/pcPtgUPpMbYB2lo9C0tuMBa/D3I1wOKLp3nv5BrHRB
         VS3OoPxwRiICon4QdGBMCKz+SC3rQ9uDCFGkEeBmJ8TgYS6a49tFQLCCq8cKh7snJ4RC
         /DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0zWnXlOnwcet+NgieNEljMhsmXrykLXl7dsbLMVIW0=;
        b=GbtEbpDCIBVrXzmm8IHlmbUYKRyJ6lrExUOyRc54WkPOEMBGa2sAl0FiXC7vT3ePqx
         mCUUJZ3Sdzim9srSZXKNs7B0bCPf39Df+F0rVbZGDz1XaHrZhGULPxQiYWap9y4SLqDt
         u6+oBlkHiZnuTghMF2D3i31KNDEh2p7CU88HThbW0houD8KJF3oqmB6n0rFBU5Fri5av
         MSthIm9H5g3B0rh6NLwcvMQmABUm6OrTbz6CPUKDx171sbpuspdi8cG/j9qmc9z2Icth
         TeYmk4i8vOuJ4nVzQ9SZBd+e2BsMYXuK+vRUdosrzTDf94wAONnGfKWZ5uNLKnipZTDP
         T/7Q==
X-Gm-Message-State: AJcUukcMsm6EtYW8j94gAu1chtzXiGGWg7h5oU5Mn3vQLLuC3AT5NGXF
        xDi78mCrjX73UCcWHebGsd2YqRiMMl6IVVqHKy2ShASk
X-Google-Smtp-Source: ALg8bN5q1OWo4SFtwdTULCuTyWrkmExgsla021NRwMqin1R4hNsttDgRFkxhCDq8lnjNRUafALXOkU1licu57BSOnnA=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr5199110itl.144.1547652796166;
 Wed, 16 Jan 2019 07:33:16 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YsuGt32H=_UTXjj-d7fEe6Lo4Nw91R-rZPy1zOyiJ4OA@mail.gmail.com>
 <04c6d87c-fc26-b994-3b34-947414984abe@i-love.sakura.ne.jp>
 <CACT4Y+brHvfKHb2CvkBFRxrm0hXKA+j_eW=orSWGWutcQwZ9iw@mail.gmail.com>
 <CACT4Y+atyYbmrkyX0n+kvBWOt0OaauQbvrRhpUezaHXce5ZDrA@mail.gmail.com>
 <54b68f21-c8b5-7074-74e0-06e3d7ee4003@i-love.sakura.ne.jp>
 <CACT4Y+ZyP2QGL3ENJZRe8qbiL8SB8yDPHRY-npTzb14+LB05RQ@mail.gmail.com>
 <20190116104308.GC26069@quack2.suse.cz> <CACT4Y+akwPNEAiBtd5j6r0M6M7DmXV3kig+bnDL39H7uu44O3Q@mail.gmail.com>
 <20190116115618.GE26069@quack2.suse.cz> <CACT4Y+ZtrBeZyNeSJ_9d3DdVuP21=h7TNnOZJ_wLhLu11+qAAA@mail.gmail.com>
 <20190116145130.GH26069@quack2.suse.cz>
In-Reply-To: <20190116145130.GH26069@quack2.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Jan 2019 16:33:05 +0100
Message-ID: <CACT4Y+Y0Q=ZoQfV9cBozhCe1ujCcydhhUwzBwucniX+fQ_S5EA@mail.gmail.com>
Subject: Re: [PATCH] fs: ratelimit __find_get_block_slow() failure message.
To:     Jan Kara <jack@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 3:51 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 16-01-19 13:37:22, Dmitry Vyukov wrote:
> > On Wed, Jan 16, 2019 at 12:56 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 16-01-19 12:03:27, Dmitry Vyukov wrote:
> > > > On Wed, Jan 16, 2019 at 11:43 AM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Wed 16-01-19 10:47:56, Dmitry Vyukov wrote:
> > > > > > On Fri, Jan 11, 2019 at 1:46 PM Tetsuo Handa
> > > > > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > > > > >
> > > > > > > On 2019/01/11 19:48, Dmitry Vyukov wrote:
> > > > > > > >> How did you arrive to the conclusion that it is harmless?
> > > > > > > >> There is only one relevant standard covering this, which is the C
> > > > > > > >> language standard, and it is very clear on this -- this has Undefined
> > > > > > > >> Behavior, that is the same as, for example, reading/writing random
> > > > > > > >> pointers.
> > > > > > > >>
> > > > > > > >> Check out this on how any race that you might think is benign can be
> > > > > > > >> badly miscompiled and lead to arbitrary program behavior:
> > > > > > > >> https://software.intel.com/en-us/blogs/2013/01/06/benign-data-races-what-could-possibly-go-wrong
> > > > > > > >
> > > > > > > > Also there is no other practical definition of data race for automatic
> > > > > > > > data race detectors than: two conflicting non-atomic concurrent
> > > > > > > > accesses. Which this code is. Which means that if we continue writing
> > > > > > > > such code we are not getting data race detection and don't detect
> > > > > > > > thousands of races in kernel code that one may consider more harmful
> > > > > > > > than this one the easy way. And instead will spent large amounts of
> > > > > > > > time to fix some of then the hard way, and leave the rest as just too
> > > > > > > > hard to debug so let the kernel continue crashing from time to time (I
> > > > > > > > believe a portion of currently open syzbot bugs that developers just
> > > > > > > > left as "I don't see how this can happen" are due to such races).
> > > > > > > >
> > > > > > >
> > > > > > > I still cannot catch. Read/write of sizeof(long) bytes at naturally
> > > > > > > aligned address is atomic, isn't it?
> > > > > >
> > > > > > Nobody guarantees this. According to C non-atomic conflicting
> > > > > > reads/writes of sizeof(long) cause undefined behavior of the whole
> > > > > > program.
> > > > >
> > > > > Yes, but to be fair the kernel has always relied on long accesses to be
> > > > > atomic pretty heavily so that it is now de-facto standard for the kernel
> > > > > AFAICT. I understand this makes life for static checkers hard but such is
> > > > > reality.
> > > >
> > > > Yes, but nobody never defined what "a long access" means. And if you
> > > > see a function that accepts a long argument and stores it into a long
> > > > field, no, it does not qualify. I bet this will come at surprise to
> > > > lots of developers.
> > >
> > > Yes, inlining and other optimizations can screw you.
> > >
> > > > Check out this fix and try to extrapolate how this "function stores
> > > > long into a long leads to a serious security bug" can actually be
> > > > applied to whole lot of places after inlining (or when somebody just
> > > > slightly shuffles code in a way that looks totally safe) that also
> > > > kinda look safe and atomic:
> > > > https://lore.kernel.org/patchwork/patch/599779/
> > > > So where is the boundary between "a long access" that is atomic and
> > > > the one that is not necessary atomic?
> > >
> > > So I tend to rely on "long access being atomic" for opaque values (no
> > > flags, no counters, ...). Just value that gets fetched from some global
> > > variable / other data structure, stored, read, and possibly compared for
> > > equality. I agree the compiler could still screw you if it could infer how
> > > that value got initially created and try to be clever about it...
> >
> > So can you, or somebody else, define a set of rules that we can use to
> > discriminate each particular case? How can we avoid that "the compiler
> > could still screw you"?
> >
> > Inlining is always enabled, right, so one needs to take into account
> > everything that's possibly can be inlined. Now or in future. And also
> > link-time-code generation, if we don't use it we are dropping 10% of
> > performance on the floor.
> > Also, ensuring that the code works when it's first submitted is the
> > smaller part of the problem. It's ensuring that it continues to work
> > in future what's more important. Try to imagine what amount of burden
> > this puts onto all developers who touch any kernel code in future.
> > Basically if you slightly alter local logic in a function that does
> > not do any loads/stores, you can screw multiple "proofs" that long
> > accesses are atomic. Or, you just move a function from .c file to .h.
> > I can bet nobody re-proofs all "long accesses are atomic" around the
> > changed code during code reviews, so these things break over time.
> > Or, even if only comparisons are involved (that you mentioned as
> > "safe") I see how that can actually affect compilation process. Say,
> > we are in the branch where 2 variables compare equal, now since no
> > concurrency is involved from compiler point of view, it can, say,
> > discard one variable and then re-load it from the other variable's
> > location, and say not the other variable has value that the other one
> > must never have. I don't have a full scenario, but that's exactly the
> > point. One will never see all possibilities.
> >
> > It all becomes super slippery slope very quickly. And we do want
> > compiler to generate as fast code as possible and do all these
> > optimizations. And it's not that there are big objective reasons to
> > not just mark all concurrent accesses and stop spending large amounts
> > of time on these "proofs".
>
> I guess you've convinced me that somehow marking such accesses is
> desirable. So is using atomic_long_t and atomic_long_set()
> / atomic_long_read() for manipulation instead what you suggest?

+Paul, Alan, Andrea, who may better know the long-term direction.
I think the closer analog of "plain long read/write that is intended
to be atomic" is using READ_ONCE/WRITE_ONCE with a normal non-atomic
type. It should achieve the goal of just read/write it once without
any tricks, but also makes them visible/searchable for humans and
tools and potential future refactoring to something else.
