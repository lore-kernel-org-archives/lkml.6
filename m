Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D43BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE0120863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBKKrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:47:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfBKKrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:47:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAkg183498106
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:46:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAkgOU3498103;
        Mon, 11 Feb 2019 02:46:42 -0800
Date:   Mon, 11 Feb 2019 02:46:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-af63147c1edacfb75a28885a7cd7e6f44e626164@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        torvalds@linux-foundation.org, dsahern@gmail.com, jolsa@redhat.com,
        kan.liang@linux.intel.com, acme@redhat.com, eranian@google.com,
        vincent.weaver@maine.edu, namhyung@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com
Reply-To: kan.liang@linux.intel.com, jolsa@redhat.com, acme@redhat.com,
          hpa@zytor.com, namhyung@kernel.org, eranian@google.com,
          vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, dsahern@gmail.com
In-Reply-To: <1549319013-4522-5-git-send-email-kan.liang@linux.intel.com>
References: <1549319013-4522-5-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Add counter freezing quirk for
 Goldmont
Git-Commit-ID: af63147c1edacfb75a28885a7cd7e6f44e626164
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

Commit-ID:  af63147c1edacfb75a28885a7cd7e6f44e626164
Gitweb:     https://git.kernel.org/tip/af63147c1edacfb75a28885a7cd7e6f44e626164
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 4 Feb 2019 14:23:33 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:00:42 +0100

perf/x86/intel: Add counter freezing quirk for Goldmont

A microcode patch is also needed for Goldmont while counter freezing
feature is enabled. Otherwise, there will be some issues, e.g. PMI lost.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1549319013-4522-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c79c0165d838..024a515d9102 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3924,8 +3924,12 @@ static __init void intel_nehalem_quirk(void)
 }
 
 static const struct x86_cpu_desc counter_freezing_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	1, 0x00000028),
-	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	8, 0x00000006),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	 2, 0x0000000e),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	 9, 0x0000002e),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT,	10, 0x00000008),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_X,	 1, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	 1, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	 8, 0x00000006),
 	{}
 };
 
@@ -4295,6 +4299,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ATOM_GOLDMONT:
 	case INTEL_FAM6_ATOM_GOLDMONT_X:
+		x86_add_quirk(intel_counter_freezing_quirk);
 		memcpy(hw_cache_event_ids, glm_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, glm_hw_cache_extra_regs,
