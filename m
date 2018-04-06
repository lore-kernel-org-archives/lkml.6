Return-Path: <3GePHWgkbANoOUVG6HHAN6LLE9.CKKCHAQOAN8KJPAJP.8KI@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523049241; cv=none;
        d=google.com; s=arc-20160816;
        b=rHw09Ji1Y0KpRrKRZbysWv2ypFpgyGRjf+jBUmYlP6+sxKkV3fxO58OAjLojMJNhHb
         CUuoy/AGAH0qo9qdHzDNvlBCAznqlmfOMAs2DCTe2FUFAlStLxFjyhHnCFZWoyfDnzgV
         3BnQ6mmdHrCBgUhD35oAOzAKHVrk8viXNw2WDaclx6RAHl1MAXOIbH0b9BnEr3iru3Lm
         FJigD1NOgjsxYyMxlsglxrjzCCkJDbTDSPo43811oL7+3HoFOPR7z2vqhe89KTN0GuGC
         PI0Wrlho5vmyg7yuFRtyV04k6MAmqEPi0uOfSJmNF44orcla7ssXa29bMbieRRg7INjp
         EWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :arc-authentication-results;
        bh=+PPElNL0xkdOI8yt626uh2Rz+4p1LhPznaLZV5df8ZE=;
        b=So/jbnKtmfPAzbOj+UdyAM3bD1/aZ3BHxLn3kW5v3CxnzYlD5iakAwpBdDxNTnCGYF
         QY8uY9zlR4x1pHXVkltLNERFGAO1KLUHNQDUJLj8iAkquXt3Tk3ZPzqH8sBn0c1Gtf3t
         nR1ezhtLp+USqVzOeQY7M+V1cFCO6EJEvtT/CLSrBRgdIAkPpuOvJs4kJQ7YpYPVUMjY
         aLlkO6vuI+arAn/pny4PFb6/+D9hDrt4iM8JkyISZxt9sATVYQnsm8sCFkLXRoM6jnWo
         CsmzMQd5ulHq59G6ZIrccsl5s8rtYBBqogsfcZjcZ8DiIxmk1ib+XRbPf48BV1v0RR4v
         9Btg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3gephwgkbanoouvg6hhan6lle9.ckkchaqoan8kjpajp.8ki@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3GePHWgkbANoOUVG6HHAN6LLE9.CKKCHAQOAN8KJPAJP.8KI@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3gephwgkbanoouvg6hhan6lle9.ckkchaqoan8kjpajp.8ki@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3GePHWgkbANoOUVG6HHAN6LLE9.CKKCHAQOAN8KJPAJP.8KI@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx48SK0IiN1h01Ct/E/NXCrj5jIoq3AO9OB21HtOXiAqcK4UhtThtrkUXqNDbZ0PNAzMxQD7F2JcToTzUQqdqjuubOTz367YZ
MIME-Version: 1.0
Date: Fri, 06 Apr 2018 14:14:01 -0700
In-Reply-To: <000000000000118a9a056928bbd9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004c1de05693489a8@google.com>
Subject: Re: INFO: rcu detected stall in snd_pcm_oss_write3 (2)
From: syzbot <syzbot+150189c103427d31a053@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, alsa-devel@alsa-project.org,
	aryabinin@virtuozzo.com, dvyukov@google.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, o-takashi@sakamocchi.jp, perex@perex.cz,
	syzkaller-bugs@googlegroups.com, tchibo@google.com, tglx@linutronix.de,
	tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979719194785856?=
X-GMAIL-MSGID: =?utf-8?q?1597032881789317038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

syzbot has found reproducer for the following crash on upstream commit
38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
Merge tag 'armsoc-drivers' of  
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=150189c103427d31a053

So far this crash happened 15 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5405588854931456
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5561439796330496
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5697900571000832
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5813481738265533882
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+150189c103427d31a053@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

IPVS: ftp: loaded support on port[0] = 21
INFO: rcu_sched self-detected stall on CPU
	1-....: (124999 ticks this GP) idle=622/1/4611686018427387906  
softirq=10596/10596 fqs=31239
	 (t=125000 jiffies g=4952 c=4951 q=20)
NMI backtrace for cpu 1
CPU: 1 PID: 4474 Comm: syzkaller631460 Not tainted 4.16.0+ #3
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
RIP: 0010:__snd_pcm_lib_xfer+0x768/0x1d10 sound/core/pcm_lib.c:2111
RSP: 0018:ffff8801b7b76ea8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffffffffffffffe0 RCX: ffffed0036f6edec
RDX: 0000000000000000 RSI: ffffffff859ff04e RDI: ffffed0036f6edf0
RBP: ffff8801b7b77148 R08: ffff8801afeae9b8 R09: 0000000000000006
R10: ffff8801afeae140 R11: 0000000000000000 R12: 0000000000000004
R13: 00000000ffffffe0 R14: ffff8801af2165c0 R15: ffff8801ceaec000
  snd_pcm_oss_write3+0xe9/0x220 sound/core/oss/pcm_oss.c:1236
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
  SYSC_exit_group kernel/exit.c:979 [inline]
  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4446e9
RSP: 002b:00007ffe29466408 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 00000000004446e9
RDX: 00000000004446e9 RSI: 0000000000000080 RDI: 0000000000000001
RBP: 00000000006cf018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401ff0
R13: 0000000000402080 R14: 0000000000000000 R15: 0000000000000000
