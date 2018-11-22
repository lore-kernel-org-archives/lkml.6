Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D63A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D63A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394003AbeKVUws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:52:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbeKVUwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:52:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMADN723744178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:13:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMADM7V3744172;
        Thu, 22 Nov 2018 02:13:22 -0800
Date:   Thu, 22 Nov 2018 02:13:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ed6101bbf6266ee83e620b19faa7c6ad56bb41ab@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, eranian@google.com,
        jolsa@redhat.com, a.p.zijlstra@chello.nl, tglx@linutronix.de,
        stable@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, acme@redhat.com,
        vincent.weaver@maine.edu, peterz@infradead.org, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org
Reply-To: a.p.zijlstra@chello.nl, tglx@linutronix.de,
          stable@vger.kernel.org, jolsa@redhat.com, eranian@google.com,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          peterz@infradead.org, vincent.weaver@maine.edu,
          torvalds@linux-foundation.org, acme@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@kernel.org
In-Reply-To: <20181121101612.16272-1-jolsa@kernel.org>
References: <20181121101612.16272-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Move branch tracing setup to the
 Intel-specific source file
Git-Commit-ID: ed6101bbf6266ee83e620b19faa7c6ad56bb41ab
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

Commit-ID:  ed6101bbf6266ee83e620b19faa7c6ad56bb41ab
Gitweb:     https://git.kernel.org/tip/ed6101bbf6266ee83e620b19faa7c6ad56bb41ab
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 21 Nov 2018 11:16:10 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 09:45:09 +0100

perf/x86/intel: Move branch tracing setup to the Intel-specific source file

Moving branch tracing setup to Intel core object into separate
intel_pmu_bts_config function, because it's Intel specific.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20181121101612.16272-1-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       | 20 --------------------
 arch/x86/events/intel/core.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 106911b603bd..374a19712e20 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -438,26 +438,6 @@ int x86_setup_perfctr(struct perf_event *event)
 	if (config == -1LL)
 		return -EINVAL;
 
-	/*
-	 * Branch tracing:
-	 */
-	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !attr->freq && hwc->sample_period == 1) {
-		/* BTS is not supported by this architecture. */
-		if (!x86_pmu.bts_active)
-			return -EOPNOTSUPP;
-
-		/* BTS is currently only allowed for user-mode. */
-		if (!attr->exclude_kernel)
-			return -EOPNOTSUPP;
-
-		/* disallow bts if conflicting events are present */
-		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
-			return -EBUSY;
-
-		event->destroy = hw_perf_lbr_event_destroy;
-	}
-
 	hwc->config |= config;
 
 	return 0;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index af8bea9d4006..a95079abeb03 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3102,10 +3102,49 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 	return flags;
 }
 
+static int intel_pmu_bts_config(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
+	    !attr->freq && hwc->sample_period == 1) {
+		/* BTS is not supported by this architecture. */
+		if (!x86_pmu.bts_active)
+			return -EOPNOTSUPP;
+
+		/* BTS is currently only allowed for user-mode. */
+		if (!attr->exclude_kernel)
+			return -EOPNOTSUPP;
+
+		/* disallow bts if conflicting events are present */
+		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
+			return -EBUSY;
+
+		event->destroy = hw_perf_lbr_event_destroy;
+	}
+
+	return 0;
+}
+
+static int core_pmu_hw_config(struct perf_event *event)
+{
+	int ret = x86_pmu_hw_config(event);
+
+	if (ret)
+		return ret;
+
+	return intel_pmu_bts_config(event);
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
 
+	if (ret)
+		return ret;
+
+	ret = intel_pmu_bts_config(event);
 	if (ret)
 		return ret;
 
@@ -3600,7 +3639,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.enable_all		= core_pmu_enable_all,
 	.enable			= core_pmu_enable_event,
 	.disable		= x86_pmu_disable_event,
-	.hw_config		= x86_pmu_hw_config,
+	.hw_config		= core_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
