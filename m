Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeDMQlE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:41:04 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:43376 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbeDMQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:41:02 -0400
X-Google-Smtp-Source: AIpwx48N7vomuMvtyn1Qpxa4kfT991xEk88/sBDSpeUbuk2Vy+qKrmSg58MEInZv2LUm3ChmsFiQBGt6mbUfLqrzUVx6H64vqd+6
MIME-Version: 1.0
Date: Fri, 13 Apr 2018 09:41:01 -0700
In-Reply-To: <000000000000f0c26d0569b5e8da@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009073b80569bd89a1@google.com>
Subject: Re: INFO: rcu detected stall in shrink_dcache_parent
From: syzbot <syzbot+8e4a81166025b5b7fa66@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found reproducer for the following crash on upstream commit
16e205cf42da1f497b10a4a24f563e6c0d574eec (Fri Apr 13 03:56:10 2018 +0000)
Merge tag 'drm-fixes-for-v4.17-rc1' of  
git://people.freedesktop.org/~airlied/linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=8e4a81166025b5b7fa66

So far this crash happened 13 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5369092034789376
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4909037686620160
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6422767771582464
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5947642240294114534
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8e4a81166025b5b7fa66@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

INFO: rcu_sched self-detected stall on CPU
	1-...!: (124998 ticks this GP) idle=c6e/1/4611686018427387906  
softirq=11062/11062 fqs=0
	 (t=125000 jiffies g=5220 c=5219 q=10)
rcu_sched kthread starved for 125000 jiffies! g5220 c5219 f0x0  
RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
RCU grace-period kthread stack dump:
rcu_sched       R  running task    23896     9      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
NMI backtrace for cpu 1
CPU: 1 PID: 4547 Comm: syzkaller613030 Not tainted 4.16.0+ #2
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
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:173
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1283
  __run_hrtimer kernel/time/hrtimer.c:1386 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1448
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1506
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:__preempt_count_add arch/x86/include/asm/preempt.h:76 [inline]
RIP: 0010:__rcu_read_lock include/linux/rcupdate.h:83 [inline]
RIP: 0010:rcu_read_lock include/linux/rcupdate.h:630 [inline]
RIP: 0010:d_walk+0x476/0xc80 fs/dcache.c:1303
RSP: 0018:ffff8801a93d79d8 EFLAGS: 00000203 ORIG_RAX: ffffffffffffff13
RAX: ffff8801acbe6300 RBX: ffff8801a762b520 RCX: ffffffff815cbe3e
RDX: 0000000000000000 RSI: ffffffff81c2a68f RDI: ffff8801a7644d20
RBP: ffff8801a93d7b58 R08: ffffed0034ec89a5 R09: ffffed0034ec89a4
R10: ffffed0034ec89a4 R11: ffff8801a7644d23 R12: ffff8801a7644ca0
R13: dffffc0000000000 R14: ffff8801a7644d20 R15: ffff8801a93d7b30
  shrink_dcache_parent+0x179/0x230 fs/dcache.c:1486
  vfs_rmdir+0x202/0x470 fs/namei.c:3850
  do_rmdir+0x523/0x610 fs/namei.c:3911
  SYSC_rmdir fs/namei.c:3929 [inline]
  SyS_rmdir+0x1a/0x20 fs/namei.c:3927
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4464a7
RSP: 002b:00007ffdd93b0718 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00000000004464a7
RDX: 0000000000000000 RSI: 00000000006d85f8 RDI: 00007ffdd93b1f80
RBP: 00007ffdd93b1f80 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000005 R11: 0000000000000207 R12: 00000000025778a0
R13: 0000000000000000 R14: 000000000008d71f R15: 00007ffdd93b1978
