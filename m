Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6578BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D272073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6jLJztG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D272073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeIELqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:46:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43480 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIELqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:46:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so2993770pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UggjSmM2Qmua+Out9uVj7N0+cSy18aEMKqOmC14XH3M=;
        b=I6jLJztGJKz0nleuGUEAQy7Mrd7Z+CA6i4SyTQmezjNyY4oPg/wJZ+egSjyol8Oft2
         p1UTGz1jGRKCalGeTdSwyLmqI1734pJm5CTP3JeKpVwedT7pggCO6DsBvYlX6UGQ1fMC
         tsx8Joer6Jsb5DgibSqUrvR3BeRZviv9jVNg2c+Oe8YYDKEv73GTqwOzIdQm+uzmnN8s
         OTzvhjlFkGsobC0b+pMkp4ntv5dnfArwVczooqRbsW+l9oTWKJc+bTdbnKasSyRFud3e
         UN5osYATOxiEJvnJ+cvdLlsYpMMJ60YGpzhko/wTEqCoSCxKwEJPtao5tTT6Ee3tPOpf
         618g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UggjSmM2Qmua+Out9uVj7N0+cSy18aEMKqOmC14XH3M=;
        b=mob8xlSfb0X0YBY/q4zdjOgjocs6h/ugzJa1r5uJUJHFiMMzJlD+eDfgeIGnyHxC17
         VU3zXfU8oJ5zNIXoSEQ790/U/PjczLK9okkHyGiQOLATx9T4o+DVsVZMUUUz8skWqqro
         qC3vqpDUsNw1FAcSe7OmrCsODx+CCBtX08XnNsPkkSh19mbaIpCfXozb8uG/cEH2312T
         vhRw5ukpiwNxOcOpOC+MDhARlYvMcIDxinRFMUfQCn1IDVv/dWXdmug1/alQ1J+l9ivm
         gkJJUaQsUl+yyccc7ATpNMUnCB99vXKrcGxL7VMGMy63X/LNgIq8TSfsVzW6g2f8BeJa
         y5rg==
X-Gm-Message-State: APzg51DXOz2zxYN3fFGleH2sKRtm+xf/rFpdV5NOCEsvPSXpr9nKG61C
        qUbepxH3tk3iwZc/zTzGaKjNDFg2LwHOwBQTd8+PRQ==
X-Google-Smtp-Source: ANB0VdapUIn2mZ4Qhwg2Tc9V7iKXGONBjNjZJJD2doA2lV6IKEHgV/mdq7duatqdpXjHLNR/8hDstJ1dLJIXkGSYsRI=
X-Received: by 2002:a63:6183:: with SMTP id v125-v6mr35613854pgb.242.1536131866332;
 Wed, 05 Sep 2018 00:17:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 5 Sep 2018 00:17:25
 -0700 (PDT)
In-Reply-To: <0000000000004f6b5805751a8189@google.com>
References: <0000000000004f6b5805751a8189@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 5 Sep 2018 09:17:25 +0200
Message-ID: <CACT4Y+ZOr7Oy==QDT-YV9m9srVPfq4A4_Q1XfND64CHXUZL2hQ@mail.gmail.com>
Subject: Re: linux-next test error
To:     syzbot <syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tim.c.chen@linux.intel.com, zwisler@kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 9:13 AM, syzbot
<syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    387ac6229ecf Add linux-next specific files for 20180905
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=149c67a6400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ad5163873ecfbc32
> dashboard link: https://syzkaller.appspot.com/bug?extid=87a05ae4accd500f5242
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com

This happens during simple image testing, mostly create a process that
does mmap. No fuzzing involved yet.

This happened around the same time I enabled extents feature in syzbot
ext4 images:
https://github.com/google/syzkaller/commit/98bfd6d34cf1dfe8b9638f88017f331e06325c25
Maybe it's related, but the hang does not happen on any other trees so far.


> INFO: task hung in do_page_mkwriteINFO: task syz-fuzzer:4876 blocked for
> more than 140 seconds.
>       Not tainted 4.19.0-rc2-next-20180905+ #56
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> syz-fuzzer      D21704  4876   4871 0x00000000
> Call Trace:
>  context_switch kernel/sched/core.c:2825 [inline]
>  __schedule+0x87c/0x1df0 kernel/sched/core.c:3473
>  schedule+0xfb/0x450 kernel/sched/core.c:3517
>  io_schedule+0x1c/0x70 kernel/sched/core.c:5140
>  wait_on_page_bit_common mm/filemap.c:1100 [inline]
>  __lock_page+0x5b7/0x7a0 mm/filemap.c:1273
>  lock_page include/linux/pagemap.h:483 [inline]
>  do_page_mkwrite+0x429/0x520 mm/memory.c:2391
>  do_shared_fault mm/memory.c:3717 [inline]
>  do_fault mm/memory.c:3756 [inline]
>  handle_pte_fault mm/memory.c:3983 [inline]
>  __handle_mm_fault+0x2a0a/0x4350 mm/memory.c:4107
>  handle_mm_fault+0x53e/0xc80 mm/memory.c:4144
>  __do_page_fault+0x620/0xe50 arch/x86/mm/fault.c:1395
>  do_page_fault+0xf6/0x7a4 arch/x86/mm/fault.c:1470
>  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1164
> RIP: 0033:0x70b591
> Code: 48 89 6c 24 10 48 8d 6c 24 10 48 8b 44 24 20 48 8b 48 08 48 8b 50 10
> 48 8d 58 08 48 83 fa 08 0f 8c 1e 01 00 00 48 8b 54 24 28 <88> 11 48 8b 48 08
> 48 8b 70 10 48 83 fe 01 0f 86 44 01 00 00 48 89
> RSP: 002b:000000c42010f3f0 EFLAGS: 00010212
> RAX: 000000c42010f508 RBX: 000000c42010f510 RCX: 00007f9d22c27000
> RDX: 0000000000000537 RSI: 000000000072a470 RDI: 000000c42010f348
> RBP: 000000c42010f400 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000009496ca R11: 0000000000000004 R12: 0000000000000000
> R13: 0000000000000020 R14: 0000000000000013 R15: 000000000000000f
>
> Showing all locks held in the system:
> 4 locks held by kworker/u4:1/22:
>  #0: 000000005bc28536 ((wq_completion)"writeback"){+.+.}, at:
> __write_once_size include/linux/compiler.h:215 [inline]
>  #0: 000000005bc28536 ((wq_completion)"writeback"){+.+.}, at:
> arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
>  #0: 000000005bc28536 ((wq_completion)"writeback"){+.+.}, at: atomic64_set
> include/asm-generic/atomic-instrumented.h:40 [inline]
>  #0: 000000005bc28536 ((wq_completion)"writeback"){+.+.}, at:
> atomic_long_set include/asm-generic/atomic-long.h:59 [inline]
>  #0: 000000005bc28536 ((wq_completion)"writeback"){+.+.}, at: set_work_data
> kernel/workqueue.c:617 [inline]
>  #0: 000000005bc28536 ((wq_completion)"writeback"){+.+.}, at:
> set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
>  #0: 000000005bc28536 ((wq_completion)"writeback"){+.+.}, at:
> process_one_work+0xb44/0x1aa0 kernel/workqueue.c:2124
>  #1: 000000007193e1ae ((work_completion)(&(&wb->dwork)->work)){+.+.}, at:
> process_one_work+0xb9b/0x1aa0 kernel/workqueue.c:2128
>  #2: 0000000079a3ee6d (&fc->fs_type->s_umount_key#29){++++}, at:
> trylock_super+0x22/0x110 fs/super.c:411
>  #3: 00000000f58a212d (&sbi->s_journal_flag_rwsem){.+.+}, at:
> do_writepages+0x9a/0x1a0 mm/page-writeback.c:2340
> 1 lock held by khungtaskd/793:
>  #0: 0000000020ca7c68 (rcu_read_lock){....}, at:
> debug_show_all_locks+0xd0/0x428 kernel/locking/lockdep.c:4436
> 1 lock held by khugepaged/799:
>  #0: 00000000af3da9ce (&mm->mmap_sem){++++}, at:
> collapse_huge_page+0x2bf/0x2250 mm/khugepaged.c:1007
> 1 lock held by rsyslogd/4761:
>  #0: 00000000a67fe71d (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x1bb/0x200
> fs/file.c:766
> 2 locks held by getty/4851:
>  #0: 00000000236449d0 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 000000004a997762 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4852:
>  #0: 00000000d68d1a08 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000f062cc2f (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4853:
>  #0: 00000000507cd5fe (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000fa59d11e (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4854:
>  #0: 00000000de7b4c24 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000e3caa2a6 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4855:
>  #0: 00000000e5b05f9f (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 0000000002e17b37 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4856:
>  #0: 00000000831fbb62 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 000000009838e2ef (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 2 locks held by getty/4857:
>  #0: 000000003038a645 (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
> drivers/tty/tty_ldsem.c:353
>  #1: 00000000c1269869 (&ldata->atomic_read_lock){+.+.}, at:
> n_tty_read+0x335/0x1ce0 drivers/tty/n_tty.c:2140
> 1 lock held by syz-fuzzer/4876:
>  #0: 00000000af3da9ce (&mm->mmap_sem){++++}, at: __do_page_fault+0x389/0xe50
> arch/x86/mm/fault.c:1324
>
> =============================================
>
> NMI backtrace for cpu 0
> CPU: 0 PID: 793 Comm: khungtaskd Not tainted 4.19.0-rc2-next-20180905+ #56
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  nmi_cpu_backtrace.cold.4+0x48/0x88 lib/nmi_backtrace.c:101
>  nmi_trigger_cpumask_backtrace+0x1b6/0x1cd lib/nmi_backtrace.c:62
>  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
>  trigger_all_cpu_backtrace include/linux/nmi.h:144 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
>  watchdog+0xb39/0x1040 kernel/hung_task.c:265
>  kthread+0x35a/0x420 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:415
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc2-next-20180905+ #56
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
> RIP: 0010:check_kcov_mode kernel/kcov.c:69 [inline]
> RIP: 0010:write_comp_data+0x22/0x70 kernel/kcov.c:122
> Code: e4 b9 ca ff 90 90 90 90 55 65 4c 8b 04 25 40 ee 01 00 65 8b 05 2f 44
> 86 7e 48 89 e5 a9 00 01 1f 00 75 51 41 8b 80 88 12 00 00 <83> f8 03 75 45 49
> 8b 80 90 12 00 00 45 8b 80 8c 12 00 00 4c 8b 08
> RSP: 0018:ffff8801d9f1fb10 EFLAGS: 00000046
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff816df180
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> RBP: ffff8801d9f1fb10 R08: ffff8801d9f0e380 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000000 R12: ffff8801d9f1fb80
> R13: 0000000000021f3e R14: 0000002b4d7800be R15: 00000000fffe3d07
> FS:  0000000000000000(0000) GS:ffff8801db100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffff600400 CR3: 00000001b91c2000 CR4: 00000000001406e0
> Call Trace:
>  __sanitizer_cov_trace_const_cmp1+0x1a/0x20 kernel/kcov.c:174
>  tick_nohz_next_event+0x5e0/0x8a0 kernel/time/tick-sched.c:672
>  __tick_nohz_idle_stop_tick kernel/time/tick-sched.c:930 [inline]
>  tick_nohz_idle_stop_tick+0x633/0xcb0 kernel/time/tick-sched.c:960
>  cpuidle_idle_call kernel/sched/idle.c:150 [inline]
>  do_idle+0x3a0/0x580 kernel/sched/idle.c:262
>  cpu_startup_entry+0x10c/0x120 kernel/sched/idle.c:368
>  start_secondary+0x433/0x5d0 arch/x86/kernel/smpboot.c:271
>  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004f6b5805751a8189%40google.com.
> For more options, visit https://groups.google.com/d/optout.
