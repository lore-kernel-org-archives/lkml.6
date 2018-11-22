Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F383EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD0720866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD0720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394017AbeKVUxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:53:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57899 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbeKVUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:53:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMADwKC3744225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:13:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMADwsa3744222;
        Thu, 22 Nov 2018 02:13:58 -0800
Date:   Thu, 22 Nov 2018 02:13:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-67266c1080ad56c31af72b9c18355fde8ccc124a@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, stable@vger.kernel.org,
        a.p.zijlstra@chello.nl, hpa@zytor.com, peterz@infradead.org,
        eranian@google.com, acme@kernel.org, jolsa@redhat.com,
        vincent.weaver@maine.edu, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: hpa@zytor.com, a.p.zijlstra@chello.nl, stable@vger.kernel.org,
          jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
          torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          vincent.weaver@maine.edu, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, peterz@infradead.org, eranian@google.com,
          acme@kernel.org
In-Reply-To: <20181121101612.16272-2-jolsa@kernel.org>
References: <20181121101612.16272-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Add generic branch tracing check
 to intel_pmu_has_bts()
Git-Commit-ID: 67266c1080ad56c31af72b9c18355fde8ccc124a
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

Commit-ID:  67266c1080ad56c31af72b9c18355fde8ccc124a
Gitweb:     https://git.kernel.org/tip/67266c1080ad56c31af72b9c18355fde8ccc124a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 21 Nov 2018 11:16:11 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 09:45:09 +0100

perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts()

Currently we check the branch tracing only by checking for the
PERF_COUNT_HW_BRANCH_INSTRUCTIONS event of PERF_TYPE_HARDWARE
type. But we can define the same event with the PERF_TYPE_RAW
type.

Changing the intel_pmu_has_bts() code to check on event's final
hw config value, so both HW types are covered.

Adding unlikely to intel_pmu_has_bts() condition calls, because
it was used in the original code in intel_bts_constraints.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20181121101612.16272-2-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 17 +++--------------
 arch/x86/events/perf_event.h | 13 +++++++++----
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a95079abeb03..a15a73788693 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2474,16 +2474,7 @@ done:
 static struct event_constraint *
 intel_bts_constraints(struct perf_event *event)
 {
-	struct hw_perf_event *hwc = &event->hw;
-	unsigned int hw_event, bts_event;
-
-	if (event->attr.freq)
-		return NULL;
-
-	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
-	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
-
-	if (unlikely(hw_event == bts_event && hwc->sample_period == 1))
+	if (unlikely(intel_pmu_has_bts(event)))
 		return &bts_constraint;
 
 	return NULL;
@@ -3105,10 +3096,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 static int intel_pmu_bts_config(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
-	struct hw_perf_event *hwc = &event->hw;
 
-	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !attr->freq && hwc->sample_period == 1) {
+	if (unlikely(intel_pmu_has_bts(event))) {
 		/* BTS is not supported by this architecture. */
 		if (!x86_pmu.bts_active)
 			return -EOPNOTSUPP;
@@ -3170,7 +3159,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		/*
 		 * BTS is set up earlier in this path, so don't account twice
 		 */
-		if (!intel_pmu_has_bts(event)) {
+		if (!unlikely(intel_pmu_has_bts(event))) {
 			/* disallow lbr if conflicting events are present */
 			if (x86_add_exclusive(x86_lbr_exclusive_lbr))
 				return -EBUSY;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index adae087cecdd..78d7b7031bfc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -859,11 +859,16 @@ static inline int amd_pmu_init(void)
 
 static inline bool intel_pmu_has_bts(struct perf_event *event)
 {
-	if (event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !event->attr.freq && event->hw.sample_period == 1)
-		return true;
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned int hw_event, bts_event;
+
+	if (event->attr.freq)
+		return false;
+
+	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
+	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 
-	return false;
+	return hw_event == bts_event && hwc->sample_period == 1;
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
