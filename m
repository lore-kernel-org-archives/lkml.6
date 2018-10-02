Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11522C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF97820878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF97820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJBQqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:46:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47033 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJBQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:46:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A2WVR1913313
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:02:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A2Wpq1913310;
        Tue, 2 Oct 2018 03:02:32 -0700
Date:   Tue, 2 Oct 2018 03:02:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Natarajan, Janakarajan" <tipbot@zytor.com>
Message-ID: <tip-d7cbbe49a9304520181fb8c9272d1327deec8453@git.kernel.org>
Cc:     namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        bp@alien8.de, acme@kernel.org, jolsa@redhat.com,
        torvalds@linux-foundation.org, acme@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, vincent.weaver@maine.edu,
        hpa@zytor.com, Suravee.Suthikulpanit@amd.com,
        linux-kernel@vger.kernel.org, Janakarajan.Natarajan@amd.com,
        eranian@google.com
Reply-To: bp@alien8.de, acme@kernel.org, jolsa@redhat.com,
          torvalds@linux-foundation.org, acme@redhat.com,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          Suravee.Suthikulpanit@amd.com, Janakarajan.Natarajan@amd.com,
          eranian@google.com, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org, vincent.weaver@maine.edu
In-Reply-To: <Message-ID:>
References: <Message-ID:>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/amd/uncore: Set ThreadMask and SliceMask
 for L3 Cache perf events
Git-Commit-ID: d7cbbe49a9304520181fb8c9272d1327deec8453
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

Commit-ID:  d7cbbe49a9304520181fb8c9272d1327deec8453
Gitweb:     https://git.kernel.org/tip/d7cbbe49a9304520181fb8c9272d1327deec8453
Author:     Natarajan, Janakarajan <Janakarajan.Natarajan@amd.com>
AuthorDate: Thu, 27 Sep 2018 15:51:55 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:38:04 +0200

perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf events

In Family 17h, some L3 Cache Performance events require the ThreadMask
and SliceMask to be set. For other events, these fields do not affect
the count either way.

Set ThreadMask and SliceMask to 0xFF and 0xF respectively.

Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Suravee <Suravee.Suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/Message-ID:
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/amd/uncore.c      | 10 ++++++++++
 arch/x86/include/asm/perf_event.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e8241b..8671de126eac 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -36,6 +36,7 @@
 
 static int num_counters_llc;
 static int num_counters_nb;
+static bool l3_mask;
 
 static HLIST_HEAD(uncore_unused_list);
 
@@ -209,6 +210,13 @@ static int amd_uncore_event_init(struct perf_event *event)
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
 
+	/*
+	 * SliceMask and ThreadMask need to be set for certain L3 events in
+	 * Family 17h. For other events, the two fields do not affect the count.
+	 */
+	if (l3_mask)
+		hwc->config |= (AMD64_L3_SLICE_MASK | AMD64_L3_THREAD_MASK);
+
 	if (event->cpu < 0)
 		return -EINVAL;
 
@@ -525,6 +533,7 @@ static int __init amd_uncore_init(void)
 		amd_llc_pmu.name	  = "amd_l3";
 		format_attr_event_df.show = &event_show_df;
 		format_attr_event_l3.show = &event_show_l3;
+		l3_mask			  = true;
 	} else {
 		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L2;
@@ -532,6 +541,7 @@ static int __init amd_uncore_init(void)
 		amd_llc_pmu.name	  = "amd_l2";
 		format_attr_event_df	  = format_attr_event;
 		format_attr_event_l3	  = format_attr_event;
+		l3_mask			  = false;
 	}
 
 	amd_nb_pmu.attr_groups	= amd_uncore_attr_groups_df;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 12f54082f4c8..78241b736f2a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -46,6 +46,14 @@
 #define INTEL_ARCH_EVENT_MASK	\
 	(ARCH_PERFMON_EVENTSEL_UMASK | ARCH_PERFMON_EVENTSEL_EVENT)
 
+#define AMD64_L3_SLICE_SHIFT				48
+#define AMD64_L3_SLICE_MASK				\
+	((0xFULL) << AMD64_L3_SLICE_SHIFT)
+
+#define AMD64_L3_THREAD_SHIFT				56
+#define AMD64_L3_THREAD_MASK				\
+	((0xFFULL) << AMD64_L3_THREAD_SHIFT)
+
 #define X86_RAW_EVENT_MASK		\
 	(ARCH_PERFMON_EVENTSEL_EVENT |	\
 	 ARCH_PERFMON_EVENTSEL_UMASK |	\
