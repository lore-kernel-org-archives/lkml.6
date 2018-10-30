Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C028C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2590E2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBsTOjJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2590E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeJ3LT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:19:27 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33696 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3LT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:19:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id i78-v6so4384895ybg.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDjZyJU3ahWCbtmdaoamyquk8LqXryG5K/Rzli+Plb0=;
        b=YBsTOjJF0sJjMKFUeJH4QWfty1nxaOMde1mYaN2wWFBGRNH8sCisdr/XJsR3bx0Byq
         Kl6+japqLUvnpjdmIuUAgF+1s68MoMBqxFPZ6t+k0QdBAgixefDtxR1MFYM7Xi34SUZk
         OnSRgE9rpwJPgdqZyBRV3hMVNf8r3XtiOV46Vz4yRj2he1rmpDKNAIw0bufPuJLbB4Vq
         kERwOLzX2rd5tRxL8D1co51lz7Ixv1xEBUKHohMXLesq3FKmOH3bIM6PYuNCvlJGtTIc
         AmoVFxTHlEAN9x654IpRzNm3BAwi9e5Nm4QTVGd5JRGklHNzcNrrZ6GN/b8PwIQrUUSr
         bLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDjZyJU3ahWCbtmdaoamyquk8LqXryG5K/Rzli+Plb0=;
        b=ue25ndtsZd6yTCguf+gHGWIbGL/31kyoJLwGWxUOJ0MzeDHwamfm1X7WMVVml31h7v
         u3Z0yZ+0U1HZPzY3awCL29AlBoh7BrhD1C9d7cDQFFAPwsRgX6SL56C7qMfW5I3MvZ/S
         5Qx8mZV+enzQTRXeGhc4l5dGwE8ycFGHr/1LfUmNCDkwhEc9PvVN+keSxdGK7THfJPwP
         KWY6e6x8NMxf96S1DQICpBhOdepm+rx7pCnApoYs7qsed1BeyaR+wevTeRx63qhAoYTQ
         4st7x5iN8OrfKSJt0HukEBlZTqs2MM8/xMI4CrB5QI6ilAFsavPQPfoZbQ9Nl1NG0ssA
         C42A==
X-Gm-Message-State: AGRZ1gKPxcFMNk0TegTC9fGiXwluxP25Ud5K7dTUDCMlQEswZsls98ae
        vYcRm0j5HETH6QbSxS4+WNSwGvsByiB5tno6HZ7B8g==
X-Google-Smtp-Source: AJdET5fjS7tsQJaBHYjFftoT5l8EdMfUanGKvJH7YWJYjipI+Sc/LrlKGNAy6NxYqeuPi6Yfr2JSQzhbZPdOibbuTCc=
X-Received: by 2002:a5b:51:: with SMTP id e17-v6mr16067618ybp.496.1540866476964;
 Mon, 29 Oct 2018 19:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181029215123.17830-1-guro@fb.com> <CALvZod7tZd6t7d9o8Mj88211McpUH0oANFqESStt7G94-PBbaQ@mail.gmail.com>
 <50e780fba8f2af412e1962823cf759f7dff8b40d.camel@surriel.com>
In-Reply-To: <50e780fba8f2af412e1962823cf759f7dff8b40d.camel@surriel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 29 Oct 2018 19:27:45 -0700
Message-ID: <CALvZod6KoAZbe9eQjGuf_4zGSYpEG2UEnwfi+Hg99or4-XPy3w@mail.gmail.com>
Subject: Re: [PATCH] mm: handle no memcg case in memcg_kmem_charge() properly
To:     Rik van Riel <riel@surriel.com>
Cc:     Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        efault@gmx.de, LKML <linux-kernel@vger.kernel.org>,
        Kernel-team@fb.com, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 6:01 PM Rik van Riel <riel@surriel.com> wrote:
>
> On Mon, 2018-10-29 at 17:50 -0700, Shakeel Butt wrote:
> > On Mon, Oct 29, 2018 at 2:52 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Mike Galbraith reported a regression caused by the commit
> > > 9b6f7e163cd0
> > > ("mm: rework memcg kernel stack accounting") on a system with
> > > "cgroup_disable=memory" boot option: the system panics with the
> > > following stack trace:
> > >
> > >   [0.928542] BUG: unable to handle kernel NULL pointer dereference
> > > at 00000000000000f8
> > >   [0.929317] PGD 0 P4D 0
> > >   [0.929573] Oops: 0002 [#1] PREEMPT SMP PTI
> > >   [0.929984] CPU: 0 PID: 1 Comm: systemd Not tainted 4.19.0-
> > > preempt+ #410
> > >   [0.930637] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS ?-20180531_142017-buildhw-08.phx2.fed4
> > >   [0.931862] RIP: 0010:page_counter_try_charge+0x22/0xc0
> > >   [0.932376] Code: 41 5d c3 c3 0f 1f 40 00 0f 1f 44 00 00 48 85 ff
> > > 0f 84 a7 00 00 00 41 56 48 89 f8 49 89 fe 49
> > >   [0.934283] RSP: 0018:ffffacf68031fcb8 EFLAGS: 00010202
> > >   [0.934826] RAX: 00000000000000f8 RBX: 0000000000000000 RCX:
> > > 0000000000000000
> > >   [0.935558] RDX: ffffacf68031fd08 RSI: 0000000000000020 RDI:
> > > 00000000000000f8
> > >   [0.936288] RBP: 0000000000000001 R08: 8000000000000063 R09:
> > > ffff99ff7cd37a40
> > >   [0.937021] R10: ffffacf68031fed0 R11: 0000000000200000 R12:
> > > 0000000000000020
> > >   [0.937749] R13: ffffacf68031fd08 R14: 00000000000000f8 R15:
> > > ffff99ff7da1ec60
> > >   [0.938486] FS:  00007fc2140bb280(0000) GS:ffff99ff7da00000(0000)
> > > knlGS:0000000000000000
> > >   [0.939311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >   [0.939905] CR2: 00000000000000f8 CR3: 0000000012dc8002 CR4:
> > > 0000000000760ef0
> > >   [0.940638] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > 0000000000000000
> > >   [0.941366] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > 0000000000000400
> > >   [0.942110] PKRU: 55555554
> > >   [0.942412] Call Trace:
> > >   [0.942673]  try_charge+0xcb/0x780
> > >   [0.943031]  memcg_kmem_charge_memcg+0x28/0x80
> > >   [0.943486]  ? __vmalloc_node_range+0x1e4/0x280
> > >   [0.943971]  memcg_kmem_charge+0x8b/0x1d0
> > >   [0.944396]  copy_process.part.41+0x1ca/0x2070
> > >   [0.944853]  ? get_acl+0x1a/0x120
> > >   [0.945200]  ? shmem_tmpfile+0x90/0x90
> > >   [0.945596]  _do_fork+0xd7/0x3d0
> > >   [0.945934]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> > >   [0.946421]  do_syscall_64+0x5a/0x180
> > >   [0.946798]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >
> > > The problem occurs because get_mem_cgroup_from_current() returns
> > > the NULL pointer if memory controller is disabled. Let's check
> > > if this is a case at the beginning of memcg_kmem_charge() and
> > > just return 0 if mem_cgroup_disabled() returns true. This is how
> > > we handle this case in many other places in the memory controller
> > > code.
> > >
> > > Fixes: 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
> > > Reported-by: Mike Galbraith <efault@gmx.de>
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > >  mm/memcontrol.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 54920cbc46bf..6e1469b80cb7 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2593,7 +2593,7 @@ int memcg_kmem_charge(struct page *page,
> > > gfp_t gfp, int order)
> > >         struct mem_cgroup *memcg;
> > >         int ret = 0;
> > >
> > > -       if (memcg_kmem_bypass())
> > > +       if (mem_cgroup_disabled() || memcg_kmem_bypass())
> > >                 return 0;
> > >
> >
> > Why not check memcg_kmem_enabled() before calling memcg_kmem_charge()
> > in memcg_charge_kernel_stack()?
>
> Check Roman's backtrace again. The function
> memcg_charge_kernel_stack() is not in it.
>

It got inlined.

> That is why it is generally better to check
> in the called function, rather than add a
> check to every call site (and maybe miss one
> or two).
>

I think the reason the check was at the call site was not to introduce
jmp/call in the allocation hot path for processes in the root memcg. I
don't have any strong preference but we should be persistent i.e.
checks at call site for all or check in the called function for all.

Shakeel
