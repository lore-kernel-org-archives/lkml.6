Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A008C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BE426D49
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="rnpwkZQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BE426D49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeFZPiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:38:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37652 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeFZPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:37:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so1805099wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VfBwtJWPg8zlCvn5V2R+V2JaIa0oCQSYm3HSJ3vz2jA=;
        b=rnpwkZQg+y+hw80FlqizQLS03SyYGtrdNIzztB0zwLyPgNpXGSvX7CbLeZJ7lW7gI/
         ZuavK3n8na1xni4WOOZBgOnq6DsZeJEaxe1cPwbzOcgTUkBc/ftB+oDyRaelNtc6G7kD
         95BVZY6K61t/gDnujFB+SfCFYk7q+spZSzIFRFS/pFgtelSPX8NySm6o+X8ZOKHZx/xV
         NORwXbGETL3y6YX5A+nH2/gaH1OdCPBm9Nv1ee+EgosU49vt/xOt5MEXG26orXiGNtca
         /TPGYCnUL2GBoJqdxYFdDcTStmAE+g9JT96wnGt/azGj85l75iEwzNAxWYR+HnUOW6Uq
         7+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VfBwtJWPg8zlCvn5V2R+V2JaIa0oCQSYm3HSJ3vz2jA=;
        b=UawipO9NTZIyTN9Rgdys095B9z1Lv4i60Bqz0C8eWg69MopxvI7/FLObqOkjEVvOnU
         Hs7KVpHQyomWVGSvcFWT/qaz6Ip9Co3MO7Q9fL1bR5HWtJm8H306LEyupWVIdN87O6b4
         CLDLKBEjByYp1gZVmMkiFCaFMlBfdpHakgW8i+y6ioBkzo16FiPjxNAfaarw6kwdOWGK
         Z4JI5OTGR/oMK3IYW5HAzlOlMdQ8Lt/e/iyT2g+o9xuxPWNOo1GOKFsUWPxW40k9kw60
         mX3Q9AuM4zcdUXUvE8j8q3YcPJMxJTl6j/pmTGfwQNQ/KqRapY8hbFSywdFJ+r4U3CzY
         RWAw==
X-Gm-Message-State: APt69E28R1BjVK1RZyOtDN6NvKc7tZ0a/RZWVKGK/ZAets72Fe0eSNkx
        qU8KvqcI06zD6N0UCmwr0xENRYsL
X-Google-Smtp-Source: AAOMgpdTrhfKsWSz5KUWsKh+AqJ5LhONT5UOdNZsWrd46JjmBOWDdfk0ZFC6uAmdyXtAJ8qejlYVPQ==
X-Received: by 2002:a1c:b3c3:: with SMTP id c186-v6mr2164148wmf.41.1530027438327;
        Tue, 26 Jun 2018 08:37:18 -0700 (PDT)
Received: from localhost.localdomain ([95.146.151.144])
        by smtp.gmail.com with ESMTPSA id l84-v6sm3411176wmi.3.2018.06.26.08.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 08:37:17 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
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
Subject: [RFC 2/4] perf: Pass pmu pointer to perf_paranoid_* helpers
Date:   Tue, 26 Jun 2018 16:36:40 +0100
Message-Id: <20180626153642.5587-3-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

To enable per-PMU access controls in a following patch we need to start
passing in the PMU object pointer to perf_paranoid_* helpers.

This patch only changes the API across the code base without changing the
behaviour.

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
 arch/powerpc/perf/core-book3s.c |  2 +-
 arch/x86/events/intel/bts.c     |  2 +-
 arch/x86/events/intel/core.c    |  2 +-
 arch/x86/events/intel/p4.c      |  2 +-
 include/linux/perf_event.h      |  6 +++---
 kernel/events/core.c            | 15 ++++++++-------
 kernel/trace/trace_event_perf.c |  6 ++++--
 7 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 3f66fcf8ad99..ae6716cea308 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -199,7 +199,7 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || sdar_valid)
 		*addrp = mfspr(SPRN_SDAR);
 
-	if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
+	if (perf_paranoid_kernel(ppmu) && !capable(CAP_SYS_ADMIN) &&
 		is_kernel_addr(mfspr(SPRN_SDAR)))
 		*addrp = 0;
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
index 707b2a96e516..6b126bdbd16c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3025,7 +3025,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
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
index 1fa12887ec02..d7938d88c028 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1178,17 +1178,17 @@ extern int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
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
index 12de95b0472e..370c89e81722 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4113,7 +4113,7 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
+		if (perf_paranoid_cpu(pmu) && !capable(CAP_SYS_ADMIN))
 			return ERR_PTR(-EACCES);
 
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
@@ -5681,7 +5681,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	lock_limit >>= PAGE_SHIFT;
 	locked = vma->vm_mm->pinned_vm + extra;
 
-	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
+	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw(event->pmu) &&
 		!capable(CAP_IPC_LOCK)) {
 		ret = -EPERM;
 		goto unlock;
@@ -10487,8 +10487,10 @@ SYSCALL_DEFINE5(perf_event_open,
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
@@ -10496,7 +10498,7 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
-	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
+	    perf_paranoid_kernel(pmu) && !capable(CAP_SYS_ADMIN)) {
 		err = -EACCES;
 		goto err_alloc;
 	}
@@ -10504,13 +10506,13 @@ SYSCALL_DEFINE5(perf_event_open,
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
@@ -10520,7 +10522,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	 * Special case software events and allow them to be part of
 	 * any hardware group.
 	 */
-	pmu = event->pmu;
 
 	if (attr.use_clockid) {
 		err = perf_event_set_clock(event, attr.clockid);
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index c79193e598f5..545a7ef9bfe1 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -45,7 +45,8 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 
 	/* The ftrace function trace is allowed only for root. */
 	if (ftrace_event_is_function(tp_event)) {
-		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
+		if (perf_paranoid_tracepoint_raw(p_event->pmu) &&
+		    !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
 		if (!is_sampling_event(p_event))
@@ -81,7 +82,8 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
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

