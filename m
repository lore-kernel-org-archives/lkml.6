Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523102317; cv=none;
        d=google.com; s=arc-20160816;
        b=V1Szkq2ufI7E4EtEatW8JA50A2z1eccGLV7+WQ5vczBNspdfkhM/LEFnYneGqiScSy
         Z/OVBbiI/SRKnapibo0AHidbtfoLXPFaf1nNBX7olt/9SJ3ysEzvzwkycyA51Qjb6uFj
         JgXtCs8Wa8n1W6upIx4Ds6IqZVEO3KMzG6hJpnJS/2mqD0Q04OI45rxl3OUirTwdb5CO
         dO4/Qx9Vvvk7D5nGWMXyOzLhztIcpYNSajgi7r+I//C1Ap6/tb6p/Z5VIG6LawX1nlVl
         8iGBguKCG7Q+3X3YDatVs72dTi+G7AUEp2gj7AHuD3jbnc5WFq3B6VufiQ0TtLqYK8j7
         /55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Ar9LGxgw8IiTOtK1nYlsTOXSfNM6NNuSDBo0I24wYXE=;
        b=UBA9WU5duaAdkVydi8Mworn6ZKvNoYRYwdSkPaLbOBLQt7nIH15O+lRliVKbVVZOtT
         6j6K9iHdlvyxMSucKOxf4xfM64FEUJRt+uV2MMi6+b22Nc8HPaKzqCZJDuunb3aVWLLK
         +SmqZm1DZU3jzY8lRnm0P0RY9o5TKA88Ofy6eXYNtQG+1wCaZ8A6m8ltTRthD+jPHK0x
         HLR9rolKi3VGeGq5taxpaoXIlM54rkZ8Cwl9iiaJJGUqRX8KaFXvpP8ePkIChtcAj7hJ
         aoU50YJ6iUQf6977pbCwsBkWOmmKKXIksZ7qgLn+jYzyw89Q/N8ECM5lZkkuIOgxAx0G
         gHfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Glyv9HHv;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Glyv9HHv;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/rruOe8ObT509GvuV2KKKQpULZTOgA1J2IMTDsDyMnj7TGLNr1hdiCfyGka+JIQfjRphHKOYJcTB4fbk++91Q=
MIME-Version: 1.0
In-Reply-To: <f4f5e80803d011926505692cda06@google.com>
References: <f4f5e80803d011926505692cda06@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sat, 7 Apr 2018 13:58:16 +0200
Message-ID: <CACT4Y+Zxv0365R_wWkUa_E4_Qe8rUg5PDPJPA6OUfnKiw+uCRg@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in snd_pcm_oss_write2
To: syzbot <syzbot+adc909755650e074e501@syzkaller.appspotmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596998278903166639?=
X-GMAIL-MSGID: =?utf-8?q?1597088536180927304?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

#syz dup: INFO: rcu detected stall in io_playback_transfer

On Fri, Apr 6, 2018 at 2:04 PM, syzbot
<syzbot+adc909755650e074e501@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> e02d37bf55a9a36f22427fd6dd733fe104d817b6 (Thu Apr 5 17:42:07 2018 +0000)
> Merge tag 'sound-4.17-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=adc909755650e074e501
>
> So far this crash happened 2 times on upstream.
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=4567980574769152
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=-4805825610197092128
> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+adc909755650e074e501@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
>         reason=80000021 qualification=0000000000000000
> IDTVectoring: info=00000000 errcode=00000000
> TSC Offset = 0xfffffd92e6bf78df
> TPR Threshold = 0x00
> EPT pointer = 0x00000001ab93b01e
> INFO: rcu_sched self-detected stall on CPU
>         0-....: (124999 ticks this GP) idle=81a/1/4611686018427387906
> softirq=379270/379270 fqs=31240
>          (t=125000 jiffies g=195733 c=195732 q=734)
> NMI backtrace for cpu 0
> CPU: 0 PID: 9961 Comm: syz-executor2 Not tainted 4.16.0+ #2
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x1b9/0x29f lib/dump_stack.c:53
>  nmi_cpu_backtrace.cold.4+0x19/0xce lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x151/0x192 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_single_cpu_backtrace include/linux/nmi.h:156 [inline]
>  rcu_dump_cpu_stacks+0x175/0x1c2 kernel/rcu/tree.c:1376
>  print_cpu_stall kernel/rcu/tree.c:1525 [inline]
>  check_cpu_stall.isra.61.cold.80+0x36c/0x59a kernel/rcu/tree.c:1593
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
> RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x0/0x20 kernel/kcov.c:183
> RSP: 0018:ffff88018e3fee20 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff85a132bd
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88018e3fee70 R08: ffff88018e044100 R09: 0000000000000006
> R10: ffff88018e044100 R11: 0000000000000000 R12: 0000000000000001
> R13: ffff8801ceaa2d80 R14: ffff88019269ab00 R15: ffffffffffffffe0
>  snd_pcm_oss_write2+0x34c/0x460 sound/core/oss/pcm_oss.c:1373
>  snd_pcm_oss_sync1+0x332/0x5a0 sound/core/oss/pcm_oss.c:1606
>  snd_pcm_oss_sync.isra.29+0x790/0x980 sound/core/oss/pcm_oss.c:1682
>  snd_pcm_oss_release+0x214/0x290 sound/core/oss/pcm_oss.c:2559
>  __fput+0x34d/0x890 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x1e4/0x290 kernel/task_work.c:113
>  exit_task_work include/linux/task_work.h:22 [inline]
>  do_exit+0x1aee/0x2730 kernel/exit.c:865
>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>  get_signal+0x886/0x1960 kernel/signal.c:2469
>  do_signal+0x90/0x2020 arch/x86/kernel/signal.c:810
>  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x792/0x9d0 arch/x86/entry/common.c:292
>  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> RIP: 0033:0x4552d9
> RSP: 002b:00007f0bfca8cce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000072bf80 RCX: 00000000004552d9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bf80
> RBP: 000000000072bf80 R08: 0000000000000000 R09: 000000000072bf58
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000a3e81f R14: 00007f0bfca8d9c0 R15: 0000000000000001
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
