Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F50C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156A32070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+LY4srb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfADNB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:01:26 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35382 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfADNB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:01:26 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so1411048itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 05:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlDCeVyQcFtZxOeauQhgqrGJnnhrVwiDh6IRjnmb770=;
        b=p+LY4srb4yFiAoFUH8bl088vqz6RJqT7VjEeA0Pp1X5rRC3TNY6A1tJT0nlW/uXXrN
         w/zBKZhmXhGXL8tbvCSX+C5qICclPaC1TIzkcvW3reTsnCpGu2totOjVTZm60u38+Nh4
         NX2sI282T2IWwKqya5SJ17rrU3dVthV4LOPQXKq/RLcHxuV+9D4+qwxg3bFgieyxoCk0
         tb3PvTnHrLrtD+BOHAr50Zver17T9Mpk30vZLoGqcJCAqdJKEnnaNzhD+HV+OKgn2sLN
         B/S7AKvGeydC26AH8pDDW2K7dRWXugK6DALaCsTP/Zev2qHkUcyE8o70W3YnWdwQW23F
         m8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlDCeVyQcFtZxOeauQhgqrGJnnhrVwiDh6IRjnmb770=;
        b=klxqybdqTlU3V7lWVMeLPZdTR7EciujekVhAZYMUSSTtQxf/rO91R+tsAlBNTS++Mo
         bqN2Omnco7vwXoRQ5xeRkgzIu3enU/dHE23fENcKBhDu8tP1ig9bp++4NL98j/JF1I6c
         9ugJ/R6hxXK9kgimJvszanAdhyBIw1QQPOw/K77DR3G1SPvXWDONnsATRBiYUa5I6KdT
         QM0o0g5JFsniu0EdPZgB7qosrVCQGnuxFl56Gx4YI7dtDtACSCyyfuI/U7Ax5gtcDZ8i
         G/CtWscBMU5hPUw7IMR41eKBa7N+hTwlYG9vbYQn84JPm1aOvI8CiDDKKuEumfNkt7/H
         INtw==
X-Gm-Message-State: AA+aEWYhdK6MbssNyp2uUDMdlX4lGdPvR6R/fjCU7Bbml/jYb1+mwAPT
        HfwI3M3rKmZ+FV1NCWT6kAOmNJvcwrXvJQq/3FrHzA==
X-Google-Smtp-Source: AFSGD/UTIizBJeSKE7mLJy9XvTcT+ISo1PBCWYRc0lr4G5ESYRuEF+gF07tNN40ShOk61oBg+YTwTJHpgScf7vDkwbI=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr31670906jan.72.1546606884961;
 Fri, 04 Jan 2019 05:01:24 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+Z37Th9884Y_bqWxbPQZi3aKR9eKMBU8WhA=KF78qxfCA@mail.gmail.com>
 <201804262241.GFB12906.LVOHMOQFJSOFFt@I-love.SAKURA.ne.jp>
 <CACT4Y+a4HhuopcBmXepugO0W98BhcvHk9f3ekf=zMDEpG0pyzg@mail.gmail.com>
 <201805160559.DAE56781.VFSOMFJOHOQLtF@I-love.SAKURA.ne.jp>
 <CACT4Y+ZGEiSEUOFRZZ832KMiKy7zBz-iXjkE2_z8Zes_LTxn6g@mail.gmail.com> <201805170150.JHD52118.LtOFSHMJFQFOOV@I-love.SAKURA.ne.jp>
In-Reply-To: <201805170150.JHD52118.LtOFSHMJFQFOOV@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 14:01:13 +0100
Message-ID: <CACT4Y+ZkuVR2eVW+BqMT=_4rCs=6dbK950qbstNFDk40e7UrmA@mail.gmail.com>
Subject: Re: Column for keywords?
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 6:50 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Dmitry Vyukov wrote:
> > On Tue, May 15, 2018 at 10:59 PM, Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > > Dmitry Vyukov wrote:
> > >> I've filed https://github.com/google/syzkaller/issues/608 to not lose
> > >> track of this.
> > >
> > > Thanks. Since the time lag between a patch was proposed and that patch is
> > > applied to a git tree tends to become long, duplicated works like
> > > https://www.spinics.net/lists/linux-fsdevel/msg125240.html and
> > > http://lkml.kernel.org/r/964a8b27-cd69-357c-fe78-76b066056201@I-love.SAKURA.ne.jp
> > > are already occurring.
> >
> > This is bad.
> >
> > > Therefore, it is important that the state of the bug (e.g.
> > > bisected, cause identified, patch proposed) is visible from the table.
> >
> > What do you think about the last section of:
> > https://groups.google.com/d/msg/syzkaller-bugs/nw7BIW9V2wk/NE0P_Au4AQAJ
> > there is already a way to say "there is a pending fix for this".
>
> That lacks a way to annotate "there is a pending fix for this, but the fix
> is not yet applied to any git tree". I mean not only "git trees which syzbot
> is checking" but also "git trees which are publicly visible".
>
> (Also, if we can later correct the patch using "#syz fix:" in case the patch
> title was renamed, it is not clear how to specify multiple patches using
> "#syz fix:" when a patch which meant to fix the reported problem contained
> a regression or was incomplete and thus fixup patch followed shortly. An
> example is commit 5f3e3b85cc0a5eae and commit ef95a90ae6f4f219 in
> "WARNING: kmalloc bug in memdup_user (2)". I've tried
>
>   #syz fix: RDMA/ucma: Correct option size check using optlen
>   #syz fix: RDMA/ucma: ucma_context reference leak in error path
>
> but only the former patch was recorded.)
>
> >
> > But one problem with manual tagging is how to make everybody update
> > these tags. If only few people do it, it can still lead to duplicate
> > work. And it's not syzbot-specific. Can happen with just any bug
> > report on kernel mailing lists. Traditionally it's solved with bug
> > tracking systems and assigning bugs when a developer starts working on
> > it. But kernel does not have a working bug tracker.
> >
> > One simple thing we can do is make syzbot poll more trees to discover
> > Reported-by tags faster. This will automatically update status on
> > dashboard to "fix pending". I've filed
> > https://github.com/google/syzkaller/issues/610 for this. Ideally, we
> > would intercept all mailed patches, but it's hard with kernel
> > development process because there is no system that tracks all pending
> > patches.
> >
>
> The problem is that the pending fix won't be applied to any git tree.
> It depends on when reviewers and maintainers can find time for
> reviewing/committing the fix. Scanning all git trees unlikely helps.
>
>   the criteria is that you are "reasonably sure that the commit will
>   reach upstream under this title", for whatever reason
>
> won't apply to not yet reviewed patches. What I want is a way to specify
> "a patch was proposed but the patch is not yet reviewed/tested/applied".
>
> Generally, progresses are not recorded frequently enough to avoid duplicated
> works. I want to check not only "fix pending" stage but also e.g. "problem
> guessed", "bisected", "cause identified", "patch proposed", "patch reviewed"
> stages from the top page's table.

1. This sounds very much like general bug tracking system. We
specifically didn't want to go down the slippery slope of implementing
yet another bug tracking system.
2. This problem is not specific to syzbot in any way (just like lost
bug reports). Kernel developers waste time on duplicate work for other
bug reports too.
So I think (1) we need a bug tracking system, (2) use that system for
syzbot to solve this local problem.
