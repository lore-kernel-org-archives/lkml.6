Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeEQMkE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:40:04 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:42888 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQMkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:40:03 -0400
X-Google-Smtp-Source: AB8JxZr3X/H7WjchEvq9OEsPdLCBTQ2f01G+xJN+CdEYdUHOHH2cJ1IQBu/U9+cLwE4FKdtz+fImqls/1ES6Jjo/WXkmycFPQD57
MIME-Version: 1.0
Date: Thu, 17 May 2018 05:40:02 -0700
In-Reply-To: <17752ce7-be26-7ae1-a5bd-6e5fff70fa9e@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a57a3056c662298@google.com>
Subject: Re: INFO: rcu detected stall in n_tty_receive_char_special
From: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
To: dvyukov@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        peter@hurleysoftware.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
INFO: rcu detected stall in corrupted

IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
INFO: rcu_sched self-detected stall on CPU
INFO: rcu_sched detected stalls on CPUs/tasks:
	1-....: (124998 ticks this GP) idle=da2/1/4611686018427387906  
softirq=12308/12308 fqs=30969
	
	1-....: (124998 ticks this GP) idle=da2/1/4611686018427387906  
softirq=12308/12308 fqs=30969
	
  (t=125002 jiffies g=6046 c=6045 q=1179)
(detected by 0, t=125002 jiffies, g=6046, c=6045, q=1179)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5134 Comm: syz-executor3 Not tainted 4.17.0-rc5+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:rep_nop arch/x86/include/asm/processor.h:667 [inline]
RIP: 0010:cpu_relax arch/x86/include/asm/processor.h:672 [inline]
RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:69 [inline]
RIP: 0010:native_queued_spin_lock_slowpath+0x204/0xde0  
kernel/locking/qspinlock.c:305
RSP: 0018:ffff8801db107030 EFLAGS: 00000002
RAX: 0000000000000000 RBX: ffffed003b620e1f RCX: 0000000000000004
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff88b911c0
RBP: ffff8801db1073a0 R08: fffffbfff1172239 R09: fffffbfff1172238
R10: fffffbfff1172238 R11: ffffffff88b911c3 R12: ffffffff88b911c0
R13: ffff8801db107378 R14: 0000000000000001 R15: dffffc0000000000
FS:  00007fd0bf7b5700(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d91e4 CR3: 00000001c68eb000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:674 [inline]
  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:30 [inline]
  queued_spin_lock include/asm-generic/qspinlock.h:90 [inline]
  do_raw_spin_lock+0x1a7/0x200 kernel/locking/spinlock_debug.c:113
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
  _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:152
  rcu_dump_cpu_stacks+0x9d/0x1c2 kernel/rcu/tree.c:1373
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
  </IRQ>
RIP: 0010:add_echo_byte drivers/tty/n_tty.c:829 [inline]
RIP: 0010:echo_char+0x152/0x340 drivers/tty/n_tty.c:934
RSP: 0018:ffff8801aa1ef720 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801a9a5e180 RBX: ffffc90002bb4000 RCX: ffffffff837ff667
RDX: 0000000000000000 RSI: ffffffff837ff672 RDI: 0000000000000001
RBP: ffff8801aa1ef748 R08: ffff8801a9a5e180 R09: 0000000000000001
R10: ffff8801a9a5e9e0 R11: ffff8801a9a5e180 R12: 00000000000008df
R13: 0000000000000000 R14: 0000000000000008 R15: ffffc90002bb6268
  n_tty_receive_char_special+0x1451/0x3510 drivers/tty/n_tty.c:1324
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1595 [inline]
  __receive_buf drivers/tty/n_tty.c:1629 [inline]
  n_tty_receive_buf_common+0x21bd/0x2ca0 drivers/tty/n_tty.c:1727
  n_tty_receive_buf+0x30/0x40 drivers/tty/n_tty.c:1756
  tiocsti drivers/tty/tty_io.c:2171 [inline]
  tty_ioctl+0x7e7/0x1870 drivers/tty/tty_io.c:2557
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455319
RSP: 002b:00007fd0bf7b4c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd0bf7b56d4 RCX: 0000000000455319
RDX: 00000000200000c0 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000002f9 R14: 00000000006f77f8 R15: 0000000000000000
Code: 5c 00 00 00 00 48 83 e7 f8 49 29 fc 41 8d 4c 24 64 c1 e9 03 f3 48 ab  
48 81 c4 48 03 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 f3 90 <e9> 3b ff ff  
ff 89 f1 81 fe 00 01 00 00 0f 84 9e 03 00 00 41 be
NMI backtrace for cpu 1
CPU: 1 PID: 5134 Comm: syz-executor3 Not tainted 4.17.0-rc5+ #1
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
  </IRQ>
RIP: 0010:add_echo_byte drivers/tty/n_tty.c:829 [inline]
RIP: 0010:echo_char+0x152/0x340 drivers/tty/n_tty.c:934
RSP: 0018:ffff8801aa1ef720 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801a9a5e180 RBX: ffffc90002bb4000 RCX: ffffffff837ff667
RDX: 0000000000000000 RSI: ffffffff837ff672 RDI: 0000000000000001
RBP: ffff8801aa1ef748 R08: ffff8801a9a5e180 R09: 0000000000000001
R10: ffff8801a9a5e9e0 R11: ffff8801a9a5e180 R12: 00000000000008df
R13: 0000000000000000 R14: 0000000000000008 R15: ffffc90002bb6268
  n_tty_receive_char_special+0x1451/0x3510 drivers/tty/n_tty.c:1324
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1595 [inline]
  __receive_buf drivers/tty/n_tty.c:1629 [inline]
  n_tty_receive_buf_common+0x21bd/0x2ca0 drivers/tty/n_tty.c:1727
  n_tty_receive_buf+0x30/0x40 drivers/tty/n_tty.c:1756
  tiocsti drivers/tty/tty_io.c:2171 [inline]
  tty_ioctl+0x7e7/0x1870 drivers/tty/tty_io.c:2557
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455319
RSP: 002b:00007fd0bf7b4c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd0bf7b56d4 RCX: 0000000000455319
RDX: 00000000200000c0 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000002f9 R14: 00000000006f77f8 R15: 0000000000000000
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.375  
msecs


Tested on:

commit:         e6506eb24187 Merge tag 'trace-v4.17-rc4-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15804957800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d57d2358c5d82736
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11608417800000
