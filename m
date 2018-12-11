Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A6FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC16020672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC16020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeLKPhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:37:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLKPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:37:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFae6j4043181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:36:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFaerY4043178;
        Tue, 11 Dec 2018 07:36:40 -0800
Date:   Tue, 11 Dec 2018 07:36:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-1f74de8798c93ce14801cc4e772603e51c841c33@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, quentin.perret@arm.com,
        torvalds@linux-foundation.org, efault@gmx.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
          quentin.perret@arm.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, efault@gmx.de
In-Reply-To: <20181203095628.11858-10-quentin.perret@arm.com>
References: <20181203095628.11858-10-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/toplogy: Introduce the
 'sched_energy_present' static key
Git-Commit-ID: 1f74de8798c93ce14801cc4e772603e51c841c33
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1f74de8798c93ce14801cc4e772603e51c841c33
Gitweb:     https://git.kernel.org/tip/1f74de8798c93ce14801cc4e772603e51c841c33
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:22 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:17:01 +0100

sched/toplogy: Introduce the 'sched_energy_present' static key

In order to make sure Energy Aware Scheduling (EAS) will not impact
systems where no Energy Model is available, introduce a static key
guarding the access to EAS code. Since EAS is enabled on a
per-root-domain basis, the static key is enabled when at least one root
domain meets all conditions for EAS.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: adharmap@codeaurora.org
Cc: chris.redpath@arm.com
Cc: currojerez@riseup.net
Cc: dietmar.eggemann@arm.com
Cc: edubezval@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: javi.merino@kernel.org
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: morten.rasmussen@arm.com
Cc: patrick.bellasi@arm.com
Cc: pkondeti@codeaurora.org
Cc: rjw@rjwysocki.net
Cc: skannan@codeaurora.org
Cc: smuckle@google.com
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Cc: viresh.kumar@linaro.org
Link: https://lkml.kernel.org/r/20181203095628.11858-10-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h    |  4 ++++
 kernel/sched/topology.c | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fd84900b0b21..2b3cf356e958 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2296,3 +2296,7 @@ unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned
 #else
 #define perf_domain_span(pd) NULL
 #endif
+
+#ifdef CONFIG_SMP
+extern struct static_key_false sched_energy_present;
+#endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0a5a1d3a4eae..3f35ba1d8fde 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -201,6 +201,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 	return 1;
 }
 
+DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
@@ -273,6 +274,19 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 	free_pd(pd);
 }
 
+static void sched_energy_set(bool has_eas)
+{
+	if (!has_eas && static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: stopping EAS\n", __func__);
+		static_branch_disable_cpuslocked(&sched_energy_present);
+	} else if (has_eas && !static_branch_unlikely(&sched_energy_present)) {
+		if (sched_debug())
+			pr_info("%s: starting EAS\n", __func__);
+		static_branch_enable_cpuslocked(&sched_energy_present);
+	}
+}
+
 /*
  * EAS can be used on a root domain if it meets all the following conditions:
  *    1. an Energy Model (EM) is available;
@@ -299,7 +313,7 @@ static void destroy_perf_domain_rcu(struct rcu_head *rp)
 #define EM_MAX_COMPLEXITY 2048
 
 extern struct cpufreq_governor schedutil_gov;
-static void build_perf_domains(const struct cpumask *cpu_map)
+static bool build_perf_domains(const struct cpumask *cpu_map)
 {
 	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
 	struct perf_domain *pd = NULL, *tmp;
@@ -365,7 +379,7 @@ static void build_perf_domains(const struct cpumask *cpu_map)
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
 
-	return;
+	return !!pd;
 
 free:
 	free_pd(pd);
@@ -373,6 +387,8 @@ free:
 	rcu_assign_pointer(rd->pd, NULL);
 	if (tmp)
 		call_rcu(&tmp->rcu, destroy_perf_domain_rcu);
+
+	return false;
 }
 #else
 static void free_pd(struct perf_domain *pd) { }
@@ -2114,6 +2130,7 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
 void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			     struct sched_domain_attr *dattr_new)
 {
+	bool __maybe_unused has_eas = false;
 	int i, j, n;
 	int new_topology;
 
@@ -2177,14 +2194,17 @@ match2:
 	for (i = 0; i < ndoms_new; i++) {
 		for (j = 0; j < n && !sched_energy_update; j++) {
 			if (cpumask_equal(doms_new[i], doms_cur[j]) &&
-			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd)
+			    cpu_rq(cpumask_first(doms_cur[j]))->rd->pd) {
+				has_eas = true;
 				goto match3;
+			}
 		}
 		/* No match - add perf. domains for a new rd */
-		build_perf_domains(doms_new[i]);
+		has_eas |= build_perf_domains(doms_new[i]);
 match3:
 		;
 	}
+	sched_energy_set(has_eas);
 #endif
 
 	/* Remember the new sched domains: */
