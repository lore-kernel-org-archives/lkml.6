Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeDFHJE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 03:09:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:53019 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeDFHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 03:09:02 -0400
X-Google-Smtp-Source: AIpwx4+SpPG3guDGAGedaWhLWAtlyMbCwWP881xDO8w4zS6tg8o2EsBHwF8roMOct/mvnjIm6oqy2fDAJ1BG18idGfNr3hgDiSLK
MIME-Version: 1.0
Date: Fri, 06 Apr 2018 00:09:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014ed1e056928bb60@google.com>
Subject: INFO: rcu detected stall in io_playback_transfer
From: syzbot <syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        o-takashi@sakamocchi.jp, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
e02d37bf55a9a36f22427fd6dd733fe104d817b6 (Thu Apr 5 17:42:07 2018 +0000)
Merge tag 'sound-4.17-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=4f2016cf5185da7759dc

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6609942245015552
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-4805825610197092128
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4f2016cf5185da7759dc@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched self-detected stall on CPU
	1-....: (124999 ticks this GP) idle=212/1/4611686018427387906  
softirq=57947/57947 fqs=31225
	 (t=125000 jiffies g=30827 c=30826 q=171)
NMI backtrace for cpu 1
CPU: 1 PID: 13330 Comm: syz-executor4 Not tainted 4.16.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
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
  tick_sched_handle+0xa0/0x180 kernel/time/tick-sched.c:171
  tick_sched_timer+0x42/0x130 kernel/time/tick-sched.c:1179
  __run_hrtimer kernel/time/hrtimer.c:1337 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1399
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1457
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:snd_pcm_oss_write3+0xf6/0x220 sound/core/oss/pcm_oss.c:1236
RSP: 0018:ffff88018f57ed00 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: ffffffffffffffe0 RBX: ffffffffffffffe0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000ffffffe0 RDI: 00000000ffffffe0
RBP: ffff88018f57ed48 R08: ffff8801b29daaf8 R09: 0000000000000006
R10: ffff8801b29da280 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8801ce8c56c0 R14: ffff8801aa45a300 R15: ffffffffffffffe0
  io_playback_transfer+0x274/0x310 sound/core/oss/io.c:47
  snd_pcm_plug_write_transfer+0x36c/0x470 sound/core/oss/pcm_plugin.c:619
  snd_pcm_oss_write2+0x25c/0x460 sound/core/oss/pcm_oss.c:1365
  snd_pcm_oss_sync1+0x332/0x5a0 sound/core/oss/pcm_oss.c:1606
  snd_pcm_oss_sync.isra.29+0x790/0x980 sound/core/oss/pcm_oss.c:1682
  snd_pcm_oss_release+0x214/0x290 sound/core/oss/pcm_oss.c:2559
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1aee/0x2730 kernel/exit.c:865
  do_group_exit+0x16f/0x430 kernel/exit.c:968
  get_signal+0x886/0x1960 kernel/signal.c:2469
  do_signal+0x90/0x2020 arch/x86/kernel/signal.c:810
  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x792/0x9d0 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4552d9
RSP: 002b:00007f5c2a0e9c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000023
RAX: fffffffffffffdfc RBX: 00007f5c2a0ea6d4 RCX: 00000000004552d9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000020000240
RBP: 000000000072c010 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000413 R14: 00000000006f9268 R15: 0000000000000002


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

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
