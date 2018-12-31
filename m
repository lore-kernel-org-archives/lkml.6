Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D58CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 03:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65A520B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 03:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbeLaDeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 22:34:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:34659 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeLaDeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 22:34:05 -0500
Received: by mail-io1-f72.google.com with SMTP id q16so6942514ios.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 19:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LrDzP082OCCcYjYO+wpDkL1rygKTROYsWPOk7EjLTRo=;
        b=GHXPNAa1tkBqHqr+dWQasIiroYd3qwpzPQ5BbrnOk1w0/KhaTRcre2cXqlc5imsywN
         3C6Dlk2HfSGa38V9EIlVRTVjuOts01P0T1Bcm6aOdiSM4o/zFbjqueY5NwqArX7Z6v4A
         raA9CqnzaPT6Wmr21um1uikMSn7b0NC3JDQyJaSQcYZZXqB/odB3jFULlnHvkG18KBYN
         KdeqNRXhqCGqfGmdTPxwkQySfhDe8Agks3jlNkLDtK1CyaNAlBIok0262ATV4Jqp4/A1
         RjgKVhDwosrPy+Qt/wbAq7blgLL6Fhumfm8c2J8oizeL8oHlJkqWRFvDHThEsT2g0jAq
         2nAA==
X-Gm-Message-State: AA+aEWYu5/+tsscEjPpDstvhrPqCh/nl8q0VB8Us7pc7Mn0wJs/6DL/O
        u3gJTL9YC053fsIEz20S06dsTiZ0LT+p9Kn3IGi67kqnVr0z
X-Google-Smtp-Source: AFSGD/VDStuOcBYO2XkYIGV9nBrE7xeOCgRyHa8piUV+GP8KKu97l4UGqdnLrnDpkIEmWUi9/tqqlPEIoht7ExoDO9NtmFNV7bTV
MIME-Version: 1.0
X-Received: by 2002:a24:7381:: with SMTP id y123mr25358983itb.32.1546227244226;
 Sun, 30 Dec 2018 19:34:04 -0800 (PST)
Date:   Sun, 30 Dec 2018 19:34:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a26437057e4915ff@google.com>
Subject: INFO: rcu detected stall in igmp_ifc_timer_expire
From:   syzbot <syzbot+041483004a7f45f1f20a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b71acb0e3721 Merge branch 'linus' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1270bbdd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbee5876573727cd
dashboard link: https://syzkaller.appspot.com/bug?extid=041483004a7f45f1f20a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+041483004a7f45f1f20a@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (1 GPs behind) idle=f3e/1/0x4000000000000004  
softirq=83230/83231 fqs=14
rcu: 	 (t=10501 jiffies g=106569 q=897)
rcu: rcu_preempt kthread starved for 10474 jiffies! g106569 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     I22032    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2831 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3472
  schedule+0xfe/0x460 kernel/sched/core.c:3516
  schedule_timeout+0x140/0x260 kernel/time/timer.c:1803
  rcu_gp_fqs_loop+0x762/0xa80 kernel/rcu/tree.c:1948
  rcu_gp_kthread+0x341/0xc70 kernel/rcu/tree.c:2105
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 0
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 4.20.0+ #362
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: rcu_gp process_srcu
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1c2/0x22c lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1211
  print_cpu_stall.cold.68+0x218/0x40a kernel/rcu/tree.c:1348
  check_cpu_stall kernel/rcu/tree.c:1422 [inline]
  rcu_pending kernel/rcu/tree.c:3018 [inline]
  rcu_check_callbacks+0xac1/0x1410 kernel/rcu/tree.c:2521
  update_process_times+0x2d/0x70 kernel/time/timer.c:1635
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:161
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1271
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x4/0x20 kernel/kcov.c:195
Code: 66 0f 1f 44 00 00 55 89 f2 89 fe bf 05 00 00 00 48 89 e5 48 8b 4d 08  
e8 6a fe ff ff 5d c3 0f 1f 84 00 00 00 00 00 55 48 89 f2 <48> 89 fe bf 07  
00 00 00 48 89 e5 48 8b 4d 08 e8 48 fe ff ff 5d c3
RSP: 0018:ffff8880ae606cb8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffffed1015cc0dd7 RBX: 0000000000000000 RCX: ffffffff86c3afc1
RDX: ffff888062f97208 RSI: ffff888062f97208 RDI: 0000000000000000
RBP: ffff8880ae606f80 R08: ffff8880a9de6140 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8880a9de6140 R12: ffff888062f97208
R13: dffffc0000000000 R14: ffff888062f97200 R15: 00000000ffffffff
  xfrm_policy_lookup+0x7e/0x80 net/xfrm/xfrm_policy.c:2145
  xfrm_bundle_lookup net/xfrm/xfrm_policy.c:2939 [inline]
  xfrm_lookup_with_ifid+0x972/0x2b80 net/xfrm/xfrm_policy.c:3080
  xfrm_lookup net/xfrm/xfrm_policy.c:3172 [inline]
  xfrm_lookup_route+0x3c/0x1f0 net/xfrm/xfrm_policy.c:3183
  ip_route_output_flow+0xb1/0xc0 net/ipv4/route.c:2582
  ip_route_output_ports include/net/route.h:161 [inline]
  igmpv3_newpack+0x541/0x1430 net/ipv4/igmp.c:362
  add_grhead.isra.29+0x235/0x300 net/ipv4/igmp.c:433
  add_grec+0x106b/0x1350 net/ipv4/igmp.c:566
  igmpv3_send_cr net/ipv4/igmp.c:696 [inline]
  igmp_ifc_timer_expire+0x5d2/0xbe0 net/ipv4/igmp.c:793
  call_timer_fn+0x272/0x920 kernel/time/timer.c:1325
  expire_timers kernel/time/timer.c:1362 [inline]
  __run_timers+0x7e5/0xc70 kernel/time/timer.c:1681
  run_timer_softirq+0x52/0xb0 kernel/time/timer.c:1694
  __do_softirq+0x30c/0xb2e kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x17f/0x1c0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1cb/0x760 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:rdtsc arch/x86/include/asm/msr.h:207 [inline]
RIP: 0010:rdtsc_ordered arch/x86/include/asm/msr.h:232 [inline]
RIP: 0010:delay_tsc+0x4c/0xc0 arch/x86/lib/delay.c:61
Code: e8 0f 31 48 c1 e2 20 48 09 c2 49 89 d4 eb 16 f3 90 bf 01 00 00 00 e8  
33 1a 71 f9 e8 4e 9c ab fb 44 39 f0 75 36 0f ae e8 0f 31 <48> c1 e2 20 48  
89 d3 48 09 c3 48 89 d8 4c 29 e0 4c 39 e8 73 24 bf
RSP: 0018:ffff8880a9dff128 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 00000000e5a9cbe0 RBX: 0000014ce5a9cb06 RCX: ffffffff839297ca
RDX: 000000000000014c RSI: ffffffff839297d8 RDI: 0000000000000005
RBP: ffff8880a9dff148 R08: ffff8880a9de6140 R09: 1ffffd1ffffa0e00
R10: ffff8880a9dff250 R11: ffffffff8b33a227 R12: 0000014ce5a9b8f7
R13: 0000000000002ced R14: 0000000000000000 R15: ffffffff8b339e80
  __delay arch/x86/lib/delay.c:161 [inline]
  __const_udelay+0x62/0x80 arch/x86/lib/delay.c:175
  try_check_zero+0x384/0x5f0 kernel/rcu/srcutree.c:730
  srcu_advance_state kernel/rcu/srcutree.c:1167 [inline]
  process_srcu+0x6bf/0x1460 kernel/rcu/srcutree.c:1261
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
