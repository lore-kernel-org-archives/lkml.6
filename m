Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518513578; cv=none;
        d=google.com; s=arc-20160816;
        b=X1abiPdIitDQLeKVmfmjujxwdgH+/Kt/WVshonF+LZIu0HlWZyHf3Ohui9YHqWjie0
         BHR69vyma6Sb/C5vuiuhEZNOYK+xJ7TjD2asUghM7zXYYxufkLC8Mhgr0ftd/1U30OwU
         eluJyWGxsWzpTVw0geYvt15VwFsCtAg4Re7N4VufOZJWCF2k5Nqb+ZfD1z7T7SVnZXVF
         QSjI846s4sr302xKPtP+MsrotduM+ly/m3UYsRQ1xOpLJVZUxJjQlpMg2QQJDlWj5993
         fVIy0AQ46b7hfoNi06xOo+WcGjcThB4vl6zi9CR6Bz7aqdju8p/mPLLbkMstX3wZ3m3G
         sdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=6BmJi3zOBe0O0Y2p8UHjpnb/gaxm0VQXobXBJ536dxI=;
        b=MnaQGMJiQF5EfypGCsIW2uW5qEeVsb+JJaSGi9hfSXn8xUjtuWztRVUdoywiL4yl6J
         iZ4tBpoUHcpjaX2+l0ZtBHpWzgLhydE9+E1veo5tOGu4HARuwbF+/aervsAIQBMgAWxO
         fVJ8+q//Kn3BjWh1YpnedEKMM+aTdpWW5El4zYklT5AoFNM0o9LFgDSd/F7NM6PacD5S
         9QMW58u0GyS2mJYDd9BkYVwKM0uhlt8lMi4cBDZl10XdxnkoJGAsjwJgAlTQq+VKlBMC
         z2jT7w3o9MEl0ddibgqPHNMf7iLB8Re7kyOvIpsQylISeg2GrsV9RI9IIh1a1wGhBKlz
         dIiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=bMpvWjWo;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=bMpvWjWo;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x226XjbAv4KNtTnpu4AyxNWWzF3owv2FIo+l5PX26yXYg1C9lblWgQrxBhrMPvyRkWq0FEOhMH0drQHb3ZB5Ls3g=
MIME-Version: 1.0
In-Reply-To: <CACT4Y+Z-iMWQccvthBAb2Ze4GjkVAm-B7m=b+KYg8AqEn4gw1Q@mail.gmail.com>
References: <001a1141ba9ea381f70565057687@google.com> <CACT4Y+Z-iMWQccvthBAb2Ze4GjkVAm-B7m=b+KYg8AqEn4gw1Q@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 13 Feb 2018 10:19:17 +0100
Message-ID: <CACT4Y+aHScQyOybzx22irqKE+B=xU79+zfgSnjCHZT6gqF89Hw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in xfrm_confirm_neigh
To: syzbot <syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com>
Cc: dzickus@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, npiggin@gmail.com,
	Philippe Ombredanne <pombredanne@nexb.com>, syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>, "the arch/x86 maintainers" <x86@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592209203961806699?=
X-GMAIL-MSGID: =?utf-8?q?1592276894395947443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 4:26 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Feb 12, 2018 at 4:23 PM, syzbot
> <syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot hit the following crash on net-next commit
>> 9515a2e082f91457db0ecff4b65371d0fb5d9aad (Thu Jan 25 03:37:38 2018 +0000)
>> net/ipv4: Allow send to local broadcast from a socket bound to a VRF
>>
>> So far this crash happened 6 times on net-next.
>> Unfortunately, I don't have any reproducer for this crash yet.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
>
>
> +xfrm maintainers

Here is a C repro:
https://gist.githubusercontent.com/dvyukov/92c67ba9afaaa960bcfbdc6ef549ac10/raw/786f9221c1d707c7f4a15effcb1d5997dd4f8638/gistfile1.txt
Somewhat messy, but it gives me:

[64360.028053] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [a.out:7891]
[64360.030043] Modules linked in:
[64360.030355] CPU: 0 PID: 7891 Comm: a.out Not tainted 4.15.0+ #96
[64360.031334] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[64360.033632] RIP: 0010:__sanitizer_cov_trace_pc+0x20/0x50
[64360.035114] RSP: 0018:ffff88006b96f6e0 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffff11
[64360.037238] RAX: ffff8800636ce040 RBX: ffff880067fadb00 RCX: ffffffff84d147a6
[64360.039238] RDX: 0000000000000000 RSI: ffffffff84d147b0 RDI: 0000000000000001
[64360.041357] RBP: ffff88006b96f6e0 R08: ffff8800636ce040 R09: ffffed000d1008c9
[64360.043364] R10: 0000000000000000 R11: 0000000000000000 R12: ffffed000cff5b7b
[64360.045366] R13: ffff880067fadbdc R14: ffff88006586ae00 R15: 0000000000000000
[64360.047367] FS:  00007f2a5bab5700(0000) GS:ffff88006ca00000(0000)
knlGS:0000000000000000
[64360.049486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[64360.051095] CR2: 0000000020cf9000 CR3: 00000000626a7001 CR4: 00000000001606f0
[64360.053065] Call Trace:
[64360.053822]  xfrm_confirm_neigh+0xd0/0x2c0
[64360.056166]  raw_sendmsg+0x1f1e/0x2640
[64360.068396]  inet_sendmsg+0x145/0x490
[64360.074198]  sock_sendmsg+0xd2/0x120
[64360.075094]  SYSC_sendto+0x3de/0x640
[64360.085269]  SyS_sendto+0x40/0x50



>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+7d03c810e50aaedef98a@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> INFO: rcu_sched self-detected stall on CPU
>>         1-...!: (124998 ticks this GP) idle=376/140000000000001/0
>> softirq=506054/506054 fqs=19
>>          (t=125000 jiffies g=289415 c=289414 q=312)
>> rcu_sched kthread starved for 124920 jiffies! g289415 c289414 f0x0
>> RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
>> rcu_sched       R  running task    23456     8      2 0x80000000
>> Call Trace:
>>  context_switch kernel/sched/core.c:2799 [inline]
>>  __schedule+0x8eb/0x2060 kernel/sched/core.c:3375
>>  schedule+0xf5/0x430 kernel/sched/core.c:3434
>>  schedule_timeout+0x118/0x230 kernel/time/timer.c:1793
>>  rcu_gp_kthread+0x9e5/0x1930 kernel/rcu/tree.c:2314
>>  kthread+0x33c/0x400 kernel/kthread.c:238
>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:541
>> NMI backtrace for cpu 1
>> CPU: 1 PID: 15893 Comm: syz-executor0 Not tainted 4.15.0-rc9+ #210
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  <IRQ>
>>  __dump_stack lib/dump_stack.c:17 [inline]
>>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>>  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>>  nmi_trigger_cpumask_backtrace+0x122/0x180 lib/nmi_backtrace.c:62
>>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>>  rcu_dump_cpu_stacks+0x186/0x1d9 kernel/rcu/tree.c:1459
>>  print_cpu_stall kernel/rcu/tree.c:1608 [inline]
>>  check_cpu_stall.isra.61+0xbb8/0x15b0 kernel/rcu/tree.c:1676
>>  __rcu_pending kernel/rcu/tree.c:3440 [inline]
>>  rcu_pending kernel/rcu/tree.c:3502 [inline]
>>  rcu_check_callbacks+0x256/0xd00 kernel/rcu/tree.c:2842
>>  update_process_times+0x30/0x60 kernel/time/timer.c:1628
>>  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>>  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1194
>>  __run_hrtimer kernel/time/hrtimer.c:1211 [inline]
>>  __hrtimer_run_queues+0x358/0xe20 kernel/time/hrtimer.c:1275
>>  hrtimer_interrupt+0x1c2/0x5e0 kernel/time/hrtimer.c:1309
>>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>>  smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
>>  apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:937
>>  </IRQ>
>> RIP: 0010:__read_once_size include/linux/compiler.h:183 [inline]
>> RIP: 0010:__sanitizer_cov_trace_pc+0x3b/0x50 kernel/kcov.c:106
>> RSP: 0018:ffff8801a6867820 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff11
>> RAX: 0000000000010000 RBX: ffff8801caf7d200 RCX: ffffffff84acc87d
>> RDX: 000000000000ffff RSI: ffffc90002aa6000 RDI: ffff8801c54c4f50
>> RBP: ffff8801a6867820 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801c54c4e00
>> R13: dffffc0000000000 R14: ffffed00395efa5f R15: ffff8801caf7d2fc
>>  xfrm_get_dst_nexthop net/xfrm/xfrm_policy.c:2732 [inline]
>>  xfrm_confirm_neigh+0xad/0x270 net/xfrm/xfrm_policy.c:2759
>>  dst_confirm_neigh include/net/dst.h:419 [inline]
>>  raw_sendmsg+0xece/0x23b0 net/ipv4/raw.c:702
>>  inet_sendmsg+0x11f/0x5e0 net/ipv4/af_inet.c:764
>>  sock_sendmsg_nosec net/socket.c:630 [inline]
>>  sock_sendmsg+0xca/0x110 net/socket.c:640
>>  SYSC_sendto+0x361/0x5c0 net/socket.c:1747
>>  SyS_sendto+0x40/0x50 net/socket.c:1715
>>  entry_SYSCALL_64_fastpath+0x29/0xa0
>> RIP: 0033:0x452f19
>> RSP: 002b:00007f00a389ec58 EFLAGS: 00000212 ORIG_RAX: 000000000000002c
>> RAX: ffffffffffffffda RBX: 000000000071bf58 RCX: 0000000000452f19
>> RDX: 000000000000001e RSI: 0000000020098000 RDI: 0000000000000013
>> RBP: 0000000000000510 R08: 0000000020cf9000 R09: 0000000000000010
>> R10: fffffffffffffffe R11: 0000000000000212 R12: 00000000006f6a20
>> R13: 00000000ffffffff R14: 00007f00a389f6d4 R15: 0000000000000001
>>
>>
>> ---
>> This bug is generated by a dumb bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for details.
>> Direct all questions to syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report.
>> If you forgot to add the Reported-by tag, once the fix for this bug is
>> merged
>> into any tree, please reply to this email with:
>> #syz fix: exact-commit-title
>> To mark this as a duplicate of another syzbot report, please reply with:
>> #syz dup: exact-subject-of-another-report
>> If it's a one-off invalid bug report, please reply with:
>> #syz invalid
>> Note: if the crash happens again, it will cause creation of a new bug
>> report.
>> Note: all commands must start from beginning of the line in the email body.
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/syzkaller-bugs/001a1141ba9ea381f70565057687%40google.com.
>> For more options, visit https://groups.google.com/d/optout.
