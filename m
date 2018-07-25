Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61881C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2608720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2608720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeGYPox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:44:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeGYPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:44:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEWSkI402999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:32:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEWSmu402996;
        Wed, 25 Jul 2018 07:32:28 -0700
Date:   Wed, 25 Jul 2018 07:32:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-4f08b6255adb1e379b4fcc8d304ec1263d465677@git.kernel.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@redhat.com, kan.liang@linux.intel.com,
        vincent.weaver@maine.edu, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        eranian@google.com
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, eranian@google.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          acme@redhat.com, kan.liang@linux.intel.com,
          vincent.weaver@maine.edu, jolsa@redhat.com
In-Reply-To: <20180309021542.11374-2-kan.liang@linux.intel.com>
References: <20180309021542.11374-2-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Support PEBS on fixed counters
Git-Commit-ID: 4f08b6255adb1e379b4fcc8d304ec1263d465677
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

Commit-ID:  4f08b6255adb1e379b4fcc8d304ec1263d465677
Gitweb:     https://git.kernel.org/tip/4f08b6255adb1e379b4fcc8d304ec1263d465677
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 8 Mar 2018 18:15:40 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:50:50 +0200

perf/x86/intel: Support PEBS on fixed counters

The Extended PEBS feature supports PEBS on fixed-function performance
counters as well as all four general purpose counters.

It has to change the order of PEBS and fixed counter enabling to make
sure PEBS is enabled for the fixed counters.

The change of the order doesn't impact the behavior of current code on
other platforms which don't support extended PEBS.
Because there is no dependency among those enable/disable functions.

Don't enable IRQ generation (0x8) for MSR_ARCH_PERFMON_FIXED_CTR_CTRL.
The PEBS ucode will handle the interrupt generation.

Based-on-code-from: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Link: http://lkml.kernel.org/r/20180309021542.11374-2-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 86f0c15dcc2d..d5a3124605f5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2041,15 +2041,15 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
 	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
 
+	if (unlikely(event->attr.precise_ip))
+		intel_pmu_pebs_disable(event);
+
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
 		intel_pmu_disable_fixed(hwc);
 		return;
 	}
 
 	x86_pmu_disable_event(event);
-
-	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_disable(event);
 }
 
 static void intel_pmu_del_event(struct perf_event *event)
@@ -2068,17 +2068,19 @@ static void intel_pmu_read_event(struct perf_event *event)
 		x86_perf_event_update(event);
 }
 
-static void intel_pmu_enable_fixed(struct hw_perf_event *hwc)
+static void intel_pmu_enable_fixed(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
-	u64 ctrl_val, bits, mask;
+	u64 ctrl_val, mask, bits = 0;
 
 	/*
-	 * Enable IRQ generation (0x8),
+	 * Enable IRQ generation (0x8), if not PEBS,
 	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
 	 * if requested:
 	 */
-	bits = 0x8ULL;
+	if (!event->attr.precise_ip)
+		bits |= 0x8;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
 		bits |= 0x2;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
@@ -2120,14 +2122,14 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	if (unlikely(event_is_checkpointed(event)))
 		cpuc->intel_cp_status |= (1ull << hwc->idx);
 
+	if (unlikely(event->attr.precise_ip))
+		intel_pmu_pebs_enable(event);
+
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
-		intel_pmu_enable_fixed(hwc);
+		intel_pmu_enable_fixed(event);
 		return;
 	}
 
-	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_enable(event);
-
 	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 }
 
