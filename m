Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeEFJbE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 05:31:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:33105 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeEFJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 05:31:02 -0400
X-Google-Smtp-Source: AB8JxZqio0yQm0Ez8YsFsR0P+zYNso2SynGQ4fyrxV13eC4GOLB3dPrNbFbtG6MqrtVffJ/1Gy/iM66FUJz7hLa38qK2ZCTf8jiN
MIME-Version: 1.0
Date: Sun, 06 May 2018 02:31:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b8fac056b863655@google.com>
Subject: INFO: rcu detected stall in vcpu_enter_guest
From: syzbot <syzbot+f58b8603b48434ef07d3@syzkaller.appspotmail.com>
To: hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    625e2001e99e Merge tag 'for-linus-4.17-rc4-tag' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ecc697800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=f58b8603b48434ef07d3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f58b8603b48434ef07d3@syzkaller.appspotmail.com

INFO: rcu_sched detected stalls on CPUs/tasks:
	(detected by 1, t=125002 jiffies, g=73789, c=73788, q=844)
All QSes seen, last rcu_sched kthread activity 125002  
(4295195361-4295070359), jiffies_till_next_fqs=3, root ->qsmask 0x0
syz-executor3   R  running task    23000 27493  11463 0x00000000
Call Trace:
  <IRQ>
  sched_show_task.cold.86+0x27a/0x301 kernel/sched/core.c:5325
  print_other_cpu_stall.cold.79+0x92f/0x9d2 kernel/rcu/tree.c:1481
  check_cpu_stall.isra.61+0x706/0xf50 kernel/rcu/tree.c:1599
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
RIP: 0010:vmx_handle_external_intr+0x1b4/0x220 arch/x86/kvm/vmx.c:9459
RSP: 0018:ffff8801bb297508 EFLAGS: 00000086 ORIG_RAX: ffffffffffffff13
RAX: ffffffff87801530 RBX: fffffe0000000ec0 RCX: 0000000000000000
RDX: ffff8801bb297508 RSI: 0000000000000001 RDI: fffffe0000000ec8
RBP: ffff8801bb297520 R08: ffff8801d93c6780 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000087800000
R13: 0000000000001530 R14: 0000000000000000 R15: 0000000000000000
  vcpu_enter_guest+0x1121/0x6060 arch/x86/kvm/x86.c:7470
  vcpu_run arch/x86/kvm/x86.c:7559 [inline]
  kvm_arch_vcpu_ioctl_run+0x33e/0x1690 arch/x86/kvm/x86.c:7736
  kvm_vcpu_ioctl+0x79d/0x12e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2560
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007f9c60b4bc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9c60b4c6d4 RCX: 0000000000455979
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000015
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000027e R14: 00000000006f7c70 R15: 0000000000000000
rcu_sched kthread starved for 125002 jiffies! g73789 c73788 f0x2  
RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
RCU grace-period kthread stack dump:
rcu_sched       R  running task    23592     9      2 0x80000000
Call Trace:
  context_switch kernel/sched/core.c:2848 [inline]
  __schedule+0x801/0x1e30 kernel/sched/core.c:3490
  schedule+0xef/0x430 kernel/sched/core.c:3549
  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
  kthread+0x345/0x410 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412


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
