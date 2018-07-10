Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B8CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21B22089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21B22089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933503AbeGJIJG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:09:06 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:34127 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933023AbeGJIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:09:03 -0400
Received: by mail-io0-f198.google.com with SMTP id w23-v6so18640952ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 01:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uFez49L01Bjgp0GGCu9r9Xf7WX39WJXNalW7LnQxALA=;
        b=ZGKLC3mTjlAIhPDJ8g6rthdkP2sSqiFiIQ1Yuac+vuxckJiVrrkv8ZoHjzMrpZV/OY
         i6qpvaIWHI2Ftowsmp1V/NyvuvVaz3lxTC8tZ/l4qllk1VkEOKT5bkUgQnVHW7N5q8p1
         x8Fm2JMjLu1fHwi3hH5M8NG37iURaMy4773YMxtm4M5CoGTqMSNL2xouF66c0vS0x0e7
         zqP/nX5ij6A1pPfNqK3MG9t3EiGSZSBc6X9Qvv/JNpZdV0TZxzGF0naZS11rKxMvFhNr
         sfV5df7VJwcJxqoX+bKQdYX4oQlJDodyJxAu7BK2ioQLkk+M5L3ITEUCg2dTumfWZod9
         0bjQ==
X-Gm-Message-State: APt69E1GZJKcX2h8BvzSqaUyWc/S59W1Gtt1pQBhflu71X/uVIqvig47
        Jq5qsksKBBv6J7ldE9nqo8su3Iz14myuYY2olLVByZeD3NsO
X-Google-Smtp-Source: AAOMgpd1l+0wsnZLen6oVIKxaSsbLv2P2kDFnCA6lmvMpGC05b2GNCuSfI55R1OmPxS7IkRBaVUgPbvrBCWg2pdgFP1TxFsSmS6b
MIME-Version: 1.0
X-Received: by 2002:a6b:3042:: with SMTP id w63-v6mr10353373iow.5.1531210142771;
 Tue, 10 Jul 2018 01:09:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 01:09:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2ef540570a0a42d@google.com>
Subject: general protection fault in p9_fd_create_unix
From:   syzbot <syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15f31a2c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=1a262da37d3bead15c39
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17492cc2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145aec58400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4527 Comm: syz-executor611 Not tainted 4.18.0-rc4+ #42
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:strlen+0x1f/0xa0 lib/string.c:479
Code: ff ff ff 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48  
89 fa 48 c1 ea 03 48 89 e5 41 54 49 89 fc 53 48 83 ec 08 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 4d 41 80 3c 24
RSP: 0018:ffff8801ad1d7398 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: 1ffff10035a3ae7b RCX: ffffffff8766d02b
RDX: 0000000000000000 RSI: ffffffff87679de2 RDI: 0000000000000000
RBP: ffff8801ad1d73b0 R08: ffff8801d9762200 R09: 0000000000000000
R10: ffffed003b5e46d6 R11: ffff8801daf236b3 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 1ffff10035a3aeb2
FS:  0000000000000000(0000) GS:ffff8801daf00000(0063) knlGS:0000000009aa8840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000200003c0 CR3: 00000001d96e0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  strlen include/linux/string.h:267 [inline]
  p9_fd_create_unix+0xbf/0x370 net/9p/trans_fd.c:993
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
RIP: 0023:0xf7f09cb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ff943bac EFLAGS: 00000286 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000200000c0
RDX: 0000000020000340 RSI: 0000000000000000 RDI: 00000000200006c0
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace fe903ba4024485fe ]---
RIP: 0010:strlen+0x1f/0xa0 lib/string.c:479
Code: ff ff ff 0f 1f 84 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 55 48  
89 fa 48 c1 ea 03 48 89 e5 41 54 49 89 fc 53 48 83 ec 08 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 04 84 c0 75 4d 41 80 3c 24
RSP: 0018:ffff8801ad1d7398 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: 1ffff10035a3ae7b RCX: ffffffff8766d02b
RDX: 0000000000000000 RSI: ffffffff87679de2 RDI: 0000000000000000
RBP: ffff8801ad1d73b0 R08: ffff8801d9762200 R09: 0000000000000000
R10: ffffed003b5e46d6 R11: ffff8801daf236b3 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 1ffff10035a3aeb2
FS:  0000000000000000(0000) GS:ffff8801daf00000(0063) knlGS:0000000009aa8840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000200003c0 CR3: 00000001d96e0000 CR4: 00000000001406e0
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
