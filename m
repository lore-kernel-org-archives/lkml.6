Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24EEC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7919720656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUf/WW1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbeLNNmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:42:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43367 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNNmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:42:45 -0500
Received: by mail-io1-f65.google.com with SMTP id l3so4431163ioc.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeoRAsyJlAWB5XR7Fa733uM2jLsUydPaembR30fp2/I=;
        b=mUf/WW1HD+b9R+yNC30X7bwJSkdKcRgvUJEw0TrxQVBwKgqAfnr873OucxOLOC8QhK
         komBw0HBvdyGrQDqGYmP51QED2p41GXIfVt5ItzoYBaeuZCCVRoueWyqzQOSEvT5ZB02
         0FssmiNQSoX4F1UloFYfNOTUtR2iLuA+aJ5a3aXIYUKpDflxNH72MP0j+jZHyJ6xrvnR
         6AROLEp1q2yqBnFoS/gpJh2yppIW2D8idbqnWrv7DInrIItpY4n3jt3sl8b0hJrIKd2u
         i7fyCtq2qVDfpmqdGA10Y1oBWUZSjF2qFNLRZH90kctsZ8R2zO0hyERohZaoA+QkrIrl
         fPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeoRAsyJlAWB5XR7Fa733uM2jLsUydPaembR30fp2/I=;
        b=Vmz25asRZZH3Pv/uD3nPW78ae5QpYLTEbD1htjAh0xH89ESTnBtsQGyc8XFwzPF9xn
         XG3JsDszeYF35ftmqptL/94imR0//8V8X28LyREW8jbcdzx1QBgI9FzlzCDjXjJjRhGw
         Rhm/g12exFpoTyF7ybNGmoOeQdRh5sofS4G5ewX/hcVb86ZfwIJIn/WL/q2rG7dNZogx
         Qov7tNwIGQepl50DVOLLIWBGUtwD7glKZIL4hCAPixOmCXvHPPw2hB1r0SPLgJsS8iVd
         uEBsYmN4K4tquJX50Aum6jztnUHpqtoV/Z/7V1WoUXv0z+yhCY+7rB31NoZIDeZqqFXh
         NJIg==
X-Gm-Message-State: AA+aEWbsLM31My6GQlk2E+gBLLZJfr784UmG0MwQB9OJfpFLXT4TWz29
        YcePhcM9HZgDar5a2UMVNkxfQUmGiear5BpJQm4ghw==
X-Google-Smtp-Source: AFSGD/VSibuWIOnZQTX9nt2AFKF4kL41xYMXPyYzRlkavoPlSwkDjUkPuy+FE8pApVokkMnwlHVOLoy52wMJwoDFRL8=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr2266905ioh.271.1544794964727;
 Fri, 14 Dec 2018 05:42:44 -0800 (PST)
MIME-Version: 1.0
References: <0000000000004ea80b057cfae21e@google.com> <CACT4Y+Z+AhQxf6=ecOkX1bOU5h7kMHYnR6CAhBv9eO5jQVeG3g@mail.gmail.com>
 <20181214132836.GE5343@dhcp22.suse.cz>
In-Reply-To: <20181214132836.GE5343@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 14 Dec 2018 14:42:33 +0100
Message-ID: <CACT4Y+aXFXnObgC-7NVe87-1bbqs2oNBBXe2mrfshLKnFqkTGA@mail.gmail.com>
Subject: Re: general protection fault in watchdog
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        rafael.j.wysocki@intel.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vkuznets@redhat.com, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 2:28 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 14-12-18 14:11:05, Dmitry Vyukov wrote:
> > On Fri, Dec 14, 2018 at 1:51 PM syzbot
> > <syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16aca143400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=7713f3aa67be76b1552c
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1131381b400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bae593400000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
> >
> > +linux-mm for memcg question
> >
> > What the repro does is effectively just
> > setsockopt(EBT_SO_SET_ENTRIES). This eats all machine memory and
> > causes OOMs. Somehow it also caused the GPF in watchdog when it
> > iterates over task list, perhaps some scheduler code leaves a dangling
> > pointer on OOM failures.
> >
> > But what bothers me is a different thing. syzkaller test processes are
> > sandboxed with a restrictive memcg which should prevent them from
> > eating all memory. do_replace_finish calls vmalloc, which uses
> > GFP_KERNEL, which does not include GFP_ACCOUNT (GFP_KERNEL_ACCOUNT
> > does). And page alloc seems to change memory against memcg iff
> > GFP_ACCOUNT is provided.
> > Am I missing something or vmalloc is indeed not accounted (DoS)? I see
> > some explicit uses of GFP_KERNEL_ACCOUNT, e.g. the one below, but they
> > seem to be very sparse.
> >
> > static void *seq_buf_alloc(unsigned long size)
> > {
> >      return kvmalloc(size, GFP_KERNEL_ACCOUNT);
> > }
> >
> > Now looking at the code I also don't see how kmalloc(GFP_KERNEL) is
> > accounted... Which makes me think I am still missing something.
>
> You are not missing anything. We do not account all allocations and you
> have to explicitly opt-in by __GFP_ACCOUNT. This is a deliberate
> decision. If the allocation is directly controlable by an untrusted user
> and the memory is associated with a process life time then this looks
> like a good usecase for __GFP_ACCOUNT. If an allocation outlives a
> process then there the flag should be considered with a great care
> because oom killer is not able to resolve the memcg pressure and so the
> limit enforcement is not effective.

Interesting.
I understand that namespaces, memcg's and processes (maybe even
threads) can have arbitrary overlapping. But I naively thought that in
canonical hierarchical cases it should all somehow work.
Question 1: is there some other, stricter sandboxing mechanism? We try
to sandbox syzkaller processes with everything available , because
these OOMs usually leads either to dead machines or hang/stall false
positives, which are nasty.
Question 2: this is a simple DoS vector, right? If I put a container
into a 1MB memcg, it can still eat arbitrary amount of non-pagable
kernel memory?
