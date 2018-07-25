Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5E2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD5E2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbeGYPp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:45:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60735 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbeGYPpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:45:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEXXoF403274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:33:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEXX1G403271;
        Wed, 25 Jul 2018 07:33:33 -0700
Date:   Wed, 25 Jul 2018 07:33:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-a38b0ba1b7d2e7a6d19877540240e8a4352fc93c@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, torvalds@linux-foundation.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, hpa@zytor.com, vincent.weaver@maine.edu,
        eranian@google.com, mingo@kernel.org, jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          acme@redhat.com, torvalds@linux-foundation.org,
          peterz@infradead.org, eranian@google.com, mingo@kernel.org,
          hpa@zytor.com, vincent.weaver@maine.edu, jolsa@redhat.com
In-Reply-To: <20180309021542.11374-4-kan.liang@linux.intel.com>
References: <20180309021542.11374-4-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Support Extended PEBS for Goldmont
 Plus
Git-Commit-ID: a38b0ba1b7d2e7a6d19877540240e8a4352fc93c
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

Commit-ID:  a38b0ba1b7d2e7a6d19877540240e8a4352fc93c
Gitweb:     https://git.kernel.org/tip/a38b0ba1b7d2e7a6d19877540240e8a4352fc93c
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 8 Mar 2018 18:15:42 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:50:50 +0200

perf/x86/intel: Support Extended PEBS for Goldmont Plus

Enable the extended PEBS for Goldmont Plus.

There is no specific PEBS constrains for Goldmont Plus. Removing the
pebs_constraints for Goldmont Plus.

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
Link: http://lkml.kernel.org/r/20180309021542.11374-4-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/ds.c   | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b1a49a108a59..035c37481f57 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4077,7 +4077,6 @@ __init int intel_pmu_init(void)
 		intel_pmu_lbr_init_skl();
 
 		x86_pmu.event_constraints = intel_slm_event_constraints;
-		x86_pmu.pebs_constraints = intel_glp_pebs_event_constraints;
 		x86_pmu.extra_regs = intel_glm_extra_regs;
 		/*
 		 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
@@ -4087,6 +4086,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.get_event_constraints = glp_get_event_constraints;
 		x86_pmu.cpu_events = glm_events_attrs;
 		/* Goldmont Plus has 4-wide pipeline */
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 595b96ae8a00..b7b01d762d32 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -713,12 +713,6 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
-struct event_constraint intel_glp_pebs_event_constraints[] = {
-	/* Allow all events as PEBS with no flags */
-	INTEL_ALL_EVENT_CONSTRAINT(0, 0xf),
-	EVENT_CONSTRAINT_END
-};
-
 struct event_constraint intel_nehalem_pebs_event_constraints[] = {
 	INTEL_PLD_CONSTRAINT(0x100b, 0xf),      /* MEM_INST_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0x0f, 0xf),    /* MEM_UNCORE_RETIRED.* */
