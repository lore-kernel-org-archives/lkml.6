Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B28120843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B28120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeIZN6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:58:40 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:44561 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeIZN6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:58:40 -0400
Received: by mail-it1-f200.google.com with SMTP id b124-v6so1971216itb.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LANyA0PoPhOKzI/10ePXYIqv2A+JbX8poeUVKpZCkwA=;
        b=L5IJpnbR0EGF59jyPH8IK3JnH2dn5An4HZhAT8jwO3ugrDiw8ybTK2r1C7rTM4i8o8
         7PPm7YT9FgxSGcys571TO5bpIbd5C31ouYwCUPxx02ziSj4p1bAw4xCjWsOVJYKz4Wol
         6gn+r2kB5eNyl+ZeU4sCsiHPqsw7rVRjaL1admxFpNQos/k/GEf5YrLuwixdG2gJl0vD
         GUEA8CFHaQmm7u0prkk3fepT+j5tabw9UwDBkgeasbh4MaE/x0rzD4fTODBoWLMJW7uv
         JrtRRqfoXc3tDP55k2xDjQ5LwfRws6QGhvKqqzk+A6fyVQ/GiGRk9HoDfa5q2UEbspWO
         ONjw==
X-Gm-Message-State: ABuFfohv8Qhi99l0f461G+j2wUktUYz3SxlQNB5iRyO1qFVzld3UlYy5
        9DbOWU/Bp5TWg6sFiizkiEhoCPxUVJwpVCL2ovTvr4iFoxj9
X-Google-Smtp-Source: ACcGV60JzXxnopMBGiVOIZRIpzE/67s5yu5Ly2/rdYvslOHBgaYKJcZ1Ss/evVTxeLI8MJG3IVJAshCm4G1LoXyOQs5ZWMfeqC1E
MIME-Version: 1.0
X-Received: by 2002:a6b:4a16:: with SMTP id w22-v6mr3328547iob.132.1537948022831;
 Wed, 26 Sep 2018 00:47:02 -0700 (PDT)
Date:   Wed, 26 Sep 2018 00:47:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009581bf0576c16d3a@google.com>
Subject: general protection fault in integrity_inode_free
From:   syzbot <syzbot+4c0fa7d385ea5af34e91@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    846e8dd47c26 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a59d56400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
dashboard link: https://syzkaller.appspot.com/bug?extid=4c0fa7d385ea5af34e91
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4c0fa7d385ea5af34e91@syzkaller.appspotmail.com

  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
general protection fault: 0000 [#1] PREEMPT SMP KASAN
RIP: 0033:0x457579
CPU: 0 PID: 8727 Comm: syz-executor3 Not tainted 4.19.0-rc5+ #33
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RSP: 002b:00007f07f2e4bc78 EFLAGS: 00000246
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:168 [inline]
RIP: 0010:rb_erase+0x306/0x3710 lib/rbtree.c:459
  ORIG_RAX: 000000000000002e
Code: c7 81 28 01 00 00 f2 f2 f2 f2 c7 81 2c 01 00 00 00 f2 f2 f2 48 89 f9  
65 48 8b 1c 25 28 00 00 00 48 89 5d d0 31 db 48 c1 e9 03 <42> 80 3c 01 00  
0f 85 41 1c 00 00 4c 8d 48 10 4c 8b 78 08 48 b9 00
RAX: ffffffffffffffda RBX: 00007f07f2e4bc90 RCX: 0000000000457579
RSP: 0018:ffff88018620e918 EFLAGS: 00010202
RDX: 0000000000000000 RSI: 000000002000b000 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f07f2e4c6d4
RDX: 1ffff10030c41d2b RSI: ffffffff8b5a08a0 RDI: 0000000000000008
R13: 00000000004c38e1 R14: 00000000004d5730 R15: 0000000000000004
RBP: ffff88018620f320 R08: dffffc0000000000 R09: fffffbfff135d5c8
kobject: 'loop5' (00000000eac6d22a): kobject_uevent_env
R10: fffffbfff135d5c8 R11: ffffffff89aeae43 R12: ffff8801bacb38f0
R13: dffffc0000000000 R14: ffff88018620f2f8 R15: ffff88018620f438
overlayfs: unrecognized mount option "smackfstransmute=upperdir" or missing  
value
FS:  00007ff9677ec700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31324000 CR3: 00000001c2773000 CR4: 00000000001406f0
Call Trace:
  integrity_inode_free+0x12f/0x320 security/integrity/iint.c:150
  security_inode_free+0x19/0x90 security/security.c:453
  __destroy_inode+0x328/0x820 fs/inode.c:238
  destroy_inode+0xda/0x200 fs/inode.c:265
  evict+0x5e0/0x980 fs/inode.c:575
  iput_final fs/inode.c:1547 [inline]
  iput+0x679/0xa90 fs/inode.c:1573
  swap_inode_boot_loader fs/ext4/ioctl.c:188 [inline]
  ext4_ioctl+0x236f/0x4210 fs/ext4/ioctl.c:865
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:501 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
  __do_sys_ioctl fs/ioctl.c:709 [inline]
  __se_sys_ioctl fs/ioctl.c:707 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff9677ebc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457579
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000003
RBP: 000000000072c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff9677ec6d4
R13: 00000000004bf626 R14: 00000000004cf4c0 R15: 00000000ffffffff
Modules linked in:
---[ end trace 6d41a32e43d56085 ]---
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:168 [inline]
RIP: 0010:rb_erase+0x306/0x3710 lib/rbtree.c:459
Code: c7 81 28 01 00 00 f2 f2 f2 f2 c7 81 2c 01 00 00 00 f2 f2 f2 48 89 f9  
65 48 8b 1c 25 28 00 00 00 48 89 5d d0 31 db 48 c1 e9 03 <42> 80 3c 01 00  
0f 85 41 1c 00 00 4c 8d 48 10 4c 8b 78 08 48 b9 00
RSP: 0018:ffff88018620e918 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffff10030c41d2b RSI: ffffffff8b5a08a0 RDI: 0000000000000008
RBP: ffff88018620f320 R08: dffffc0000000000 R09: fffffbfff135d5c8
R10: fffffbfff135d5c8 R11: ffffffff89aeae43 R12: ffff8801bacb38f0
R13: dffffc0000000000 R14: ffff88018620f2f8 R15: ffff88018620f438
FS:  00007ff9677ec700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31324000 CR3: 00000001c2773000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
