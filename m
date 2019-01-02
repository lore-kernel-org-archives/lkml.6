Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41253C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053E8218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0Z9W7W+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfABS35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 13:29:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52773 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfABS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 13:29:56 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so42089102itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 10:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9SJWAAY9/QXJCI4Fl7OpN64fV1E5Pup0uWqSCVW0E0=;
        b=O0Z9W7W+4aozqnfp0HoWpaEDW+EyNHpaTcHcnBiPZ4xczP7WE4sku38nwwbO8tmvr4
         iLiy7XU3Fsoh8Qm+fNc2+RZxhv1VryvhrfK8Ss2TEETv8SM+PrL63qGabIFWE4jVX3DG
         79sCrtVBHeu9MFs8Or6Y2gL4PE07Uc3lpJEfEo3OuFMknVnTz4WEhSHj9OQrFKOtVRSp
         ABVNd04RTDQ+S/H1L/rFr3bV9L2/QC64MWgwyDkpyPuPaptZft4EGlNFtNA1JTE1b/7R
         Qq9a3TQQK1ZiZEVgSt1NRe+6a1oeQDxgkBUoex3ORftsLmKrp9k1o/TI2sXfWgk614yc
         x9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9SJWAAY9/QXJCI4Fl7OpN64fV1E5Pup0uWqSCVW0E0=;
        b=PwqHwqBE3jKvR0GMu1tO8zoYjVx836/aBt38tYzHs0cds3JomNLEUVboC8MZo0Y4D1
         0yxjKhZkfQ5GdM09HXC99JWNmnRExR4olG2gYIBxz7cXdQbgvAFn0SVpzuiISlqyjwL+
         ohuIWBt/vb3JUHEdVb8lXeK29YAumeEI9I6OkLunvPq+jVmynBScgfrbPsSaNoGw7B0U
         O+MOh3dB/LyW5w1ME3lBad3HdplsmXgttBnVETkKnkU1fc8ZyI28Xtpf/on8PI/NablR
         wJFFHIFhCb3A1faIyqX3G+tQuyXLvLhx4YlfdfhgricxzVxDWcUonobyGo2rv11EGGVd
         N/bQ==
X-Gm-Message-State: AA+aEWbu9/ZQP6seKHquVBE4gWtHfqmO5HU1A3wlyvruFKxnMnrjLCpU
        lG08Qtl4bnNp3PTvAJAOWrC12QV44QFCWTprHDNEvw==
X-Google-Smtp-Source: AFSGD/W1I60Vw1bn7yGCdnLtnh1tD0To3yq/OKcokKIE45lZQKx2QO8AQ0mdMz8dcO7HvLgRUdOBkShCKMKRIMBj+SI=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr27388743jan.72.1546453795043;
 Wed, 02 Jan 2019 10:29:55 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f67ca2057e75bec3@google.com> <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190102180611.GE31517@techsingularity.net>
In-Reply-To: <20190102180611.GE31517@techsingularity.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 19:29:43 +0100
Message-ID: <CACT4Y+YMc0hiU-taTmwvm_6u4hAruBWV0qAz_Bp4f2a6JC-UiA@mail.gmail.com>
Subject: Re: possible deadlock in __wake_up_common_lock
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux@dominikbrodowski.net,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        xieyisheng1@huawei.com, zhong jiang <zhongjiang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 7:06 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 02, 2019 at 01:51:01PM +0100, Vlastimil Babka wrote:
> > On 1/2/19 9:51 AM, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    f346b0becb1b Merge branch 'akpm' (patches from Andrew)
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1510cefd400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c255c77ba370fe7c
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=93d94a001cfbce9e60e1
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com
> > >
> > >
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > 4.20.0+ #297 Not tainted
> > > ------------------------------------------------------
> > > syz-executor0/8529 is trying to acquire lock:
> > > 000000005e7fb829 (&pgdat->kswapd_wait){....}, at:
> > > __wake_up_common_lock+0x19e/0x330 kernel/sched/wait.c:120
> >
> > From the backtrace at the end of report I see it's coming from
> >
> > >   wakeup_kswapd+0x5f0/0x930 mm/vmscan.c:3982
> > >   steal_suitable_fallback+0x538/0x830 mm/page_alloc.c:2217
> >
> > This wakeup_kswapd is new due to Mel's 1c30844d2dfe ("mm: reclaim small
> > amounts of memory when an external fragmentation event occurs") so CC Mel.
> >
>
> New year new bugs :(

Old too :(
https://syzkaller.appspot.com/#upstream-open

> > > but task is already holding lock:
> > > 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: spin_lock
> > > include/linux/spinlock.h:329 [inline]
> > > 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue_bulk
> > > mm/page_alloc.c:2548 [inline]
> > > 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: __rmqueue_pcplist
> > > mm/page_alloc.c:3021 [inline]
> > > 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue_pcplist
> > > mm/page_alloc.c:3050 [inline]
> > > 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at: rmqueue
> > > mm/page_alloc.c:3072 [inline]
> > > 000000009bb7bae0 (&(&zone->lock)->rlock){-.-.}, at:
> > > get_page_from_freelist+0x1bae/0x52a0 mm/page_alloc.c:3491
> > >
> > > which lock already depends on the new lock.
> >
> > However, I don't understand why lockdep thinks it's a problem. IIRC it
> > doesn't like that we are locking pgdat->kswapd_wait.lock while holding
> > zone->lock. That means it has learned that the opposite order also
> > exists, e.g. somebody would take zone->lock while manipulating the wait
> > queue? I don't see where but I admit I'm not good at reading lockdep
> > splats, so CCing Peterz and Ingo as well. Keeping rest of mail for
> > reference.
> >
>
> I'm not sure I'm reading the output correctly because I'm having trouble
> seeing the exact pattern that allows lockdep to conclude the lock ordering
> is problematic.
>
> I think it's hungup on the fact that mod_timer can allocate debug
> objects for KASAN and somehow concludes that the waking of kswapd is
> problematic because potentially a lock ordering exists that would trip.
> I don't see how it's actually possible though due to either a lack of
> imagination or maybe lockdep is being cautious as something could change
> in the future that allows the lockup.
>
> There are a few options I guess in order of preference.
>
> 1. Drop zone->lock for the call. It's not necessarily to keep track of
>    the IRQ flags as callers into that path already do things like treat
>    IRQ disabling and the spin lock separately.
>
> 2. Use another alloc_flag in steal_suitable_fallback that is set when a
>    wakeup is required but do the actual wakeup in rmqueue() after the
>    zone locks are dropped and the allocation request is completed
>
> 3. Always wakeup kswapd if watermarks are boosted. I like this the least
>    because it means doing wakeups that are unrelated to fragmentation
>    that occurred in the current context.
>
> Any particular preference?
>
> While I recognise there is no test case available, how often does this
> trigger in syzbot as it would be nice to have some confirmation any
> patch is really fixing the problem.

This info is always available over the "dashboard link" in the report:
https://syzkaller.appspot.com/bug?extid=93d94a001cfbce9e60e1

In this case it's 1. I don't know why. Lock inversions are easier to
trigger in some sense as information accumulates globally. Maybe one
of these stacks is hard to trigger, or maybe all these stacks are
rarely triggered on one machine. While the info accumulates globally,
non of the machines are actually run for any prolonged time: they all
crash right away on hundreds of known bugs.

So good that Qian can reproduce this.
