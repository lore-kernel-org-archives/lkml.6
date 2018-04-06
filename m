Return-Path: <3DR3HWgkbAEAu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522998541; cv=none;
        d=google.com; s=arc-20160816;
        b=wCp1KOfMewGyU5cpsjhPl62OkViSj7rq+zQepnoReSsWdAqCxyjVlJ7SFedvoi4UTE
         9fchtHkRPM1Qc3/jRAtOgGa8AHYUDhU9x934pZhUO+FFwKOKkLRAgoiJrUEQvmtaSLyH
         6LJdwut2FpR6F68eDpUMMq3p5y1GkgJOtNQztVJUFhW+xIu3RRnWJcgebcN5MYlzxWqs
         cxor4nr9sDsvR9rmzVy/d/nPsun31t0cOFoJLx+Z3jQoaWpmqDCtvBFmMKZgDBGzTpuf
         IJkkISsqqKWgik+RZ0IAC61qiLsxSzWCi3sEnzXCpS5pzOU/9c4vccmE3bpK4GCiOyAN
         3pHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=bZP5BP5xCh8hHOljD8tiNzreGFUPwkh3nTxfP+PjD2M=;
        b=Z4Prf8ij4UXSPwj9pDY7GQmfaoPZ+u9qBo55Dnlu0HtsLtArWdaK4GDIWjjfWhXOA2
         +QNRSfbLOc3xOQQgRQqjvOWH4cnB6riM1kBzItEWAlN24+iPVtPOdGxSmYdOfexrasQc
         rWg0z7NVudJ3aqxvgJ3usdxMisfhGHEBjQvxKfuE8Rn32NSx3QGhV6dQYsn8g8jw0EXJ
         i337h0WotXPX1BshnpvxNKrg8kMStBkCrqNFb6nl3LNXuP3/AdD1B61Xz6gNrCCUvbeI
         bu1J97CrLJtEZT5UNjHxgG4hdGVYV2pr9u4oulQ3eTxD1ei25ODEbrBpqTn/Zph431UI
         5P4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3dr3hwgkbaeau01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3DR3HWgkbAEAu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3dr3hwgkbaeau01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3DR3HWgkbAEAu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx4/8hiN90QUTvDPysFUTITm/EJ25zTyVp7NzMaEYMdCicYGcHdG00LX5aM0YA35R1yob6l56ao4K7WpEo+JNm4HI7J+JUjv+
MIME-Version: 1.0
Date: Fri, 06 Apr 2018 00:09:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000118a9a056928bbd9@google.com>
Subject: INFO: rcu detected stall in snd_pcm_oss_write3 (2)
From: syzbot <syzbot+150189c103427d31a053@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tchibo@google.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979719194785856?=
X-GMAIL-MSGID: =?utf-8?q?1596979719194785856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
e02d37bf55a9a36f22427fd6dd733fe104d817b6 (Thu Apr 5 17:42:07 2018 +0000)
Merge tag 'sound-4.17-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=150189c103427d31a053

So far this crash happened 3 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6067392849379328
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-4805825610197092128
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+150189c103427d31a053@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

Buffer I/O error on dev loop0, logical block 6, lost async page write
Buffer I/O error on dev loop0, logical block 7, lost async page write
Buffer I/O error on dev loop0, logical block 8, lost async page write
Buffer I/O error on dev loop0, logical block 9, lost async page write
Buffer I/O error on dev loop0, logical block 10, lost async page write
INFO: rcu_sched self-detected stall on CPU
	1-....: (124998 ticks this GP) idle=9b2/1/4611686018427387906  
softirq=22733/22733 fqs=31170
	 (t=125000 jiffies g=11599 c=11598 q=1619)
NMI backtrace for cpu 1
CPU: 1 PID: 7184 Comm: syz-executor3 Not tainted 4.16.0+ #2
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
RIP: 0010:__sanitizer_cov_trace_pc+0x2b/0x50 kernel/kcov.c:101
RSP: 0018:ffff8801cfe77710 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff8801d0108080 RBX: 0000000000000004 RCX: ffffffff85a1f955
RDX: 0000000000000002 RSI: ffffffff85a1f95f RDI: 0000000000000005
RBP: ffff8801cfe77710 R08: ffff8801d0108080 R09: 0000000000000006
R10: ffff8801d0108080 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8801ceb2cd80 R14: ffff8801aaacec00 R15: ffffffffffffffe0
  snd_pcm_oss_write3+0x16f/0x220 sound/core/oss/pcm_oss.c:1224
  io_playback_transfer+0x274/0x310 sound/core/oss/io.c:47
  snd_pcm_plug_write_transfer+0x36c/0x470 sound/core/oss/pcm_plugin.c:619
  snd_pcm_oss_write2+0x25c/0x460 sound/core/oss/pcm_oss.c:1365
  snd_pcm_oss_sync1+0x332/0x5a0 sound/core/oss/pcm_oss.c:1606
  snd_pcm_oss_sync.isra.29+0x790/0x980 sound/core/oss/pcm_oss.c:1682
  snd_pcm_oss_release+0x214/0x290 sound/core/oss/pcm_oss.c:2559
  __fput+0x34d/0x890 fs/file_table.c:209
  ____fput+0x15/0x20 fs/file_table.c:243
  task_work_run+0x1e4/0x290 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
  exit_to_usermode_loop+0x2bd/0x310 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
  do_syscall_64+0x792/0x9d0 arch/x86/entry/common.c:292
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4552d9
RSP: 002b:00007f4e5ffe6c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f4e5ffe76d4 RCX: 00000000004552d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000052 R14: 00000000006f3850 R15: 0000000000000000
INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 1-... } 127452  
jiffies s: 2685 root: 0x2/.
blocking rcu_node structures:
Task dump for CPU 1:
syz-executor3   R  running task    24120  7184   4559 0x0000000c
Call Trace:


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
