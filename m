Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2319CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D66222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550043580;
	bh=dcd/3gjz+JIiqIJPhYxUfsPbsFKkCGZ+I5n0Wx3OPBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ic3dQS227pktsTI2yg++pi05NAjJBlOmwyObiaGDbZchVdDO5XybsXGqdY/z8/Abj
	 PLDRIkKOGds6MiJRRW43QYFg2o+fr40K65CBdyWViYkhIB0II7TbSRJPdq9/uaLHD/
	 X/kUgwabJYxPcZZoaeqZR8FD/Uwrue4VoJdZY0hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbfBMHji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:39:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42447 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfBMHjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:39:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so1270281wrx.9;
        Tue, 12 Feb 2019 23:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tTROI4kdvUJB9sdekENMO+AddhvOJA+Ke4ICmN3umI0=;
        b=myAtznFQ8Q9zyOrCe/Ggs4naahUSWwS1Pa3pCyHRE1Em/nYe2Lkx2f9DZYus8/pN+e
         ledXRpkyv4lRyYW1rMqkXLcNr5YIR8jmXt5dSRp8Or5Ueb/oVPAnZIMU65rRUB8UGfAW
         Xh88KyRldjNCPGbUohNNYeToRJShOzLBDsIiHM77SooFF6Hnb0W6is6g2SUWOgqfoLnt
         Hx8zdT4S4wcUAZNI2r3O8eBR5d4nSvCaBwvKeaAFkJ8PXN7VNAHQcdlx4aAMqhXbSWwY
         mUA+BIOyHtrLxH1+V2wM4oiWiNGShPxOQf1vrbayEfhFUbDl4eBeWGmN+uUBt5RFyVE9
         qggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tTROI4kdvUJB9sdekENMO+AddhvOJA+Ke4ICmN3umI0=;
        b=CIEaC0YAKHwHrL8gipHgsH94iUwqVSorsdQVqFvz7yUJV4X7YA5VWI3cd6IlS6Ak7G
         7hbYrctNfIojeDcFvTFbt8BfyB+W4bRazbHYjXPelBERgOGJMqe1nqTOCCFeMyN2L8qb
         EueIjE34dm6/Dt7MbDfHDuixtREi1qti8bSABnM+2k8rVzIoHQZWpiWbSL94/fYxEiDe
         z2Yi/KMArXUyXze+MvBvqdRHsigS/MOC4mJxCShNOGrUaug1cAQnPxw37LJrndtvrM+K
         da2Fvxtm3EV7UFFnb7+hZ/KJZi2bfGmXCcyRUHUityVGCS1lMriBjLoUbEpHhC84YpkH
         L3iw==
X-Gm-Message-State: AHQUAuZQSqCe4LZPI4L0R7SUSbaSB5CTEJWX7eZpwDlzPyGwg+iSYF1L
        +AmFSqT9YYgN/InUZnCv2Jc=
X-Google-Smtp-Source: AHgI3Ib1JW/1dyHCyHYZPZCYh1Li0ZiFdlCv+oeSijnqIHOvWs9K3+O18h36a1KpgxQ8fg6gqVUM3w==
X-Received: by 2002:a5d:6b05:: with SMTP id v5mr6403161wrw.76.1550043574887;
        Tue, 12 Feb 2019 23:39:34 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i10sm21605614wrx.54.2019.02.12.23.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:39:33 -0800 (PST)
Date:   Wed, 13 Feb 2019 08:39:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jun.zhang@intel.com, junchangwang@gmail.com,
        joel@joelfernandes.org, bigeasy@linutronix.de, w@1wt.eu
Subject: Re: [GIT PULL rcu/next] RCU commits for 5.1
Message-ID: <20190213073931.GA62549@gmail.com>
References: <20190211201208.GA30732@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211201208.GA30732@linux.ibm.com>
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
> 1.	Additional cleanups after RCU flavor consolidation.
> 
> 	http://lkml.kernel.org/r/20190109211830.GA30595@linux.ibm.com
> 
> 2.	Grace-period forward-progress cleanups and improvements.
> 
> 	http://lkml.kernel.org/r/20190109212816.GA32282@linux.ibm.com
> 
> 3.	Documentation updates.
> 
> 	http://lkml.kernel.org/r/20190109213302.GA1723@linux.ibm.com
> 
> 4.	Miscellaneous fixes.
> 
> 	http://lkml.kernel.org/r/20190109214115.GA2835@linux.ibm.com
> 
> 5.	spin_is_locked() conversions to lockdep.
> 
> 	http://lkml.kernel.org/r/20190109222120.GA13904@linux.ibm.com
> 
> 6.	SPDX changes to RCU source and header files.
> 
> 	http://lkml.kernel.org/r/20190207141700.GA11106@linux.ibm.com
> 
> 7.	SRCU updates.
> 
> 	http://lkml.kernel.org/r/20190109214506.GA4747@linux.ibm.com
> 
> 8.	Torture-test updates, including nolibc updates and moving
> 	nolibc to tools/include.
> 
> 	http://lkml.kernel.org/r/20190109214944.GA5610@linux.ibm.com
> 
> All of these changes have been subjected to 0day Test Robot and -next
> testing, and are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git e7ffb4eb9a6d89678e7f62461737899f88dab64e
> 
> for you to fetch changes up to e7ffb4eb9a6d89678e7f62461737899f88dab64e:
> 
>   Merge branches 'doc.2019.01.26a', 'fixes.2019.01.26a', 'sil.2019.01.26a', 'spdx.2019.02.09a', 'srcu.2019.01.26a' and 'torture.2019.01.26a' into HEAD (2019-02-09 08:47:52 -0800)
> 
> Note that the diffstat output omits the addition of tree_stall.h, so is
> overly optimistic.  :-/
> 
> ----------------------------------------------------------------
> Joel Fernandes (Google) (1):
>       rcu: Add sparse check to rcu_assign_pointer()
> 
> Junchang Wang (2):
>       doc: Fix outdated links
>       RCU/torture.txt: Remove section MODULE PARAMETERS
> 
> Paul E. McKenney (59):
>       sched: Replace call_rcu_sched() with call_rcu()
>       sched: Replace synchronize_sched() with synchronize_rcu()
>       rcu: Rename and comment changes due to only one rcuo kthread per CPU
>       rcu: Make expedited IPI handler return after handling critical section
>       rcu: Inline force_quiescent_state() into rcu_force_quiescent_state()
>       rcu: Eliminate RCU_BH_FLAVOR and RCU_SCHED_FLAVOR
>       rcu: Inline rcu_kthread_do_work() into its sole remaining caller
>       rcu: Determine expedited-GP IPI handler at build time
>       rcu: Consolidate PREEMPT and !PREEMPT synchronize_rcu_expedited()
>       rcu: Consolidate PREEMPT and !PREEMPT synchronize_rcu()
>       rcu: Inline _synchronize_rcu_expedited() into synchronize_rcu_expedited()
>       rcu: Discard separate per-CPU callback counts
>       rcu: Remove wrapper definitions for obsolete RCU update functions
>       rcu: Accommodate zero jiffies_till_first_fqs and kthread kicking
>       rcu: Move rcu_cpu_kthread_task to rcu_data structure
>       rcu: Move rcu_cpu_kthread_status to rcu_data structure
>       rcu: Remove unused rcu_cpu_kthread_loops per-CPU variable
>       rcu: Move rcu_cpu_has_work to rcu_data structure
>       rcu: Remove unused rcu_cpu_kthread_cpu per-CPU variable
>       rcu: Update NOCB comments
>       rcu: Improve diagnostics for failed RCU grace-period start
>       rcu: Protect rcu_check_gp_kthread_starvation() access to ->gp_flags
>       rcu: Add sysrq rcu_node-dump capability
>       Merge branches 'consolidate.2019.01.26a' and 'fwd.2019.01.26a' into HEAD
>       doc: Now jiffies_till_sched_qs solicits help from cond_resched()
>       doc: CPU-hotplug notifiers cannot invoke synchronize_srcu() or srcu_barrier()
>       rcu: Docbook for rcu_head_init() and rcu_head_after_call_rcu()
>       rcu: Rename rcu_check_callbacks() to rcu_sched_clock_irq()
>       rcu: Rename rcu_process_callbacks() to rcu_core() for Tree RCU
>       rcu: Remove preemption disabling from expedited CPU selection
>       rcu: Repair rcu_nmi_exit() docbook header
>       rcu: Fix obsolete DYNTICK_IRQ_NONIDLE comment
>       include/asm-generic: Remove spin_is_locked() comment
>       virt/kvm: Replace spin_is_locked() with lockdep
>       srcu: Check for invalid idx argument in srcu_read_unlock()
>       rcutorture: Record grace periods in forward-progress histogram
>       torture: Explain and simplify odd "for" loop in mkinitrd.sh
>       rcutorture: Add grace period after CPU offline
>       rcuperf: Stop abusing IS_ENABLED()
>       rcu/rcu.h: Convert to SPDX license identifier
>       rcu/rcuperf: Convert to SPDX license identifier
>       rcu/rcu_segcblist: Convert to SPDX license identifier
>       rcu/rcutorture: Convert to SPDX license identifier
>       rcu/srcu: Convert to SPDX license identifier
>       rcu/sync: Convert to SPDX license identifier
>       rcu/tiny: Convert to SPDX license identifier
>       rcu/tree: Convert to SPDX license identifier
>       rcu/update: Convert to SPDX license identifier
>       linux/rcu_node_tree: Convert to SPDX license identifier
>       linux/rcupdate: Convert to SPDX license identifier
>       linux/rcu_segcblist: Convert to SPDX license identifier
>       linux/rcu_sync: Convert to SPDX license identifier
>       linux/rcutiny: Convert to SPDX license identifier
>       linux/rcutree: Convert to SPDX license identifier
>       linux/srcu: Convert to SPDX license identifier
>       torture: Convert to SPDX license identifier
>       linux/torture: Convert to SPDX license identifier
>       locking/locktorture: Convert to SPDX license identifier
>       Merge branches 'doc.2019.01.26a', 'fixes.2019.01.26a', 'sil.2019.01.26a', 'spdx.2019.02.09a', 'srcu.2019.01.26a' and 'torture.2019.01.26a' into HEAD
> 
> Sebastian Andrzej Siewior (1):
>       srcu: Remove srcu_queue_delayed_work_on()
> 
> Willy Tarreau (5):
>       rcutorture/nolibc: Fix the clobbered registers in the MIPS syscall definition
>       rcutorture/nolibc: Fix some poor indentation and alignment
>       rcutorture/nolibc: Add a bit of documentation to explain how to use nolibc
>       tools headers: Move the nolibc header from rcutorture to tools/include/nolibc/
>       MAINTAINERS: Add myself as the maintainer for the nolibc header file(s)
> 
> Zhang, Jun (2):
>       rcu: Do RCU GP kthread self-wakeup from softirq and interrupt
>       rcu: Prevent needless ->gp_seq_needed update in __note_gp_changes()
> 
>  .../Expedited-Grace-Periods/ExpSchedFlow.svg       |  18 +-
>  .../Expedited-Grace-Periods.html                   |  26 +-
>  .../Memory-Ordering/Tree-RCU-Memory-Ordering.html  |   6 +-
>  .../TreeRCU-callback-invocation.svg                |   2 +-
>  .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |   8 +-
>  .../RCU/Design/Memory-Ordering/TreeRCU-qs.svg      |   6 +-
>  .../RCU/Design/Requirements/Requirements.html      |  20 +-
>  Documentation/RCU/stallwarn.txt                    |  15 +-
>  Documentation/RCU/torture.txt                      | 169 +------------
>  Documentation/RCU/whatisRCU.txt                    |   4 +-
>  Documentation/admin-guide/kernel-parameters.txt    |  32 ++-
>  MAINTAINERS                                        |   6 +
>  include/asm-generic/bug.h                          |   3 -
>  include/linux/rcu_node_tree.h                      |  17 +-
>  include/linux/rcu_segcblist.h                      |  17 +-
>  include/linux/rcu_sync.h                           |  15 +-
>  include/linux/rcupdate.h                           |  91 +------
>  include/linux/rcutiny.h                            |  17 +-
>  include/linux/rcutree.h                            |  19 +-
>  include/linux/srcu.h                               |  18 +-
>  include/linux/srcutiny.h                           |  17 +-
>  include/linux/srcutree.h                           |  20 +-
>  include/linux/torture.h                            |  20 +-
>  kernel/locking/locktorture.c                       |  21 +-
>  kernel/rcu/rcu.h                                   |  21 +-
>  kernel/rcu/rcu_segcblist.c                         |  17 +-
>  kernel/rcu/rcu_segcblist.h                         |  17 +-
>  kernel/rcu/rcuperf.c                               |  27 +--
>  kernel/rcu/rcutorture.c                            |  59 +++--
>  kernel/rcu/srcutiny.c                              |  17 +-
>  kernel/rcu/srcutree.c                              |  72 ++----
>  kernel/rcu/sync.c                                  |  15 +-
>  kernel/rcu/tiny.c                                  |  19 +-
>  kernel/rcu/tree.c                                  | 267 +++++++++++++--------
>  kernel/rcu/tree.h                                  |  53 ++--
>  kernel/rcu/tree_exp.h                              | 201 ++++++----------
>  kernel/rcu/tree_plugin.h                           | 238 +++++-------------
>  kernel/rcu/update.c                                |  17 +-
>  kernel/sched/cpufreq.c                             |   4 +-
>  kernel/sched/cpufreq_schedutil.c                   |   2 +-
>  kernel/sched/sched.h                               |   2 +-
>  kernel/sched/topology.c                            |   4 +-
>  kernel/time/timer.c                                |   2 +-
>  kernel/torture.c                                   |  25 +-
>  .../rcutorture/bin => include/nolibc}/nolibc.h     | 118 +++++++--
>  tools/testing/selftests/rcutorture/bin/mkinitrd.sh |  27 ++-
>  virt/kvm/kvm_main.c                                |   2 +-
>  47 files changed, 640 insertions(+), 1173 deletions(-)
>  rename tools/{testing/selftests/rcutorture/bin => include/nolibc}/nolibc.h (94%)

Pulled, thanks a lot Paul!

	Ingo
