Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059D3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AB720856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AB720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbeGXITE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:19:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:38639 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbeGXITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:19:04 -0400
Received: by mail-it0-f70.google.com with SMTP id i4-v6so1698840ite.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WB8HxJW4Yq3okT09QUDWQsO8RMhPaFCh0XSRFQKuoro=;
        b=O3lSZs2l8dQ4zt6i9dcTPN5226gYK7305O4PxCZyH6UKIQ8S7z2nhpGrYwVXeCKXo5
         yktCKKphA+/AK7XwFfcV0X3SNQSMjj2YqCpl8JDw7KMI2BxuJ0B2uUbNMWM+nXk04J2p
         Rt9jFSIh0XfWjnhrGnTF2+nY6/hNBuwmjEqEax/yl0BYXuLuTE8QmkWmgGa6+eqMfVoN
         B0KkMK5af9v+F78LvKkdBvkE8oRNxqLlRjb6zgeiIpqZZvf0J/zK0kkO7ve9LKD19YNW
         kBBJDOamhUkHkPoUe/RQ052j8QRLTPy6z5ZXEcvLXdemwWBAkn2Vpl56fh28BqMiZAHL
         lk/A==
X-Gm-Message-State: AOUpUlEe1/0SEM7icUiTJPtUS3ZnsSlEAP043VeHPNZXH/4t29bq2ulw
        Um/6rHXEB9+6eLKxJtbVhUDE7MJ3EN/IYe8AlbmSOiebq4BN
X-Google-Smtp-Source: AAOMgpfeZ3z8b7cLSoUkT2WPpbMCwptFSiKnEnBCYgdMuSS/EzLmkI46YzKleotx0zm6Mqewybk/PSTqjI4CJswM63MoWmOeyKIi
MIME-Version: 1.0
X-Received: by 2002:a6b:3dd:: with SMTP id e90-v6mr6249499ioi.85.1532416441919;
 Tue, 24 Jul 2018 00:14:01 -0700 (PDT)
Date:   Tue, 24 Jul 2018 00:14:01 -0700
In-Reply-To: <0000000000006e1bbe0570bea62e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab31220571b98177@google.com>
Subject: Re: general protection fault in inet_accept
From:   syzbot <syzbot+2e9616288940d15a6476@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    fd800f646402 wan/fsl_ucc_hdlc: use IS_ERR_VALUE() to check..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1579b51c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acf770f568ef945b
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9616288940d15a6476
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=179e4d62400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f7a978400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e9616288940d15a6476@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 5524 Comm: kworker/1:120 Not tainted 4.18.0-rc5+ #137
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events smc_tcp_listen_work
RIP: 0010:inet_accept+0xf2/0xa00 net/ipv4/af_inet.c:735
Code: 84 d2 74 09 80 fa 03 0f 8e 95 07 00 00 48 8d 78 28 41 c7 46 80 ea ff  
ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 96 07 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffff8801ce71f4b0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000005
RDX: dffffc0000000000 RSI: ffffffff8677aa46 RDI: 0000000000000028
RBP: ffff8801ce71f598 R08: ffff8801ae2e8480 R09: ffffed0037e1236f
R10: ffffed0037e1236f R11: ffff8801bf091b7b R12: ffff8801bf091ac0
R13: ffff8801ce71f4f0 R14: ffff8801ce71f570 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200024c0 CR3: 0000000008e6a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kernel_accept+0x136/0x310 net/socket.c:3251
  smc_clcsock_accept net/smc/af_smc.c:832 [inline]
  smc_tcp_listen_work+0x222/0xef0 net/smc/af_smc.c:1296
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace de997303bb6ff5f8 ]---
RIP: 0010:inet_accept+0xf2/0xa00 net/ipv4/af_inet.c:735
Code: 84 d2 74 09 80 fa 03 0f 8e 95 07 00 00 48 8d 78 28 41 c7 46 80 ea ff  
ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 96 07 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffff8801ce71f4b0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000005
RDX: dffffc0000000000 RSI: ffffffff8677aa46 RDI: 0000000000000028
RBP: ffff8801ce71f598 R08: ffff8801ae2e8480 R09: ffffed0037e1236f
R10: ffffed0037e1236f R11: ffff8801bf091b7b R12: ffff8801bf091ac0
R13: ffff8801ce71f4f0 R14: ffff8801ce71f570 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200024c0 CR3: 0000000008e6a000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

