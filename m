Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B2420852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B2420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeGYPqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:46:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbeGYPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:46:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEVtHQ402949
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:31:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEVtUh402946;
        Wed, 25 Jul 2018 07:31:55 -0700
Date:   Wed, 25 Jul 2018 07:31:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-3196234039155a33c80e52d7aa41a29dce9a5c51@git.kernel.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
        vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, mingo@kernel.org, eranian@google.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com, acme@redhat.com,
          vincent.weaver@maine.edu, peterz@infradead.org,
          tglx@linutronix.de, eranian@google.com,
          kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
          jolsa@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180309021542.11374-1-kan.liang@linux.intel.com>
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Introduce PMU flag for Extended
 PEBS
Git-Commit-ID: 3196234039155a33c80e52d7aa41a29dce9a5c51
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

Commit-ID:  3196234039155a33c80e52d7aa41a29dce9a5c51
Gitweb:     https://git.kernel.org/tip/3196234039155a33c80e52d7aa41a29dce9a5c51
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 8 Mar 2018 18:15:39 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:50:49 +0200

perf/x86/intel: Introduce PMU flag for Extended PEBS

The Extended PEBS feature, introduced in the Goldmont Plus
microarchitecture, supports all events as "Extended PEBS".

Introduce flag PMU_FL_PEBS_ALL to indicate the platforms which support
extended PEBS.

To support all events, it needs to support all constraints for PEBS. To
avoid duplicating all the constraints in the PEBS table, making the PEBS
code search the normal constraints too.

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
Link: http://lkml.kernel.org/r/20180309021542.11374-1-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/ds.c   | 7 +++++++
 arch/x86/events/perf_event.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8dbba77e0518..9fd9cb1d2cc8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -871,6 +871,13 @@ struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 		}
 	}
 
+	/*
+	 * Extended PEBS support
+	 * Makes the PEBS code search the normal constraints.
+	 */
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
+		return NULL;
+
 	return &emptyconstraint;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2430398befd8..156286335351 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -673,6 +673,7 @@ do {									\
 #define PMU_FL_HAS_RSP_1	0x2 /* has 2 equivalent offcore_rsp regs   */
 #define PMU_FL_EXCL_CNTRS	0x4 /* has exclusive counter requirements  */
 #define PMU_FL_EXCL_ENABLED	0x8 /* exclusive counter active */
+#define PMU_FL_PEBS_ALL		0x10 /* all events are valid PEBS events */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
