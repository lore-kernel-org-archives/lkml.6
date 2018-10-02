Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAA620878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAA620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeJBQxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:53:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50011 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:53:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92AA6401916140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:10:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92AA5Tg1916137;
        Tue, 2 Oct 2018 03:10:05 -0700
Date:   Tue, 2 Oct 2018 03:10:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-7c5314b88da6d5af98239786772a1c44cc5eb67d@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, tglx@linutronix.de, vincent.weaver@maine.edu,
        eranian@google.com, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, kan.liang@linux.intel.com
Reply-To: hpa@zytor.com, eranian@google.com, vincent.weaver@maine.edu,
          acme@redhat.com, kan.liang@linux.intel.com,
          alexander.shishkin@linux.intel.com,
          torvalds@linux-foundation.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, jolsa@redhat.com
In-Reply-To: <1533712328-2834-3-git-send-email-kan.liang@linux.intel.com>
References: <1533712328-2834-3-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Add quirk for Goldmont Plus
Git-Commit-ID: 7c5314b88da6d5af98239786772a1c44cc5eb67d
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

Commit-ID:  7c5314b88da6d5af98239786772a1c44cc5eb67d
Gitweb:     https://git.kernel.org/tip/7c5314b88da6d5af98239786772a1c44cc5eb67d
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Wed, 8 Aug 2018 00:12:08 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 10:14:33 +0200

perf/x86/intel: Add quirk for Goldmont Plus

A ucode patch is needed for Goldmont Plus while counter freezing feature
is enabled. Otherwise, there will be some issues, e.g. PMI flood with
some events.

Add a quirk to check microcode version. If the system starts with the
wrong ucode, leave the counter-freezing feature permanently disabled.

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
Link: http://lkml.kernel.org/r/1533712328-2834-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f17cf6c3ec6f..ab01ef9ddd77 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3839,6 +3839,40 @@ static __init void intel_nehalem_quirk(void)
 	}
 }
 
+static bool intel_glp_counter_freezing_broken(int cpu)
+{
+	u32 rev = UINT_MAX; /* default to broken for unknown stepping */
+
+	switch (cpu_data(cpu).x86_stepping) {
+	case 1:
+		rev = 0x28;
+		break;
+	case 8:
+		rev = 0x6;
+		break;
+	}
+
+	return (cpu_data(cpu).microcode < rev);
+}
+
+static __init void intel_glp_counter_freezing_quirk(void)
+{
+	/* Check if it's already disabled */
+	if (disable_counter_freezing)
+		return;
+
+	/*
+	 * If the system starts with the wrong ucode, leave the
+	 * counter-freezing feature permanently disabled.
+	 */
+	if (intel_glp_counter_freezing_broken(raw_smp_processor_id())) {
+		pr_info("PMU counter freezing disabled due to CPU errata,"
+			"please upgrade microcode\n");
+		x86_pmu.counter_freezing = false;
+		x86_pmu.handle_irq = intel_pmu_handle_irq;
+	}
+}
+
 /*
  * enable software workaround for errata:
  * SNB: BJ122
@@ -4188,6 +4222,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
+		x86_add_quirk(intel_glp_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glp_hw_cache_extra_regs,
