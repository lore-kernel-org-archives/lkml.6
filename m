Return-Path: <3rj27WgkbAPElrsdTeeXkTiibW.ZhhZeXnlXkVhgmXgm.Vhf@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522220462; cv=none;
        d=google.com; s=arc-20160816;
        b=jH3Rmt/gjv8QwEegxwvp3CcBbgoIYlZEwX4zMJzAUmH5q4VF7J8gPcVvlQhicLHRqb
         64PcLfIgvRztE+NYefWoyE+Hu26HC/XztBFkGdKUsiHDdqn+7YyMx7cxR8nF9w0FbgTn
         ZETv+7pLaGypmkKGQj7mgrpW/ToH+RxGkoie6juJV8oc5nJkw1k8DMi502MnRYa6NzNB
         DWIGI903XD4BgCfJ0Hs9kq5p6ae/IpB2BkCqQdylAUkHHo9HIf2781Y0NgHZ6MN7KS30
         wou5v6d3afdlEJtliSirBlpEsnNZdO2CZ8ljmZFdcQ6i/L4L4KF5sy0FPNpLP7fcO0WG
         JC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=JnUvmEExLz0H8hZ0JQLotNhL3Ez5h4wuzX9NeHBPCEs=;
        b=byqD68MEUL50QL1txv4U1H9ZlAzHz8simo9OHueSCkgKVd5ac+YGAkt17MaVx/qWi2
         CxxdwKk6gML66mfKEaZ1+uPKOevxChZykiiGqeSDtO/t3dMvPWJXPyHCcV3VdBAtjthr
         ckv/aoG/bSDvLfUgYHJWyh69HtZCOBtNiTK6VOPiS86rw+D28+CG6WeqDbQkF16J47y4
         0Y3MSpMenhbMS/326JO+7icC+Ir5xxilFx1fI85OechLKnTeSFf2NweVAEGVkoGir9zd
         xQPeUAfnW0jj8IPHOtn3/kzLz1Zo/Xtj9NgR/leAOIuYsV5OBX48XjTBaAlBEfAvQZUz
         n66Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3rj27wgkbapelrsdteexktiibw.zhhzexnlxkvhgmxgm.vhf@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3rj27WgkbAPElrsdTeeXkTiibW.ZhhZeXnlXkVhgmXgm.Vhf@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3rj27wgkbapelrsdteexktiibw.zhhzexnlxkvhgmxgm.vhf@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3rj27WgkbAPElrsdTeeXkTiibW.ZhhZeXnlXkVhgmXgm.Vhf@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx4/R8GDNsdR7IfEVqhqiRVOGPvYNuTsxS9E4x0EBGjaLPUEeWGQwctODAF3iEthr2LMWf6XKq3QUDfUlQFRz9fLacAd3Fp8N
MIME-Version: 1.0
Date: Wed, 28 Mar 2018 00:01:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a1140e920eb829905687391d6@google.com>
Subject: INFO: rcu detected stall in __process_echoes
From: syzbot <syzbot+108696293d7a21ab688f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tchibo@google.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596163843273194959?=
X-GMAIL-MSGID: =?utf-8?q?1596163843273194959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
3eb2ce825ea1ad89d20f7a3b5780df850e4be274 (Sun Mar 25 22:44:30 2018 +0000)
Linux 4.16-rc7
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=108696293d7a21ab688f

So far this crash happened 10 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=4941573204738048
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5314352743710720
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5561943247028224
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+108696293d7a21ab688f@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched self-detected stall on CPU
	0-....: (124999 ticks this GP) idle=6aa/1/4611686018427387906  
softirq=9528/9528 fqs=31245
	 (t=125000 jiffies g=4714 c=4713 q=8)
NMI backtrace for cpu 0
CPU: 0 PID: 51 Comm: kworker/u4:2 Not tainted 4.16.0-rc7+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
  nmi_trigger_cpumask_backtrace+0x123/0x180 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
  rcu_dump_cpu_stacks+0x186/0x1de kernel/rcu/tree.c:1375
  print_cpu_stall kernel/rcu/tree.c:1524 [inline]
  check_cpu_stall.isra.61+0xbb8/0x15b0 kernel/rcu/tree.c:1592
  __rcu_pending kernel/rcu/tree.c:3361 [inline]
  rcu_pending kernel/rcu/tree.c:3423 [inline]
  rcu_check_callbacks+0x238/0xd20 kernel/rcu/tree.c:2763
  update_process_times+0x30/0x60 kernel/time/timer.c:1636
  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1194
  __run_hrtimer kernel/time/hrtimer.c:1349 [inline]
  __hrtimer_run_queues+0x39c/0xec0 kernel/time/hrtimer.c:1411
  hrtimer_interrupt+0x2a5/0x6f0 kernel/time/hrtimer.c:1469
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:857
  </IRQ>
RIP: 0010:__write_once_size include/linux/compiler.h:215 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x4b/0x50 kernel/kcov.c:109
RSP: 0018:ffff8801d96170a8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff12
RAX: ffff8801d960a5c0 RBX: ffffc90001fb8000 RCX: ffffffff82f38349
RDX: 0000000000000000 RSI: 1ffff1003b2c15e4 RDI: ffffc90001fb9963
RBP: ffff8801d96170a8 R08: 1ffff1003b2c2dbd R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000000057efa5704
R13: dffffc0000000000 R14: 000000057efa5704 R15: 0000000000003321
  echo_buf drivers/tty/n_tty.c:144 [inline]
  __process_echoes+0x5c9/0x770 drivers/tty/n_tty.c:732
  flush_echoes drivers/tty/n_tty.c:799 [inline]
  __receive_buf drivers/tty/n_tty.c:1615 [inline]
  n_tty_receive_buf_common+0x1380/0x2520 drivers/tty/n_tty.c:1709
  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
  tty_ldisc_receive_buf+0xa7/0x180 drivers/tty/tty_buffer.c:456
  tty_port_default_receive_buf+0x106/0x160 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:475 [inline]
  flush_to_ldisc+0x3c4/0x590 drivers/tty/tty_buffer.c:524
  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
