Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E04C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E5D20842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E5D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeGILtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:49:07 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:41127 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754481AbeGILtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:49:03 -0400
Received: by mail-io0-f198.google.com with SMTP id p12-v6so2028820iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NnxpwBhArnHJabTbtQUdG57eG1sWl5w9oy4cWYhrubc=;
        b=LFxCpo4X9tdt0n4Xq1o/piHMzEt9LnFCRIg0OQMW3IscDNTuxKA/Oy/vpULuq1nqig
         zlgX1SAhSF3KNP6OoqJ8Q3eY/NWrKtzOgzVq6x1YTn2/BuwGtqsMPpQ3hvKp9ZbkWool
         m8ErlcVJ7xnP/A4lxmV1kh8hhU+puHEnnlfb8CVYcBdLrrf9BZy6dJ6gHGOCPv6mmEtP
         GXDjXj4Fira3MgW1PkmqUEdvz/s/h2thBh80nB33UQPYKe27Jwn3ZMzisvK7qqylnARo
         oSdqQcOU8woYbVWMcX+8gz4A39vibAoIyRIJNrg6IyxmXUlZIwWs9yLl6XJoZzEnC72J
         uvMw==
X-Gm-Message-State: AOUpUlF9MEBzQVq1OmDXG5UW+e7IaoGZFut0tAK/kRYnvtDCiroFKcUf
        4wqf/gHmxpldlz2FfKT0dU6V3EaaljggzLNXkyRk6wTVWsxX
X-Google-Smtp-Source: AAOMgpeRjdCpDE78wUOPqMNRf1/RKxWJUozdnNVCuc2+RId+9y/mR1uI1ZdHfIqWMYpXX79rEhfBS8tC6DQG9p9pFnaJEP0IQ+d6
MIME-Version: 1.0
X-Received: by 2002:a6b:ce10:: with SMTP id p16-v6mr8868235iob.74.1531136942697;
 Mon, 09 Jul 2018 04:49:02 -0700 (PDT)
Date:   Mon, 09 Jul 2018 04:49:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009276d205708f9910@google.com>
Subject: general protection fault in finish_wait
From:   syzbot <syzbot+3aac4a52d8e8ca0414d5@syzkaller.appspotmail.com>
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

HEAD commit:    6508b6781be0 tcp: cleanup copied_seq and urg_data in tcp_d..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1256e6dc400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=3aac4a52d8e8ca0414d5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1310fafc400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10af4f48400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3aac4a52d8e8ca0414d5@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 19 Comm: kworker/1:0 Not tainted 4.18.0-rc3+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events smc_tcp_listen_work
RIP: 0010:__lock_acquire+0x245/0x5020 kernel/locking/lockdep.c:3314
Code: 28 00 00 00 0f 85 03 34 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 c6 35 00 00 49 81 7d 00 60 76 e7 89 0f 84 42 ff
RSP: 0000:ffff8801d9b36d20 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffffff88f1b060
RBP: ffff8801d9b370a8 R08: 0000000000000001 R09: 0000000000000001
R10: ffff8801d9b2a500 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000018 R14: ffff8801d9b2a500 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002cc0 CR3: 00000001ae03f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x96/0xc0 kernel/locking/spinlock.c:152
  finish_wait+0x119/0x430 kernel/sched/wait.c:364
  inet_csk_wait_for_connect net/ipv4/inet_connection_sock.c:418 [inline]
  inet_csk_accept+0x6d0/0xe70 net/ipv4/inet_connection_sock.c:451
  inet_accept+0x138/0x9f0 net/ipv4/af_inet.c:734
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
---[ end trace 472b359041f047a6 ]---
RIP: 0010:__lock_acquire+0x245/0x5020 kernel/locking/lockdep.c:3314
Code: 28 00 00 00 0f 85 03 34 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 c6 35 00 00 49 81 7d 00 60 76 e7 89 0f 84 42 ff
RSP: 0000:ffff8801d9b36d20 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffffff88f1b060
RBP: ffff8801d9b370a8 R08: 0000000000000001 R09: 0000000000000001
R10: ffff8801d9b2a500 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000018 R14: ffff8801d9b2a500 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002cc0 CR3: 00000001ae03f000 CR4: 00000000001406e0
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
