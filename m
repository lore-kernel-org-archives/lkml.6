Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AE9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C2720881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C2720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeGJTTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:19:30 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:40999 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732620AbeGJTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:19:29 -0400
Received: by mail-it0-f70.google.com with SMTP id h26-v6so98383itj.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Uy0H9RDLnISO8wgzzMR7U91yOFyinPkkNszQpObd6oE=;
        b=kEIHM7uJ+x2YZAvcj12kmesH9O5XbQe6hL2ancFMgUB2w5FQ4QfmxOWPnqhdDZBCA5
         MEZH7+WtxzRcRUNULpUpVTBc6jjRqzx2l6KbxFNfzzp6rTXxPcScAOP/+s0OhwOOLdSZ
         f/aYj+WyoiKqOEsbHlmpZxOQ0WpepWveLHadUNzZFZu+FTOn47McyYvgxYnSI3jaXy6m
         0n5BxuixFeVoU5HJAKOtFB/i8mLPxo/Xw/Vu+sPugFvNVr41Q0HPELsuAhtyLC0jsbkX
         xWYKAVk2ptbXzuVr5cMaXoTbB/+BdWrqNC0g34mUzjraHzqgBC9JVI/EuPRluCbxiDl3
         nw1Q==
X-Gm-Message-State: APt69E0wrMVQDisuwROQFO9S+IlX3HdfGv5W1oIs4An0OG8AHGX28kwE
        xXlwEpNG9+hznSmmE52dEityBlfMs0jrqjRsjcXe7S5r/szD
X-Google-Smtp-Source: AAOMgpeSrwNAfnpSPoajFcupU500B5wJowAfAch1oQpglNBs2xb+Yrr6X3jDPbxmwHl3UPxmDlIdM+dLHiLCRL7IGGesWoggIs34
MIME-Version: 1.0
X-Received: by 2002:a24:7b0e:: with SMTP id q14-v6mr10913314itc.44.1531250343029;
 Tue, 10 Jul 2018 12:19:03 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:19:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c242e90570aa0062@google.com>
Subject: general protection fault in in_aton
From:   syzbot <syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bart.vanassche@wdc.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    092150a25cb7 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1687b168400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=2a831e062bb4aebd8755
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=158cc2c2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e7ef48400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4524 Comm: syz-executor617 Not tainted 4.18.0-rc4+ #42
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:in_aton+0x3e/0x180 net/core/utils.c:63
Code: f6 41 55 41 54 49 89 fc 53 48 83 ec 08 c7 45 d4 00 00 00 00 e8 a3 a5  
7c fb 4c 89 e0 4c 89 e2 c1 65 d4 08 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38  
38 d0 7f 08 84 c0 0f 85 1a 01 00 00 41 0f be 1c 24
RSP: 0018:ffff8801a8f171a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801acc613a4 RCX: ffffffff87685d49
RDX: 0000000000000000 RSI: ffffffff85ff65fd RDI: 0000000000000000
RBP: ffff8801a8f171d0 R08: ffff8801ac928040 R09: ffffed00351e2df9
R10: ffffed00351e2df9 R11: 0000000000000003 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:000000000961b840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000140 CR3: 00000001ac93c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  rdma_create_trans+0xdbe/0x1ed0 net/9p/trans_rdma.c:678
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
RIP: 0023:0xf7f65cb9
Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b  
5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffb9d3bc EFLAGS: 00000282 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000200000c0
RDX: 0000000020000340 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 5db7de5a7d39bf0a ]---
RIP: 0010:in_aton+0x3e/0x180 net/core/utils.c:63
Code: f6 41 55 41 54 49 89 fc 53 48 83 ec 08 c7 45 d4 00 00 00 00 e8 a3 a5  
7c fb 4c 89 e0 4c 89 e2 c1 65 d4 08 48 c1 e8 03 83 e2 07 <42> 0f b6 04 38  
38 d0 7f 08 84 c0 0f 85 1a 01 00 00 41 0f be 1c 24
RSP: 0018:ffff8801a8f171a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8801acc613a4 RCX: ffffffff87685d49
RDX: 0000000000000000 RSI: ffffffff85ff65fd RDI: 0000000000000000
RBP: ffff8801a8f171d0 R08: ffff8801ac928040 R09: ffffed00351e2df9
R10: ffffed00351e2df9 R11: 0000000000000003 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:000000000961b840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000140 CR3: 00000001ac93c000 CR4: 00000000001406f0
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
