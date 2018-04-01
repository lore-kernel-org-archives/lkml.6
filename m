Return-Path: <3KxPBWgkbADIgmnYOZZSfOddWR.UccUZSigSfQcbhSbh.Qca@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522602796; cv=none;
        d=google.com; s=arc-20160816;
        b=QpHO0ZdAmx1jPLgLD5RDJrWPXYjQvjePHKl12onNRMZeCOE0G2Q1GpNkMzvDu0wR6o
         ZG85fx3wJIQpqgCIVtD4r9/qwEDiBTeC6VkffR3Pc+JeDOeig082ZNx3WILI2u2P1hhG
         zmao0yQp6iYRY/uOKJjDPSYXTcmnRjqDbLkVTCnRVsvA4sTL+z/4prdOKW3gotWAviaq
         HG8v+PKtzrawAeU5YB30L9oYbZPY1rrYKfyT47JMXUKMRHrimb3Se6pWOjq4gwX0U0VF
         lNiPHEaLOKwV6S0P5sVUTepQvEVlKA6lkUhMeADUzTc8mXMrN7WcH+IXCQ6k0cYjFdsJ
         Xkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=R2H5fuagOGPZbPTSFda2MwjXIUZn/uf+bn39S9TptlI=;
        b=uh9qiUXWLXvG0wojcL1ozTnKXzZm4aW/mcXGOpBYPVC4rGpDIr+vf4DTpmn2nDHyP7
         oRY6JM606ieudToiVPAZIM2AB0knqdfSRAcRTMF988/p2mQ2KQrD/03/7FbfCKcIMdNI
         KdNOMcQRBiH9KmpmiUnt2Oy/onUGXgYyYJ+su9RzcJ6P+hnS4Z4jPffGiWGRL83QrNsB
         cDOiGyF528A7Ja6sHtJougmlO9eH8Ow0U7nqFN7B1l7ZttZ66eeqKozmuThS6UkROSu6
         lqd+jzj/Ou38nTl9Ya2mcxXQPSecv283FOcC9+46TXRmzooer0dV4MRqWOyY+DoreeEo
         hgzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3kxpbwgkbadigmnyozzsfoddwr.uccuzsigsfqcbhsbh.qca@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3KxPBWgkbADIgmnYOZZSfOddWR.UccUZSigSfQcbhSbh.Qca@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3kxpbwgkbadigmnyozzsfoddwr.uccuzsigsfqcbhsbh.qca@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3KxPBWgkbADIgmnYOZZSfOddWR.UccUZSigSfQcbhSbh.Qca@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx493sWX2awaXz4Pu7YxHElfQZZZK9cvMnkw1d42S5pkGBRnKJD/iD3f0GR/PuoTn0yqcKXPGRhKR49YrizaGklyaENOuIzoZ
MIME-Version: 1.0
Date: Sun, 01 Apr 2018 10:13:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113eba28c654440568cc9604@google.com>
Subject: INFO: rcu detected stall in __bitmap_set
From: syzbot <syzbot+c479aeac880b090ceeb2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	mark.rutland@arm.com, pombredanne@nexb.com, syzkaller-bugs@googlegroups.com,
	tchibo@google.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596564749571556487?=
X-GMAIL-MSGID: =?utf-8?q?1596564749571556487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot hit the following crash on upstream commit
cb6416592bc2a8b731dabcec0d63cda270764fc6 (Sun Mar 25 17:45:10 2018 +0000)
Merge tag 'dmaengine-fix-4.16-rc7' of  
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=c479aeac880b090ceeb2

So far this crash happened 3 times on upstream.
Unfortunately, I don't have any reproducer for this crash yet.
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=5205501092560896
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-5034017172441945317
compiler: gcc (GCC) 7.1.1 20170620

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c479aeac880b090ceeb2@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

INFO: rcu_sched self-detected stall on CPU
	1-....: (124999 ticks this GP) idle=1ca/1/4611686018427387906  
softirq=17365/17365 fqs=31238
	 (t=125000 jiffies g=7965 c=7964 q=402)
NMI backtrace for cpu 1
CPU: 1 PID: 6633 Comm: syz-executor6 Not tainted 4.16.0-rc6+ #366
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
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x3b/0x50 kernel/kcov.c:106
RSP: 0018:ffff8801ce8ef680 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff12
RAX: 0000000000010000 RBX: ffffffffffffff80 RCX: ffffffff825ae73d
RDX: 000000000000ffff RSI: ffffc90004a0d000 RDI: ffff8801d1a15660
RBP: ffff8801ce8ef680 R08: ffffed003a342acd R09: ffff8801d1a15660
R10: 0000000000000001 R11: ffffed003a342acc R12: ffffffffffffffff
R13: 0000000000000000 R14: ffff8801d1a15660 R15: 0000000000000000
  __bitmap_set+0xdd/0x110 lib/bitmap.c:274
  bitmap_set include/linux/bitmap.h:365 [inline]
  __bitmap_parselist+0x310/0x4b0 lib/bitmap.c:616
  bitmap_parselist+0x3a/0x50 lib/bitmap.c:628
  cpulist_parse include/linux/cpumask.h:639 [inline]
  update_cpumask kernel/cgroup/cpuset.c:974 [inline]
  cpuset_write_resmask+0x1694/0x2850 kernel/cgroup/cpuset.c:1724
  cgroup_file_write+0x2ae/0x710 kernel/cgroup/cgroup.c:3429
  kernfs_fop_write+0x2bc/0x440 fs/kernfs/file.c:316
  __vfs_write+0xef/0x970 fs/read_write.c:480
  vfs_write+0x189/0x510 fs/read_write.c:544
  SYSC_write fs/read_write.c:589 [inline]
  SyS_write+0xef/0x220 fs/read_write.c:581
  do_syscall_64+0x281/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x454879
RSP: 002b:00007fd0e0f38c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd0e0f396d4 RCX: 0000000000454879
RDX: 0000000000000008 RSI: 0000000020000080 RDI: 0000000000000015
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000067c R14: 00000000006fac40 R15: 0000000000000000


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
