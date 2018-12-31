Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA55C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 03:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECCD21019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 03:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLaDeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 22:34:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:47613 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLaDeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 22:34:05 -0500
Received: by mail-io1-f70.google.com with SMTP id s25so31056448ioc.14
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 19:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dVxYa+Qv/hrvwgK6htPfaWkuBhegOYQYg8rIoPV6FbM=;
        b=EDATJVcm3RmWgea4CEUiP3uJ2yVSsgwuRzDONVVDwz1qNb2JCSUb4LiatcbnIgU6RP
         vPMPXn9JrIXkNEykJbzyRfn5nkPrHn4DbvFq3GVrGk0+kyieQk+Lzm49ozsmy1FbtUkg
         EWMVxLPjYOqHEkHnase7pgYB4mI1BJJrMi3T2q9ggjBP+Tvz0NU05r9hOOU3lsItZH+J
         LKUvy+A3gUUb7XCF4mVnUEhUUddlzmlatbEtUEcrLyBlGpKvkzsBV9X7zOTMsoHqxN+i
         GOlibgTv+00fG5qwBcXR6K28iShGctV8RyVVh9tSn1Mdo01F5JLpNssHlqbkdp1dzo/5
         AU3A==
X-Gm-Message-State: AA+aEWambudkedxAjpwK+kUDWfb7y86vp8FVqahwwDX0Ra/39AQ/Chwg
        cZ13U795aiO3RUl+SWJ6S1gechv9yHdlYhve/cT3/9UD4Jmb
X-Google-Smtp-Source: AFSGD/VTxiP4t+KpkMcqmFqk2U67lajfunjwDoW+5tAKMv7FtFL+fLX/qibS4PQTzoUjJ0HFQorfpeszcs4mdlnilOGyqeGzgYKf
MIME-Version: 1.0
X-Received: by 2002:a24:4ac4:: with SMTP id k187mr26251793itb.8.1546227244042;
 Sun, 30 Dec 2018 19:34:04 -0800 (PST)
Date:   Sun, 30 Dec 2018 19:34:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f9349057e4915b4@google.com>
Subject: INFO: rcu detected stall in inet_dgram_connect
From:   syzbot <syzbot+94683b47a87718b5dff7@syzkaller.appspotmail.com>
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

HEAD commit:    f7d18ef6a95f Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=152cb86f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b137b8ba637eb77
dashboard link: https://syzkaller.appspot.com/bug?extid=94683b47a87718b5dff7
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+94683b47a87718b5dff7@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor4'.
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor4'.
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P23939
rcu: 	(detected by 1, t=10503 jiffies, g=56797, q=1404)
syz-executor5   R  running task    24952 23939   8064 0x00000006
Call Trace:
  <IRQ>
  sched_show_task.cold.86+0x2b6/0x30a kernel/sched/core.c:5293
  rcu_print_detail_task_stall_rnp+0xc7/0x103 kernel/rcu/tree_plugin.h:690
  rcu_print_detail_task_stall kernel/rcu/tree_plugin.h:703 [inline]
  print_other_cpu_stall.cold.69+0x5b5/0x8db kernel/rcu/tree.c:1289
  check_cpu_stall kernel/rcu/tree.c:1429 [inline]
  rcu_pending kernel/rcu/tree.c:3018 [inline]
  rcu_check_callbacks+0xfe8/0x1410 kernel/rcu/tree.c:2521
  update_process_times+0x2d/0x70 kernel/time/timer.c:1635
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:161
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1271
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50 kernel/kcov.c:94
Code: 14 dd 28 00 00 00 4d 39 d0 72 1b 49 83 c1 01 4a 89 7c 10 e0 4a 89 74  
10 e8 4a 89 54 10 f0 4a 89 4c d8 20 4c 89 08 5d c3 66 90 <55> 48 89 e5 48  
8b 75 08 65 48 8b 04 25 40 ee 01 00 65 8b 15 c8 47
RSP: 0018:ffff888065fa7458 EFLAGS: 00000217 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffff86c5ddd8
RDX: 00000000ffffffff RSI: 000000000000227d RDI: 0000000000000004
RBP: ffff888065fa7718 R08: ffff8880a9eac700 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8880a9eac700 R12: 000000000000227d
R13: dffffc0000000000 R14: ffff8880a86c8dc0 R15: 00000000ffffffff
  xfrm_policy_lookup+0x7e/0x80 net/xfrm/xfrm_policy.c:2145
  xfrm_bundle_lookup net/xfrm/xfrm_policy.c:2939 [inline]
  xfrm_lookup_with_ifid+0x972/0x2b80 net/xfrm/xfrm_policy.c:3080
  xfrm_lookup net/xfrm/xfrm_policy.c:3172 [inline]
  xfrm_lookup_route+0x3c/0x1f0 net/xfrm/xfrm_policy.c:3183
  ip_route_output_flow+0xb1/0xc0 net/ipv4/route.c:2582
  ip_route_connect include/net/route.h:309 [inline]
  __ip4_datagram_connect+0x70e/0x1330 net/ipv4/datagram.c:51
  ip4_datagram_connect+0x2f/0x50 net/ipv4/datagram.c:92
  inet_dgram_connect+0x154/0x2e0 net/ipv4/af_inet.c:571
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fee7c44bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000010 RSI: 0000000020593000 RDI: 0000000000000004
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fee7c44c6d4
R13: 00000000004be2ff R14: 00000000004ce440 R15: 00000000ffffffff
syz-executor5   R  running task    24952 23939   8064 0x8000000e
Call Trace:
  <IRQ>
  sched_show_task.cold.86+0x2b6/0x30a kernel/sched/core.c:5293
  rcu_print_detail_task_stall_rnp+0xc7/0x103 kernel/rcu/tree_plugin.h:690
  rcu_print_detail_task_stall kernel/rcu/tree_plugin.h:705 [inline]
  print_other_cpu_stall.cold.69+0x615/0x8db kernel/rcu/tree.c:1289
  check_cpu_stall kernel/rcu/tree.c:1429 [inline]
  rcu_pending kernel/rcu/tree.c:3018 [inline]
  rcu_check_callbacks+0xfe8/0x1410 kernel/rcu/tree.c:2521
  update_process_times+0x2d/0x70 kernel/time/timer.c:1635
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:161
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1271
  __run_hrtimer kernel/time/hrtimer.c:1389 [inline]
  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1451
  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1509
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1035 [inline]
  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1060
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50 kernel/kcov.c:94
Code: 14 dd 28 00 00 00 4d 39 d0 72 1b 49 83 c1 01 4a 89 7c 10 e0 4a 89 74  
10 e8 4a 89 54 10 f0 4a 89 4c d8 20 4c 89 08 5d c3 66 90 <55> 48 89 e5 48  
8b 75 08 65 48 8b 04 25 40 ee 01 00 65 8b 15 c8 47
RSP: 0018:ffff888065fa7458 EFLAGS: 00000217 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffff86c5ddd8
RDX: 00000000ffffffff RSI: 000000000000227d RDI: 0000000000000004
RBP: ffff888065fa7718 R08: ffff8880a9eac700 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8880a9eac700 R12: 000000000000227d
R13: dffffc0000000000 R14: ffff8880a86c8dc0 R15: 00000000ffffffff
  xfrm_policy_lookup+0x7e/0x80 net/xfrm/xfrm_policy.c:2145
  xfrm_bundle_lookup net/xfrm/xfrm_policy.c:2939 [inline]
  xfrm_lookup_with_ifid+0x972/0x2b80 net/xfrm/xfrm_policy.c:3080
  xfrm_lookup net/xfrm/xfrm_policy.c:3172 [inline]
  xfrm_lookup_route+0x3c/0x1f0 net/xfrm/xfrm_policy.c:3183
  ip_route_output_flow+0xb1/0xc0 net/ipv4/route.c:2582
  ip_route_connect include/net/route.h:309 [inline]
  __ip4_datagram_connect+0x70e/0x1330 net/ipv4/datagram.c:51
  ip4_datagram_connect+0x2f/0x50 net/ipv4/datagram.c:92
  inet_dgram_connect+0x154/0x2e0 net/ipv4/af_inet.c:571
  __sys_connect+0x37d/0x4c0 net/socket.c:1664
  __do_sys_connect net/socket.c:1675 [inline]
  __se_sys_connect net/socket.c:1672 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1672
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457ec9
Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fee7c44bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
RDX: 0000000000000010 RSI: 0000000020593000 RDI: 0000000000000004
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fee7c44c6d4
R13: 00000000004be2ff R14: 00000000004ce440 R15: 00000000ffffffff
rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P23939 }  
10898 jiffies s: 5085 root: 0x0/T
rcu: blocking rcu_node structures:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
