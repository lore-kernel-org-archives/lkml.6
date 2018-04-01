Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeDARIE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 13:08:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:43101 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753661AbeDARIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 13:08:02 -0400
X-Google-Smtp-Source: AIpwx482clNjbNOYnEGm8rN/x5MtcF9ysnh+yxGzP5vbW1imestRF3A+yREVn+CF0rzBC4w2Sz8TIHc7R7G7a7mOVXuFB1C2lHaN
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 10:08:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113ed5540f411c0568cc8418@google.com>
Subject: INFO: task hung in __get_super
From: syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
10b84daddbec72c6b440216a69de9a9605127f7a (Sat Mar 31 17:59:00 2018 +0000)
Merge branch 'perf-urgent-for-linus' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=10007d66ca02b08f0e60

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5899419228569600
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-2760467897697295172
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
random: crng init done
INFO: task syz-executor3:13421 blocked for more than 120 seconds.
       Not tainted 4.16.0-rc7+ #9
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor3   D24672 13421   4481 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2862 [inline]
  __schedule+0x8fb/0x1ec0 kernel/sched/core.c:3440
  schedule+0xf5/0x430 kernel/sched/core.c:3499
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x401/0x6e0 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xa4/0x150 kernel/locking/rwsem.c:26
  __get_super.part.9+0x1d3/0x280 fs/super.c:663
  __get_super include/linux/spinlock.h:310 [inline]
  get_super+0x2d/0x40 fs/super.c:692
  fsync_bdev+0x19/0x80 fs/block_dev.c:468
  invalidate_partition+0x35/0x60 block/genhd.c:1566
  drop_partitions.isra.12+0xcd/0x1d0 block/partition-generic.c:440
  rescan_partitions+0x72/0x900 block/partition-generic.c:513
  __blkdev_reread_part+0x15f/0x1e0 block/ioctl.c:173
  blkdev_reread_part+0x26/0x40 block/ioctl.c:193
  loop_reread_partitions+0x12f/0x1a0 drivers/block/loop.c:619
  loop_set_status+0x9bb/0xf60 drivers/block/loop.c:1161
  loop_set_status64+0x9d/0x110 drivers/block/loop.c:1271
  lo_ioctl+0xd86/0x1b70 drivers/block/loop.c:1381
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0x1759/0x1e00 block/ioctl.c:601
  block_ioctl+0xde/0x120 fs/block_dev.c:1875
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x454e79
RSP: 002b:00007fda691eec68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fda691ef6d4 RCX: 0000000000454e79
RDX: 00000000200001c0 RSI: 0000000000004c04 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000287 R14: 00000000006f5d48 R15: 0000000000000000

Showing all locks held in the system:
2 locks held by khungtaskd/878:
  #0:  (rcu_read_lock){....}, at: [<000000004cf2ddac>]  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0:  (rcu_read_lock){....}, at: [<000000004cf2ddac>] watchdog+0x1c5/0xd60  
kernel/hung_task.c:249
  #1:  (tasklist_lock){.+.+}, at: [<00000000fc5e2248>]  
debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
2 locks held by getty/4404:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000c5139392>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003da58a6e>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4405:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000c5139392>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003da58a6e>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4406:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000c5139392>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003da58a6e>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4407:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000c5139392>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003da58a6e>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4408:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000c5139392>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003da58a6e>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4409:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000c5139392>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003da58a6e>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
2 locks held by getty/4410:
  #0:  (&tty->ldisc_sem){++++}, at: [<00000000c5139392>]  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<000000003da58a6e>]  
n_tty_read+0x2ef/0x1a40 drivers/tty/n_tty.c:2131
3 locks held by syz-executor3/13421:
  #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<00000000834f78af>]  
lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
  #1:  (&bdev->bd_mutex){+.+.}, at: [<0000000003605603>]  
blkdev_reread_part+0x1e/0x40 block/ioctl.c:192
  #2:  (&type->s_umount_key#77){.+.+}, at: [<0000000077701649>]  
__get_super.part.9+0x1d3/0x280 fs/super.c:663
1 lock held by syz-executor3/13464:
  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000c39e77db>]  
__blkdev_get+0x176/0x13b0 fs/block_dev.c:1458
1 lock held by syz-executor3/13466:
  #0:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<00000000834f78af>]  
lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
1 lock held by syz-executor2/13423:
  #0:  (&bdev->bd_mutex){+.+.}, at: [<0000000032c86bf7>]  
blkdev_put+0x2a/0x4f0 fs/block_dev.c:1808
2 locks held by syz-executor0/13428:
  #0:  (&type->s_umount_key#76/1){+.+.}, at: [<00000000d25ba33a>]  
alloc_super fs/super.c:211 [inline]
  #0:  (&type->s_umount_key#76/1){+.+.}, at: [<00000000d25ba33a>]  
sget_userns+0x3a1/0xe40 fs/super.c:502
  #1:  (&lo->lo_ctl_mutex/1){+.+.}, at: [<00000000834f78af>]  
lo_ioctl+0x8b/0x1b70 drivers/block/loop.c:1355
1 lock held by syz-executor0/13465:
  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000c39e77db>]  
__blkdev_get+0x176/0x13b0 fs/block_dev.c:1458
1 lock held by blkid/13434:
  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000c39e77db>]  
__blkdev_get+0x176/0x13b0 fs/block_dev.c:1458
1 lock held by syz-executor2/13638:
  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000c39e77db>]  
__blkdev_get+0x176/0x13b0 fs/block_dev.c:1458
1 lock held by syz-executor2/13639:
  #0:  (&bdev->bd_mutex){+.+.}, at: [<00000000c39e77db>]  
__blkdev_get+0x176/0x13b0 fs/block_dev.c:1458

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 878 Comm: khungtaskd Not tainted 4.16.0-rc7+ #9
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
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54


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
