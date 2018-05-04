Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeEDFGE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 01:06:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:41799 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEDFGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 01:06:02 -0400
X-Google-Smtp-Source: AB8JxZqusFsHIoD2l6pQfNZXc+wvDEnw0VXaNpfIcc30y/+eXeOek7zlApRYyKldhO7bGW09J9wDtVpVoqKryu5/+ROvqMI/IULG
MIME-Version: 1.0
Date: Thu, 03 May 2018 22:06:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c39de9056b5a46ca@google.com>
Subject: general protection fault in perf_tp_event
From: syzbot <syzbot+2f86b8550eb66cbd5808@syzkaller.appspotmail.com>
To: acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c15f6d8d4715 Merge tag 'dma-mapping-4.17-4' of git://git.i..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128d955b800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=2f86b8550eb66cbd5808
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2f86b8550eb66cbd5808@syzkaller.appspotmail.com

R13: 00000000000004a7 R14: 00000000006fb048 R15: 0000000000000002
kasan: CONFIG_KASAN_INLINE enabled
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 13905 Comm: udevd Not tainted 4.17.0-rc3+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:perf_tp_event_match kernel/events/core.c:8235 [inline]
RIP: 0010:perf_tp_event+0x427/0xc30 kernel/events/core.c:8286
RSP: 0018:ffff8801acea7380 EFLAGS: 00010002
RAX: 000006ca2060204a RBX: 0000365103010080 RCX: ffffffff81921715
RDX: 0000000000000000 RSI: ffffffff819217a9 RDI: 0000365103010250
RBP: ffff8801acea77b0 R08: ffff8801d7e4c200 R09: ffff8801dae00000
R10: ffff8801acea77e0 R11: 0000000000000000 R12: ffffed00359d4e90
R13: dffffc0000000000 R14: ffff8801acea75c0 R15: dffffc0000000000
FS:  00007fb9286417a0(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb928648000 CR3: 00000001aec72000 CR4: 00000000001406f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  perf_trace_run_bpf_submit+0x23f/0x370 kernel/events/core.c:8261
  perf_trace_sched_wakeup_template+0x4fc/0x910  
include/trace/events/sched.h:57
  trace_sched_wakeup_new include/trace/events/sched.h:103 [inline]
  wake_up_new_task+0x7ad/0xc10 kernel/sched/core.c:2447
  _do_fork+0x379/0x12a0 kernel/fork.c:2113
  __do_sys_clone kernel/fork.c:2195 [inline]
  __se_sys_clone kernel/fork.c:2189 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2189
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fb927d24f46
RSP: 002b:00007ffe709c6b80 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffe709c6b80 RCX: 00007fb927d24f46
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffe709c6be0 R08: 0000000000003651 R09: 0000000000003651
R10: 00007fb928641a70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe709c6ba0 R14: 0000000000000005 R15: 0000000000000005
Code: 48 85 db 0f 84 da 00 00 00 e8 a6 27 e7 ff 48 83 eb 60 0f 84 cb 00 00  
00 e8 97 27 e7 ff 48 8d bb d0 01 00 00 48 89 f8 48 c1 e8 03 <42> 0f b6 04  
28 84 c0 74 08 3c 03 0f 8e dc 06 00 00 44 8b bb d0
RIP: perf_tp_event_match kernel/events/core.c:8235 [inline] RSP:  
ffff8801acea7380
RIP: perf_tp_event+0x427/0xc30 kernel/events/core.c:8286 RSP:  
ffff8801acea7380

======================================================
WARNING: possible circular locking dependency detected
4.17.0-rc3+ #31 Not tainted
------------------------------------------------------
udevd/13905 is trying to acquire lock:
000000003dcbb218 ((console_sem).lock){-.-.}, at: down_trylock+0x13/0x70  
kernel/locking/semaphore.c:136

but task is already holding lock:
000000008f208626 (&rq->lock){-.-.}, at: __task_rq_lock+0xe0/0x300  
kernel/sched/core.c:77

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&rq->lock){-.-.}:
        __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
        _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:144
        rq_lock kernel/sched/sched.h:1799 [inline]
        task_fork_fair+0x8a/0x660 kernel/sched/fair.c:9967
        sched_fork+0x43e/0xb30 kernel/sched/core.c:2379
        copy_process.part.38+0x1c18/0x6e90 kernel/fork.c:1764
        copy_process kernel/fork.c:1607 [inline]
        _do_fork+0x291/0x12a0 kernel/fork.c:2088
        kernel_thread+0x34/0x40 kernel/fork.c:2147
        rest_init+0x22/0xe4 init/main.c:407
        start_kernel+0x906/0x92d init/main.c:737
        x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:445
        x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:426
        secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

-> #1 (&p->pi_lock){-.-.}:
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        try_to_wake_up+0xca/0x1190 kernel/sched/core.c:1963
        wake_up_process+0x10/0x20 kernel/sched/core.c:2126
        __up.isra.1+0x1b8/0x290 kernel/locking/semaphore.c:262
        up+0x12f/0x1b0 kernel/locking/semaphore.c:187
        __up_console_sem+0xbe/0x1b0 kernel/printk/printk.c:242
        console_unlock+0x7d6/0x1100 kernel/printk/printk.c:2417
        do_con_write+0x12b2/0x2280 drivers/tty/vt/vt.c:2437
        con_write+0x25/0xc0 drivers/tty/vt/vt.c:2786
        process_output_block drivers/tty/n_tty.c:579 [inline]
        n_tty_write+0x6b9/0x1180 drivers/tty/n_tty.c:2308
        do_tty_write drivers/tty/tty_io.c:958 [inline]
        tty_write+0x3f1/0x880 drivers/tty/tty_io.c:1042
        __vfs_write+0x10b/0x960 fs/read_write.c:485
        vfs_write+0x1f8/0x560 fs/read_write.c:549
        ksys_write+0xf9/0x250 fs/read_write.c:598
        __do_sys_write fs/read_write.c:610 [inline]
        __se_sys_write fs/read_write.c:607 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:607
        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 ((console_sem).lock){-.-.}:
        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
        _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
        down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
        __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
        console_trylock+0x15/0xa0 kernel/printk/printk.c:2229
        console_trylock_spinning kernel/printk/printk.c:1643 [inline]
        vprintk_emit+0x694/0xdd0 kernel/printk/printk.c:1906
        vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
        vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
        printk+0x9e/0xba kernel/printk/printk.c:1980
        kasan_die_handler.cold.22+0x11/0x30 arch/x86/mm/kasan_init_64.c:253
        notifier_call_chain+0x178/0x380 kernel/notifier.c:93
        __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
        atomic_notifier_call_chain+0x98/0x190 kernel/notifier.c:193
        notify_die+0x1a3/0x2b0 kernel/notifier.c:549
        do_general_protection+0x248/0x2f0 arch/x86/kernel/traps.c:558
        general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1159
        perf_tp_event_match kernel/events/core.c:8235 [inline]
        perf_tp_event+0x427/0xc30 kernel/events/core.c:8286
        perf_trace_run_bpf_submit+0x23f/0x370 kernel/events/core.c:8261
        perf_trace_sched_wakeup_template+0x4fc/0x910  
include/trace/events/sched.h:57
        trace_sched_wakeup_new include/trace/events/sched.h:103 [inline]
        wake_up_new_task+0x7ad/0xc10 kernel/sched/core.c:2447
        _do_fork+0x379/0x12a0 kernel/fork.c:2113
        __do_sys_clone kernel/fork.c:2195 [inline]
        __se_sys_clone kernel/fork.c:2189 [inline]
        __x64_sys_clone+0xbf/0x150 kernel/fork.c:2189
        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   (console_sem).lock --> &p->pi_lock --> &rq->lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&rq->lock);
                                lock(&p->pi_lock);
                                lock(&rq->lock);
   lock((console_sem).lock);

  *** DEADLOCK ***

3 locks held by udevd/13905:
  #0: 00000000e1d7c5c3 (&p->pi_lock){-.-.}, at: wake_up_new_task+0xa1/0xc10  
kernel/sched/core.c:2427
  #1: 000000008f208626 (&rq->lock){-.-.}, at: __task_rq_lock+0xe0/0x300  
kernel/sched/core.c:77
  #2: 0000000081b0555b (rcu_read_lock){....}, at:  
atomic_notifier_call_chain+0x0/0x190 include/linux/compiler.h:188

stack backtrace:
CPU: 0 PID: 13905 Comm: udevd Not tainted 4.17.0-rc3+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  print_circular_bug.isra.36.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1223
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2417 [inline]
  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  down_trylock+0x13/0x70 kernel/locking/semaphore.c:136
  __down_trylock_console_sem+0xae/0x200 kernel/printk/printk.c:225
  console_trylock+0x15/0xa0 kernel/printk/printk.c:2229
  console_trylock_spinning kernel/printk/printk.c:1643 [inline]
  vprintk_emit+0x694/0xdd0 kernel/printk/printk.c:1906
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
  printk+0x9e/0xba kernel/printk/printk.c:1980
  kasan_die_handler.cold.22+0x11/0x30 arch/x86/mm/kasan_init_64.c:253
  notifier_call_chain+0x178/0x380 kernel/notifier.c:93
  __atomic_notifier_call_chain kernel/notifier.c:183 [inline]
  atomic_notifier_call_chain+0x98/0x190 kernel/notifier.c:193
  notify_die+0x1a3/0x2b0 kernel/notifier.c:549
  do_general_protection+0x248/0x2f0 arch/x86/kernel/traps.c:558
  general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1159
RIP: 0010:perf_tp_event_match kernel/events/core.c:8235 [inline]
RIP: 0010:perf_tp_event+0x427/0xc30 kernel/events/core.c:8286
RSP: 0018:ffff8801acea7380 EFLAGS: 00010002
RAX: 000006ca2060204a RBX: 0000365103010080 RCX: ffffffff81921715
RDX: 0000000000000000 RSI: ffffffff819217a9 RDI: 0000365103010250
RBP: ffff8801acea77b0 R08: ffff8801d7e4c200 R09: ffff8801dae00000
R10: ffff8801acea77e0 R11: 0000000000000000 R12: ffffed00359d4e90
R13: dffffc0000000000 R14: ffff8801acea75c0 R15: dffffc0000000000
  perf_trace_run_bpf_submit+0x23f/0x370 kernel/events/core.c:8261
  perf_trace_sched_wakeup_template+0x4fc/0x910  
include/trace/events/sched.h:57
  trace_sched_wakeup_new include/trace/events/sched.h:103 [inline]
  wake_up_new_task+0x7ad/0xc10 kernel/sched/core.c:2447
  _do_fork+0x379/0x12a0 kernel/fork.c:2113
  __do_sys_clone kernel/fork.c:2195 [inline]
  __se_sys_clone kernel/fork.c:2189 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2189
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fb927d24f46
RSP: 002b:00007ffe709c6b80 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffe709c6b80 RCX: 00007fb927d24f46
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffe709c6be0 R08: 0000000000003651 R09: 0000000000003651
R10: 00007fb928641a70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe709c6ba0 R14: 0000000000000005 R15: 0000000000000005
---[ end trace a533ec42f4e51501 ]---
general protection fault: 0000 [#2] SMP KASAN
Dumping ftrace buffer:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
