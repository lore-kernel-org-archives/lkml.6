Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA72C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7099020675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k69P8H6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeLQJpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:45:05 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35368 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeLQJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:45:04 -0500
Received: by mail-io1-f65.google.com with SMTP id o13so9513114ioh.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s9n4qx1EPN+B3iXCP79otTSrNIunsxQ2YdauTCagWJ4=;
        b=k69P8H6XhueH0WOHJKEAxfthw8/KKgcXItph8/STiafeEzYUilAd0HinFPw+1OHw06
         LURuPKCyum+FunPTcl8Xg2SOu9ceGYzWxV2lyOa7op5k3E3foLtH+ll23OIdi4zgQAgw
         ESdFTcJMhX1rUSRLCMc2buHPJIDM5mSXFxTevNYVpFnHU7p0Hz07TrduK9PSga5qRXA9
         55Anqf+HE2y5rjsV+9+eYv698cQZjcDYvVfFVweQ41OGWRDWnKxhkK3ck/xHumuuQcyx
         6q+ihuVRVia11gJclmClS0ehAdka58CZ9ZRSIVF2r2PB437Y5lg7dGbx0GXc+px70H9d
         vtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s9n4qx1EPN+B3iXCP79otTSrNIunsxQ2YdauTCagWJ4=;
        b=NHMlni2uVrhvH4Xsrv3EMQ6TcguxmQ5rfBDcNluxroLzS+xm5qwXajecMMMrPN4uA1
         S2JBTMch4Gu1bm8o26dPy6ZSD7+SoYfQsgJE1IbX/HKTNLaq8qQGCOnrH/2u8yTMQJdg
         hu6k+lXdp8RoxcOXDdfQu9VYNUU5LTcwYpcMjJKoEoblQPchbc1WRu7gjh4brlf563gm
         2smzlfgZ1ppwqMpBLYeB3ZvYcAKK6Wzia9AiWuYYYOiHxgTCg1mUUb5ncIM/c2bg35Gz
         RQSVwlB8wS6RtCTq6pOHabio+JOE5pT6aTXEyhTawjzvWH3zbYwMeewj/rr2Vgref8R4
         tdSw==
X-Gm-Message-State: AA+aEWYgnzo10UKrP24gpfKPSREAUnciUy6fBnyDpff8HCShbomYumpR
        rVz9ssF7wXJbGn6LOXkX3NYIQHr6dbXasviOgZ6vuQ==
X-Google-Smtp-Source: AFSGD/UTNKeafibfavA4FYj1BKqMRD4XC1jRQO2uBFaaqavrDi2N1ejIOo4oQ7cOcbiV5dXuUsp5H7w0GGJRc3cpCI4=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr10424379iom.11.1545039903276;
 Mon, 17 Dec 2018 01:45:03 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005e47a2057d0edc49@google.com> <20181216190412.GE4170@linux.ibm.com>
In-Reply-To: <20181216190412.GE4170@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Dec 2018 10:44:52 +0100
Message-ID: <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
Subject: Re: WARNING in __rcu_read_unlock
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 8:04 PM Paul E. McKenney <paulmck@linux.ibm.com> wr=
ote:
>
> On Sat, Dec 15, 2018 at 04:41:03AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    2aa55dccf83d hns3: prevent building without CONFIG_INET
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15628f6d400=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd9655b05acf=
c97ff
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D43f6755d1c2e6=
2743468
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125fda8b4=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D135e54cd400=
000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com
> >
> > IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> > IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> > 8021q: adding VLAN 0 to HW filter on device team0
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > WARNING: CPU: 0 PID: -2035180937 at kernel/rcu/tree_plugin.h:438
> > __rcu_read_unlock+0x266/0x2e0 kernel/rcu/tree_plugin.h:432
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: -2035180937 Comm:  L =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD Not tainted 4.20.0-rc6+ #344
> > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > BIOS Google 01/01/2011
> > Call Trace:
> >  <IRQ>
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x244/0x39d lib/dump_stack.c:113
> >  panic+0x2ad/0x55c kernel/panic.c:188
> >  __warn.cold.8+0x20/0x45 kernel/panic.c:540
> >  report_bug+0x254/0x2d0 lib/bug.c:186
> >  fixup_bug arch/x86/kernel/traps.c:178 [inline]
> >  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
> >  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
> >  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> > RIP: 0010:__rcu_read_unlock+0x266/0x2e0 kernel/rcu/tree_plugin.h:432
> > Code: 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 0f b6 04 02 84 c0 74 04
> > 3c 03 7e 6f 41 c7 84 24 70 03 00 00 00 00 00 00 e9 5a fe ff ff <0f>
> > 0b e9 da fe ff ff 4c 89 f7 e8 1b 14 59 00 e9 2a fe ff ff 4c 89
> > RSP: 0018:ffff8881dae075e8 EFLAGS: 00010006
> > RAX: dffffc0000000000 RBX: 1ffff1103b5c0ebe RCX: ffffffff8153f599
> > RDX: 1ffff1103b5c0eca RSI: ffffffff8153f5bb RDI: 0000000000000005
> > RBP: ffff8881dae076b8 R08: ffff8881bf1f4540 R09: ffffed103b5c3ef8
> > R10: ffffed103b5c3ef8 R11: ffff8881dae1f7c7 R12: 00000000fdb21501
> > R13: 1ffff1103b5c0eca R14: ffff8881bf1f48b0 R15: ffff8881dae07690
> >  rcu_read_unlock include/linux/rcupdate.h:660 [inline]
> >  __atomic_notifier_call_chain kernel/notifier.c:184 [inline]
> >  atomic_notifier_call_chain+0xd0/0x190 kernel/notifier.c:193
> >  notify_die+0x1bd/0x2d0 kernel/notifier.c:549
> >  do_general_protection+0x16d/0x2f0 arch/x86/kernel/traps.c:557
> >  general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1142
> > RIP: 0010:task_css include/linux/cgroup.h:477 [inline]
> > RIP: 0010:task_ca kernel/sched/cpuacct.c:43 [inline]
> > RIP: 0010:cpuacct_account_field+0x140/0x3d0 kernel/sched/cpuacct.c:365
> > Code: b6 97 08 00 85 c0 74 0d 80 3d 69 bb b2 08 00 0f 84 a4 01 00 00
> > 49 8d 7e 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80>
> > 3c 02 00 0f 85 4e 02 00 00 4d 8b 7e 10 49 81 ff 20 23 58 89 0f
> > RSP: 0018:ffff8881dae078a8 EFLAGS: 00010002
> > RAX: dffffc0000000000 RBX: ffff8881dae07918 RCX: 0000000000000000
> > RDX: 000000000000000e RSI: 00000000ffff8881 RDI: 0000000000000072
> > RBP: ffff8881dae07940 R08: 0000000000000000 R09: 0000000000000000
> > R10: ffffed1037304851 R11: 0000000000000007 R12: 0000000000982e14
> > R13: dffffc0000000000 R14: 0000000000000062 R15: ffff8881bf1f4540
> >  cgroup_account_cputime_field include/linux/cgroup.h:775 [inline]
> >  task_group_account_field kernel/sched/cputime.c:108 [inline]
> >  account_system_index_time+0x1e8/0x5d0 kernel/sched/cputime.c:171
> >  irqtime_account_process_tick.isra.6+0x35b/0x490 kernel/sched/cputime.c=
:388
> >  account_process_tick+0x282/0x350 kernel/sched/cputime.c:483
> >  update_process_times+0x21/0x70 kernel/time/timer.c:1634
> >  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
> >  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
> >  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
> >  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
> >  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inline]
> >  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1059
> >  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
> >  </IRQ>
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
>
>
> Hmmm...  Line 432 is the "t->rcu_read_lock_nesting =3D 0;" below
> and Line 438 is the int "rrln =3D READ_ONCE(t->rcu_read_lock_nesting);"
> below.  Are you saying that the value of "current" is NULL?  If you
> do that, you have voided your RCU warranty.  ;-)
>
> Or should I be looking elsewhere than v4.20-rc5?

Hi Paul,

Git tree and commit are in the first lines of the report ;)

I think it points to:
    WARN_ON_ONCE(rrln < 0 && rrln > INT_MIN / 2);

The exact source line for the RIP: line maybe off-by-one, because
usually we have call return PCs, and then it's necessary to subtract 1
during symbolization, but not for RIP: lines, because they contain
exact faulting PC. This was fixed few days ago, but I think this
report was generated before this fix:
https://github.com/google/syzkaller/commit/7a944a0a666587f229291814b30644cc=
0859674c

But the kernel output contains the right line number:
[   51.239451] WARNING: CPU: 0 PID: -2035180937 at
kernel/rcu/tree_plugin.h:438 __rcu_read_unlock+0x266/0x2e0

That "PID: -2035180937" looks concerning.

Out of 3 syscalls in the reproducer, 2 operate on invalid fd's so
probably no-op. And the remaining one injects a network packet. If
this is caused by the incoming network packet, it may be pretty bad.
+netdev.



> ------------------------------------------------------------------------
>
> void __rcu_read_unlock(void)
> {
>         struct task_struct *t =3D current;
>
>         if (t->rcu_read_lock_nesting !=3D 1) {
>                 --t->rcu_read_lock_nesting;
>         } else {
>                 barrier();  /* critical section before exit code. */
>                 t->rcu_read_lock_nesting =3D INT_MIN;
>                 barrier();  /* assign before ->rcu_read_unlock_special lo=
ad */
>                 if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
>                         rcu_read_unlock_special(t);
>                 barrier();  /* ->rcu_read_unlock_special load before assi=
gn */
>                 t->rcu_read_lock_nesting =3D 0;
>         }
> #ifdef CONFIG_PROVE_LOCKING
>         {
>                 int rrln =3D READ_ONCE(t->rcu_read_lock_nesting);
>
>                 WARN_ON_ONCE(rrln < 0 && rrln > INT_MIN / 2);
>         }
> #endif /* #ifdef CONFIG_PROVE_LOCKING */
> }
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20181216190412.GE4170%40linux.ibm.com.
> For more options, visit https://groups.google.com/d/optout.
