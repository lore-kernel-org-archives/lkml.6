Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FEAC7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FF120663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfAULf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:35:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfAULf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:35:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBZihQ2497308
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:35:44 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBZiZ82497305;
        Mon, 21 Jan 2019 03:35:44 -0800
Date:   Mon, 21 Jan 2019 03:35:44 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-85ff0ec647a3bdfda7fc4ae567f529c141721eb1@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        mingo@kernel.org, quentin.perret@arm.com, hpa@zytor.com
Reply-To: quentin.perret@arm.com, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20181203095628.11858-11-quentin.perret@arm.com>
References: <20181203095628.11858-11-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Introduce a sysctl for Energy
 Aware Scheduling
Git-Commit-ID: 85ff0ec647a3bdfda7fc4ae567f529c141721eb1
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

Commit-ID:  85ff0ec647a3bdfda7fc4ae567f529c141721eb1
Gitweb:     https://git.kernel.org/tip/85ff0ec647a3bdfda7fc4ae567f529c141721eb1
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:23 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:27:53 +0100

sched/topology: Introduce a sysctl for Energy Aware Scheduling

In its current state, Energy Aware Scheduling (EAS) starts automatically
on asymmetric platforms having an Energy Model (EM). However, there are
users who want to have an EM (for thermal management for example), but
don't want EAS with it.

In order to let users disable EAS explicitly, introduce a new sysctl
called 'sched_energy_aware'. It is enabled by default so that EAS can
start automatically on platforms where it makes sense. Flipping it to 0
rebuilds the scheduling domains and disables EAS.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
Link: https://lkml.kernel.org/r/20181203095628.11858-11-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/sysctl/kernel.txt | 12 ++++++++++++
 include/linux/sched/sysctl.h    |  7 +++++++
 kernel/sched/topology.c         | 29 +++++++++++++++++++++++++++++
 kernel/sysctl.c                 | 11 +++++++++++
 4 files changed, 59 insertions(+)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index c0527d8a468a..379063e58326 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -79,6 +79,7 @@ show up in /proc/sys/kernel:
 - reboot-cmd                  [ SPARC only ]
 - rtsig-max
 - rtsig-nr
+- sched_energy_aware
 - seccomp/                    ==> Documentation/userspace-api/seccomp_filter.rst
 - sem
 - sem_next_id		      [ sysv ipc ]
@@ -890,6 +891,17 @@ rtsig-nr shows the number of RT signals currently queued.
 
 ==============================================================
 
+sched_energy_aware:
+
+Enables/disables Energy Aware Scheduling (EAS). EAS starts
+automatically on platforms where it can run (that is,
+platforms with asymmetric CPU topologies and having an Energy
+Model available). If your platform happens to meet the
+requirements for EAS but you do not want to use it, change
+this value to 0.
+
+==============================================================
+
 sched_schedstats:
 
 Enables/disables scheduler statistics. Enabling this feature
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index a9c32daeb9d8..99ce6d728df7 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -83,4 +83,11 @@ extern int sysctl_schedstats(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
 				 loff_t *ppos);
 
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+extern unsigned int sysctl_sched_energy_aware;
+extern int sched_energy_aware_handler(struct ctl_table *table, int write,
+				 void __user *buffer, size_t *lenp,
+				 loff_t *ppos);
+#endif
+
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3f35ba1d8fde..50c3fc316c54 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -203,9 +203,35 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+unsigned int sysctl_sched_energy_aware = 1;
 DEFINE_MUTEX(sched_energy_mutex);
 bool sched_energy_update;
 
+#ifdef CONFIG_PROC_SYSCTL
+int sched_energy_aware_handler(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, state;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		state = static_branch_unlikely(&sched_energy_present);
+		if (state != sysctl_sched_energy_aware) {
+			mutex_lock(&sched_energy_mutex);
+			sched_energy_update = 1;
+			rebuild_sched_domains();
+			sched_energy_update = 0;
+			mutex_unlock(&sched_energy_mutex);
+		}
+	}
+
+	return ret;
+}
+#endif
+
 static void free_pd(struct perf_domain *pd)
 {
 	struct perf_domain *tmp;
@@ -322,6 +348,9 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 	struct cpufreq_policy *policy;
 	struct cpufreq_governor *gov;
 
+	if (!sysctl_sched_energy_aware)
+		goto free;
+
 	/* EAS is enabled for asymmetric CPU capacity topologies. */
 	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
 		if (sched_debug()) {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..987ae08147bf 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -467,6 +467,17 @@ static struct ctl_table kern_table[] = {
 		.extra1		= &one,
 	},
 #endif
+#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
+	{
+		.procname	= "sched_energy_aware",
+		.data		= &sysctl_sched_energy_aware,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_energy_aware_handler,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+#endif
 #ifdef CONFIG_PROVE_LOCKING
 	{
 		.procname	= "prove_locking",
