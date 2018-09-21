Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A58ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672CF21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672CF21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbeIUMb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:31:29 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:57033 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeIUMb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:31:29 -0400
Received: by mail-io1-f72.google.com with SMTP id a3-v6so18243760iod.23
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 23:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5StPrAEgw/nPj/v42xi+JdATyWojYn/Lb65NN/08LB0=;
        b=GflyB9DdZybLJxOmT38awwc2TSp3HeAzhnSokDze063/QjzQ4Szk/N985sOjYu/WJA
         pJRsvWFfs07ziUztgE8+vp8yy3QLEG2DZ6mFAciPJv/1oohQgiMyuTfqYYyGTpDIwKDY
         i3xjAjng28C2/YOVzDGVu9I2dNA6yd2pJWsLrU0wti0QdSYH3VeucBHxkrdCo3Q1opGG
         /VvF4JgkSlnJFONtT1SvbsW9cuC0CREunNgQKB09uOtwvFb8qUIR9d3/apwxrYxceV5B
         FNqYhN2p1gdZXmK1kURGDGrzj6h5xXvXu39klvfiONuRwLovTgY7nZPCv7Kzb/SOf1As
         EpoQ==
X-Gm-Message-State: APzg51Ads9xr+aGYox3X7I+viMS+UBdmlILIxSchjFEjX3eDbSJ8Obeh
        tD9VeSgb7Isfx/VKkm5hnCipkhq6xfGjn5xxDR74xnt7+ZC3
X-Google-Smtp-Source: ANB0VdZiCkYk5URA+d5hlF3a1NrgJ5sRbgLjuvdBu/rY3pIjRNka5Eqsdq5Wn8TNlmVlQ4+5r07moEStP5lhTkjIeNb4xsysjUxj
MIME-Version: 1.0
X-Received: by 2002:a6b:1ecb:: with SMTP id e194-v6mr29947411ioe.93.1537512242945;
 Thu, 20 Sep 2018 23:44:02 -0700 (PDT)
Date:   Thu, 20 Sep 2018 23:44:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014285d05765bf72a@google.com>
Subject: BUG: unable to handle kernel paging request in do_mount
From:   syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a0cb0cabe4bb Add linux-next specific files for 20180920
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=164d6511400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=786006c5dafbadf6
dashboard link: https://syzkaller.appspot.com/bug?extid=73c7fe4f77776505299b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13650fae400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118cbf21400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com

RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440329
RDX: 0000000020000380 RSI: 00000000200002c0 RDI: 0000000000000000
RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000034
R10: 00000000001800a0 R11: 0000000000000246 R12: 0000000000000003
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
BUG: unable to handle kernel paging request at fffffffffffffff4
PGD 966d067 P4D 966d067 PUD 966f067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5551 Comm: syz-executor016 Not tainted  
4.19.0-rc4-next-20180920+ #76
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:parse_monolithic_mount_data fs/namespace.c:2354 [inline]
RIP: 0010:do_remount fs/namespace.c:2387 [inline]
RIP: 0010:do_mount+0xb3b/0x1db0 fs/namespace.c:2950
Code: 06 00 48 89 c2 48 89 c3 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80  
3c 02 00 0f 85 24 11 00 00 48 b8 00 00 00 00 00 fc ff df <4c> 8b 33 49 8d  
7e 18 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f8 10
RSP: 0018:ffff8801bb99fc28 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 0000000000000000
RDX: 1ffffffffffffffe RSI: ffffffff81ddffac RDI: 0000000000000282
RBP: ffff8801bb99fdb0 R08: ffff8801d8b0e600 R09: ffffed003b5a5b57
R10: ffffed003b5a5b57 R11: ffff8801dad2dabb R12: ffff8801d3666830
R13: ffff8801c942cb80 R14: ffff8801c942cb80 R15: 0000000000000000
FS:  00000000010de880(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 00000001d84b5000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ksys_mount+0x12d/0x140 fs/namespace.c:3175
  __do_sys_mount fs/namespace.c:3189 [inline]
  __se_sys_mount fs/namespace.c:3186 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3186
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440329
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc6e4c9ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440329
RDX: 0000000020000380 RSI: 00000000200002c0 RDI: 0000000000000000
RBP: 00000000006cb018 R08: 0000000000000000 R09: 0000000000000034
R10: 00000000001800a0 R11: 0000000000000246 R12: 0000000000000003
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: fffffffffffffff4
---[ end trace 8aa3e592ff591401 ]---
RIP: 0010:parse_monolithic_mount_data fs/namespace.c:2354 [inline]
RIP: 0010:do_remount fs/namespace.c:2387 [inline]
RIP: 0010:do_mount+0xb3b/0x1db0 fs/namespace.c:2950
Code: 06 00 48 89 c2 48 89 c3 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80  
3c 02 00 0f 85 24 11 00 00 48 b8 00 00 00 00 00 fc ff df <4c> 8b 33 49 8d  
7e 18 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f8 10
RSP: 0018:ffff8801bb99fc28 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: fffffffffffffff4 RCX: 0000000000000000
RDX: 1ffffffffffffffe RSI: ffffffff81ddffac RDI: 0000000000000282
RBP: ffff8801bb99fdb0 R08: ffff8801d8b0e600 R09: ffffed003b5a5b57
R10: ffffed003b5a5b57 R11: ffff8801dad2dabb R12: ffff8801d3666830
R13: ffff8801c942cb80 R14: ffff8801c942cb80 R15: 0000000000000000
FS:  00000000010de880(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff4 CR3: 00000001d84b5000 CR4: 00000000001406e0
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
