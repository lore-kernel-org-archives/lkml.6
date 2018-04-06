Return-Path: <38XTHWgkbANQIOPA0BB4H0FF83.6EE6B4KI4H2EDJ4DJ.2EC@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523021042; cv=none;
        d=google.com; s=arc-20160816;
        b=KDd9AjG35CTIvucLslD1cfypgDGdPr2EXZYFYavRJtG3YD8frBxKND9tQ40N80Hl++
         6S2BL3vbv8mdHgr6i1B4O3J8KiT/SyG8+uL9pWZVFYNNStAW8cMa6gv0y08NGTjTRzNv
         Eb3szyVOgACZSSPO0YZN3b4XvDxbftYDJHYRSjI5koZIrmXJg6znF/mDfIunTxZtFg47
         vN1DsNH8q8rd4ZGse4J4MMlXmak6CbHSAZljtYmeevn8nhZvsA3YQ/MxDSW2g08Pw/1I
         BcwXHXyuw15bLHMvzhEgJipBTFRH3xkOEpgmO4BvzP5MAc/U+NaHOmSI4p+Z4FzqVUD4
         sakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=PoX+RDDZJ9oGydC+3tOnSMCMJV/HzJZSLh7Sfr+6xf4=;
        b=HgDAT0wz6m8kCUFxGwtZLpIsnInckp0K8A97XfGk66lcsuNEt1vGXvwOOQBh/64FPN
         iRRNgjhTuvdkyKkIUpiszYMBSPrMXoJMhNM/YKfwGPyEjPbQYY6ud1l/47Le5eiYztuD
         WETYzEB3d10R9XLPdXGB781xZwhU75/gJmF1wA4joxIaEZmUFk+pWfPBSeshK28L24GX
         bD8w+WE1I00Q4Wcy0GUKMddOvQ8MApmEq+Per0+KBXXFfxx4YL4C73sKBVGFPLHH1FWP
         xRseK6dxpQnCAYpTobnprYV6UelUTwZmcAnjzZIfsul817y1LgmGyJJRLLNZRKXvR0w0
         8c1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 38xthwgkbanqiopa0bb4h0ff83.6ee6b4ki4h2edj4dj.2ec@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=38XTHWgkbANQIOPA0BB4H0FF83.6EE6B4KI4H2EDJ4DJ.2EC@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 38xthwgkbanqiopa0bb4h0ff83.6ee6b4ki4h2edj4dj.2ec@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=38XTHWgkbANQIOPA0BB4H0FF83.6EE6B4KI4H2EDJ4DJ.2EC@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx49sX0UjBXqjr2nsqi2uUoaTAxWtbarsMyelw/T5iigdn0OlBNrnh5Ym3QPNlo4yw3wjwvcRgUb9ZYJEusaCrkwA1V5HJLD5
MIME-Version: 1.0
Date: Fri, 06 Apr 2018 06:24:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a11425bc430af6c05692df8c8@google.com>
Subject: INFO: rcu detected stall in snd_pcm_stream_lock_irq
From: syzbot <syzbot+74e011b2046f4322d178@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	mark.rutland@arm.com, syzkaller-bugs@googlegroups.com, tchibo@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597003312361546038?=
X-GMAIL-MSGID: =?utf-8?q?1597003312361546038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
Merge tag 'armsoc-drivers' of  
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=74e011b2046f4322d178

Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4582053840420864
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5813481738265533882
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+74e011b2046f4322d178@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

syz-executor1 (6140) used greatest stack depth: 11720 bytes left
INFO: rcu_sched self-detected stall on CPU
	1-....: (124998 ticks this GP) idle=0b2/1/4611686018427387906  
softirq=15730/15730 fqs=31205
	 (t=125000 jiffies g=8316 c=8315 q=1529)
NMI backtrace for cpu 1
CPU: 1 PID: 6087 Comm: syz-executor0 Not tainted 4.16.0+ #3
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
  tick_sched_handle+0xa0/0x180 kernel/time/tick-sched.c:171
  tick_sched_timer+0x42/0x130 kernel/time/tick-sched.c:1179
  __run_hrtimer kernel/time/hrtimer.c:1337 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1399
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1457
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x50 kernel/kcov.c:106
RSP: 0018:ffff8801920cf4d0 EFLAGS: 00000216 ORIG_RAX: ffffffffffffff13
RAX: 0000000000040000 RBX: ffff8801ceb61200 RCX: ffffc90001eb0000
RDX: 0000000000040000 RSI: ffffffff859d760f RDI: ffff8801ceb61200
RBP: ffff8801920cf4d0 R08: ffff8801b4946540 R09: 0000000000000006
R10: ffff8801b4946540 R11: 0000000000000000 R12: ffffffff8826fa20
R13: 0000000000000020 R14: ffff8801d3008c00 R15: ffff8801ceb61200
  snd_pcm_stream_lock_irq+0xf/0xf0 sound/core/pcm_native.c:150
  __snd_pcm_lib_xfer+0x345/0x1d10 sound/core/pcm_lib.c:2162
  snd_pcm_oss_write3+0xe9/0x220 sound/core/oss/pcm_oss.c:1236
  io_playback_transfer+0x274/0x310 sound/core/oss/io.c:47
  snd_pcm_plug_write_transfer+0x36c/0x470 sound/core/oss/pcm_plugin.c:619
  snd_pcm_oss_write2+0x25c/0x460 sound/core/oss/pcm_oss.c:1365
  snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1431 [inline]
  snd_pcm_oss_write+0x55f/0xa20 sound/core/oss/pcm_oss.c:2774
  do_loop_readv_writev fs/read_write.c:703 [inline]
  do_iter_write+0x491/0x5f0 fs/read_write.c:961
  vfs_writev+0x1c7/0x330 fs/read_write.c:1004
  do_writev+0x112/0x2f0 fs/read_write.c:1039
  SYSC_writev fs/read_write.c:1112 [inline]
  SyS_writev+0x27/0x30 fs/read_write.c:1109
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4552d9
RSP: 002b:00007f82ef52cc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f82ef52d6d4 RCX: 00000000004552d9
RDX: 0000000000000001 RSI: 0000000020000180 RDI: 0000000000000015
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000006cc R14: 00000000006fd3c0 R15: 0000000000000000


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
