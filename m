Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDRBCR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 21:02:17 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:39128 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeDRBCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 21:02:03 -0400
X-Google-Smtp-Source: AIpwx495myJTF6LrQ0GKfXptmWit0C7PGW+bamudiPL9d1ks6ojm4XWdN0X+0W5V2/SoAFIexe/rSKcmuzMXho1bNNv0Xdazkgze
MIME-Version: 1.0
Date: Tue, 17 Apr 2018 18:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba999f056a150015@google.com>
Subject: INFO: task hung in fsnotify_mark_destroy_workfn
From: syzbot <syzbot+e38306788a2e7102a3b6@syzkaller.appspotmail.com>
To: amir73il@gmail.com, dan.carpenter@oracle.com, dwindsor@gmail.com,
        elena.reshetova@intel.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
a27fc14219f2e3c4a46ba9177b04d9b52c875532 (Mon Apr 16 21:07:39 2018 +0000)
Merge branch 'parisc-4.17-3' of  
git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=e38306788a2e7102a3b6

syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5126465372815360
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5956756370882560
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5914490758943236750
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e38306788a2e7102a3b6@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

binder: undelivered TRANSACTION_ERROR: 29201
binder: 23363:23363 got reply transaction with no transaction stack
binder: undelivered TRANSACTION_ERROR: 29201
binder: 23363:23363 transaction failed 29201/-71, size 0-0 line 2763
binder: undelivered TRANSACTION_ERROR: 29201
INFO: task kworker/u4:4:853 blocked for more than 120 seconds.
binder: undelivered TRANSACTION_ERROR: 29201
       Not tainted 4.17.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u4:4    D11512   853      2 0x80000000
Workqueue: events_unbound fsnotify_mark_destroy_workfn
binder: undelivered TRANSACTION_ERROR: 29201
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
  schedule+0xef/0x430 kernel/sched/core.c:3549
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
  schedule_timeout+0x1b5/0x240 kernel/time/timer.c:1777
binder: undelivered TRANSACTION_ERROR: 29201
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x3e7/0x870 kernel/sched/completion.c:136
binder: undelivered TRANSACTION_ERROR: 29201
  __synchronize_srcu+0x189/0x240 kernel/rcu/srcutree.c:924
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
  synchronize_srcu+0x408/0x54f kernel/rcu/srcutree.c:1002
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
  fsnotify_mark_destroy_workfn+0x1aa/0x530 fs/notify/mark.c:759
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
binder: 23369:23369 got reply transaction with no transaction stack
binder: 23369:23369 transaction failed 29201/-71, size 0-0 line 2763
binder: 23366:23366 got reply transaction with no transaction stack
binder: 23366:23366 transaction failed 29201/-71, size 0-0 line 2763
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
binder: undelivered TRANSACTION_ERROR: 29201
binder: undelivered TRANSACTION_ERROR: 29201
binder: 23379:23379 got reply transaction with no transaction stack
binder: 23379:23379 transaction failed 29201/-71, size 0-0 line 2763
binder: undelivered TRANSACTION_ERROR: 29201
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
binder: undelivered TRANSACTION_ERROR: 29201

Showing all locks held in the system:
2 locks held by kworker/u4:4/853:
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 00000000b1269673 ((reaper_work).work){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
2 locks held by khungtaskd/890:
  #0: 00000000d567328c (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 00000000d567328c (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 00000000e997dc08 (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4495:
  #0: 0000000074daf9d2 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000004453c96f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4496:
  #0: 00000000f9c39154 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000049c9f89f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4497:
  #0: 0000000062607460 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000009e5ece05 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4498:
  #0: 000000003d5a0fd5 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000002f190677 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4499:
  #0: 00000000be6d9ce4 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000d4f768b6 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4500:
  #0: 0000000088819f44 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000e44bac98 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4501:
  #0: 00000000ab21a80f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000a3c3ecab (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
1 lock held by syz-executor2/4541:
  #0: 00000000e997dc08 (tasklist_lock){.+.+}, at:  
release_task.part.15+0x2b8/0x1b90 kernel/exit.c:197
2 locks held by kworker/u4:0/4556:
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0: 000000009bb0899e ((wq_completion)"events_unbound"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1: 000000003ac762ed (connector_reaper_work){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 890 Comm: khungtaskd Not tainted 4.17.0-rc1+ #6
binder: undelivered TRANSACTION_ERROR: 29201
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
binder: 23380:23380 got reply transaction with no transaction stack
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
binder: 23380:23380 transaction failed 29201/-71, size 0-0 line 2763
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
binder: undelivered TRANSACTION_ERROR: 29201
  kthread+0x345/0x410 kernel/kthread.c:238
binder: undelivered TRANSACTION_ERROR: 29201
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 4552 Comm: kworker/1:0 Not tainted 4.17.0-rc1+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events binder_deferred_func
RIP: 0010:__sanitizer_cov_trace_pc+0x1e/0x50 kernel/kcov.c:97
RSP: 0018:ffff8801acd5ec28 EFLAGS: 00000046
RAX: ffff8801a9d38580 RBX: ffffffff8a4995e1 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8751fd0f RDI: ffff8801acd5ed48
RBP: ffff8801acd5ec28 R08: ffff8801a9d38580 R09: fffffbfff14932bc
R10: fffffbfff14932bc R11: ffffffff8a4995e0 R12: 00000000000004ce
R13: ffff8801acd5ed88 R14: ffffffff87ab5aa5 R15: ffff8801acd5ece0
FS:  0000000000000000(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020009ff3 CR3: 00000001ad760000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  vsnprintf+0x137f/0x1b40 lib/vsprintf.c:2358
  sprintf+0xa7/0xd0 lib/vsprintf.c:2494
  print_time kernel/printk/printk.c:1223 [inline]
  print_prefix+0x26a/0x3f0 kernel/printk/printk.c:1246
  msg_print_text+0xca/0x1c0 kernel/printk/printk.c:1273
  console_unlock+0x4f5/0x1100 kernel/printk/printk.c:2369
  vprintk_emit+0x6ad/0xdd0 kernel/printk/printk.c:1907
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
  printk+0x9e/0xba kernel/printk/printk.c:1980
  binder_release_work.cold.64+0x42/0xa2 drivers/android/binder.c:4208
  binder_thread_release+0x519/0x660 drivers/android/binder.c:4396
  binder_deferred_release drivers/android/binder.c:4939 [inline]
  binder_deferred_func+0x6ce/0x1320 drivers/android/binder.c:5022
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Code: f0 4a 89 4c d8 20 4c 89 08 5d c3 66 90 55 65 48 8b 04 25 c0 ed 01 00  
65 8b 15 af bd 88 7e 48 89 e5 81 e2 00 01 1f 00 48 8b 75 08 <75> 2b 8b 90  
78 12 00 00 83 fa 02 75 20 48 8b 88 80 12 00 00 8b


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
