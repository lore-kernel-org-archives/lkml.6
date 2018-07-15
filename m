Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE10520870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE10520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeGOJBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:01:12 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:52127 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeGOJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:01:12 -0400
Received: by mail-io0-f198.google.com with SMTP id w23-v6so22282744iob.18
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 01:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rVgg6NNFzNQZXJVBG4B9YK9PY7dZ6/WqhOON47sXuj0=;
        b=QRtB7kDFEKkRCMDPCZs6gjAXWZzSz3Oy69dVBBTeZq02Raw/0FNvbe/dI7l7vbcK4E
         bHffTS/LsU8NNPc1DSuxADv7ZM+N0IxrcWU3/XF4w5BF8tnUg/L1KpCyXVoPaUjP2yxa
         kTfMC/LWUR0oxToZnnJhC3P90BK3Er7ND652tOnJljKb12Kd3uKYYxGG9ANYxizyIJ1k
         FkW/hr3xtixkpVjsCJm/3XdujPIfUafcuiuXPwwoEUncIJYzDPYircqQpenaec5XJwqI
         nyYigGAD4XsAbey4M7X5NONRkmjGCtLvKs328qhjaKPPwusPNUPgvEDX4tW26r0JEy0N
         MwIQ==
X-Gm-Message-State: AOUpUlG67SD57B4VNuJhHYO5rPmNdM6HsmX86OMZnVY+pO8mSCOJ/i4w
        6poI+BuYx2iQmLQy5DKVqecNIQtgt0SPiP/IbmqHWsqjE5Vz
X-Google-Smtp-Source: AAOMgpe989fSiBM8AESOLv1HWvGZ3avKa4CNy51+YYC2ft7Zvq4XUj/iQa6Maf4WpH7iksfvmbPT/0c3DDN2tNSqwj05XkNXfhMK
MIME-Version: 1.0
X-Received: by 2002:a24:d11:: with SMTP id 17-v6mr5247844itx.3.1531643942153;
 Sun, 15 Jul 2018 01:39:02 -0700 (PDT)
Date:   Sun, 15 Jul 2018 01:39:02 -0700
In-Reply-To: <00000000000054fd6b0570be9fa8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000183859057105a5b7@google.com>
Subject: Re: general protection fault in bpf_tcp_close (2)
From:   syzbot <syzbot+339037020e772651f1d8@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    13f7432bdd8e Merge branch 'bpf-tcp-listen-cb'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d6a9a4400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=339037020e772651f1d8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1647db68400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a04d1c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+339037020e772651f1d8@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4474 Comm: syz-executor715 Not tainted 4.18.0-rc3+ #55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__hlist_del include/linux/list.h:679 [inline]
RIP: 0010:hlist_del_rcu include/linux/rculist.h:440 [inline]
RIP: 0010:bpf_tcp_close+0x94c/0x1050 kernel/bpf/sockmap.c:365
Code: 85 25 06 00 00 48 8d 95 18 ff ff ff 49 8b 4c 24 18 48 89 d6 48 c1 ee  
03 c6 04 1e 00 48 89 ce 48 c1 ee 03 48 89 85 18 ff ff ff <80> 3c 1e 00 0f  
85 bf 05 00 00 48 c1 ea 03 48 85 c0 48 89 01 48 89
RSP: 0018:ffff8801c5da7950 EFLAGS: 00010a02
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: dead000000000200
RDX: ffff8801c5da7a40 RSI: 1bd5a00000000040 RDI: ffff8801d3175790
RBP: ffff8801c5da7b28 R08: ffff8801b3c50540 R09: ffffed003a62eb11
R10: ffffed003a62eb11 R11: ffff8801d317588b R12: ffff8801d3175780
R13: ffff8801aad5d800 R14: ffff8801d3175888 R15: ffff8801d3175798
FS:  00000000018e5880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b79d7fe78 CR3: 00000001aba3d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
  __sock_release+0xd7/0x260 net/socket.c:599
  sock_close+0x19/0x20 net/socket.c:1150
  __fput+0x355/0x8b0 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x405781
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 54 17 00 00 c3 48  
83 ec 08 e8 6a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 b3 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff3d5e3680 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000405781
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000006b70
R13: 00000000004073d0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 24c47acbb9ad1d76 ]---
RIP: 0010:__hlist_del include/linux/list.h:679 [inline]
RIP: 0010:hlist_del_rcu include/linux/rculist.h:440 [inline]
RIP: 0010:bpf_tcp_close+0x94c/0x1050 kernel/bpf/sockmap.c:365
Code: 85 25 06 00 00 48 8d 95 18 ff ff ff 49 8b 4c 24 18 48 89 d6 48 c1 ee  
03 c6 04 1e 00 48 89 ce 48 c1 ee 03 48 89 85 18 ff ff ff <80> 3c 1e 00 0f  
85 bf 05 00 00 48 c1 ea 03 48 85 c0 48 89 01 48 89
RSP: 0018:ffff8801c5da7950 EFLAGS: 00010a02
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: dead000000000200
RDX: ffff8801c5da7a40 RSI: 1bd5a00000000040 RDI: ffff8801d3175790
RBP: ffff8801c5da7b28 R08: ffff8801b3c50540 R09: ffffed003a62eb11
R10: ffffed003a62eb11 R11: ffff8801d317588b R12: ffff8801d3175780
R13: ffff8801aad5d800 R14: ffff8801d3175888 R15: ffff8801d3175798
FS:  00000000018e5880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b79d7fe78 CR3: 00000001aba3d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

