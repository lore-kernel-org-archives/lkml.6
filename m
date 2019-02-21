Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B328A20700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfBUOtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:49:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:55890 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfBUOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:49:04 -0500
Received: by mail-it1-f198.google.com with SMTP id j3so15604190itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=c5ODwyzlBndhyv8sPBPtgiNnikaFeeuMEVGCcNnGFvE=;
        b=Bq1yBdmBsYZ0L97Ra0XJ90xFexK2AiKq3GAo1iQUpUVAc66IIAlDhpxs4+wBWM7PWe
         T5Hpyct2Ra4hHZ8w4G48Z1EkfHCAY4hMw2jZCiHOTDlbWQ5pnNo3xffCxFemArHyNGqw
         FZtA6rW1gs7wuYCuau1Sx/r1pTSwtJLrSluH42aaHchJSf1aDqaXxK7jd5UOW7PyiZh4
         N23s/av5AKDsIQN3Jxh4tIc5iwU+686gg8u5LVjxZFd9KkbqdVy3uVdRJIKdv+QNkvfa
         pmf/k+e2sX/yhlkL3mW5mrvv6xviEzrG3yUW+4vk/c1bvRrKKwZQXxiZLktPgr9h/7/r
         Hztw==
X-Gm-Message-State: AHQUAuYGv0DABKmKbmedbsAtJ4Za7rI8AWD7DBWIinWWsywaORMsimGL
        MDXDPvfxQTc1FfNEo5zH7L7darDVhPdWJbQWTdnstm+Yxmyc
X-Google-Smtp-Source: AHgI3IYk/3BkkVlnpffsLduVLqgFAtgMvG7CghPAJ+yrqkSsCjgE1fQ1l/y6nV7GGtTrOOf8V+gsNmLxizheIJ7gStRuwBzwoviD
MIME-Version: 1.0
X-Received: by 2002:a24:43:: with SMTP id 64mr7098081ita.19.1550760543324;
 Thu, 21 Feb 2019 06:49:03 -0800 (PST)
Date:   Thu, 21 Feb 2019 06:49:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005116810582689334@google.com>
Subject: INFO: rcu detected stall in try_check_zero
From:   syzbot <syzbot+7dac0c08116b7c22a9e4@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    57902dc0670c Merge tag 'riscv-for-linus-5.0-rc7' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150813e4c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=7dac0c08116b7c22a9e4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7dac0c08116b7c22a9e4@syzkaller.appspotmail.com

kvm: vcpu 0: requested 34784 ns lapic timer period limited to 200000 ns
Sysenter RSP=0000000000000000 CS:RIP=0000:0000000000000000
CS:   sel=0x0000, attr=0x10000, limit=0x00000000, base=0x0000000000000000
EXT4-fs warning (device sda1): ext4_group_add:1636: No reserved GDT blocks,  
can't resize
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (1 ticks this GP) idle=342/1/0x4000000000000002  
softirq=74727/74727 fqs=0
rcu: 	 (t=11211 jiffies g=92145 q=633)
rcu: rcu_preempt kthread starved for 11211 jiffies! g92145 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29024    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2844 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3485
  schedule+0x92/0x180 kernel/sched/core.c:3529
  schedule_timeout+0x4db/0xfd0 kernel/time/timer.c:1803
  rcu_gp_fqs_loop kernel/rcu/tree.c:1948 [inline]
  rcu_gp_kthread+0x956/0x17a0 kernel/rcu/tree.c:2105
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 1
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.0.0-rc6+ #69
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: rcu_gp process_srcu
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x183/0x1cf kernel/rcu/tree.c:1211
  print_cpu_stall kernel/rcu/tree.c:1348 [inline]
  check_cpu_stall kernel/rcu/tree.c:1422 [inline]
  rcu_pending kernel/rcu/tree.c:3018 [inline]
  rcu_check_callbacks.cold+0x500/0xa4a kernel/rcu/tree.c:2521
  update_process_times+0x32/0x80 kernel/time/timer.c:1635
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:161
  tick_sched_timer+0x47/0x130 kernel/time/tick-sched.c:1271
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x33e/0xde0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x120/0x570 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:preempt_schedule_irq+0xab/0x140 kernel/sched/core.c:3712
Code: 00 00 e8 08 d3 4b fa e8 e3 4f 73 fa 4c 89 f0 48 c1 e8 03 80 3c 18 00  
75 6c 48 83 3d ae 88 90 01 00 74 5e fb 66 0f 1f 44 00 00 <bf> 01 00 00 00  
e8 cb d5 ff ff 48 c7 c0 f8 81 92 88 48 c1 e8 03 80
RSP: 0018:ffff8880a98f7ad8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1125040 RBX: dffffc0000000000 RCX: 1ffff1101531d9ae
RDX: 0000000000000000 RSI: ffff8880a98ecd50 RDI: ffff8880a98eccfc
RBP: ffff8880a98f7af8 R08: ffff8880a98ec480 R09: ffff8880a98ecd70
R10: 0000000000000000 R11: 0000000000000000 R12: ffffed101531d890
R13: ffff8880a98ec480 R14: ffffffff88928200 R15: 0000000000000000
  retint_kernel+0x1b/0x2d
RIP: 0010:delay_tsc+0x33/0xc0 arch/x86/lib/delay.c:68
Code: bf 01 00 00 00 41 55 41 54 53 e8 c8 2a 4d fa e8 63 78 2a fc 41 89 c5  
0f ae e8 0f 31 48 c1 e2 20 48 09 c2 49 89 d4 eb 16 f3 90 <bf> 01 00 00 00  
e8 a3 2a 4d fa e8 3e 78 2a fc 44 39 e8 75 36 0f ae
RSP: 0018:ffff8880a98f7bb0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff02
RAX: 0000000080000000 RBX: 0000019b9f7d4c70 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff832b1798 RDI: 0000000000000001
RBP: ffff8880a98f7bd0 R08: ffff8880a98ec480 R09: 0000000000000040
R10: 0000000000000040 R11: ffffffff88a41667 R12: 0000019b9f7d2877
R13: 0000000000000001 R14: 0000000000002ced R15: 00000000000011df
  __delay arch/x86/lib/delay.c:161 [inline]
  __const_udelay+0x5f/0x80 arch/x86/lib/delay.c:175
  try_check_zero+0x201/0x330 kernel/rcu/srcutree.c:730
  srcu_advance_state kernel/rcu/srcutree.c:1167 [inline]
  process_srcu+0x329/0xec0 kernel/rcu/srcutree.c:1261
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
DS:   sel=0x0000, attr=0x10000, limit=0x00000000, base=0x0000000000000000
SS:   sel=0x0000, attr=0x10000, limit=0x00000000, base=0x0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
