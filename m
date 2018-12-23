Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B25C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883B021773
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 07:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeLWHVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 02:21:05 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:44966 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeLWHVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 02:21:05 -0500
Received: by mail-io1-f70.google.com with SMTP id v8so9580167ioh.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 23:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CAdOTMqZNBSSDU/1i2hV2rOd+ZJRRuR23p8brqxJna8=;
        b=nhneiV1TIFFDgSxJ1s2UnO3EqGfSmX9kD6n1vG19XaodBvhEeQloEeJ06REpsB7n7b
         D47Zg2ZCaRnFAc/q0cCme9Mi6I3pOGGBC0QrIV2D03UJG3L/N8kIiWfML904T7TRF1K2
         lOqiZ7DOaL/gP7lhB8Oipy5XNw1kMV6jk3ml09GwQNrFpk9Jdo5geXKtz0s1K+xoFUPt
         AqUBC9Swz3v9twXlg9lvKJjZreh4+TZw2TJ/MY0EVG7AquhSSpnsMdKAdeRO8XWCPA8d
         C5ocx85FZejq/XHm6sj+NTsEl6xzCRmM8en5ax1O5e3XDZ6vzHNTTAgi77p58OYcJxky
         rBWw==
X-Gm-Message-State: AA+aEWZeBP5yNlWvAhpfvRVdbtD5mHAE/hduetKLEqG2WpTAgEb9c0UV
        RAcMEi8VybjTQXIDw1Q2VMwi0RBxDlMLLoD+prY5/97LK5nt
X-Google-Smtp-Source: AFSGD/WxshXEEUWPk9UkNIjbWXPRUTpRpbCwBY2r6fsb3TC8+mSoaECzL1WaVjZysokc97uKInRDggH03DcHmVr7Qgw5XjtHtC+t
MIME-Version: 1.0
X-Received: by 2002:a24:1c87:: with SMTP id c129mr6669511itc.11.1545549663756;
 Sat, 22 Dec 2018 23:21:03 -0800 (PST)
Date:   Sat, 22 Dec 2018 23:21:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0eab6057dab52d4@google.com>
Subject: WARNING: ODEBUG bug in tipc_enable_bearer
From:   syzbot <syzbot+b981acf1fb240c0c128b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ce28bb445388 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10eddf97400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67a2081147a23142
dashboard link: https://syzkaller.appspot.com/bug?extid=b981acf1fb240c0c128b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a348c3400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134f5b1b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b981acf1fb240c0c128b@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Disabling bearer <eth:bridge_slave_1>
------------[ cut here ]------------
ODEBUG: free active (active state 1) object type: rcu_head hint:            
(null)
WARNING: CPU: 1 PID: 6104 at lib/debugobjects.c:328  
debug_print_object+0x16a/0x210 lib/debugobjects.c:325
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6104 Comm: syz-executor926 Not tainted 4.20.0-rc7+ #358
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:debug_print_object+0x16a/0x210 lib/debugobjects.c:325
Code: 60 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
e0 f7 60 88 4c 89 fe 48 c7 c7 80 ed 60 88 e8 16 a6 b7 fd <0f> 0b 83 05 61  
92 86 06 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff8881b3856fe0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81653fa5 RDI: 0000000000000005
RBP: ffff8881b3857020 R08: ffff8881bd440300 R09: ffffed103b5e3ef8
R10: ffffed103b5e3ef8 R11: ffff8881daf1f7c7 R12: 0000000000000001
R13: ffffffff8959bf20 R14: 0000000000000000 R15: ffffffff8860f220
  __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
  debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:817
  kfree+0xbd/0x230 mm/slab.c:3816
  tipc_enable_bearer+0xefa/0xf10 net/tipc/bearer.c:322
  __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:900
  tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:908
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x59f/0x750 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4456a9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc7161d698 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffc7161d6e0 RCX: 00000000004456a9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000000001 R09: 0000000000000100
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000

======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc7+ #358 Not tainted
------------------------------------------------------
syz-executor926/6104 is trying to acquire lock:
0000000065118b5a ((console_sem).lock){-...}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
00000000d78d5834 (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed  
lib/debugobjects.c:776 [inline]
00000000d78d5834 (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x17a/0x58d lib/debugobjects.c:817

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&obj_hash[i].lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        __debug_object_init+0x127/0x1290 lib/debugobjects.c:383
        debug_object_init+0x16/0x20 lib/debugobjects.c:431
        debug_hrtimer_init kernel/time/hrtimer.c:410 [inline]
        debug_init kernel/time/hrtimer.c:458 [inline]
        hrtimer_init+0x97/0x490 kernel/time/hrtimer.c:1308
        init_dl_task_timer+0x1b/0x50 kernel/sched/deadline.c:1057
        __sched_fork+0x2ae/0x590 kernel/sched/core.c:2166
        init_idle+0x75/0x6d0 kernel/sched/core.c:5374
        sched_init+0xb33/0xc07 kernel/sched/core.c:6063
        start_kernel+0x448/0x8fd init/main.c:608
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1124 [inline]
        task_fork_fair+0xb0/0x6d0 kernel/sched/fair.c:9802
        sched_fork+0x443/0xba0 kernel/sched/core.c:2359
        copy_process+0x25b8/0x8790 kernel/fork.c:1887
        _do_fork+0x1cb/0x11d0 kernel/fork.c:2216
        kernel_thread+0x34/0x40 kernel/fork.c:2275
        rest_init+0x28/0x372 init/main.c:409
        arch_call_rest_init+0xe/0x1b
        start_kernel+0x8c2/0x8fd init/main.c:745
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
        secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xdc/0x1460 kernel/sched/core.c:1965
        wake_up_process+0x10/0x20 kernel/sched/core.c:2129
        __up.isra.1+0x1c0/0x2a0 kernel/locking/semaphore.c:262
        up+0x13c/0x1c0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:236
        console_unlock+0x811/0x1180 kernel/printk/printk.c:2432
        vprintk_emit+0x39c/0x990 kernel/printk/printk.c:1922
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1997
        check_stack_usage kernel/exit.c:755 [inline]
        do_exit.cold.19+0x57/0x16f kernel/exit.c:916
        do_group_exit+0x177/0x440 kernel/exit.c:970
        __do_sys_exit_group kernel/exit.c:981 [inline]
        __se_sys_exit_group kernel/exit.c:979 [inline]
        __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:979
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-...}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:219
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
        console_trylock_spinning kernel/printk/printk.c:1653 [inline]
        vprintk_emit+0x37d/0x990 kernel/printk/printk.c:1921
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
        vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
        printk+0xa7/0xcf kernel/printk/printk.c:1997
        __warn_printk+0x8c/0xe0 kernel/panic.c:594
        debug_print_object+0x16a/0x210 lib/debugobjects.c:325
        __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
        debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:817
        kfree+0xbd/0x230 mm/slab.c:3816
        tipc_enable_bearer+0xefa/0xf10 net/tipc/bearer.c:322
        __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:900
        tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:908
        genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
        genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
        netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
        genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
        netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
        netlink_unicast+0x59f/0x750 net/netlink/af_netlink.c:1336
        netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
        sock_sendmsg_nosec net/socket.c:621 [inline]
        sock_sendmsg+0xd5/0x120 net/socket.c:631
        ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
        __sys_sendmsg+0x11d/0x280 net/socket.c:2154
        __do_sys_sendmsg net/socket.c:2163 [inline]
        __se_sys_sendmsg net/socket.c:2161 [inline]
        __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
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

4 locks held by syz-executor926/6104:
  #0: 000000008bc6bb7a (cb_lock){++++}, at: genl_rcv+0x19/0x40  
net/netlink/genetlink.c:636
  #1: 000000005a3e3ae6 (genl_mutex){+.+.}, at: genl_lock  
net/netlink/genetlink.c:33 [inline]
  #1: 000000005a3e3ae6 (genl_mutex){+.+.}, at: genl_rcv_msg+0x13a/0x168  
net/netlink/genetlink.c:624
  #2: 00000000fe29ad2e (rtnl_mutex){+.+.}, at: rtnl_lock+0x17/0x20  
net/core/rtnetlink.c:77
  #3: 00000000d78d5834 (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:776 [inline]
  #3: 00000000d78d5834 (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x17a/0x58d lib/debugobjects.c:817

stack backtrace:
CPU: 1 PID: 6104 Comm: syz-executor926 Not tainted 4.20.0-rc7+ #358
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_circular_bug.isra.33.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3360/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x99/0xd0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:219
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2247
  console_trylock_spinning kernel/printk/printk.c:1653 [inline]
  vprintk_emit+0x37d/0x990 kernel/printk/printk.c:1921
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1964
  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
  printk+0xa7/0xcf kernel/printk/printk.c:1997
  __warn_printk+0x8c/0xe0 kernel/panic.c:594
  debug_print_object+0x16a/0x210 lib/debugobjects.c:325
  __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
  debug_check_no_obj_freed+0x3ae/0x58d lib/debugobjects.c:817
  kfree+0xbd/0x230 mm/slab.c:3816
  tipc_enable_bearer+0xefa/0xf10 net/tipc/bearer.c:322
  __tipc_nl_bearer_enable+0x37c/0x4a0 net/tipc/bearer.c:900
  tipc_nl_bearer_enable+0x22/0x30 net/tipc/bearer.c:908
  genl_family_rcv_msg+0x8a7/0x11a0 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x59f/0x750 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  ? trace_hardirqs_of
Lost 14 message(s)!
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
