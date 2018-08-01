Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D40C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED532083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED532083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbeHAKMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:12:37 -0400
Received: from mail-io0-f199.google.com ([209.85.223.199]:51302 "EHLO
        mail-io0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387672AbeHAKMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:12:36 -0400
Received: by mail-io0-f199.google.com with SMTP id w23-v6so13091575iob.18
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1/r6wpP8sJ0DK1AkOpbdLmrlooR06z26dHxSh0Y/W9o=;
        b=VUpyHjRWLXNg3NqWIb5r6otDr+PsFyRI7JFEML/cCJtYEu+4gvW6x8SVb97LA1X2Cm
         l8wAo/TyaHYwC72Q2iInw4u6TKBW3paiGg7+fxaOBprh+OS/rneSTfYmzZzLTtuON5LV
         DruvtPms8bk6un4VRujR8qNbZw5/Jmum4mrED6o+B9E/kmmJlV9glaLyh7jWkP1bAXO+
         HXCZ6HEIxTKBOyiEbWuMNfbYXj0gCbYqon9PNwsXPeQhGgCBteq7W3omyJQNVQahZWvn
         qOenfF49jJ1xoYPT5oqwOo5IGofMrfmOocVGrzvMA3K3OAjMy/hCNqEdto1O0Qk4S+wr
         QoLQ==
X-Gm-Message-State: AOUpUlFh/PAZhvo+CIL/swvfM0Lus0e+0ywcInptzJSGIsoQ3UrPb8C6
        +HaBId8Nyqw4kMzHzbIPAV7qyexsAX48T0COvNO80H3gEsQ9
X-Google-Smtp-Source: AAOMgpdZSX4y8ckNzMHqzBgn4aLABVz6J8NwVKvw8MnCNcF2T1T5gNEHbqRuMdQiJLktU6VPIHcVFs8QAQdmqvLL2ik99I5jjUO6
MIME-Version: 1.0
X-Received: by 2002:a02:b38c:: with SMTP id p12-v6mr12324428jan.43.1533112082376;
 Wed, 01 Aug 2018 01:28:02 -0700 (PDT)
Date:   Wed, 01 Aug 2018 01:28:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012325c05725b7920@google.com>
Subject: INFO: rcu detected stall in tipc_sk_lookup
From:   syzbot <syzbot+230075782a192b8ca880@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    527838d470e3 Merge branch 'x86-urgent-for-linus' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12726f1c400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
dashboard link: https://syzkaller.appspot.com/bug?extid=230075782a192b8ca880
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+230075782a192b8ca880@syzkaller.appspotmail.com

INFO: rcu_sched self-detected stall on CPU
	1-....: (104999 ticks this GP) idle=002/1/4611686018427387906  
softirq=125049/125058 fqs=26224
	 (t=105000 jiffies g=69343 c=69342 q=1302)
NMI backtrace for cpu 1
CPU: 1 PID: 29490 Comm: syz-executor5 Not tainted 4.18.0-rc7+ #170
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1336
  print_cpu_stall kernel/rcu/tree.c:1485 [inline]
  check_cpu_stall.isra.60.cold.78+0x36c/0x5a6 kernel/rcu/tree.c:1553
  __rcu_pending kernel/rcu/tree.c:3244 [inline]
  rcu_pending kernel/rcu/tree.c:3291 [inline]
  rcu_check_callbacks+0x23f/0xcd0 kernel/rcu/tree.c:2646
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3eb/0x10c0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1028 [inline]
  smp_apic_timer_interrupt+0x165/0x730 arch/x86/kernel/apic/apic.c:1053
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:lock_acquire+0x25f/0x540 kernel/locking/lockdep.c:3927
Code: 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 6a 02 00 00 48 83 3d a8  
8a 92 06 00 0f 84 d4 01 00 00 48 8b bd 20 ff ff ff 57 9d <0f> 1f 44 00 00  
48 b8 00 00 00 00 00 fc ff df 48 01 c3 48 c7 03 00
RSP: 0018:ffff8801999a67c0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: 1ffff10033334cfd RCX: 0000000000000000
RDX: 1ffffffff0fe3615 RSI: 0000000000000000 RDI: 0000000000000286
RBP: ffff8801999a68b0 R08: 0000000000000008 R09: 0000000000000002
R10: ffff880192d5c908 R11: 632564d1cb2a3fed R12: ffff880192d5c080
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
  rcu_lock_acquire include/linux/rcupdate.h:245 [inline]
  rcu_read_lock include/linux/rcupdate.h:631 [inline]
  net_generic include/net/netns/generic.h:44 [inline]
  tipc_sk_lookup+0x131/0xfa0 net/tipc/socket.c:2682
  tipc_nl_publ_dump+0x243/0xfa2 net/tipc/socket.c:3456
  __tipc_nl_compat_dumpit.isra.11+0x20b/0xad0 net/tipc/netlink_compat.c:192
  tipc_nl_compat_publ_dump net/tipc/netlink_compat.c:920 [inline]
  tipc_nl_compat_sk_dump+0x87c/0xca0 net/tipc/netlink_compat.c:968
  __tipc_nl_compat_dumpit.isra.11+0x337/0xad0 net/tipc/netlink_compat.c:201
  tipc_nl_compat_dumpit+0x1f4/0x440 net/tipc/netlink_compat.c:265
  tipc_nl_compat_handle net/tipc/netlink_compat.c:1142 [inline]
  tipc_nl_compat_recv+0x12b3/0x19a0 net/tipc/netlink_compat.c:1205
  genl_family_rcv_msg+0x8a3/0x1140 net/netlink/genetlink.c:601
  genl_rcv_msg+0xc6/0x168 net/netlink/genetlink.c:626
  netlink_rcv_skb+0x172/0x440 net/netlink/af_netlink.c:2448
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:637
  netlink_unicast_kernel net/netlink/af_netlink.c:1310 [inline]
  netlink_unicast+0x5a0/0x760 net/netlink/af_netlink.c:1336
  netlink_sendmsg+0xa18/0xfd0 net/netlink/af_netlink.c:1901
  sock_sendmsg_nosec net/socket.c:641 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:651
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2125
  __sys_sendmsg+0x11d/0x290 net/socket.c:2163
  __do_sys_sendmsg net/socket.c:2172 [inline]
  __se_sys_sendmsg net/socket.c:2170 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2170
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456a09
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8665b39c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8665b3a6d4 RCX: 0000000000456a09
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000022
RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d3058 R14: 00000000004c7d3e R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
