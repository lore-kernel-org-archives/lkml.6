Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522998811; cv=none;
        d=google.com; s=arc-20160816;
        b=vyPWxx1VZhanBr68vrQLjUFgVXLUTVaya4Cbi70brl/6YLMvtBxUd11lXdMmYRPblD
         ZyCq/ycl3FwXlc+8CePwdVXJ75ObhHb7K8SCr3cBUySy6VjT+2LMSjB/3tmmD0IqopbK
         ispnzdHwXiRyV68UPtnjuHtK8ELAAbOeGyRdmvWMQd35KN0+w6GpQuU7At72DwC8wMHO
         sj1kch4ChY/PC1Eu7B+ZvKSb8IF4tKGn0pKVc9yQn/3nD8K5r4AuVby+mTj74KVuIgup
         cFlIcrG03j3dyaHo3f0KVK4GJ+lIsqV26Tr4LGVSJOtN6cV+0vCU/h/afJs6GWTfX/yC
         sQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=aAWu1HyxihtuSX88ZTNtVazj4izdKOoxYJj/6jD/j54=;
        b=tsH5+r48s89blv3QXSCGyGBOJh1EAyXE4eMu2vj/vCH97D6AivSKufDiztvkOXDCWQ
         q6yOILM3TKCY0UmXN6xIT2Nm6ACVA1amZAvD/0PpwZPtIn43jkDpY31qoh2FzYSvKJlF
         9Atpg8/Jy/tOgIEZ79eSXzHV6XbT57LlTCoUaih3OXZrWDDpo6sM3LhMk18jIJP7SQU7
         093f1EoqKP/KxTRI1C8QYfsIl0cmiNo4DMEhR8Y4gRaLAaJ58c2GhgMzFdoHSbRV5DI8
         TlIDXub6RqSQn2cmc+4dpdzG20rn1ztbdhlk82MhfVrCfwpspOmnylAdA0ru76andlFW
         Pwvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Zya/AbGa;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Zya/AbGa;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+oONlirAgDyovhW/bkMQOY32N4Z5k+PrKve5RDY+VkyyMUYRoBjtVd2akE/9ys56VjjdflVIUSDRgr8ODKMng=
MIME-Version: 1.0
In-Reply-To: <883d24f7d4ccc52e19056928c5be@google.com>
References: <883d24f7d4ccc52e19056928c5be@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Apr 2018 09:13:10 +0200
Message-ID: <CACT4Y+bBRpiNpmwwJ3s-T2Vo1wXD3mOeGtQKzXS_xeGUZZUYCw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in n_tty_receive_char_special
To: syzbot <syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596979907220664835?=
X-GMAIL-MSGID: =?utf-8?q?1596980000973682122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 6, 2018 at 9:12 AM, syzbot
<syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 (Sat Mar 31 01:52:36 2018 +0000)
> kernel.h: Retain constant expression output for max()/min()
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=18df353d7540aa6b5467
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5836679554269184
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-1647968177339044852
> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+18df353d7540aa6b5467@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.


This looks somewhat similar to "INFO: rcu detected stall in __process_echoes":
https://syzkaller.appspot.com/bug?id=17f23b094cd80df750e5b0f8982c521ee6bcbf40
But I am not sure because stall stacks are somewhat different.


> INFO: rcu_sched detected stalls on CPUs/tasks:
>         (detected by 1, t=125007 jiffies, g=42488, c=42487, q=11)
> All QSes seen, last rcu_sched kthread activity 125014
> (4295022441-4294897427), jiffies_till_next_fqs=3, root ->qsmask 0x0
> kworker/u4:5    R  running task    15272  8806      2 0x80000008
> Workqueue: events_unbound flush_to_ldisc
> Call Trace:
>  <IRQ>
>  sched_show_task.cold.87+0x27a/0x301 kernel/sched/core.c:5325
>  print_other_cpu_stall.cold.79+0x92f/0x9d2 kernel/rcu/tree.c:1481
>  check_cpu_stall.isra.61+0x706/0xf50 kernel/rcu/tree.c:1599
>  __rcu_pending kernel/rcu/tree.c:3356 [inline]
>  rcu_pending kernel/rcu/tree.c:3401 [inline]
>  rcu_check_callbacks+0x21b/0xad0 kernel/rcu/tree.c:2763
>  update_process_times+0x2d/0x70 kernel/time/timer.c:1636
>  tick_sched_handle+0xa0/0x180 kernel/time/tick-sched.c:171
>  tick_sched_timer+0x42/0x130 kernel/time/tick-sched.c:1179
>  __run_hrtimer kernel/time/hrtimer.c:1337 [inline]
>  __hrtimer_run_queues+0x3e3/0x10a0 kernel/time/hrtimer.c:1399
>  hrtimer_interrupt+0x286/0x650 kernel/time/hrtimer.c:1457
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x15d/0x710 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:862
>  </IRQ>
> RIP: 0010:echo_char+0xae/0x2e0 drivers/tty/n_tty.c:915
> RSP: 0018:ffff8801d33e71e0 EFLAGS: 00000a07 ORIG_RAX: ffffffffffffff13
> RAX: dffffc0000000000 RBX: ffffc90013158000 RCX: ffffffff8375b1b7
> RDX: 1ffff1003ad87636 RSI: ffffffff8375b1c6 RDI: ffff8801d6c3b1b4
> RBP: ffff8801d33e7210 R08: ffff8801cf482540 R09: fffff5200262b460
> R10: fffff5200262b460 R11: ffffc9001315a307 R12: 00000000000000cb
> R13: ffff8801d6c3ae00 R14: 00000000c240f0bb R15: 00000000000000bb
>  n_tty_receive_char_special+0x13b3/0x31c0 drivers/tty/n_tty.c:1306
>  n_tty_receive_buf_fast drivers/tty/n_tty.c:1577 [inline]
>  __receive_buf drivers/tty/n_tty.c:1611 [inline]
>  n_tty_receive_buf_common+0x20ca/0x2c50 drivers/tty/n_tty.c:1709
>  n_tty_receive_buf2+0x33/0x40 drivers/tty/n_tty.c:1744
>  tty_ldisc_receive_buf+0xb0/0x190 drivers/tty/tty_buffer.c:456
>  tty_port_default_receive_buf+0x110/0x170 drivers/tty/tty_port.c:38
>  receive_buf drivers/tty/tty_buffer.c:475 [inline]
>  flush_to_ldisc+0x3e9/0x560 drivers/tty/tty_buffer.c:524
>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>  kthread+0x345/0x410 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
> rcu_sched kthread starved for 125626 jiffies! g42488 c42487 f0x2
> RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
> RCU grace-period kthread stack dump:
> rcu_sched       R  running task    23592     9      2 0x80000000
> Call Trace:
>  context_switch kernel/sched/core.c:2848 [inline]
>  __schedule+0x807/0x1e40 kernel/sched/core.c:3490
>  schedule+0xef/0x430 kernel/sched/core.c:3549
>  schedule_timeout+0x138/0x240 kernel/time/timer.c:1801
>  rcu_gp_kthread+0x6b5/0x1940 kernel/rcu/tree.c:2231
>  kthread+0x345/0x410 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:411
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
> https://groups.google.com/d/msgid/syzkaller-bugs/883d24f7d4ccc52e19056928c5be%40google.com.
> For more options, visit https://groups.google.com/d/optout.
