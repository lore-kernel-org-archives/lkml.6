Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B8C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A4521874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6eQpD/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfADQhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:37:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52360 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfADQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:37:25 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so2286683itg.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 08:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5WlQ5+ddRF82gEGryHn+vE4cGAjWVDsj8+0ESzCtes=;
        b=R6eQpD/9iN6Fa7AEgsFeLDR9wsXQc945p4T4J3ARwEb9SqyypbXYuH/17A3op316W7
         WI6UyCQT6tQxuHBMxqxRhKHit3drrxx2zndJmOyvdEJ/9yxk6n6b0JACCI7BEOlK0LuV
         cix+zU7UpTvcePEQsWNO7ynCRl8f2vySz1ODx/PYhcYFL+Kkn8T11nDRbPjniE2mbhMS
         6jsj0MJ7s6k/g6O9FidU3nG+M+nLTKmJao6Zz3Vnpw1PVaE9Ef0Cmh8+mDdDjQIXuFVb
         0O4xmaIy8KDGLBN3pfX4/ikcDA5hqXHV2nEA/jodUQB2llDJhjyqKUtf+SkcPTxcKnPx
         hUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5WlQ5+ddRF82gEGryHn+vE4cGAjWVDsj8+0ESzCtes=;
        b=NDO1Z9B0YphGikal/eL29N306RPCbyyEM9kPxh9EqXNE9Xy3eXSjeaP5ZSiPkif/w8
         joipn64zG5bZ3Lxk2PRtsSGpCQeDkojHxKM7a9VRxpdCfBpU84XZxG4CBwJM3NgqKqIx
         qvq6ZH4xXUzQwWMz/zTZ5L0yClsiNeU7iM98kurirvj5YNi3QBhKOIRiYLZVUX1DZi1t
         Esrp6ab8vAKLmu66bfRKsKEdp4fUJ9l7zGA4QIDt86oBXLdlqHPys3n2gnEcZNVUchxj
         cLN3E8XBZ9PML9jp1ETTsW3HzN2Tr9gZH+jJjHrFq4Lb6THBDUKet+0K9o8WIvJSJAtY
         zoiQ==
X-Gm-Message-State: AJcUukcaP4EewwxMFOzVkDWZ6/EoWeUbceqXDAyl1szdvH8wl6L1WoDS
        NGGNP7KqWvaPbc1UwTLHsLKP1IgcBNlqQO2uMd/wqBWTRKextg==
X-Google-Smtp-Source: ALg8bN46AvvnF80SUFr3znoTQl7EYRyx+wsEMzR7fOuNS7PlpFeiHskZ/N27tl1L0PYJ1g9XCP0uCO4+Q49tynV9/2M=
X-Received: by 2002:a24:6511:: with SMTP id u17mr1413392itb.12.1546619843383;
 Fri, 04 Jan 2019 08:37:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000af6ec7057ea3d8df@google.com>
In-Reply-To: <000000000000af6ec7057ea3d8df@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 17:37:12 +0100
Message-ID: <CACT4Y+bgouQquwTa23WdorASC9K2HWzsSrnZBMjY3p+cP3i5Hw@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds in update_curr
To:     syzbot <syzbot+d959075ee873314ffb9c@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefano Brivio <sbrivio@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 4:51 PM syzbot
<syzbot+d959075ee873314ffb9c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    645ff1e8e704 Merge branch 'for-linus' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b8c59b400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=20271e14bc1c87f0
> dashboard link: https://syzkaller.appspot.com/bug?extid=d959075ee873314ffb9c
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b32430c00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d959075ee873314ffb9c@syzkaller.appspotmail.com


Presumably a random manifestation of the stack overflow/corruption:

#syz dup: kernel panic: stack is corrupted in udp4_lib_lookup2

See https://groups.google.com/forum/#!msg/syzkaller-bugs/vr87kmG5qRI/31nOcuVsFgAJ




> IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> 8021q: adding VLAN 0 to HW filter on device batadv0
> ==================================================================
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> BUG: KASAN: stack-out-of-bounds in calc_delta_fair kernel/sched/fair.c:629
> [inline]
> BUG: KASAN: stack-out-of-bounds in update_curr+0x99d/0xbc0
> kernel/sched/fair.c:823
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> Read of size 8 at addr ffff8880a94be4c0 by task syz-executor2/8264
> CPU: 1 PID: -2015332728 Comm: e  Not tainted 4.20.0+ #7
>
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> CPU: 0 PID: 8264 Comm: syz-executor2 Not tainted 4.20.0+ #7
> RIP: 0010:lookup_object lib/debugobjects.c:156 [inline]
> RIP: 0010:debug_object_deactivate lib/debugobjects.c:542 [inline]
> RIP: 0010:debug_object_deactivate+0x16c/0x4b0 lib/debugobjects.c:529
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Code: c1 ea 03 42 80 3c 2a 00 0f 85 49 02 00 00 4d 8b 24 24 4d 85 e4 0f 84
> d1 00 00 00 49 8d 7c 24 18 83 c3 01 48 89 fa 48 c1 ea 03 <42> 80 3c 2a 00
> 0f 85 fa 01 00 00 49 3b 4c 24 18 75 c0 49 8d 7c 24
> Call Trace:
> RSP: 0018:ffff8880ae707b80 EFLAGS: 00010002
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
> RAX: 1ffffffff16d5674 RBX: 0000000000000003 RCX: ffff8880ae726620
> RDX: 000000000000000b RSI: 0000000000000004 RDI: 0000000000000058
> RBP: ffff8880ae707c70 R08: 1ffff11015ce0f5c R09: ffffffff899ad160
> R10: 0000000000000086 R11: 0000000000000003 R12: 0000000000000040
> R13: dffffc0000000000 R14: 1ffff11015ce0f74 R15: ffffffff8b6ab3a8
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000068 CR3: 000000007f479000 CR4: 00000000001406e0
>   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
>   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
>   calc_delta_fair kernel/sched/fair.c:629 [inline]
>   update_curr+0x99d/0xbc0 kernel/sched/fair.c:823
>   debug_hrtimer_deactivate kernel/time/hrtimer.c:412 [inline]
>   debug_deactivate kernel/time/hrtimer.c:462 [inline]
>   __run_hrtimer kernel/time/hrtimer.c:1359 [inline]
>   __hrtimer_run_queues+0x225/0x1050 kernel/time/hrtimer.c:1451
>   enqueue_entity+0x3e5/0x20b0 kernel/sched/fair.c:3880
>   hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
>   smp_apic_timer_interrupt+0x18d/0x760 arch/x86/kernel/apic/apic.c:1060
>   enqueue_task_fair+0x237/0x10c0 kernel/sched/fair.c:5133
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>   enqueue_task kernel/sched/core.c:730 [inline]
>   activate_task+0x11d/0x470 kernel/sched/core.c:751
>   </IRQ>
>   ttwu_activate kernel/sched/core.c:1643 [inline]
>   ttwu_do_activate+0xd4/0x1f0 kernel/sched/core.c:1702
> Modules linked in:
>   ttwu_queue kernel/sched/core.c:1847 [inline]
>   try_to_wake_up+0x997/0x1480 kernel/sched/core.c:2057
> ---[ end trace 5a5c098e51171999 ]---
> RIP: 0010:lookup_object lib/debugobjects.c:156 [inline]
> RIP: 0010:debug_object_deactivate lib/debugobjects.c:542 [inline]
> RIP: 0010:debug_object_deactivate+0x16c/0x4b0 lib/debugobjects.c:529
> Code: c1 ea 03 42 80 3c 2a 00 0f 85 49 02 00 00 4d 8b 24 24 4d 85 e4 0f 84
> d1 00 00 00 49 8d 7c 24 18 83 c3 01 48 89 fa 48 c1 ea 03 <42> 80 3c 2a 00
> 0f 85 fa 01 00 00 49 3b 4c 24 18 75 c0 49 8d 7c 24
> RSP: 0018:ffff8880ae707b80 EFLAGS: 00010002
> RAX: 1ffffffff16d5674 RBX: 0000000000000003 RCX: ffff8880ae726620
> RDX: 000000000000000b RSI: 0000000000000004 RDI: 0000000000000058
>   default_wake_function+0x30/0x50 kernel/sched/core.c:3710
> RBP: ffff8880ae707c70 R08: 1ffff11015ce0f5c R09: ffffffff899ad160
> R10: 0000000000000086 R11: 0000000000000003 R12: 0000000000000040
>   __wake_up_common+0x1d3/0x7d0 kernel/sched/wait.c:92
> R13: dffffc0000000000 R14: 1ffff11015ce0f74 R15: ffffffff8b6ab3a8
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000068 CR3: 000000007f479000 CR4: 00000000001406e0
>   __wake_up_locked+0x11/0x20 kernel/sched/wait.c:154
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   ep_poll_callback+0x3c5/0x10a0 fs/eventpoll.c:1200
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000af6ec7057ea3d8df%40google.com.
> For more options, visit https://groups.google.com/d/optout.
