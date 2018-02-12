Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518449193; cv=none;
        d=google.com; s=arc-20160816;
        b=Geed/lFK7eGzFBNC6xzb5qCJNEIbQpWeKr8MYzenVoBPPsbk2G8vFSblIKYGd5+sHn
         k1r/rJceX84/PhWafZGfKU0oGfeIWUVdNoFo5e+oZGmVZDgRaIV719ATot2/zGZi4Bul
         QXoBnL5+q0vYxvnjsIPUo/0vVm555bc0XheqChFxBAvdq87dsWPIpzP15XP15mNKI6XF
         SWxxSt/grtbhFcAVtecJbfUDR6pO3BpJXtKp9lbuSAYdGVnwYvPaOWWnNvXzIioyIU1u
         rwbljnXvidmbV3sXjGL2GkxFiDNktRWe7l6JhAZNhB7YfYLvnnlTpeEjgEcSZafsWzZ8
         BFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=BlBSKj5krUwPVvaP2QNA7w7otdhP3dkHIuBxBtC1FNA=;
        b=xyGOucrtTksfcid6uGS5rBT/6Ew1vKobNVpbMpToI45aY4aIiWAbsY60gf8iluCCd5
         srdSK7mH4wNva7vmJm0KFCe67EmCDdGuPOxmBGicYmnQFtSkzNijuiX03dmR9mA3boQB
         KZaisEvHAsRY2wDOmuLq4NefpVFDJEz+jTLhaq0vdk3ABydo1OXY7L+uCoW0PS7kF8L0
         ANrSFOdjQMOIRVyozBROmuJYNZIG/amttLnTU2nAjMu/kRgObe8yKYarjrT81J2VDjO/
         ulRG+iWxwE3gZrjfsGSp74WPmxx8GzAk2qu4eKdmCvznp2PBMriFzF4ByNmpcDbCzutd
         wGKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=snPg3p8H;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=snPg3p8H;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x226i6S8lnyqi7mkQ5K8OL7SHIu1/dO22wbdUs5mpxcWVGA/wNqYuB9ydc9ur5R0Cw06LlZUBJDZyMc7vvGwPV6U=
MIME-Version: 1.0
In-Reply-To: <001a1143d40c20464f056505745b@google.com>
References: <001a1143d40c20464f056505745b@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2018 16:26:12 +0100
Message-ID: <CACT4Y+ZeW1yH9HHCG1wMPWDUA0Es5VmzKDuYgyYAv+Jb1joiPQ@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in _decode_session6
To: syzbot <syzbot+24d1c14022d23c04a83e@syzkaller.appspotmail.com>
Cc: babu.moger@oracle.com, dzickus@redhat.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, npiggin@gmail.com,
	syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
	"the arch/x86 maintainers" <x86@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>,
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592209159602451431?=
X-GMAIL-MSGID: =?utf-8?q?1592209380978289021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 4:23 PM, syzbot
<syzbot+24d1c14022d23c04a83e@syzkaller.appspotmail.com> wrote:
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

#syz dup: INFO: rcu detected stall in __xfrm_decode_session


> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+24d1c14022d23c04a83e@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> INFO: rcu_sched self-detected stall on CPU
>         1-....: (1 GPs behind) idle=41e/140000000000001/0
> softirq=91762/91764 fqs=31218
>          (t=125000 jiffies g=53093 c=53092 q=1018)
> NMI backtrace for cpu 1
> CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 4.15.0-rc5+ #177
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
> RIP: 0010:__sanitizer_cov_trace_pc+0x1e/0x50 kernel/kcov.c:97
> RSP: 0018:ffff8801d9fae2f8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff11
> RAX: ffff8801d9f9e440 RBX: ffff8801c3591340 RCX: ffffffff84c2553b
> RDX: 0000000000000100 RSI: ffff8801b06a0640 RDI: 0000000000000000
> RBP: ffff8801d9fae2f8 R08: ffffed00360d6059 R09: ffffed00360d6059
> R10: 000000000000000b R11: ffffed00360d6058 R12: ffff8801b06a0658
> R13: ffff8801d9fae498 R14: 00000000000025c0 R15: dffffc0000000000
>  _decode_session6+0x9eb/0x1380 net/ipv6/xfrm6_policy.c:160
>  __xfrm_decode_session+0x68/0x110 net/xfrm/xfrm_policy.c:2358
>  xfrm_decode_session_reverse include/net/xfrm.h:1213 [inline]
>  icmpv6_route_lookup+0x356/0x660 net/ipv6/icmp.c:372
>  icmp6_send+0x17cd/0x28c0 net/ipv6/icmp.c:551
>  icmpv6_param_prob+0x2c/0x40 net/ipv6/icmp.c:598
>  ipv6_frag_rcv+0x342b/0x5320 net/ipv6/reassembly.c:583
>  ip6_input_finish+0x37e/0x17a0 net/ipv6/ip6_input.c:284
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
> https://groups.google.com/d/msgid/syzkaller-bugs/001a1143d40c20464f056505745b%40google.com.
> For more options, visit https://groups.google.com/d/optout.
