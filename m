Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A78CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2D120672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2D120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeLKPdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:33:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeLKPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:33:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFWXMf4042107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:32:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFWXPB4042104;
        Tue, 11 Dec 2018 07:32:33 -0800
Date:   Tue, 11 Dec 2018 07:32:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Quentin Perret <tipbot@zytor.com>
Message-ID: <tip-5bd0988be12733a42a1a3d50e3e2ddfd79e57518@git.kernel.org>
Cc:     quentin.perret@arm.com, tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        efault@gmx.de, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, efault@gmx.de, hpa@zytor.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de, quentin.perret@arm.com
In-Reply-To: <20181203095628.11858-2-quentin.perret@arm.com>
References: <20181203095628.11858-2-quentin.perret@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Relocate arch_scale_cpu_capacity()
 to the internal header
Git-Commit-ID: 5bd0988be12733a42a1a3d50e3e2ddfd79e57518
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

Commit-ID:  5bd0988be12733a42a1a3d50e3e2ddfd79e57518
Gitweb:     https://git.kernel.org/tip/5bd0988be12733a42a1a3d50e3e2ddfd79e57518
Author:     Quentin Perret <quentin.perret@arm.com>
AuthorDate: Mon, 3 Dec 2018 09:56:14 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:16:58 +0100

sched/topology: Relocate arch_scale_cpu_capacity() to the internal header

By default, arch_scale_cpu_capacity() is only visible from within the
kernel/sched folder. Relocate it to include/linux/sched/topology.h to
make it visible to other clients needing to know about the capacity of
CPUs, such as the Energy Model framework.

This also shrinks the <linux/sched/topology.h> public header.

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
Link: https://lkml.kernel.org/r/20181203095628.11858-2-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/topology.h | 16 ++++++++++++++++
 kernel/sched/sched.h           | 18 ------------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7fa0bc17cd8c..c31d3a47a47c 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -201,6 +201,14 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 # define SD_INIT_NAME(type)
 #endif
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
+{
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 #else /* CONFIG_SMP */
 
 struct sched_domain_attr;
@@ -216,6 +224,14 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+#ifndef arch_scale_cpu_capacity
+static __always_inline
+unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
+{
+	return SCHED_CAPACITY_SCALE;
+}
+#endif
+
 #endif	/* !CONFIG_SMP */
 
 static inline int task_node(const struct task_struct *p)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ceb896404869..66067152a831 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1859,24 +1859,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
-#ifdef CONFIG_SMP
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-#else
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
-{
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-#endif
-
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PREEMPT
 
