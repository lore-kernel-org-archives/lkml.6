Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RWMxLPI7GluNKwAAmS7hNA
	; Fri, 08 Jun 2018 08:20:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A53E6607E4; Fri,  8 Jun 2018 08:20:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+KVCbUY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SORTED_RECIPS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A7F5960590;
	Fri,  8 Jun 2018 08:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7F5960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932223AbeFHIUn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:20:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44175 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932408AbeFHIUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:20:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so6256194pfk.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1w7Sv6FetmhWdshCzoJKcRvEo8lI6+9K22GAUaCPHv0=;
        b=L+KVCbUYrh1Va/ubPk3h8lvnzZw3ozj9taNDL1EfJrBJzjBdtff3ii77kvBn5H+3m/
         uKL3r9vamWij9SnUXdMKPbhMILgtTf8aZTPloDkdWxVA190Fmm+VfO2UFLqbvZEHVr8C
         eWmt+kI271534aqHfh3lHPxljE8SRZvUTWZylU5FFQn94LBTLkxxaI8yu0SH9XlHXYhe
         gI9ztp/q8p/R0HMHJfuGaIA25aqDZhofMSxGAKdvymRGEQbuECjZSC+ymUFlZRsxgN8s
         8swj3kYWTEMgHm7j2/iMaIxfDuvIgtSZxFfnVxTjCFp2E7q4gtYMke1Nb5r7n+yQn1I0
         oxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1w7Sv6FetmhWdshCzoJKcRvEo8lI6+9K22GAUaCPHv0=;
        b=oEn+DkdPQoMw9p3Nn7BCxdM3bkQYb/iYFBBVIhrH80kW4i7zi24yBKl9Ly317ZiL5Z
         0jDjGqRqtJPSPh7prNMur84Bf1rB33I+MVB9yDDlKwMldr6VR6SRTEwXIMh8pmIXCLeX
         W62Y8+NsaxYUOYK1z1dgn28NTxXhqTZnKyYSzKM67Bplc2tVTk1kvjH+FdKdG6sWZTKx
         hoYHTAtJgnW3dJhxHKNEUXHg8vwjoRTK5khyoxRPfLW9u9AhzBmfpD0wrniy8izkl81C
         QaHDRPfyMd9+8QjlPE0yQiFOaio4/4J8bMBsgkZQQvBBDAq42YqhwdNlYSR4MtAEY0g6
         HUyg==
X-Gm-Message-State: APt69E3NIKlWRM+vKZlYjUm7jfLTV+Sv/VFMd4fL52AEM9GxSykAL1B9
        KG55SjrV1UJuFIysL1f55tRc1SkdbVe56SsOwRR/Mw==
X-Google-Smtp-Source: ADUXVKJlbbItI+UmZxzsSRVcFNjBes/0gkGwLSFpc7OWj0YblU6EctUGmgaL6qyDYnnn5VupG87DGTFudGvDKxmG8BQ=
X-Received: by 2002:a65:490d:: with SMTP id p13-v6mr4316167pgs.84.1528446035494;
 Fri, 08 Jun 2018 01:20:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 01:20:15
 -0700 (PDT)
In-Reply-To: <089e0826d4d4bdb7c5056500fb67@google.com>
References: <089e0826d4d4bdb7c5056500fb67@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 10:20:15 +0200
Message-ID: <CACT4Y+YkgsQG9vtFJSbSBNuFAdiApEuSfih0Qj1SpNRTasR69A@mail.gmail.com>
Subject: Re: INFO: task hung in netdev_run_todo
To: syzbot <syzbot+8cd13ab48843d67c58f0@syzkaller.appspotmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Benc <jbenc@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        mschiffer@universe-factory.net, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 11:03 AM, syzbot
<syzbot+8cd13ab48843d67c58f0@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 581e400ff935d34d95811258586128bf11baef15 (Wed Feb 7 22:29:34 2018 +0000)
> Merge tag 'modules-for-v4.16' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux
>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> user-space arch: i386
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+8cd13ab48843d67c58f0@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> INFO: task kworker/u4:1:21 blocked for more than 120 seconds.
>       Not tainted 4.15.0+ #213
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/u4:1    D12208    21      2 0x80000000
> Workqueue: netns cleanup_net
> Call Trace:
>  context_switch kernel/sched/core.c:2857 [inline]
>  __schedule+0x8e2/0x2040 kernel/sched/core.c:3435
>  schedule+0xf5/0x430 kernel/sched/core.c:3494
>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:3552
>  __mutex_lock_common kernel/locking/mutex.c:833 [inline]
>  __mutex_lock+0xaad/0x1a80 kernel/locking/mutex.c:893
>  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>  rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>  netdev_wait_allrefs+0x1cb/0x410 net/core/dev.c:8035
>  netdev_run_todo+0x478/0xae0 net/core/dev.c:8129
>  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:108
>  default_device_exit_batch+0x4b4/0x5d0 net/core/dev.c:8930
>  ops_exit_list.isra.6+0x100/0x150 net/core/net_namespace.c:145
>  cleanup_net+0x6a3/0xcc0 net/core/net_namespace.c:517
>  process_one_work+0xbbf/0x1af0 kernel/workqueue.c:2113
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:429
>
> Showing all locks held in the system:
> 4 locks held by kworker/u4:1/21:
>  #0:  ((wq_completion)"%s""netns"){+.+.}, at: [<000000008671663e>]
> process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  (net_cleanup_work){+.+.}, at: [<0000000098e1951b>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (net_mutex){+.+.}, at: [<000000009da3dcc8>] cleanup_net+0x242/0xcc0
> net/core/net_namespace.c:484
>  #3:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 2 locks held by khungtaskd/758:
>  #0:  (rcu_read_lock){....}, at: [<0000000032c7899a>]
> check_hung_uninterruptible_tasks kernel/hung_task.c:175 [inline]
>  #0:  (rcu_read_lock){....}, at: [<0000000032c7899a>] watchdog+0x1c5/0xd60
> kernel/hung_task.c:249
>  #1:  (tasklist_lock){.+.+}, at: [<000000008744ddaf>]
> debug_show_all_locks+0xd3/0x3d0 kernel/locking/lockdep.c:4470
> 1 lock held by rsyslogd/3947:
>  #0:  (&f->f_pos_lock){+.+.}, at: [<00000000f50ca942>]
> __fdget_pos+0x12b/0x190 fs/file.c:765
> 2 locks held by getty/4070:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004fdd9acb>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033740686>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4071:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004fdd9acb>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033740686>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4072:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004fdd9acb>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033740686>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4073:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004fdd9acb>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033740686>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4074:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004fdd9acb>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033740686>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4075:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004fdd9acb>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033740686>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 2 locks held by getty/4076:
>  #0:  (&tty->ldisc_sem){++++}, at: [<000000004fdd9acb>]
> ldsem_down_read+0x37/0x40 drivers/tty/tty_ldsem.c:365
>  #1:  (&ldata->atomic_read_lock){+.+.}, at: [<0000000033740686>]
> n_tty_read+0x2ef/0x1a00 drivers/tty/n_tty.c:2131
> 1 lock held by syz-executor2/4154:
>  #0:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 3 locks held by kworker/1:3/7524:
>  #0:  ((wq_completion)"%s"("ipv6_addrconf")){+.+.}, at: [<000000008671663e>]
> process_one_work+0xaaf/0x1af0 kernel/workqueue.c:2084
>  #1:  ((addr_chk_work).work){+.+.}, at: [<0000000098e1951b>]
> process_one_work+0xb01/0x1af0 kernel/workqueue.c:2088
>  #2:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor0/10595:
>  #0:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor3/13841:
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<0000000063f9b07b>] lock_sock
> include/net/sock.h:1463 [inline]
>  #0:  (sk_lock-AF_INET6){+.+.}, at: [<0000000063f9b07b>]
> compat_ipv6_getsockopt+0x1f1/0x390 net/ipv6/ipv6_sockglue.c:1412
> 1 lock held by syz-executor3/13845:
>  #0:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor3/13851:
>  #0:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor3/13862:
>  #0:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor0/13866:
>  #0:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
> 1 lock held by syz-executor2/13868:
>  #0:  (rtnl_mutex){+.+.}, at: [<000000000b60ddd2>] rtnl_lock+0x17/0x20
> net/core/rtnetlink.c:74
>
> =============================================
>
> NMI backtrace for cpu 1
> CPU: 1 PID: 758 Comm: khungtaskd Not tainted 4.15.0+ #213
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  nmi_cpu_backtrace+0x1d2/0x210 lib/nmi_backtrace.c:103
>  nmi_trigger_cpumask_backtrace+0x122/0x180 lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:138 [inline]
>  check_hung_task kernel/hung_task.c:132 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:190 [inline]
>  watchdog+0x90c/0xd60 kernel/hung_task.c:249
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:429
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0+ #213
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:rcu_lockdep_current_cpu_online+0x52/0x190 kernel/rcu/tree.c:1123
> RSP: 0018:ffff8801db407780 EFLAGS: 00000282
> RAX: ffffed003b680ef0 RBX: 1ffff1003b680ef0 RCX: 1ffff1003b680ef6
> RDX: dffffc0000000000 RSI: ffffffff86b290c0 RDI: ffff8801db423750
> RBP: ffff8801db407808 R08: 1ffff1003b680e47 R09: 0000000000000002
> R10: ffff8801db4076f8 R11: 0000000000000020 R12: 1ffff1003b680f20
> R13: ffff8801d9e66a00 R14: ffff8801db4079c0 R15: 1ffff1003b680f14
> FS:  0000000000000000(0000) GS:ffff8801db400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000240f000 CR3: 0000000006a22003 CR4: 00000000001606f0
> DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>  <IRQ>
>  rcu_read_lock_held+0x94/0xc0 kernel/rcu/update.c:331
>  rebalance_domains+0x945/0xcc0 kernel/sched/fair.c:9147
>  run_rebalance_domains+0x378/0x770 kernel/sched/fair.c:9405
>  __do_softirq+0x2d7/0xb85 kernel/softirq.c:285
>  invoke_softirq kernel/softirq.c:365 [inline]
>  irq_exit+0x1cc/0x200 kernel/softirq.c:405
>  scheduler_ipi+0x318/0x820 kernel/sched/core.c:1804
>  smp_reschedule_interrupt+0xe6/0x650 arch/x86/kernel/smp.c:277
>  reschedule_interrupt+0xa9/0xb0 arch/x86/entry/entry_64.S:853
>  </IRQ>
> RIP: 0010:native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:54
> RSP: 0018:ffffffff86a07c38 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff02
> RAX: dffffc0000000000 RBX: 1ffffffff0d40f8a RCX: 0000000000000000
> RDX: 1ffffffff0d59278 RSI: 0000000000000001 RDI: ffffffff86ac93c0
> RBP: ffffffff86a07c38 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffffff86a07cf0 R14: ffffffff87269560 R15: 0000000000000000
>  arch_safe_halt arch/x86/include/asm/paravirt.h:93 [inline]
>  default_idle+0xbf/0x430 arch/x86/kernel/process.c:354
>  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:345
>  default_idle_call+0x36/0x90 kernel/sched/idle.c:98
>  cpuidle_idle_call kernel/sched/idle.c:156 [inline]
>  do_idle+0x24a/0x3b0 kernel/sched/idle.c:246
>  cpu_startup_entry+0x104/0x120 kernel/sched/idle.c:351
>  rest_init+0xed/0xf0 init/main.c:436
>  start_kernel+0x7f1/0x819 init/main.c:716
>  x86_64_start_reservations+0x2a/0x2c arch/x86/kernel/head64.c:378
>  x86_64_start_kernel+0x77/0x7a arch/x86/kernel/head64.c:359
>  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:237
> Code: c7 85 78 ff ff ff b3 8a b5 41 48 8d 04 13 48 c7 45 80 b5 14 7d 86 48
> c7 45 88 50 e2 5d 81 c7 00 f1 f1 f1 f1 c7 40 04 00 f2 f2 f2 <c7> 40 08 f3 f3
> f3 f3 b8 01 00 00 00 65 8b 0d 9b 0a a4 7e 81 e1


Presumably this is just a flake due to too slow execution. A thread
can't actually take the mutex for 2 minutes, but nothing has hanged
entirely. See detailed discussion here:
https://groups.google.com/d/msg/syzkaller-bugs/JwoXRjOYNnY/pIZWcXAoBQAJ
