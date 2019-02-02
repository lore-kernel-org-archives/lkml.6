Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD9BC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 19:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AAA2082C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 19:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfBBTQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 14:16:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:54768 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfBBTQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 14:16:04 -0500
Received: by mail-io1-f72.google.com with SMTP id f24so8860885ioh.21
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 11:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2lmptCo6j1cG4xx3M8up8GNqcP+SV7W0ChxMzpzUC/M=;
        b=mg5ZZplHLs2etLhNPkz7XsRSxwD2OHOn87ZMNxQTHFWpMsIeCXqo6Vp3LE/j1cHi8p
         KqThgCaLK+Yf1iu90DOeovAjheYa9zV9eTO2+GxH0pM4NKAT6Jws/kn7PlmqA86JcqTb
         nHGQpjOUhMfIHNEMY+2hoCgwK6l5jC8Gce3Sxq9ceJYyWTUb7u0QfoziMHPP5jpuHCbn
         QE9S/Uvg6ssIYFqS9cAOouKJtp6TglWINrHk2o/joljP13wcUrIJPnA3yOM/7Ac5MRQk
         f23DcS/ZnnuOinKA/dBPMpqcYzWQelmHqn4m0I/NBLxoAL23Wf066ycOpZX2Rz5eyEMC
         ketg==
X-Gm-Message-State: AHQUAuZaFSgW0dQsb5qLx3De18Sw9g9ME+q1m7y5WFogQwjAM30qAask
        fOxlZpGwiASJulISuQgJSkVl1nJnE1UmMfYyoNHYD1Yi1RYQ
X-Google-Smtp-Source: AHgI3IYNBiJaCHqESPsOaRE3Mvklb1UZHHuN7t1fRwppx//cAJjMKM/D4cb7AOIRSIO4u6HPhUHSuQ2+9QEiv0snM8a2aefgIVSG
MIME-Version: 1.0
X-Received: by 2002:a24:a94:: with SMTP id 142mr9379473itw.15.1549134963404;
 Sat, 02 Feb 2019 11:16:03 -0800 (PST)
Date:   Sat, 02 Feb 2019 11:16:03 -0800
In-Reply-To: <000000000000445dd9057a7149f1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033f8b60580ee1718@google.com>
Subject: Re: general protection fault in rds_recv_rcvbuf_delta
From:   syzbot <syzbot+4b4f8163c2e246df3c4c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    cd984a5be215 Merge tag 'xtensa-20190201' of git://github.c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1725e4ff400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e0064f906afee10
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f8163c2e246df3c4c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11631328c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1172c7ef400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b4f8163c2e246df3c4c@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8054 Comm: syz-executor390 Not tainted 5.0.0-rc4+ #56
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rds_recv_rcvbuf_delta.part.0+0x14a/0x3f0 net/rds/recv.c:103
Code: c1 ea 03 80 3c 02 00 0f 85 6e 02 00 00 4c 8b a3 c0 04 00 00 48 b8 00  
00 00 00 00 fc ff df 49 8d 7c 24 2c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 00
RSP: 0018:ffff88808fd9f670 EFLAGS: 00010007
RAX: dffffc0000000000 RBX: ffff8880a96a97c0 RCX: ffffffff8681f5bd
RDX: 0000000000000005 RSI: ffffffff8681f5cb RDI: 000000000000002c
RBP: ffff88808fd9f6a8 R08: ffff888086a1a000 R09: ffffed1011fb3ec4
R10: ffffed1011fb3ec3 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8880a96a9ce4 R14: 000000000002e400 R15: ffff88809aeecc00
FS:  00000000026d4940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000424ec0 CR3: 000000008e163000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  rds_recv_rcvbuf_delta net/rds/recv.c:379 [inline]
  rds_recv_incoming+0x789/0x11f0 net/rds/recv.c:379
  rds_loop_xmit+0xf3/0x2a0 net/rds/loop.c:96
  rds_send_xmit+0x1113/0x2560 net/rds/send.c:355
  rds_sendmsg+0x280a/0x3450 net/rds/send.c:1368
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:631
  ___sys_sendmsg+0x806/0x930 net/socket.c:2116
  __sys_sendmsg+0x105/0x1d0 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4487e9
Code: e8 4c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab c5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffa307f188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004487e9
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000004
RBP: 000000000000c806 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004ab4b0
R13: 00000000004052b0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace e9dbe4e38be82e2e ]---
RIP: 0010:rds_recv_rcvbuf_delta.part.0+0x14a/0x3f0 net/rds/recv.c:103
Code: c1 ea 03 80 3c 02 00 0f 85 6e 02 00 00 4c 8b a3 c0 04 00 00 48 b8 00  
00 00 00 00 fc ff df 49 8d 7c 24 2c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 00
RSP: 0018:ffff88808fd9f670 EFLAGS: 00010007
RAX: dffffc0000000000 RBX: ffff8880a96a97c0 RCX: ffffffff8681f5bd
RDX: 0000000000000005 RSI: ffffffff8681f5cb RDI: 000000000000002c
RBP: ffff88808fd9f6a8 R08: ffff888086a1a000 R09: ffffed1011fb3ec4
R10: ffffed1011fb3ec3 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8880a96a9ce4 R14: 000000000002e400 R15: ffff88809aeecc00
FS:  00000000026d4940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000424ec0 CR3: 000000008e163000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

