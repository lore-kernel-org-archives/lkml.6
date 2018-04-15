Return-Path: <35VbTWgkbALwu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523799781; cv=none;
        d=google.com; s=arc-20160816;
        b=Ktxhags6dEshZaTt+huSrW6OrbrMiJfNCHYKdU68uV3jcx+k/OiW+ybFs3LtkQwa44
         cLQenK631S0ms4DwGmxD80fiqwdw+HiVw83mW6qArxtsno+ETqs7WUd0GRA3qHHVQbgp
         Wa9QVX/iPjuICIzXexEi3Qrhig1SFVuMPsAVDFCrfZXD2wDQcKEbTvuryw/vlG8OkTsq
         S/3bwCwQ6tmcs3yvXv+8sdEtiwIkpQ4L/4eMcPoyfTxXV2Z2dvIh4k+GgwOcJ0JXj3be
         j7865cviIegEIwQTM3e7qWTAig+GHAveoPte43B/vkxS/SA6sIkmp8KythPOLJ+9TNkx
         E8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :arc-authentication-results;
        bh=P00I2/dHXuR5WgrVN7YYTtLuxb6gJF5iDJwcJ9L+b1o=;
        b=hT2ANb0QXyL2q3Aw9zYXEj/+A0Pw0pSj2djWkgCGGxkc5RkOT+JoxQeIaeq5syPdbJ
         V1ZM1X80ZTawoXSNQpuwbHo1r2IAOHQZEHFi3EhmKC+OdUaQCzANM9LsoLPbIvLq7E26
         cDQwxqEJR8+yiyiqBe5t38soA1Sm8pyprGmxYwaVVsckRYB1HQFszhRVihRvz77BVQ1z
         lQ4nMHl1uSb0eVYJ9Es6wkoTHYA9tSojGr7Yrbk5SPimTWBA88Z/5zYt1+EB1iARHEpS
         p/shdY/LqaGx+NE789MqL1i3jc6ArBcNprhpH6Ym5FYqqfRxu6oJ3aV4fvApHnlD89JV
         pNRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 35vbtwgkbalwu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=35VbTWgkbALwu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 35vbtwgkbalwu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=35VbTWgkbALwu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AIpwx4/051ns7uKBWG6fxK1+X8HIUWf1Y3HNKhzDnsXQxDE9kPI2S+IxYL38YmNtwDbMtpKM/5QwdeFuLUNzeLX20GFH6F+aA8wB
MIME-Version: 1.0
Date: Sun, 15 Apr 2018 06:43:01 -0700
In-Reply-To: <883d24f7d4ccc52e19056928c5be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <001a113f8d5cab39bd0569e3482a@google.com>
Subject: Re: INFO: rcu detected stall in n_tty_receive_char_special
From: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
To: dvyukov@google.com, gregkh@linuxfoundation.org, jslaby@suse.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979907220664835?=
X-GMAIL-MSGID: =?utf-8?q?1597819879782516813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

syzbot has found reproducer for the following crash on upstream commit
18b7fd1c93e5204355ddbf2608a097d64df81b88 (Sat Apr 14 15:50:50 2018 +0000)
Merge branch 'akpm' (patches from Andrew)
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=18df353d7540aa6b5467

So far this crash happened 2 times on upstream.
C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5283196245639168
syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=5978502260064256
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=4993708470566912
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-8852471259444315113
compiler: gcc (GCC) 8.0.1 20180413 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.

INFO: rcu_sched self-detected stall on CPU
	1-....: (124999 ticks this GP) idle=792/1/4611686018427387906  
softirq=9920/9920 fqs=31243
	 (t=125000 jiffies g=4830 c=4829 q=20)
NMI backtrace for cpu 1
CPU: 1 PID: 4467 Comm: syzkaller756606 Not tainted 4.16.0+ #3
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
  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:173
  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1283
  __run_hrtimer kernel/time/hrtimer.c:1386 [inline]
  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1448
  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1506
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
  </IRQ>
RIP: 0010:echo_char+0x96/0x2e0 drivers/tty/n_tty.c:915
RSP: 0018:ffff8801b079f6f8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffff8801b06ee1c0 RBX: ffffc90001e64000 RCX: ffffffff837ab4a7
RDX: 0000000000000000 RSI: ffffffff837ab4b6 RDI: 0000000000000001
RBP: ffff8801b079f728 R08: ffff8801b06ee1c0 R09: 0000000000000001
R10: ffff8801b06eea20 R11: ffff8801b06ee1c0 R12: 000000000000000f
R13: ffff8801b02b0dc0 R14: 000000012b1bcc47 R15: 0000000000000c47
  n_tty_receive_char_special+0x13b3/0x31c0 drivers/tty/n_tty.c:1306
  n_tty_receive_buf_fast drivers/tty/n_tty.c:1577 [inline]
  __receive_buf drivers/tty/n_tty.c:1611 [inline]
  n_tty_receive_buf_common+0x20ca/0x2c50 drivers/tty/n_tty.c:1709
  n_tty_receive_buf+0x30/0x40 drivers/tty/n_tty.c:1738
  tiocsti drivers/tty/tty_io.c:2171 [inline]
  tty_ioctl+0x7e7/0x1870 drivers/tty/tty_io.c:2557
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  SYSC_ioctl fs/ioctl.c:708 [inline]
  SyS_ioctl+0x24/0x30 fs/ioctl.c:706
  do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x42/0xb7
RIP: 0033:0x4404b9
RSP: 002b:00007ffee94bd7f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000200006c0 RCX: 00000000004404b9
RDX: 00000000200000c0 RSI: 0000000000005412 RDI: 0000000000000012
RBP: 6d74702f7665642f R08: 000000000000000a R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401c30
R13: 0000000000401cc0 R14: 0000000000000000 R15: 0000000000000000
