Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72AC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D50213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D50213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJILjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:39:00 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48632 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeJILjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:39:00 -0400
Received: by mail-io1-f69.google.com with SMTP id v12-v6so230036iob.15
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 21:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rZqP1fm23mV6a0nmRz2viWF7KZXuarSsE6Oczbs7rqo=;
        b=OvMG2KXVDlQtxPglcC5f0bUhNw5Zlsf274iDskRYt89m1ByPl3oSxOzCB5MjpbM9bp
         9iu+4+sUzg1lT6bt5Z8kkhgIM9lKCwwduEc3XEi8YXxKLqbuvUkrdoIWwm+dGs4xoZAx
         izot5ZmCWP0jGu+vtf9/r28GJ5Kl+U7qe8cq7yM3ddiQ4+tO7LLyML+5QVi/uNvYATX/
         OyWUv6doBXB76LzFwRQT0y8dKEa3jMq2t2aerTvFPk6pUFQy5cfxAZfJ5r4ZAwdJ9Kp1
         V+INdV7eLL5nosqQTIGOF5mUzJNz++AcK9R5OiRWody43Jxx5E5kONkCD0/bscMwQK1l
         QF/g==
X-Gm-Message-State: ABuFfogDLFiwMKyagZs3u3ufLoju1LHyxsXln34FGw5y7JWrVJ3LdQbT
        bklyvdV7tkFsqQjaKEOUJa5vozAtxtJH5DTxBoy/0f6T4T8j
X-Google-Smtp-Source: ACcGV61XkDH1eEhkqikF/+avcxvN9/onbV9ZviX94ZsMeq53IL9DZo/07AJpMb5t2llJJ5+KNvYK0xarH1aE0NRIsIQYH79+LDMv
MIME-Version: 1.0
X-Received: by 2002:a5e:dd0c:: with SMTP id t12-v6mr18606711iop.16.1539059042860;
 Mon, 08 Oct 2018 21:24:02 -0700 (PDT)
Date:   Mon, 08 Oct 2018 21:24:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089c56e0577c41b4b@google.com>
Subject: kernel BUG at fs/block_dev.c:LINE!
From:   syzbot <syzbot+82909b30c4657137bf84@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0854ba5ff5c9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1554ec06400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=82909b30c4657137bf84
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10331976400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165db54e400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+82909b30c4657137bf84@syzkaller.appspotmail.com

  loop1: p1
  loop4: p1
  loop3: p1
  loop5: p1
------------[ cut here ]------------
kernel BUG at fs/block_dev.c:1627!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6913 Comm: syz-executor753 Not tainted 4.19.0-rc7+ #53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:blkdev_get+0x65f/0xb50 fs/block_dev.c:1627
Code: ff ff ff 0f 84 4d 03 00 00 48 89 85 f0 fe ff ff e8 f6 fa 9d ff 48 8b  
85 f0 fe ff ff 48 85 c0 0f 84 9b 00 00 00 e8 e1 fa 9d ff <0f> 0b e8 da fa  
9d ff 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffff8801c0a8f578 EFLAGS: 00010293
RAX: ffff8801c083a700 RBX: 0000000000000000 RCX: ffffffff81e0da52
RDX: 0000000000000000 RSI: ffffffff81e0daaf RDI: 0000000000000005
RBP: ffff8801c0a8f6a8 R08: ffff8801c083a700 R09: fffffbfff12424f0
R10: fffffbfff12424f0 R11: ffffffff89212783 R12: ffff8801d3ac0318
R13: ffff8801d3bee2d8 R14: ffff8801d3bee2c0 R15: ffff8801d3ac0280
FS:  0000000001359880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000606ed8 CR3: 00000001c12d3000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  blkdev_open+0x1fb/0x280 fs/block_dev.c:1775
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3418 [inline]
  path_openat+0x12bf/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445589
Code: fd cd fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb cd fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd31e04eb8 EFLAGS: 00000286 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000020000080 RCX: 0000000000445589
RDX: 00000000008001a0 RSI: 0000000020000080 RDI: 00000000ffffff9c
RBP: 706e692f7665642f R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000069554
R13: 0000000000402870 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace bcaf07e3e9ad4219 ]---
RIP: 0010:blkdev_get+0x65f/0xb50 fs/block_dev.c:1627
Code: ff ff ff 0f 84 4d 03 00 00 48 89 85 f0 fe ff ff e8 f6 fa 9d ff 48 8b  
85 f0 fe ff ff 48 85 c0 0f 84 9b 00 00 00 e8 e1 fa 9d ff <0f> 0b e8 da fa  
9d ff 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffff8801c0a8f578 EFLAGS: 00010293
RAX: ffff8801c083a700 RBX: 0000000000000000 RCX: ffffffff81e0da52
RDX: 0000000000000000 RSI: ffffffff81e0daaf RDI: 0000000000000005
RBP: ffff8801c0a8f6a8 R08: ffff8801c083a700 R09: fffffbfff12424f0
R10: fffffbfff12424f0 R11: ffffffff89212783 R12: ffff8801d3ac0318
R13: ffff8801d3bee2d8 R14: ffff8801d3bee2c0 R15: ffff8801d3ac0280
FS:  0000000001359880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000606ed8 CR3: 00000001c12d3000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
