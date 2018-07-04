Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D9C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D70208E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D70208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeGDPLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:11:06 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:53132 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeGDPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:11:03 -0400
Received: by mail-io0-f197.google.com with SMTP id y26-v6so3409139iob.19
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4FwfsNJ7ZSqHIxXTyPnk/5y3Fv2nnMmLwLxwosdaltQ=;
        b=AsG81ACpNov2Z2EaBtFE8lvSHyxU552T90QF177cwOytSlb9BTYkmdBs0e72P9Kysi
         KUHMEIp+ApA07JF+RJrFGLP23FQzPARqgzdFYrj47CvpFLscZD2+axoVimdYhtUihfOb
         hj3cxKHjRgRrgIKw7CdTCzHdeV9aasHnF37lJUc3GpxtIxBq+1ODvvL5eaEbagSBXi+6
         a/7OVtVAENKnLZi7/uC9gWj+3ZoVNJHVvVvpIhMdg0OU1Z/4ojKcVxhKmCZ8prmvy+JN
         hlaCo2FYce9CEUV/uT5J2Oy7ae6BAwsfyLNRyWxFL5TMezkGUOAZ/iauFUbPBR7gbhyv
         uZHw==
X-Gm-Message-State: AOUpUlH3TYSNiTv1TdjeBuLf4rRRdPUHVBIF8mr9OGi2I3i5sk7dGrL5
        8qf0EGRxDbvsezo/WJt93ebtr/MEgXuaYOCcJb/aEHew7U7b
X-Google-Smtp-Source: AAOMgpchAbA12qT1D9UeuGDwLN6Qc7hAQ5eyct69UH688JkOF22BcwIam3njfbguoz7lFH54r9kT+EVMnJdnIWWLrBPoTDpzGhfi
MIME-Version: 1.0
X-Received: by 2002:a6b:4501:: with SMTP id s1-v6mr915040ioa.42.1530717062576;
 Wed, 04 Jul 2018 08:11:02 -0700 (PDT)
Date:   Wed, 04 Jul 2018 08:11:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c443f505702dd6fb@google.com>
Subject: KASAN: stack-out-of-bounds Read in switch_mm_irqs_off
From:   syzbot <syzbot+6cea61a6cd1e9ae6b195@syzkaller.appspotmail.com>
To:     dave.hansen@linux.intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=136a7e0c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
dashboard link: https://syzkaller.appspot.com/bug?extid=6cea61a6cd1e9ae6b195
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6cea61a6cd1e9ae6b195@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in switch_mm_irqs_off+0x13db/0x16c0  
arch/x86/mm/tlb.c:275
PANIC: double fault, error_code: 0x0
Read of size 8 at addr ffff8801957727f0 by task swapper/0/0
CPU: 1 PID: 6433 Comm: syz-executor2 Not tainted 4.18.0-rc3+ #45

Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc3+ #45
RIP: 0010:__lock_acquire+0x2e/0x5020 kernel/locking/lockdep.c:3294
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Code:
Call Trace:
41 57
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
41
89 cf
41 56
41 55
49 89
  print_address_description+0x6c/0x20b mm/kasan/report.c:256
fd
41
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
54
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
45
  switch_mm_irqs_off+0x13db/0x16c0 arch/x86/mm/tlb.c:275
89 cc
53
65
4c
8b 34 25
40
ee
01 00
48
83
e4 f0
  context_switch kernel/sched/core.c:2850 [inline]
  __schedule+0x79c/0x1ed0 kernel/sched/core.c:3504
48 81
ec
60 03
00
00
48
8b
45 10
<89>
  schedule_idle+0x45/0x80 kernel/sched/core.c:3575
94 24
  do_idle+0x17f/0x570 kernel/sched/idle.c:286
80
00
00
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
00
48 ba
00
00
  rest_init+0xe1/0xe4 init/main.c:442
00 00
  start_kernel+0x90e/0x949 init/main.c:738
00
fc
ff df
48
89 84
24 98
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:452
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:433
RSP: 0018:ffff880193f7eea0 EFLAGS: 00010086
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
RAX: 0000000000000000 RBX: 1ffff100327efe50 RCX: 0000000000000002

RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff88f92620
Allocated by task 4496:
RBP: ffff880193f7f228 R08: 0000000000000000 R09: 0000000000000000
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
R10: ffff880195aa71b8 R11: ffff8801daf236b3 R12: 0000000000000000
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
R13: ffffffff88f92620 R14: ffff8801aa290440 R15: 0000000000000002
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
FS:  00007f39fda9b700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  dup_mm kernel/fork.c:1234 [inline]
  copy_mm kernel/fork.c:1297 [inline]
  copy_process.part.40+0x235f/0x7220 kernel/fork.c:1803
CR2: ffff880193f7ee98 CR3: 00000001d6d6a000 CR4: 00000000001406e0
  copy_process kernel/fork.c:1616 [inline]
  _do_fork+0x291/0x12a0 kernel/fork.c:2099
DR0: 00000000200001c0 DR1: 0000000020000000 DR2: 0000000000000000
  __do_sys_clone kernel/fork.c:2206 [inline]
  __se_sys_clone kernel/fork.c:2200 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2200
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
