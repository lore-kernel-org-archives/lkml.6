Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF61C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C57421479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulqiR23T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C57421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJJUWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:22:04 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56253 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:22:04 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so7818342itd.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ju4I6Q53en68pF0LoCjwm4UTDVl6dok49ziXNCPL+M0=;
        b=ulqiR23T3oc3GAIEuy5MviDnADxsLmJgvp3SQNOs2HF3IH++ecFBvf7xuQLAUvt7he
         QqPp7sZu3958Nrbr5O2d2uuqW1xTjBgHybyfozznugzD2k3pRXurZ1/UBt0H3/rT7qTD
         TxisYscWqVOV/6UAGiO5PrgcFU9WxL1EBNtX6DBTg/Od684kDXfopc/fRxHMaNoJUYv7
         +HmnqVFfzWcSDXmvbNybYumeOJUGWQVk2yhhevVpU4ANG2mLCPHIYkSPo2GM5rAhIHIP
         IK+eHiArAjKlg4Vh9y33DXgHlzAWRYXrGgmBulwqBVZ7BYVqCsHDy4vOBUxPof6MUyWc
         PBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ju4I6Q53en68pF0LoCjwm4UTDVl6dok49ziXNCPL+M0=;
        b=OVqIozWSRvzQExf5Iv64jdCvEM9YLoK8OTv/1jzYQbkhIrwo4uXelo1O3qc+/MbEee
         m6FlnynA4od2fljlsff7w0tydzGrAEHi2YMiFkhBUwVc/ouiao4tuHXRFySpcd7pFGwe
         Hn1JiS7er+mVJQUVf+OYfPSCy/eaQymKwRf52ANbN3nnY+SYWrm93V8h6eJF6p0T18O3
         VxUHz/IeusgnK9fs1YsZYGbQJhTaFkkOHjBWF/h+FQ0Pz6octJsohIUV0dEp4t7kAAwH
         3VWt1vcrPIrf1OgNc+/seICyyXok1l1hcmxzxHVOv2+/DKnYNVQKcYkmy3gYb5rr2Hjn
         bZSg==
X-Gm-Message-State: ABuFfoggjOSvdksATbkgpvgtlzJIDKGsyTiLlXSkWSOXZrLtq1UvSyAP
        zdf54p9jC3k7sZd6zLMhB6+W8TBVZHhfFAJkeh9V1wl3GoQ=
X-Google-Smtp-Source: ACcGV60iu5EjXq1p16J99QkMTLLYctsQjoWQpeCmfP4o5AsalVui0V4E055tKk3siq2lACoQ2h0p1D0coduioFXfuz0=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr670381ite.12.1539176398535;
 Wed, 10 Oct 2018 05:59:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 05:59:38
 -0700 (PDT)
In-Reply-To: <00000000000053a2ca0577ceddac@google.com>
References: <00000000000053a2ca0577ceddac@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 14:59:38 +0200
Message-ID: <CACT4Y+adu4sL96Dp7_m4=Q7bP0eL1w8zVce-2-+FZMAut+E9SA@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in free_task
To:     syzbot <syzbot+71aff6ea121ffefc280f@syzkaller.appspotmail.com>,
        dledford@redhat.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, swise@opengridcomputing.com,
        markb@mellanox.com, linux-rdma@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, guro@fb.com,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Marcos Souza <marcos.souza.org@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 7:14 PM, syzbot
<syzbot+71aff6ea121ffefc280f@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    ae16eea39a86 Add linux-next specific files for 20181008
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16a493b9400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=42525ce985d1a955
> dashboard link: https://syzkaller.appspot.com/bug?extid=71aff6ea121ffefc280f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14567ae6400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14baa25e400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+71aff6ea121ffefc280f@syzkaller.appspotmail.com

This looks the same as:

#syz dup: WARNING in __put_task_struct (2)

The reproducer is all RDMA and also some task refcounting bug.

+RDMA maintainers

> ------------[ cut here ]------------
> ODEBUG: free active (active state 1) object type: rcu_head hint:
> (null)
> WARNING: CPU: 0 PID: 6048 at lib/debugobjects.c:329
> debug_print_object+0x16a/0x210 lib/debugobjects.c:326
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 6048 Comm: syz-executor022 Not tainted 4.19.0-rc7-next-20181008+
> #89
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x3ab lib/dump_stack.c:113
>  panic+0x238/0x4e7 kernel/panic.c:184
>  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>  report_bug+0x254/0x2d0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
> RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
> Code: 41 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd
> 60 02 41 88 4c 89 fe 48 c7 c7 00 f8 40 88 e8 36 2f b4 fd <0f> 0b 83 05 a9 f4
> 5e 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
> RSP: 0018:ffff8801d8c3eda8 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8164d235 RDI: 0000000000000005
> RBP: ffff8801d8c3ede8 R08: ffff8801d70aa280 R09: ffffed003b5c3eda
> R10: ffffed003b5c3eda R11: ffff8801dae1f6d7 R12: 0000000000000001
> R13: ffffffff8939a760 R14: 0000000000000000 R15: ffffffff8840fca0
>  __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
>  debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:818
>  kmem_cache_free+0x202/0x290 mm/slab.c:3759
>  free_task_struct kernel/fork.c:163 [inline]
>  free_task+0x16e/0x1f0 kernel/fork.c:457
>  __put_task_struct+0x2e6/0x620 kernel/fork.c:730
>  put_task_struct include/linux/sched/task.h:96 [inline]
>  finish_task_switch+0x66c/0x900 kernel/sched/core.c:2715
>  context_switch kernel/sched/core.c:2834 [inline]
>  __schedule+0x8d7/0x21d0 kernel/sched/core.c:3480
>  schedule+0xfe/0x460 kernel/sched/core.c:3524
>  freezable_schedule include/linux/freezer.h:172 [inline]
>  futex_wait_queue_me+0x3f9/0x840 kernel/futex.c:2530
>  futex_wait+0x45c/0xa50 kernel/futex.c:2645
>  do_futex+0x31a/0x26d0 kernel/futex.c:3528
>  __do_sys_futex kernel/futex.c:3589 [inline]
>  __se_sys_futex kernel/futex.c:3557 [inline]
>  __x64_sys_futex+0x472/0x6a0 kernel/futex.c:3557
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x446549
> Code: e8 2c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 2b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f3a998f5da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446549
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc38
> RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
> R13: 2f646e6162696e69 R14: 666e692f7665642f R15: 00000000006dbd2c
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000053a2ca0577ceddac%40google.com.
> For more options, visit https://groups.google.com/d/optout.
