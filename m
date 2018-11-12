Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75126C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459962175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459962175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbeKLPmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:42:43 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:38743 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeKLPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:42:43 -0500
Received: by mail-io1-f69.google.com with SMTP id w22-v6so9032793ioc.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EzVKpwb4ZKW36Y7v5QeV4348sSb4UnF4yUwmC9Zf7/A=;
        b=dZc3hhMnURb0KfA96VVWBvXmb/lIknnXJQvMRr52uUg75b1zp9imzpZ0xvntPG3qze
         fPtkGvwqbu1lASSC2dIhDlMpwSVTBLISwuNdLBwxbG6nRen0bgcir0IIoC+Qrzp5KBhr
         t+qMffZ/OlObKf7LAh0235/ExtfU5ZQdthYVazjY6ErA2s4wQXiaAjJay6jTyq01BkNX
         24vfBkOpxKxJxLW5LN/eN1SsIMiSv7z/tUg4VqApj962SYLmjTfOA1IbcxEY1EHcBDX4
         XxEd1R2UICBL+K3X7KIdTOeN6mACr7Ka1uae4SeMqhsCJ5Xs/7ZqJ+hHrbpola63phcL
         FM3g==
X-Gm-Message-State: AGRZ1gK2KCnrMbZcfvS4YgL5loHa4t5sn/i+rEHVB5Oz5QKKawSpCCOp
        bMq3UgDRf0m5f/Ds8Q5pRadw7aT4Ny1CU8pGVLXE5g9/Dve7
X-Google-Smtp-Source: AJdET5eyzvXYEK1nxPt/5WkKbln2n+tQ/dHEIZHHyki+/ReTN+kWTkWwG5yv/+U9KybPTK1AQGurEkB0CJ/Zzhxa0x1h+LIfzvBR
MIME-Version: 1.0
X-Received: by 2002:a24:d255:: with SMTP id z82-v6mr9399250itf.31.1542001862660;
 Sun, 11 Nov 2018 21:51:02 -0800 (PST)
Date:   Sun, 11 Nov 2018 21:51:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000445dd9057a7149f1@google.com>
Subject: general protection fault in rds_recv_rcvbuf_delta
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

Hello,

syzbot found the following crash on:

HEAD commit:    e255aee5b66c Merge tag 'tty-4.20-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124d66a3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f215f21f041a0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f8163c2e246df3c4c
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b4f8163c2e246df3c4c@syzkaller.appspotmail.com

vhci_hcd: default hub control req: 0000 v0000 i0001 l50287
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 18919 Comm: syz-executor3 Not tainted 4.20.0-rc1+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rds_recv_rcvbuf_delta.part.3+0x14a/0x3f0 net/rds/recv.c:103
Code: c1 ea 03 80 3c 02 00 0f 85 6e 02 00 00 4c 8b a3 c0 04 00 00 48 b8 00  
00 00 00 00 fc ff df 49 8d 7c 24 2c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 00
RSP: 0018:ffff88018b39efc0 EFLAGS: 00010007
RAX: dffffc0000000000 RBX: ffff8801be730780 RCX: ffffc9001061b000
RDX: 0000000000000005 RSI: ffffffff8749949b RDI: 000000000000002c
RBP: ffff88018b39eff8 R08: ffff8801ce388300 R09: ffffed0031673ded
R10: ffffed0031673ded R11: 0000000000000003 R12: 0000000000000000
R13: ffff8801be730ca4 R14: 000000000002e0c0 R15: ffff8801cbe88b00
FS:  00007fa7bf29b700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33a27000 CR3: 00000001bf445000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  rds_recv_rcvbuf_delta net/rds/recv.c:379 [inline]
  rds_recv_incoming+0x8bb/0x1400 net/rds/recv.c:379
  rds_loop_xmit+0xf3/0x2a0 net/rds/loop.c:96
  rds_send_xmit+0x13ef/0x2bb0 net/rds/send.c:355
  rds_sendmsg+0x290f/0x3180 net/rds/send.c:1338
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  __sys_sendto+0x3d7/0x670 net/socket.c:1788
  __do_sys_sendto net/socket.c:1800 [inline]
  __se_sys_sendto net/socket.c:1796 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa7bf29ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000457569
RDX: 0000000000000241 RSI: 0000000020000a00 RDI: 0000000000000008
RBP: 000000000072bf00 R08: 000000002069affb R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa7bf29b6d4
R13: 00000000004c3c11 R14: 00000000004d5e80 R15: 00000000ffffffff
Modules linked in:
---[ end trace ffda6d1117cbc209 ]---
RIP: 0010:rds_recv_rcvbuf_delta.part.3+0x14a/0x3f0 net/rds/recv.c:103
Code: c1 ea 03 80 3c 02 00 0f 85 6e 02 00 00 4c 8b a3 c0 04 00 00 48 b8 00  
00 00 00 00 fc ff df 49 8d 7c 24 2c 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 00
RSP: 0018:ffff88018b39efc0 EFLAGS: 00010007
RAX: dffffc0000000000 RBX: ffff8801be730780 RCX: ffffc9001061b000
RDX: 0000000000000005 RSI: ffffffff8749949b RDI: 000000000000002c
RBP: ffff88018b39eff8 R08: ffff8801ce388300 R09: ffffed0031673ded
R10: ffffed0031673ded R11: 0000000000000003 R12: 0000000000000000
R13: ffff8801be730ca4 R14: 000000000002e0c0 R15: ffff8801cbe88b00
FS:  00007fa7bf29b700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33a27000 CR3: 00000001bf445000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
