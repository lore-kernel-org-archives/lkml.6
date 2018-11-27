Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD5AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76C920873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76C920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbeK1CuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:50:24 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:52691 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbeK1CuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:50:24 -0500
Received: by mail-io1-f72.google.com with SMTP id h7so22611319iof.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 07:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6fEJ8Exqcxr8f7oZ6Defb32ruLXvnGIJ5tnReXjq9ws=;
        b=bi6IXNHNZxLUqCyYzH4gQmRy+1XaTsHaTn157nEYuCr+QJ0Ec/+qvD6Frj0AEwOvO8
         jkYGcaqSpjWDlFSqkOkRDfP037hER62ljhPVzVF2VNsVvehrmUwY1Ex6oT3ZSeMe6U8Q
         8Lmt0ch3OMfrDpm3VClnGYQlU5ueJgl58fl2/MKCayX21g0YKbyhobFSMUwbxDNpJd6F
         HSRsC4O1VeRTSAi1Ec00faJ2n1uydMGQikim43tqhFRlbA2SfVbwTgykKZfv89nFYava
         F9wn59PUAgSUYmsUIBA9Fm1l9/ErAuUs9HPObYcXjmITfBRJ5b0t7wDTy/AAORaWpI5+
         p7Cw==
X-Gm-Message-State: AA+aEWaBnGzPVSClLNv8OpMoXLgUQLQoQQGlJ/7GctfS4y9nhEhzAukO
        l5yMEwHMHExDN8SU+0zUQ4k6gVWd0quaJpO0RhJIhcz3t9oT
X-Google-Smtp-Source: AFSGD/XQujYs8/JLgKg/s0S+i9hwMxnpkOMtICaHfrpCxvh/tvqVjwBhoUaBdEiNZIWgGTPOQ7Td2SNRmT/wMJFLPLOMUn0+0oJ3
MIME-Version: 1.0
X-Received: by 2002:a6b:e603:: with SMTP id g3mr798275ioh.27.1543333923955;
 Tue, 27 Nov 2018 07:52:03 -0800 (PST)
Date:   Tue, 27 Nov 2018 07:52:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004eade9057ba76eae@google.com>
Subject: BUG: corrupted list in freeary
From:   syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, dave@stgolabs.net,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, manfred@colorfullife.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d3e6a3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com

input: syz1 as /devices/virtual/input/input670
input: syz1 as /devices/virtual/input/input671
list_del corruption. prev->next should be ffff8881dae2cdb8, but was  
0000000000100000
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6194 Comm: syz-executor5 Not tainted 4.20.0-rc3+ #348
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
Code: d0 60 88 e8 b2 31 d2 fd 0f 0b 48 89 de 48 c7 c7 00 d2 60 88 e8 a1 31  
d2 fd 0f 0b 48 89 de 48 c7 c7 a0 d1 60 88 e8 90 31 d2 fd <0f> 0b 48 89 d9  
48 c7 c7 60 d2 60 88 e8 7f 31 d2 fd 0f 0b 48 89 f1
RSP: 0018:ffff8881848fee80 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffff8881dae2cdb8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
RBP: ffff8881848fee98 R08: ffff8881848f26c0 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8881848f26c0 R12: ffff8881c3173a00
R13: ffff8881be118118 R14: ffff8881848ff280 R15: dffffc0000000000
FS:  00000000020b2940(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000001c10d3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  unlink_queue ipc/sem.c:786 [inline]
  freeary+0xbd1/0x1a40 ipc/sem.c:1160
  free_ipcs+0x9f/0x1c0 ipc/namespace.c:112
  sem_exit_ns+0x20/0x40 ipc/sem.c:237
  free_ipc_ns ipc/namespace.c:120 [inline]
  put_ipc_ns+0x66/0x180 ipc/namespace.c:152
  free_nsproxy+0xcf/0x220 kernel/nsproxy.c:180
  switch_task_namespaces+0xb3/0xd0 kernel/nsproxy.c:229
  exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
  do_exit+0x1ad1/0x26d0 kernel/exit.c:866
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410fa0
Code: 24 48 8b 4c 24 28 48 89 4c 24 08 88 44 24 10 c6 44 24 11 01 0f b6 44  
24 50 88 44 24 12 e8 18 15 01 00 48 8b 44 24 18 48 85 c0 <74> 59 48 89 44  
24 30 48 8b 48 18 48 8b 54 24 48 48 01 d1 48 89 88
RSP: 002b:00007fff19ab9c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 0000000000410fa0
RDX: 0000000000000038 RSI: 0000000000728020 RDI: 00000000000000f9
RBP: 0000000000000003 R08: 0000000000006000 R09: 0000000000004000
R10: 00007fff19ab95e0 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000008f53b R14: 00000000000002f8 R15: 0000000000000005
Modules linked in:
---[ end trace 9573c75ddafce7e3 ]---
RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
Code: d0 60 88 e8 b2 31 d2 fd 0f 0b 48 89 de 48 c7 c7 00 d2 60 88 e8 a1 31  
d2 fd 0f 0b 48 89 de 48 c7 c7 a0 d1 60 88 e8 90 31 d2 fd <0f> 0b 48 89 d9  
48 c7 c7 60 d2 60 88 e8 7f 31 d2 fd 0f 0b 48 89 f1
RSP: 0018:ffff8881848fee80 EFLAGS: 00010286
RAX: 0000000000000054 RBX: ffff8881dae2cdb8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
RBP: ffff8881848fee98 R08: ffff8881848f26c0 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8881848f26c0 R12: ffff8881c3173a00
R13: ffff8881be118118 R14: ffff8881848ff280 R15: dffffc0000000000
FS:  00000000020b2940(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000625208 CR3: 00000001c10d3000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
