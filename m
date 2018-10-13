Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55819C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2528E20835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2528E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJMPHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:07:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51488 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeJMPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:07:07 -0400
Received: by mail-io1-f69.google.com with SMTP id z9-v6so11092795iog.18
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 00:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pvZ8DsnBEvcMFYzqYXE6O4tx/tJ7XBqls1bx4YJ5J5Q=;
        b=DWPqeYmNbFAlKXnDxDDJghiwEQVjfBCkpTiw2MTQ5ZqyxzyJzbubzD2goVQD9AGBko
         hc49EQaXgM0qUhCdOsky80EQV/bQRZLfP1Va3k4T2sRxQxZatKo8tvsFa/fxbvaG4OYh
         rHjhe2vRVPAxnbA22Z3g3ONxjAmy7PUFE7o5MfuLdoxzXChWGRwB28SrYhzFLJhLFUW6
         Wm5BJuAouSPSUC+JpMbRNqu6PaEF0sJD8/SYDA6WBcnPNkEQLKlVVLH+Ik0hbYR059iF
         bMoOOBxptoHFsk//lcW3iATjSGFZpFXK91fFWDz58CmgDnd5PMhfBSmmKZWrhHl7YnZ3
         MFRQ==
X-Gm-Message-State: ABuFfogJaE6eI5q5aJBEBpY+y7AHJ3Hhsp0Wlqd2Dh67jYozFOTXvWef
        62uXC62HpB6No3Tm98YMEogMuYDerClIbq1tnDkheeXK8vu/
X-Google-Smtp-Source: ACcGV62JGcUKtXE2PyT92N8L6MBuiFfKIglTOlydhSOnNQV63d2M44GQ0WTTXz1i7N6EHkWFuuYtfuSDWU/Pwg03NplmLn+CPFfd
MIME-Version: 1.0
X-Received: by 2002:a24:2f03:: with SMTP id j3-v6mr7145033itj.15.1539415862468;
 Sat, 13 Oct 2018 00:31:02 -0700 (PDT)
Date:   Sat, 13 Oct 2018 00:31:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4ee200578172fde@google.com>
Subject: INFO: rcu detected stall in do_idle
From:   syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, nstange@suse.de, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6b3944e42e2e afs: Fix cell proc list
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1545a479400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14825d5e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122cc531400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+385468161961cee80c31@syzkaller.appspotmail.com

sshd (5193) used greatest stack depth: 15496 bytes left
sched: DL replenish lagged too much
hrtimer: interrupt took 417330 ns
rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10520 jiffies, g=-1179, q=0)
rcu: All QSes seen, last rcu_sched kthread activity 10521  
(4295005425-4294994904), jiffies_till_next_fqs=1, root ->qsmask 0x0
swapper/0       R  running task    21816     0      0 0x80000000
Call Trace:
  <IRQ>
  sched_show_task.cold.83+0x2b6/0x30a kernel/sched/core.c:5296
  print_other_cpu_stall.cold.79+0xa83/0xba5 kernel/rcu/tree.c:1430
  check_cpu_stall kernel/rcu/tree.c:1557 [inline]
  __rcu_pending kernel/rcu/tree.c:3276 [inline]
  rcu_pending kernel/rcu/tree.c:3319 [inline]
  rcu_check_callbacks+0xafc/0x1990 kernel/rcu/tree.c:2665
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1029 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1054
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:864
RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:798 [inline]
RIP: 0010:__do_softirq+0x2c3/0xad8 kernel/softirq.c:276
Code: c7 c0 98 f2 31 89 48 c1 e8 03 42 80 3c 30 00 0f 85 17 07 00 00 48 83  
3d e2 ef 51 01 00 0f 84 6e 06 00 00 fb 66 0f 1f 44 00 00 <48> c7 85 68 fe  
ff ff 00 91 20 89 b8 ff ff ff ff 0f bc 85 74 fe ff
RSP: 0018:ffff8801dae07ae8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1263e53 RBX: ffffffff89276e40 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff892776bc
RBP: ffff8801dae07cc8 R08: ffffffff89276e40 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff1003b5c0fa1
R13: ffffffff89276e40 R14: dffffc0000000000 R15: 0000000000000000
  invoke_softirq kernel/softirq.c:372 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:412
  scheduler_ipi+0x55a/0xad0 kernel/sched/core.c:1780
  smp_reschedule_interrupt+0x109/0x650 arch/x86/kernel/smp.c:278
  reschedule_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:888
  </IRQ>
RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:57
Code: e9 2c ff ff ff 48 89 c7 48 89 45 d8 e8 e3 e0 11 fa 48 8b 45 d8 e9 ca  
fe ff ff 48 89 df e8 d2 e0 11 fa eb 82 55 48 89 e5 fb f4 <5d> c3 0f 1f 84  
00 00 00 00 00 55 48 89 e5 f4 5d c3 90 90 90 90 90
RSP: 0018:ffffffff89207bb8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff02
RAX: dffffc0000000000 RBX: 1ffffffff1240f7b RCX: 0000000000000000
RDX: 1ffffffff1263e54 RSI: 0000000000000001 RDI: ffffffff8931f2a0
RBP: ffffffff89207bb8 R08: ffffffff89276e40 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89207c78
R13: ffffffff89f3be20 R14: 0000000000000000 R15: 0000000000000000
  arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
  default_idle+0xbf/0x490 arch/x86/kernel/process.c:498
  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:489
  default_idle_call+0x6d/0x90 kernel/sched/idle.c:93
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x3db/0x5b0 kernel/sched/idle.c:262
  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
  rest_init+0xe2/0xe5 init/main.c:442
  start_kernel+0x8f4/0x92f init/main.c:739
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
  x86_64_start_kernel+0x76/0x79 arch/x86/kernel/head64.c:451
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
rcu: rcu_sched kthread starved for 10601 jiffies! g-1179 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_sched       R  running task    25144    11      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2825 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3473
  schedule+0xfe/0x460 kernel/sched/core.c:3517
  schedule_timeout+0x140/0x260 kernel/time/timer.c:1804
  rcu_gp_kthread+0x9d9/0x2310 kernel/rcu/tree.c:2194
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
