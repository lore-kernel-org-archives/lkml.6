Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFE5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E8D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C64Hzwe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E8D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbeJPMTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728476AbeJPMBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED7E2147E;
        Tue, 16 Oct 2018 04:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663208;
        bh=teYqKc2QKMH2yDXkOLoeLejMMmqqbv9QLbb47DLBa4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C64Hzwe89GycpdwV/qqf20c2mfScPRMPYDa29LK2yrujkzdthQywiuD76Au9nr0O+
         ei9nkJp33sPk1GMI4qOSvqwmZUEbhdRE5RB80uJJjdeWZF6PC1RM7W4kHhccnfmWq+
         Px3hVSFAptrT2TM3ciMKp+9dXb9+eEl9pud1tbqc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Suravee <Suravee.Suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 069/100] perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf events
Date:   Tue, 16 Oct 2018 00:11:50 -0400
Message-Id: <20181016041221.135528-69-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>

[ Upstream commit d7cbbe49a9304520181fb8c9272d1327deec8453 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
-- 
2.17.1

