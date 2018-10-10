Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DF3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09E0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09E0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJJWgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:36:42 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:34525 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJJWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:36:41 -0400
Received: by mail-it1-f197.google.com with SMTP id p20-v6so11848116itg.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1HE0qkXkRanxJ5fwvDZV3ex2VHzD88otVS4reRrxv+Q=;
        b=Q/I5M5cI5Ay26ldY7B1OXnPV7Va97vlpXulrCH8L6MLG1EAxhgydJTZ7jO6gSGAFA6
         1UdTrqnUI/bIagRQsJzsPcrAVJfmTOn923M38WwBbYcaM4rL8zsYcw/MsdUfoWv0uxaJ
         tshBKEn/3qCicESAm6JAJMPGzfLkhucp2sURnjaSnfJH4XX9FhhbKPdNJRkvzkeOYFbA
         l/OwKMg8YfB7V40BEw2veOIUgtfK0Oo49An2LYJ8It9ujXvV1ZrDAvmOMFsZaUubJTn3
         A2H7LGHzdLilaykCBQ2FTSvX6oWQQeECOAh3DWc0QyS96Wq4KB84u8YggBb0B78KUqdJ
         OfpA==
X-Gm-Message-State: ABuFfojRUGCJlxktx6NOBBddFFqp23TlYjPls0KATgLPguAbgbkvQ+J/
        3IADE1Q5k1nH/sovVYTrYG8EW8OmdCUMiR/46m0CLsaNQGLJ
X-Google-Smtp-Source: ACcGV61hu6PywfdJ2TbI7B2/Ey8GsqScO6GYRtFx8aJiQlsbdRSvIt9h3EWmC3V280hl+l0q8udKrAiMrRtCTXncuuG8gIS5HATu
MIME-Version: 1.0
X-Received: by 2002:a6b:3bc8:: with SMTP id i191-v6mr23058934ioa.32.1539184443865;
 Wed, 10 Oct 2018 08:14:03 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:14:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000542c10577e14e22@google.com>
Subject: kernel BUG at arch/x86/mm/physaddr.c:LINE!
From:   syzbot <syzbot+ff03fe05c717b82502d0@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0854ba5ff5c9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e64ea1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=ff03fe05c717b82502d0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e516a1400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d6e93a400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ff03fe05c717b82502d0@syzkaller.appspotmail.com

RBP: 00007ffc881226c0 R08: 0000000020000100 R09: 0000000000000100
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
overlayfs: failed to verify origin (syzkaller.Ry8w8Y/file0, ino=16483,  
err=-12)
------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:22!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5918 Comm: syz-executor189 Not tainted 4.19.0-rc7+ #53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__phys_addr+0xff/0x120 arch/x86/mm/physaddr.c:22
Code: 3c 02 00 75 31 4c 8b 25 ff c3 ee 07 48 89 de bf ff ff ff 1f e8 a2 7a  
46 00 49 01 dc 48 81 fb ff ff ff 1f 76 a7 e8 61 79 46 00 <0f> 0b e8 6a e9  
89 00 e9 7a ff ff ff e8 c0 e9 89 00 eb c8 0f 1f 40
RSP: 0018:ffff8801c3387770 EFLAGS: 00010093
RAX: ffff8801c323a080 RBX: 000000007ffffff4 RCX: ffffffff81385c1e
RDX: 0000000000000000 RSI: ffffffff81385c2f RDI: 0000000000000007
RBP: ffff8801c3387788 R08: ffff8801c323a080 R09: ffffed003b5c4fe8
R10: ffffed003b5c4fe8 R11: ffff8801dae27f47 R12: 000000007ffffff4
R13: 0000000000000001 R14: ffffffff882f8c80 R15: 0000000000004063
FS:  000000000148d880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000619570 CR3: 00000001c4ab0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  virt_to_head_page include/linux/mm.h:658 [inline]
  virt_to_cache mm/slab.c:399 [inline]
  kfree+0x7b/0x230 mm/slab.c:3809
  ovl_verify_set_fh+0xba/0x180 fs/overlayfs/namei.c:435
  ovl_verify_origin fs/overlayfs/overlayfs.h:316 [inline]
  ovl_get_indexdir fs/overlayfs/super.c:1139 [inline]
  ovl_fill_super+0x3026/0x3f7b fs/overlayfs/super.c:1441
  mount_nodev+0x6b/0x110 fs/super.c:1204
  ovl_mount+0x2c/0x40 fs/overlayfs/super.c:1518
  mount_fs+0xae/0x31d fs/super.c:1261
  vfs_kern_mount.part.35+0xdc/0x4f0 fs/namespace.c:961
  vfs_kern_mount fs/namespace.c:951 [inline]
  do_new_mount fs/namespace.c:2457 [inline]
  do_mount+0x581/0x31f0 fs/namespace.c:2787
  ksys_mount+0x12d/0x140 fs/namespace.c:3003
  __do_sys_mount fs/namespace.c:3017 [inline]
  __se_sys_mount fs/namespace.c:3014 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3014
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4418e9
Code: 26 02 00 85 c0 b8 00 00 00 00 48 0f 44 c3 5b c3 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc88122678 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004418e9
RDX: 00000000200000c0 RSI: 0000000020000000 RDI: 0000000000400000
RBP: 00007ffc881226c0 R08: 0000000020000100 R09: 0000000000000100
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 25e838f694c8a24f ]---
RIP: 0010:__phys_addr+0xff/0x120 arch/x86/mm/physaddr.c:22
Code: 3c 02 00 75 31 4c 8b 25 ff c3 ee 07 48 89 de bf ff ff ff 1f e8 a2 7a  
46 00 49 01 dc 48 81 fb ff ff ff 1f 76 a7 e8 61 79 46 00 <0f> 0b e8 6a e9  
89 00 e9 7a ff ff ff e8 c0 e9 89 00 eb c8 0f 1f 40
RSP: 0018:ffff8801c3387770 EFLAGS: 00010093
RAX: ffff8801c323a080 RBX: 000000007ffffff4 RCX: ffffffff81385c1e
RDX: 0000000000000000 RSI: ffffffff81385c2f RDI: 0000000000000007
RBP: ffff8801c3387788 R08: ffff8801c323a080 R09: ffffed003b5c4fe8
R10: ffffed003b5c4fe8 R11: ffff8801dae27f47 R12: 000000007ffffff4
R13: 0000000000000001 R14: ffffffff882f8c80 R15: 0000000000004063
FS:  000000000148d880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000619570 CR3: 00000001c4ab0000 CR4: 00000000001406f0
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
