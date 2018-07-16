Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2818ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9665120877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9665120877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeGPPp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:45:57 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:58471 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeGPPp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:45:56 -0400
Received: by mail-it0-f71.google.com with SMTP id y13-v6so13707652ita.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 08:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=euXY6Sz/2v+zE7oqzitSIKvfHL+U109UMyv+SESYFhA=;
        b=XrLTU8ads+Cqlatz/na2Sb5vpAyqJ95jbhcMlKZ5qzNfPxaQR+DhQ8QsQmncXGbp46
         sXBPB80CWDo81oSz6UVh44XbKWlNQA5S9n6SLkxSr2ieneY5fOxM8dfpwcVJoenmUnNE
         5QkDg1eIqsBAy6upiDJt6Yr3c5ctpUe9ez2JUTBcm32GtJZGnHBhqBzcjALYLYwQ8H+C
         Q2/PYFg+ggMpojqfsQPTNd2+pvouplz+fdObhCBkK1AitNcooXPkSxX86wQsIYhBwC4z
         1KAYK8q1hVP9Sj4BcDgmc9BERt0gKwZo8DkA4CDgVTadW/ySI0aTvrGb3EqAbmV7KaKL
         z/Ag==
X-Gm-Message-State: AOUpUlG8XmyOOvrDOEZLH6df8i7xdxCwznj2Tu82AT6IH6PJJ7vROcSL
        IQfv9G4K/ee5eqB3SzaYpuHVC0wCi6mGFV/+z1Pn8AmjcGcv
X-Google-Smtp-Source: AAOMgpcCmwaNzz9pwYmQmWqeJOY1oWbaXFE0HHAArfAnU5dxmZFz5f0kNi/1k5T5RRz7QXCX10tR0qa4nEq6j7YueYBmPfE0dNpp
MIME-Version: 1.0
X-Received: by 2002:a02:a319:: with SMTP id q25-v6mr7673683jai.44.1531754282818;
 Mon, 16 Jul 2018 08:18:02 -0700 (PDT)
Date:   Mon, 16 Jul 2018 08:18:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e92d1805711f5552@google.com>
Subject: WARNING in bpf_jit_free
From:   syzbot <syzbot+2ff1e7cb738fd3c41113@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9d3cce1e8b85 Linux 4.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1127970c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0ccc9273f0e539
dashboard link: https://syzkaller.appspot.com/bug?extid=2ff1e7cb738fd3c41113
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2ff1e7cb738fd3c41113@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 12000 at kernel/bpf/core.c:628 bpf_jit_free+0x2e5/0x3f0
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:bpf_jit_free+0x2e5/0x3f0
Code: 07 38 c8 7f 08 84 c0 0f 85 85 00 00 00 48 b8 00 02 00 00 00 00 ad de  
44 0f b6 63 02 48 39 c2 0f 84 d9 fd ff ff e8 db a3 f3 ff <0f> 0b e9 cd fd  
ff ff e8 cf a3 f3 ff 4c 89 f0 48 ba 00 00 00 00 00
RSP: 0018:ffff880194267640 EFLAGS: 00010293
RAX: ffff8801aa76e6c0 RBX: ffffc9000192e000 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffffffff81886765 RDI: ffff8801d9223768
RBP: ffff8801942676d8 R08: ffff8801aa76eef8 R09: 0000000000000006
R10: ffff8801aa76e6c0 R11: 0000000000000000 R12: 000000000000000f
R13: 1ffff1003284ceca R14: ffffc9000192e002 R15: ffffc9000192e020
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#1] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194266f80 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff8801942670f8 R08: ffff8801aa76e6c0 R09: ffffed003b5c46d6
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#2] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194266818 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194266990 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#3] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801942660a8 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194266220 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#4] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194265938 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194265ab0 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#5] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801942651c8 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194265340 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#6] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194264a58 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194264bd0 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#7] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff8801942642e8 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194264460 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#8] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194263b78 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194263cf0 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#9] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194263408 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194263580 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#10] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194262c98 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194262e10 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#11] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194262528 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff8801942626a0 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#12] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194261db8 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194261f30 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#13] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194261648 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff8801942617c0 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Oops: 0000 [#14] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events bpf_prog_free_deferred
RIP: 0010:bpf_get_prog_addr_region kernel/bpf/core.c:384 [inline]
RIP: 0010:bpf_tree_comp kernel/bpf/core.c:435 [inline]
RIP: 0010:__lt_find include/linux/rbtree_latch.h:115 [inline]
RIP: 0010:latch_tree_find include/linux/rbtree_latch.h:208 [inline]
RIP: 0010:bpf_prog_kallsyms_find+0x2f8/0x4c0 kernel/bpf/core.c:509
Code: e7 f3 ff 0f 0b e8 38 e7 f3 ff 4c 89 e6 4c 89 ef e8 dd e7 f3 ff 4d 39  
e5 0f 82 a0 00 00 00 e8 1f e7 f3 ff 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 30  
84 c0 74 08 3c 03 0f 8e 4e 01 00 00 41 8b 04 24 4c
RSP: 0018:ffff880194260ed8 EFLAGS: 00010806
RAX: 1ffffffff4002000 RBX: ffff8801d9223730 RCX: ffffffff81882413
RDX: 0000000000000000 RSI: ffffffff81882421 RDI: 0000000000000006
RBP: ffff880194261050 R08: ffff8801aa76e6c0 R09: 0000000000000001
R10: ffffed003b5c46d6 R11: ffff8801dae236b3 R12: ffffffffa0010000
R13: ffffffffffffffff R14: dffffc0000000000 R15: ffff8801d9223730
FS:  0000000000000000(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4002000 CR3: 00000001817e0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
BUG: unable to handle kernel paging request at fffffbfff4002000
PGD 21fbea067 P4D 21fbea067 PUD 21fa5e067 PMD 1c4b80067 PTE 0
Thread overran stack, or stack corrupted
Oops: 0000 [#15] SMP KASAN
CPU: 0 PID: 12000 Comm: kworker/0:5 Not tainted 4.18.0-rc5+ #149
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
usercopy: Kernel memory overwrite attempt detected to process stack (offset  
0, size 8)!
usercopy: Kernel memory overwrite attempt detected to SLAB  
object 'kmalloc-4096' (offset 4120, size 2)!
------------[ cut here ]------------


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
