Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D8EC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D508A2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfBUOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:52:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:56216 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:52:05 -0500
Received: by mail-it1-f200.google.com with SMTP id j3so15616034itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZJS2VseaFwaepfUpDnWNKJKlN/YdNaSZxjKfyQ9C93g=;
        b=oM2b7L1L5ow6TF5UeT7Ja/j7AiT0Tnmb50CJj18f5CJQL7G9zsTunA0Ay6uY/kO/9s
         UPwvZnjvQ/bmeBdcMhPOEy3maKFQCKqWvzRoz+4UcaUnjLbdE8a4rpfSmFsM874f3hXO
         +tENUhxaQS9PexN8cfPveEsL2AZrX90WmuTd66PEDXQG3MI3xGh2FBlr9FjRoHzCvD+q
         z+WBlq9foVg6KzV9vPjh9qA0cU7sT51zDl0Ht60VTcv0h/x/4qR0m+QkqLYvtuoEWraU
         4BORdetJEBmmWQbAmRU11l5s13pogAmULXgnVx+K9k3Wmc0wnCQJH74EOBdMBWxXG7EH
         4q3w==
X-Gm-Message-State: AHQUAuY0mOVQS0+/AUufEiQNFWMy83FpaBxq9MguRrQmS7PXQ54FgVdu
        R+qP3CK4LTCI9cj3B4wfrVzOzx6sXK/57wzYKQcQJtC+rqGJ
X-Google-Smtp-Source: AHgI3IYYYLJ55AAXJQMTHm/wFxozI21cq9PtW+0rU2zQ7iIk7+aBh7YUOsgoqtbqXovYRV2HSIO9DYrzXfD8BV6nkcCOY34KOljX
MIME-Version: 1.0
X-Received: by 2002:a6b:c707:: with SMTP id x7mr27774925iof.5.1550760724309;
 Thu, 21 Feb 2019 06:52:04 -0800 (PST)
Date:   Thu, 21 Feb 2019 06:52:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001aab8b0582689e11@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in __generic_file_write_iter
From:   syzbot <syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, amir73il@gmail.com,
        darrick.wong@oracle.com, david@fromorbit.com, hannes@cmpxchg.org,
        hughd@google.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4aa9fc2a435a Revert "mm, memory_hotplug: initialize struct..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1101382f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fceea9e2d99ac20
dashboard link: https://syzkaller.appspot.com/bug?extid=ca95b2b7aef9e7cbd6ab
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ca95b2b7aef9e7cbd6ab@syzkaller.appspotmail.com

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
#PF error: [INSTR]
PGD a7ea0067 P4D a7ea0067 PUD 81535067 PMD 0
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 15924 Comm: syz-executor0 Not tainted 5.0.0-rc4+ #50
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff88804c3d7858 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff885aeb60 RCX: 000000000000005b
RDX: 0000000000000000 RSI: ffff88807ec22930 RDI: ffff8880a59bdcc0
RBP: ffff88804c3d79b8 R08: 0000000000000000 R09: ffff88804c3d7910
R10: ffff8880835ca200 R11: 0000000000000000 R12: 000000000000005b
R13: ffff88804c3d7c98 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007f3456db4700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000814ac000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __generic_file_write_iter+0x25e/0x630 mm/filemap.c:3333
  ext4_file_write_iter+0x37a/0x1410 fs/ext4/file.c:266
  call_write_iter include/linux/fs.h:1862 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x764/0xb40 fs/read_write.c:487
  vfs_write+0x20c/0x580 fs/read_write.c:549
  ksys_write+0x105/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458089
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3456db3c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458089
RDX: 000000000000005b RSI: 0000000020000240 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3456db46d4
R13: 00000000004c7450 R14: 00000000004dce68 R15: 00000000ffffffff
Modules linked in:
CR2: 0000000000000000
---[ end trace 5cac9d2c75a59916 ]---
kobject: 'loop5' (000000004426a409): kobject_uevent_env
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff88804c3d7858 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff885aeb60 RCX: 000000000000005b
kobject: 'loop5' (000000004426a409): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
RDX: 0000000000000000 RSI: ffff88807ec22930 RDI: ffff8880a59bdcc0
kobject: 'loop2' (00000000b82e0c58): kobject_uevent_env
kobject: 'loop2' (00000000b82e0c58): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
RBP: ffff88804c3d79b8 R08: 0000000000000000 R09: ffff88804c3d7910
R10: ffff8880835ca200 R11: 0000000000000000 R12: 000000000000005b
R13: ffff88804c3d7c98 R14: dffffc0000000000 R15: 0000000000000000
kobject: 'loop5' (000000004426a409): kobject_uevent_env
FS:  00007f3456db4700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
kobject: 'loop5' (000000004426a409): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000022029a0 CR3: 00000000814ac000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
