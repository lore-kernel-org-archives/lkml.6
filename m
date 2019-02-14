Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C8C2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405813AbfBNLbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:31:06 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:57037 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfBNLbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:31:03 -0500
Received: by mail-it1-f199.google.com with SMTP id 135so9640790itb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 03:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rAGrgVmd7jY1B2AKLWXblFBZOmLFIxKmCTmWr0Bfyy8=;
        b=Vv+3bzqV+QH1bYUlNUqFy6z8jX3XyCA6o2zHnzEkgFWeAvajvzx5emekO18ckN6KPS
         yV44nHowUeB/5QSxn5BtnBaev4qE+z6fudp71yQypPPweQKgBoZALtaJtcvI0Ht9y3FC
         aMJdAekSBTlap3QyShoozaJJoX1eOS/umRXMYZhU8Pn424aZkGHErQyziGjWpcqa4Agd
         0EdI68CHGCmsI1YynA0maYZo+wVXhIlz6qWppVqeLSWhgrfxkn9HIe7r/4s9ARMIzKvA
         3O38rRC3txLPstcMXSzROL3DbFY+KPezf4YX4g4x9X/W3WQbyAmZiHGeq7wzPmmzucWU
         HVGQ==
X-Gm-Message-State: AHQUAuYLF9pkZTFMKco0gJgEyPWqBNxiDTNSDhUOPnnWHNojpXHgfShJ
        okDYj2noVFQfXYTfmG4CJOFcGAcvuyGCcBFN4nPRtLF0R/mr
X-Google-Smtp-Source: AHgI3IYXf0gEv1iFrlOHvzuxH2xkx1yBC8+qf8PGMXWuInCnyljN7Wa+t82uCpmO93zbFiKsQxHsKThIzQsKTNQWB4kGKS6vcFZM
MIME-Version: 1.0
X-Received: by 2002:a02:23c8:: with SMTP id u191mr1962904jau.12.1550143862650;
 Thu, 14 Feb 2019 03:31:02 -0800 (PST)
Date:   Thu, 14 Feb 2019 03:31:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048c0060581d8fe23@google.com>
Subject: kernel BUG at drivers/android/binder_alloc.c:LINE! (2)
From:   syzbot <syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b3418f8bddf4 Add linux-next specific files for 20190214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15d98978c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a3a37525a677c71
dashboard link: https://syzkaller.appspot.com/bug?extid=55de1eb4975dec156d8f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com

binder: 9248:9252 ioctl 80081272 20000140 returned -22
------------[ cut here ]------------
kernel BUG at drivers/android/binder_alloc.c:1141!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9252 Comm: syz-executor.2 Not tainted 5.0.0-rc6-next-20190214  
#35
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1141
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 9f e1 26 fc 4c 89  
e6 4c 89 ef e8 b4 e2 26 fc 4d 39 e5 76 07 e8 8a e1 26 fc <0f> 0b e8 83 e1  
26 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 91
RSP: 0018:ffff88803fc37558 EFLAGS: 00010212
RAX: 0000000000040000 RBX: 0000000020001000 RCX: ffffc9000a245000
RDX: 0000000000000386 RSI: ffffffff85498076 RDI: 0000000000000006
RBP: ffff88803fc375d8 R08: ffff88805d20e640 R09: 0000000000000028
R10: ffffed1007f86f01 R11: ffff88803fc3780f R12: 0000000000000020
R13: 0000000000000028 R14: ffff8880772a18d0 R15: 0000000000000000
FS:  00007f8b32812700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d6c10 CR3: 00000000788df000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  binder_alloc_copy_from_buffer+0x37/0x42 drivers/android/binder_alloc.c:1187
  binder_get_object+0xa2/0x1e0 drivers/android/binder.c:2062
  binder_transaction+0x2b4a/0x6690 drivers/android/binder.c:3231
  binder_thread_write+0x64a/0x2820 drivers/android/binder.c:3792
  binder_ioctl_write_read drivers/android/binder.c:4825 [inline]
  binder_ioctl+0x1033/0x183b drivers/android/binder.c:5002
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8b32811c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e29
RDX: 0000000020000000 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8b328126d4
R13: 00000000004bf15b R14: 00000000004d0a60 R15: 00000000ffffffff
Modules linked in:
---[ end trace ccb30c2e039fdec2 ]---
RIP: 0010:binder_alloc_do_buffer_copy+0xd6/0x510  
drivers/android/binder_alloc.c:1141
Code: 02 00 0f 85 20 04 00 00 4d 8b 64 24 58 49 29 dc e8 9f e1 26 fc 4c 89  
e6 4c 89 ef e8 b4 e2 26 fc 4d 39 e5 76 07 e8 8a e1 26 fc <0f> 0b e8 83 e1  
26 fc 4c 8b 75 d0 4d 29 ec 4c 89 e6 4c 89 f7 e8 91
RSP: 0018:ffff88803fc37558 EFLAGS: 00010212
RAX: 0000000000040000 RBX: 0000000020001000 RCX: ffffc9000a245000
RDX: 0000000000000386 RSI: ffffffff85498076 RDI: 0000000000000006
RBP: ffff88803fc375d8 R08: ffff88805d20e640 R09: 0000000000000028
R10: ffffed1007f86f01 R11: ffff88803fc3780f R12: 0000000000000020
R13: 0000000000000028 R14: ffff8880772a18d0 R15: 0000000000000000
FS:  00007f8b32812700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff6ec60cec CR3: 00000000788df000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
