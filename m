Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7D4C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7F0224F4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7F0224F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeGGHJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:09:07 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:44272 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbeGGHJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:09:03 -0400
Received: by mail-io0-f199.google.com with SMTP id f12-v6so11308799iob.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qz/gu4OefQ0ME1m4xf8pUn3Qgbv1gLNeiJsBqdgjHeY=;
        b=neeM4LWSsfDevG8BsAZCIlPOteyf1G6kZGlo10A9b7tir4MEBPqyuf4/sWl8J4aHtF
         44uCBzLhJmlYJbGMTpPfqoDvJEytTsu5plBSj02PHICjFvI5KjG+PpolM/j0JAotQJju
         HakEdTvjt+Ns3R792nCOmNLAtfVeQTuFezAoCUOJhvVGQUKbWOOCxaUhxA1+sjxhAOXM
         cym1uUjC96um0/U6advtTFLgxjS5cGh/4SgVOXpsZWANmWpiddMQXDtYkzqhgGJsqVac
         xIt2cV3zD7HEU1NZxezKmX3+nrZs+m3kjTLXyyj6yO+bXcuUxs8qpF5AygxVkOdzrS7F
         9peQ==
X-Gm-Message-State: AOUpUlENRtF+a+OD+he/vktbizC/4kxOkyIhYxEqjvWtW8NQAco3Ly1+
        Lgv2BfYzRIsOV4dPX4PxHjhGqCpK9ewxMOJOeT/TssXH6S+N
X-Google-Smtp-Source: AAOMgpf8XZ3HDTQVOdZF3yxuYZAoXD9z/W1kEWRpLYK9JF9hWbur5jLoLcStU194vQbIG8R10WU1gfINC2A6sTxHKU9Km/GDF6jZ
MIME-Version: 1.0
X-Received: by 2002:a6b:c648:: with SMTP id w69-v6mr5489692iof.108.1530947342940;
 Sat, 07 Jul 2018 00:09:02 -0700 (PDT)
Date:   Sat, 07 Jul 2018 00:09:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bc6660570637414@google.com>
Subject: general protection fault in cgroup_reconfigure
From:   syzbot <syzbot+d4eb75e353a836d57809@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net,
        dhowells@redhat.com, guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    526674536360 Add linux-next specific files for 20180706
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b51a2c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
dashboard link: https://syzkaller.appspot.com/bug?extid=d4eb75e353a836d57809
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10ce2cc2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149cec58400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d4eb75e353a836d57809@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4415 Comm: syz-executor204 Not tainted  
4.18.0-rc3-next-20180706+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cgroup_reconfigure+0x25/0x80 kernel/cgroup/cgroup.c:1781
Code: 00 00 00 00 00 55 48 89 e5 53 48 89 f3 e8 f3 e9 08 00 48 8d bb 90 00  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
45 48 8b 9b 90 00 00 00 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffff8801acc1f9f8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c5edb2
RDX: 0000000000000012 RSI: ffffffff8173906d RDI: 0000000000000090
RBP: ffff8801acc1fa00 R08: ffff8801ad2e45c0 R09: fffffbfff11c24e5
R10: fffffbfff11c24e5 R11: ffffffff88e1272b R12: ffff8801d9a14940
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  00000000016f3880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001b24ea000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kernfs_sop_reconfigure+0xba/0x100 fs/kernfs/mount.c:31
  do_remount_sb+0x34f/0x850 fs/super.c:991
  do_umount fs/namespace.c:1467 [inline]
  ksys_umount+0xfa7/0x12f0 fs/namespace.c:1585
  __do_sys_umount fs/namespace.c:1596 [inline]
  __se_sys_umount fs/namespace.c:1594 [inline]
  __x64_sys_umount+0x54/0x80 fs/namespace.c:1594
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440059
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe8d0cd578 EFLAGS: 00000217 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440059
RDX: 0000000000440059 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004018e0
R13: 0000000000401970 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 2c2a1923aa2ae1cb ]---
RIP: 0010:cgroup_reconfigure+0x25/0x80 kernel/cgroup/cgroup.c:1781
Code: 00 00 00 00 00 55 48 89 e5 53 48 89 f3 e8 f3 e9 08 00 48 8d bb 90 00  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
45 48 8b 9b 90 00 00 00 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffff8801acc1f9f8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c5edb2
RDX: 0000000000000012 RSI: ffffffff8173906d RDI: 0000000000000090
RBP: ffff8801acc1fa00 R08: ffff8801ad2e45c0 R09: fffffbfff11c24e5
R10: fffffbfff11c24e5 R11: ffffffff88e1272b R12: ffff8801d9a14940
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  00000000016f3880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001b24ea000 CR4: 00000000001406e0
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
