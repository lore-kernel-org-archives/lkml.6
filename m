Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B559C6778F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 01:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A82208B4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 01:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A82208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754469AbeGHB3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 21:29:05 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:50819 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754362AbeGHB3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 21:29:03 -0400
Received: by mail-io0-f199.google.com with SMTP id v2-v6so6734011ioh.17
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 18:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Edc642UtbfM/X0LF4Myno2MrPprhvr2uBZeEdaxAhLI=;
        b=uUxzaHFC/Vyzn+hrEeRV4lVSMVY0UgPsacAKRbeFQCe0GMQXeFGOZdFQh6AedUEN93
         7BhEDMGExuvGDuLUiY7DkR3zOYi5pia4G61hWwf2b750K8T0hQnfq0u8EXneYdaQ0+Gz
         Ef3fDj7hx1JMM8EJjAFJJGuAtOO9CdWTHnf6lDtOxgS6jlmVIGhC1V6F+/VVo7NoWbf2
         LpzBv7vsvKNPohHVqd2p8z6AZVq4xg4/LonpuS6HuQcGXFqvVFWk914uz65l1TjZG4fo
         cnDxbKAEA0DDEcCfUbycE0CzLN3pG+Aw9GGnmqoEjRdgZd1+Lm7uorQ+uFfargo+c2VA
         Of3g==
X-Gm-Message-State: AOUpUlEOr7SZVbIMkkfXxy48VrvNqqxrYzoCH8EdGLsSVj3AD1k1ZEBn
        GMh1wErJ0Y/bhSjQxvrZvlluBAVGOw1OEc+w44tWkHJDa+rQ
X-Google-Smtp-Source: AAOMgpcgz22bLVCwrD11PCzQcjcioi0ZcxBoI+PQIAXfAxsn15brDDwx2OlLwYKxxCUQ9pYgfxuEc8deMjE1DS8cXqkj8FOqWX1c
MIME-Version: 1.0
X-Received: by 2002:a6b:19c1:: with SMTP id 184-v6mr4997416ioz.66.1531013342872;
 Sat, 07 Jul 2018 18:29:02 -0700 (PDT)
Date:   Sat, 07 Jul 2018 18:29:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072ce39057072d272@google.com>
Subject: kernel BUG at fs/super.c:LINE!
From:   syzbot <syzbot+0977fcb74b8a12a967b8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1443b168400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=0977fcb74b8a12a967b8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=159481b2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142bca2c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0977fcb74b8a12a967b8@syzkaller.appspotmail.com

RBP: 0000000000000004 R08: 0000000020000180 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Filesystem sysfs get_tree() didn't set fc->root
------------[ cut here ]------------
kernel BUG at fs/super.c:1761!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 1 PID: 4470 Comm: syz-executor042 Not tainted  
4.18.0-rc3-next-20180706+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vfs_get_tree.cold.21+0x4f/0x60 fs/super.c:1756
Code: 37 00 48 c1 e0 2a 48 89 da 48 c1 ea 03 80 3c 02 00 74 08 48 89 df e8  
30 f0 f4 ff 48 8b 33 48 c7 c7 a0 5a f3 87 e8 05 36 9d ff <0f> 0b 4c 89 ef  
e8 17 f0 f4 ff eb c0 90 90 90 90 90 55 48 89 e5 53
RSP: 0018:ffff8801aac07be0 EFLAGS: 00010286
RAX: 000000000000002f RBX: ffffffff8906e5e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81634381 RDI: 0000000000000001
RBP: ffff8801aac07c10 R08: ffff8801a6cd6440 R09: ffffed003b5e4fc0
R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: 0000000000000000
R13: ffff8801bf72bdc8 R14: 0000000000000020 R15: ffff8801bf72bdd8
FS:  0000000001bf0880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b4f7c CR3: 00000001c4ae4000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_new_mount fs/namespace.c:2567 [inline]
  do_mount+0x6c1/0x1fb0 fs/namespace.c:2889
  ksys_mount+0x12d/0x140 fs/namespace.c:3105
  __do_sys_mount fs/namespace.c:3119 [inline]
  __se_sys_mount fs/namespace.c:3116 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3116
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440c89
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 10 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe59b66978 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe59b66990 RCX: 0000000000440c89
RDX: 0000000020000280 RSI: 00000000200000c0 RDI: 0000000020000000
RBP: 0000000000000004 R08: 0000000020000180 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: ffffffffffffffff R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 07cdba975902c41a ]---
RIP: 0010:vfs_get_tree.cold.21+0x4f/0x60 fs/super.c:1756
Code: 37 00 48 c1 e0 2a 48 89 da 48 c1 ea 03 80 3c 02 00 74 08 48 89 df e8  
30 f0 f4 ff 48 8b 33 48 c7 c7 a0 5a f3 87 e8 05 36 9d ff <0f> 0b 4c 89 ef  
e8 17 f0 f4 ff eb c0 90 90 90 90 90 55 48 89 e5 53
RSP: 0018:ffff8801aac07be0 EFLAGS: 00010286
RAX: 000000000000002f RBX: ffffffff8906e5e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81634381 RDI: 0000000000000001
RBP: ffff8801aac07c10 R08: ffff8801a6cd6440 R09: ffffed003b5e4fc0
R10: ffffed003b5e4fc0 R11: ffff8801daf27e07 R12: 0000000000000000
R13: ffff8801bf72bdc8 R14: 0000000000000020 R15: ffff8801bf72bdd8
FS:  0000000001bf0880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b4f7c CR3: 00000001c4ae4000 CR4: 00000000001406e0
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
