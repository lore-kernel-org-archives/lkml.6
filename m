Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC63C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F6921722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F6921722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbeKLPzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:55:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbeKLPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:55:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAC62jNF3546727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Nov 2018 22:02:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAC62jXm3546724;
        Sun, 11 Nov 2018 22:02:45 -0800
Date:   Sun, 11 Nov 2018 22:02:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-4d47d6407ac7b4b442a4e717488a3bb137398b6c@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, peterz@infradead.org, hpa@zytor.com,
        vincent.weaver@maine.edu, acme@redhat.com,
        torvalds@linux-foundation.org, kan.liang@linux.intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: vincent.weaver@maine.edu, hpa@zytor.com, acme@redhat.com,
          torvalds@linux-foundation.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          eranian@google.com, jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          kan.liang@linux.intel.com
In-Reply-To: <20181019170419.378-2-kan.liang@linux.intel.com>
References: <20181019170419.378-2-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Support CoffeeLake 8th
 CBOX
Git-Commit-ID: 4d47d6407ac7b4b442a4e717488a3bb137398b6c
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

Commit-ID:  4d47d6407ac7b4b442a4e717488a3bb137398b6c
Gitweb:     https://git.kernel.org/tip/4d47d6407ac7b4b442a4e717488a3bb137398b6c
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Fri, 19 Oct 2018 10:04:19 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Nov 2018 05:03:26 +0100

perf/x86/intel/uncore: Support CoffeeLake 8th CBOX

Coffee Lake has 8 core products which has 8 Cboxes. The 8th CBOX is
mapped into different MSR space.

Increase the num_boxes to 8 to handle the new products. It will not
impact the previous platforms, SkyLake, KabyLake and earlier CoffeeLake.
Because the num_boxes will be recalculated in uncore_cpu_init and
doesn't exceed the x86_max_cores.

Introduce a new box flag bit to indicate the 8th CBOX.

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
Link: http://lkml.kernel.org/r/20181019170419.378-2-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.h     | 33 +++++++++++++++++++++++++--------
 arch/x86/events/intel/uncore_snb.c |  6 +++++-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index e17ab885b1e9..cb46d602a6b8 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -129,8 +129,15 @@ struct intel_uncore_box {
 	struct intel_uncore_extra_reg shared_regs[0];
 };
 
-#define UNCORE_BOX_FLAG_INITIATED	0
-#define UNCORE_BOX_FLAG_CTL_OFFS8	1 /* event config registers are 8-byte apart */
+/* CFL uncore 8th cbox MSRs */
+#define CFL_UNC_CBO_7_PERFEVTSEL0		0xf70
+#define CFL_UNC_CBO_7_PER_CTR0			0xf76
+
+#define UNCORE_BOX_FLAG_INITIATED		0
+/* event config registers are 8-byte apart */
+#define UNCORE_BOX_FLAG_CTL_OFFS8		1
+/* CFL 8th CBOX has different MSR space */
+#define UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS	2
 
 struct uncore_event_desc {
 	struct kobj_attribute attr;
@@ -297,17 +304,27 @@ unsigned int uncore_freerunning_counter(struct intel_uncore_box *box,
 static inline
 unsigned uncore_msr_event_ctl(struct intel_uncore_box *box, int idx)
 {
-	return box->pmu->type->event_ctl +
-		(box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
-		uncore_msr_box_offset(box);
+	if (test_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags)) {
+		return CFL_UNC_CBO_7_PERFEVTSEL0 +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx);
+	} else {
+		return box->pmu->type->event_ctl +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
+		       uncore_msr_box_offset(box);
+	}
 }
 
 static inline
 unsigned uncore_msr_perf_ctr(struct intel_uncore_box *box, int idx)
 {
-	return box->pmu->type->perf_ctr +
-		(box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
-		uncore_msr_box_offset(box);
+	if (test_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags)) {
+		return CFL_UNC_CBO_7_PER_CTR0 +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx);
+	} else {
+		return box->pmu->type->perf_ctr +
+		       (box->pmu->type->pair_ctr_ctl ? 2 * idx : idx) +
+		       uncore_msr_box_offset(box);
+	}
 }
 
 static inline
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index bfa25814fe5f..2593b0d7aeee 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -221,6 +221,10 @@ static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
 		wrmsrl(SKL_UNC_PERF_GLOBAL_CTL,
 			SNB_UNC_GLOBAL_CTL_EN | SKL_UNC_GLOBAL_CTL_CORE_ALL);
 	}
+
+	/* The 8th CBOX has different MSR space */
+	if (box->pmu->pmu_idx == 7)
+		__set_bit(UNCORE_BOX_FLAG_CFL8_CBOX_MSR_OFFS, &box->flags);
 }
 
 static void skl_uncore_msr_enable_box(struct intel_uncore_box *box)
@@ -247,7 +251,7 @@ static struct intel_uncore_ops skl_uncore_msr_ops = {
 static struct intel_uncore_type skl_uncore_cbox = {
 	.name		= "cbox",
 	.num_counters   = 4,
-	.num_boxes	= 5,
+	.num_boxes	= 8,
 	.perf_ctr_bits	= 44,
 	.fixed_ctr_bits	= 48,
 	.perf_ctr	= SNB_UNC_CBO_0_PER_CTR0,
