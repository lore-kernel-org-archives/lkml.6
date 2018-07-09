Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C72C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15F220840
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15F220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933705AbeGIRHF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:07:05 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:39192 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933495AbeGIRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:07:02 -0400
Received: by mail-io0-f200.google.com with SMTP id x14-v6so16798022ioa.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n3pkiplEhnCEqQYLZmvPd1xZf6hM9YN/70vQEOyd1ec=;
        b=aSWZHWZWoQCxbaUs1ohW5POJHdjhpLwLPZUI/r5co8MHhLhIcbPu0sgkDQlqP2y0OS
         Wg9zxrxk01mEcqk2qocIhixqskb7BZsHJ8NkH2PO06/o8kOnltV80yumSy2xHJO5GtzR
         pniVr5dqxG6wCFRdSz28tboxihYGa/i16U1pGLfOUAIw2SV1uGk4U7yQ5diHHnvf6SBN
         Pn+0GZBPVgLxeVxXE/IvjMV2SXYXxb02oL1RxObHXlQAnVqQrkzDKW/4iwuqkOcdh8o2
         STsTcTPQQwKyQ2/7tgy+UtFu9lD2UKCixgCdLfkOMKSYlWazbg00y/ZSyvy5L0r4Rlwu
         IPoA==
X-Gm-Message-State: APt69E2dkRtA58fcgsqWdB8Qks0P/7Tf+AcdvRr7JVNscY8IB/2Yro6M
        5/i/Q+MaDIFUvMDQeviGuAjU42gPS9z4GovjCwSsgAv5TuvG
X-Google-Smtp-Source: AAOMgpdqkFadjhX+qK8wD1hIpK8hy3IqAVLTjHqNCUxQDmMUKZPmIwLZOMe5XwSo047b1Vn3HAMB0dSbWHMpbmTrotWT/cGI37sK
MIME-Version: 1.0
X-Received: by 2002:a02:b705:: with SMTP id g5-v6mr9703198jam.10.1531156022344;
 Mon, 09 Jul 2018 10:07:02 -0700 (PDT)
Date:   Mon, 09 Jul 2018 10:07:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cec1940570940acf@google.com>
Subject: INFO: task hung in vfs_removexattr
From:   syzbot <syzbot+9d0373cdac2be4979750@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e4b044d2251 Linux 4.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dc81b2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=9d0373cdac2be4979750
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d0373cdac2be4979750@syzkaller.appspotmail.com

netlink: 16 bytes leftover after parsing attributes in process  
`syz-executor0'.
netlink: 16 bytes leftover after parsing attributes in process  
`syz-executor0'.
INFO: task syz-executor5:14548 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc4+ #138
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor5   D24752 14548   4547 0x00000004
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
  inode_lock include/linux/fs.h:715 [inline]
  vfs_removexattr+0x82/0x1c0 fs/xattr.c:391
  removexattr+0xd3/0x130 fs/xattr.c:691
  path_removexattr+0x1b9/0x210 fs/xattr.c:705
  __do_sys_removexattr fs/xattr.c:719 [inline]
  __se_sys_removexattr fs/xattr.c:716 [inline]
  __x64_sys_removexattr+0x59/0x80 fs/xattr.c:716
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455e29
Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 ab 04 00 00 48 83 ec  
58 48 89 6c 24 50 48 8d 6c 24 50 48 8b 44 24 60 c6 00 00 <48> 8b 4c 24 68  
48 89 ca 48 89 50 08 48 8b 59 20 48 01 da 31 db 31
RSP: 002b:00007f4465180c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000c5
RAX: ffffffffffffffda RBX: 00007f44651816d4 RCX: 0000000000455e29
RDX: 0000000000000000 RSI: 0000000020000400 RDI: 0000000020000380
RBP: 000000000072bf48 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004bbfeb R14: 00000000004d1108 R15: 0000000000000001

Showing all locks held in the system:
1 lock held by khungtaskd/901:
  #0: 00000000ebf24c36 (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4461
1 lock held by rsyslogd/4405:
2 locks held by getty/4495:
  #0: 00000000692a9d2f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000072fe5412 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4496:
  #0: 000000002b623882 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000056c15f7c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4497:
  #0: 000000002c1f858b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 0000000048aba06b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4498:
  #0: 00000000da02f89a (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000004a06c40f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4499:
  #0: 0000000017508207 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 00000000a4b24877 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4500:
  #0: 0000000079a247d3 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000009bcfd45d (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4501:
  #0: 00000000e73958a9 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
  #1: 000000007d96a629 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by syz-executor5/14500:
  #0: 00000000ba1ef7f9 (sb_writers#19){.+.+}, at: sb_start_write  
include/linux/fs.h:1554 [inline]
  #0: 00000000ba1ef7f9 (sb_writers#19){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
  #1: 00000000e4cbde96 (&sb->s_type->i_mutex_key#25){++++}, at: inode_lock  
include/linux/fs.h:715 [inline]
  #1: 00000000e4cbde96 (&sb->s_type->i_mutex_key#25){++++}, at:  
vfs_removexattr+0x82/0x1c0 fs/xattr.c:391
2 locks held by syz-executor5/14548:
  #0: 00000000ba1ef7f9 (sb_writers#19){.+.+}, at: sb_start_write  
include/linux/fs.h:1554 [inline]
  #0: 00000000ba1ef7f9 (sb_writers#19){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:386
  #1: 00000000e4cbde96 (&sb->s_type->i_mutex_key#25){++++}, at: inode_lock  
include/linux/fs.h:715 [inline]
  #1: 00000000e4cbde96 (&sb->s_type->i_mutex_key#25){++++}, at:  
vfs_removexattr+0x82/0x1c0 fs/xattr.c:391

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 901 Comm: khungtaskd Not tainted 4.18.0-rc4+ #138
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
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
