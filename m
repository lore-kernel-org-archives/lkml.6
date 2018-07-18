Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951512075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951512075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbeGRLPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:15:19 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:44540 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbeGRLPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:15:18 -0400
Received: by mail-io0-f199.google.com with SMTP id e8-v6so3050508ioq.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=piLTCnuimHFu6uYUHBO+qc+/k5Bwq2pOCKwrejMWpZI=;
        b=tsvHkvQmCJ/YCpIMTc207nn4f9aufpl7cnma+JvrVQ8HYMY1whINflppgEVY+rVXI6
         D8bbgIdRltGA/iKysrvfVYm2+78yHF24ouvho1cPa0UM9ea4MYrT6XEDZx4pdqSBfHmN
         48E4p3CCdMvvLiCnT3Lz05wbeGuDzqX0Fq6c5tSSqnkFRXmYGbSjjtgZxr9a4kFxtS0W
         qTIydRxm4nM4Eem/J0k+jcD0oofuPWTuTNgf+lcxKmlSN3Twe8OAaXtL/TB3hTvVgTUL
         k/xWRGICVV0WUX/IDSF9YkGfLklozEBKGc0HbI1HSf0yzonoy5XBECXY27d5YHU72jfN
         RPHg==
X-Gm-Message-State: AOUpUlHoDsaOD6C7GJmBiQS11PdaHhTWsXjOgkQrm/37pXXpiVfIWkpM
        POngEBykgSh/xm7lf4Z1gU81bWivD/vOOsO1UeC/BYZMOGzm
X-Google-Smtp-Source: AAOMgpdzDif+OKoDR22prNx6jqKpWfxdoyCwgCiT8W0sBKZbH0+gawjIuZ853njMyj3P2RsWN6RT7sx3XhbaRq6m1gS5XrPimvpG
MIME-Version: 1.0
X-Received: by 2002:a24:56ce:: with SMTP id o197-v6mr716550itb.32.1531910281971;
 Wed, 18 Jul 2018 03:38:01 -0700 (PDT)
Date:   Wed, 18 Jul 2018 03:38:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f5541057143a85e@google.com>
Subject: INFO: task hung in grab_super
From:   syzbot <syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3c53776e29f8 Mark HI and TASKLET softirq synchronous
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136af978400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0ccc9273f0e539
dashboard link: https://syzkaller.appspot.com/bug?extid=f425456ea8aa16b40d20
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com

INFO: task syz-executor1:20048 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc5+ #152
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D24600 20048   4592 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_write_failed_common+0x95d/0x1630  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xaa/0x130 kernel/locking/rwsem.c:72
  grab_super+0xac/0x2a0 fs/super.c:380
  sget_userns+0x457/0xf20 fs/super.c:508
  sget+0x10b/0x150 fs/super.c:567
  mount_bdev+0x111/0x3e0 fs/super.c:1147
  ext4_mount+0x34/0x40 fs/ext4/super.c:5844
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
RIP: 0033:0x455ab9
Code: e0 1f 48 89 04 24 e8 b6 6f fd ff e8 81 6a fd ff e8 5c 68 fd ff 48 8d  
05 23 cd 48 00 48 89 04 24 48 c7 44 24 08 1d 00 00 00 e8 <13> 5e fd ff 0f  
0b e8 8c 44 00 00 e9 07 f0 ff ff cc cc cc cc cc cc
RSP: 002b:00007f243a3f3c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f243a3f46d4 RCX: 0000000000455ab9
RDX: 0000000020000140 RSI: 0000000020000000 RDI: 0000000020000040
RBP: 000000000072bf48 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c01fb R14: 00000000004cfe38 R15: 0000000000000001

Showing all locks held in the system:
1 lock held by khungtaskd/902:
  #0: 0000000035584d3c (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4461
1 lock held by rsyslogd/4451:
2 locks held by getty/4541:
  #0: 000000006f0b7018 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000bae5c9d0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4542:
  #0: 00000000e9d8517f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000150ebe8a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4543:
  #0: 0000000040e50d21 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000069970342 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4544:
  #0: 00000000955281b7 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000004616d311 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4545:
  #0: 000000003faa1dd4 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000000dfddacf (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4546:
  #0: 00000000c5cc544f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000caf6720f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4547:
  #0: 00000000c10d3596 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000e2223f78 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
1 lock held by syz-executor1/19991:
2 locks held by syz-executor1/20048:
  #0: 00000000ca0a2d7d (&bdev->bd_fsfreeze_mutex){+.+.}, at:  
mount_bdev+0xa5/0x3e0 fs/super.c:1141
  #1: 00000000af861ef0 (&type->s_umount_key#69){+.+.}, at:  
grab_super+0xac/0x2a0 fs/super.c:380

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 902 Comm: khungtaskd Not tainted 4.18.0-rc5+ #152
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:196 [inline]
  watchdog+0x9c4/0xf80 kernel/hung_task.c:252
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 19991 Comm: syz-executor1 Not tainted 4.18.0-rc5+ #152
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_is_held+0x76/0x140 kernel/locking/lockdep.c:3741
Code: 00 00 4c 8b 6d c8 4d 8d b4 24 38 08 00 00 45 31 ff 48 b8 00 00 00 00  
00 fc ff df 49 c1 ed 03 49 01 c5 41 8b 84 24 30 08 00 00 <85> c0 7f 24 e9  
85 00 00 00 41 0f b6 45 00 41 83 c7 01 84 c0 74 08
RSP: 0018:ffff88018ea3eed8 EFLAGS: 00000086
RAX: 0000000000000001 RBX: 0000000000000286 RCX: ffffc9000443f000
RDX: 1ffff10031c245de RSI: 00000000ffffffff RDI: ffffffff88f925e0
RBP: ffff88018ea3ef18 R08: ffff88018e1226c0 R09: ffffed003b5e46d6
R10: 0000000000000003 R11: 0000000000000001 R12: ffff88018e1226c0
R13: ffffed0031c245de R14: ffff88018e122ef8 R15: 0000000000000000
FS:  00007f243a415700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001d8749000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_is_held_type+0x121/0x210 kernel/locking/lockdep.c:3962
  lock_is_held include/linux/lockdep.h:344 [inline]
  ___might_sleep+0x295/0x330 kernel/sched/core.c:6152
  __might_sleep+0x95/0x190 kernel/sched/core.c:6140
  lock_page include/linux/pagemap.h:481 [inline]
  pagecache_get_page+0x787/0xe40 mm/filemap.c:1554
  find_or_create_page include/linux/pagemap.h:322 [inline]
  grow_dev_page fs/buffer.c:940 [inline]
  grow_buffers fs/buffer.c:1009 [inline]
  __getblk_slow fs/buffer.c:1036 [inline]
  __getblk_gfp+0x3bb/0xb10 fs/buffer.c:1313
  __bread_gfp+0x2d/0x310 fs/buffer.c:1347
  sb_bread_unmovable include/linux/buffer_head.h:313 [inline]
  ext4_fill_super+0x6de/0xda80 fs/ext4/super.c:3541
  mount_bdev+0x30c/0x3e0 fs/super.c:1174
  ext4_mount+0x34/0x40 fs/ext4/super.c:5844
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
RIP: 0033:0x455ab9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f243a414c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f243a4156d4 RCX: 0000000000455ab9
RDX: 0000000020000140 RSI: 0000000020000000 RDI: 0000000020000040
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c01fb R14: 00000000004cfe38 R15: 0000000000000000
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.163  
msecs


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
