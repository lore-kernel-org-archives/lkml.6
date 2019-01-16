Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3359C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830BD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9fCXwt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392820AbfAPMhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:37:35 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53413 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbfAPMhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:37:35 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so2690187ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 04:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IjsgAVNq+/mY0dPILU+7uMfkqBhlSb4FD+n4YRYnSk=;
        b=t9fCXwt4TntkM6ZBWGB/ICXIgZ2+gw4Su2q/AGrnTPsF6I7qIsxV5n8LtMYLz6W2Zc
         Dw+uyEyuniGn8Kz1LGzVTLG/TGIffafhUOXedu7m7UkIBPVlfufBXxBL2kYthjo5vUkX
         7NzWnj4LwvodFjEBhlOLnsv0PzsChJb9x02wNCHaN+VzxRGx5rNtBMlm7f6oobLV9+IA
         FEglfkuP9gPW2xbvoXuXybATJymW/ZnbzpGpuw/ajKdjkkk0Yoe19GBWpqymPOob0Voo
         L5f05tHk8zLHk3v6yeqMPjP1mKFYDmJeOI7zOoKi+ndv5ypNjfDTGr7TG2xwklBeC2U9
         9h9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IjsgAVNq+/mY0dPILU+7uMfkqBhlSb4FD+n4YRYnSk=;
        b=ggT9deNyHq6vinONVWD0P9KuWtcWg3gw+YwW3FPQY7JzKkWoI5wB6HMzL1CGXERd9c
         nvoaZMHBheQ9nLNVK6BPTae/aIkNs6raPMMskb/m19c3g3Se8nWJFR5aSXkYOPS3OuZK
         c/jYmXC+8At7GekU0u3+dT1Fmhz/BAs3/MKbBqOPbyy3Z900SyGxxZHeHp7auGMTsj+w
         vgZJDAwPCb9eOJvmaXCNOTCGtt62kJMiqsnNV4NIzFHUI96mf5cPbaLOrBixwqUSFGG6
         c8foiIjmqdIbtQp5vRplrezbus5O2FJUCED9P3ftRkiW8t9MasqtxaBU3tVtwJtxeKRy
         a7ig==
X-Gm-Message-State: AJcUukeeg9ODwkzv2M4gCG6cQJ2X4sTqetafUaUUxEqw3V10yqDZSP3N
        E6mgQTm5+vh1fhW17YCjB3tkHhpGn1uxQ4rxetbwZg==
X-Google-Smtp-Source: ALg8bN5kF//cq6fCxyCbFNRSYFR/Nk85I9ElIgtLR+KmzN2LkYYiIr0c2FuZ5Jp50BvPaC7j1uaEEdxlJCBcxjSZJfw=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr1246485iti.166.1547642253773;
 Wed, 16 Jan 2019 04:37:33 -0800 (PST)
MIME-Version: 1.0
References: <1547201433-10231-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YsuGt32H=_UTXjj-d7fEe6Lo4Nw91R-rZPy1zOyiJ4OA@mail.gmail.com>
 <04c6d87c-fc26-b994-3b34-947414984abe@i-love.sakura.ne.jp>
 <CACT4Y+brHvfKHb2CvkBFRxrm0hXKA+j_eW=orSWGWutcQwZ9iw@mail.gmail.com>
 <CACT4Y+atyYbmrkyX0n+kvBWOt0OaauQbvrRhpUezaHXce5ZDrA@mail.gmail.com>
 <54b68f21-c8b5-7074-74e0-06e3d7ee4003@i-love.sakura.ne.jp>
 <CACT4Y+ZyP2QGL3ENJZRe8qbiL8SB8yDPHRY-npTzb14+LB05RQ@mail.gmail.com>
 <20190116104308.GC26069@quack2.suse.cz> <CACT4Y+akwPNEAiBtd5j6r0M6M7DmXV3kig+bnDL39H7uu44O3Q@mail.gmail.com>
 <20190116115618.GE26069@quack2.suse.cz>
In-Reply-To: <20190116115618.GE26069@quack2.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Jan 2019 13:37:22 +0100
Message-ID: <CACT4Y+ZtrBeZyNeSJ_9d3DdVuP21=h7TNnOZJ_wLhLu11+qAAA@mail.gmail.com>
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

On Wed, Jan 16, 2019 at 12:56 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 16-01-19 12:03:27, Dmitry Vyukov wrote:
> > On Wed, Jan 16, 2019 at 11:43 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 16-01-19 10:47:56, Dmitry Vyukov wrote:
> > > > On Fri, Jan 11, 2019 at 1:46 PM Tetsuo Handa
> > > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > > >
> > > > > On 2019/01/11 19:48, Dmitry Vyukov wrote:
> > > > > >> How did you arrive to the conclusion that it is harmless?
> > > > > >> There is only one relevant standard covering this, which is the C
> > > > > >> language standard, and it is very clear on this -- this has Undefined
> > > > > >> Behavior, that is the same as, for example, reading/writing random
> > > > > >> pointers.
> > > > > >>
> > > > > >> Check out this on how any race that you might think is benign can be
> > > > > >> badly miscompiled and lead to arbitrary program behavior:
> > > > > >> https://software.intel.com/en-us/blogs/2013/01/06/benign-data-races-what-could-possibly-go-wrong
> > > > > >
> > > > > > Also there is no other practical definition of data race for automatic
> > > > > > data race detectors than: two conflicting non-atomic concurrent
> > > > > > accesses. Which this code is. Which means that if we continue writing
> > > > > > such code we are not getting data race detection and don't detect
> > > > > > thousands of races in kernel code that one may consider more harmful
> > > > > > than this one the easy way. And instead will spent large amounts of
> > > > > > time to fix some of then the hard way, and leave the rest as just too
> > > > > > hard to debug so let the kernel continue crashing from time to time (I
> > > > > > believe a portion of currently open syzbot bugs that developers just
> > > > > > left as "I don't see how this can happen" are due to such races).
> > > > > >
> > > > >
> > > > > I still cannot catch. Read/write of sizeof(long) bytes at naturally
> > > > > aligned address is atomic, isn't it?
> > > >
> > > > Nobody guarantees this. According to C non-atomic conflicting
> > > > reads/writes of sizeof(long) cause undefined behavior of the whole
> > > > program.
> > >
> > > Yes, but to be fair the kernel has always relied on long accesses to be
> > > atomic pretty heavily so that it is now de-facto standard for the kernel
> > > AFAICT. I understand this makes life for static checkers hard but such is
> > > reality.
> >
> > Yes, but nobody never defined what "a long access" means. And if you
> > see a function that accepts a long argument and stores it into a long
> > field, no, it does not qualify. I bet this will come at surprise to
> > lots of developers.
>
> Yes, inlining and other optimizations can screw you.
>
> > Check out this fix and try to extrapolate how this "function stores
> > long into a long leads to a serious security bug" can actually be
> > applied to whole lot of places after inlining (or when somebody just
> > slightly shuffles code in a way that looks totally safe) that also
> > kinda look safe and atomic:
> > https://lore.kernel.org/patchwork/patch/599779/
> > So where is the boundary between "a long access" that is atomic and
> > the one that is not necessary atomic?
>
> So I tend to rely on "long access being atomic" for opaque values (no
> flags, no counters, ...). Just value that gets fetched from some global
> variable / other data structure, stored, read, and possibly compared for
> equality. I agree the compiler could still screw you if it could infer how
> that value got initially created and try to be clever about it...

So can you, or somebody else, define a set of rules that we can use to
discriminate each particular case? How can we avoid that "the compiler
could still screw you"?

Inlining is always enabled, right, so one needs to take into account
everything that's possibly can be inlined. Now or in future. And also
link-time-code generation, if we don't use it we are dropping 10% of
performance on the floor.
Also, ensuring that the code works when it's first submitted is the
smaller part of the problem. It's ensuring that it continues to work
in future what's more important. Try to imagine what amount of burden
this puts onto all developers who touch any kernel code in future.
Basically if you slightly alter local logic in a function that does
not do any loads/stores, you can screw multiple "proofs" that long
accesses are atomic. Or, you just move a function from .c file to .h.
I can bet nobody re-proofs all "long accesses are atomic" around the
changed code during code reviews, so these things break over time.
Or, even if only comparisons are involved (that you mentioned as
"safe") I see how that can actually affect compilation process. Say,
we are in the branch where 2 variables compare equal, now since no
concurrency is involved from compiler point of view, it can, say,
discard one variable and then re-load it from the other variable's
location, and say not the other variable has value that the other one
must never have. I don't have a full scenario, but that's exactly the
point. One will never see all possibilities.

It all becomes super slippery slope very quickly. And we do want
compiler to generate as fast code as possible and do all these
optimizations. And it's not that there are big objective reasons to
not just mark all concurrent accesses and stop spending large amounts
of time on these "proofs".
