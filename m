Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1008EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA88208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA88208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeGaIMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:12:46 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:47900 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeGaIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:12:46 -0400
Received: by mail-io0-f199.google.com with SMTP id z9-v6so10613447iom.14
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j4RjinoTw/v0eP8o2wPDrjoOIm52GJRCDEozG2+VI10=;
        b=U0q36gY5CNrnaUigRc8rPH/d5llorJU+0jbH62XqP9TM0wVt8mMGdCvhnTITGwVyct
         3aSSRuvw86uk9a4ZjH03PNgKJcSrpH66ZEUfBJE6YElaK1K1s4A7WoKuJw01NfI/suFA
         X9bxtnmCHpw/j7DBkRLnFQWBGRaM3MHpjW90eQVEMhDXSRxVV709zZAw/lZoEKcAia4h
         0Qt5PQavmxJtN/38bp5ul3xrO01SFrTh6zkjm6sPIRP3yUTPzHggAOs3ebO3REwcV/I/
         dhei0SSqohWFFeqyXJx0FgSqR2EC0TWYLFow8C85ajbyOJJ7R1eOTybmeHyp1ERzXd4L
         l3qg==
X-Gm-Message-State: AOUpUlFhF4LOPXm5M5PJoKq+yowPh5yhM3g3D6VW7BShaQDhLwsSuHzg
        B9n1FSe7LxTXgyz0B2uC8HGDYZ/JuCfKUeCFRlzXDxGGONgk
X-Google-Smtp-Source: AAOMgpfUL0zQPIIJDbcg+wqNlWTuUStNODMMElvwdvlZqNDAKC5gsQA5rb8SWbeh/FOnMstficPM0IihT00IX3fJmlErnWSzmPAj
MIME-Version: 1.0
X-Received: by 2002:a02:ba04:: with SMTP id z4-v6mr10168198jan.61.1533018842260;
 Mon, 30 Jul 2018 23:34:02 -0700 (PDT)
Date:   Mon, 30 Jul 2018 23:34:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086f39e057245c3ac@google.com>
Subject: WARNING: ODEBUG bug in rfcomm_dlc_free
From:   syzbot <syzbot+1f6d4ad860c650c2f215@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        keescook@chromium.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    527838d470e3 Merge branch 'x86-urgent-for-linus' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ebce52400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6d4ad860c650c2f215
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f6d4ad860c650c2f215@syzkaller.appspotmail.com

bond0: Error: Device is in use and cannot be enslaved
Unknown ioctl -1070573808
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint:  
rfcomm_dlc_timeout+0x0/0x70 include/linux/list.h:64
WARNING: CPU: 0 PID: 1696 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 1696 Comm: syz-executor4 Not tainted 4.18.0-rc7+ #170
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
Code: 3a 87 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 92 00 00 00 48 8b 14 dd  
20 74 3a 87 4c 89 f6 48 c7 c7 c0 69 3a 87 e8 c6 b0 e6 fd <0f> 0b 83 05 a9  
e6 29 05 01 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffff880191937648 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffc90007a4a000
RDX: 00000000000292e2 RSI: ffffffff81632481 RDI: 0000000000000001
RBP: ffff880191937688 R08: ffff8801b67b6340 R09: ffffed003b603ec2
R10: ffffed003b603ec2 R11: ffff8801db01f617 R12: 0000000000000001
R13: ffffffff87f9c9e0 R14: ffffffff873a6e60 R15: ffffffff816918a0
  __debug_check_no_obj_freed lib/debugobjects.c:783 [inline]
  debug_check_no_obj_freed+0x3b2/0x595 lib/debugobjects.c:815
  kfree+0xc7/0x260 mm/slab.c:3812
  rfcomm_dlc_free+0x1e/0x30 net/bluetooth/rfcomm/core.c:328
  rfcomm_dlc_put include/net/bluetooth/rfcomm.h:258 [inline]
  __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:417 [inline]
  rfcomm_create_dev net/bluetooth/rfcomm/tty.c:486 [inline]
  rfcomm_dev_ioctl+0x1dfe/0x2240 net/bluetooth/rfcomm/tty.c:588
  rfcomm_sock_ioctl+0x89/0xb0 net/bluetooth/rfcomm/sock.c:902
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:969
  sock_ioctl+0x30d/0x680 net/socket.c:1093
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456a09
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f521726dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f521726e6d4 RCX: 0000000000456a09
RDX: 0000000020000140 RSI: 00000000400452c8 RDI: 0000000000000014
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cddc0 R14: 00000000004c472b R15: 0000000000000001

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc7+ #170 Not tainted
------------------------------------------------------
syz-executor4/1696 is trying to acquire lock:
0000000072b74d86 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000001082e10b (&obj_hash[i].lock){-.-.}, at: __debug_check_no_obj_freed  
lib/debugobjects.c:774 [inline]
000000001082e10b (&obj_hash[i].lock){-.-.}, at:  
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
        copy_process.part.39+0x1bf5/0x70b0 kernel/fork.c:1796
        copy_process kernel/fork.c:1639 [inline]
        _do_fork+0x291/0x12a0 kernel/fork.c:2122
        kernel_thread+0x34/0x40 kernel/fork.c:2181
        rest_init+0x22/0xe4 init/main.c:408
        start_kernel+0x90e/0x949 init/main.c:738
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xd2/0x12a0 kernel/sched/core.c:1985
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

-> #0 ((console_sem).lock){-.-.}:
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
        rfcomm_dlc_free+0x1e/0x30 net/bluetooth/rfcomm/core.c:328
        rfcomm_dlc_put include/net/bluetooth/rfcomm.h:258 [inline]
        __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:417 [inline]
        rfcomm_create_dev net/bluetooth/rfcomm/tty.c:486 [inline]
        rfcomm_dev_ioctl+0x1dfe/0x2240 net/bluetooth/rfcomm/tty.c:588
        rfcomm_sock_ioctl+0x89/0xb0 net/bluetooth/rfcomm/sock.c:902
        sock_do_ioctl+0xe4/0x3e0 net/socket.c:969
        sock_ioctl+0x30d/0x680 net/socket.c:1093
        vfs_ioctl fs/ioctl.c:46 [inline]
        file_ioctl fs/ioctl.c:500 [inline]
        do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
        __do_sys_ioctl fs/ioctl.c:708 [inline]
        __se_sys_ioctl fs/ioctl.c:706 [inline]
        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
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

3 locks held by syz-executor4/1696:
  #0: 000000007adfc19a (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}, at:  
lock_sock include/net/sock.h:1474 [inline]
  #0: 000000007adfc19a (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}, at:  
rfcomm_sock_ioctl+0x7b/0xb0 net/bluetooth/rfcomm/sock.c:901
  #1: 00000000f97b5970 (rfcomm_ioctl_mutex){+.+.}, at: rfcomm_create_dev  
net/bluetooth/rfcomm/tty.c:485 [inline]
  #1: 00000000f97b5970 (rfcomm_ioctl_mutex){+.+.}, at:  
rfcomm_dev_ioctl+0x4a5/0x2240 net/bluetooth/rfcomm/tty.c:588
  #2: 000000001082e10b (&obj_hash[i].lock){-.-.}, at:  
__debug_check_no_obj_freed lib/debugobjects.c:774 [inline]
  #2: 000000001082e10b (&obj_hash[i].lock){-.-.}, at:  
debug_check_no_obj_freed+0x16c/0x595 lib/debugobjects.c:815

stack backtrace:
CPU: 0 PID: 1696 Comm: syz-executor4 Not tainted 4.18.0-rc7+ #170
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
  rfcomm_dlc_free+0x1e/0x30 net/bluetooth/rfcomm/core.c:328
  rfcomm_dlc_put include/net/bluetooth/rfcomm.h:258 [inline]
  __rfcomm_create_dev net/bluetooth/rfcomm/tty.c:417 [inline]
  rfcomm_create_dev net/bluetooth/rfcomm/tty.c:486 [inline]
  rfcomm_dev_ioctl+0x1dfe/0x2240 net/bluetooth/rfcomm/tty.c:588
  rfcomm_sock_ioctl+0x89/0xb0 net/bluetooth/rfcomm/sock.c:902
  sock_do_ioctl+0xe4/0x3e0 net/socket.c:969
  sock_ioctl+0x30d/0x680 net/socket.c:1093
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456a09
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f521726dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f521726e6d4 RCX: 0000000000456a09
RDX: 0000000020000140 RSI: 00000000400452c8 RDI: 0000000000000014
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cddc0 R14: 00000000004c472b R15: 0000000000000001
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
