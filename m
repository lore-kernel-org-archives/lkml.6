Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522221134; cv=none;
        d=google.com; s=arc-20160816;
        b=0ABEz2f1p4DwU5K0zBo2RifdzUeyUkKTGYJafBz0TS6WLWKrZQovcb80H0DL0KG1M3
         GnWVWa4IWY04hgxNe1Fjm/5Yj+iI/BHE/NEc811xRno9OBOFeHXcYCptHZ+Z+9XAoulO
         9O02rEgNjJ61xb6oJNh51xJG/+gVLxHlJG2KCMGbNxqx7z6pqvani/IlRsgpgbjR22Xi
         B7jIFpA+E8Nra7wQ6E16vC66+wCA39kq2J9nmUXaclvPaPtS3vjszV5Cy79vlk2hgPzu
         FAGg91bXLq9AETdU4un6ggo/b1SK27u34aPAec9g+AedqkxP+xfx+uB31LBWJ5w4Meir
         YQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=s/B64O5gRfKEpmsA4r5VyctoD5LcibXWUdfroV8beoI=;
        b=B2XHpPkOv+8TkUTWLbxj80E8NBEQfODw/xe2SWs/fRtMZIq3IvbRYlAf47Cy3W90Uc
         zLVHFJ3sm52F6BTF0TP8Ox5VGjihZaKAtvR+PDmbZ9gct+PgddrlADAVxzrpKsSFXHi2
         KVAUofmlx8UkHGMz2bJk0MC/u2wHUGTyAc/N9cJXO2tF6sFlD6BcqJGkknD37J4hZPky
         wPO4udn73dIAyTx5fgy+mGAzYN+DbmTA2Pz9oPnBbgLhypgeisBwPatVUolGyRQtHFoA
         MfIfJmOKtiYg2HtiePlZvfzEMIT1gSWh0P+Je1Vbf5R0QYEYB95ndgnM8AVdGs0IjRQg
         36/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mpPgzNQZ;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mpPgzNQZ;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+6m6roVmHkArKwTtvrEqq3w7zcqGF85TyxtBs3OCmVS6ZRgRhFG66GYhXlLfQNlMCFjzQuGQSLDhHNfQCdFlA=
MIME-Version: 1.0
In-Reply-To: <00000000000061b9c3056873b7c3@google.com>
References: <00000000000061b9c3056873b7c3@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 28 Mar 2018 09:11:53 +0200
Message-ID: <CACT4Y+ZVoOMEVFTXaWNvEa8T6ayikj-NoAiQwEEfTevj1wUB-A@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in commit_echoes
To: syzbot <syzbot+a0366f667e2cac7c0bbf@syzkaller.appspotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596164503018865475?=
X-GMAIL-MSGID: =?utf-8?q?1596164548729530101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

#syz dup: INFO: rcu detected stall in __process_echoes

On Wed, Mar 28, 2018 at 9:11 AM, syzbot
<syzbot+a0366f667e2cac7c0bbf@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 3eb2ce825ea1ad89d20f7a3b5780df850e4be274 (Sun Mar 25 22:44:30 2018 +0000)
> Linux 4.16-rc7
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=a0366f667e2cac7c0bbf
>
> So far this crash happened 3 times on upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=6443860423081984
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-8440362230543204781
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a0366f667e2cac7c0bbf@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> INFO: rcu_sched self-detected stall on CPU
>         0-....: (124999 ticks this GP) idle=692/1/4611686018427387906
> softirq=21889/21889 fqs=31226
>          (t=125000 jiffies g=11261 c=11260 q=580)
> NMI backtrace for cpu 0
> CPU: 0 PID: 215 Comm: kworker/u4:4 Not tainted 4.16.0-rc7+ #3
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events_unbound flush_to_ldisc
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
>  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x123/0x180 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>  rcu_dump_cpu_stacks+0x186/0x1de kernel/rcu/tree.c:1375
>  print_cpu_stall kernel/rcu/tree.c:1524 [inline]
>  check_cpu_stall.isra.61+0xbb8/0x15b0 kernel/rcu/tree.c:1592
>  __rcu_pending kernel/rcu/tree.c:3361 [inline]
>  rcu_pending kernel/rcu/tree.c:3423 [inline]
>  rcu_check_callbacks+0x238/0xd20 kernel/rcu/tree.c:2763
>  update_process_times+0x30/0x60 kernel/time/timer.c:1636
>  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1194
>  __run_hrtimer kernel/time/hrtimer.c:1349 [inline]
>  __hrtimer_run_queues+0x39c/0xec0 kernel/time/hrtimer.c:1411
>  hrtimer_interrupt+0x2a5/0x6f0 kernel/time/hrtimer.c:1469
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:857
>  </IRQ>
> RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50
> RSP: 0018:ffff8801d93e7070 EFLAGS: 00000217 ORIG_RAX: ffffffffffffff12
> RAX: 0000000000000000 RBX: ffffc90007f8a000 RCX: ffffffff82f38392
> RDX: 0000000000000007 RSI: 1ffff1003b278d6c RDI: ffffc90007f8bb1f
> RBP: ffff8801d93e70e0 R08: 1ffff1003b27cdb5 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000577d218be
> R13: dffffc0000000000 R14: 00000000000008bf R15: 0000000000001ed0
>  commit_echoes+0x147/0x1b0 drivers/tty/n_tty.c:764
>  n_tty_receive_char_fast drivers/tty/n_tty.c:1416 [inline]
>  n_tty_receive_buf_fast drivers/tty/n_tty.c:1576 [inline]
>  __receive_buf drivers/tty/n_tty.c:1611 [inline]
>  n_tty_receive_buf_common+0x1156/0x2520 drivers/tty/n_tty.c:1709
>  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
>  tty_ldisc_receive_buf+0xa7/0x180 drivers/tty/tty_buffer.c:456
>  tty_port_default_receive_buf+0x106/0x160 drivers/tty/tty_port.c:38
>  receive_buf drivers/tty/tty_buffer.c:475 [inline]
>  flush_to_ldisc+0x3c4/0x590 drivers/tty/tty_buffer.c:524
>  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
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
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000061b9c3056873b7c3%40google.com.
> For more options, visit https://groups.google.com/d/optout.
