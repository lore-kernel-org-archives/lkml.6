Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAB7C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46AD2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeLSShG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:37:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:55397 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbeLSShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:37:04 -0500
Received: by mail-it1-f198.google.com with SMTP id j3so7463512itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1IbbA9fH2zZ8HgrPn/ZNdu+pDYuYGcB9YkBNoaRGtpo=;
        b=VwQvAgWm2Ex4II2ZOnryPbpp/8aTCkKdPn3xDnMlqKNiB5PdJmBtNRr8FvCb3TPF8u
         M842FysWUAdcbaiaO8VDLAYbI0mrgH9HBLk6ftNjOy32vEZJl6vT4rMLJMjZO0XLTEmH
         Qbzw2dZ/gX0zM/N7gjL2astrD+9Bc378g8Sw3EjIzllX8qyjHO0r+Lb81Lw7njgACL3t
         J5yIHpmOXvV+lehU8CyWbCwGjdbFUTipXbq/ijwaVSihkj5q3mbrEAUvnr4t/Q93Ffv1
         n/khu/GHmY/tLih2gYswK76MzgNHPRXTPuSmLOJfrcpDIpc5toI4as6dt9Q+hJwv3YF3
         X54g==
X-Gm-Message-State: AA+aEWbeYEdtt99c34nB6HCZqCuhjmrMVKc8IhEF2Vt7qO9xcYbOHUnx
        WI5gtHJoDpRrJP/DCqnnliWRXexaB9sIod7fattkabJ4FhxQ
X-Google-Smtp-Source: AFSGD/XI6H+uGY9fV9zgdJsO0nzNsvoir52RaqyzEb3/GUjci3RgUV+mITvIiOiO3kp0CTqWYxVQnbno35EaMD5xfozqL0XAuFv9
MIME-Version: 1.0
X-Received: by 2002:a02:b5e5:: with SMTP id y34mr18171218jaj.21.1545244623196;
 Wed, 19 Dec 2018 10:37:03 -0800 (PST)
Date:   Wed, 19 Dec 2018 10:37:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db57ce057d644c81@google.com>
Subject: INFO: rcu detected stall in pfkey_sendmsg
From:   syzbot <syzbot+e1d3a7522b4d05aeede4@syzkaller.appspotmail.com>
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

HEAD commit:    a26d94bff4d5 net: bridge: remove unneeded variable 'err'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14c7a4cd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
dashboard link: https://syzkaller.appspot.com/bug?extid=e1d3a7522b4d05aeede4
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e1d3a7522b4d05aeede4@syzkaller.appspotmail.com

ip6_tunnel: ip6tnl1 xmit: Local address not yet configured!
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (1 GPs behind) idle=9e6/1/0x4000000000000002  
softirq=418161/418162 fqs=5249
rcu: 	 (t=10502 jiffies g=488537 q=1706)
NMI backtrace for cpu 1
CPU: 1 PID: 18240 Comm: syz-executor3 Not tainted 4.20.0-rc6+ #352
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.2+0x5c/0xa1 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1e8/0x22a lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x16f/0x1bc kernel/rcu/tree.c:1195
  print_cpu_stall.cold.67+0x1f3/0x3c7 kernel/rcu/tree.c:1334
  check_cpu_stall kernel/rcu/tree.c:1408 [inline]
  rcu_pending kernel/rcu/tree.c:2961 [inline]
  rcu_check_callbacks+0xf3b/0x13f0 kernel/rcu/tree.c:2506
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
RIP: 0010:__read_once_size include/linux/compiler.h:182 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:69 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x20/0x50 kernel/kcov.c:101
Code: 4c d8 20 4c 89 08 5d c3 66 90 55 48 89 e5 48 8b 75 08 65 48 8b 04 25  
40 ee 01 00 65 8b 15 28 69 82 7e 81 e2 00 01 1f 00 75 2b <8b> 90 d8 12 00  
00 83 fa 02 75 20 48 8b 88 e0 12 00 00 8b 80 dc 12
RSP: 0018:ffff888197daf338 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff8881d207c040 RBX: ffff8881c39fd688 RCX: ffffc9000be34000
RDX: 0000000000000000 RSI: ffffffff86cdda27 RDI: ffff8881c39fd688
RBP: ffff888197daf338 R08: ffff8881d207c040 R09: 0000000000000008
R10: 0000000000000003 R11: ffff8881d207c040 R12: dffffc0000000000
R13: 0000000000000000 R14: 000000000000227d R15: 0000000000000000
  xfrm_policy_insert_list+0x257/0x1020 net/xfrm/xfrm_policy.c:1531
  xfrm_policy_inexact_insert+0x166/0xee0 net/xfrm/xfrm_policy.c:1195
  xfrm_policy_insert+0x639/0x850 net/xfrm/xfrm_policy.c:1570
  pfkey_spdadd+0x10f8/0x19d0 net/key/af_key.c:2339
  pfkey_process+0x857/0x9a0 net/key/af_key.c:2844
  pfkey_sendmsg+0x5e5/0xfb0 net/key/af_key.c:3683
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
RSP: 002b:00007efc20b07c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457669
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007efc20b086d4
R13: 00000000004c443a R14: 00000000004d7410 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
