Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA53BC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DE920827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389307AbeKGLUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:20:16 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:50621 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389114AbeKGLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:20:15 -0500
Received: by mail-it1-f198.google.com with SMTP id p206-v6so13371563itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jJ6iItgcitFE6kdnD5dXMSlrvJIa/kC/j6FNFJP1rxU=;
        b=Trmng7AUXuwnhFqrv1aTRLOMZKnQQ9THjjfX6nVCDj8OV0VPkiM4adQUKWwzp8LBMs
         E5a1P+YYQdd56vZOyJvR/CsnaqhZ5ghcbUQJSZUiDZdQSwuaG6UkXdf+58K7NEF+LyIj
         1nZ5n5vgHDcpyfLd1OcRjzZ0BvLayHXXagUvDb8S2cc6QcVbIx7KcXeyBVq74/EnfdNF
         jVN3GMP8lUpGuaLmbe/tRYPhDsDcWfAmhnzEZyKIJgAQEhmRncMRIlthzLFriMigp61V
         CQP2tzAB7tDrSXsY0HJkX+mLRl3iuQREbIpQ6nowvyro0P8l0q631I1nx+MU3SvPTQOl
         aBxg==
X-Gm-Message-State: AGRZ1gKrVr98gkPw7UMZW92W2mnNGWXbLuX173sTUBLtiWN62mFn/DE6
        07dPlY4OvWQTMjSa9u48QD1v+YF0kmKIF1I7Da83HswNsMov
X-Google-Smtp-Source: AJdET5c3lj2qjdfLx9yr6UbLV79M+mSLJIehfI6vFkLsc180Cy1xpk3gK+447LEZZ6OO3iFNTjTtMSx9QeUuz9IEVixKBMfCrKHG
MIME-Version: 1.0
X-Received: by 2002:a02:661c:: with SMTP id k28-v6mr23322001jac.22.1541555523597;
 Tue, 06 Nov 2018 17:52:03 -0800 (PST)
Date:   Tue, 06 Nov 2018 17:52:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062c5c3057a095d25@google.com>
Subject: WARNING: ODEBUG bug in tls_sw_free_resources_tx
From:   syzbot <syzbot+70ab6a1f8151888c4ea0@syzkaller.appspotmail.com>
To:     aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c6c54b505b8 Merge branch 'i2c/for-next' of git://git.kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1276246d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=136ed5b316dbf1d8
dashboard link: https://syzkaller.appspot.com/bug?extid=70ab6a1f8151888c4ea0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+70ab6a1f8151888c4ea0@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint:  
delayed_work_timer_fn+0x0/0x90 include/linux/compiler.h:179
WARNING: CPU: 1 PID: 17315 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17315 Comm: syz-executor5 Not tainted 4.19.0+ #281
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:966
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Code: 60 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
c0 c2 60 88 4c 89 fe 48 c7 c7 60 b8 60 88 e8 76 ea b5 fd <0f> 0b 83 05 11  
01 82 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff880192ea76e0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165d6c5 RDI: 0000000000000005
RBP: ffff880192ea7720 R08: ffff880190074640 R09: ffffed003b5e3ef8
R10: ffffed003b5e3ef8 R11: ffff8801daf1f7c7 R12: 0000000000000001
R13: ffffffff895a51c0 R14: ffffffff816c19a0 R15: ffffffff8860bd00
  __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
  debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:818
  kfree+0xbd/0x230 mm/slab.c:3816
  tls_sw_free_resources_tx+0x826/0xcf0 net/tls/tls_sw.c:1808
  tls_sk_proto_close+0x602/0x750 net/tls/tls_main.c:278
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffeccfec1d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411021
RDX: 0000000000000000 RSI: 0000000000730870 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000e2abfaa8 R09: 00000000e2abfaac
R10: 00007ffeccfec100 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000512 R15: 0000000000000005

======================================================
WARNING: possible circular locking dependency detected
4.19.0+ #281 Not tainted
------------------------------------------------------
syz-executor5/17315 is trying to acquire lock:
00000000b56e5405 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000008f462fd4 (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed  
lib/debugobjects.c:777 [inline]
000000008f462fd4 (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x17a/0x58d lib/debugobjects.c:818

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&obj_hash[i].lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        __debug_object_init+0x127/0x1290 lib/debugobjects.c:384
        debug_object_init+0x16/0x20 lib/debugobjects.c:432
        debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
        debug_init kernel/time/hrtimer.c:458 [inline]
        hrtimer_init+0x97/0x490 kernel/time/hrtimer.c:1308
        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1057
        __sched_fork+0x2ae/0x590 kernel/sched/core.c:2166
        init_idle+0x75/0x740 kernel/sched/core.c:5374
        sched_init+0xb33/0xc07 kernel/sched/core.c:6057
        start_kernel+0x4be/0xa2b init/main.c:608
        x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1126 [inline]
        task_fork_fair+0xb0/0x6d0 kernel/sched/fair.c:9768
        sched_fork+0x443/0xba0 kernel/sched/core.c:2359
        copy_process+0x25b8/0x87a0 kernel/fork.c:1886
        _do_fork+0x1cb/0x11d0 kernel/fork.c:2213
        kernel_thread+0x34/0x40 kernel/fork.c:2272
        rest_init+0x28/0x372 init/main.c:409
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x9f0/0xa2b init/main.c:745
        x86_64_start_reservations+0x2e/0x30 arch/x86/kernel/head64.c:472
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xdc/0x1490 kernel/sched/core.c:1965
        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
        __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13c/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:236
        console_unlock+0x811/0x1190 kernel/printk/printk.c:2432
        vprintk_emit+0x391/0x990 kernel/printk/printk.c:1922
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1997
        check_stack_usage kernel/exit.c:755 [inline]
        do_exit.cold.18+0x57/0x16f kernel/exit.c:916
        do_group_exit+0x177/0x440 kernel/exit.c:970
        __do_sys_exit_group kernel/exit.c:981 [inline]
        __se_sys_exit_group kernel/exit.c:979 [inline]
        __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-.-.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:219
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
        console_trylock_spinning kernel/printk/printk.c:1653 [inline]
        vprintk_emit+0x372/0x990 kernel/printk/printk.c:1921
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1997
        __warn_printk+0x8c/0xe0 kernel/panic.c:594
        debug_print_object+0x16a/0x210 lib/debugobjects.c:326
        __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
        debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:818
        kfree+0xbd/0x230 mm/slab.c:3816
        tls_sw_free_resources_tx+0x826/0xcf0 net/tls/tls_sw.c:1808
        tls_sk_proto_close+0x602/0x750 net/tls/tls_main.c:278
        inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
        inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
        __sock_release+0xd7/0x250 net/socket.c:579
        sock_close+0x19/0x20 net/socket.c:1141
        __fput+0x385/0xa30 fs/file_table.c:278
        ____fput+0x15/0x20 fs/file_table.c:309
        task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
        tracehook_notify_resume include/linux/tracehook.h:188 [inline]
        exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
        prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
        syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
        do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   (console_sem).lock --> &rq->lock --> &obj_hash[i].lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&obj_hash[i].lock);
                                lock(&rq->lock);
                                lock(&obj_hash[i].lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

3 locks held by syz-executor5/17315:
  #0: 0000000097b82416 (&sb->s_type->i_mutex_key#11){+.+.}, at: inode_lock  
include/linux/fs.h:757 [inline]
  #0: 0000000097b82416 (&sb->s_type->i_mutex_key#11){+.+.}, at:  
__sock_release+0x8b/0x250 net/socket.c:578
  #1: 00000000ea6832e0 (sk_lock-AF_INET6){+.+.}, at: lock_sock  
include/net/sock.h:1492 [inline]
  #1: 00000000ea6832e0 (sk_lock-AF_INET6){+.+.}, at:  
tls_sk_proto_close+0xf5/0x750 net/tls/tls_main.c:262
  #2: 000000008f462fd4 (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:777 [inline]
  #2: 000000008f462fd4 (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x17a/0x58d lib/debugobjects.c:818

stack backtrace:
CPU: 1 PID: 17315 Comm: syz-executor5 Not tainted 4.19.0+ #281
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xae/0x1f0 kernel/printk/printk.c:219
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
  console_trylock_spinning kernel/printk/printk.c:1653 [inline]
  vprintk_emit+0x372/0x990 kernel/printk/printk.c:1921
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
  printk+0xa7/0xcf kernel/printk/printk.c:1997
  __warn_printk+0x8c/0xe0 kernel/panic.c:594
  debug_print_object+0x16a/0x210 lib/debugobjects.c:326
  __debug_check_no_obj_freed lib/debugobjects.c:786 [inline]
  debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:818
  kfree+0xbd/0x230 mm/slab.c:3816
  tls_sw_free_resources_tx+0x826/0xcf0 net/tls/tls_sw.c:1808
  tls_sk_proto_close+0x602/0x750 net/tls/tls_main.c:278
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
  __sock_release+0xd7/0x250 net/socket.c:579
  sock_close+0x19/0x20 net/socket.c:1141
  __fput+0x385/0xa30 fs/file_table.c:278
  ____fput+0x15/0x20 fs/file_table.c:309
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411021
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffeccfec1d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411021
RDX: 0000000000000000 RSI: 0000000000730870 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000e2abfaa8 R09: 00000000e2abfaac
R10: 00007ffeccfec100 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000512 R15: 0000000000000005
Shutting down cpus with NMI
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
