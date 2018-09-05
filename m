Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79089C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1890520857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1890520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIEPsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:48:50 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:51124 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIEPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:48:50 -0400
Received: by mail-it0-f72.google.com with SMTP id n194-v6so7348549itn.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 04:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kecolx3nQEkGDeNfrinQucCpnwrU6GNmdJ//pUNjHHE=;
        b=DXS+648YTbCbP9c/Ib0BHIJcfv9M6nrnZj+GfMEfEQPqOKeTrlulhpEyt7dbmyV+UZ
         kBh+q8+JRYIcEVZUKC1OoyOYrxtpIqahAbzEW97dE5VJSaptUi8v6bF6lU7/u89eLhq+
         Fqii336HqvFBBhCGF9tj7jWiT5gaQjWriX3JS7XIwFInB+i5F3lrpeAvE1bi3AtMAtz1
         iLtG5wfTitRvrJE/Qq5LiYRqTW060Xlb7AYSCQaJhJtQUQVHwnjIgd3lLqO1AGA83c6m
         6oZ88td74rRk3PdO+H2BNqzTt9y/ukus0xZLkZvf5vPqilN8TZ5O8O6npUtbqzdXwbZp
         OoBg==
X-Gm-Message-State: APzg51CMgAIdmYXCHQdaAIMKjUGmTvPihDUQQJirQ2oE6w8raD9a9QMk
        aSE5QZ9LfcZ38ewOqIWF3Q+XjcRfyLnqSlfjADhtJKutaL2g
X-Google-Smtp-Source: ANB0Vdbk1JJtNQW3EuxEJVdTxPo9ObysTVcd6KAzotpcISytYAYc0aRYUbsMROdk9O+2LMREwarJD58yeQ2k8Qhh8NswKfmBioBx
MIME-Version: 1.0
X-Received: by 2002:a02:40c9:: with SMTP id n192-v6mr14239010jaa.33.1536146343044;
 Wed, 05 Sep 2018 04:19:03 -0700 (PDT)
Date:   Wed, 05 Sep 2018 04:19:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019b8ee05751df11d@google.com>
Subject: INFO: task hung in vfat_lookup
From:   syzbot <syzbot+72000baa7858f1703b04@syzkaller.appspotmail.com>
To:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    420f51f4ab6b Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11296c92400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=72000baa7858f1703b04
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+72000baa7858f1703b04@syzkaller.appspotmail.com

INFO: task syz-executor0:4634 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc1+ #217
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D21248  4634      1 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1003 [inline]
  __mutex_lock+0xbf9/0x1700 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  vfat_lookup+0xf1/0x640 fs/fat/namei_vfat.c:709
  __lookup_slow+0x2b5/0x540 fs/namei.c:1671
  lookup_slow+0x57/0x80 fs/namei.c:1688
  walk_component+0x94a/0x2630 fs/namei.c:1810
  link_path_walk.part.40+0xa6e/0x1540 fs/namei.c:2141
  link_path_walk fs/namei.c:2072 [inline]
  path_openat+0x268/0x5340 fs/namei.c:3533
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x584/0x720 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4551a0
Code: 44 24 10 48 8b 4c 24 08 48 8b 54 24 70 48 39 d0 0f 85 69 01 00 00 48  
8b 9c 24 10 01 00 00 48 89 1c 24 48 89 54 24 08 48 89 4c <24> 10 48 89 44  
24 18 e8 74 6d 00 00 0f b6 44 24 20 84 c0 0f 84 3c
RSP: 002b:00007ffd57125ec0 EFLAGS: 00000206 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004551a0
RDX: 0000000000000000 RSI: 0000000000090800 RDI: 00000000004c1e40
RBP: 00000000000001b6 R08: 0000000000000001 R09: 0000000001523940
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
R13: 0000000000051351 R14: 000000000000003a R15: badc0ffeebadface
INFO: task syz-executor0:8851 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc1+ #217
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor0   D23808  8851   4634 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  d_wait_lookup fs/dcache.c:2428 [inline]
  d_alloc_parallel+0x1456/0x1eb0 fs/dcache.c:2510
  __lookup_slow+0x1e6/0x540 fs/namei.c:1654
  lookup_slow+0x57/0x80 fs/namei.c:1688
  walk_component+0x94a/0x2630 fs/namei.c:1810
  link_path_walk.part.40+0xa6e/0x1540 fs/namei.c:2141
  link_path_walk fs/namei.c:2072 [inline]
  path_openat+0x268/0x5340 fs/namei.c:3533
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x584/0x720 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410dd1
Code: 00 00 00 00 00 00 00 48 c7 84 24 90 00 00 00 00 00 00 00 48 8d 05 0f  
5e 04 00 48 89 44 24 78 48 8d 44 24 50 48 89 84 24 80 00 <00> 00 48 8d 84  
24 a8 00 00 00 48 89 84 24 88 00 00 00 0f b6 84 24
RSP: 002b:00007f0a65bafbb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f0a65bb06d4 RCX: 0000000000410dd1
RDX: 00007f0a65bafbe2 RSI: 0000000000000002 RDI: 00007f0a65bafbd0
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000012
R10: 0000000000000007 R11: 0000000000000293 R12: 00000000ffffffff
R13: 00000000004d72c0 R14: 00000000004ca44c R15: 0000000000000001

Showing all locks held in the system:
1 lock held by khungtaskd/792:
  #0: 00000000d6534971 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4436
1 lock held by rsyslogd/4498:
2 locks held by getty/4588:
  #0: 000000001a00424d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000064c91a05 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4589:
  #0: 0000000044cc0e87 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000031085714 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4590:
  #0: 00000000a90082dc (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000dcf02824 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4591:
  #0: 000000003298bfed (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000065469fb5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4592:
  #0: 00000000c527c2cb (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000006b71748e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4593:
  #0: 000000007d73fabd (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000e3e6d879 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4594:
  #0: 00000000c6a3fd33 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000003e69bf2b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by syz-executor0/4634:
  #0: 00000000cc4e26bc (&sb->s_type->i_mutex_key#22){++++}, at:  
inode_lock_shared include/linux/fs.h:748 [inline]
  #0: 00000000cc4e26bc (&sb->s_type->i_mutex_key#22){++++}, at:  
lookup_slow+0x49/0x80 fs/namei.c:1687
  #1: 00000000a76b47cf (&sbi->s_lock){+.+.}, at: vfat_lookup+0xf1/0x640  
fs/fat/namei_vfat.c:709
2 locks held by syz-executor0/8846:
1 lock held by syz-executor0/8851:
  #0: 00000000cc4e26bc (&sb->s_type->i_mutex_key#22){++++}, at:  
inode_lock_shared include/linux/fs.h:748 [inline]
  #0: 00000000cc4e26bc (&sb->s_type->i_mutex_key#22){++++}, at:  
lookup_slow+0x49/0x80 fs/namei.c:1687

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 792 Comm: khungtaskd Not tainted 4.19.0-rc1+ #217
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x48/0x88 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb39/0x1040 kernel/hung_task.c:265
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Sending NMI from CPU 1 to CPUs 0:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.030  
msecs
NMI backtrace for cpu 0
CPU: 0 PID: 8846 Comm: syz-executor0 Not tainted 4.19.0-rc1+ #217
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:find_get_entry+0x304/0xc90 mm/filemap.c:1424
Code: c2 3b 0d 9b 81 e8 4c 90 c4 ff 48 b8 00 00 00 00 00 fc ff df 48 03 85  
d0 fc ff ff 48 8d 78 08 48 c7 00 00 00 00 00 48 83 e7 f8 <48> c7 40 48 00  
00 00 00 48 29 f8 8d 48 50 31 c0 c1 e9 03 f3 48 ab
RSP: 0018:ffff8801824de488 EFLAGS: 00000286
RAX: ffffed003049bc9f RBX: 0000000000000001 RCX: 1ffff1003b35b50e
RDX: 1ffffffff10237b5 RSI: 0000000000000003 RDI: ffffed003049bca0
RBP: ffff8801824de7c0 R08: 1ffff1003049bc72 R09: ffffed003b6046de
R10: 0000000000000003 R11: 0000000000000002 R12: ffffea00070312c0
R13: ffff8801824de798 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f0a65bd1700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 000000018732e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  pagecache_get_page+0x11e/0xe40 mm/filemap.c:1541
  find_or_create_page include/linux/pagemap.h:322 [inline]
  grow_dev_page fs/buffer.c:948 [inline]
  grow_buffers fs/buffer.c:1017 [inline]
  __getblk_slow fs/buffer.c:1044 [inline]
  __getblk_gfp+0x3bb/0xb10 fs/buffer.c:1321
  __bread_gfp+0x2d/0x310 fs/buffer.c:1355
  sb_bread include/linux/buffer_head.h:307 [inline]
  fat__get_entry+0x59c/0xa30 fs/fat/dir.c:101
  fat_get_entry fs/fat/dir.c:129 [inline]
  fat_search_long+0x33b/0x15d0 fs/fat/dir.c:477
  vfat_find+0x16d/0x1a0 fs/fat/namei_vfat.c:697
  vfat_lookup+0x107/0x640 fs/fat/namei_vfat.c:711
  __lookup_slow+0x2b5/0x540 fs/namei.c:1671
  lookup_slow+0x57/0x80 fs/namei.c:1688
  walk_component+0x94a/0x2630 fs/namei.c:1810
  link_path_walk.part.40+0xa6e/0x1540 fs/namei.c:2141
  link_path_walk fs/namei.c:2072 [inline]
  path_openat+0x268/0x5340 fs/namei.c:3533
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x584/0x720 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410dd1
Code: 75 14 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 b4 17 00 00 c3 48  
83 ec 08 e8 8a fa ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 d3 fa ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f0a65bd0bb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f0a65bd16d4 RCX: 0000000000410dd1
RDX: 00007f0a65bd0be2 RSI: 0000000000000002 RDI: 00007f0a65bd0bd0
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000012
R10: 0000000000000007 R11: 0000000000000293 R12: 00000000ffffffff
R13: 00000000004d72c0 R14: 00000000004ca44c R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
