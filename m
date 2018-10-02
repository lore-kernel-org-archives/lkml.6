Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1E0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2174420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ6Cb8nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2174420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJBPGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:06:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42765 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeJBPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:06:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id b11-v6so1100109wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qCIPJhNz+AljVjS1hLWlaa0v3cs7PoHX5WEkZe8OlGg=;
        b=bQ6Cb8nwZ4S+D2fKDvw27aoQWucI/r+2/V6GgHgLad8VheIcsbM9njX7yFu9UYU1QC
         dnooSTxNTe2kEvfGuax2WMsLhK7uKL1td85leKKep1Vxd5ojGxkUZ0CDSdvrnuiL8oKJ
         W1ECMQjhH0Ug0ziiEE46k3pJPJP/FVyG1vvxnoamhnXQ29cYo3OdY5kKH3s+4cXjVRLM
         sP2toPwqbGObz9ivH3XGAjaJ6NuYdN2tcDl1DGxizDMLi7GgTVaCcjQmXHD98N68u0Or
         2Y0pNrM7n+14Qfqi0zdSkE0LWXR1vN+NynntQh8ErIHBNxe5iY9DvxhofcJK5tX0oe5Z
         NqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qCIPJhNz+AljVjS1hLWlaa0v3cs7PoHX5WEkZe8OlGg=;
        b=GMfbbt7UyIwsQQQ9yI4lkIlAoqqntx/o3UnzaYDB43bNMQdhgmlgZhccvMEmh/NcKi
         Dv/OLjlkrf1YyX9IMK79V2J+Jh8Tj5Gx84rcHjqNMHvKVB7qKeiD6U4BzB9q8nOOYZKb
         /SCCHsGtRNOeluk8on48wEyv8HpaoRuqOjYh2oSHuhd0UmdN/LiOYw+ky2/upDJN3e9S
         8ZsXaMPncVBOJ/ZlU3gLf+g4qDqXg8ghzsMPDdBYF3SoPIycdQKDH4pPvJWXEYkJfYDn
         lhKvE7dSeuSZ93XLJjgBZ6Sz7CqwTa3LrwH2lhzxf8bsSjdxbjiAFAFzfNMHI9KOIbSQ
         gBfA==
X-Gm-Message-State: ABuFfohka9Dj1LSqJvChMivB4AAF6gQaL1KAukLIgtWFXCd/Ji9+7KCM
        WCx78LCUbjvqYwT59SX5/IA=
X-Google-Smtp-Source: ACcGV62dAPwqrlpmxpq3/HTeNw8Bp99tkH5Ky3s9u4q7qQ4qrVJoCy2e+LLpnrHaXcj8KeGMXCViPA==
X-Received: by 2002:a5d:69c2:: with SMTP id s2-v6mr5960072wrw.232.1538468672497;
        Tue, 02 Oct 2018 01:24:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k93-v6sm1481235wrc.89.2018.10.02.01.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:24:31 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:24:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, efault@gmx.de, byungchul.park@lge.com,
        joel@joelfernandes.org, mhillenb@amazon.de, dwmw2@infradead.org,
        peterz@infradead.org
Subject: Re: [GIT PULL rcu/next] RCU commits for 4.20/5.0
Message-ID: <20181002082429.GA69893@gmail.com>
References: <20180926182159.GA26116@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926182159.GA26116@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> Hello, Ingo,
> 
> This pull request contains the following changes:
> 
> 1.	Documentation updates, including some good-eye catches from
> 	Joel Fernandes.
> 
> 	http://lkml.kernel.org/r/20180829211637.GA20980@linux.vnet.ibm.com
> 
> 2.	SRCU updates, most notably changes enabling call_srcu() to be
> 	invoked very early in the boot sequence.
> 
> 	http://lkml.kernel.org/r/20180829212036.GA22033@linux.vnet.ibm.com
> 
> 3.	Torture-test updates, including some preliminary work towards
> 	making rcutorture better able to find problems that result in
> 	insufficient grace-period forward progress.
> 
> 	http://lkml.kernel.org/r/20180829214722.GA23411@linux.vnet.ibm.com
> 
> 4.	Consolidate the RCU-bh, RCU-preempt, and RCU-sched flavors into
> 	a single flavor similar to RCU-sched in !PREEMPT kernels and 
> 	into a single flavor similar to RCU-preempt (but also waiting
> 	on preempt-disabled sequences of code) in PREEMPT kernels.  This
> 	branch also includes a refactoring of rcu_{nmi,irq}_{enter,exit}()
> 	from Byungchul Park.
> 
> 	http://lkml.kernel.org/r/20180829222021.GA29944@linux.vnet.ibm.com
> 
> 5.	Now that there is only one RCU flavor in any given running kernel,
> 	the many "rsp" pointers are no longer required, and this cleanup
> 	series removes them.
> 
> 	http://lkml.kernel.org/r/20180829223830.GA1800@linux.vnet.ibm.com
> 
> 6.	This branch carries out additional cleanups made possible by
> 	the RCU flavor consolidation, including inlining how-trivial
> 	functions, updating comments and definitions, and removing
> 	now-unneeded rcutorture scenarios.
> 
> 	http://lkml.kernel.org/r/20180829225340.GA7019@linux.vnet.ibm.com
> 
> 7.	Initial changes to RCU to better promote forward progress of
> 	grace periods, including fixing a bug found by Marius Hillenbrand
> 	and David Woodhouse, with the fix suggested by Peter Zijlstra.
> 
> 	http://lkml.kernel.org/r/20180829230035.GA7751@linux.vnet.ibm.com
> 
> 8.	Now that there is only one flavor of RCU in any running kernel,
> 	there is also only on rcu_data structure per CPU.  This means
> 	that the rcu_dynticks structure can be merged into the rcu_data
> 	structure, a task taken on by this branch.  This branch also
> 	contains a -rt-related fix from Mike Galbraith.
> 
> 	http://lkml.kernel.org/r/20180829230715.GA9431@linux.vnet.ibm.com
> 
> Once again, the layout of this pull request is unusual due to the large
> footprint of the commits in #4-#8 above.  These five branches are therefore
> stacked on top of each other instead of my usual practice of laying them
> out in parallel.
> 
> This pull request decreases the size of RCU by more than 450 lines,
> offsetting the increase of the v4.19 merge window.  I expect a further
> decrease due to additional outside-of-RCU cleanups, though this will be
> offset by additional forward-progress testing and fixes in response to
> Marius's and David's location of a forward-progress bug that escaped to
> the field -- rcutorture should have located that bug, after all.
> 
> All of these changes have been subjected to 0day Test Robot and -next
> testing, and are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to b56ada120921fbb0a4fb2a5bee163717182e7e9e:
> 
>   Merge branches 'doc.2018.08.30a', 'dynticks.2018.08.30b', 'srcu.2018.08.30b' and 'torture.2018.08.29a' into HEAD (2018-08-30 16:12:53 -0700)
> 
> ----------------------------------------------------------------
> Byungchul Park (1):
>       rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
> 
> Joel Fernandes (Google) (2):
>       doc: Fix broken RCU-requirements link to LKML archive
>       doc: Improve rcu_dynticks::dynticks documentation
> 
> Mike Galbraith (1):
>       rcu: Convert rcu_state.ofl_lock to raw_spinlock_t
> 
> Paul E. McKenney (137):
>       doc: Add design documentation on interruption of NMI handlers
>       torture: Stop overwriting Make.out file with obsolete version
>       rcutorture: Force occasional reader waits
>       rcutorture: Warn on bad torture type for built-in tests
>       rcuperf: Warn on bad perf type for built-in tests
>       rcutorture: Remove TREE06 and TREE08 from the default test list
>       rcutorture: Add forward-progress tests for RCU grace periods
>       rcutorture: Also use GP sequence to judge forward progress
>       rcutorture: Avoid no-test complaint if too few forward-progress tries
>       rcutorture: Vary forward-progress test interval
>       rcutorture: Add self-propagating callback to forward-progress testing
>       rcutorture: Increase rcu_read_delay() longdelay_ms
>       rcutorture: Limit reader duration if irq or bh disabled
>       rcutorture: Reduce priority of forward-progress testing
>       rcutorture: Adjust number of reader kthreads per CPU-hotplug operations
>       rcutorture: Print forward-progress test interval on error
>       rcutorture: Check GP completion at stutter end
>       rcutorture: Maintain self-propagating CB only during forward-progress test
>       doc: Update removal of RCU-bh/sched update machinery
>       doc: Fix broken HTML directive
>       rcu: Defer reporting RCU-preempt quiescent states when disabled
>       rcutorture: Test extended "rcu" read-side critical sections
>       rcu: Allow processing deferred QSes for exiting RCU-preempt readers
>       rcu: Remove now-unused ->b.exp_need_qs field from the rcu_special union
>       rcu: Add warning to detect half-interrupts
>       rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt when safe
>       rcu: Report expedited grace periods at context-switch time
>       rcu: Define RCU-bh update API in terms of RCU
>       rcu: Update comments and help text for no more RCU-bh updaters
>       rcu: Drop "wake" parameter from rcu_report_exp_rdp()
>       rcu: Fix typo in rcu_get_gp_kthreads_prio() header comment
>       rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds
>       rcu: Express Tiny RCU updates in terms of RCU rather than RCU-sched
>       rcu: Remove RCU_STATE_INITIALIZER()
>       rcu: Eliminate rcu_state structure's ->call field
>       rcu: Remove rcu_state structure's ->rda field
>       rcu: Remove rcu_state_p pointer to default rcu_state structure
>       rcu: Remove rcu_data_p pointer to default rcu_data structure
>       rcu: Remove rsp parameter from rcu_report_qs_rnp()
>       rcu: Remove rsp parameter from rcu_report_qs_rsp()
>       rcu: Remove rsp parameter from rcu_report_unblock_qs_rnp()
>       rcu: Remove rsp parameter from rcu_report_qs_rdp()
>       rcu: Remove rsp parameter from rcu_gp_in_progress()
>       rcu: Remove rsp parameter from rcu_get_root()
>       rcu: Remove rsp parameter from record_gp_stall_check_time()
>       rcu: Remove rsp parameter from rcu_check_gp_kthread_starvation()
>       rcu: Remove rsp parameter from rcu_dump_cpu_stacks()
>       rcu: Remove rsp parameter from rcu_stall_kick_kthreads()
>       rcu: Remove rsp parameter from print_other_cpu_stall()
>       rcu: Remove rsp parameter from print_cpu_stall()
>       rcu: Remove rsp parameter from check_cpu_stall()
>       rcu: Remove rsp parameter from rcu_future_gp_cleanup()
>       rcu: Remove rsp parameter from rcu_gp_kthread_wake()
>       rcu: Remove rsp parameter from rcu_accelerate_cbs()
>       rcu: Remove rsp parameter from rcu_accelerate_cbs_unlocked()
>       rcu: Remove rsp parameter from rcu_advance_cbs()
>       rcu: Remove rsp parameter from __note_gp_changes()
>       rcu: Remove rsp parameter from note_gp_changes()
>       rcu: Remove rsp parameter from rcu_gp_slow()
>       rcu: Remove rsp parameter from rcu_gp_kthread() and friends
>       rcu: Remove rsp parameter from rcu_check_quiescent_state()
>       rcu: Remove rsp parameter from CPU hotplug functions
>       rcu: Remove rsp parameter from rcu_do_batch()
>       rcu: Remove rsp parameter from force-quiescent-state functions
>       rcu: Remove rsp parameter from rcu_check_gp_start_stall()
>       rcu: Remove rsp parameter from __rcu_process_callbacks()
>       rcu: Remove rsp parameter from __call_rcu() and friend
>       rcu: Remove rsp parameter from __rcu_pending()
>       rcu: Remove rsp parameter from _rcu_barrier() and friends
>       rcu: Remove rsp parameter from rcu_boot_init_percpu_data() and friends
>       rcu: Remove rsp parameter from rcu_init_one() and friends
>       rcu: Remove rsp parameter from rcu_print_detail_task_stall()
>       rcu: Remove rsp parameter from dump_blkd_tasks() and friend
>       rcu: Remove rsp parameter from rcu_spawn_one_boost_kthread()
>       rcu: Remove rsp parameter from print_cpu_stall_info()
>       rcu: Remove rsp parameter from no-CBs CPU functions
>       rcu: Remove rsp parameter from expedited grace-period functions
>       rcu: Remove rsp parameter from rcu_node tree accessor macros
>       rcu: Remove rcu_data structure's ->rsp field
>       rcu: Remove last non-flavor-traversal rsp local variable from tree_plugin.h
>       rcu: Remove for_each_rcu_flavor() flavor-traversal macro
>       rcu: Simplify rcutorture_get_gp_data()
>       rcu: Restructure rcu_check_gp_kthread_starvation()
>       rcu: Eliminate stall-warning use of rsp
>       rcu: Eliminate grace-period management code use of rsp
>       rcu: Eliminate callback-invocation/invocation use of rsp
>       rcu: Eliminate quiescent-state and grace-period-nonstart use of rsp
>       rcu: Eliminate RCU-barrier use of rsp
>       rcu: Eliminate initialization-time use of rsp
>       rcu: Fix typo in force_qs_rnp()'s parameter's parameter
>       rcu: Inline increment_cpu_stall_ticks() into its sole caller
>       rcu: Pull rcu_gp_kthread() FQS loop into separate function
>       rcu: Consolidate RCU-bh update-side function definitions
>       rcu: Consolidate RCU-sched update-side function definitions
>       rcutorture: Add RCU-bh and RCU-sched support for extended readers
>       rcu: Stop testing RCU-bh and RCU-sched
>       rcutorture: Remove the "rcu_bh" and "sched" torture types
>       rcuperf: Remove the "rcu_bh" and "sched" torture types
>       rcu: Remove now-unused rcutorture APIs
>       rcu: Clean up flavor-related definitions and comments in rcupdate.h
>       rcu: Clean up flavor-related definitions and comments in rculist.h
>       rcu: Clean up flavor-related definitions and comments in rcupdate_wait.h
>       rcu: Clean up flavor-related definitions and comments in Kconfig
>       rcu: Clean up flavor-related definitions and comments in rcu.h
>       rcu: Clean up flavor-related definitions and comments in rcutorture.c
>       rcu: Clean up flavor-related definitions and comments in srcutree.h
>       rcu: Clean up flavor-related definitions and comments in tiny.c
>       rcu: Clean up flavor-related definitions and comments in tree.c
>       rcu: Clean up flavor-related definitions and comments in tree_exp.h
>       rcu: Clean up flavor-related definitions and comments in tree_plugin.h
>       rcu: Clean up flavor-related definitions and comments in update.c
>       rcu: Remove !PREEMPT code from rcu_note_voluntary_context_switch()
>       rcu: Define rcu_all_qs() only in !PREEMPT builds
>       rcu: Inline _rcu_barrier() into its sole remaining caller
>       rcu: Make need_resched() respond to urgent RCU-QS needs
>       rcu: Provide improved interrupt-from-idle check in rcu_check_callbacks()
>       rcutorture: Dump reader protection sequence if failures or close calls
>       rcu: Motivate Tiny RCU forward progress
>       rcu: Eliminate ->rcu_qs_ctr from the rcu_dynticks structure
>       rcu: Provide functions for determining if call_rcu() has been invoked
>       rcu: Compute jiffies_till_sched_qs from other kernel parameters
>       rcu: More aggressively enlist scheduler aid for nohz_full CPUs
>       rcu: Avoid resched_cpu() when rescheduling the current CPU
>       rcu: Convert "1UL << x" to "BIT(x)"
>       rcu: Remove unused rcu_dynticks_snap() from Tiny RCU
>       rcu: Merge rcu_dynticks structure into rcu_data structure
>       rcu: Switch ->tick_nohz_enabled_snap to rcu_data structure
>       rcu: Switch last accelerate/advance to rcu_data structure
>       rcu: Switch lazy counts to rcu_data structure
>       rcu: Switch urgent quiescent-state requests to rcu_data structure
>       rcu: Switch dyntick nesting counters to rcu_data structure
>       rcu: Switch ->dynticks to rcu_data structure, remove rcu_dynticks
>       rcu: Remove obsolete ->dynticks_fqs and ->cond_resched_completed
>       srcu: Make call_srcu() available during very early boot
>       rcutorture: Test early boot call_srcu()
>       srcu: Make early-boot call_srcu() reuse workqueue lists
>       Merge branches 'doc.2018.08.30a', 'dynticks.2018.08.30b', 'srcu.2018.08.30b' and 'torture.2018.08.29a' into HEAD
> 
>  .../Design/Data-Structures/Data-Structures.html    |   31 +-
>  .../Expedited-Grace-Periods.html                   |    9 +-
>  .../RCU/Design/Requirements/Requirements.html      |  214 +-
>  Documentation/RCU/stallwarn.txt                    |   13 +-
>  Documentation/RCU/whatisRCU.txt                    |    3 +-
>  Documentation/admin-guide/kernel-parameters.txt    |   31 +-
>  Documentation/kernel-per-CPU-kthreads.txt          |    2 +-
>  include/linux/rculist.h                            |   32 +-
>  include/linux/rcupdate.h                           |  154 +-
>  include/linux/rcupdate_wait.h                      |   14 +-
>  include/linux/rcutiny.h                            |   53 +-
>  include/linux/rcutree.h                            |   31 +-
>  include/linux/sched.h                              |    6 +-
>  include/linux/srcutree.h                           |   13 +-
>  include/linux/torture.h                            |    2 +-
>  include/trace/events/rcu.h                         |   25 +-
>  kernel/rcu/Kconfig                                 |   14 +-
>  kernel/rcu/rcu.h                                   |   67 +-
>  kernel/rcu/rcuperf.c                               |   66 +-
>  kernel/rcu/rcutorture.c                            |  397 ++--
>  kernel/rcu/srcutiny.c                              |   29 +-
>  kernel/rcu/srcutree.c                              |   31 +-
>  kernel/rcu/tiny.c                                  |  154 +-
>  kernel/rcu/tree.c                                  | 2213 ++++++++------------
>  kernel/rcu/tree.h                                  |  132 +-
>  kernel/rcu/tree_exp.h                              |  426 ++--
>  kernel/rcu/tree_plugin.h                           |  790 +++----
>  kernel/rcu/update.c                                |   70 +-
>  kernel/softirq.c                                   |    3 +-
>  kernel/torture.c                                   |    3 +-
>  .../selftests/rcutorture/bin/kvm-test-1-run.sh     |    1 -
>  .../selftests/rcutorture/configs/rcu/CFLIST        |    2 -
>  .../selftests/rcutorture/configs/rcu/SRCU-P.boot   |    1 +
>  .../selftests/rcutorture/configs/rcu/SRCU-u.boot   |    1 +
>  .../selftests/rcutorture/configs/rcu/TINY02.boot   |    2 -
>  .../selftests/rcutorture/configs/rcu/TREE01.boot   |    2 +-
>  .../selftests/rcutorture/configs/rcu/TREE04.boot   |    2 +-
>  .../selftests/rcutorture/configs/rcu/TREE05.boot   |    3 +-
>  .../selftests/rcutorture/configs/rcu/TREE06.boot   |    2 -
>  .../selftests/rcutorture/configs/rcu/TREE08.boot   |    2 -
>  40 files changed, 2294 insertions(+), 2752 deletions(-)

Pulled into tip:core/rcu, thanks a lot Paul!

The code and complexity reduction from the consolidation of the RCU models is pretty 
impressive IMO! :-)

	Ingo
