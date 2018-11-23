Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8143EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5452820820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5452820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502103AbeKWRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:11:54 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:38156 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501982AbeKWRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:11:54 -0500
Received: by mail-io1-f69.google.com with SMTP id l12so10337476iop.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 22:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HsV+FFxj018CVJK7/HuA1BZrqStSaL27Bnenz3U3pRg=;
        b=m5V11fFjMeikoCD9Tqsj7tUhpD6J1cLfxdlpOa8xN5qaEt+pO5CXCVXiXn6LnznsP8
         IXa3O75bxRgHrLROsAP1fj3jpN3JvtwcsUxOPpCZb0LDDZh2JGysJjkgErnVnt+jR11g
         s0Jl83ZSQSVjoEXmaDU3MCBCrwFL28FZ837+PaRvBu4bSKc2CJfifn1Sn7ZtFfMqe1SP
         q24ZhbcQScj2/l6FJFI5oO0vAtDEC8oRMWfjObfvlm9og2JQW6V6/DJes9uny5rFOOc8
         hphxwy8NKSotoR65Zt5LBPILT1etQtxPBUFfmN4shxA5XWQjL+vssJ8+8jbKEG7MOt5o
         szOA==
X-Gm-Message-State: AA+aEWbDbOmzC6zKeDzh7Sd1ZVdo3HdTWYWIBmevwrjUSd0hbppXuPvR
        6je5mwIBpFEyvcZc8UWI3w1G1fcFp6a445nP2mbGNrJiIqsX
X-Google-Smtp-Source: AFSGD/XV2AA/rDGh5dz2ps+t2ph5m0wOY5PkYHb8cayGccLdsasEyGVeYXNwPY83xqNnnjqvWg9mI9G4JXwIuOs57ZlDs60f8Xkc
MIME-Version: 1.0
X-Received: by 2002:a6b:c84a:: with SMTP id y71mr8461272iof.10.1542954544035;
 Thu, 22 Nov 2018 22:29:04 -0800 (PST)
Date:   Thu, 22 Nov 2018 22:29:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000807fe4057b4f19c6@google.com>
Subject: BUG: corrupted list in p9_read_work (2)
From:   syzbot <syzbot+77a25acfa0382e06ab23@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    edeca3a769ad Merge tag 'sound-4.20-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dee26d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=77a25acfa0382e06ab23
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1459062b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+77a25acfa0382e06ab23@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
list_del corruption, ffff8881d12ddfb0->next is LIST_POISON1  
(dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:47!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 2915 Comm: kworker/0:2 Not tainted 4.20.0-rc3+ #124
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events p9_read_work
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x4a lib/list_debug.c:45
Code: d2 fd 0f 0b 4c 89 e2 48 89 de 48 c7 c7 00 d1 60 88 e8 c6 37 d2 fd 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 60 d0 60 88 e8 b2 37 d2 fd <0f> 0b 48 89 de  
48 c7 c7 c0 d1 60 88 e8 a1 37 d2 fd 0f 0b 48 89 de
RSP: 0018:ffff8881cb9075c0 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff8881d12ddfb0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
RBP: ffff8881cb9075d8 R08: ffff8881cbb30400 R09: ffffed103b5c5020
R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: dead000000000200
R13: dead000000000100 R14: ffff8881d8fd6a90 R15: ffff8881d8fd6a50
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001b3f06000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  p9_read_work+0xa95/0x1140 net/9p/trans_fd.c:378
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace e66a284578a06221 ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x26/0x4a lib/list_debug.c:45
Code: d2 fd 0f 0b 4c 89 e2 48 89 de 48 c7 c7 00 d1 60 88 e8 c6 37 d2 fd 0f  
0b 4c 89 ea 48 89 de 48 c7 c7 60 d0 60 88 e8 b2 37 d2 fd <0f> 0b 48 89 de  
48 c7 c7 c0 d1 60 88 e8 a1 37 d2 fd 0f 0b 48 89 de
RSP: 0018:ffff8881cb9075c0 EFLAGS: 00010286
RAX: 000000000000004e RBX: ffff8881d12ddfb0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
RBP: ffff8881cb9075d8 R08: ffff8881cbb30400 R09: ffffed103b5c5020
R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: dead000000000200
R13: dead000000000100 R14: ffff8881d8fd6a90 R15: ffff8881d8fd6a50
FS:  0000000000000000(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001b3f06000 CR4: 00000000001406f0
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
