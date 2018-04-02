Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeDBJUW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:20:22 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:55392 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754169AbeDBJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:20:02 -0400
X-Google-Smtp-Source: AIpwx4/GTfxMyHXvsrKlrc8hufN2Q87hAgjg8qTfso9knTyt5cYgBQ/u5Nn0V+99YaRvyTpl+rQvBy7QIVz6uh3Te5TsKSxCNcbB
MIME-Version: 1.0
Date: Mon, 02 Apr 2018 02:20:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b5a780568da18cf@google.com>
Subject: INFO: task hung in perf_trace_event_unreg
From: syzbot <syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w329KkqU009091

Hello,

syzbot hit the following crash on upstream commit
0adb32858b0bddf4ada5f364a84ed60b196dbcda (Sun Apr 1 21:20:27 2018 +0000)
Linux 4.16
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=2dbc55da20fa246378fd

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5487937873510400
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2374466361298166459
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2dbc55da20fa246378fd@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

REISERFS warning (device loop4): super-6502 reiserfs_getopt: unknown mount  
option "g�;e�K�׫>pquota"
INFO: task syz-executor3:10803 blocked for more than 120 seconds.
       Not tainted 4.16.0+ #10
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor3   D20944 10803   4492 0x80000002
Call Trace:
  context_switch kernel/sched/core.c:2862 [inline]
  __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
  schedule+0xf5/0x430 kernel/sched/core.c:3499
  schedule_timeout+0x1a3/0x230 kernel/time/timer.c:1777
  do_wait_for_common kernel/sched/completion.c:86 [inline]
  __wait_for_common kernel/sched/completion.c:107 [inline]
  wait_for_common kernel/sched/completion.c:118 [inline]
  wait_for_completion+0x415/0x770 kernel/sched/completion.c:139
  __wait_rcu_gp+0x221/0x340 kernel/rcu/update.c:414
  synchronize_sched.part.64+0xac/0x100 kernel/rcu/tree.c:3212
  synchronize_sched+0x76/0xf0 kernel/rcu/tree.c:3213
  tracepoint_synchronize_unregister include/linux/tracepoint.h:80 [inline]
  perf_trace_event_unreg.isra.2+0xb7/0x1f0  
kernel/trace/trace_event_perf.c:161
  perf_trace_destroy+0xbc/0x100 kernel/trace/trace_event_perf.c:236
  tp_perf_event_destroy+0x15/0x20 kernel/events/core.c:7976
  _free_event+0x3bd/0x10f0 kernel/events/core.c:4121
  put_event+0x24/0x30 kernel/events/core.c:4204
  perf_event_release_kernel+0x6e8/0xfc0 kernel/events/core.c:4310
  perf_release+0x37/0x50 kernel/events/core.c:4320
  __fput+0x327/0x7e0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x199/0x270 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x9bb/0x1ad0 kernel/exit.c:865
  do_group_exit+0x149/0x400 kernel/exit.c:968
  get_signal+0x73a/0x16d0 kernel/signal.c:2469
  do_signal+0x90/0x1e90 arch/x86/kernel/signal.c:809
  exit_to_usermode_loop+0x258/0x2f0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ec/0x940 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x455269
RSP: 002b:00007f8976371ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000000 RBX: 000000000072bec8 RCX: 0000000000455269
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bec8
RBP: 000000000072bec8 R08: 0000000000000000 R09: 000000000072bea0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe793f79cf R14: 00007f89763729c0 R15: 0000000000000000

Showing all locks held in the system:
2 locks held by khungtaskd/876:
  #0:  (rcu_read_lock){....}, at: [<000000008f2bec4b>]  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0:  (rcu_read_lock){....}, at: [<000000008f2bec4b>] watchdog+0x1c5/0xd60  
kernel/hung_task.c:249
  #1:  (tasklist_lock){.+.+}, at: [<0000000006b3009f>]  
debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
2 locks held by getty/4414:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4415:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4416:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4417:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4418:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4419:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4420:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000e51437c8>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<00000000762a7320>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
1 lock held by syz-executor3/10803:
  #0:  (event_mutex){+.+.}, at: [<00000000c507b78a>]  
perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:234
4 locks held by syz-executor5/10816:
  #0:  (&tty->legacy_mutex){+.+.}, at: [<00000000567b7b94>]  
tty_lock+0x5d/0x90 drivers/tty/tty_mutex.c:19
  #1:  (&tty->legacy_mutex/1){+.+.}, at: [<00000000567b7b94>]  
tty_lock+0x5d/0x90 drivers/tty/tty_mutex.c:19
  #2:  (&tty->ldisc_sem){++++}, at: [<000000002b6b6a29>]  
tty_ldisc_ref+0x1b/0x80 drivers/tty/tty_ldisc.c:298
  #3:  (&o_tty->termios_rwsem/1){++++}, at: [<0000000007d9a7a4>]  
n_tty_flush_buffer+0x21/0x320 drivers/tty/n_tty.c:357
1 lock held by syz-executor2/10827:
  #0:  (event_mutex){+.+.}, at: [<00000000c507b78a>]  
perf_trace_destroy+0x28/0x100 kernel/trace/trace_event_perf.c:234
1 lock held by blkid/10832:
  #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<000000006e2f031e>]  
lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
1 lock held by syz-executor4/10835:
  #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<000000006e2f031e>]  
lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
1 lock held by syz-executor4/10845:
  #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<000000006e2f031e>]  
lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 876 Comm: khungtaskd Not tainted 4.16.0+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x123/0x180 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0x90c/0xd60 kernel/hung_task.c:249
INFO: rcu_sched self-detected stall on CPU
	0-....: (124996 ticks this GP) idle=75e/1/4611686018427387906  
softirq=33205/33205 fqs=30980
	
  (t=125000 jiffies g=17618 c=17617 q=921)
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 7457 Comm: kworker/u4:5 Not tainted 4.16.0+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:__process_echoes+0x641/0x770 drivers/tty/n_tty.c:733
RSP: 0018:ffff8801af4ff078 EFLAGS: 00000217
RAX: 0000000000000000 RBX: ffffc90003673000 RCX: ffffffff8352d4c2
RDX: 0000000000000006 RSI: 1ffff10039602994 RDI: ffffc9000367515e
RBP: ffff8801af4ff0e0 R08: 1ffff10035e9fdb5 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000625628efd
R13: dffffc0000000000 R14: 0000000000000efe R15: 0000000000001b15
FS:  0000000000000000(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd5bfa4ca8 CR3: 000000000846a005 CR4: 00000000001606f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  commit_echoes+0x147/0x1b0 drivers/tty/n_tty.c:764
  n_tty_receive_char_fast drivers/tty/n_tty.c:1416 [inline]
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1576 [inline]
  __receive_buf drivers/tty/n_tty.c:1611 [inline]
  n_tty_receive_buf_common+0x1156/0x2520 drivers/tty/n_tty.c:1709
  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
  tty_ldisc_receive_buf+0xa7/0x180 drivers/tty/tty_buffer.c:456
  tty_port_default_receive_buf+0x106/0x160 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:475 [inline]
  flush_to_ldisc+0x3c4/0x590 drivers/tty/tty_buffer.c:524
  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
Code: 60 12 00 00 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 42 0f b6 04 28 38  
d0 7f 08 84 c0 0f 85 21 01 00 00 42 80 bc 33 60 12 00 00 82 <74> 0f e8 48  
90 1e fe 4d 8d 74 24 02 e9 58 ff ff ff e8 39 90 1e


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

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
