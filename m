Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE76C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CD821019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 08:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeLaIDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 03:03:05 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:59264 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeLaIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 03:03:04 -0500
Received: by mail-it1-f198.google.com with SMTP id p21so28882203itb.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 00:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0k9NZuVb4n8iyYpV0AQdlr2djICXQ/Mea1gEl7dtGSA=;
        b=AYQAUah4iEegx9F1x8NnV0mxrCKkFkyBeCBXzs/FQKyMAKfxRTXCDypqbewU11ewtW
         AH4laceop+Vk+5VlRXgNSQsTXh6A9MqyP7cJDF8xecm32sauUg3tV3z6YtynaAF4YzPH
         ML24Nn+ryz1diM8gbvOyG45Pu1UtUXc6dxt8i2f9d4y8OfKKGdpHpHBDJblUw+Kffctz
         NqZtclGqIh9czywZ2Gpp/4kBDFuugUkVB8GHJuyZI49nuyfPvkZWPJk/kyzkmNF1r2il
         Z7uyIFD8MYf0uccGFhpLITC+XSdsmxtQpp2qKonuhcNARw2RbpGK7hc3mvU1ThFdOCvd
         LqDA==
X-Gm-Message-State: AJcUukd+ZEZd6x+Cch8pHCzdxM+uV2R8/0JdYTFgJToWcW3tJg/UAjH4
        2ooWhw+i4cF74MPfnHOTHWjYOkRDiP04w7tkL2+q4Az/4D39
X-Google-Smtp-Source: ALg8bN7Slk7q3X9dKiGoOURt3nWY4BmHDbAcp5hsRt8N/o6HgURCZFC/VX//ilsicl7zCjojEeI75RxWUrHUAOF1ytasqpskmzQj
MIME-Version: 1.0
X-Received: by 2002:a6b:8e83:: with SMTP id q125mr34641266iod.9.1546243383448;
 Mon, 31 Dec 2018 00:03:03 -0800 (PST)
Date:   Mon, 31 Dec 2018 00:03:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b5ae5057e4cd7d1@google.com>
Subject: INFO: rcu detected stall in x25_connect
From:   syzbot <syzbot+564c57b4bf1df3ce1c94@syzkaller.appspotmail.com>
To:     andrew.hendry@gmail.com, davem@davemloft.net, dvlasenk@redhat.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    38355a5f9a22 bnx2x: Fix NULL pointer dereference in bnx2x_..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe1677400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a91d685acb971514
dashboard link: https://syzkaller.appspot.com/bug?extid=564c57b4bf1df3ce1c94
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+564c57b4bf1df3ce1c94@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (1 GPs behind) idle=b82/1/0x4000000000000002  
softirq=245727/245728 fqs=2
rcu: 	 (t=10500 jiffies g=375665 q=22)
rcu: rcu_preempt kthread starved for 10496 jiffies! g375665 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: RCU grace-period kthread stack dump:
rcu_preempt     I22568    10      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2831 [inline]
  __schedule+0x86c/0x1ed0 kernel/sched/core.c:3472
  schedule+0xfe/0x460 kernel/sched/core.c:3516
  schedule_timeout+0x140/0x260 kernel/time/timer.c:1804
  rcu_gp_fqs_loop+0x762/0xa80 kernel/rcu/tree.c:1934
  rcu_gp_kthread+0x341/0xc70 kernel/rcu/tree.c:2090
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 1
CPU: 1 PID: 23613 Comm: syz-executor0 Not tainted 4.20.0-rc7+ #249
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x63/0xa2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1c2/0x22c lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1195
  print_cpu_stall.cold.65+0x1f3/0x3c6 kernel/rcu/tree.c:1334
  check_cpu_stall kernel/rcu/tree.c:1408 [inline]
  rcu_pending kernel/rcu/tree.c:2961 [inline]
  rcu_check_callbacks+0xac1/0x1410 kernel/rcu/tree.c:2506
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:__x25_find_socket+0x6c/0x110 net/x25/af_x25.c:327
Code: 2f e8 d8 a9 87 fa 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f  
85 a1 00 00 00 48 8b 5b 68 48 85 db 74 7c e8 b4 a9 87 fa <48> 83 eb 68 74  
71 e8 a9 a9 87 fa 48 8d bb 88 04 00 00 48 89 f8 48
RSP: 0018:ffff88806485faa8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000040000 RBX: ffff88809f242a68 RCX: ffffc90005df9000
RDX: 0000000000040000 RSI: ffffffff86f6b08c RDI: ffff88809f242a68
RBP: ffff88806485fad0 R08: ffff88808e4e8700 R09: fffffbfff13fc688
R10: fffffbfff13fc688 R11: ffffffff89fe3443 R12: dffffc0000000000
R13: 0000000000000001 R14: ffff88809b212940 R15: 0000000000000000
  x25_new_lci net/x25/af_x25.c:357 [inline]
  x25_connect+0x380/0x1050 net/x25/af_x25.c:786
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4579b9
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb14afb2c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004579b9
RDX: 0000000000000012 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb14afb36d4
R13: 00000000004be22e R14: 00000000004ce488 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
