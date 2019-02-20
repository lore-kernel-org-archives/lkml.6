Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC10B20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hysg6AAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBTPMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:12:33 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38557 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBTPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:12:32 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so16224654itg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gb/zsW7xscNie13Ee0vPsARYt12rlrJTPXGTHFK91R8=;
        b=Hysg6AAo0ZH3rZ0mYES0C76b3jua61d0IcYE5sBGXpACokOIfkSHlIZboZ3OuqxpoD
         ShC2XSfmQbjTt26nFQodWCRgBYT0EM1xr4f1sBJBiOur7SrKUJy0iRzzrck7Y349eur5
         O9qohcAb2Q33I2Aq8iZOL3sHgfWUaE9o0IFyOhAMIHH/74rgSdiHChMv33OmLZqCgNvN
         uOCk9Tg2h9avsBRjwdLIDJT+F9WeWhJv0VKtNfYOuaBYGpW3d5MffDTlqSFPRrYZp/Vj
         2G0cLR89XXex3GKuwO9DER3BjTIo3m+im2WlUDHqqoJnKH9a4BqLfrGMV+E48DZEJxZu
         nUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gb/zsW7xscNie13Ee0vPsARYt12rlrJTPXGTHFK91R8=;
        b=X1iUeJMvAKlpDwFvlMrkJHtW5UvRaruhl1T7Hq0pQssQyB63phLrPw/2aFipE88T5H
         hyT4ezwgkFuGa6Sart0NwIAC/n8d7aqM9oURxp2NdxL5LfXZumnNHYhSATCx+lHMY4SY
         AyWwLcDKMrIpeiZOBJxJT1RG89dGxC993oHNndphVGolaTEojp3sUxOpTd/195NFciQU
         uDyvSZcPGne1ZjtARjgTmjntuiw04KEYdF8RuNLIQS8MYxwlgZ6Q/3i97Un3ihnas7X6
         eCz2FxsA/JEtscLbig6LiiOo5mB5Eb1UUrln1l12Ely2NjAaw3I//lfxHi7a2aiJT/zz
         nTEQ==
X-Gm-Message-State: AHQUAub5uAIfBwnjRostBQZE86bX8aiO+4fOGPdPZAPSvd38VcVdBAX8
        X9K5HNQuT9qje1zNPul+azM+rOcCcScHPKbv10eK8w==
X-Google-Smtp-Source: AHgI3IYd/Ks71VosRiwrmGjRLVCvWl0FhcC7sfOjK421nRTdsfOzNajP0M4vb+8AnQ8e1Z63c1wXHuJIq2N6L7egKjA=
X-Received: by 2002:a02:9089:: with SMTP id x9mr17277512jaf.72.1550675550914;
 Wed, 20 Feb 2019 07:12:30 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009e76240574711017@google.com>
In-Reply-To: <0000000000009e76240574711017@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Feb 2019 16:12:18 +0100
Message-ID: <CACT4Y+YUfaAQs9vOtk61opaSkCtQEgQUrcBQNebsk-F223s0pw@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in f2fs_fill_super
To:     syzbot <syzbot+77ea19d309d4cdc55cc1@syzkaller.appspotmail.com>,
        jaegeuk@kernel.org, stummala@codeaurora.org, shengyong1@huawei.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuchao0@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:04 PM syzbot
<syzbot+77ea19d309d4cdc55cc1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e27bc174c9c6 Add linux-next specific files for 20180824
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11c0034a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=28446088176757ea
> dashboard link: https://syzkaller.appspot.com/bug?extid=77ea19d309d4cdc55cc1
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+77ea19d309d4cdc55cc1@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object type: percpu_counter
> hint:           (null)
> WARNING: CPU: 1 PID: 18832 at lib/debugobjects.c:329
> debug_print_object+0x16a/0x210 lib/debugobjects.c:326
> Kernel panic - not syncing: panic_on_warn set ...


Was this fixed by something?
It happened a number of times, but then stopped after Oct 23 2018. Was it:

commit 26b5a079197c8cb6725565968b7fd3299bd1877b
Author: Sheng Yong <shengyong1@huawei.com>
Date:   Fri Oct 12 18:49:26 2018 +0800
    f2fs: cleanup dirty pages if recover failed

which fixed some bugs in f2fs_fill_super?



> CPU: 1 PID: 18832 Comm: syz-executor4 Not tainted 4.18.0-next-20180824+ #47
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   panic+0x238/0x4e7 kernel/panic.c:184
>   __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>   report_bug+0x252/0x2d0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:178 [inline]
>   do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>   do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:996
> RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
> Code: 3a 87 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd
> 20 e5 3a 87 4c 89 f6 48 c7 c7 c0 da 3a 87 e8 26 ec e3 fd <0f> 0b 83 05 a9
> 49 28 05 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
> RSP: 0018:ffff8801a9a97360 EFLAGS: 00010082
> RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffc90012037000
> RDX: 000000000002cd2b RSI: ffffffff8163b051 RDI: 0000000000000001
> RBP: ffff8801a9a973a0 R08: ffff8801c1f76100 R09: ffffed003b623eca
> R10: ffffed003b623eca R11: ffff8801db11f657 R12: 0000000000000001
> R13: ffffffff882b7ae0 R14: ffffffff873adf60 R15: 0000000000000000
>   __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
>   debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:818
>   kfree+0xc7/0x210 mm/slab.c:3812
>   f2fs_fill_super+0xe1a/0x8150 fs/f2fs/super.c:3147
>   mount_bdev+0x314/0x3e0 fs/super.c:1347
>   f2fs_mount+0x3c/0x50 fs/f2fs/super.c:3161
>   legacy_get_tree+0x131/0x460 fs/fs_context.c:732
>   vfs_get_tree+0x1cb/0x5c0 fs/super.c:1746
>   do_new_mount fs/namespace.c:2627 [inline]
>   do_mount+0x6f9/0x1e30 fs/namespace.c:2951
>   ksys_mount+0x12d/0x140 fs/namespace.c:3167
>   __do_sys_mount fs/namespace.c:3181 [inline]
>   __se_sys_mount fs/namespace.c:3178 [inline]
>   __x64_sys_mount+0xbe/0x150 fs/namespace.c:3178
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459aba
> Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 bd 8a fb ff c3 66 2e 0f
> 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 9a 8a fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007f16f9937a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f16f9937b30 RCX: 0000000000459aba
> RDX: 00007f16f9937ad0 RSI: 0000000020000100 RDI: 00007f16f9937af0
> RBP: 0000000020000100 R08: 00007f16f9937b30 R09: 00007f16f9937ad0
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
> R13: 0000000000000000 R14: 00000000004c9c12 R15: 0000000000000000
>
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.18.0-next-20180824+ #47 Not tainted
> ------------------------------------------------------
> syz-executor4/18832 is trying to acquire lock:
> 00000000cd8e7eb7 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70
> kernel/locking/semaphore.c:136
>
> but task is already holding lock:
> 0000000046ad1dd4 (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed
> lib/debugobjects.c:777 [inline]
> 0000000046ad1dd4 (&obj_hash[i].lock){-.-.}, at:
> debug_check_no_obj_freed+0x16c/0x595 lib/debugobjects.c:818
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #3 (&obj_hash[i].lock){-.-.}:
>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>         _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>         __debug_object_init+0x127/0x12e0 lib/debugobjects.c:384
>         debug_object_init+0x16/0x20 lib/debugobjects.c:432
>         debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
>         debug_init kernel/time/hrtimer.c:458 [inline]
>         hrtimer_init+0x97/0x410 kernel/time/hrtimer.c:1308
>         init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1057
>         __sched_fork+0x2ae/0x590 kernel/sched/core.c:2160
>         init_idle+0x75/0x740 kernel/sched/core.c:5377
>         sched_init+0xbee/0xcbd kernel/sched/core.c:6060
>         start_kernel+0x47d/0x94e init/main.c:602
>         x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
>         x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
>         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
>
> -> #2 (&rq->lock){-.-.}:
>         __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>         _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
>         rq_lock kernel/sched/sched.h:1821 [inline]
>         task_fork_fair+0x93/0x680 kernel/sched/fair.c:9574
>         sched_fork+0x44b/0xbd0 kernel/sched/core.c:2353
>         copy_process+0x235e/0x7af0 kernel/fork.c:1840
>         _do_fork+0x1ca/0x1170 kernel/fork.c:2169
>         kernel_thread+0x34/0x40 kernel/fork.c:2228
>         rest_init+0x22/0xe4 init/main.c:408
>         start_kernel+0x913/0x94e init/main.c:739
>         x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
>         x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
>         secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
>
> -> #1 (&p->pi_lock){-.-.}:
>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>         _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>         try_to_wake_up+0xd2/0x1250 kernel/sched/core.c:1960
>         wake_up_process+0x10/0x20 kernel/sched/core.c:2123
>         __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
>         up+0x13c/0x1c0 kernel/locking/semaphore.c:187
>         __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:245
>         console_unlock+0x506/0x10d0 kernel/printk/printk.c:2430
>         con_install+0x34e/0x420 drivers/tty/vt/vt.c:3241
>         tty_driver_install_tty drivers/tty/tty_io.c:1224 [inline]
>         tty_init_dev+0xfd/0x460 drivers/tty/tty_io.c:1324
>         tty_open_by_driver drivers/tty/tty_io.c:1959 [inline]
>         tty_open+0x692/0xb30 drivers/tty/tty_io.c:2007
>         chrdev_open+0x25a/0x770 fs/char_dev.c:417
>         do_dentry_open+0x49c/0x1140 fs/open.c:771
>         vfs_open+0xa0/0xd0 fs/open.c:880
>         do_last fs/namei.c:3418 [inline]
>         path_openat+0x12fb/0x5300 fs/namei.c:3534
>         do_filp_open+0x255/0x380 fs/namei.c:3564
>         do_sys_open+0x584/0x720 fs/open.c:1063
>         __do_sys_open fs/open.c:1081 [inline]
>         __se_sys_open fs/open.c:1076 [inline]
>         __x64_sys_open+0x7e/0xc0 fs/open.c:1076
>         do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #0 ((console_sem).lock){-.-.}:
>         lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
>         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>         _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>         down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>         __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:228
>         console_trylock+0x15/0xa0 kernel/printk/printk.c:2249
>         console_trylock_spinning kernel/printk/printk.c:1651 [inline]
>         vprintk_emit+0x31f/0x910 kernel/printk/printk.c:1926
>         vprintk_default+0x28/0x30 kernel/printk/printk.c:1968
>         vprintk_func+0x7a/0x117 kernel/printk/printk_safe.c:398
>         printk+0xa7/0xcf kernel/printk/printk.c:2001
>         __warn_printk+0x8c/0xe0 kernel/panic.c:590
>         debug_print_object+0x16a/0x210 lib/debugobjects.c:326
>         __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
>         debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:818
>         kfree+0xc7/0x210 mm/slab.c:3812
>         f2fs_fill_super+0xe1a/0x8150 fs/f2fs/super.c:3147
>         mount_bdev+0x314/0x3e0 fs/super.c:1347
>         f2fs_mount+0x3c/0x50 fs/f2fs/super.c:3161
>         legacy_get_tree+0x131/0x460 fs/fs_context.c:732
>         vfs_get_tree+0x1cb/0x5c0 fs/super.c:1746
>         do_new_mount fs/namespace.c:2627 [inline]
>         do_mount+0x6f9/0x1e30 fs/namespace.c:2951
>         ksys_mount+0x12d/0x140 fs/namespace.c:3167
>         __do_sys_mount fs/namespace.c:3181 [inline]
>         __se_sys_mount fs/namespace.c:3178 [inline]
>         __x64_sys_mount+0xbe/0x150 fs/namespace.c:3178
>         do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> other info that might help us debug this:
>
> Chain exists of:
>    (console_sem).lock --> &rq->lock --> &obj_hash[i].lock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&obj_hash[i].lock);
>                                 lock(&rq->lock);
>                                 lock(&obj_hash[i].lock);
>    lock((console_sem).lock);
>
>   *** DEADLOCK ***
>
> 2 locks held by syz-executor4/18832:
>   #0: 000000002b55bbcc (&fc->fs_type->s_umount_key#49/1){+.+.}, at:
> alloc_super+0x25e/0xb20 fs/super.c:225
>   #1: 0000000046ad1dd4 (&obj_hash[i].lock){-.-.}, at:
> __debug_check_no_obj_freed lib/debugobjects.c:777 [inline]
>   #1: 0000000046ad1dd4 (&obj_hash[i].lock){-.-.}, at:
> debug_check_no_obj_freed+0x16c/0x595 lib/debugobjects.c:818
>
> stack backtrace:
> CPU: 1 PID: 18832 Comm: syz-executor4 Not tainted 4.18.0-next-20180824+ #47
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>   print_circular_bug.isra.34.cold.55+0x1bd/0x27d
> kernel/locking/lockdep.c:1222
>   check_prev_add kernel/locking/lockdep.c:1862 [inline]
>   check_prevs_add kernel/locking/lockdep.c:1975 [inline]
>   validate_chain kernel/locking/lockdep.c:2416 [inline]
>   __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3412
>   lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
>   down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
>   __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:228
>   console_trylock+0x15/0xa0 kernel/printk/printk.c:2249
>   console_trylock_spinning kernel/printk/printk.c:1651 [inline]
>   vprintk_emit+0x31f/0x910 kernel/printk/printk.c:1926
>   vprintk_default+0x28/0x30 kernel/printk/printk.c:1968
>   vprintk_func+0x7a/0x117 kernel/printk/printk_safe.c:398
>   printk+0xa7/0xcf kernel/printk/printk.c:2001
>   __warn_printk+0x8c/0xe0 kernel/panic.c:590
>   debug_print_object+0x16a/0x210 lib/debugobjects.c:326
>   __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
>   debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:818
>   kfree+0xc7/0x210 mm/slab.c:3812
>   f2fs_fill_super+0xe1a/0x8150 fs/f2fs/super.c:3147
>   mount_bdev+0x314/0x3e0 fs/super.c:1347
>   f2fs_mount+0x3c/0x50 fs/f2fs/super.c:3161
>   legacy_get_tree+0x131/0x460 fs/fs_context.c:732
>   vfs_get_tree+0x1cb/0x5c0 fs/super.c:1746
>   do_new_mount fs/namespace.c:2627 [inline]
>   do_mount+0x6f9/0x1e30 fs/namespace.c:2951
>   ksys_mount+0x12d/0x140 fs/namespace.c:3167
>   __do_sys_mount fs/namespace.c:3181 [inline]
>   __se_sys_mount fs/namespace.c:3178 [inline]
>   __x64_sys_mount+0xbe/0x150 fs/namespace.c:3178
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459aba
> Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 bd 8a fb ff c3 66 2e 0f
> 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 9a 8a fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007f16f9937a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f16f9937b30 RCX: 0000000000459aba
> RDX: 00007f16f9937ad0 RSI: 0000000020000100 RDI: 00007f16f9937af0
> RBP: 0000000020000100 R08: 00007f16f9937b30 R09: 00007f16f9937ad0
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
> R13: 0000000000000000 R14: 00000000004c9c12 R15: 0000000000000000
> Dumping ftrace buffer:
> ---------------------------------
> syz-exec-23595   1...2 1079757271us : 0: }D
> syz-exec-23595   1..s3 1079757464us : 0: }D
> ---------------------------------
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
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009e76240574711017%40google.com.
> For more options, visit https://groups.google.com/d/optout.
