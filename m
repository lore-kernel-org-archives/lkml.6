Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C102086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C102086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIHUdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 16:33:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48810 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeIHUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 16:33:17 -0400
Received: by mail-io1-f72.google.com with SMTP id n26-v6so1033422iog.15
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 08:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kRnNjOCEI0ftoNRKymycB3xobHAm2bot6lQR5g1+Dwc=;
        b=AJqvDI4+OSgZYoCYzoLJtJGGwWpdCFocIqQN+4HyzEHqrJmxhW6ODYBo2QGmL2BvXm
         yVO+lILvK16il5We6sZCBn8YeN/qyDyjcwydurpFa9FqR6TdkY/vrpbNLCovHqOS9ADn
         rAsZgS0meZxzMM0+b/YNxtGBrSoi6x+1d34+xFSPDo1emSLDURNSSgIeN+2kDqr/hiRk
         MzOYxLz0ZvCoRcBQhpf9PyuuwZLygXQ9Qf8hDvsCCJq1xHBgbTfc9p2aNM+SRNKySetk
         Sj/wx7918iY810uicG8h3tpiCrWNTQM64Q1kiEYG9n36OgMur/JFKM+Gz0YgVBU5Ic+D
         /JDg==
X-Gm-Message-State: APzg51BymAm+v4MljrCCmE3JCEfmvg9weqW7AkiNZR6+JEtT5E1cWmp5
        l+WBJEX6fu49j4EzAqzLUCWAzGxyXeZ+AFK5PqwV5xubCJZ/
X-Google-Smtp-Source: ANB0VdacBig94WUrJA6qn9EBldLgN5FrHN6vZhiVHlRGGFjDyDfWvxpACncxLS0qMZf5vR+egqoIp5zJkg/1NNIEFT8pMIenQpGI
MIME-Version: 1.0
X-Received: by 2002:a02:76cd:: with SMTP id z196-v6mr11114720jab.30.1536421623344;
 Sat, 08 Sep 2018 08:47:03 -0700 (PDT)
Date:   Sat, 08 Sep 2018 08:47:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015b8fe05755e09ad@google.com>
Subject: INFO: task hung in __blkdev_get (2)
From:   syzbot <syzbot+2a732b5a87000875c1f3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b50694381cfc Merge branch 'stable/for-linus-4.17' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166708d7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
dashboard link: https://syzkaller.appspot.com/bug?extid=2a732b5a87000875c1f3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a732b5a87000875c1f3@syzkaller.appspotmail.com

binder: 17633:17652 ioctl c0306201 20007000 returned -22
INFO: task syz-executor0:17586 blocked for more than 120 seconds.
       Not tainted 4.17.0-rc6+ #66
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D22720 17586  16831 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2859 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3501
  schedule+0xef/0x430 kernel/sched/core.c:3545
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3603
  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
  __mutex_lock+0xe38/0x17f0 kernel/locking/mutex.c:893
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
  __blkdev_get+0x193/0x13a0 fs/block_dev.c:1460
  blkdev_get+0xb9/0xb30 fs/block_dev.c:1611
  blkdev_get_by_dev+0x3f/0x80 fs/block_dev.c:1733
  journal_init_dev fs/reiserfs/journal.c:2625 [inline]
  journal_init+0xcad/0x6a20 fs/reiserfs/journal.c:2772
  reiserfs_fill_super+0xd59/0x3900 fs/reiserfs/super.c:2034
  mount_bdev+0x30c/0x3e0 fs/super.c:1174
  get_super_block+0x34/0x40 fs/reiserfs/super.c:2605
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xd4/0x4d0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x564/0x3070 fs/namespace.c:2848
  ksys_mount+0x12d/0x140 fs/namespace.c:3064
  __do_sys_mount fs/namespace.c:3078 [inline]
  __se_sys_mount fs/namespace.c:3075 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45843a
RSP: 002b:00007fc481e97ba8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 000000000045843a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc481e97bf0
RBP: 0000000000000001 R08: 0000000020013900 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000019
R13: 0000000000000001 R14: 00000000006fed68 R15: 0000000000000000

Showing all locks held in the system:
2 locks held by khungtaskd/894:
  #0: 00000000555ac416 (rcu_read_lock){....}, at:  
check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
  #0: 00000000555ac416 (rcu_read_lock){....}, at: watchdog+0x1ff/0xf60  
kernel/hung_task.c:249
  #1: 00000000dd73bdbb (tasklist_lock){.+.+}, at:  
debug_show_all_locks+0xde/0x34a kernel/locking/lockdep.c:4470
1 lock held by rsyslogd/4380:
  #0: 00000000ca6266dd (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1a9/0x1e0  
fs/file.c:766
2 locks held by getty/4470:
  #0: 000000001d015e21 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000000d332adb (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4471:
  #0: 0000000048bf8be6 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000023f3c5d7 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4472:
  #0: 000000006b8ddf0c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000061b8fb1b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4473:
  #0: 000000007a3e9951 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000cc33e1ac (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4474:
  #0: 00000000d4d7bced (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000cea9fd89 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4475:
  #0: 00000000c455607f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000074a85a34 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by getty/4476:
  #0: 000000000dda4794 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000096899971 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x321/0x1cc0 drivers/tty/n_tty.c:2131
2 locks held by syz-executor0/17586:
  #0: 00000000a67274d0 (&type->s_umount_key#20/1){+.+.}, at: alloc_super  
fs/super.c:223 [inline]
  #0: 00000000a67274d0 (&type->s_umount_key#20/1){+.+.}, at:  
sget_userns+0x2dd/0xf00 fs/super.c:516
  #1: 000000005e3a2817 (&bdev->bd_mutex){+.+.}, at:  
__blkdev_get+0x193/0x13a0 fs/block_dev.c:1460
1 lock held by syz-executor0/17667:
  #0: 000000005e3a2817 (&bdev->bd_mutex){+.+.}, at:  
__blkdev_get+0x193/0x13a0 fs/block_dev.c:1460
1 lock held by blkid/17605:
  #0: 000000005e3a2817 (&bdev->bd_mutex){+.+.}, at:  
__blkdev_get+0x193/0x13a0 fs/block_dev.c:1460
3 locks held by syz-executor4/17608:
  #0: 00000000777e5516 (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x2130  
drivers/block/loop.c:1392
  #1: 000000005e3a2817 (&bdev->bd_mutex){+.+.}, at:  
blkdev_reread_part+0x1e/0x40 block/ioctl.c:192
  #2: 00000000a67274d0 (&type->s_umount_key#70){.+.+}, at:  
__get_super.part.12+0x20f/0x2e0 fs/super.c:695
1 lock held by syz-executor4/17671:
  #0: 000000005e3a2817 (&bdev->bd_mutex){+.+.}, at:  
__blkdev_get+0x193/0x13a0 fs/block_dev.c:1460

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 894 Comm: khungtaskd Not tainted 4.17.0-rc6+ #66
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_task kernel/hung_task.c:132 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
  watchdog+0xc10/0xf60 kernel/hung_task.c:249
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
