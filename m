Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDBEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0087D2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 05:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0087D2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbeKGObu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:31:50 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:39971 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbeKGObt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:31:49 -0500
Received: by mail-it1-f198.google.com with SMTP id y144-v6so20122495itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 21:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oKdqLNRUyfDOsY22dPLcC9o/6BB8HqoxmHM+EbugauA=;
        b=FMSLm+lANKYprURoJlksRzuv8gbb2WK/n7l7JlNSoiVgAq6dMLAtOTikXc12wBXyQ/
         3zrwZrS0S8Na31o2j+amIogtGlYgXcvkzzpUpTw0t21X/VfdF8QMzegP/A/tZXpwq5p2
         6eUA0Ng7KqpI0qNzZO21iXhielrS2hUuYk5PURv2PrFP7tuY9fResZOLkdZ/esjCI/Jb
         DRSAGuhcTERA4o4WIwkYhX7Dl1Yuxu331KXrOyJCR8a+7vS4ZdndYqHbrbLfkHXPgz6L
         NSaDi0+glSxxXkE6OT8lD8zUFyDKF+0pAyaE8wj9dbxJnbhvUGBPoydMIWbCGBt1Cz0j
         E4ow==
X-Gm-Message-State: AGRZ1gKsZxgqW22ljVPM+60iYRjTsZAA+W71yZWTGqmeYNepTCTdPpsI
        yuoWd92/iIiHouwJmfbPjnsI6ThuHkxS5KhMiQaPItzOYVxX
X-Google-Smtp-Source: AJdET5cQ6A5C38LNEPy0Q+0RwKJ/U5zMmqrsipdftaS5LLh7df3QiIFZtKwac8vjlDk53Q8q6BNL19P2KYuox9SC4Mar9eCa4ECH
MIME-Version: 1.0
X-Received: by 2002:a6b:df42:: with SMTP id d2-v6mr214832iop.21.1541566984997;
 Tue, 06 Nov 2018 21:03:04 -0800 (PST)
Date:   Tue, 06 Nov 2018 21:03:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089d2c9057a0c083a@google.com>
Subject: general protection fault in __x86_indirect_thunk_rbx
From:   syzbot <syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae9825400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
dashboard link: https://syzkaller.appspot.com/bug?extid=83e12cf81d2c14842146
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9939 Comm: syz-executor5 Not tainted 4.20.0-rc1-next-20181107+  
#107
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__x86_indirect_thunk_rbx+0x10/0x20 arch/x86/lib/retpoline.S:33
Code: 90 0f ae e8 eb f9 48 89 04 24 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00  
00 00 00 e8 07 00 00 00 f3 90 0f ae e8 eb f9 48 89 1c 24 <c3> 0f 1f 44 00  
00 66 2e 0f 1f 84 00 00 00 00 00 e8 07 00 00 00 f3
RSP: 0018:ffff88019f166eb0 EFLAGS: 00010293
RAX: ffff8801c298a680 RBX: 5f415e415d415c41 RCX: ffffffff81ed555d
kobject: 'loop2' (000000005961f4a7): kobject_uevent_env
RDX: 0000000000000000 RSI: ffffffff81ed5c9e RDI: ffff88019f166f38
RBP: ffff88019f1670a0 R08: ffff8801c298a680 R09: ffffed003b5e5b67
kobject: 'loop2' (000000005961f4a7): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801ce6465c0
R13: ffff88019f166f38 R14: 1ffff10033e2cddb R15: dffffc0000000000
FS:  00007fdc2a4eb700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c000 CR3: 000000019fde7000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
  __fput+0x2f0/0xa70 fs/file_table.c:271
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad1/0x26d0 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8a8/0x1970 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fdc2a4eac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffe0 RBX: 0000000000000006 RCX: 0000000000457569
RDX: 000000000000029f RSI: 0000000020a88f88 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000020e68000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdc2a4eb6d4
R13: 00000000004c3b86 R14: 00000000004d5cc8 R15: 00000000ffffffff
Modules linked in:
---[ end trace f409c0e248b1eb30 ]---
RIP: 0010:__x86_indirect_thunk_rbx+0x10/0x20 arch/x86/lib/retpoline.S:33
Code: 90 0f ae e8 eb f9 48 89 04 24 c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00  
00 00 00 e8 07 00 00 00 f3 90 0f ae e8 eb f9 48 89 1c 24 <c3> 0f 1f 44 00  
00 66 2e 0f 1f 84 00 00 00 00 00 e8 07 00 00 00 f3
RSP: 0018:ffff88019f166eb0 EFLAGS: 00010293
RAX: ffff8801c298a680 RBX: 5f415e415d415c41 RCX: ffffffff81ed555d
RDX: 0000000000000000 RSI: ffffffff81ed5c9e RDI: ffff88019f166f38
RBP: ffff88019f1670a0 R08: ffff8801c298a680 R09: ffffed003b5e5b67
R10: ffffed003b5e5b67 R11: ffff8801daf2db3b R12: ffff8801ce6465c0
audit: type=1326 audit(1541560871.105:63): auid=4294967295 uid=0 gid=0  
ses=4294967295 subj==unconfined pid=9895 comm="syz-executor3"  
exe="/root/syz-executor3" sig=9 arch=c000003e syscall=228 compat=0  
ip=0x45a3ca code=0x0
R13: ffff88019f166f38 R14: 1ffff10033e2cddb R15: dffffc0000000000
FS:  00007fdc2a4eb700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
kobject: 'loop4' (00000000e724a344): kobject_uevent_env
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop4' (00000000e724a344): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (00000000c2eca0f7): kobject_uevent_env
kobject: 'loop3' (00000000e5653105): kobject_uevent_env
kobject: 'kvm' (00000000c2eca0f7): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (00000000e5653105): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
CR2: 00007fe26d074db8 CR3: 00000001a2d54000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kobject: 'kvm' (00000000c2eca0f7): kobject_uevent_env
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kobject: 'kvm' (00000000c2eca0f7): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (00000000b5ef668f): kobject_uevent_env


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
