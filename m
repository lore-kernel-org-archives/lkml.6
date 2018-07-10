Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922BBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E12E20871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E12E20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeGJTZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:25:30 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:56007 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732241AbeGJTZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:25:30 -0400
Received: by mail-io0-f197.google.com with SMTP id u23-v6so19946587iol.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KJrGFzcAjE4/VEZNNBMxdxK731xrmtqwqyKMFHg+8WM=;
        b=ZSBwB51iuJWmkR79rS2i1GCPbX7GvvSitzCpTON4hm9h7f38F5TVT5VdzxVB2CNjBU
         3QCy5LLADNqtY5HVFFrXP+I3BV1w4VlPl4jSxRSKearuN+1/M13onNtImGoMt98G+msT
         FDDxhkfyXqeldVQhxxFd3GeLpS5NXoCo+DRqW7Bse2+/pw26fcWA0n4Q+/Dn5qHoL7FO
         jD3OuzuMfITkwV26rRrgXKtIZUYyWcgnkBWSVg/W+CX9bBR+NPVLHC9yrK1ksNHqaUZu
         gxN0PNLNCo1aH9p3riIbGCdZXJfeAJ87/nJXfuyX2OmQzkzr04V7gd4F0R4Z0lis6o8o
         +wZw==
X-Gm-Message-State: APt69E0CQo6XdL+psTZsbJpyvhKqK+Tjl2DJ+V6Z3SOLTuiSBsZnCLZ5
        9A55FSv8WOGC41P5QbB1ZuqqsCfWJWOqj4WT05c5K/MIQV1a
X-Google-Smtp-Source: AAOMgpeFuv/VCc57fsQGQ6XI8e0Df35x0heoxjkdcOWoKilwyTQ9cpH3kKirIe1MI/BTXxLu4exW+XEBgBZpPGbfv5/ZzQIjsAFq
MIME-Version: 1.0
X-Received: by 2002:a24:700a:: with SMTP id f10-v6mr8658635itc.40.1531250702272;
 Tue, 10 Jul 2018 12:25:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:25:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bd65e0570aa16f2@google.com>
Subject: kernel BUG at fs/reiserfs/lock.c:LINE!
From:   syzbot <syzbot+66d2c2155ece8b6d3fc0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3951bd9fe3e2 Add linux-next specific files for 20180710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1495050c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b6e8479ba596271a
dashboard link: https://syzkaller.appspot.com/bug?extid=66d2c2155ece8b6d3fc0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+66d2c2155ece8b6d3fc0@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000014
R13: 0000000000000000 R14: 00000000004d3fb8 R15: 0000000000000048
REISERFS warning (device loop2):  reiserfs_fill_super: Cannot allocate  
memory for journal device name
loop6: rw=1, want=32877, limit=112
------------[ cut here ]------------
kernel BUG at fs/reiserfs/lock.c:44!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 12313 Comm: syz-executor2 Not tainted 4.18.0-rc4-next-20180710+  
#3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:reiserfs_write_unlock+0xeb/0x110 fs/reiserfs/lock.c:44
Code: 5d c3 e8 88 42 76 ff 48 8d 7b 28 48 c7 83 a8 00 00 00 00 00 00 00 e8  
c4 b8 96 05 e8 6f 42 76 ff 5b 41 5c 5d c3 e8 65 42 76 ff <0f> 0b e8 fe c2  
b4 ff eb a1 e8 17 c3 b4 ff e9 33 ff ff ff e8 0d c3
RSP: 0018:ffff8801956e77e0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8801ba2e16c0 RCX: ffffc9000b8a9000
RDX: 0000000000040000 RSI: ffffffff8206390b RDI: ffff8801ba2e1768
RBP: ffff8801956e77f0 R08: ffffed0032adcf25 R09: 0000000000000000
R10: fffffbfff11f1224 R11: ffffffff88f89123 R12: ffff8801956e7ac8
R13: ffffed0032adcf3d R14: ffffed0032adcf2d R15: ffff8801c9f20800
FS:  00007f1c6ce16700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c2643 CR3: 00000001cda4f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  reiserfs_fill_super+0xfac/0x3930 fs/reiserfs/super.c:2222
  mount_bdev+0x314/0x3e0 fs/super.c:1344
  get_super_block+0x3c/0x50 fs/reiserfs/super.c:2608
  legacy_get_tree+0x118/0x440 fs/fs_context.c:659
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45885a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd 8f fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ba 8f fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007f1c6ce15a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1c6ce15b30 RCX: 000000000045885a
RDX: 00007f1c6ce15ad0 RSI: 0000000020000140 RDI: 00007f1c6ce15af0
RBP: 0000000020000140 R08: 00007f1c6ce15b30 R09: 00007f1c6ce15ad0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000014
R13: 0000000000000000 R14: 00000000004d3fb8 R15: 0000000000000048
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 3d34f3558efcb4e7 ]---
RIP: 0010:reiserfs_write_unlock+0xeb/0x110 fs/reiserfs/lock.c:44
Code: 5d c3 e8 88 42 76 ff 48 8d 7b 28 48 c7 83 a8 00 00 00 00 00 00 00 e8  
c4 b8 96 05 e8 6f 42 76 ff 5b 41 5c 5d c3 e8 65 42 76 ff <0f> 0b e8 fe c2  
b4 ff eb a1 e8 17 c3 b4 ff e9 33 ff ff ff e8 0d c3
RSP: 0018:ffff8801956e77e0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8801ba2e16c0 RCX: ffffc9000b8a9000
RDX: 0000000000040000 RSI: ffffffff8206390b RDI: ffff8801ba2e1768
RBP: ffff8801956e77f0 R08: ffffed0032adcf25 R09: 0000000000000000
R10: fffffbfff11f1224 R11: ffffffff88f89123 R12: ffff8801956e7ac8
R13: ffffed0032adcf3d R14: ffffed0032adcf2d R15: ffff8801c9f20800
FS:  00007f1c6ce16700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c2643 CR3: 00000001cda4f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
