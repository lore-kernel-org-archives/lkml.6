Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5193FC38A24
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E15F208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E15F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389948AbeGKTy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:54:57 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:45109 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733093AbeGKTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:54:56 -0400
Received: by mail-io0-f198.google.com with SMTP id i18-v6so22946038iog.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OzML1U98M7CAu5qi8OkUxq+t04cIaTK/kgvWPrwJZJc=;
        b=jvnipxK2xYAuImiMTd81GIJc/cgFwDH/A0PqrXONI+0hf3p1b60/YBewyX42Cy53P/
         l3taIbMpuB8uE2jWtZcceCmjecpfCAE0T4tg3Yhbwy+59pbMw2hZ5lyxaC4xvplMuzzt
         0wiFxZkkaTcOiNhhe+wy3kYX5t4uzigeJg5LO0YUrcsAXqv/QbfqqwSde3W/skIBhHnM
         Vnf1BhywLiu1ZdD7ACdh0Vw2v4D7xCxarYmBpTAhiBqR1+l7PMepciHpcTT2JMMfrAP7
         kBmNjNKmgM2nDC0AUCRCKWQT3h/tlDpz2S0SQxXrZiW8o9WTb5pMcnwPz+Do131uLB5l
         4HOQ==
X-Gm-Message-State: AOUpUlGCHp8mRuZZ0De3C7X+X86yIz1wlcwZz3YNC8DdFhNOPzhkWFNr
        aVpvd5onKeSUXCgGXyEDqr22N2qaqDCgXlwj0nqyXmhvVskX
X-Google-Smtp-Source: AAOMgpdgkwvNJrBY8yYRHCdErGNxBg3jIL7QK5NGecp/6LHMvc9MruSNrH+hcqnjKAf4bjmciAwe6ruhAn2ZOrGcumfod7tH1z/i
MIME-Version: 1.0
X-Received: by 2002:a02:2244:: with SMTP id o65-v6mr9817jao.56.1531338543954;
 Wed, 11 Jul 2018 12:49:03 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:49:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f183880570be89ba@google.com>
Subject: general protection fault in kernel_accept
From:   syzbot <syzbot+e3132895630f957306bc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0026129c8629 rhashtable: add restart routine in rhashtable..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=105660c8400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b88de6eac8694da6
dashboard link: https://syzkaller.appspot.com/bug?extid=e3132895630f957306bc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=16f58ac2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11023efc400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 7406 Comm: kworker/1:106 Not tainted 4.18.0-rc3+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events smc_tcp_listen_work
RIP: 0010:kernel_accept+0x34/0x310 net/socket.c:3243
Code: d6 41 55 49 89 fd 41 54 49 89 f4 53 48 83 ec 08 e8 21 51 8e fb 49 8d  
7d 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 4a 02 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff8801b6aaf5a8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801ac82d0c0 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff85edbaaf RDI: 0000000000000020
RBP: ffff8801b6aaf5d8 R08: ffff8801af0fc8b8 R09: 0000000000000006
R10: ffff8801af0fc080 R11: 0000000000000000 R12: ffff8801b6aaf688
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801b6aaf708
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf138 CR3: 00000001abf14000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  smc_clcsock_accept net/smc/af_smc.c:701 [inline]
  smc_tcp_listen_work+0x222/0xef0 net/smc/af_smc.c:1114
  process_one_work+0xc73/0x1ba0 kernel/workqueue.c:2153
  worker_thread+0x189/0x13c0 kernel/workqueue.c:2296
  kthread+0x345/0x410 kernel/kthread.c:240
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace b294fcf0c2e6ce5f ]---
RIP: 0010:kernel_accept+0x34/0x310 net/socket.c:3243
Code: d6 41 55 49 89 fd 41 54 49 89 f4 53 48 83 ec 08 e8 21 51 8e fb 49 8d  
7d 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 4a 02 00 00 48 b8 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff8801b6aaf5a8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801ac82d0c0 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff85edbaaf RDI: 0000000000000020
RBP: ffff8801b6aaf5d8 R08: ffff8801af0fc8b8 R09: 0000000000000006
R10: ffff8801af0fc080 R11: 0000000000000000 R12: ffff8801b6aaf688
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8801b6aaf708
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cf138 CR3: 0000000008e6a000 CR4: 00000000001406e0
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
