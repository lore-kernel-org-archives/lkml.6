Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518449120; cv=none;
        d=google.com; s=arc-20160816;
        b=CX/nZ19gc8/WfnfIJgjiPbQNB3IAVOzqpbcZ0odfhu+EcGGCPgJ/dLt9GZHngRxe+w
         5X77/fh/LueAo5ae94ABseY9zU64tVdFkeU2khqvGTri3t+1O4O4BJaSRCNDYas7n1Qd
         wyM5AChJRHrH0xn2twKIQDfV0h4J3JLHKwpeRUcI8uSgzbmlV8sksXDViXkdgmrwYv40
         xadlQblIYUeAMi7HM9+fMhT+K2Rq4k4kxQ37e5H2b/8yUIsdDVikWtd2nydL4MfQMlWj
         hJIyMtS12NRqnwkQYpeS8hkIRTfuCYzm4sXfSb4mkJvy3jpllYUpcrxEO/QTJxHtLAac
         GYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yqC0JnHXMqElTW65jTbMkyrBSds+mMizsJeuTtfMI/k=;
        b=hT8bP5rB1Ib9O1ov0WJOO+ZEd99proLwEhQnfOgJO5hAEmu/4Mc5wrgs1eILKcE0DI
         x/6U60ikSkMDvd7dSkXCWXzuvp0blz9qBvzvSqcCkJrLw7yaMwi7pS5oKGrSD549dj7l
         7kouij6rp6yXBi8moXWBZC/qePLW9GlACoLZoS8nXBffDD/MNuUqFyAcx30Rfz9nCtrb
         3XZbPrjt5sLrkTLzZaFy3T+jEnh6Ki0vGQHZH7gSoC7oZZknB7jGH+tlGW/oCJ/W076r
         mZpdod6/SeDNXy9jIOz+zYBUlp2rUqffHQlqSOWilAIhEoME/Z2iLIzX+R9BFE8Ha7MR
         q2rA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jVHzmh2Y;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jVHzmh2Y;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x227ZWYclwcJpPCWkPkPruMb6tnNVmAUJr8RhHRyZH07GxXLN3suKEUuqNofwn6l/BCk2piAFi1EoSYPQXZzjnNs=
MIME-Version: 1.0
In-Reply-To: <001a113f6d56977f0b056505705a@google.com>
References: <001a113f6d56977f0b056505705a@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2018 16:24:58 +0100
Message-ID: <CACT4Y+aKht+L1NFXT0+a=fAa66rSApc--3FGFRjV1xcn8rpa0Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in __xfrm_decode_session
To: syzbot <syzbot+9a24dafd2f9855d33cd3@syzkaller.appspotmail.com>
Cc: Janakarajan.Natarajan@amd.com, Borislav Petkov <bpetkov@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Philippe Ombredanne <pombredanne@nexb.com>, syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>, "the arch/x86 maintainers" <x86@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592209097207473081?=
X-GMAIL-MSGID: =?utf-8?q?1592209304224730301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 4:22 PM, syzbot
<syzbot+9a24dafd2f9855d33cd3@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on net-next commit
> d0adb51edb73c94a595bfa9d9bd8b35977e74fbf
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.


+xfrm maintainers

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9a24dafd2f9855d33cd3@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> netlink: 4 bytes leftover after parsing attributes in process
> `syz-executor0'.
> INFO: rcu_sched self-detected stall on CPU
> INFO: rcu_sched detected stalls on CPUs/tasks:
>         0-...!: (1 GPs behind) idle=c92/140000000000001/0
> softirq=414248/414250 fqs=23
>         (detected by 1, t=125002 jiffies, g=240513, c=240512, q=235)
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.15.0-rc5+ #177
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__preempt_count_add arch/x86/include/asm/preempt.h:76 [inline]
> RIP: 0010:delay_tsc+0x48/0x70 arch/x86/lib/delay.c:68
> RSP: 0018:ffff8801db206ff0 EFLAGS: 00000007
> RAX: 000001f123cf45ac RBX: ffffffff88460f20 RCX: 000001f123cf422e
> RDX: 000000000000037e RSI: 0000000000000000 RDI: 00000000000008fd
> RBP: ffff8801db206ff0 R08: 1ffff1003b640d57 R09: 000000000000000c
> R10: ffff8801db206f78 R11: 0000000000000060 R12: 0000000000002708
> R13: 0000000000000020 R14: fffffbfff108c229 R15: fffffbfff108c1ed
> FS:  0000000000000000(0000) GS:ffff8801db200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000201e0000 CR3: 0000000006422004 CR4: 00000000001606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  __delay arch/x86/lib/delay.c:161 [inline]
>  __const_udelay+0x5b/0x70 arch/x86/lib/delay.c:175
>  wait_for_xmitr+0x6f/0x1e0 drivers/tty/serial/8250/8250_port.c:2041
>  serial8250_console_putchar+0x1f/0x60
> drivers/tty/serial/8250/8250_port.c:3170
>  uart_console_write+0xac/0xe0 drivers/tty/serial/serial_core.c:1858
>  serial8250_console_write+0x64f/0xa40
> drivers/tty/serial/8250/8250_port.c:3236
>  univ8250_console_write+0x5f/0x70 drivers/tty/serial/8250/8250_core.c:590
>  call_console_drivers kernel/printk/printk.c:1574 [inline]
>  console_unlock+0x788/0xd80 kernel/printk/printk.c:2233
>  vprintk_emit+0x4ad/0x590 kernel/printk/printk.c:1757
>  vprintk_default+0x28/0x30 kernel/printk/printk.c:1796
>  vprintk_func+0x57/0xc0 kernel/printk/printk_safe.c:379
>  printk+0xaa/0xca kernel/printk/printk.c:1829
>  print_cpu_stall_info_begin kernel/rcu/tree_plugin.h:1657 [inline]
>  print_cpu_stall kernel/rcu/tree.c:1594 [inline]
>  check_cpu_stall.isra.61+0x845/0x15b0 kernel/rcu/tree.c:1676
>  __rcu_pending kernel/rcu/tree.c:3440 [inline]
>  rcu_pending kernel/rcu/tree.c:3502 [inline]
>  rcu_check_callbacks+0x256/0xd00 kernel/rcu/tree.c:2842
>  update_process_times+0x30/0x60 kernel/time/timer.c:1630
>  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1166
>  __run_hrtimer kernel/time/hrtimer.c:1211 [inline]
>  __hrtimer_run_queues+0x358/0xe20 kernel/time/hrtimer.c:1275
>  hrtimer_interrupt+0x1c2/0x5e0 kernel/time/hrtimer.c:1309
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:904
>  </IRQ>
> RIP: 0010:_decode_session6+0x555/0x1380 net/ipv6/xfrm6_policy.c:148
> RSP: 0018:ffff8801d9f3e590 EFLAGS: 00000a03 ORIG_RAX: ffffffffffffff11
> RAX: 1ffff1003a6418d0 RBX: ffff8801d320c5c0 RCX: ffff8801d320c684
> RDX: 0000000000000000 RSI: 000000000000fc89 RDI: ffff8801d320c644
> RBP: ffff8801d9f3e618 R08: ffffed0037a8a2a5 R09: ffffed0037a8a2a5
> R10: 000000000000000b R11: ffffed0037a8a2a4 R12: 000000000000fe61
> R13: ffff8801d9f3e8f0 R14: 000000000000fcb0 R15: dffffc0000000000
>  __xfrm_decode_session+0x68/0x110 net/xfrm/xfrm_policy.c:2358
>  __xfrm_policy_check+0x18c/0x2350 net/xfrm/xfrm_policy.c:2393
>  __xfrm_policy_check2 include/net/xfrm.h:1170 [inline]
>  xfrm_policy_check include/net/xfrm.h:1175 [inline]
>  xfrm6_policy_check include/net/xfrm.h:1185 [inline]
>  rawv6_rcv+0x8f6/0x1200 net/ipv6/raw.c:424
>  ipv6_raw_deliver net/ipv6/raw.c:224 [inline]
>  raw6_local_deliver+0x819/0xa80 net/ipv6/raw.c:240
>  ip6_input_finish+0x3c7/0x17a0 net/ipv6/ip6_input.c:246
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ip6_input+0xe9/0x560 net/ipv6/ip6_input.c:327
>  dst_input include/net/dst.h:449 [inline]
>  ip6_rcv_finish+0x1a9/0x7a0 net/ipv6/ip6_input.c:71
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ipv6_rcv+0xf37/0x1fa0 net/ipv6/ip6_input.c:208
>  __netif_receive_skb_core+0x1a41/0x3460 net/core/dev.c:4499
>  __netif_receive_skb+0x2c/0x1b0 net/core/dev.c:4564
>  process_backlog+0x203/0x740 net/core/dev.c:5244
>  napi_poll net/core/dev.c:5642 [inline]
>  net_rx_action+0x792/0x1910 net/core/dev.c:5708
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>  run_ksoftirqd+0x50/0x100 kernel/softirq.c:666
>  smpboot_thread_fn+0x450/0x7c0 kernel/smpboot.c:164
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:515
> Code: d1 48 09 c1 0f ae e8 0f 31 48 c1 e2 20 48 09 d0 48 89 c2 48 29 ca 48
> 39
> Lost 40 message(s)!
> rcu_sched kthread starved for 124900 jiffies! g240513 c240512 f0x0
> RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=1
> rcu_sched       I23456     8      2 0x80000000
> Call Trace:
>  context_switch kernel/sched/core.c:2799 [inline]
>  __schedule+0x8eb/0x2060 kernel/sched/core.c:3375
>  schedule+0xf5/0x430 kernel/sched/core.c:3434
>  schedule_timeout+0x118/0x230 kernel/time/timer.c:1795
>  rcu_gp_kthread+0x9e5/0x1930 kernel/rcu/tree.c:2314
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:515
>         0-...!: (1 GPs behind) idle=c92/140000000000001/0
> softirq=414248/414250 fqs=23
>          (t=126311 jiffies g=240513 c=240512 q=235)
> rcu_sched kthread starved for 126214 jiffies! g240513 c240512 f0x2
> RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=1
> rcu_sched       R  running task    23456     8      2 0x80000000
> Call Trace:
>  context_switch kernel/sched/core.c:2799 [inline]
>  __schedule+0x8eb/0x2060 kernel/sched/core.c:3375
>  schedule+0xf5/0x430 kernel/sched/core.c:3434
>  schedule_timeout+0x118/0x230 kernel/time/timer.c:1795
>  rcu_gp_kthread+0x9e5/0x1930 kernel/rcu/tree.c:2314
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:515
> NMI backtrace for cpu 0
> CPU: 0 PID: 7 Comm: ksoftirqd/0 Not tainted 4.15.0-rc5+ #177
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x122/0x180 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>  rcu_dump_cpu_stacks+0x186/0x1d9 kernel/rcu/tree.c:1459
>  print_cpu_stall kernel/rcu/tree.c:1608 [inline]
>  check_cpu_stall.isra.61+0xbb8/0x15b0 kernel/rcu/tree.c:1676
>  __rcu_pending kernel/rcu/tree.c:3440 [inline]
>  rcu_pending kernel/rcu/tree.c:3502 [inline]
>  rcu_check_callbacks+0x256/0xd00 kernel/rcu/tree.c:2842
>  update_process_times+0x30/0x60 kernel/time/timer.c:1630
>  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1166
>  __run_hrtimer kernel/time/hrtimer.c:1211 [inline]
>  __hrtimer_run_queues+0x358/0xe20 kernel/time/hrtimer.c:1275
>  hrtimer_interrupt+0x1c2/0x5e0 kernel/time/hrtimer.c:1309
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:904
>  </IRQ>
> RIP: 0010:_decode_session6+0x555/0x1380 net/ipv6/xfrm6_policy.c:148
> RSP: 0018:ffff8801d9f3e590 EFLAGS: 00000a03 ORIG_RAX: ffffffffffffff11
> RAX: 1ffff1003a6418d0 RBX: ffff8801d320c5c0 RCX: ffff8801d320c684
> RDX: 0000000000000000 RSI: 000000000000fc89 RDI: ffff8801d320c644
> RBP: ffff8801d9f3e618 R08: ffffed0037a8a2a5 R09: ffffed0037a8a2a5
> R10: 000000000000000b R11: ffffed0037a8a2a4 R12: 000000000000fe61
> R13: ffff8801d9f3e8f0 R14: 000000000000fcb0 R15: dffffc0000000000
>  __xfrm_decode_session+0x68/0x110 net/xfrm/xfrm_policy.c:2358
>  __xfrm_policy_check+0x18c/0x2350 net/xfrm/xfrm_policy.c:2393
>  __xfrm_policy_check2 include/net/xfrm.h:1170 [inline]
>  xfrm_policy_check include/net/xfrm.h:1175 [inline]
>  xfrm6_policy_check include/net/xfrm.h:1185 [inline]
>  rawv6_rcv+0x8f6/0x1200 net/ipv6/raw.c:424
>  ipv6_raw_deliver net/ipv6/raw.c:224 [inline]
>  raw6_local_deliver+0x819/0xa80 net/ipv6/raw.c:240
>  ip6_input_finish+0x3c7/0x17a0 net/ipv6/ip6_input.c:246
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ip6_input+0xe9/0x560 net/ipv6/ip6_input.c:327
>  dst_input include/net/dst.h:449 [inline]
>  ip6_rcv_finish+0x1a9/0x7a0 net/ipv6/ip6_input.c:71
>  NF_HOOK include/linux/netfilter.h:250 [inline]
>  ipv6_rcv+0xf37/0x1fa0 net/ipv6/ip6_input.c:208
>  __netif_receive_skb_core+0x1a41/0x3460 net/core/dev.c:4499
>  __netif_receive_skb+0x2c/0x1b0 net/core/dev.c:4564
>  process_backlog+0x203/0x740 net/core/dev.c:5244
>  napi_poll net/core/dev.c:5642 [inline]
>  net_rx_action+0x792/0x1910 net/core/dev.c:5708
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>  run_ksoftirqd+0x50/0x100 kernel/softirq.c:666
>  smpboot_thread_fn+0x450/0x7c0 kernel/smpboot.c:164
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:515
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.115
> msecs
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a113f6d56977f0b056505705a%40google.com.
> For more options, visit https://groups.google.com/d/optout.
