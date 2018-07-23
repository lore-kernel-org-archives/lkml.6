Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E802ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7D20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB7D20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388816AbeGWSBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:01:10 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:41482 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388200AbeGWSBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:01:10 -0400
Received: by mail-io0-f197.google.com with SMTP id p12-v6so773362iog.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 09:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4J/BVpvw1b312T6ndcl2pNWuqBkVe7xUo2cQerPLCYg=;
        b=JoCNbvrwrDKN9dZQ5qfI6OOumTCh7zxccOBr2v3oZn+R8MEElNwdyIvRL7LxUmbS12
         kZ2af9DWxi5HZt2QGN5fM1WWSpDN95T6htoIedDP5EkI+Ee4qsDhC/1nTwNdQSg0AVIf
         mIEWTJOzV5kmO2JYLvhCYK1cNA+EF4WRpYNrGvE/f2Eaz0ucVdq/OSCkBEG/mZyftN/v
         QydsKrYr9cKeHiNo9XlYEl9gDtH0nGO0AXotpQNcbPZ6t2yC8V0A4VF4tTNtKrovEreS
         0f3Nuowkd3IOIupukfbNZV1Sv6DVt2ImYQ8puVnb8tBAvyBM/fSUpdVLHdF0n/xGFJ4l
         tdNg==
X-Gm-Message-State: AOUpUlHHDW1HQ7/o9Pfx5KWhLXFKFU2dy54dqhMl/sQ20dGURjALu4EM
        faajdL68q9fG3Y/3y+YEVAG5a0PSxWbiNNLI+6o5ymfxjdyx
X-Google-Smtp-Source: AAOMgpcVix1vwjLKK/4vX+891Ru37R6waiqcZSOqNp0N5gaRG3g5TOf2nKIKb9x14/lE5GwxILAxdAynQ6OqDyr502cvq+cA0W72
MIME-Version: 1.0
X-Received: by 2002:a6b:3805:: with SMTP id f5-v6mr5119586ioa.40.1532365142161;
 Mon, 23 Jul 2018 09:59:02 -0700 (PDT)
Date:   Mon, 23 Jul 2018 09:59:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f70a0e0571ad8ffb@google.com>
Subject: WARNING in untrack_pfn
From:   syzbot <syzbot+e1a4f80c370d2381e49f@syzkaller.appspotmail.com>
To:     dan.j.williams@intel.com, dave.jiang@intel.com,
        haozhong.zhang@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    89cf55353308 Add linux-next specific files for 20180720
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=127e408c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9641a83a066bb43
dashboard link: https://syzkaller.appspot.com/bug?extid=e1a4f80c370d2381e49f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=158f8f70400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e1a4f80c370d2381e49f@syzkaller.appspotmail.com

RBP: 000000000072bea0 R08: 0000000020000180 R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000008
R13: 00000000004bb85d R14: 00000000004c8d28 R15: 0000000000000037
CPU: 0 PID: 4581 Comm: syz-executor7 Not tainted 4.18.0-rc5-next-20180720+  
#12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
WARNING: CPU: 1 PID: 4578 at arch/x86/mm/pat.c:1039 untrack_pfn+0x2ac/0x310  
arch/x86/mm/pat.c:1039
Call Trace:
Kernel panic - not syncing: panic_on_warn set ...

  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x11 lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1557
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc+0x2af/0x760 mm/slab.c:3552
  anon_vma_alloc mm/rmap.c:82 [inline]
  anon_vma_fork+0x192/0x960 mm/rmap.c:341
  dup_mmap kernel/fork.c:476 [inline]
  dup_mm kernel/fork.c:1250 [inline]
  copy_mm kernel/fork.c:1305 [inline]
  copy_process.part.41+0x6705/0x73d0 kernel/fork.c:1819
  copy_process kernel/fork.c:1628 [inline]
  _do_fork+0x291/0x12a0 kernel/fork.c:2117
  __do_sys_clone kernel/fork.c:2224 [inline]
  __se_sys_clone kernel/fork.c:2218 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2218
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffea9330498 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00000000011b5914 RCX: 0000000000455ab9
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 000000000072bea0 R08: 0000000020000180 R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000008
R13: 00000000004bb85d R14: 00000000004c8d28 R15: 0000000000000037
CPU: 1 PID: 4578 Comm: syz-executor0 Not tainted 4.18.0-rc5-next-20180720+  
#12
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:996
RIP: 0010:untrack_pfn+0x2ac/0x310 arch/x86/mm/pat.c:1039
Code: 5e 41 5f 5d c3 e8 14 50 45 00 4c 89 ee 4c 89 ff e8 59 e3 ff ff e8 04  
50 45 00 4d 85 e4 0f 85 72 ff ff ff eb 9e e8 f4 4f 45 00 <0f> 0b eb 95 4c  
89 e7 e8 88 1a 84 00 e9 92 fe ff ff 48 8b bd 28 ff
RSP: 0018:ffff8801b485ee00 EFLAGS: 00010293
RAX: ffff8801b2b10100 RBX: 1ffff1003690bdc2 RCX: ffffffff81375594
RDX: 0000000000000000 RSI: ffffffff813756cc RDI: 0000000000000005
RBP: ffff8801b485eed8 R08: ffff8801b2b10100 R09: 0000000000000000
R10: ffffed003655e021 R11: ffff8801b2af010b R12: ffff8801b2918460
R13: 00000000ffffffea R14: ffff8801b485eeb0 R15: 0000000000000000
  unmap_single_vma+0x1c5/0x310 mm/memory.c:1538
  unmap_vmas+0x120/0x1f0 mm/memory.c:1589
  exit_mmap+0x2b5/0x5a0 mm/mmap.c:3113
  __mmput kernel/fork.c:977 [inline]
  mmput+0x265/0x620 kernel/fork.c:998
  dup_mm kernel/fork.c:1265 [inline]
  copy_mm kernel/fork.c:1305 [inline]
  copy_process.part.41+0x2b1e/0x73d0 kernel/fork.c:1819
  copy_process kernel/fork.c:1628 [inline]
  _do_fork+0x291/0x12a0 kernel/fork.c:2117
  __do_sys_clone kernel/fork.c:2224 [inline]
  __se_sys_clone kernel/fork.c:2218 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2218
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdd193e648 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000b34914 RCX: 0000000000455ab9
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 000000000072bea0 R08: 0000000020000180 R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000008
R13: 00000000004bb85d R14: 00000000004c8d28 R15: 0000000000000037
CPU: 0 PID: 4576 Comm: syz-executor1 Not tainted 4.18.0-rc5-next-20180720+  
#12
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  fail_dump lib/fault-inject.c:51 [inline]
  should_fail.cold.4+0xa/0x11 lib/fault-inject.c:149
  __should_failslab+0x124/0x180 mm/failslab.c:32
  should_failslab+0x9/0x14 mm/slab_common.c:1557
  slab_pre_alloc_hook mm/slab.h:423 [inline]
  slab_alloc mm/slab.c:3378 [inline]
  kmem_cache_alloc+0x47/0x760 mm/slab.c:3552
  anon_vma_chain_alloc mm/rmap.c:129 [inline]
  anon_vma_clone+0x140/0x740 mm/rmap.c:269
  anon_vma_fork+0xf0/0x960 mm/rmap.c:332
  dup_mmap kernel/fork.c:476 [inline]
  dup_mm kernel/fork.c:1250 [inline]
  copy_mm kernel/fork.c:1305 [inline]
  copy_process.part.41+0x6705/0x73d0 kernel/fork.c:1819
  copy_process kernel/fork.c:1628 [inline]
  _do_fork+0x291/0x12a0 kernel/fork.c:2117
  __do_sys_clone kernel/fork.c:2224 [inline]
  __se_sys_clone kernel/fork.c:2218 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2218
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455ab9
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff66d3e588 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000cfa914 RCX: 0000000000455ab9
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 000000000072bea0 R08: 0000000020000180 R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000008
R13: 00000000004bb85d R14: 00000000004c8d28 R15: 0000000000000037
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
