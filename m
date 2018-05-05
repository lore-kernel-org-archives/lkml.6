Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEEPr3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 11:47:29 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:35239 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeEEPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 11:47:03 -0400
X-Google-Smtp-Source: AB8JxZoOyAytH5ZsYjfOrzP39H/Tlt3RwyAFrmS6AmZxMDNWFIRJLfFbXKDDbJrHZPBf5WWGbhpbcIuGwcWHc2KyipRgTOreuelk
MIME-Version: 1.0
Date: Sat, 05 May 2018 08:47:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008680d056b77596f@google.com>
Subject: INFO: task hung in fsnotify_connector_destroy_workfn
From: syzbot <syzbot+4417a2fa149da3802a74@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    625e2001e99e Merge tag 'for-linus-4.17-rc4-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13886e07800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=4417a2fa149da3802a74
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=160c8e07800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4417a2fa149da3802a74@syzkaller.appspotmail.com

binder: undelivered TRANSACTION_ERROR: 29189
binder: 28815:28815 transaction failed 29189/-22, size 40-8 line 2856
binder: 28807:28807 transaction failed 29189/-22, size 40-8 line 2856
binder: 28817:28817 transaction failed 29189/-22, size 40-8 line 2856
binder: 28813:28813 transaction failed 29189/-22, size 40-8 line 2856
INFO: task kworker/u4:1:22 blocked for more than 120 seconds.
binder: 28814:28814 transaction failed 29189/-22, size 40-8 line 2856
       Not tainted 4.17.0-rc3+ #33
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u4:1    D21192    22      2 0x80000000
binder: 28819:28819 transaction failed 29189/-22, size 40-8 line 2856
Workqueue: events_unbound fsnotify_connector_destroy_workfn
Call Trace:
binder: 28820:28820 transaction failed 29189/-22, size 40-8 line 2856
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
binder: 28821:28821 transaction failed 29189/-22, size 40-8 line 2856
  schedule+0xef/0x430 kernel/sched/core.c:3549
binder: 28822:28822 transaction failed 29189/-22, size 40-8 line 2856
  schedule_timeout+0x1b5/0x240 kernel/time/timer.c:1777
binder: 28823:28823 transaction failed 29189/-22, size 40-8 line 2856
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x3e7/0x870 kernel/sched/completion.c:136
binder: 28824:28824 transaction failed 29189/-22, size 40-8 line 2856
  __synchronize_srcu+0x189/0x240 kernel/rcu/srcutree.c:924
  synchronize_srcu_expedited kernel/rcu/srcutree.c:949 [inline]
  synchronize_srcu+0x32d/0x54f kernel/rcu/srcutree.c:1000
  fsnotify_connector_destroy_workfn+0x44/0xa0 fs/notify/mark.c:156
  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
binder: 28831:28831 transaction failed 29189/-22, size 40-8 line 2856
binder: 28826:28826 transaction failed 29189/-22, size 40-8 line 2856
binder: 28827:28827 transaction failed 29189/-22, size 40-8 line 2856
  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
binder: 28830:28830 transaction failed 29189/-22, size 40-8 line 2856
binder: 28836:28836 transaction failed 29189/-22, size 40-8 line 2856
binder: 28829:28829 transaction failed 29189/-22, size 40-8 line 2856
binder: 28839:28839 transaction failed 29189/-22, size 40-8 line 2856
binder: 28840:28840 transaction failed 29189/-22, size 40-8 line 2856
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412

Showing all locks held in the system:
2 locks held by kworker/u4:1/22:
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1:         (ptrval) (connector_reaper_work){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120
2 locks held by khungtaskd/892:
  #0:         (ptrval) (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0:         (ptrval) (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1:         (ptrval) (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
2 locks held by getty/4471:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4472:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4473:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4474:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4475:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4476:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4477:
  #0:         (ptrval) (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:         (ptrval) (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by kworker/u4:2/4527:
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
__write_once_size include/linux/compiler.h:215 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
atomic64_set include/asm-generic/atomic-instrumented.h:40 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:57 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_data kernel/workqueue.c:617 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
  #0:         (ptrval) ((wq_completion)"events_unbound"){+.+.}, at:  
process_one_work+0xaef/0x1b50 kernel/workqueue.c:2116
  #1:         (ptrval) ((reaper_work).work){+.+.}, at:  
process_one_work+0xb46/0x1b50 kernel/workqueue.c:2120

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 892 Comm: khungtaskd Not tainted 4.17.0-rc3+ #33
binder: 28842:28842 transaction failed 29189/-22, size 40-8 line 2856
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
binder: 28844:28844 transaction failed 29189/-22, size 40-8 line 2856
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
binder: 28845:28845 transaction failed 29189/-22, size 40-8 line 2856
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
binder: 28846:28846 transaction failed 29189/-22, size 40-8 line 2856
binder: 28848:28848 transaction failed 29189/-22, size 40-8 line 2856
binder: 28847:28847 transaction failed 29189/-22, size 40-8 line 2856
  kthread+0x345/0x410 kernel/kthread.c:238
binder: 28849:28849 transaction failed 29189/-22, size 40-8 line 2856
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 1 to CPUs 0:
binder: 28850:28850 transaction failed 29189/-22, size 40-8 line 2856
NMI backtrace for cpu 0
CPU: 0 PID: 28850 Comm: syz-executor2 Not tainted 4.17.0-rc3+ #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ttwu_queue kernel/sched/core.c:1827 [inline]
RIP: 0010:try_to_wake_up+0x811/0x1190 kernel/sched/core.c:2053
RSP: 0018:ffff8801dae07938 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff8801dae07af8 RCX: 0000000000000003
RDX: 0000000000000000 RSI: 000000000002c680 RDI: 0000000000000000
RBP: ffff8801dae07b20 R08: ffff8801dae00000 R09: dffffc0000000000
R10: 1ffffffff115b574 R11: ffffffff88adaba0 R12: 0000000000000000
R13: ffff8801d91c6080 R14: ffff8801dae2c680 R15: ffff8801dae07ab8
FS:  0000000001ee4940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000204edf8a CR3: 00000001c7b2d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  wake_up_process+0x10/0x20 kernel/sched/core.c:2126
  hrtimer_wakeup+0x48/0x60 kernel/time/hrtimer.c:1647
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:1678 [inline]
RIP: 0010:vprintk_emit+0xbd0/0xdd0 kernel/printk/printk.c:1906
RSP: 0018:ffff8801a85ee8a0 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801aa6865c0 RBX: 0000000000000200 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8160be97 RDI: 0000000000000293
RBP: ffff8801a85eea30 R08: ffff8801aa6865c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffffffff11a316d
R13: 0000000000000045 R14: ffffed00350bdd31 R15: ffffffff8a6d3360
  vprintk_default+0x28/0x30 kernel/printk/printk.c:1947
  vprintk_func+0x7a/0xe7 kernel/printk/printk_safe.c:379
  printk+0x9e/0xba kernel/printk/printk.c:1980
  binder_transaction.cold.75+0xcaf/0x1b11 drivers/android/binder.c:3264
  binder_thread_write+0x858/0x2c30 drivers/android/binder.c:3532
  binder_ioctl_write_read.isra.41+0x2be/0xaf0 drivers/android/binder.c:4459
  binder_ioctl+0xcbe/0x13fd drivers/android/binder.c:4599
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007fff1dfd7e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000001ee4914 RCX: 0000000000455979
RDX: 0000000020008000 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000019c R14: 00000000006f6740 R15: 00000000000f0a3a
Code: 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 29 08 00 00 4d 8b 3e 4d  
85 ff 75 b8 65 ff 0d 68 0f af 7e e9 45 f9 ff ff 4e 8d 34 06 <4c> 89 f7 e8  
b7 fb 1b 06 49 8d 7f 08 4d 8d 4e 18 48 b8 00 00 00


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

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
