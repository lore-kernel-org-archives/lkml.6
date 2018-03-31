Return-Path: <3Va-_WgkbAI4AGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522511702; cv=none;
        d=google.com; s=arc-20160816;
        b=wgSygKIfB8VyAMGsCABZEQgV19hL0iwGxNk+ddPFckC8SKMSPEMDGG9R7nHwpWvw1Y
         NlPOtjQvnOBrXMuwIt6tuBcjbE98xaPbaFcNbujrtutvUarkZ0FoASn86XgGm9RO/zov
         ihpg5NS5B3wcgw064IBApf0bqf95EyraHVuHKbngaYFE8Y/pKb6BSPaLurndEOlKzyTq
         VmnzQx9m+1VaJHj0320CCygkjYCkrSXvm/BJfIMoE0c8ukCuG/cdMUo0V4zextI8G0Vw
         t3xRX+PjJlYU1qMX5ugPM988u5coZNNoUSBJR0qcRgrRtO/3k3JoLRfLSE4JrOYjdMm/
         CQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=7CSxtasgtPxXXOPeQw1ORupWdE8kCf2BQj5lUneKYIQ=;
        b=l1hq5AylGYb6JGYA6w6hUGBG2CkgsrwfKfTcUV1QZczv94hLM8FA3EqDWlmMH+ofIQ
         5VHFUDeQmx46fIlAQy4jdpBkNUytd+LPyFmQ4nta5XbT7ieM+2G/E3BruWv01zgVg4jx
         QGrpv6yERHqhUYzfjslXiawTxgqTST1jkX73UZ8SOleNB1XLvj3vdcp71ycFfxCjPi78
         aT+Hw818b77ANWATARNYmR/woXxQIMmx6MtwIw/AXy8nOLkQvxpQ72OZtzumkBxbdRp5
         RG8c2wR62PoudMLROdinZCVkKo6nf5UuW7cqyVFzjc6pQxp2fh7iRAZLefbId3LpSIuK
         tEyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3va-_wgkbai4agh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3Va-_WgkbAI4AGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3va-_wgkbai4agh2s33w9s770v.y66y3wcaw9u65bw5b.u64@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3Va-_WgkbAI4AGH2s33w9s770v.y66y3wCAw9u65Bw5B.u64@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx48xcKP8Ug3zamB0BPnBivIBORKS+6+LXqjzgiHppFOIPbLGQHjxXBaaXeaW17RchMUp5NjRHzVIUSLSMe1xXHOw/cLKzszj
MIME-Version: 1.0
Date: Sat, 31 Mar 2018 08:55:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <94eb2c05b2d829b3db0568b76106@google.com>
Subject: INFO: rcu detected stall in n_tty_receive_buf_common
From: syzbot <syzbot+b7d0f37ffd431e2d698c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596469230959732817?=
X-GMAIL-MSGID: =?utf-8?q?1596469230959732817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
0b412605ef5f5c64b31f19e2910b1d5eba9929c3 (Thu Mar 29 01:07:23 2018 +0000)
Merge tag 'drm-fixes-for-v4.16-rc8' of  
git://people.freedesktop.org/~airlied/linux
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=b7d0f37ffd431e2d698c

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5308434815647744
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5176078016446464
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5940022372990976
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b7d0f37ffd431e2d698c@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched self-detected stall on CPU
	0-....: (124999 ticks this GP) idle=6ea/1/4611686018427387906  
softirq=9748/9748 fqs=31240
	 (t=125000 jiffies g=4823 c=4822 q=10)
NMI backtrace for cpu 0
CPU: 0 PID: 4469 Comm: syzkaller058368 Not tainted 4.16.0-rc7+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
RIP: 0010:echo_buf drivers/tty/n_tty.c:144 [inline]
RIP: 0010:__process_echoes+0x5d9/0x770 drivers/tty/n_tty.c:732
RSP: 0018:ffff8801af12f7f0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff12
RAX: 0000000000000594 RBX: ffffc90001946000 RCX: ffffffff82f38469
RDX: 0000000000000000 RSI: 1ffff1003543c565 RDI: ffffc900019477f4
RBP: ffff8801af12f858 R08: 1ffff10035e25ea4 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000005e6b39594
R13: dffffc0000000000 R14: 00000005e6b39594 R15: 0000000000003803
  flush_echoes drivers/tty/n_tty.c:799 [inline]
  __receive_buf drivers/tty/n_tty.c:1615 [inline]
  n_tty_receive_buf_common+0x1380/0x2520 drivers/tty/n_tty.c:1709
  n_tty_receive_buf+0x30/0x40 drivers/tty/n_tty.c:1738
  tiocsti drivers/tty/tty_io.c:2171 [inline]
  tty_ioctl+0x9c5/0x1610 drivers/tty/tty_io.c:2557
  vfs_ioctl fs/ioctl.c:46 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
  SYSC_ioctl fs/ioctl.c:701 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x446979
RSP: 002b:00007fb18094bd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006e29fc RCX: 0000000000446979
RDX: 00000000200000c0 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00000000006e29f8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 6d74702f7665642f
R13: 00007ffc95813d0f R14: 00007fb18094c9c0 R15: 0000000000000001


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
