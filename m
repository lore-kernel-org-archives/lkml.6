Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA7AECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F68208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F68208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbeGMDLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:11:34 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:51479 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbeGMDLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:11:34 -0400
Received: by mail-io0-f199.google.com with SMTP id w23-v6so17221815iob.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 19:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=p3OycOx0Lh06I8BKQvRpuFoT00SKKuRd810Z973OTvQ=;
        b=bhxEWqZMntHQ7gfi9feKZR+Za1C1K4kr+QMs9SrkIUrbcBssOsmuxnuV9AIXbtAQWo
         gu1Ljk3eTPtoVr34LGB7XGZU7G8Chq4w+4TqmVZNf9Y7S4Ibxc117aSrzetgozQZUZZs
         CREIIrZFqYKaF/R4O0aRxrhGMLIBlS4gtdQlp6o7xIPSn/RZEU9nMWQ9pWLfCSjkQsz/
         lgwnKhCyPY9n83LZan/3GXnVp1+B9lTTmaGwLEQjPR52a7bZ7poxmKH9GcJ5+npsabWo
         Co48lv4SSEkf5wLgOMRE/eWcy0s/ufnZ1l6qPl3JeB338wwjVdlPuRjCv3FOW/DSE+ou
         EeZQ==
X-Gm-Message-State: AOUpUlHxC88nCsLRzfcdG00kDe1PqKfUABi+6bc6PHlusRf73GxbJyv3
        F/f3j94jtLAecdXgHEu9TtnLhapjCGaC+V/a8/u8IJSfPqxp
X-Google-Smtp-Source: AAOMgpeCM+eQCQv8/u/E9o+aBhQX/Wj+y8NFJA42ayaWpwqlA78adLtx0vXBqH9j+8GJ2JMJCem/1WJ877ADlVm2EPcTNerpN41t
MIME-Version: 1.0
X-Received: by 2002:a6b:cb06:: with SMTP id b6-v6mr1916515iog.107.1531450743349;
 Thu, 12 Jul 2018 19:59:03 -0700 (PDT)
Date:   Thu, 12 Jul 2018 19:59:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c6be40570d8a9d8@google.com>
Subject: general protection fault in propagate_entity_cfs_rq
From:   syzbot <syzbot+2e37f794f31be5667a88@syzkaller.appspotmail.com>
To:     andy.shevchenko@gmail.com, douly.fnst@cn.fujitsu.com,
        hpa@zytor.com, jgross@suse.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, ville.syrjala@linux.intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6fd066604123 Merge branch 'bpf-arm-jit-improvements'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e92678400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=2e37f794f31be5667a88
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1014db94400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f81e78400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e37f794f31be5667a88@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): team0: link is not ready
8021q: adding VLAN 0 to HW filter on device team0
IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.18.0-rc3+ #51
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:propagate_entity_cfs_rq.isra.70+0x199/0x20c0  
kernel/sched/fair.c:10039
Code: 0d 02 00 00 48 c7 c0 60 70 2a 89 48 89 f9 48 c1 e8 03 48 01 d8 48 89  
85 28 fb ff ff 4c 8d a9 58 01 00 00 4c 89 e8 48 c1 e8 03 <80> 3c 18 00 0f  
85 5e 11 00 00 4c 8b a1 58 01 00 00 0f 1f 44 00 00
RSP: 0018:ffff8801daf06c90 EFLAGS: 00010003
RAX: 03fffe20074fc1d0 RBX: dffffc0000000000 RCX: 1ffff1003a7e0d2c
RDX: 1ffff1003a7e0d2a RSI: 1ffff1003b5e0e7f RDI: 1ffff1003a7e0d2c
RBP: ffff8801daf071a0 R08: ffff8801dae2cbc0 R09: 1ffffffff11a25cc
R10: 00000000019d6e0b R11: 0000000000000000 R12: 1ffff1003b5e0e3b
R13: 1ffff1003a7e0e84 R14: ffff8801d3f06800 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb1b24d7e78 CR3: 00000001ab04b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  detach_entity_cfs_rq+0x6e3/0xf50 kernel/sched/fair.c:10059
  migrate_task_rq_fair+0xba/0x290 kernel/sched/fair.c:6709
  set_task_cpu+0x131/0x770 kernel/sched/core.c:1194
  detach_task.isra.89+0xdb/0x150 kernel/sched/fair.c:7438
  detach_tasks kernel/sched/fair.c:7525 [inline]
  load_balance+0xf0b/0x3640 kernel/sched/fair.c:8884
  rebalance_domains+0x82a/0xd90 kernel/sched/fair.c:9262
  run_rebalance_domains+0x365/0x4c0 kernel/sched/fair.c:9884
  __do_softirq+0x2e8/0xb17 kernel/softirq.c:288
  invoke_softirq kernel/softirq.c:368 [inline]
  irq_exit+0x1d1/0x200 kernel/softirq.c:408
  exiting_irq arch/x86/include/asm/apic.h:527 [inline]
  smp_apic_timer_interrupt+0x186/0x730 arch/x86/kernel/apic/apic.c:1052
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
Code: c7 48 89 45 d8 e8 5a 04 24 fa 48 8b 45 d8 e9 d2 fe ff ff 48 89 df e8  
49 04 24 fa eb 8a 90 90 90 90 90 90 90 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffff8801d9af7c38 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffff1003b35ef8a RCX: ffffffff81667982
RDX: 1ffffffff11e3610 RSI: 0000000000000004 RDI: ffffffff88f1b080
RBP: ffff8801d9af7c38 R08: ffffed003b5e46d7 R09: ffffed003b5e46d6
R10: ffffed003b5e46d6 R11: ffff8801daf236b3 R12: 0000000000000001
R13: ffff8801d9af7cf0 R14: ffffffff899edd20 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xc7/0x450 arch/x86/kernel/process.c:500
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:491
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3aa/0x570 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  start_secondary+0x433/0x5d0 arch/x86/kernel/smpboot.c:265
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace cb0cd83b57bb4bba ]---
RIP: 0010:propagate_entity_cfs_rq.isra.70+0x199/0x20c0  
kernel/sched/fair.c:10039
Code: 0d 02 00 00 48 c7 c0 60 70 2a 89 48 89 f9 48 c1 e8 03 48 01 d8 48 89  
85 28 fb ff ff 4c 8d a9 58 01 00 00 4c 89 e8 48 c1 e8 03 <80> 3c 18 00 0f  
85 5e 11 00 00 4c 8b a1 58 01 00 00 0f 1f 44 00 00
RSP: 0018:ffff8801daf06c90 EFLAGS: 00010003
RAX: 03fffe20074fc1d0 RBX: dffffc0000000000 RCX: 1ffff1003a7e0d2c
RDX: 1ffff1003a7e0d2a RSI: 1ffff1003b5e0e7f RDI: 1ffff1003a7e0d2c
RBP: ffff8801daf071a0 R08: ffff8801dae2cbc0 R09: 1ffffffff11a25cc
R10: 00000000019d6e0b R11: 0000000000000000 R12: 1ffff1003b5e0e3b
R13: 1ffff1003a7e0e84 R14: ffff8801d3f06800 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb1b24d7e78 CR3: 00000001ab04b000 CR4: 00000000001406e0
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
