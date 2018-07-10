Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C79CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6576208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6576208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGJKaE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:30:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:55717 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932752AbeGJKaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:30:02 -0400
Received: by mail-io0-f198.google.com with SMTP id u23-v6so18696988iol.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=v8ba2XomyTUf6xaaJyld0WtV0IC4QpCCqoeRJ5Iu8Q4=;
        b=jwuectkf3cmYp07yZBwhtyvwoguEKSq9hsM+kfj2AAT6vJudZqNK0ayppGBJg2CM5K
         Evf3QefM9vxJ2dX/hA2U/xYX5+Bvg9VKUy7LOB1BJomWrsxw8svmc4DjoL/gZb5BOJqy
         lxf5zpezYJ/kTD+f2vbiCKd21Xhmr0jXqOnQuXzS0KK6RsChhjvw4xwzZBw2us0z7mm/
         sTTUT03sEEbw0gRXQCLP12xtTp/SOQXi5sJ3Q5XS8R0wypltU2lTa4jCFV9Vf+91IZT7
         0l1GmEzRmpn3yHxLBe/tJifjZ7PSWuHqKAseMQymayIWVoMbnnONCprZybH9XKZaIKNX
         jHlA==
X-Gm-Message-State: AOUpUlHj5i/zmaiC25W9nZqxsJ4ZLKNXxzkwbcAAy/R/r3hmaKPnGBSU
        Cz82mB+NZ+SGdqHKk/vYmSydHK0ax8EQWamkDUCs0EDHAYpF
X-Google-Smtp-Source: AAOMgpeGG8vaq3ilWJEj3MVOYqrYVlhZeCrpiKaYQkbubDoLFE2EaUEM1m3GJS83wQ2IO59kPw7SLxPB5KYj6vF/bn0+Fhon2FKv
MIME-Version: 1.0
X-Received: by 2002:a24:5d08:: with SMTP id w8-v6mr3596661ita.22.1531218602127;
 Tue, 10 Jul 2018 03:30:02 -0700 (PDT)
Date:   Tue, 10 Jul 2018 03:30:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da8a9b0570a29c01@google.com>
Subject: INFO: task hung in iterate_supers
From:   syzbot <syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d00d6d9a339d Add linux-next specific files for 20180709
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111179b2400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94fe2b586beccacd
dashboard link: https://syzkaller.appspot.com/bug?extid=2349f5067b1772c1d8a5
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=174329b2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11229044400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2349f5067b1772c1d8a5@syzkaller.appspotmail.com

INFO: task syz-executor687:4459 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D23544  4459   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad5912da8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dac44 RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dac40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4479 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D25408  4479   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0x10c/0x1e0 fs/sync.c:115
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad58f1da8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dac5c RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dac58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4492 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D22992  4492   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad58d0da8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dac74 RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dac70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4497 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D25408  4497   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad58afda8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dac8c RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dac88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4503 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D24512  4503   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad588eda8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006daca4 RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006daca0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4521 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D23648  4521   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad586dda8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dacbc RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dacb8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4524 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D23640  4524   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad584cda8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dacd4 RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dacd0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4534 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D23864  4534   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad582bda8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dacec RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dace8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4548 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D25408  4548   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad580ada8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dad04 RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dad00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: task syz-executor687:4556 blocked for more than 140 seconds.
       Not tainted 4.18.0-rc3-next-20180709+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor687 D24480  4556   4456 0x00000000
Call Trace:
  context_switch kernel/sched/core.c:2853 [inline]
  __schedule+0x87c/0x1ed0 kernel/sched/core.c:3501
  schedule+0xfb/0x450 kernel/sched/core.c:3545
  __rwsem_down_read_failed_common kernel/locking/rwsem-xadd.c:269 [inline]
  rwsem_down_read_failed+0x362/0x600 kernel/locking/rwsem-xadd.c:286
  call_rwsem_down_read_failed+0x18/0x30 arch/x86/lib/rwsem.S:94
  __down_read arch/x86/include/asm/rwsem.h:83 [inline]
  down_read+0xc3/0x1d0 kernel/locking/rwsem.c:26
  iterate_supers+0xe2/0x290 fs/super.c:728
  ksys_sync+0xec/0x1e0 fs/sync.c:113
  __ia32_sys_sync+0xe/0x20 fs/sync.c:124
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4498c9
Code: e8 1c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d2 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0ad57e9da8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00000000006dad1c RCX: 00000000004498c9
RDX: 00000000004498c9 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dad18 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0030656c69662f2e
R13: 3d6e6f6973726576 R14: 64663d736e617274 R15: 0000000000000001
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 899 Comm: khungtaskd Not tainted 4.18.0-rc3-next-20180709+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.5+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:143 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0xb39/0x10b0 kernel/hung_task.c:265
  kthread+0x345/0x410 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt+0x6/0x10  
arch/x86/include/asm/irqflags.h:54


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
