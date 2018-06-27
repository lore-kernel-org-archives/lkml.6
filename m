Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225DCC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95EF23C1F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95EF23C1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeF0IuB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:50:01 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:45090 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753296AbeF0It5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:49:57 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 6A9921C2707
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:49:56 +0100 (IST)
Received: (qmail 6149 invoked from network); 27 Jun 2018 08:49:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 27 Jun 2018 08:49:55 -0000
Date:   Wed, 27 Jun 2018 09:49:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "kkolakow@redhat.com" <kkolakow@redhat.com>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180627084954.73ucqvac62v5gje4@techsingularity.net>
References: <CAE4VaGBtasbDBoZ-c5R-AY++Y1BXgjrE7DwN0zOt113xmV95xw@mail.gmail.com>
 <20180615135212.wq45co7ootvdeo2f@techsingularity.net>
 <CAE4VaGAdXNYXMUn4eQgMqQtLKfp6-YHMa1NUSpL-L078oX7C-w@mail.gmail.com>
 <CAE4VaGBeTpxd1phR4rVAjqOXuLgLWPtVMPoRSOcG3HXfWDF=8w@mail.gmail.com>
 <20180619151803.bu6pehdu6wbd6l5x@techsingularity.net>
 <CAE4VaGAPOfy0RtQehKoe+443C1GRrJXCveBFgcAZ1nChVavp1g@mail.gmail.com>
 <CAE4VaGBMeL82SJK53gtcWkor-9eXeLX6VP9juw=FW=BOyp+hMA@mail.gmail.com>
 <20180621092331.p2pmaiu6563kp5u2@techsingularity.net>
 <CAE4VaGCQV+cS-vhdLyMwzftbB-xBHPt4Y4chg_0ykLHTE9cRfw@mail.gmail.com>
 <CAE4VaGDHcZbnDpJ+FiQLfA1DRftY0j_GJSnh3FDRi34OztVH6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGDHcZbnDpJ+FiQLfA1DRftY0j_GJSnh3FDRi34OztVH6Q@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:18:37AM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we have results for the "Fixes for sched/numa_balancing" series and overall
> it looks very promising.
> 
> We see improvements in the range 15-20% for the stream benchmark and
> upto 60% for the OpenMP NAS benchmark. While NAS results are noisy (have
> quite big variations)  we see improvements on a wide range of 2 and 4 NUMA
> systems.  More importantly, we don't see any regressions. I have posted
> screenshots of the median differences on 4 NUMA servers for NAS benchmark
> with
> 
> 4x Gold 6126 CPU @ 2.60GHz
> 4x E5-4627 v2 @ 3.30GHz
> 
> to illustrate the typical results.
> 
> How are things looking at your side?
> 

I saw similar results in that it was a general win. I'm also trialing
the following monolithic patch on top if you want to try it. The timing
of this will depend on when/if numa_blancing fixes get picked up and I'm
still waiting on test results to come through. Unfortunately, on Friday,
I'll be unavailable for two weeks so this may drag on a bit.  The expanded
set of patches is at

git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git sched-numa-fast-crossnode-v1r12

If the results are positive, I'll update the series and post it as a
RFC. Monolithic patch on top of fixes for sched/numa_balancing is as follows.

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0dbe1d5bb936..eea5f82ca447 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -669,11 +669,6 @@ typedef struct pglist_data {
 	struct task_struct *kcompactd;
 #endif
 #ifdef CONFIG_NUMA_BALANCING
-	/* Rate limiting time interval */
-	unsigned long numabalancing_migrate_next_window;
-
-	/* Number of pages migrated during the rate limiting time interval */
-	unsigned long numabalancing_migrate_nr_pages;
 	int active_node_migrate;
 #endif
 	/*
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 711372845945..de8c73f9abcf 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -71,32 +71,6 @@ TRACE_EVENT(mm_migrate_pages,
 		__print_symbolic(__entry->reason, MIGRATE_REASON))
 );
 
-TRACE_EVENT(mm_numa_migrate_ratelimit,
-
-	TP_PROTO(struct task_struct *p, int dst_nid, unsigned long nr_pages),
-
-	TP_ARGS(p, dst_nid, nr_pages),
-
-	TP_STRUCT__entry(
-		__array(	char,		comm,	TASK_COMM_LEN)
-		__field(	pid_t,		pid)
-		__field(	int,		dst_nid)
-		__field(	unsigned long,	nr_pages)
-	),
-
-	TP_fast_assign(
-		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
-		__entry->pid		= p->pid;
-		__entry->dst_nid	= dst_nid;
-		__entry->nr_pages	= nr_pages;
-	),
-
-	TP_printk("comm=%s pid=%d dst_nid=%d nr_pages=%lu",
-		__entry->comm,
-		__entry->pid,
-		__entry->dst_nid,
-		__entry->nr_pages)
-);
 #endif /* _TRACE_MIGRATE_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6ca3be059872..c020af2c58ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1394,6 +1394,17 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	int last_cpupid, this_cpupid;
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
+	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
+
+	/*
+	 * Allow first faults or private faults to migrate immediately early in
+	 * the lifetime of a task. The magic number 4 is based on waiting for
+	 * two full passes of the "multi-stage node selection" test that is
+	 * executed below.
+	 */
+	if ((p->numa_preferred_nid == -1 || p->numa_scan_seq <= 4) &&
+	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
+		return true;
 
 	/*
 	 * Multi-stage node selection is used in conjunction with a periodic
@@ -1412,7 +1423,6 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 	 * This quadric squishes small probabilities, making it less likely we
 	 * act on an unlikely task<->page relation.
 	 */
-	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
 	if (!cpupid_pid_unset(last_cpupid) &&
 				cpupid_to_nid(last_cpupid) != dst_nid)
 		return false;
@@ -6702,6 +6712,9 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
 	p->se.exec_start = 0;
 
 #ifdef CONFIG_NUMA_BALANCING
+	if (!static_branch_likely(&sched_numa_balancing))
+		return;
+
 	if (!p->mm || (p->flags & PF_EXITING))
 		return;
 
@@ -6709,8 +6722,26 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu __maybe_unus
 		int src_nid = cpu_to_node(task_cpu(p));
 		int dst_nid = cpu_to_node(new_cpu);
 
-		if (src_nid != dst_nid)
-			p->numa_scan_period = task_scan_start(p);
+		if (src_nid == dst_nid)
+			return;
+
+		/*
+		 * Allow resets if faults have been trapped before one scan
+		 * has completed. This is most likely due to a new task that
+		 * is pulled cross-node due to wakeups or load balancing.
+		 */
+		if (p->numa_scan_seq) {
+			/*
+			 * Avoid scan adjustments if moving to the preferred
+			 * node or if the task was not previously running on
+			 * the preferred node.
+			 */
+			if (dst_nid == p->numa_preferred_nid ||
+			    (p->numa_preferred_nid != -1 && src_nid != p->numa_preferred_nid))
+				return;
+		}
+
+		p->numa_scan_period = task_scan_start(p);
 	}
 #endif
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index c7749902a160..f935f4781036 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1856,54 +1856,6 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
 	return newpage;
 }
 
-/*
- * page migration rate limiting control.
- * Do not migrate more than @pages_to_migrate in a @migrate_interval_millisecs
- * window of time. Default here says do not migrate more than 1280M per second.
- */
-static unsigned int migrate_interval_millisecs __read_mostly = 100;
-static unsigned int ratelimit_pages __read_mostly = 128 << (20 - PAGE_SHIFT);
-
-/* Returns true if the node is migrate rate-limited after the update */
-static bool numamigrate_update_ratelimit(pg_data_t *pgdat,
-					unsigned long nr_pages)
-{
-	unsigned long next_window, interval;
-
-	next_window = READ_ONCE(pgdat->numabalancing_migrate_next_window);
-	interval = msecs_to_jiffies(migrate_interval_millisecs);
-
-	/*
-	 * Rate-limit the amount of data that is being migrated to a node.
-	 * Optimal placement is no good if the memory bus is saturated and
-	 * all the time is being spent migrating!
-	 */
-	if (time_after(jiffies, next_window)) {
-		if (xchg(&pgdat->numabalancing_migrate_nr_pages, 0)) {
-			do {
-				next_window += interval;
-			} while (unlikely(time_after(jiffies, next_window)));
-
-			WRITE_ONCE(pgdat->numabalancing_migrate_next_window,
-							       next_window);
-		}
-	}
-	if (pgdat->numabalancing_migrate_nr_pages > ratelimit_pages) {
-		trace_mm_numa_migrate_ratelimit(current, pgdat->node_id,
-								nr_pages);
-		return true;
-	}
-
-	/*
-	 * This is an unlocked non-atomic update so errors are possible.
-	 * The consequences are failing to migrate when we potentiall should
-	 * have which is not severe enough to warrant locking. If it is ever
-	 * a problem, it can be converted to a per-cpu counter.
-	 */
-	pgdat->numabalancing_migrate_nr_pages += nr_pages;
-	return false;
-}
-
 static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
 	int page_lru;
@@ -1976,14 +1928,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	if (page_is_file_cache(page) && PageDirty(page))
 		goto out;
 
-	/*
-	 * Rate-limit the amount of data that is being migrated to a node.
-	 * Optimal placement is no good if the memory bus is saturated and
-	 * all the time is being spent migrating!
-	 */
-	if (numamigrate_update_ratelimit(pgdat, 1))
-		goto out;
-
 	isolated = numamigrate_isolate_page(pgdat, page);
 	if (!isolated)
 		goto out;
@@ -2030,14 +1974,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	unsigned long mmun_start = address & HPAGE_PMD_MASK;
 	unsigned long mmun_end = mmun_start + HPAGE_PMD_SIZE;
 
-	/*
-	 * Rate-limit the amount of data that is being migrated to a node.
-	 * Optimal placement is no good if the memory bus is saturated and
-	 * all the time is being spent migrating!
-	 */
-	if (numamigrate_update_ratelimit(pgdat, HPAGE_PMD_NR))
-		goto out_dropref;
-
 	new_page = alloc_pages_node(node,
 		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
 		HPAGE_PMD_ORDER);
@@ -2134,7 +2070,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 
 out_fail:
 	count_vm_events(PGMIGRATE_FAIL, HPAGE_PMD_NR);
-out_dropref:
 	ptl = pmd_lock(mm, pmd);
 	if (pmd_same(*pmd, entry)) {
 		entry = pmd_modify(entry, vma->vm_page_prot);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a4fc9b0798df..9049e7b26e92 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6211,11 +6211,6 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 	int nid = pgdat->node_id;
 
 	pgdat_resize_init(pgdat);
-#ifdef CONFIG_NUMA_BALANCING
-	pgdat->numabalancing_migrate_nr_pages = 0;
-	pgdat->active_node_migrate = 0;
-	pgdat->numabalancing_migrate_next_window = jiffies;
-#endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	spin_lock_init(&pgdat->split_queue_lock);
 	INIT_LIST_HEAD(&pgdat->split_queue);

-- 
Mel Gorman
SUSE Labs
