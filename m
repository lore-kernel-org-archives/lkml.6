Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeEBR4G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:56:06 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:50536 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeEBR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:56:02 -0400
X-Google-Smtp-Source: AB8JxZqN+mYm/UObPmm7ugqPVZZnh8fHyEpAhBHtN9t9k4/39Uxoev7I1eswvB6d8r8lnvB/RkLX+p2mg6nrRBx8ZShFiBAYVUPU
MIME-Version: 1.0
Date: Wed, 02 May 2018 10:56:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2fe62056b3ccca5@google.com>
Subject: INFO: rcu detected stall in __schedule
From: syzbot <syzbot+f16b3e3512a1e3c1d1f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
        netdev@vger.kernel.org, paulus@samba.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w42HuCGc017380

Hello,

syzbot found the following crash on:

HEAD commit:    f2125992e7cb Merge tag 'xfs-4.17-fixes-1' of  
git://git.kern...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?id=4755940087693312
kernel config:   
https://syzkaller.appspot.com/x/.config?id=6493557782959164711
dashboard link: https://syzkaller.appspot.com/bug?extid=f16b3e3512a1e3c1d1f6
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f16b3e3512a1e3c1d1f6@syzkaller.appspotmail.com

do_dccp_getsockopt: sockopt(PACKET_SIZE) is deprecated: fix your app
do_dccp_getsockopt: sockopt(PACKET_SIZE) is deprecated: fix your app
ntfs: (device loop6): parse_options(): Unrecognized mount option  
error�n��uldip.
INFO: rcu_sched self-detected stall on CPU
	0-...!: (125000 ticks this GP) idle=f3e/1/4611686018427387906  
softirq=112858/112858 fqs=0
	 (t=125000 jiffies g=61626 c=61625 q=1534)
rcu_sched kthread starved for 125000 jiffies! g61626 c61625 f0x0  
RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=0
RCU grace-period kthread stack dump:
rcu_sched       I23592     9      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
NMI backtrace for cpu 0
CPU: 0 PID: 26694 Comm: syz-executor1 Not tainted 4.17.0-rc3+ #28
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
RIP: 0010:arch_local_irq_enable arch/x86/include/asm/paravirt.h:793 [inline]
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168  
[inline]
RIP: 0010:_raw_spin_unlock_irq+0x56/0x70 kernel/locking/spinlock.c:192
RSP: 0018:ffff8801b3dbf438 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: ffff8801dae2c680 RCX: 1ffff100361ebd4d
RDX: 1ffffffff11a316f RSI: ffff8801b0f5ea48 RDI: ffffffff88d18b78
RBP: ffff8801b3dbf440 R08: ffff8801b0f5e9f8 R09: 0000000000000006
R10: ffff8801b0f5e1c0 R11: 0000000000000000 R12: ffff8801b0f5e1c0
R13: ffff8801b0f5e7a0 R14: dffffc0000000000 R15: ffff8801b0f5e1c0
  rq_unlock_irq kernel/sched/sched.h:1824 [inline]
  __schedule+0x144f/0x1e30 kernel/sched/core.c:3493
  schedule+0xef/0x430 kernel/sched/core.c:3549
  do_sched_yield+0x187/0x240 kernel/sched/core.c:4965
  yield+0xa5/0xe0 kernel/sched/core.c:5054
  tasklet_kill+0x4e/0xd0 kernel/softirq.c:559
  ppp_asynctty_close+0x9e/0x150 drivers/net/ppp/ppp_async.c:239
  ppp_asynctty_hangup+0x15/0x20 drivers/net/ppp/ppp_async.c:256
  tty_ldisc_hangup+0x138/0x640 drivers/tty/tty_ldisc.c:730
  __tty_hangup.part.21+0x2da/0x6e0 drivers/tty/tty_io.c:621
  __tty_hangup drivers/tty/tty_io.c:571 [inline]
  tty_vhangup+0x21/0x30 drivers/tty/tty_io.c:694
  pty_close+0x3bd/0x510 drivers/tty/pty.c:78
  tty_release+0x494/0x12e0 drivers/tty/tty_io.c:1656
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
  exit_to_usermode_loop+0x2bd/0x310 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007f92c3751c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f92c37526d4 RCX: 0000000000455979
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000013
RBP: 000000000072bf50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000053 R14: 00000000006f4868 R15: 0000000000000001


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
