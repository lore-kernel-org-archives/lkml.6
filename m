Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054C4C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6972075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQeO6sI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6972075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeJWSKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:10:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39281 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWSKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:10:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so1055852wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cFpxQjmWzqVTJTS0ZAd6LbZhLsOWxiVd6XsYy6oRE3s=;
        b=DQeO6sI3OdpasDFHKpzMego4FBP53RdhFNGKkanZDSAkPU6jEtcuUjYFwdTzy+H4yd
         nk7skAEc7i0BLzyJxJ66p8G/8LvhazrOGv7LMJabSGA705WVXpom+3VS3kGtXKIE481n
         OBBbJNCF2WfnrHthdMVIcpKEYD1rwBYt4OgcTHpx471AP4slm4YdCy3cZFEBYfHI5Za1
         dIC8BrjBYea4PFlXlXZtYke4ExupL3jPgUy4m4N5/lg0yUXPj//FJrj71nFyoh5j81Ab
         ksWeYuHONlMcH3kKL1zcFqlip9W/Ol9Cr+WVB97AoEo3BG3X6dxA3InzBuagZFDltKok
         pAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=cFpxQjmWzqVTJTS0ZAd6LbZhLsOWxiVd6XsYy6oRE3s=;
        b=RXiTYMilde9FQ+WrbWchgkEn6kb/vd2eVxdEw0HSLNiJ/JXP7HvmTcqChHwnalXrMR
         ZKsjknAyzge6tOaXmVHaxc5Jh8VhPmhkxky7IfSLhwagiZzU9pQx3xtuLON55A6+pIBC
         NnlTDCMGJVo5XiqV3wPUVF67LVoJszQa7ZBdIlK3HU7p0nMX6EuAWROqVq2PoKpxLREe
         +tR4bgYzZaGM6xOwCesMMEG5H/2J2k3N6sfBmUxwYSOzLFTUioaNVqzF3LR19qcZA0OL
         E5NLkIfJNpRy6wDMC8Y11xDFBDWlXRLpUmJqpcx/409fN6x+dl1uRSTTmhLUX+vFC+J/
         U4ng==
X-Gm-Message-State: ABuFfojjj6iYi3nNq50xILUbI2eEvdLmxSdaUP18Aw4zy0BStPCLspFO
        VUGg3abVQURFf+eqfKwORT8=
X-Google-Smtp-Source: ACcGV60biObxRysV9YridTc0jh/6EHaCPgQjzD7nrMkZanc0/SQEoWpIlvSxeNx3gRbPfwcsJ8K07g==
X-Received: by 2002:a1c:7ed4:: with SMTP id z203-v6mr19127597wmc.62.1540288083646;
        Tue, 23 Oct 2018 02:48:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i6-v6sm1603790wrq.4.2018.10.23.02.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 02:48:02 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:48:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RCU updates for v4.20
Message-ID: <20181023094800.GA75275@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-rcu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

   # HEAD: d0346559a7c358a5328e1fa43135acc548c0f224 Merge branch 'for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

The biggest change in this cycle is the conclusion of the big
"simplify RCU to two primary flavors" consolidation work - i.e.
there's a single RCU flavor for any kernel variant (PREEMPT and 
!PREEMPT):

    - Consolidate the RCU-bh, RCU-preempt, and RCU-sched flavors into
      a single flavor similar to RCU-sched in !PREEMPT kernels and
      into a single flavor similar to RCU-preempt (but also waiting
      on preempt-disabled sequences of code) in PREEMPT kernels.  This
      branch also includes a refactoring of rcu_{nmi,irq}_{enter,exit}()
      from Byungchul Park.
    
    - Now that there is only one RCU flavor in any given running kernel,
      the many "rsp" pointers are no longer required, and this cleanup
      series removes them.
    
    - This branch carries out additional cleanups made possible by
      the RCU flavor consolidation, including inlining how-trivial
      functions, updating comments and definitions, and removing
      now-unneeded rcutorture scenarios.
    
    - Now that there is only one flavor of RCU in any running kernel,
      there is also only on rcu_data structure per CPU.  This means
      that the rcu_dynticks structure can be merged into the rcu_data
      structure, a task taken on by this branch.  This branch also
      contains a -rt-related fix from Mike Galbraith.

There were also other updates:

    - Documentation updates, including some good-eye catches from
      Joel Fernandes.
    
    - SRCU updates, most notably changes enabling call_srcu() to be
      invoked very early in the boot sequence.
    
    - Torture-test updates, including some preliminary work towards
      making rcutorture better able to find problems that result in
      insufficient grace-period forward progress.
    
    - Initial changes to RCU to better promote forward progress of
      grace periods, including fixing a bug found by Marius Hillenbrand
      and David Woodhouse, with the fix suggested by Peter Zijlstra.
    
 Thanks,

	Ingo

------------------>
Byungchul Park (1):
      rcu: Refactor rcu_{nmi,irq}_{enter,exit}()

Joel Fernandes (Google) (2):
      doc: Fix broken RCU-requirements link to LKML archive
      doc: Improve rcu_dynticks::dynticks documentation

Mike Galbraith (1):
      rcu: Convert rcu_state.ofl_lock to raw_spinlock_t

Paul E. McKenney (136):
      doc: Add design documentation on interruption of NMI handlers
      torture: Stop overwriting Make.out file with obsolete version
      rcutorture: Force occasional reader waits
      rcutorture: Warn on bad torture type for built-in tests
      rcuperf: Warn on bad perf type for built-in tests
      rcutorture: Remove TREE06 and TREE08 from the default test list
      rcutorture: Add forward-progress tests for RCU grace periods
      rcutorture: Also use GP sequence to judge forward progress
      rcutorture: Avoid no-test complaint if too few forward-progress tries
      rcutorture: Vary forward-progress test interval
      rcutorture: Add self-propagating callback to forward-progress testing
      rcutorture: Increase rcu_read_delay() longdelay_ms
      rcutorture: Limit reader duration if irq or bh disabled
      rcutorture: Reduce priority of forward-progress testing
      rcutorture: Adjust number of reader kthreads per CPU-hotplug operations
      rcutorture: Print forward-progress test interval on error
      rcutorture: Check GP completion at stutter end
      rcutorture: Maintain self-propagating CB only during forward-progress test
      doc: Update removal of RCU-bh/sched update machinery
      doc: Fix broken HTML directive
      rcu: Defer reporting RCU-preempt quiescent states when disabled
      rcutorture: Test extended "rcu" read-side critical sections
      rcu: Allow processing deferred QSes for exiting RCU-preempt readers
      rcu: Remove now-unused ->b.exp_need_qs field from the rcu_special union
      rcu: Add warning to detect half-interrupts
      rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt when safe
      rcu: Report expedited grace periods at context-switch time
      rcu: Define RCU-bh update API in terms of RCU
      rcu: Update comments and help text for no more RCU-bh updaters
      rcu: Drop "wake" parameter from rcu_report_exp_rdp()
      rcu: Fix typo in rcu_get_gp_kthreads_prio() header comment
      rcu: Define RCU-sched API in terms of RCU for Tree RCU PREEMPT builds
      rcu: Express Tiny RCU updates in terms of RCU rather than RCU-sched
      rcu: Remove RCU_STATE_INITIALIZER()
      rcu: Eliminate rcu_state structure's ->call field
      rcu: Remove rcu_state structure's ->rda field
      rcu: Remove rcu_state_p pointer to default rcu_state structure
      rcu: Remove rcu_data_p pointer to default rcu_data structure
      rcu: Remove rsp parameter from rcu_report_qs_rnp()
      rcu: Remove rsp parameter from rcu_report_qs_rsp()
      rcu: Remove rsp parameter from rcu_report_unblock_qs_rnp()
      rcu: Remove rsp parameter from rcu_report_qs_rdp()
      rcu: Remove rsp parameter from rcu_gp_in_progress()
      rcu: Remove rsp parameter from rcu_get_root()
      rcu: Remove rsp parameter from record_gp_stall_check_time()
      rcu: Remove rsp parameter from rcu_check_gp_kthread_starvation()
      rcu: Remove rsp parameter from rcu_dump_cpu_stacks()
      rcu: Remove rsp parameter from rcu_stall_kick_kthreads()
      rcu: Remove rsp parameter from print_other_cpu_stall()
      rcu: Remove rsp parameter from print_cpu_stall()
      rcu: Remove rsp parameter from check_cpu_stall()
      rcu: Remove rsp parameter from rcu_future_gp_cleanup()
      rcu: Remove rsp parameter from rcu_gp_kthread_wake()
      rcu: Remove rsp parameter from rcu_accelerate_cbs()
      rcu: Remove rsp parameter from rcu_accelerate_cbs_unlocked()
      rcu: Remove rsp parameter from rcu_advance_cbs()
      rcu: Remove rsp parameter from __note_gp_changes()
      rcu: Remove rsp parameter from note_gp_changes()
      rcu: Remove rsp parameter from rcu_gp_slow()
      rcu: Remove rsp parameter from rcu_gp_kthread() and friends
      rcu: Remove rsp parameter from rcu_check_quiescent_state()
      rcu: Remove rsp parameter from CPU hotplug functions
      rcu: Remove rsp parameter from rcu_do_batch()
      rcu: Remove rsp parameter from force-quiescent-state functions
      rcu: Remove rsp parameter from rcu_check_gp_start_stall()
      rcu: Remove rsp parameter from __rcu_process_callbacks()
      rcu: Remove rsp parameter from __call_rcu() and friend
      rcu: Remove rsp parameter from __rcu_pending()
      rcu: Remove rsp parameter from _rcu_barrier() and friends
      rcu: Remove rsp parameter from rcu_boot_init_percpu_data() and friends
      rcu: Remove rsp parameter from rcu_init_one() and friends
      rcu: Remove rsp parameter from rcu_print_detail_task_stall()
      rcu: Remove rsp parameter from dump_blkd_tasks() and friend
      rcu: Remove rsp parameter from rcu_spawn_one_boost_kthread()
      rcu: Remove rsp parameter from print_cpu_stall_info()
      rcu: Remove rsp parameter from no-CBs CPU functions
      rcu: Remove rsp parameter from expedited grace-period functions
      rcu: Remove rsp parameter from rcu_node tree accessor macros
      rcu: Remove rcu_data structure's ->rsp field
      rcu: Remove last non-flavor-traversal rsp local variable from tree_plugin.h
      rcu: Remove for_each_rcu_flavor() flavor-traversal macro
      rcu: Simplify rcutorture_get_gp_data()
      rcu: Restructure rcu_check_gp_kthread_starvation()
      rcu: Eliminate stall-warning use of rsp
      rcu: Eliminate grace-period management code use of rsp
      rcu: Eliminate callback-invocation/invocation use of rsp
      rcu: Eliminate quiescent-state and grace-period-nonstart use of rsp
      rcu: Eliminate RCU-barrier use of rsp
      rcu: Eliminate initialization-time use of rsp
      rcu: Fix typo in force_qs_rnp()'s parameter's parameter
      rcu: Inline increment_cpu_stall_ticks() into its sole caller
      rcu: Pull rcu_gp_kthread() FQS loop into separate function
      rcu: Consolidate RCU-bh update-side function definitions
      rcu: Consolidate RCU-sched update-side function definitions
      rcutorture: Add RCU-bh and RCU-sched support for extended readers
      rcu: Stop testing RCU-bh and RCU-sched
      rcutorture: Remove the "rcu_bh" and "sched" torture types
      rcuperf: Remove the "rcu_bh" and "sched" torture types
      rcu: Remove now-unused rcutorture APIs
      rcu: Clean up flavor-related definitions and comments in rcupdate.h
      rcu: Clean up flavor-related definitions and comments in rculist.h
      rcu: Clean up flavor-related definitions and comments in rcupdate_wait.h
      rcu: Clean up flavor-related definitions and comments in Kconfig
      rcu: Clean up flavor-related definitions and comments in rcu.h
      rcu: Clean up flavor-related definitions and comments in rcutorture.c
      rcu: Clean up flavor-related definitions and comments in srcutree.h
      rcu: Clean up flavor-related definitions and comments in tiny.c
      rcu: Clean up flavor-related definitions and comments in tree.c
      rcu: Clean up flavor-related definitions and comments in tree_exp.h
      rcu: Clean up flavor-related definitions and comments in tree_plugin.h
      rcu: Clean up flavor-related definitions and comments in update.c
      rcu: Remove !PREEMPT code from rcu_note_voluntary_context_switch()
      rcu: Define rcu_all_qs() only in !PREEMPT builds
      rcu: Inline _rcu_barrier() into its sole remaining caller
      rcu: Make need_resched() respond to urgent RCU-QS needs
      rcu: Provide improved interrupt-from-idle check in rcu_check_callbacks()
      rcutorture: Dump reader protection sequence if failures or close calls
      rcu: Motivate Tiny RCU forward progress
      rcu: Eliminate ->rcu_qs_ctr from the rcu_dynticks structure
      rcu: Provide functions for determining if call_rcu() has been invoked
      rcu: Compute jiffies_till_sched_qs from other kernel parameters
      rcu: More aggressively enlist scheduler aid for nohz_full CPUs
      rcu: Avoid resched_cpu() when rescheduling the current CPU
      rcu: Convert "1UL << x" to "BIT(x)"
      rcu: Remove unused rcu_dynticks_snap() from Tiny RCU
      rcu: Merge rcu_dynticks structure into rcu_data structure
      rcu: Switch ->tick_nohz_enabled_snap to rcu_data structure
      rcu: Switch last accelerate/advance to rcu_data structure
      rcu: Switch lazy counts to rcu_data structure
      rcu: Switch urgent quiescent-state requests to rcu_data structure
      rcu: Switch dyntick nesting counters to rcu_data structure
      rcu: Switch ->dynticks to rcu_data structure, remove rcu_dynticks
      rcu: Remove obsolete ->dynticks_fqs and ->cond_resched_completed
      srcu: Make call_srcu() available during very early boot
      rcutorture: Test early boot call_srcu()
      srcu: Make early-boot call_srcu() reuse workqueue lists


 .../Design/Data-Structures/Data-Structures.html    |   31 +-
 .../Expedited-Grace-Periods.html                   |    9 +-
 .../RCU/Design/Requirements/Requirements.html      |  214 +-
 Documentation/RCU/stallwarn.txt                    |   13 +-
 Documentation/RCU/whatisRCU.txt                    |    3 +-
 Documentation/admin-guide/kernel-parameters.txt    |   31 +-
 Documentation/kernel-per-CPU-kthreads.txt          |    2 +-
 include/linux/rculist.h                            |   32 +-
 include/linux/rcupdate.h                           |  154 +-
 include/linux/rcupdate_wait.h                      |   14 +-
 include/linux/rcutiny.h                            |   53 +-
 include/linux/rcutree.h                            |   31 +-
 include/linux/sched.h                              |    6 +-
 include/linux/srcutree.h                           |   13 +-
 include/linux/torture.h                            |    2 +-
 include/trace/events/rcu.h                         |   25 +-
 kernel/rcu/Kconfig                                 |   14 +-
 kernel/rcu/rcu.h                                   |   67 +-
 kernel/rcu/rcuperf.c                               |   66 +-
 kernel/rcu/rcutorture.c                            |  397 ++--
 kernel/rcu/srcutiny.c                              |   29 +-
 kernel/rcu/srcutree.c                              |   31 +-
 kernel/rcu/tiny.c                                  |  154 +-
 kernel/rcu/tree.c                                  | 2213 ++++++++------------
 kernel/rcu/tree.h                                  |  132 +-
 kernel/rcu/tree_exp.h                              |  426 ++--
 kernel/rcu/tree_plugin.h                           |  790 +++----
 kernel/rcu/update.c                                |   70 +-
 kernel/softirq.c                                   |    3 +-
 kernel/torture.c                                   |    3 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |    1 -
 .../selftests/rcutorture/configs/rcu/CFLIST        |    2 -
 .../selftests/rcutorture/configs/rcu/SRCU-P.boot   |    1 +
 .../selftests/rcutorture/configs/rcu/SRCU-u.boot   |    1 +
 .../selftests/rcutorture/configs/rcu/TINY02.boot   |    2 -
 .../selftests/rcutorture/configs/rcu/TREE01.boot   |    2 +-
 .../selftests/rcutorture/configs/rcu/TREE04.boot   |    2 +-
 .../selftests/rcutorture/configs/rcu/TREE05.boot   |    3 +-
 .../selftests/rcutorture/configs/rcu/TREE06.boot   |    2 -
 .../selftests/rcutorture/configs/rcu/TREE08.boot   |    2 -
 40 files changed, 2294 insertions(+), 2752 deletions(-)

