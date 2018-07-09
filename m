Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90051C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3161C20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3161C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932921AbeGITbF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:31:05 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:35729 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932686AbeGITbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:31:02 -0400
Received: by mail-it0-f71.google.com with SMTP id r184-v6so11314530ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 12:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZPTzgkdWTCXLfNy8dwW5FEHu1mfh9LDpYlPhDWPfF7o=;
        b=OBcyILz2AII9KW11lzj3GaAfbI0QRPIf1g9ExTxJEvR5XGZG586XKzAdOA+qAyQX1Z
         XZ3oqpg72F2266L4iyz6ObX5WVGFX34fYlrS40bdg4R6zYDzWSBn+0q0sxG1vF1xdIe8
         5fX1/ifesJfbF9udHE6biJNbjn0i46w2JzRIfCLGh6w8eR7VnYsArGNnpCxWy/RRAFGk
         SsMN2EuZLgkf76H58cD0+VD/YZYE2fkeJtQHLveHwEstcFxHctYs9tPBZ2IRHzL8ngvt
         1VdRCH0OSrN6XGxLhTef/PnE1UJNHUdLFbD2HmFRBbll6D6yXBnSZjgcW7KNj3/HPJ/0
         YpuA==
X-Gm-Message-State: APt69E0FV4zkTAkSmy9Ug5VUEa4FVD51jNtn+3vHt9Z07Gv/u55Zm2pc
        QXY4bxHDGWM9zKLfaBJUhJUzFQboTGsy5gfKJRHMkQZVnsz4
X-Google-Smtp-Source: AAOMgpfzH76g5zTJ5MsQ19jC2RW4ebrlc+2HkRIpVeMVkz5zmz8c5rCF1NEs0Mor/XyrnLNOZXk6jJ8QY4YqAPBdEeE+dT7q1yFP
MIME-Version: 1.0
X-Received: by 2002:a6b:8d8a:: with SMTP id p132-v6mr9891881iod.59.1531164662079;
 Mon, 09 Jul 2018 12:31:02 -0700 (PDT)
Date:   Mon, 09 Jul 2018 12:31:02 -0700
In-Reply-To: <00000000000024f01405708aab83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6aec70570960d29@google.com>
Subject: Re: WARNING: ODEBUG bug in p9_fd_close
From:   syzbot <syzbot+d702a81aadeedd565723@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    1e4b044d2251 Linux 4.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100ff170400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=d702a81aadeedd565723
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17fa550c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1214c2c2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d702a81aadeedd565723@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint:  
p9_read_work+0x0/0x1060 net/9p/trans_fd.c:208
WARNING: CPU: 1 PID: 4559 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 4559 Comm: syz-executor938 Not tainted 4.18.0-rc4+ #138
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Code: 1a 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
a0 71 1a 88 4c 89 f6 48 c7 c7 40 67 1a 88 e8 c6 94 e6 fd <0f> 0b 83 05 d9  
66 3e 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff8801ce7172d8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81631821 RDI: 0000000000000001
RBP: ffff8801ce717318 R08: ffff8801b1ad0040 R09: ffffed003b5e3ec2
R10: ffffed003b5e3ec2 R11: ffff8801daf1f617 R12: 0000000000000001
R13: ffffffff88f63820 R14: ffffffff881a6be0 R15: ffffffff814ea9c0
  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
  debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:815
  kfree+0xc7/0x260 mm/slab.c:3812
  p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
  p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44aa59
Code: e8 4c c2 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f86c9470da8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006f0024 RCX: 000000000044aa59
RDX: 0000000020000100 RSI: 0000000020000340 RDI: 0000000000000000
RBP: 00000000006f0020 R08: 00000000200001c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 6f72746e6f632f2e
R13: 7363762f7665642f R14: 64663d736e617274 R15: 0000000000000001

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc4+ #138 Not tainted
------------------------------------------------------
syz-executor938/4559 is trying to acquire lock:
000000002f789677 ((console_sem).lock){-...}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
00000000d059bb19 (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed  
lib/debugobjects.c:774 [inline]
00000000d059bb19 (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x16c/0x595 lib/debugobjects.c:815

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&obj_hash[i].lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        __debug_object_init+0x127/0x12e0 lib/debugobjects.c:381
        debug_object_init+0x16/0x20 lib/debugobjects.c:429
        debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
        debug_init kernel/time/hrtimer.c:458 [inline]
        hrtimer_init+0x97/0x480 kernel/time/hrtimer.c:1308
        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1056
        __sched_fork+0x2ae/0x590 kernel/sched/core.c:2185
        init_idle+0x75/0x7a0 kernel/sched/core.c:5405
        sched_init+0xbf3/0xd2c kernel/sched/core.c:6103
        start_kernel+0x47d/0x949 init/main.c:602
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1812 [inline]
        task_fork_fair+0x93/0x680 kernel/sched/fair.c:9952
        sched_fork+0x446/0xb40 kernel/sched/core.c:2381
        copy_process.part.39+0x1c09/0x7220 kernel/fork.c:1773
        copy_process kernel/fork.c:1616 [inline]
        _do_fork+0x291/0x12a0 kernel/fork.c:2099
        kernel_thread+0x34/0x40 kernel/fork.c:2158
        rest_init+0x22/0xe4 init/main.c:408
        start_kernel+0x90e/0x949 init/main.c:738
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xd2/0x12b0 kernel/sched/core.c:1985
        wake_up_process+0x10/0x20 kernel/sched/core.c:2148
        __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13c/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:242
        console_unlock+0x7a2/0x10b0 kernel/printk/printk.c:2411
        vprintk_emit+0x6c6/0xdf0 kernel/printk/printk.c:1907
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
        printk+0xa7/0xcf kernel/printk/printk.c:1981
        load_umh+0x51/0xbd net/bpfilter/bpfilter_kern.c:98
        do_one_initcall+0x127/0x913 init/main.c:884
        do_initcall_level init/main.c:952 [inline]
        do_initcalls init/main.c:960 [inline]
        do_basic_setup init/main.c:978 [inline]
        kernel_init_freeable+0x49b/0x58e init/main.c:1135
        kernel_init+0x11/0x1b3 init/main.c:1061
        ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

-> #0 ((console_sem).lock){-...}:
        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2230
        console_trylock_spinning kernel/printk/printk.c:1643 [inline]
        vprintk_emit+0x6ad/0xdf0 kernel/printk/printk.c:1906
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
        printk+0xa7/0xcf kernel/printk/printk.c:1981
        __warn_printk+0x8c/0xe0 kernel/panic.c:590
        debug_print_object+0x16a/0x210 lib/debugobjects.c:326
        __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
        debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:815
        kfree+0xc7/0x260 mm/slab.c:3812
        p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
        p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
        v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
        v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
        mount_fs+0xae/0x328 fs/super.c:1277
        vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
        vfs_kern_mount fs/namespace.c:1027 [inline]
        do_new_mount fs/namespace.c:2518 [inline]
        do_mount+0x581/0x30e0 fs/namespace.c:2848
        ksys_mount+0x12d/0x140 fs/namespace.c:3064
        __do_sys_mount fs/namespace.c:3078 [inline]
        __se_sys_mount fs/namespace.c:3075 [inline]
        __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
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

1 lock held by syz-executor938/4559:
  #0: 00000000d059bb19 (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:774 [inline]
  #0: 00000000d059bb19 (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x16c/0x595 lib/debugobjects.c:815

stack backtrace:
CPU: 1 PID: 4559 Comm: syz-executor938 Not tainted 4.18.0-rc4+ #138
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.57+0x1bd/0x27d  
kernel/locking/lockdep.c:1227
  check_prev_add kernel/locking/lockdep.c:1867 [inline]
  check_prevs_add kernel/locking/lockdep.c:1980 [inline]
  validate_chain kernel/locking/lockdep.c:2421 [inline]
  __lock_acquire+0x3449/0x5020 kernel/locking/lockdep.c:3435
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2230
  console_trylock_spinning kernel/printk/printk.c:1643 [inline]
  vprintk_emit+0x6ad/0xdf0 kernel/printk/printk.c:1906
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1948
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:382
  printk+0xa7/0xcf kernel/printk/printk.c:1981
  __warn_printk+0x8c/0xe0 kernel/panic.c:590
  debug_print_object+0x16a/0x210 lib/debugobjects.c:326
  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
  debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:815
  kfree+0xc7/0x260 mm/slab.c:3812
  p9_fd_close+0x416/0x5b0 net/9p/trans_fd.c:893
  p9_client_create+0xac2/0x16c9 net/9p/client.c:1076
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44aa59
Code: e8 4c c2 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f86c9470da8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000006f0024 RCX: 000000000044aa59
RDX: 0000000020000100 RSI: 0000000020000340 RDI: 0000000000000000
RBP: 00000000006f0020 R08: 00000000200001c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 6f72746e6f632f2e
R13: 7363762f7665642f R14: 64663d736e617274 R15: 0000000000000001
Shutting down cpus with NMI
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

