Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E1C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB9821019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfAWH1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:27:04 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:39991 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:27:04 -0500
Received: by mail-io1-f71.google.com with SMTP id u2so1076365iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 23:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4/MjMX/4I48x2L/lvKx7dWPF8jb+uYKo6Jn5sVc8mp4=;
        b=cHspEH8UlJr/BI86Hd12JlLxe6T+gFwZ05JK4Ks/AFS3nZUU60teBvxdsC/OKP9U15
         9vpIaYG4Bc0yo9fzaMVKd1ZqJHj1eIqgewWH7SBvhT67r/RZgG3J9mxBA98I3HhJoePp
         TwlEBVW3yy4vLY9lx5OQVSr0E+bSM1OmTmxzr9okIfKdwfnNLUpH0OX8iRACWqjrv5sQ
         AAGlG/ptuN1OuWo90jhIMhk54UPz+u0XG5nHyW04lzienYzgiyDi1fod/I77p78kdhOP
         STGwYf04vsbVUlnvXJv+7CKHajN6P2GepPzvmqYZjaW/YPtKEmUz28tDoBZBygSR2t1k
         iwtQ==
X-Gm-Message-State: AJcUukeunnovLIMk+2geAnfvScwcMISkqLbi9AcIH486MoHJFLXcaaT/
        929Lq9CAC4cFahB+aEUhFQee8Wxg0+q7Dl2tDANjUoYLHix8
X-Google-Smtp-Source: ALg8bN6D7DuZy8r06y0wtA5J1KMm4bayYYfSxo/iII5msQDq/tmk3DWbP/iIX7juXRMBZSj0666efq9zA8RM5jHIABed2Dr+vVDF
MIME-Version: 1.0
X-Received: by 2002:a24:e81:: with SMTP id 123mr427907ite.22.1548228423305;
 Tue, 22 Jan 2019 23:27:03 -0800 (PST)
Date:   Tue, 22 Jan 2019 23:27:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033d5e205801b05d3@google.com>
Subject: general protection fault in rxrpc_connect_call
From:   syzbot <syzbot+7966f2a0b2c7da8939b4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    787a3b432276 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104f80c0c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
dashboard link: https://syzkaller.appspot.com/bug?extid=7966f2a0b2c7da8939b4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dc0930c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f3766b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7966f2a0b2c7da8939b4@syzkaller.appspotmail.com

audit: type=1800 audit(1548224295.427:29): pid=7748 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rc.local" dev="sda1" ino=2432 res=0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7899 Comm: syz-executor751 Not tainted 5.0.0-rc3+ #39
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rxrpc_connect_call+0x1a3/0x5130 net/rxrpc/conn_client.c:690
Code: fa 4c 89 f0 48 c1 e8 03 80 3c 18 00 0f 85 01 46 00 00 48 b8 00 00 00  
00 00 fc ff df 49 8b 1e 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 07 46 00 00 48 8b 5b 18 48 8d bb f0 01 00 00 48
RSP: 0018:ffff88808889ee90 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88808ca0596c
RDX: 0000000000000003 RSI: ffffffff873650fa RDI: 0000000000000018
RBP: ffff88808889f3a8 R08: 00000000006000c0 R09: ffff8880a9620d20
R10: ffff8880a9620480 R11: 0000000000000000 R12: ffff8880a9177b40
R13: ffff88809a470160 R14: ffff88808889f6c8 R15: ffff8880a9177cc8
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:0000000008b34840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000090872000 CR4: 00000000001406f0
Call Trace:
  rxrpc_new_client_call+0xb0b/0x1e50 net/rxrpc/call_object.c:291
  rxrpc_new_client_call_for_sendmsg net/rxrpc/sendmsg.c:593 [inline]
  rxrpc_do_sendmsg+0x16df/0x27ad net/rxrpc/sendmsg.c:649
  rxrpc_sendmsg+0x4b8/0x5f0 net/rxrpc/af_rxrpc.c:556
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x409/0x910 net/socket.c:2116
  __sys_sendmmsg+0x3bc/0x730 net/socket.c:2204
  __compat_sys_sendmmsg net/compat.c:771 [inline]
  __do_compat_sys_sendmmsg net/compat.c:778 [inline]
  __se_compat_sys_sendmmsg net/compat.c:775 [inline]
  __ia32_compat_sys_sendmmsg+0x9f/0x100 net/compat.c:775
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x333/0xf98 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f17869
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ff96366c EFLAGS: 00000217 ORIG_RAX: 0000000000000159
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000020005c00
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000020000040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 32887e7d2c420b9a ]---
RIP: 0010:rxrpc_connect_call+0x1a3/0x5130 net/rxrpc/conn_client.c:690
Code: fa 4c 89 f0 48 c1 e8 03 80 3c 18 00 0f 85 01 46 00 00 48 b8 00 00 00  
00 00 fc ff df 49 8b 1e 48 8d 7b 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 07 46 00 00 48 8b 5b 18 48 8d bb f0 01 00 00 48
RSP: 0018:ffff88808889ee90 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88808ca0596c
RDX: 0000000000000003 RSI: ffffffff873650fa RDI: 0000000000000018
RBP: ffff88808889f3a8 R08: 00000000006000c0 R09: ffff8880a9620d20
R10: ffff8880a9620480 R11: 0000000000000000 R12: ffff8880a9177b40
R13: ffff88809a470160 R14: ffff88808889f6c8 R15: ffff8880a9177cc8
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:0000000008b34840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000090872000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
