Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8093ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC3720856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC3720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbeGSPce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:32:34 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:59781 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbeGSPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:32:34 -0400
Received: by mail-it0-f69.google.com with SMTP id a10-v6so5889087itc.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vzDJKuHV7UtSDddei0aPY9a2y1QHsQu98RjOfzJjf6I=;
        b=Fq8DJzbDltyx/CNfeCcVQZcP9S9BhZtqT5iHrjyvbZ/BV59uji0t9jT65suEJuNTDt
         vnoXjT/t5MDbTBPOQLwDZ/aIuempj7Z6rHcWECqoCIrIgmg3pnNrMrz484B4PIwwWNkV
         g1vBTo3tZT0dL+2cNlrPGS8GAM5EPipIzUg5Trt6pPy4BpRPDnQtfDLPhoqs/sYMsZMt
         hYli3Gqm8h+XAMhqQYfx8jwTodHV886z43QxIW4bvE6NYuEaEzd3UzieK0IXgqLg1H6s
         51ycXnoeJJ7hIYxRZfD7Xx/tdIsAF66fyJPPdgEcB7NIkUryTFCcpN0rxQ6vbEkz0TNT
         5Wng==
X-Gm-Message-State: AOUpUlH+HXE8r0O+vfhUTweA58kJZ01HMyehalBut98++RhPP2s+JthW
        gLf0ThegEnwlfyaKSQLxgi2zP6DzsJ/SB+8Fo5LbHw1z3jz0
X-Google-Smtp-Source: AAOMgpdVy3ESTKNHxeYaP3LG1CmZf0tFje2NEvCFghIJHbpVHE2SIGrAfDcnBLgVkZIMEZCbutiU1jYpq2VOMlopzmCesyrR7knj
MIME-Version: 1.0
X-Received: by 2002:a24:54c9:: with SMTP id t192-v6mr2987516ita.40.1532011743186;
 Thu, 19 Jul 2018 07:49:03 -0700 (PDT)
Date:   Thu, 19 Jul 2018 07:49:03 -0700
In-Reply-To: <0000000000006e1bbe0570bea62e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be957f05715b47e9@google.com>
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

HEAD commit:    024ddc0ce104 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103f4b2c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0bdc4175608181c
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9616288940d15a6476
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
userspace arch: i386
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15b5e1c2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e9616288940d15a6476@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: cc1: uninitialized urandom read (8 bytes read)
IPVS: ftp: loaded support on port[0] = 21
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4573 Comm: kworker/0:4 Not tainted 4.18.0-rc5+ #57
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events smc_tcp_listen_work
RIP: 0010:inet_accept+0xf2/0x9f0 net/ipv4/af_inet.c:734
Code: 84 d2 74 09 80 fa 03 0f 8e 93 07 00 00 48 8d 78 28 41 c7 46 80 ea ff  
ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 94 07 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffff8801d93974b0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000005
RDX: dffffc0000000000 RSI: ffffffff867516c6 RDI: 0000000000000028
RBP: ffff8801d9397598 R08: ffff8801adcde0c0 R09: ffffed003517482f
R10: ffffed003517482f R11: ffff8801a8ba417b R12: ffff8801a8ba40c0
R13: ffff8801d93974f0 R14: ffff8801d9397570 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000008350031 CR3: 0000000008e6a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kernel_accept+0x136/0x310 net/socket.c:3251
  smc_clcsock_accept net/smc/af_smc.c:701 [inline]
  smc_tcp_listen_work+0x222/0xef0 net/smc/af_smc.c:1114
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 99066b32c3785fe4 ]---
RIP: 0010:inet_accept+0xf2/0x9f0 net/ipv4/af_inet.c:734
Code: 84 d2 74 09 80 fa 03 0f 8e 93 07 00 00 48 8d 78 28 41 c7 46 80 ea ff  
ff ff 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 94 07 00 00 48 b9 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffff8801d93974b0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000005
RDX: dffffc0000000000 RSI: ffffffff867516c6 RDI: 0000000000000028
RBP: ffff8801d9397598 R08: ffff8801adcde0c0 R09: ffffed003517482f
R10: ffffed003517482f R11: ffff8801a8ba417b R12: ffff8801a8ba40c0
R13: ffff8801d93974f0 R14: ffff8801d9397570 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000008350031 CR3: 0000000008e6a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

