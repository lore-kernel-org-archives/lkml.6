Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62554C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139CD218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfxtEs0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfABNiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 08:38:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51117 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfABNiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 08:38:11 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so40898108iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 05:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n31S5V6U6qDCS3H60OBn8oaVGBivbCpBvsFPVxzMFkY=;
        b=UfxtEs0dqP99VEWWA7/4fxvsiK6OFH8xbGzp0w3m6peQpyBLq9xsNUXDJ9Ea8Je6Yb
         h6jiyRrD46O58OcS/fAvv25G+9MAp9JQFZC1BfNFIJ56nNFPEd8LBE2g4smihZCcEY8e
         d0BbuJfUXDnDoSHyvkordw7rFstLKuahBXPD2NqEGYKgn895NNMqfq8I6SeQuXUNzgtc
         SC9NdBeESPw1eof71Nyj+uulF1OpOvhlGF3wovO3nRGCAxwqK5WaEZLzovY7gwo0Cfex
         WCbaYylZdmm817bhvR/krynNWWDqlIp7lOFsibg5+0+wygO81Nbx8pndkFfG53Dkv99i
         EREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n31S5V6U6qDCS3H60OBn8oaVGBivbCpBvsFPVxzMFkY=;
        b=LQw7Nd5qAWTcoInvPHFgV6PrD7LehcvWSzHLcytg0yvXhMeXp3YjCJ3SpfEUrFZFZG
         OobwYIZpvlVG539qIcyMnoHSc7Nk30C7Xs4cIz7U3qhNn10ZXHt4a7l3q61kQ39BeD5g
         Bn+9BjtsJXJZXTiESKpQJZJAXsUHm09AVPGY+Zc6OHv9zd3HmPFRLTYlcsTG8+9M+INk
         Lw52BP85C9VBu1NoKaV9VCFKmHmRUccAEGI9C3qLhawb6dgobGU9s/niyYpNwQMze+OA
         IuLHwYZ6vAzafLK07zeLJQWlsOar8S2CLNMauQHbhfh2Xfc1ubJwzmtqn8dLD9VSCV3n
         EOdA==
X-Gm-Message-State: AA+aEWYPrjeXLr0sWN9nnz4emafodIDwjm67K3AUl2NhGqTFQ+2yKSIb
        /yhIZq6lOcoeZKQTOilKOOBibU1VB2OksrdRxLyuAw==
X-Google-Smtp-Source: AFSGD/Xj43N4YtAugGxxs9vAJnd4i5K7MV7MGl+PNpSG1UC+BSacLGJRQi8LyvQ2bhA9umKqYg5D6mHR8PzQ44rlIWI=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr26734815jan.72.1546436290028;
 Wed, 02 Jan 2019 05:38:10 -0800 (PST)
MIME-Version: 1.0
References: <000000000000665f2e057cd00db6@google.com> <CACT4Y+Y-Yv0a1DzqsTHRSP52DdKLy0J2fAfsVfZUSNNnAOUnzg@mail.gmail.com>
 <CACT4Y+bxTz6d11v89gpDSEPyB+sJssNGPmEsC9-LVsGbxEpcuA@mail.gmail.com> <20181230154648.GB9832@redhat.com>
In-Reply-To: <20181230154648.GB9832@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 14:37:58 +0100
Message-ID: <CACT4Y+Y+ZdBPXGhytZycqcLc_7GOR-VZB8KKuX_qUgxmiVT60w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in handle_userfault (2)
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 4:46 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Hello,
>
> On Sun, Dec 30, 2018 at 08:48:05AM +0100, Dmitry Vyukov wrote:
> > On Wed, Dec 12, 2018 at 10:58 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Wed, Dec 12, 2018 at 10:45 AM syzbot
> > > <syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    14cf8c1d5b90 Add linux-next specific files for 20181210
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=133296db400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c9133d0a4284c012
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=cbc64b24b2b2d54c07a9
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >
> > > This is a corrupted/intermixed kernel output, the bug actually
> > > happened somewhere in net/core/neighbour.c.
> > > syzkaller has a bunch of code to try to deal to corrupted kernel
> > > output, but it's not always possible as a parallel thread printing
> > > something can inject an unrelated frame just in the right place, and
> > > then it's indistinguishable from a crash happened there.
> > >
> > > The question is: what's the significance of that
> > > "FAULT_FLAG_ALLOW_RETRY missing 70"?
> > > Is it something to fix in kernel? Can the check be removed? Should it
>
> This is a rate limited warning not compiled in production kernels.
>
> #ifdef CONFIG_DEBUG_VM
>                 if (printk_ratelimit()) {
>                         printk(KERN_WARNING
>                                "FAULT_FLAG_ALLOW_RETRY missing %x\n",
>                                vmf->flags);
>                         dump_stack();
>                 }
> #endif
>
> It helps to tell if it's an userland bug or a kernel missing feature
> like some get_user_pages that can't drop mmap_sem in a path where we
> may need userfaultfd to be functional.
>
> Those get_user_pages locations are deterministic, so for example when
> qemu started explicitly calling get_mempolicy(MPOL_F_NODE|MPOL_F_ADDR)
> we had to change the get_user_pages there to make uffd functional for
> such syscall. An example of where this debug aid paid off relatively
> recently is commit 3b9aadf7278d16d7bed4d5d808501065f70898d8.
>
> > > be moved somewhere earlier when flags are passed to kernel and cause
> > > EINVAL? Can it be at least converted to a single-line pr_warn?
>
> I don't see the problem with the VM_FAULT_SIGBUS retval.
>
> The reason of the full dump_stack is because pr_warn would tell us
> nothing about the location of the get_user_pages that needs
> conversion. It's pretty much like when you get an -EINVAL in userland
> and there's a zillon places that returns -EINVAL and you've no clue
> which one you hit. The debug_stack is about pinpointing the exact
> location after the fact, to evaluate what to do about it.
>
> > > +Sasha go as far as suggesting that any "Call Trace:" in kernel output
> > > means a kernel bugs. This is one of few places in kernel that dumps
> > > stacks left and right without a kernel bug (?).
>
> Yes this is a case where the Call Trace in the logs doesn't guarantee
> there was a kernel bug, this is why it's rate limited and only
> compiled in non production builds.
>
> I haven't looked at the reproducer source, but looking only at the
> trace I can tell this happened because a region has been registered in
> uffd while a page fault was already undergoing a VM_FAULT_RETRY
> cycle.
>
> We could remove the dump_stack if FAULT_FLAG_TRIED is set, but
> removing it for all cases would make it harder to solve other kernel
> issues like described above.
>
> However with Peter Xu recent work FAULT_FLAG_TRIED will go away as
> part of the userfaultfd WP support (FAULT_FLAG_TRIED is the reason of
> this specific false positive) so you won't be able to trigger this
> path through undefined state userland race conditions anymore after
> that.
>
> So I'd propose Peter's FAULT_FLAG_TRIED removal as the best path
> forward because it's will solve 3 problems: 1) this rate limited false
> positive FAULT_FLAG_TRIED dump_stack with malicious app, 2) signal
> case not returning VM_FAULT_RETRY despite we dropped mmap_sem to sleep
> until we got waken up by a signal, 3) it'll allow the uffd write
> protection to work.
>
> https://lkml.kernel.org/r/20181121062103.18835-1-peterx@redhat.com
>
> Until FAULT_FLAG_TRIED is dropped, it's up to the manager in the non
> cooperative case and up to the app itself in the normal more common
> cooperative case, to ensure there aren't page faults already happening
> in the region while the region is registered in uffd. It's totally
> trivial for the app to do so until we relax this requirement in a
> fully backwards compatible way.
>
> The reason FAULT_FLAG_TRIED must be dropped for the write-protection
> feature is that the uffd per-page granular write protection ioctl must
> be allowed to run at any time on any region, potentially while there
> are already VM_FAULT_RETRY faults being retried. So the kernel common
> code must be allowed to return VM_FAULT_RETRY twice or more in a row
> from the point of view of the arch page fault code.
>
> To remove the dump_stack completely (not only for the case of a
> malicious userland app) we could add a debug facility in debugfs where
> we could dump stack traces in a circular buffer, so we could ask the
> root user to cat the file and send us the extra call trace debug data
> associated to the single pr_warn in the log. It'd actually be nice if
> all kind of -EINVAL could dump their stack there too in fact
> (supposedly they're not fast paths).
>
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+cbc64b24b2b2d54c07a9@syzkaller.appspotmail.com
> > > >
> > > > RDX: 00000000000003ff RSI: 0000000020012fe0 RDI: 00007f5dbe489850
> > > > RBP: 000000000072bf00 R08: 00000000000003ff R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5dbe48a6d4
> > > > R13: 00000000004c578a R14: 00000000004d9d90 R15: 00000000ffffffff
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0x100
> > > > lib/list_debug.c:51
> > > > CPU: 1 PID: 20306 Comm: syz-executor2 Not tainted 4.20.0-rc6-next-20181210+
> > > > #164
> > > > Read of size 8 at addr ffff8881c5e72bb0 by task kworker/0:1/12
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > >
> > > > Call Trace:
> > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > >   dump_stack+0x244/0x39d lib/dump_stack.c:113
> > > >   handle_userfault.cold.30+0x47/0x62 fs/userfaultfd.c:431
> > > >   do_anonymous_page mm/memory.c:2938 [inline]
> > > >   handle_pte_fault mm/memory.c:3780 [inline]
> > > >   __handle_mm_fault+0x4d26/0x5b70 mm/memory.c:3906
> > > >   handle_mm_fault+0x54f/0xc70 mm/memory.c:3943
> > > >   do_user_addr_fault arch/x86/mm/fault.c:1475 [inline]
> > > >   __do_page_fault+0x5f6/0xd70 arch/x86/mm/fault.c:1541
> > > >   do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1572
> > > >   page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1143
> > > > RIP: 0033:0x4510a0
> > > > Code: 0f 84 c4 0f 00 00 48 89 f1 48 89 f8 48 83 e1 3f 48 83 f9 20 0f 86 7b
> > > > 02 00 00 48 83 e6 f0 48 83 e1 0f 66 0f ef c0 66 0f ef c9 <66> 0f 74 0e 66
> > > > 0f d7 d1 48 d3 ea 49 c7 c2 11 00 00 00 49 29 ca 4d
> > > > RSP: 002b:00007fab1fbba7a8 EFLAGS: 00010202
> > > > RAX: 00007fab1fbba850 RBX: 0000000000000003 RCX: 000000000000000e
> > > > RDX: 00000000000003ff RSI: 0000000020012fe0 RDI: 00007fab1fbba850
> > > > RBP: 000000000072bf00 R08: 00000000000003ff R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007fab1fbbb6d4
> > > > R13: 00000000004c578a R14: 00000000004d9d90 R15: 00000000ffffffff
> > > > CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 4.20.0-rc6-next-20181210+ #164
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > > Workqueue: events_power_efficient neigh_periodic_work
> > > > Call Trace:
> > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > >   dump_stack+0x244/0x39d lib/dump_stack.c:113
> > > >   print_address_description.cold.4+0x9/0x1ff mm/kasan/report.c:187
> > > >   kasan_report.cold.5+0x1b/0x39 mm/kasan/report.c:317
> > > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
> > > >   __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
> > > >   __list_del_entry include/linux/list.h:117 [inline]
> > > >   list_del_init include/linux/list.h:159 [inline]
> > > >   neigh_mark_dead+0x13b/0x410 net/core/neighbour.c:125
>
> The real crash seems to be completely unrelated to userfaultfd, the
> list_del_init is in neigh_mark_dead.
>
>         if (!list_empty(&n->gc_list)) {
>                 list_del_init(&n->gc_list);


Hi Andrea,

Thanks for the detailed answer.

If we are proceeding with "mm: some enhancements to the page fault
mechanism", that's good as it will eliminate at least part of this
output.

There are 2 types of debug configs: ones add additional checks for
machines and another add verbose output for humans. CONFIG_DEBUG_VM
seems to be more of the first type of debug config -- additional
checks for machines. I've seen some of the second type debug configs
are prefixed with DEBUG_VERBOSE or something along these lines. Maybe
it makes sense to split this out of CONFIG_DEBUG_VM. Since it's a
"gray" check (rather then white/black check), it can't be used in
CI/fuzzing setups anyways -- not possible to analyse thousands of
cases manually (though maybe we actually hitting some that can be
classified as kernel bugs).

Yes, the problem is way more general. As you noted it applies to 100K
of EINVAL|EFAULT|ENOMEM, it's super hard to figure out what/where
exactly goes wrong in the kernel getting only -22. But at the same
time we can't have all of these 100K places dump stacks. I don't know
what's a good solution for this. Manually annotating 100K places does
not look like the right way to go. Maybe kprobes can do this? In some
cases I used CONFIG_KCOV  and kcovtrace
(https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace.c)
to collect kernel trace from a failing syscall.
