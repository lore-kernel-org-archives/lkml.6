Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00811C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7DF2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7DF2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeJBAxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:53:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35538 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeJBAxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:53:06 -0400
Received: by mail-io1-f71.google.com with SMTP id z20-v6so14407344ioh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+VLpXMpvzJ27cUapk1Oy1YuvqdF4Gs+mnDkDW5R9OJc=;
        b=dzmb8Wee9OvRlu6aEH3kWOwqOKpEfnxr3wi/88Y2n35Wj4xK2qs7Ui3Q/Ue2f2MQeL
         m8HnRCztfSsHgpZcYDNPq6M1yTX6nlBNVUk7Ucai6uA0J51D8sn4y8gT6EfLMWHZGZhp
         IRYgVzZEglokX6x+OH37P1+mjBOrTb4/2o+R3dw2QCp6aTsZLwmDdlgDWZ19/Jt+MR9R
         +rd9uXhDB1OuVx4gz/mxS/KQA0N2wok/r/Z7FEOe6Lk8eOpYgv2L/QGDUXnxMd8kwan8
         /EeQYwg0oImDTqi58Z/Z05Z5P2KvXfWXx1EwWOzb1alYYwKr5r6Cwv1tAySt1rKZxUH3
         m9mg==
X-Gm-Message-State: ABuFfogWxoYyMXxjqhDO3R5FM4iyYfr4V+5gOZAn8JQ+uegxxpldwliH
        +r6j9SYsgUU8NJZYmHitU62B2c1uU/1w7ZwM/ym6Dh52mBHC
X-Google-Smtp-Source: ACcGV62/PwOK0Xom4K6gXsIpiAjAAvzD1d1BLs6GEe2B58AW/I2+xJ1DnT/cMU7DQ8klZ+LaO48od+lu+nCV0wvg1nqlowaXAxPF
MIME-Version: 1.0
X-Received: by 2002:a24:a048:: with SMTP id o69-v6mr11817924ite.39.1538417644600;
 Mon, 01 Oct 2018 11:14:04 -0700 (PDT)
Date:   Mon, 01 Oct 2018 11:14:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003908ec05772ec554@google.com>
Subject: INFO: task hung in ext4_fallocate
From:   syzbot <syzbot+c61979f6f2cba5cb3c06@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    291d0e5d81e1 Merge tag 'for-linus-20180929' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10332181400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8212f992609a887
dashboard link: https://syzkaller.appspot.com/bug?extid=c61979f6f2cba5cb3c06
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1611fbfa400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1489f831400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c61979f6f2cba5cb3c06@syzkaller.appspotmail.com

audit: type=1400 audit(1538313446.938:37): avc:  denied  { map } for   
pid=5541 comm="syz-executor212" path="/root/syz-executor212822736"  
dev="sda1" ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
INFO: task syz-executor212:5548 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor212 D19712  5548   5545 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  __rwsem_down_write_failed_common+0xbb9/0x1670  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa5/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:738 [inline]
  ext4_fallocate+0x921/0x2300 fs/ext4/extents.c:4957
  vfs_fallocate+0x4b4/0x940 fs/open.c:308
  ksys_fallocate+0x56/0x90 fs/open.c:331
  __do_sys_fallocate fs/open.c:339 [inline]
  __se_sys_fallocate fs/open.c:337 [inline]
  __x64_sys_fallocate+0x97/0xf0 fs/open.c:337
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ef9
Code: 67 00 00 00 00 00 00 00 00 49 6e 76 61 6c 69 64 20 22 24 4d 61 69 6e  
4d 73 67 51 75 65 75 65 44 65 71 75 65 75 65 54 69 6d 65 <45> 6e 64 22 2c  
20 65 72 72 6f 72 20 25 64 2e 20 49 67 6e 6f 72 65
RSP: 002b:00007ffd82484778 EFLAGS: 00000217 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000010001 R11: 0000000000000217 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor212:5550 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor212 D23736  5550   5543 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  __rwsem_down_write_failed_common+0xbb9/0x1670  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa5/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:738 [inline]
  process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
  ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
  do_last fs/namei.c:3422 [inline]
  path_openat+0x134d/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ef9
Code: 67 00 00 00 00 00 00 00 00 49 6e 76 61 6c 69 64 20 22 24 4d 61 69 6e  
4d 73 67 51 75 65 75 65 44 65 71 75 65 75 65 54 69 6d 65 <45> 6e 64 22 2c  
20 65 72 72 6f 72 20 25 64 2e 20 49 67 6e 6f 72 65
RSP: 002b:00007ffd82484778 EFLAGS: 00000207 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 00000000008c3880 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor212:5551 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor212 D23736  5551   5546 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  __rwsem_down_write_failed_common+0xbb9/0x1670  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa5/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:738 [inline]
  process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
  ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
  do_last fs/namei.c:3422 [inline]
  path_openat+0x134d/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ef9
Code: 67 00 00 00 00 00 00 00 00 49 6e 76 61 6c 69 64 20 22 24 4d 61 69 6e  
4d 73 67 51 75 65 75 65 44 65 71 75 65 75 65 54 69 6d 65 <45> 6e 64 22 2c  
20 65 72 72 6f 72 20 25 64 2e 20 49 67 6e 6f 72 65
RSP: 002b:00007ffd82484778 EFLAGS: 00000207 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 00000000008c3880 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor212:5552 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor212 D23888  5552   5544 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  __rwsem_down_write_failed_common+0xbb9/0x1670  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa5/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:738 [inline]
  process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
  ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
  do_last fs/namei.c:3422 [inline]
  path_openat+0x134d/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ef9
Code: 67 00 00 00 00 00 00 00 00 49 6e 76 61 6c 69 64 20 22 24 4d 61 69 6e  
4d 73 67 51 75 65 75 65 44 65 71 75 65 75 65 54 69 6d 65 <45> 6e 64 22 2c  
20 65 72 72 6f 72 20 25 64 2e 20 49 67 6e 6f 72 65
RSP: 002b:00007ffd82484778 EFLAGS: 00000207 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 00000000008c3880 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor212:5553 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor212 D23736  5553   5542 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  __rwsem_down_write_failed_common+0xbb9/0x1670  
kernel/locking/rwsem-xadd.c:566
  rwsem_down_write_failed+0xe/0x10 kernel/locking/rwsem-xadd.c:595
  call_rwsem_down_write_failed+0x17/0x30 arch/x86/lib/rwsem.S:117
  __down_write arch/x86/include/asm/rwsem.h:142 [inline]
  down_write+0xa5/0x130 kernel/locking/rwsem.c:72
  inode_lock include/linux/fs.h:738 [inline]
  process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
  ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
  do_last fs/namei.c:3422 [inline]
  path_openat+0x134d/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ef9
Code: 67 00 00 00 00 00 00 00 00 49 6e 76 61 6c 69 64 20 22 24 4d 61 69 6e  
4d 73 67 51 75 65 75 65 44 65 71 75 65 75 65 54 69 6d 65 <45> 6e 64 22 2c  
20 65 72 72 6f 72 20 25 64 2e 20 49 67 6e 6f 72 65
RSP: 002b:00007ffd82484778 EFLAGS: 00000207 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 00000000008c3880 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/983:
  #0: 000000005e364832 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4435
1 lock held by rsyslogd/5383:
  #0: 000000003ee63875 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/5505:
  #0: 0000000016366007 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000001962389b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5506:
  #0: 00000000459f06bd (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000009ba0e33f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5507:
  #0: 00000000ed059e98 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000006a8dd22c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5508:
  #0: 00000000de392f74 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000002f41f35e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5509:
  #0: 000000004b0015bd (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000fbcabc1c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5510:
  #0: 000000000749babf (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000039eaad48 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5511:
  #0: 000000009592ef13 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000080736cf9 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by syz-executor212/5548:
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: file_start_write  
include/linux/fs.h:2759 [inline]
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: vfs_fallocate+0x72a/0x940  
fs/open.c:307
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
ext4_fallocate+0x921/0x2300 fs/ext4/extents.c:4957
6 locks held by syz-executor212/5549:
2 locks held by syz-executor212/5550:
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
2 locks held by syz-executor212/5551:
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
2 locks held by syz-executor212/5552:
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
2 locks held by syz-executor212/5553:
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 00000000dd953693 (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 000000000a255960 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 983 Comm: khungtaskd Not tainted 4.19.0-rc5+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.3+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1b3/0x1ed lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb3e/0x1050 kernel/hung_task.c:265
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5549 Comm: syz-executor212 Not tainted 4.19.0-rc5+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:mext_check_coverage.constprop.13+0x20d/0x510  
fs/ext4/move_extent.c:101
Code: 86 16 fe ff ff 4c 8d 24 40 48 b8 00 00 00 00 00 fc ff df 49 c1 e4 04  
49 01 dc 49 8d 7c 24 10 48 89 fa 48 c1 ea 03 80 3c 02 00 <0f> 85 36 02 00  
00 48 b8 00 00 00 00 00 fc ff df 4d 8b 64 24 10 49
RSP: 0018:ffff8801b4af71c0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff8801bac71600 RCX: ffffffff821e4a52
RDX: 1ffff1003758e2c2 RSI: ffffffff821e493b RDI: ffff8801bac71610
RBP: ffff8801b4af7270 R08: ffff8801c3056180 R09: 1ffffffff1273955
R10: ffffed003b5e4732 R11: ffff8801daf23993 R12: ffff8801bac71600
R13: 00000000cbb0eca5 R14: ffff8801b0f34530 R15: ffff8801b4af73e0
FS:  00000000008c3880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001c59e4000 CR4: 00000000001406e0
Call Trace:
  move_extent_per_page fs/ext4/move_extent.c:323 [inline]
  ext4_move_extents+0x2784/0x3c20 fs/ext4/move_extent.c:669
  ext4_ioctl+0x3154/0x4210 fs/ext4/ioctl.c:799
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ef9
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd82484778 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 0000000020000040 RSI: 00000000c028660f RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
