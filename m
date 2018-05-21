Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeEURZG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:25:06 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:47672 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbeEURZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:25:03 -0400
X-Google-Smtp-Source: AB8JxZou4QJtGETLDnRH8b+2s9XCsPDCsUy9JUQ90oMUswZ9foaTCvIVzEq76RHOyzG87zpHfuGHPKMIootIQDGW0noSini5Z/I+
MIME-Version: 1.0
Date: Mon, 21 May 2018 10:25:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9b74b056cba9482@google.com>
Subject: INFO: rcu detected stall in save_stack_trace
From: syzbot <syzbot+0f775f734aa841af54cc@syzkaller.appspotmail.com>
To: hpa@zytor.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vbabka@suse.cz, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0b449a441dac Merge tag 'dmaengine-fix-4.17-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127ec337800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3b4e30da84ec1ed
dashboard link: https://syzkaller.appspot.com/bug?extid=0f775f734aa841af54cc
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17d3a84f800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10770827800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0f775f734aa841af54cc@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
INFO: rcu_sched self-detected stall on CPU
	0-...!: (124935 ticks this GP) idle=042/1/4611686018427387908  
softirq=14940/14940 fqs=5
	 (t=125000 jiffies g=7464 c=7463 q=430266)
NMI backtrace for cpu 0
CPU: 0 PID: 6412 Comm: ip Not tainted 4.17.0-rc5+ #59
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1376
  print_cpu_stall kernel/rcu/tree.c:1525 [inline]
  check_cpu_stall.isra.61.cold.80+0x36c/0x59a kernel/rcu/tree.c:1593
  __rcu_pending kernel/rcu/tree.c:3356 [inline]
  rcu_pending kernel/rcu/tree.c:3401 [inline]
  rcu_check_callbacks+0x21b/0xad0 kernel/rcu/tree.c:2763
  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1460
  hrtimer_interrupt+0x2f3/0x750 kernel/time/hrtimer.c:1518
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
RIP: 0010:__save_stack_trace+0x53/0xd0 arch/x86/kernel/stacktrace.c:43
RSP: 0018:ffff8801dae06ce0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: ffffffff85da28ea RBX: ffff8801dae06d78 RCX: 0000000000000001
RDX: 1ffff1003b5c0da5 RSI: ffff8801c08b7758 RDI: ffffffff85da28ea
RBP: ffff8801dae06d58 R08: ffff8801dae06d18 R09: ffff8801c0a62180
R10: ffffed003b5c0da6 R11: ffff8801dae06d37 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8801c0a62180 R15: ffff88007c262427
  save_stack_trace+0x1a/0x20 arch/x86/kernel/stacktrace.c:60
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
  kmem_cache_alloc_node+0x144/0x780 mm/slab.c:3644
  __alloc_skb+0x111/0x780 net/core/skbuff.c:193
  alloc_skb include/linux/skbuff.h:987 [inline]
  _sctp_make_chunk+0x58/0x280 net/sctp/sm_make_chunk.c:1417
  sctp_make_control net/sctp/sm_make_chunk.c:1464 [inline]
  sctp_make_heartbeat+0x8f/0x430 net/sctp/sm_make_chunk.c:1177
  sctp_sf_heartbeat.isra.23+0x26/0x180 net/sctp/sm_statefuns.c:1005
  sctp_sf_sendbeat_8_3+0x38e/0x550 net/sctp/sm_statefuns.c:1049
  sctp_do_sm+0x1ab/0x7160 net/sctp/sm_sideeffect.c:1188
  sctp_generate_heartbeat_event+0x218/0x450 net/sctp/sm_sideeffect.c:406
  call_timer_fn+0x230/0x940 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0x79e/0xc50 kernel/time/timer.c:1666
  run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
  invoke_softirq kernel/softirq.c:365 [inline]
  irq_exit+0x1d1/0x200 kernel/softirq.c:405
  exiting_irq arch/x86/include/asm/apic.h:525 [inline]
  smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783  
[inline]
RIP: 0010:kmem_cache_free+0xb3/0x2d0 mm/slab.c:3757
RSP: 0018:ffff8801c08b7568 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: ffff8801bb77f300 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000286
RBP: ffff8801c08b7588 R08: ffff8801c08b7310 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d9bdd6c0
R13: 0000000000000286 R14: ffffffff85d7708c R15: 0000000000000000
  kfree_skbmem+0x13c/0x210 net/core/skbuff.c:582
  __kfree_skb net/core/skbuff.c:642 [inline]
  consume_skb+0x193/0x550 net/core/skbuff.c:701
  skb_free_datagram+0x1a/0xf0 net/core/datagram.c:329
  netlink_recvmsg+0x6fe/0x1450 net/netlink/af_netlink.c:1980
  sock_recvmsg_nosec net/socket.c:802 [inline]
  sock_recvmsg+0xd0/0x110 net/socket.c:809
  ___sys_recvmsg+0x2b6/0x680 net/socket.c:2279
  __sys_recvmsg+0x112/0x260 net/socket.c:2328
  __do_sys_recvmsg net/socket.c:2338 [inline]
  __se_sys_recvmsg net/socket.c:2335 [inline]
  __x64_sys_recvmsg+0x78/0xb0 net/socket.c:2335
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f8daae3a210
RSP: 002b:00007fff88d0a008 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8daae3a210
RDX: 0000000000000000 RSI: 00007fff88d0a050 RDI: 0000000000000003
RBP: 0000000000003b38 R08: 00007f8dab0e3ec8 R09: 00007f8daae80c00
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006395c0
R13: 00007fff88d0e0e0 R14: 0000000000003b38 R15: 00007fff88d0dbc8


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
