Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0BDC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DC820833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DC820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeKDE2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 00:28:14 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:56130 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeKDE2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 00:28:14 -0400
Received: by mail-it1-f197.google.com with SMTP id w196-v6so6612547itc.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 12:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OS6uL2UqYzZtamggqdDQjIlfSbSrRU6Y9ZEEUeCuvr8=;
        b=jjg61sTpRBtDSmCyCPPbbWi4TRm8U5OFk2xbdo32u482O0saoA5ux/mZeo4qAKQA35
         ywHPJs2PfcCCrjZ6Yhxgwabq3h6ai5+3wYwIXpA/tnWrtbI9S8/TJ+ZNxi+BfNDA7+/m
         2jcGYgZp5PkqgPExpEVL84Rt+lGMKbVHz5uYBOGMrz4o0DUxlGCjSnRI1uwDSEdvVP9X
         rG5BjY60js2gbS9Xs88qBpImnTqmJ4Y6LtF67DxSrG7QhsD5jSQa8HXR9YcHAItuj6rY
         xtr6vdLvqJJrH2G/HMDZjiQ95bNoJgv13lUefFzHT9nTM3C4rYoq6FhhSuikRHAiAhPw
         pjGg==
X-Gm-Message-State: AGRZ1gJedLnqpsKwkDU6gO5UIaG9zG99OFBjyzwHpBs3PKGxEf5Fjwnr
        9HccX2Rm4af+E2vxtB9oim7GHbsjAtweE3lDVM8KE5LzFEmE
X-Google-Smtp-Source: AJdET5epcS5oKZj4Ohh9VCuL9N/zpdS0qVU0DNmV3FAQaTu8fqcanP5Ny4+eGChkj35o+0478b7BxQoTMmh7QEPxRy5AGOX2jgqn
MIME-Version: 1.0
X-Received: by 2002:a02:854a:: with SMTP id g68-v6mr13548723jai.12.1541272563461;
 Sat, 03 Nov 2018 12:16:03 -0700 (PDT)
Date:   Sat, 03 Nov 2018 12:16:03 -0700
In-Reply-To: <000000000000ec1b3805799d0a56@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5b4fb0579c77b40@google.com>
Subject: Re: general protection fault in delayed_uprobe_remove
From:   syzbot <syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    25e9471b6a27 Add linux-next specific files for 20181102
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1549cfe5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a22859d870756c1
dashboard link: https://syzkaller.appspot.com/bug?extid=eab6e18f95a9fe69005e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137174f5400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1278485d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 21962 Comm: syz-executor753 Not tainted 4.19.0-next-20181102+  
#104
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:delayed_uprobe_remove+0x6f/0x140 kernel/events/uprobes.c:339
Code: 00 00 00 48 81 fb c0 f8 5f 89 4c 8b 23 49 bd 00 00 00 00 00 fc ff df  
75 2f e9 98 00 00 00 e8 78 1d e5 ff 4c 89 e0 48 c1 e8 03 <42> 80 3c 28 00  
0f 85 91 00 00 00 49 81 fc c0 f8 5f 89 49 8b 04 24
RSP: 0018:ffff8801cc56f178 EFLAGS: 00010a02
RAX: 1bd5a00000000020 RBX: ffff8801c1fece00 RCX: 1ffff1003b2001f4
RDX: 0000000000000000 RSI: ffffffff819a4af8 RDI: ffff8801c1fece18
RBP: ffff8801cc56f1a0 R08: ffff8801d9000fa0 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801d9000700 R12: dead000000000100
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8801bb484ec0
FS:  00007fcaad5a4700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcaad5a3e78 CR3: 00000001d392f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  uprobe_clear_state+0xbe/0x390 kernel/events/uprobes.c:1510
  __mmput kernel/fork.c:1041 [inline]
  mmput+0x1bc/0x610 kernel/fork.c:1066
  exit_mm kernel/exit.c:545 [inline]
  do_exit+0xe74/0x26d0 kernel/exit.c:854
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8a8/0x1970 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4469c9
Code: e8 dc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fcaad5a3db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00000000006dcc38 RCX: 00000000004469c9
RDX: 00000000004469c9 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006dcc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffc9cc8172f R14: 00007fcaad5a49c0 R15: 00000000006dcd2c
Modules linked in:
---[ end trace b0de3a2925ef8954 ]---
RIP: 0010:delayed_uprobe_remove+0x6f/0x140 kernel/events/uprobes.c:339
Code: 00 00 00 48 81 fb c0 f8 5f 89 4c 8b 23 49 bd 00 00 00 00 00 fc ff df  
75 2f e9 98 00 00 00 e8 78 1d e5 ff 4c 89 e0 48 c1 e8 03 <42> 80 3c 28 00  
0f 85 91 00 00 00 49 81 fc c0 f8 5f 89 49 8b 04 24
RSP: 0018:ffff8801cc56f178 EFLAGS: 00010a02
RAX: 1bd5a00000000020 RBX: ffff8801c1fece00 RCX: 1ffff1003b2001f4
RDX: 0000000000000000 RSI: ffffffff819a4af8 RDI: ffff8801c1fece18
RBP: ffff8801cc56f1a0 R08: ffff8801d9000fa0 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801d9000700 R12: dead000000000100
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8801bb484ec0
FS:  00007fcaad5a4700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000154c000 CR3: 00000001d4590000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

