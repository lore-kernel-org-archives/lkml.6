Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80FEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902392089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902392089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbeGJTTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:19:30 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:52842 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732618AbeGJTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:19:29 -0400
Received: by mail-io0-f199.google.com with SMTP id y26-v6so19198505iob.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jAWpfc/rAjZPqe0XjzYdyieGZAZfM+nJmDz6s79thN4=;
        b=Cz0Cx5plqqCDcMu01Nq+ay1P/ei21Ns3ANmDOYQWaPK6i0vjnuYhVECEP8edoTNzES
         Hknz0DTYgUsNfPSKxUxci9KTQWugrWjRy1gkjlDaiwqApxPPu4dyAvSnXp0BfcuRuoED
         0yNA3cvAD/qb1MFzTu092ovGiFX7qpYKcYbEMSHUMtNJU75KGeY+wamsTjSU+G0djWK0
         Q8FrZx9m6fihBnBczcn1vzD7DMqiTaJ+Cx0uZnRhBG68HXMohk+vZM9fTRoE8Ard4Xa0
         jBFYmyVm0LYBILlO6MU8Q6RgwUEbmspE7LzjxbRoJHfHZgiKPF/dJnscCZWko8a+1VgW
         n8Aw==
X-Gm-Message-State: APt69E0YE2rbs4tODWufv4bviILhUpyxhKTIwrV7msMcD3zQg7uLPfnZ
        DNHrRcLm7ZE9exnFbQlBb4nJtnZu2sUCNJ1UJxbxU9Fv6GTX
X-Google-Smtp-Source: AAOMgpeOouh2hGsMtRTfEkqO+SlRVWJ/2Exx+QIA2BHksIYtEe49kSKf7Zu03CZvbsmrXSGtVoF3OkIDyIeE/QAB+YVyaYT1rBt4
MIME-Version: 1.0
X-Received: by 2002:a24:9195:: with SMTP id i143-v6mr11110520ite.52.1531250342822;
 Tue, 10 Jul 2018 12:19:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:19:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf0d390570aa008d@google.com>
Subject: general protection fault in vsscanf
From:   syzbot <syzbot+0ec640a6eebcf1c82417@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    092150a25cb7 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1260ef34400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=0ec640a6eebcf1c82417
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=14c2f50c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fe4c58400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0ec640a6eebcf1c82417@syzkaller.appspotmail.com

9pnet: p9_fd_create_tcp (4481): problem connecting socket to 127.0.0.1
9pnet: p9_fd_create_tcp (4506): problem connecting socket to 127.0.0.1
kasan: CONFIG_KASAN_INLINE enabled
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
kasan: GPF could be caused by NULL-ptr deref or user memory access
CPU: 1 PID: 4502 Comm: syz-executor518 Not tainted 4.18.0-rc4+ #42
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vsscanf+0x3c1/0x2af0 lib/vsprintf.c:2966
Code: f9 44 89 ee bf 6e 00 00 00 e8 5b 82 eb f9 41 80 fd 6e 0f 84 ce 02 00  
00 e8 7c 81 eb f9 4c 89 f0 4c 89 f2 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38  
38 d0 7f 08 84 c0 0f 85 e8 1c 00 00 45 0f b6 26 31
RSP: 0018:ffff8801bf93f0a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff888364c1 RCX: ffffffff87908a15
RDX: 0000000000000000 RSI: ffffffff87908a24 RDI: 0000000000000001
RBP: ffff8801bf93f270 R08: ffff8801b5e9a140 R09: ffff8801bf93f464
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff888364c1
R13: 0000000000000064 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0063) knlGS:00000000f7efcb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7f3dcc4 CR3: 00000001b6883000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sscanf+0xab/0xe0 lib/vsprintf.c:3172
  valid_ipaddr4 net/9p/trans_fd.c:903 [inline]
  p9_fd_create_tcp+0x113/0x8a0 net/9p/trans_fd.c:943
  p9_client_create+0x915/0x16c9 net/9p/client.c:1062
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
  __do_compat_sys_mount fs/compat.c:125 [inline]
  __se_compat_sys_mount fs/compat.c:92 [inline]
  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f42cb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7efc1ec EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000200000c0
RDX: 0000000020000340 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
general protection fault: 0000 [#2] SMP KASAN
---[ end trace 603612217fadf6c1 ]---
CPU: 0 PID: 4504 Comm: syz-executor518 Tainted: G      D            
4.18.0-rc4+ #42
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vsscanf+0x3c1/0x2af0 lib/vsprintf.c:2966
RIP: 0010:vsscanf+0x3c1/0x2af0 lib/vsprintf.c:2966
Code: f9 44 89 ee bf 6e 00 00 00 e8
Code:
5b 82 eb f9 41 80
f9
fd 6e 0f 84 ce 02
44
00 00 e8 7c 81 eb
89
f9 4c 89 f0 4c 89
ee
f2 48 c1 e8 03 83
bf
e2 07 <42> 0f b6 04
6e
38 38 d0 7f 08 84
00
c0 0f 85 e8 1c 00 00
00
45 0f b6 26 31
RSP: 0018:ffff8801af7ff0a0 EFLAGS: 00010246
00
RAX: 0000000000000000 RBX: ffffffff888364c1 RCX: ffffffff87908a15
RDX: 0000000000000000 RSI: ffffffff87908a24 RDI: 0000000000000001
RBP: ffff8801af7ff270 R08: ffff8801b5e2a1c0 R09: ffff8801af7ff464
e8
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff888364c1
R13: 0000000000000064 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000f7efcb40
5b
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000008090b10 CR3: 00000001b5f70000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
82
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
eb
f9
41
80
  sscanf+0xab/0xe0 lib/vsprintf.c:3172
fd
6e
  valid_ipaddr4 net/9p/trans_fd.c:903 [inline]
  p9_fd_create_tcp+0x113/0x8a0 net/9p/trans_fd.c:943
0f
84
ce
02
  p9_client_create+0x915/0x16c9 net/9p/client.c:1062
00
00
e8
7c
81
eb
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
f9
4c
89
f0
4c
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  mount_fs+0xae/0x328 fs/super.c:1277
89
  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
f2
48
  vfs_kern_mount fs/namespace.c:1027 [inline]
  do_new_mount fs/namespace.c:2518 [inline]
  do_mount+0x581/0x30e0 fs/namespace.c:2848
c1
e8
03
83
  __do_compat_sys_mount fs/compat.c:125 [inline]
  __se_compat_sys_mount fs/compat.c:92 [inline]
  __ia32_compat_sys_mount+0x5d5/0x860 fs/compat.c:92
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
e2
07
<42>
0f
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
b6
RIP: 0023:0xf7f42cb9
Code: 55 08
04
8b 88 64 cd ff ff
38
8b 98 68 cd ff ff 89
38
c8 85 d2 74 02 89 0a
d0
5b 5d c3 8b 04 24
7f
c3 8b 1c 24 c3 51 52
08
55 89 e5 0f 34 cd
84
80 <5d> 5a 59 c3 90 90
c0
90 90 eb 0d 90 90 90
0f
90 90 90 90 90 90
85
90 90 90
RSP: 002b:00000000f7efc1ec EFLAGS: 00000296 ORIG_RAX: 0000000000000015
e8
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000200000c0
RDX: 0000000020000340 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
1c
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
00
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 603612217fadf6c2 ]---
00
RIP: 0010:vsscanf+0x3c1/0x2af0 lib/vsprintf.c:2966
Code:
45
f9 44 89 ee bf
0f
6e 00
b6
00 00
26
e8
31
5b 82
eb f9
RSP: 0018:ffff8801bf93f0a0 EFLAGS: 00010246
41 80
fd 6e
RAX: 0000000000000000 RBX: ffffffff888364c1 RCX: ffffffff87908a15
0f 84
RDX: 0000000000000000 RSI: ffffffff87908a24 RDI: 0000000000000001
ce 02
RBP: ffff8801bf93f270 R08: ffff8801b5e9a140 R09: ffff8801bf93f464
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff888364c1
00 00
R13: 0000000000000064 R14: 0000000000000000 R15: dffffc0000000000
e8 7c
FS:  0000000000000000(0000) GS:ffff8801daf00000(0063) knlGS:00000000f7efcb40
81 eb
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
f9 4c
CR2: 00000000f7f3dcc4 CR3: 00000001b6883000 CR4: 00000000001406e0
89 f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
4c 89
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
f2 48


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
