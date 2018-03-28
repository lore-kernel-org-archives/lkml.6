Return-Path: <3IkC7WgkbAGsbhiTJUUNaJYYRM.PXXPUNdbNaLXWcNWc.LXV@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522221091; cv=none;
        d=google.com; s=arc-20160816;
        b=m+426LuLsTMatVcGdSzePiW+iqWoAexbg8C8ELHo9J0dHSgiNn2ZP8jycgAnrTa0BT
         siqsECAq05w4OVfClGE7L23hS05LzdYci9uMbh1erYgEGm8r+K966Otu8p5vpvaVkTvy
         t9QLkYJXTSwRzNsQ79F5rXX0XxMdDLHaI/YskTptfVoAdQZGfsxTFxRKwVHSCXcP4+cF
         8Ja84cBFLIcaFQykLvWqLbEJCrT8gBKRF/Fa/3cuqg1MNZnz0W8cKj4Seqng1HGNmaTQ
         wIcpCiASELd6QxaY0pXMw/5ekVgoVwWFzy1i2xwDvRg0xM8eZ1YunlVQWBdbvlU2HhAg
         tKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=qcr0fFmXThE5aMUBiXfVyGJZTAGHcyVwl2x39CNVk6U=;
        b=L9Gtw7s0vygQEwpYTGbpXIqwIu3geakz2T8y83PAvlTvl4zU77fJfG4+cXaJ5mpj9G
         GmzcuAP25+Xn5kJzHBcBn5gOcHYpBVp+hbD3W5PRDot8WjBepKGTkye69XCFzcngnmL9
         iqBnFBPRLO/r4R4POEGy0v1b4NE8/vUSVlxwHbinTmM5ms3ghoxJvGaxjWnjgqhCozcP
         G6o3pcRMSzo1ScSGw7EPAbhaJiMiZpoj6Vq4dJXuYTzBJa9mZCVSDXRTiMx1Fmm9r4Nc
         NDqgPF6wE/kktdno73R8di/9+OZx7mUm68eHP9hrPCUXyLxzpIfq6NvrBSG2dXSnjTIi
         FI3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3ikc7wgkbagsbhitjuunajyyrm.pxxpundbnalxwcnwc.lxv@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3IkC7WgkbAGsbhiTJUUNaJYYRM.PXXPUNdbNaLXWcNWc.LXV@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3ikc7wgkbagsbhitjuunajyyrm.pxxpundbnalxwcnwc.lxv@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3IkC7WgkbAGsbhiTJUUNaJYYRM.PXXPUNdbNaLXWcNWc.LXV@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AG47ELtPiCuoSScA07VIWLbFpofFY7p5lLhUvjKG1b9EQm9Qmho32XzJecaxJ7Aba72lG1Dmwu/n64J1mE7SIU1BtBltAelyNayX
MIME-Version: 1.0
Date: Wed, 28 Mar 2018 00:11:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061b9c3056873b7c3@google.com>
Subject: INFO: rcu detected stall in commit_echoes
From: syzbot <syzbot+a0366f667e2cac7c0bbf@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596164503018865475?=
X-GMAIL-MSGID: =?utf-8?q?1596164503018865475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
3eb2ce825ea1ad89d20f7a3b5780df850e4be274 (Sun Mar 25 22:44:30 2018 +0000)
Linux 4.16-rc7
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=a0366f667e2cac7c0bbf

So far this crash happened 3 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6443860423081984
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a0366f667e2cac7c0bbf@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched self-detected stall on CPU
	0-....: (124999 ticks this GP) idle=692/1/4611686018427387906  
softirq=21889/21889 fqs=31226
	 (t=125000 jiffies g=11261 c=11260 q=580)
NMI backtrace for cpu 0
CPU: 0 PID: 215 Comm: kworker/u4:4 Not tainted 4.16.0-rc7+ #3
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
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
RSP: 0018:ffff8801d93e7070 EFLAGS: 00000217 ORIG_RAX: ffffffffffffff12
RAX: 0000000000000000 RBX: ffffc90007f8a000 RCX: ffffffff82f38392
RDX: 0000000000000007 RSI: 1ffff1003b278d6c RDI: ffffc90007f8bb1f
RBP: ffff8801d93e70e0 R08: 1ffff1003b27cdb5 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000577d218be
R13: dffffc0000000000 R14: 00000000000008bf R15: 0000000000001ed0
  commit_echoes+0x147/0x1b0 drivers/tty/n_tty.c:764
  n_tty_receive_char_fast drivers/tty/n_tty.c:1416 [inline]
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1576 [inline]
  __receive_buf drivers/tty/n_tty.c:1611 [inline]
  n_tty_receive_buf_common+0x1156/0x2520 drivers/tty/n_tty.c:1709
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
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
