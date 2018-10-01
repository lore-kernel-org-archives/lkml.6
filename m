Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05612083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05612083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeJAOee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:34:34 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44575 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbeJAOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:34:33 -0400
Received: by mail-io1-f71.google.com with SMTP id s15-v6so12452907iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 00:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=S+39f2zPFei2f+M8NENO7GxEd17tRnvpa109rr32d1c=;
        b=gXWf9kCA9iu9sEJlkCr5OdsaAQTJL5JplWmo/VQmahcgbufpPAYuu7NYxL5ZozevSU
         uT0/jWtfJNJVljsTNdmfhOVrWU8dGPrXHmldDF6868QPyRvbPpgtARrbhp4RQRFzw8D4
         lXdh1vs058A5wOTSY2qC6+R3Z+//cmkTLe0FOSIIfjHrZsZfti33grx3xz+M0Dj8N49e
         miqbzJaW45vZ7Fm0ZkJIiMAoIoi/usuFezK9aN8n5l3nQfpaJ5KUd6uNL8FB95laxCP9
         1b5FeJi4kvzVKh1PKmgFpitj5pZjJ84FCskq+Canz+fCdCdXby2qA40uILt+yL38Y8oY
         KSJA==
X-Gm-Message-State: ABuFfoj/GWeaYu+i4I5DiDRRSVDNGmcJ0oAaSuf5odmeIoUSWuK6xqvC
        HJ9+sdGPXpqgS08gGx61jKzwtnIxsxPZm03AqdQcFLMHxygh
X-Google-Smtp-Source: ACcGV626IubA4NUhoBKRX1akQqsPK2TjWEzp2JkIGr7DulHbZQDlC+ATB1ilm7ifCQ4rqLRiI/iR4M8aJyFUD2vrnQvquAhu2pzQ
MIME-Version: 1.0
X-Received: by 2002:a6b:9057:: with SMTP id s84-v6mr7143026iod.27.1538380684058;
 Mon, 01 Oct 2018 00:58:04 -0700 (PDT)
Date:   Mon, 01 Oct 2018 00:58:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033ebee0577262a98@google.com>
Subject: INFO: task hung in process_measurement
From:   syzbot <syzbot+cdc562bc26a2b2b0a94f@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    291d0e5d81e1 Merge tag 'for-linus-20180929' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15232dc6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8212f992609a887
dashboard link: https://syzkaller.appspot.com/bug?extid=cdc562bc26a2b2b0a94f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e285e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1237fe81400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cdc562bc26a2b2b0a94f@syzkaller.appspotmail.com

audit: type=1400 audit(1538324226.449:37): avc:  denied  { map } for   
pid=5529 comm="sh" path="/bin/dash" dev="sda1" ino=1473  
scontext=system_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
INFO: task syz-executor101:5522 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor101 D23752  5522   5521 0x00000004
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
  process_measurement+0xc3e/0x1bf0 security/integrity/ima/ima_main.c:205
  ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
  do_last fs/namei.c:3422 [inline]
  path_openat+0x134d/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  ksys_open include/linux/syscalls.h:1276 [inline]
  __do_sys_creat fs/open.c:1121 [inline]
  __se_sys_creat fs/open.c:1119 [inline]
  __x64_sys_creat+0x61/0x80 fs/open.c:1119
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ef9
Code: 67 00 00 00 00 00 00 00 00 49 6e 76 61 6c 69 64 20 22 24 4d 61 69 6e  
4d 73 67 51 75 65 75 65 44 65 71 75 65 75 65 54 69 6d 65 <45> 6e 64 22 2c  
20 65 72 72 6f 72 20 25 64 2e 20 49 67 6e 6f 72 65
RSP: 002b:00007ffe712a3838 EFLAGS: 00000213 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 0000000000440ef9 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000001e42880 R11: 0000000000000213 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor101:5524 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor101 D23736  5524   5517 0x00000004
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
RSP: 002b:00007ffe712a3838 EFLAGS: 00000207 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000000001e42880 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor101:5525 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor101 D22824  5525   5520 0x00000004
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
RSP: 002b:00007ffe712a3838 EFLAGS: 00000207 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000000001e42880 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor101:5526 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor101 D24024  5526   5518 0x00000004
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
RSP: 002b:00007ffe712a3838 EFLAGS: 00000207 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000000001e42880 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor101:5527 blocked for more than 140 seconds.
       Not tainted 4.19.0-rc5+ #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor101 D22664  5527   5516 0x00000004
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
RSP: 002b:00007ffe712a3838 EFLAGS: 00000207 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440ef9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 0000000000000000 R08: 0000000001e42880 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000207 R12: 0000000000401d90
R13: 0000000000401e20 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/982:
  #0: 000000001116c4dd (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x424 kernel/locking/lockdep.c:4435
3 locks held by rs:main Q:Reg/5361:
  #0: 0000000044c0c517 (&rq->lock){-.-.}, at: rq_lock  
kernel/sched/sched.h:1821 [inline]
  #0: 0000000044c0c517 (&rq->lock){-.-.}, at: __schedule+0x236/0x1ed0  
kernel/sched/core.c:3411
  #1: 000000000bec9fcc (sb_writers#4){.+.+}, at: file_start_write  
include/linux/fs.h:2759 [inline]
  #1: 000000000bec9fcc (sb_writers#4){.+.+}, at: vfs_write+0x42a/0x560  
fs/read_write.c:548
  #2: 000000004be84093 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_trylock  
include/linux/fs.h:758 [inline]
  #2: 000000004be84093 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
ext4_file_write_iter+0x2a1/0x1420 fs/ext4/file.c:232
1 lock held by rsyslogd/5364:
  #0: 00000000a8830431 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200  
fs/file.c:766
2 locks held by getty/5485:
  #0: 00000000de1e6136 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000600ee548 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5486:
  #0: 00000000b3285b25 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000001c3ae4b7 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5487:
  #0: 000000004c7225f2 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000da2e4cc7 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5488:
  #0: 00000000297a93f9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000066f4404f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5489:
  #0: 00000000dd58e666 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000e2fa745f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5490:
  #0: 00000000a6cae2fb (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000048d03f73 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/5491:
  #0: 00000000093a54ec (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x32/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000dc6b27f8 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by syz-executor101/5522:
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 000000008a4b9094 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 000000008a4b9094 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0xc3e/0x1bf0 security/integrity/ima/ima_main.c:205
6 locks held by syz-executor101/5523:
2 locks held by syz-executor101/5524:
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 00000000eae730c5 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 00000000eae730c5 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
2 locks held by syz-executor101/5525:
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 00000000eae730c5 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 00000000eae730c5 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
2 locks held by syz-executor101/5526:
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 00000000eae730c5 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 00000000eae730c5 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205
2 locks held by syz-executor101/5527:
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: sb_start_write  
include/linux/fs.h:1566 [inline]
  #0: 000000000bec9fcc (sb_writers#4){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360
  #1: 00000000eae730c5 (&sb->s_type->i_mutex_key#9){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
  #1: 00000000eae730c5 (&sb->s_type->i_mutex_key#9){+.+.}, at:  
process_measurement+0x190f/0x1bf0 security/integrity/ima/ima_main.c:205

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 982 Comm: khungtaskd Not tainted 4.19.0-rc5+ #40
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
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.217  
msecs
NMI backtrace for cpu 1
CPU: 1 PID: 5523 Comm: syz-executor101 Not tainted 4.19.0-rc5+ #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__sanitizer_cov_trace_pc+0x1/0x50 kernel/kcov.c:94
Code: dd 28 00 00 00 4d 39 d0 72 1b 49 83 c1 01 4a 89 7c 10 e0 4a 89 74 10  
e8 4a 89 54 10 f0 4a 89 4c d8 20 4c 89 08 5d c3 66 90 55 <48> 89 e5 65 48  
8b 04 25 40 ee 01 00 65 8b 15 3c 38 83 7e 81 e2 00
RSP: 0018:ffff8801bd427108 EFLAGS: 00000282
RAX: 0000000000000000 RBX: ffff8801bab4f8a8 RCX: ffffffff82110c43
RDX: 1ffff10037569f11 RSI: ffffffff821103d3 RDI: ffff8801bab4f888
RBP: ffff8801bd427140 R08: ffff8801c4472340 R09: 1ffffffff1273955
R10: ffffed003b5e4732 R11: ffff8801daf23993 R12: 0000000000000000
R13: 0000000093734bb2 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000001e42880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001cc615000 CR4: 00000000001406e0
Call Trace:
  ext4_find_extent+0xdc/0x9b0 fs/ext4/extents.c:880
  get_ext_path fs/ext4/move_extent.c:31 [inline]
  mext_check_coverage.constprop.13+0x2b0/0x510 fs/ext4/move_extent.c:98
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
RSP: 002b:00007ffe712a3838 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
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
