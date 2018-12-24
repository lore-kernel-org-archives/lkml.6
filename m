Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB1DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 05:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E118206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 05:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeLXFlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 00:41:04 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:42212 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLXFlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 00:41:04 -0500
Received: by mail-it1-f198.google.com with SMTP id g7so12975023itg.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 21:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CZkd8ASqdnCqXIFS0GdDHFZSX/NqGi41UyLAYrH9SpA=;
        b=gCuo3EzmPW5Srbyr1jzvT1s7jQZXbnfY04hLaiJC3CKVSEalBETpiEiE2FxdkF3Zve
         3+djVQrTh6y7hQEUwEL7qS1FQ350tgSG/5HjE400f3pX+DiLqC6Ua8Xr5WE+/fErBA9d
         tn6kkTgQn5uooRz6zQHX83hos8r6inpEruuQlra7W3pqgChAOjcHfC+teuG+ezMTuReR
         XCkAGdtEf3VzEo3OV1ZAviuHSjXg7SmqyvWoYIBgorWv24avMmm8ElBXLh3roKa4npNG
         iDrKG4KUlGNR89nV8nSKWrMxbS77dtslfOaIBkywsK1O6M1R5MxnJ47L89o7pjutZGBz
         sUog==
X-Gm-Message-State: AJcUukfLVA6ntmyTx6cwZXyrstDELf8HthCGH6t3e+8hBefgQNigK+SV
        yMVih/nCSaBmpeitYtWpBi2Nv/EL4thtW5B/RtQg0u91iDpE
X-Google-Smtp-Source: ALg8bN6fT0BlwI4NB0YzHx5P7e1Vvfycr3rpGb93f52XeDNqi2Uojk6cYomO+VkOb9OlWHlBF4xPstML/3zsJH9aMJhFKP6QLjSZ
MIME-Version: 1.0
X-Received: by 2002:a5e:9746:: with SMTP id h6mr203589ioq.4.1545630062957;
 Sun, 23 Dec 2018 21:41:02 -0800 (PST)
Date:   Sun, 23 Dec 2018 21:41:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db5b24057dbe0ab9@google.com>
Subject: INFO: rcu detected stall in netlink_sendmsg
From:   syzbot <syzbot+a910a514846e27f15348@syzkaller.appspotmail.com>
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

HEAD commit:    ce28bb445388 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12662e67400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67a2081147a23142
dashboard link: https://syzkaller.appspot.com/bug?extid=a910a514846e27f15348
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a910a514846e27f15348@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (10500 ticks this GP) idle=58a/1/0x4000000000000002  
softirq=84145/84145 fqs=0
rcu: 	 (t=10500 jiffies g=122913 q=1655)
rcu: rcu_preempt kthread starved for 10500 jiffies! g122913 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
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
CPU: 1 PID: 10942 Comm: syz-executor1 Not tainted 4.20.0-rc7+ #358
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
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x1/0x20 kernel/kcov.c:188
Code: fe ff ff 5d c3 0f 1f 40 00 55 0f b7 d6 0f b7 f7 bf 03 00 00 00 48 89  
e5 48 8b 4d 08 e8 88 fe ff ff 5d c3 66 0f 1f 44 00 00 55 <89> f2 89 fe bf  
05 00 00 00 48 89 e5 48 8b 4d 08 e8 6a fe ff ff 5d
RSP: 0018:ffff8881c195ef50 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 0000000000040000 RBX: 0000000000000004 RCX: ffffc90005f36000
RDX: 0000000000040000 RSI: 0000000000000004 RDI: 000000000000000e
RBP: ffff8881c195efc0 R08: ffff8881d7da2040 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8881d7da2040 R12: dffffc0000000000
R13: ffff8881c2e07c18 R14: ffff8881b8142d20 R15: 0000000001000000
  xfrm_policy_bysel_ctx+0x883/0x1050 net/xfrm/xfrm_policy.c:1664
  xfrm_get_policy+0x6a3/0x1140 net/xfrm/xfrm_user.c:1887
  xfrm_user_rcv_msg+0x44c/0x8e0 net/xfrm/xfrm_user.c:2663
  netlink_rcv_skb+0x16c/0x430 net/netlink/af_netlink.c:2477
  xfrm_netlink_rcv+0x6f/0x90 net/xfrm/xfrm_user.c:2671
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x59f/0x750 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfc0 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:621 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:631
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
  __sys_sendmsg+0x11d/0x280 net/socket.c:2154
  __do_sys_sendmsg net/socket.c:2163 [inline]
  __se_sys_sendmsg net/socket.c:2161 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457669
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fc47e41ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 000000002014f000 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc47e41b6d4
R13: 00000000004c44d8 R14: 00000000004d74e8 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
