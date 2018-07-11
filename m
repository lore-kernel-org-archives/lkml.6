Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA60C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B4F2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B4F2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeGKUCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:02:55 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:38199 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeGKUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:02:55 -0400
Received: by mail-it0-f69.google.com with SMTP id i4-v6so2621577ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fZ91f1ZZOCPH9nWCAsDXAufSgB2Hzc62J/ug7jd2Pl8=;
        b=P9So5o2p4Wb6+2QIgv76c4l1KS/Rmcbj5815DQ9+haoDE1bfyWI1eSBddjZX7njy2s
         LiK1T/KIXLJRXm6vyh3N5bZZQaj8R/rXDSVUJpXw7fnBhKg7RYoA21SObO/5DRc7pf/e
         WtIw4cNYCicctn9lBQ5hgtfpJ3UyUbvH9gZUM9poSjzmdxkwJZidsX/dJGcAy+fshlZR
         pCZZQNLKg5gv1PFZwwSOSzsf6fYE7XRrzEbgc0BsF7c5NdQe+SuFslEWGtFVvPb/yCLY
         2ghh0vY6F9DitZ6v9jNp8OeOsG8J0PFrf34ayw37WOPRrAm6Kf3djrQ2vhNVy+l5Dm4j
         GBsw==
X-Gm-Message-State: AOUpUlFOfNNOvIorYzx4y7FXpHSkZlDgndIdwnhcrz2BlweZmOogOsdb
        nG6frGf0D+6unZUkmWZnwU5ZiZI7Oq26nVcdUjxm+Y1plbE8
X-Google-Smtp-Source: AAOMgpcwLIeFmxiEBBvgF16/EiP9xOQqjm/WrRRhNSHYk0ieuxNQexJyjJv+14vjb6Kpbxh48hF8wsrwCIusWl/xun2NhS0XBWac
MIME-Version: 1.0
X-Received: by 2002:a5e:c01a:: with SMTP id u26-v6mr8322iol.69.1531339021881;
 Wed, 11 Jul 2018 12:57:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:57:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e1bbe0570bea62e@google.com>
Subject: general protection fault in inet_accept
From:   syzbot <syzbot+2e9616288940d15a6476@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0026129c8629 rhashtable: add restart routine in rhashtable..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10ed430c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b88de6eac8694da6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9616288940d15a6476
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e9616288940d15a6476@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 27 Comm: kworker/1:1 Not tainted 4.18.0-rc3+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events smc_tcp_listen_work
RIP: 0010:inet_accept+0xf2/0x9f0 net/ipv4/af_inet.c:734
Code: 84 d2 74 09 80 fa 03 0f 8e 93 07 00 00 48 8d 78 28 41 c7 46 80 ea ff  
ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 94 07 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffff8801d94574b0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000005
RDX: dffffc0000000000 RSI: ffffffff86751b46 RDI: 0000000000000028
RBP: ffff8801d9457598 R08: ffff8801d9448700 R09: ffffed00367a0f6f
R10: ffffed00367a0f6f R11: ffff8801b3d07b7b R12: ffff8801b3d07ac0
R13: ffff8801d94574f0 R14: ffff8801d9457570 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30220000 CR3: 00000001d711f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kernel_accept+0x136/0x310 net/socket.c:3251
  smc_clcsock_accept net/smc/af_smc.c:701 [inline]
  smc_tcp_listen_work+0x222/0xef0 net/smc/af_smc.c:1114
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 0d34e5471cc130cb ]---
RIP: 0010:inet_accept+0xf2/0x9f0 net/ipv4/af_inet.c:734
Code: 84 d2 74 09 80 fa 03 0f 8e 93 07 00 00 48 8d 78 28 41 c7 46 80 ea ff  
ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 94 07 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffff8801d94574b0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000005
RDX: dffffc0000000000 RSI: ffffffff86751b46 RDI: 0000000000000028
RBP: ffff8801d9457598 R08: ffff8801d9448700 R09: ffffed00367a0f6f
R10: ffffed00367a0f6f R11: ffff8801b3d07b7b R12: ffff8801b3d07ac0
R13: ffff8801d94574f0 R14: ffff8801d9457570 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30220000 CR3: 0000000008e6a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
