Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7836C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8947820852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8947820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935061AbeFROdF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:33:05 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:39804 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934882AbeFROdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:33:03 -0400
Received: by mail-it0-f70.google.com with SMTP id o7-v6so8448636itf.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 07:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Cepo5oeo3tzRCJ2FcewOumPG1eGPriC7kCbPj6fUDAc=;
        b=VmTAKRH7EWxrB4FdP8BBX1H8zPY7hskrvJqbnhkHk5Qv5FrbiYe/Ab7a+cFM7fb43c
         2TGqxCB+bFBEBbBYqXCw2z9Li0e2XqCb295a593LGBLelYqM2b36D+6Nj1mZyIQh4PJn
         65UVTAMnmmEcdGZ9ilkVB+AG0wF717zDqnltyqPdVguQLwAs7P6WFgEOyrVtVvl2XM35
         MfPdoHfeOInGg3B+/yARa+QIUhzhx90gK3OSEoyyrY3BEtrTUjFxDx0Y1FBRghJjHOFh
         /omvz1y+CVBQAsdxVdW0Wah+sePq544wh/QaP7YmckPbAJNO6mMQAJu94o8pay7kVfvC
         FIjg==
X-Gm-Message-State: APt69E1LeTpLxz5/FfWaG9iNKb5SzalkHZt+czzkmXJc1hb+idGyzURT
        q+eUyYSdfqcTq87nMsgp9rxz78xrwuRuBerqLLqwou06+WEo
X-Google-Smtp-Source: ADUXVKL+TnWRfzT/jYG8MgYQUeknhM0dqi0YpWNsIDBwxNZFT8y+8xf8BfCyd9aNZEzJKvKAEFft7l983PlVO3vkJ8l95rMHt/0s
MIME-Version: 1.0
X-Received: by 2002:a24:42cf:: with SMTP id i198-v6mr5000297itb.9.1529332382717;
 Mon, 18 Jun 2018 07:33:02 -0700 (PDT)
Date:   Mon, 18 Jun 2018 07:33:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a6282056eeb71da@google.com>
Subject: general protection fault in loop_validate_file
From:   syzbot <syzbot+2f228435b0b9ec0ba068@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ce397d215ccd Linux 4.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129dfccf800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f390986c4f7cd566
dashboard link: https://syzkaller.appspot.com/bug?extid=2f228435b0b9ec0ba068
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2f228435b0b9ec0ba068@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 16780 Comm: syz-executor1 Not tainted 4.18.0-rc1+ #107
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:loop_validate_file+0x247/0x470 drivers/block/loop.c:664
Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 2e 02 00 00 4d 8b a4 24  
f0 00 00 00 49 8d bc 24 b8 01 00 00 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f  
85 03 02 00 00 4d 8b a4 24 b8 01 00 00 4c 89 e0 48
RSP: 0018:ffff8801b2f2f8f8 EFLAGS: 00010202
RAX: 0000000000000037 RBX: dffffc0000000000 RCX: ffffc90002a12000
RDX: 0000000000000047 RSI: ffffffff84c20bf7 RDI: 00000000000001b8
RBP: ffff8801b2f2f918 R08: ffff8801c9498380 R09: ffffed003b5c46d6
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8801b38f71c0 R14: 0000000000000002 R15: ffff8801cfb60500
FS:  00007f40b01d1700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f222000 CR3: 00000001c542a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  loop_set_fd drivers/block/loop.c:928 [inline]
  lo_ioctl+0x54d/0x1d10 drivers/block/loop.c:1411
  __blkdev_driver_ioctl block/ioctl.c:303 [inline]
  blkdev_ioctl+0x9cd/0x2030 block/ioctl.c:601
  block_ioctl+0xee/0x130 fs/block_dev.c:1880
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455b29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f40b01d0c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f40b01d16d4 RCX: 0000000000455b29
RDX: 0000000000000014 RSI: 0000000000004c00 RDI: 0000000000000015
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004be118 R14: 00000000004cc118 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 3a5a065777b1499b ]---
RIP: 0010:loop_validate_file+0x247/0x470 drivers/block/loop.c:664
Code: 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 2e 02 00 00 4d 8b a4 24  
f0 00 00 00 49 8d bc 24 b8 01 00 00 48 89 f8 48 c1 e8 03 <80> 3c 18 00 0f  
85 03 02 00 00 4d 8b a4 24 b8 01 00 00 4c 89 e0 48
RSP: 0018:ffff8801b2f2f8f8 EFLAGS: 00010202
RAX: 0000000000000037 RBX: dffffc0000000000 RCX: ffffc90002a12000
RDX: 0000000000000047 RSI: ffffffff84c20bf7 RDI: 00000000000001b8
RBP: ffff8801b2f2f918 R08: ffff8801c9498380 R09: ffffed003b5c46d6
R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8801b38f71c0 R14: 0000000000000002 R15: ffff8801cfb60500
FS:  00007f40b01d1700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f222000 CR3: 00000001c542a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
