Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071678-1518620334-2-5745349043168266513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  SORTED_RECIPS 2.499, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518620334; b=nQnOaBFTgq9STkd+q9kZPr+lx6QEiO8rBGcfRviycUmO6sW
    Cf1VgrO/inaJZ51nDlQiS/EK5sEqg7hPO+IXGrKCgTdICH5LWA361Q/xyS02dY8V
    Udt+BD8yCFZF20rigo2JhatQmRLFLSvBeWGOtgO1drYpxsv8/0Kd9BnEfmrM9Ro/
    NZC29xd1ve6qCNmiZ3D7fXceBtTAFF5cnNFtP8WRA6DBkMGelFuRwevQJLIyLcmJ
    YOqk+u5XQiMmd7SmC8fzmPelXJTQ7Mpoy2GFFA8/apO6zuTCukfStA5vHHbdOQeW
    +rxAmUV8I62b9ByazUaO3UIOjZ0Z6HxF3kkJSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518620334; bh=Xyn/SfovEYmg4BLCdhrv9wWdzjsJy4KRHCL6VP
    Z3FxQ=; b=HI9jvhc8iKVp5mrCl5dcoKs9eSAkPw8abmuZiHFqGYEIId34egtpag
    M2SNyuBbCq4qgue56VBpaY6eCbfc/V7uaRrjJN5zu22rF3Mu5wNPZq6bhcnlLJHp
    LALlsGPsPw87AH9Pw3kUJ6nuuTcVMUtQgTtjJuhvDvReoBdnqlXfpCRtbfmdgJZV
    MOLpQAK4mKaJu/eATQEHLwFzs5DrwPyUVoTG/wninS8/9ap3HkvF6xhUKVQclx8Y
    YCUrFprUTaW+qs27kxZ7qdjB8YVaufM7fhh+lFhY8WAtYmXEb8zGHujmAqcTvUtw
    aAuxkrT+s5hjBHBtQOv1EcsGzr7SdpPA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=hyonxhOn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BWzS30bw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=hyonxhOn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BWzS30bw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030751AbeBNO6x (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 09:58:53 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33594 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030382AbeBNO6v (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Feb 2018 09:58:51 -0500
X-Google-Smtp-Source: AH8x227s1OljhQZmfY7BjWU0v1xfnqE8VTKphblo++xnARpI+P9Y6pTRnGq8sdwZPi1etYq4RkLqm/vM/j0R9eJhbFw=
MIME-Version: 1.0
In-Reply-To: <089e082bdf106667a50560f672cc@google.com>
References: <001a1148e11441b3e70560c843f1@google.com> <089e082bdf106667a50560f672cc@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 14 Feb 2018 15:58:25 +0100
Message-ID: <CACT4Y+b9gKjRBxG28b-xLAoH_kWEtzE8Wqxsm+r74KBtY6afJg@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in tty_ioctl
To: syzbot
        <bot+4e86372b8cb60e44613ff63e5dd1dcaffa7a4d29@syzkaller.appspotmail.com>
Cc: Alexey.Brodkin@synopsys.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        babu.moger@oracle.com, david@lechnology.com, dzickus@redhat.com,
        eric@anholt.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, jan.kiszka@siemens.com,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, npiggin@gmail.com,
        phil@raspberrypi.org, rafael.gago@gmail.com,
        sean.wang@mediatek.com, syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Dec 23, 2017 at 12:48 AM, syzbot
<bot+4e86372b8cb60e44613ff63e5dd1dcaffa7a4d29@syzkaller.appspotmail.com>
wrote:
> syzkaller has found reproducer for the following crash on
> 37759fa6d0fa9e4d6036d19ac12f555bfc0aeafd
> git://git.cmpxchg.org/linux-mmots.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers


I think this is fixed with:

#syz fix: n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD)



> INFO: rcu_sched self-detected stall on CPU
>         1-...!: (124998 ticks this GP) idle=1aa/1/4611686018427387906
> softirq=6401/6401 fqs=178
>          (t=125000 jiffies g=3233 c=3232 q=384)
> rcu_sched kthread starved for 124263 jiffies! g3233 c3232 f0x0
> RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
> rcu_sched       R  running task    23272     8      2 0x80000000
> Call Trace:
>  context_switch kernel/sched/core.c:2800 [inline]
>  __schedule+0x8eb/0x2060 kernel/sched/core.c:3376
>  schedule+0xf5/0x430 kernel/sched/core.c:3435
>  schedule_timeout+0x13e/0x6f0 kernel/time/timer.c:1818
>  rcu_gp_kthread+0x9dd/0x18e0 kernel/rcu/tree.c:2231
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:524
> NMI backtrace for cpu 1
> CPU: 1 PID: 3169 Comm: syzkaller626814 Not tainted 4.15.0-rc4-mm1+ #49
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
>  rcu_dump_cpu_stacks+0x186/0x1de kernel/rcu/tree.c:1375
>  print_cpu_stall kernel/rcu/tree.c:1524 [inline]
>  check_cpu_stall.isra.62+0xbb8/0x15b0 kernel/rcu/tree.c:1592
>  __rcu_pending kernel/rcu/tree.c:3362 [inline]
>  rcu_pending kernel/rcu/tree.c:3424 [inline]
>  rcu_check_callbacks+0x238/0xd20 kernel/rcu/tree.c:2764
>  update_process_times+0x30/0x60 kernel/time/timer.c:1630
>  tick_sched_handle+0x85/0x160 kernel/time/tick-sched.c:162
>  tick_sched_timer+0x42/0x120 kernel/time/tick-sched.c:1148
>  __run_hrtimer kernel/time/hrtimer.c:1210 [inline]
>  __hrtimer_run_queues+0x358/0xe20 kernel/time/hrtimer.c:1274
>  hrtimer_interrupt+0x1c2/0x5e0 kernel/time/hrtimer.c:1308
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1025 [inline]
>  smp_apic_timer_interrupt+0x14a/0x700 arch/x86/kernel/apic/apic.c:1050
>  apic_timer_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:920
>  </IRQ>
> RIP: 0010:variable_test_bit arch/x86/include/asm/bitops.h:332 [inline]
> RIP: 0010:inq_canon drivers/tty/n_tty.c:2409 [inline]
> RIP: 0010:n_tty_ioctl+0x218/0x2d0 drivers/tty/n_tty.c:2429
> RSP: 0018:ffff8801c914fb48 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff11
> RAX: 0000000000000643 RBX: ffffc900018c3060 RCX: ffffffff8293be5c
> RDX: 0000000000000000 RSI: 00000000749d30db RDI: ffffc900018c4260
> RBP: ffff8801c914fb88 R08: 1ffff10039229e99 R09: 0000000000000004
> R10: ffff8801c914f988 R11: 0000000000000003 R12: ffffc900018c2000
> R13: 00000002e0efd643 R14: 0000000020a6bffc R15: ffff8801c8493938
>  tty_ioctl+0x336/0x1610 drivers/tty/tty_io.c:2640
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x445b39
> RSP: 002b:00007f6ed1479d18 EFLAGS: 00000293 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000006dac3c RCX: 0000000000445b39
> RDX: 0000000020a6bffc RSI: 000000000000541b RDI: 0000000000000013
> RBP: 00000000006dac38 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 6d74702f7665642f
> R13: 00007ffe16e1657f R14: 00007f6ed147a9c0 R15: 0000000000000008
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/089e082bdf106667a50560f672cc%40google.com.
>
> For more options, visit https://groups.google.com/d/optout.
