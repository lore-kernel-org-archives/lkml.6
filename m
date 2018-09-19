Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0272151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="WgSqsKOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0272151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeISSF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:05:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45039 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbeISSFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:05:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so5584731wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mgNdcRiXOIDj/ssegf1dm+Nb4Rv3rYu1hOHwqaX7GAc=;
        b=WgSqsKOnOsJABlo09ljTu3FrNUGrTTBB8YuyZiUHK061QivqlzMJtAR1pNw41px2Pk
         MFkVTdEcnF6cCEBw50tNxCF1DJTwhsnbR6SNyJBaw+uzW/rKjpmqd7P1y1NpsJXk6LWq
         YBZ+m48zGuH9qPJVHpT9AjqHnhcJNWAfCslj2vzws5bHdSnz0BIuApVuezToLaHs5jul
         bsI+onjGXv5yoh/rGZch8CMK6lpl0RgkUZ40jy8pPlYoB+rw7J+aqt5D5O90XwYHMKBa
         RdTfejReYJuPvpzzX+HEE8DTtz7DC4QZCf9iRZ48YQ6gvrxzSLtT6XXcyIwjia/rDU8L
         QaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mgNdcRiXOIDj/ssegf1dm+Nb4Rv3rYu1hOHwqaX7GAc=;
        b=jhuUoI9mjDkRSMP4d1C6XXspZoZt2GW7ld/18k0OUmGTVkQjlCxUDBBhJgk1qsNUgX
         2bomZ1rp0ZcW8j0R0hJdQefipL5ts8Q1YNxvxXudtbVMafs83QCE2I5Mr/TekC6ej8dj
         VvZQRBK8cqE/wLn/3B2i/QyHovS7mbhZrZD+9lZ5M0xq4B0itMUNbMguivsccpmxZdMM
         r3OrLsWO4VzCPnmxL20i/H8R/C/cF4kIIynG3WW9FJ8Jnbhtss0eKNlI2R2KHeO2iFmw
         WFfmk1i2mScuejrdR3bjJLfSYnY5684B2pW5iMMtwiAQkn85/eNhtdCTq2K8YCQgw09B
         a//Q==
X-Gm-Message-State: APzg51AQ/u3eN5fh995nqcTB5WJG1nKQQqZtgJxVXCqtnTyN+UfN4mCb
        TsLX+7IyeP9L6RYlJGvvNcyYqQs5jK4=
X-Google-Smtp-Source: ANB0VdZ69APgSB17lm+lQ1VvLg6J6rAfJe/T+7ySkfptYqfbuisZhq3aXvZovr4ArVghR+7xRWKCFA==
X-Received: by 2002:adf:8485:: with SMTP id 5-v6mr28722311wrg.34.1537360079816;
        Wed, 19 Sep 2018 05:27:59 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id l18-v6sm19412403wru.75.2018.09.19.05.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 05:27:59 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org
Subject: [RFC 2/5] perf: Pass pmu pointer to perf_paranoid_* helpers
Date:   Wed, 19 Sep 2018 13:27:48 +0100
Message-Id: <20180919122751.12439-3-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

To enable per-PMU access controls in a following patch we need to start
passing in the PMU object pointer to perf_paranoid_* helpers.

This patch only changes the API across the code base without changing the
behaviour.

v2:
 * Correct errors in core-book3s.c as reported by kbuild test robot.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 arch/powerpc/perf/core-book3s.c | 31 ++++++++++++++++++++++---------
 arch/x86/events/intel/bts.c     |  2 +-
 arch/x86/events/intel/core.c    |  2 +-
 arch/x86/events/intel/p4.c      |  2 +-
 include/linux/perf_event.h      |  6 +++---
 kernel/events/core.c            | 15 ++++++++-------
 kernel/trace/trace_event_perf.c |  6 ++++--
 7 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 81f8a0c838ae..1e8b1aed6e81 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -95,7 +95,13 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
 {
 	return 0;
 }
-static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp) { }
+
+static inline void
+perf_get_data_addr(struct pmu *pmu, struct pt_regs *regs, u64 *addrp)
+{
+
+}
+
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	return 0;
@@ -126,7 +132,13 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
 static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) {}
-static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
+
+static inline void
+power_pmu_bhrb_read(struct pmu *pmu,struct cpu_hw_events *cpuhw)
+{
+
+}
+
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
 
@@ -170,7 +182,8 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
  * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC, the
  * [POWER7P_]MMCRA_SDAR_VALID bit in MMCRA, or the SDAR_VALID bit in SIER.
  */
-static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
+static inline void
+perf_get_data_addr(struct pmu *pmu, struct pt_regs *regs, u64 *addrp)
 {
 	unsigned long mmcra = regs->dsisr;
 	bool sdar_valid;
@@ -195,7 +208,7 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || sdar_valid)
 		*addrp = mfspr(SPRN_SDAR);
 
-	if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
+	if (perf_paranoid_kernel(pmu) && !capable(CAP_SYS_ADMIN) &&
 		is_kernel_addr(mfspr(SPRN_SDAR)))
 		*addrp = 0;
 }
@@ -435,7 +448,7 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 }
 
 /* Processing BHRB entries */
-static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
+static void power_pmu_bhrb_read(struct pmu *pmu, struct cpu_hw_events *cpuhw)
 {
 	u64 val;
 	u64 addr;
@@ -463,8 +476,8 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 			 * exporting it to userspace (avoid exposure of regions
 			 * where we could have speculative execution)
 			 */
-			if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
-				is_kernel_addr(addr))
+			if (perf_paranoid_kernel(pmu) &&
+			    !capable(CAP_SYS_ADMIN) && is_kernel_addr(addr))
 				continue;
 
 			/* Branches are read most recent first (ie. mfbhrb 0 is
@@ -2066,12 +2079,12 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		if (event->attr.sample_type &
 		    (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
-			perf_get_data_addr(regs, &data.addr);
+			perf_get_data_addr(event->pmu, regs, &data.addr);
 
 		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
 			struct cpu_hw_events *cpuhw;
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
-			power_pmu_bhrb_read(cpuhw);
+			power_pmu_bhrb_read(event->pmu, cpuhw);
 			data.br_stack = &cpuhw->bhrb_stack;
 		}
 
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 24ffa1e88cf9..e416c9e2400a 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -555,7 +555,7 @@ static int bts_event_init(struct perf_event *event)
 	 * Note that the default paranoia setting permits unprivileged
 	 * users to profile the kernel.
 	 */
-	if (event->attr.exclude_kernel && perf_paranoid_kernel() &&
+	if (event->attr.exclude_kernel && perf_paranoid_kernel(event->pmu) &&
 	    !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 035c37481f57..40ccb4dbbadf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3033,7 +3033,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (x86_pmu.version < 3)
 		return -EINVAL;
 
-	if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
+	if (perf_paranoid_cpu(event->pmu) && !capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	event->hw.config |= ARCH_PERFMON_EVENTSEL_ANY;
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index d32c0eed38ca..878451ef1ace 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -776,7 +776,7 @@ static int p4_validate_raw_event(struct perf_event *event)
 	 * the user needs special permissions to be able to use it
 	 */
 	if (p4_ht_active() && p4_event_bind_map[v].shared) {
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
+		if (perf_paranoid_cpu(event->pmu) && !capable(CAP_SYS_ADMIN))
 			return -EACCES;
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..22906bcc1bcd 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1179,17 +1179,17 @@ extern int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
 int perf_event_max_stack_handler(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp, loff_t *ppos);
 
-static inline bool perf_paranoid_tracepoint_raw(void)
+static inline bool perf_paranoid_tracepoint_raw(const struct pmu *pmu)
 {
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline bool perf_paranoid_cpu(void)
+static inline bool perf_paranoid_cpu(const struct pmu *pmu)
 {
 	return sysctl_perf_event_paranoid > 0;
 }
 
-static inline bool perf_paranoid_kernel(void)
+static inline bool perf_paranoid_kernel(const struct pmu *pmu)
 {
 	return sysctl_perf_event_paranoid > 1;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index adcd9eae13fb..f556144bc0c5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4108,7 +4108,7 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
+		if (perf_paranoid_cpu(pmu) && !capable(CAP_SYS_ADMIN))
 			return ERR_PTR(-EACCES);
 
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
@@ -5676,7 +5676,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	lock_limit >>= PAGE_SHIFT;
 	locked = vma->vm_mm->pinned_vm + extra;
 
-	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
+	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw(event->pmu) &&
 		!capable(CAP_IPC_LOCK)) {
 		ret = -EPERM;
 		goto unlock;
@@ -10492,8 +10492,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_cred;
 	}
 
+	pmu = event->pmu;
+
 	if (!attr.exclude_kernel) {
-		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
+		if (perf_paranoid_kernel(pmu) && !capable(CAP_SYS_ADMIN)) {
 			err = -EACCES;
 			goto err_alloc;
 		}
@@ -10501,7 +10503,7 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
-	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
+	    perf_paranoid_kernel(pmu) && !capable(CAP_SYS_ADMIN)) {
 		err = -EACCES;
 		goto err_alloc;
 	}
@@ -10509,13 +10511,13 @@ SYSCALL_DEFINE5(perf_event_open,
 	/* privileged levels capture (kernel, hv): check permissions */
 	if ((attr.sample_type & PERF_SAMPLE_BRANCH_STACK) &&
 	    (attr.branch_sample_type & PERF_SAMPLE_BRANCH_PERM_PLM) &&
-	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
+	    perf_paranoid_kernel(pmu) && !capable(CAP_SYS_ADMIN)) {
 		err = -EACCES;
 		goto err_alloc;
 	}
 
 	if (is_sampling_event(event)) {
-		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
+		if (pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -EOPNOTSUPP;
 			goto err_alloc;
 		}
@@ -10525,7 +10527,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	 * Special case software events and allow them to be part of
 	 * any hardware group.
 	 */
-	pmu = event->pmu;
 
 	if (attr.use_clockid) {
 		err = perf_event_set_clock(event, attr.clockid);
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 69a3fe926e8c..04ea3afec5b2 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -46,7 +46,8 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 
 	/* The ftrace function trace is allowed only for root. */
 	if (ftrace_event_is_function(tp_event)) {
-		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
+		if (perf_paranoid_tracepoint_raw(p_event->pmu) &&
+		    !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
 		if (!is_sampling_event(p_event))
@@ -82,7 +83,8 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	 * ...otherwise raw tracepoint data can be a severe data leak,
 	 * only allow root to have these.
 	 */
-	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
+	if (perf_paranoid_tracepoint_raw(p_event->pmu) &&
+	    !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	return 0;
-- 
2.17.1

