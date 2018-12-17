Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB11C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156C920656
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UROgZzu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbeLQNHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:07:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46717 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeLQNHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:07:31 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so9869365ios.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VB0X1wuye1d2ONDWztQSDJ6avY/G0lddk6F6PR4Dyvs=;
        b=UROgZzu8HdQAHW7lNGWjfhcSi/M8oRBDTxDE2sw/IrBoAteWDoKSaitxCaAFhQoFSj
         9sOYnCVDnbBkfon2v2VtsOS4LlUmBAzh9u+pItN+pM3DQHT+qr/Ys65avFqDH7aGa2OZ
         TjZ4nUm3j2xC8ajaN0v+9/HzYhmyoSVoj70wunZY8T67akCcauR6M30WCNWu54vhnAso
         xMdMOD/90ZzjwonAnhCMydOM4FSYRRReONXN8VQZ+BTcq3fQ5fncAq5hGSKP4IuzSyBY
         FAbNdwjNx9AQ1qR8pqeWcRv2Uv3Azd7zXCJMCPGiO0krcfZR435JxT5dCmQv6CNRPWPr
         LsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VB0X1wuye1d2ONDWztQSDJ6avY/G0lddk6F6PR4Dyvs=;
        b=nXg918Ycl9Da7I6Yk8P9FujBY4EajUfJlYxkPj0xSoxjrv3LgivLAFacN/BdhdR2aa
         V4kaDVOpU5+wujA4YwbsuHbugIuZLD7Y+sTC+M+a6AdV0ZNMaPxruYO5VLaXfMsnHQqY
         dr/XQ3TRTx9IXD/bqzEJYU8mLkFSkmHxL3RAvJHMje9uxemp4KfpJB/Xh96dtWg5/buL
         WC8v63b0G/uA1LRj3odx5wU9SwHoAcQvZXBpWB8X+lRKy/7kCsF6o6PvMoVNNX9vqZ7b
         iJNGZD+a6/iB40y5Gsj80kdvssxhWQUXg/JeP+0LdPXbJYiJL4onMrh2yJsLLx0oi+AQ
         x7pw==
X-Gm-Message-State: AA+aEWaDQws/jFnetFCS8+GTvMIoSXCF6LpsLmR8jrN9m56taruDeIk/
        noso2dVjD44w7o9mQ48iRH2DBsoUqL+bAw3MPKD/+Q==
X-Google-Smtp-Source: AFSGD/X3flrdHpS3LEWghcy2d6Wq1ODBQGnb3Zzj0+zBm1EZkh2Bb+eTEcSn/urHmx+zMhIcG3qlf715vp5lp4ywllE=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr10923005iom.11.1545052048605;
 Mon, 17 Dec 2018 05:07:28 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005e47a2057d0edc49@google.com> <20181216190412.GE4170@linux.ibm.com>
 <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com> <20181217112916.GG4170@linux.ibm.com>
In-Reply-To: <20181217112916.GG4170@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Dec 2018 14:07:17 +0100
Message-ID: <CACT4Y+aj+auY-7DCK91hNrU5o19JBibfG_e8tucf-Kiwcqx+-Q@mail.gmail.com>
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

On Mon, Dec 17, 2018 at 12:29 PM Paul E. McKenney <paulmck@linux.ibm.com> w=
rote:
>
> On Mon, Dec 17, 2018 at 10:44:52AM +0100, Dmitry Vyukov wrote:
> > On Sun, Dec 16, 2018 at 8:04 PM Paul E. McKenney <paulmck@linux.ibm.com=
> wrote:
> > >
> > > On Sat, Dec 15, 2018 at 04:41:03AM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    2aa55dccf83d hns3: prevent building without CONFIG_=
INET
> > > > git tree:       net-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15628f6=
d400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd9655b0=
5acfc97ff
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D43f6755d1=
c2e62743468
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125fd=
a8b400000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D135e54c=
d400000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the =
commit:
> > > > Reported-by: syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com
> > > >
> > > > IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> > > > IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> > > > 8021q: adding VLAN 0 to HW filter on device team0
> > > > kasan: CONFIG_KASAN_INLINE enabled
> > > > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > > > WARNING: CPU: 0 PID: -2035180937 at kernel/rcu/tree_plugin.h:438
> > > > __rcu_read_unlock+0x266/0x2e0 kernel/rcu/tree_plugin.h:432
> > > > Kernel panic - not syncing: panic_on_warn set ...
> > > > CPU: 0 PID: -2035180937 Comm:  L =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD Not tainted 4.20.0-rc6+ #344
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > > > BIOS Google 01/01/2011
> > > > Call Trace:
> > > >  <IRQ>
> > > >  __dump_stack lib/dump_stack.c:77 [inline]
> > > >  dump_stack+0x244/0x39d lib/dump_stack.c:113
> > > >  panic+0x2ad/0x55c kernel/panic.c:188
> > > >  __warn.cold.8+0x20/0x45 kernel/panic.c:540
> > > >  report_bug+0x254/0x2d0 lib/bug.c:186
> > > >  fixup_bug arch/x86/kernel/traps.c:178 [inline]
> > > >  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
> > > >  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
> > > >  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> > > > RIP: 0010:__rcu_read_unlock+0x266/0x2e0 kernel/rcu/tree_plugin.h:43=
2
> > > > Code: 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 0f b6 04 02 84 c0 74 0=
4
> > > > 3c 03 7e 6f 41 c7 84 24 70 03 00 00 00 00 00 00 e9 5a fe ff ff <0f>
> > > > 0b e9 da fe ff ff 4c 89 f7 e8 1b 14 59 00 e9 2a fe ff ff 4c 89
> > > > RSP: 0018:ffff8881dae075e8 EFLAGS: 00010006
> > > > RAX: dffffc0000000000 RBX: 1ffff1103b5c0ebe RCX: ffffffff8153f599
> > > > RDX: 1ffff1103b5c0eca RSI: ffffffff8153f5bb RDI: 0000000000000005
> > > > RBP: ffff8881dae076b8 R08: ffff8881bf1f4540 R09: ffffed103b5c3ef8
> > > > R10: ffffed103b5c3ef8 R11: ffff8881dae1f7c7 R12: 00000000fdb21501
> > > > R13: 1ffff1103b5c0eca R14: ffff8881bf1f48b0 R15: ffff8881dae07690
> > > >  rcu_read_unlock include/linux/rcupdate.h:660 [inline]
> > > >  __atomic_notifier_call_chain kernel/notifier.c:184 [inline]
> > > >  atomic_notifier_call_chain+0xd0/0x190 kernel/notifier.c:193
> > > >  notify_die+0x1bd/0x2d0 kernel/notifier.c:549
> > > >  do_general_protection+0x16d/0x2f0 arch/x86/kernel/traps.c:557
> > > >  general_protection+0x1e/0x30 arch/x86/entry/entry_64.S:1142
> > > > RIP: 0010:task_css include/linux/cgroup.h:477 [inline]
> > > > RIP: 0010:task_ca kernel/sched/cpuacct.c:43 [inline]
> > > > RIP: 0010:cpuacct_account_field+0x140/0x3d0 kernel/sched/cpuacct.c:=
365
> > > > Code: b6 97 08 00 85 c0 74 0d 80 3d 69 bb b2 08 00 0f 84 a4 01 00 0=
0
> > > > 49 8d 7e 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80>
> > > > 3c 02 00 0f 85 4e 02 00 00 4d 8b 7e 10 49 81 ff 20 23 58 89 0f
> > > > RSP: 0018:ffff8881dae078a8 EFLAGS: 00010002
> > > > RAX: dffffc0000000000 RBX: ffff8881dae07918 RCX: 0000000000000000
> > > > RDX: 000000000000000e RSI: 00000000ffff8881 RDI: 0000000000000072
> > > > RBP: ffff8881dae07940 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: ffffed1037304851 R11: 0000000000000007 R12: 0000000000982e14
> > > > R13: dffffc0000000000 R14: 0000000000000062 R15: ffff8881bf1f4540
> > > >  cgroup_account_cputime_field include/linux/cgroup.h:775 [inline]
> > > >  task_group_account_field kernel/sched/cputime.c:108 [inline]
> > > >  account_system_index_time+0x1e8/0x5d0 kernel/sched/cputime.c:171
> > > >  irqtime_account_process_tick.isra.6+0x35b/0x490 kernel/sched/cputi=
me.c:388
> > > >  account_process_tick+0x282/0x350 kernel/sched/cputime.c:483
> > > >  update_process_times+0x21/0x70 kernel/time/timer.c:1634
> > > >  tick_sched_handle+0x9f/0x180 kernel/time/tick-sched.c:164
> > > >  tick_sched_timer+0x45/0x130 kernel/time/tick-sched.c:1274
> > > >  __run_hrtimer kernel/time/hrtimer.c:1398 [inline]
> > > >  __hrtimer_run_queues+0x41c/0x10d0 kernel/time/hrtimer.c:1460
> > > >  hrtimer_interrupt+0x313/0x780 kernel/time/hrtimer.c:1518
> > > >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1034 [inlin=
e]
> > > >  smp_apic_timer_interrupt+0x1a1/0x760 arch/x86/kernel/apic/apic.c:1=
059
> > > >  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
> > > >  </IRQ>
> > > > Kernel Offset: disabled
> > > > Rebooting in 86400 seconds..
> > >
> > >
> > > Hmmm...  Line 432 is the "t->rcu_read_lock_nesting =3D 0;" below
> > > and Line 438 is the int "rrln =3D READ_ONCE(t->rcu_read_lock_nesting)=
;"
> > > below.  Are you saying that the value of "current" is NULL?  If you
> > > do that, you have voided your RCU warranty.  ;-)
> > >
> > > Or should I be looking elsewhere than v4.20-rc5?
> >
> > Hi Paul,
> >
> > Git tree and commit are in the first lines of the report ;)
>
> Ah, net-next.
>
> > I think it points to:
> >     WARN_ON_ONCE(rrln < 0 && rrln > INT_MIN / 2);
> >
> > The exact source line for the RIP: line maybe off-by-one, because
> > usually we have call return PCs, and then it's necessary to subtract 1
> > during symbolization, but not for RIP: lines, because they contain
> > exact faulting PC. This was fixed few days ago, but I think this
> > report was generated before this fix:
> > https://github.com/google/syzkaller/commit/7a944a0a666587f229291814b306=
44cc0859674c
> >
> > But the kernel output contains the right line number:
> > [   51.239451] WARNING: CPU: 0 PID: -2035180937 at
> > kernel/rcu/tree_plugin.h:438 __rcu_read_unlock+0x266/0x2e0
> >
> > That "PID: -2035180937" looks concerning.
>
> As does this sort of report on a line that contains simple integer
> arithmetic and boolean operations.  ;-)
>
> Any chance of a bisection?
>
>                                                         Thanx, Paul
>
> > Out of 3 syscalls in the reproducer, 2 operate on invalid fd's so
> > probably no-op. And the remaining one injects a network packet. If
> > this is caused by the incoming network packet, it may be pretty bad.
> > +netdev.


For now I can say this is something notoriously bad. Just emitting the
packet gave me:

[ 2103.960719] BUG: unable to handle kernel paging request at ffffe902e1e2a=
2d8
early console in extract_kernel
input_data: 0x00000000089b12e9
input_len: 0x0000000003451648
output: 0x0000000001000000
output_len: 0x0000000009911a48
kernel_total_size: 0x000000000ae26000
trampoline_32bit: 0x000000000009d000
Decompressing Linux... Parsing ELF... done.
Booting the kernel.

and second time:

[   30.976582] INFO: trying to register non-static key.
[   30.977065] BUG: KASAN: stack-out-of-bounds in inode_init_always+0xc16/0=
xd80
[   30.977681] general protection fault: 0000 [#1] PREEMPT SMP KASAN
[   30.978428] Kernel panic - not syncing: Fatal exception
