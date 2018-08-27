Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64C4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D46208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D46208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeH1AvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:51:22 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:49998 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1AvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:51:22 -0400
Received: by mail-io0-f200.google.com with SMTP id k9-v6so291135iob.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VpR1eB7lJbtMcMycRv8NZynP3fXO80jlxkdKLAzgYcY=;
        b=R5G0K3MixqyYVE6vCCNN6frhwsNyxfXHqYuFvpSTcd7II2GvqZk3naMLxOe15btzMA
         Na/gl9yQxPiv3Z1qZFmTQZe1nKOKRe5PaqDxv0SjIS4fx574rwvqv/2Bcuga4shy8WFt
         SIofYYyuBTZNpi7San+T7ZGmTTnEszNWareWW56HM3vqXpfAfobSlDM4kRHsd1ELICo3
         lXhmcwfqkQzAH56WRocF+6dBHIm/Y6HU2HUz20zupYo/Ca9vCy7N1fVGG6DyYifWRCkY
         D1iAN3MMMgJ2xurP+Q0R3Tsh628JQpvzSP8U+U6kj4nYK8TC07VVA/8euAaI0vSWMz9n
         4SAg==
X-Gm-Message-State: APzg51Axo8owONd2cF6FI/KwayUW6Bh5p1BO8lxbYzZAAB1jyip8Df28
        9SV8GctmWJCioAmis3016yNzSBSlw/+rmC860CRuxm1KJkif
X-Google-Smtp-Source: ANB0Vdat3wBHntNvld2ACJNS/jOPbOG0Sdozy3sTFHTY1bwE3l/n+3J0R2sHQvP0u6DNwiwZApG1hQGO9uZr5fqa2qiw6W8x6PqR
MIME-Version: 1.0
X-Received: by 2002:a6b:3ad4:: with SMTP id h203-v6mr197229ioa.94.1535403783841;
 Mon, 27 Aug 2018 14:03:03 -0700 (PDT)
Date:   Mon, 27 Aug 2018 14:03:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f74de0574710d3e@google.com>
Subject: INFO: task hung in snd_seq_write
From:   syzbot <syzbot+4c595632b98bb8ffcc66@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e27bc174c9c6 Add linux-next specific files for 20180824
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1772020a400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28446088176757ea
dashboard link: https://syzkaller.appspot.com/bug?extid=4c595632b98bb8ffcc66
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4c595632b98bb8ffcc66@syzkaller.appspotmail.com

INFO: task syz-executor1:8015 blocked for more than 140 seconds.
       Not tainted 4.18.0-next-20180824+ #47
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D25408  8015   4471 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1003 [inline]
  __mutex_lock+0xbf9/0x1700 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  snd_seq_write+0x1f1/0x8d0 sound/core/seq/seq_clientmgr.c:1021
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: 08 e8 3b a9 fb ff 48 8b 44 24 20 48 8b 4c 24 18 48 8b 54 24 38 48 8b  
7c 24 48 eb 8d 48 8b 6c 24 50 48 83 c4 58 c3 48 89 04 24 <48> 89 5c 24 08  
e8 0d a9 fb ff 48 8b 44 24 40 48 8b 4c 24 48 48 8b
RSP: 002b:00007f5f1ec8fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5f1ec906d4 RCX: 0000000000457089
RDX: 0000000000000020 RSI: 0000000020000480 RDI: 0000000000000006
RBP: 0000000000930140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d7388 R14: 00000000004c1780 R15: 0000000000000001
INFO: task syz-executor1:8019 blocked for more than 140 seconds.
       Not tainted 4.18.0-next-20180824+ #47
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D25896  8019   4471 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1003 [inline]
  __mutex_lock+0xbf9/0x1700 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  snd_seq_write+0x1f1/0x8d0 sound/core/seq/seq_clientmgr.c:1021
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: 08 e8 3b a9 fb ff 48 8b 44 24 20 48 8b 4c 24 18 48 8b 54 24 38 48 8b  
7c 24 48 eb 8d 48 8b 6c 24 50 48 83 c4 58 c3 48 89 04 24 <48> 89 5c 24 08  
e8 0d a9 fb ff 48 8b 44 24 40 48 8b 4c 24 48 48 8b
RSP: 002b:00007f5f1ec6ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5f1ec6f6d4 RCX: 0000000000457089
RDX: 0000000000000090 RSI: 0000000020000580 RDI: 0000000000000003
RBP: 00000000009301e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d7340 R14: 00000000004ca576 R15: 0000000000000002
INFO: task syz-executor1:8026 blocked for more than 140 seconds.
       Not tainted 4.18.0-next-20180824+ #47
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D25112  8026   4471 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1003 [inline]
  __mutex_lock+0xbf9/0x1700 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  snd_seq_ioctl+0x221/0x440 sound/core/seq/seq_clientmgr.c:2137
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: 08 e8 3b a9 fb ff 48 8b 44 24 20 48 8b 4c 24 18 48 8b 54 24 38 48 8b  
7c 24 48 eb 8d 48 8b 6c 24 50 48 83 c4 58 c3 48 89 04 24 <48> 89 5c 24 08  
e8 0d a9 fb ff 48 8b 44 24 40 48 8b 4c 24 48 48 8b
RSP: 002b:00007f5f1ec4dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5f1ec4e6d4 RCX: 0000000000457089
RDX: 00000000200006c0 RSI: 00000000c08c5332 RDI: 0000000000000006
RBP: 0000000000930280 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004cfed0 R14: 00000000004bf048 R15: 0000000000000003
INFO: task syz-executor1:8040 blocked for more than 140 seconds.
       Not tainted 4.18.0-next-20180824+ #47
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D25896  8040   4471 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1003 [inline]
  __mutex_lock+0xbf9/0x1700 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  snd_seq_write+0x1f1/0x8d0 sound/core/seq/seq_clientmgr.c:1021
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: 08 e8 3b a9 fb ff 48 8b 44 24 20 48 8b 4c 24 18 48 8b 54 24 38 48 8b  
7c 24 48 eb 8d 48 8b 6c 24 50 48 83 c4 58 c3 48 89 04 24 <48> 89 5c 24 08  
e8 0d a9 fb ff 48 8b 44 24 40 48 8b 4c 24 48 48 8b
RSP: 002b:00007f5f1ec2cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5f1ec2d6d4 RCX: 0000000000457089
RDX: 00000000000000a0 RSI: 00000000200004c0 RDI: 0000000000000006
RBP: 0000000000930320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d7418 R14: 00000000004c1870 R15: 0000000000000004
INFO: task syz-executor1:8043 blocked for more than 140 seconds.
       Not tainted 4.18.0-next-20180824+ #47
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor1   D25896  8043   4471 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
  schedule+0xfb/0x450 kernel/sched/core.c:3517
  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3575
  __mutex_lock_common kernel/locking/mutex.c:1003 [inline]
  __mutex_lock+0xbf9/0x1700 kernel/locking/mutex.c:1073
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
  snd_seq_write+0x1f1/0x8d0 sound/core/seq/seq_clientmgr.c:1021
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: 08 e8 3b a9 fb ff 48 8b 44 24 20 48 8b 4c 24 18 48 8b 54 24 38 48 8b  
7c 24 48 eb 8d 48 8b 6c 24 50 48 83 c4 58 c3 48 89 04 24 <48> 89 5c 24 08  
e8 0d a9 fb ff 48 8b 44 24 40 48 8b 4c 24 48 48 8b
RSP: 002b:00007f5f1ebeac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5f1ebeb6d4 RCX: 0000000000457089
RDX: 00000000ffffff76 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 0000000000930460 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d7790 R14: 00000000004ca7f1 R15: 0000000000000006

Showing all locks held in the system:
1 lock held by khungtaskd/776:
  #0: 0000000098b2492f (rcu_read_lock){....}, at:  
debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4436
1 lock held by rsyslogd/4329:
2 locks held by getty/4419:
  #0: 00000000a4856276 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000004b3fbd4e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4420:
  #0: 00000000d3776216 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 0000000018b91ba2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4421:
  #0: 00000000e90a323e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000369e6155 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4422:
  #0: 000000001139f51f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000003aa121ca (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4423:
  #0: 00000000dc25f399 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000009e2aa14c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4424:
  #0: 00000000fe22db15 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 00000000249dec83 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
2 locks held by getty/4425:
  #0: 000000002fbf78cf (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:353
  #1: 000000000377af90 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
1 lock held by syz-executor1/7988:
1 lock held by syz-executor1/8015:
  #0: 000000007dc4af24 (&client->ioctl_mutex){+.+.}, at:  
snd_seq_write+0x1f1/0x8d0 sound/core/seq/seq_clientmgr.c:1021
1 lock held by syz-executor1/8019:
  #0: 000000007dc4af24 (&client->ioctl_mutex){+.+.}, at:  
snd_seq_write+0x1f1/0x8d0 sound/core/seq/seq_clientmgr.c:1021
1 lock held by syz-executor1/8026:
  #0: 000000007dc4af24 (&client->ioctl_mutex){+.+.}, at:  
snd_seq_ioctl+0x221/0x440 sound/core/seq/seq_clientmgr.c:2137
1 lock held by syz-executor1/8040:
  #0: 000000007dc4af24 (&client->ioctl_mutex){+.+.}, at:  
snd_seq_write+0x1f1/0x8d0 sound/core/seq/seq_clientmgr.c:1021
1 lock held by syz-executor1/8043:
  #0: 000000007dc4af24 (&client->ioctl_mutex){+.+.}, at:  
snd_seq_write+0x1f1/0x8d0 sound/core/seq/seq_clientmgr.c:1021

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 776 Comm: khungtaskd Not tainted 4.18.0-next-20180824+ #47
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
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Sending NMI from CPU 1 to CPUs 0:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.319  
msecs
NMI backtrace for cpu 0
CPU: 0 PID: 7988 Comm: syz-executor1 Not tainted 4.18.0-next-20180824+ #47
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:mark_lock+0x181/0x19f0 kernel/locking/lockdep.c:3155
Code: 43 10 00 00 00 00 48 8b 75 d0 65 48 33 34 25 28 00 00 00 0f 85 f5 11  
00 00 48 81 c4 08 01 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d <c3> 48 c7 c7 a0  
97 90 89 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
RSP: 0018:ffff8801db0072e8 EFLAGS: 00000086
RAX: 0000000000000001 RBX: 0000000000000039 RCX: 1ffff100365035f1
RDX: 1ffffffff12853f6 RSI: 0000000000000000 RDI: ffffffff89429fb0
RBP: ffff8801db007680 R08: 0000000000000008 R09: 0000000000000001
R10: ffff8801b281a700 R11: ffff8801b281af2c R12: ffff8801b281af8a
R13: 0000000000000040 R14: ffff8801b281a700 R15: 000000000000000e
FS:  00007f5f1ecb1700(0000) GS:ffff8801db000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001c3883000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  lock_acquire+0x1e4/0x4f0 kernel/locking/lockdep.c:3901
  seqcount_lockdep_reader_access include/linux/seqlock.h:81 [inline]
  read_seqcount_begin include/linux/seqlock.h:164 [inline]
  ktime_get+0x14e/0x440 kernel/time/timekeeping.c:754
  hrtimer_forward_now include/linux/hrtimer.h:473 [inline]
  perf_swevent_hrtimer+0x405/0x510 kernel/events/core.c:9124
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3eb/0xff0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x16d/0x6a0 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:867
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa1/0xc0  
kernel/locking/spinlock.c:184
Code: 68 bc f1 87 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c  
02 00 75 21 48 83 3d 2e be 3a 01 00 74 0e 48 89 df 57 9d <0f> 1f 44 00 00  
eb bb 0f 0b 0f 0b e8 cf 10 05 fb eb 97 e8 c8 10 05
RSP: 0018:ffff88019430f7b0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 0000000000000282 RCX: 1ffff100365035ec
RDX: 1ffffffff0fe378d RSI: 0000000000000000 RDI: 0000000000000282
RBP: ffff88019430f7c0 R08: ffff8801b281af40 R09: 0000000000000006
R10: ffff8801b281a700 R11: 0000000000000000 R12: ffffffff8861fc20
R13: ffff8801b0156540 R14: 0000000000000282 R15: ffffffff8a34a020
  spin_unlock_irqrestore include/linux/spinlock.h:384 [inline]
  snd_seq_client_use_ptr+0x9e/0x3f0 sound/core/seq/seq_clientmgr.c:178
  snd_seq_dispatch_event+0xbf/0x650 sound/core/seq/seq_clientmgr.c:845
  snd_seq_check_queue.part.4+0x139/0x360 sound/core/seq/seq_queue.c:275
  snd_seq_check_queue sound/core/seq/seq_queue.c:255 [inline]
  snd_seq_enqueue_event+0x346/0x4d0 sound/core/seq/seq_queue.c:343
  snd_seq_client_enqueue_event+0x2a5/0x510 sound/core/seq/seq_clientmgr.c:957
  snd_seq_write+0x3f1/0x8d0 sound/core/seq/seq_clientmgr.c:1074
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457089
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5f1ecb0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5f1ecb16d4 RCX: 0000000000457089
RDX: 00000000ffffff76 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d7790 R14: 00000000004ca7f1 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
