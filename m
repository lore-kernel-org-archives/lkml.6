Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A992C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3422E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfBKKpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:45:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:45:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAjF1N3497928
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:45:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAjFtl3497924;
        Mon, 11 Feb 2019 02:45:15 -0800
Date:   Mon, 11 Feb 2019 02:45:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-a96fff8df28ddd2f6710e5af454a45014c73183c@git.kernel.org>
Cc:     dsahern@gmail.com, namhyung@kernel.org, mingo@kernel.org,
        jolsa@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, hpa@zytor.com, vincent.weaver@maine.edu,
        peterz@infradead.org, torvalds@linux-foundation.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de
Reply-To: dsahern@gmail.com, namhyung@kernel.org, mingo@kernel.org,
          jolsa@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          eranian@google.com, vincent.weaver@maine.edu, hpa@zytor.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de
In-Reply-To: <1549319013-4522-3-git-send-email-kan.liang@linux.intel.com>
References: <1549319013-4522-3-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Clean up SNB PEBS quirk
Git-Commit-ID: a96fff8df28ddd2f6710e5af454a45014c73183c
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

Commit-ID:  a96fff8df28ddd2f6710e5af454a45014c73183c
Gitweb:     https://git.kernel.org/tip/a96fff8df28ddd2f6710e5af454a45014c73183c
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 4 Feb 2019 14:23:31 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:00:40 +0100

perf/x86/intel: Clean up SNB PEBS quirk

Clean up SNB PEBS quirk to use the new facility to check for min
microcode revisions.

Only check the boot CPU, assuming models and features are consistent
over all CPUs.

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
Link: https://lkml.kernel.org/r/1549319013-4522-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8fe2afa9c818..87f4ed203c07 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3792,36 +3792,21 @@ static __init void intel_pebs_isolation_quirk(void)
 	intel_check_pebs_isolation();
 }
 
-static int intel_snb_pebs_broken(int cpu)
-{
-	u32 rev = UINT_MAX; /* default to broken for unknown models */
-
-	switch (cpu_data(cpu).x86_model) {
-	case INTEL_FAM6_SANDYBRIDGE:
-		rev = 0x28;
-		break;
-
-	case INTEL_FAM6_SANDYBRIDGE_X:
-		switch (cpu_data(cpu).x86_stepping) {
-		case 6: rev = 0x618; break;
-		case 7: rev = 0x70c; break;
-		}
-	}
+static const struct x86_cpu_desc pebs_ucodes[] = {
+	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE,		7, 0x00000028),
+	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE_X,	6, 0x00000618),
+	INTEL_CPU_DESC(INTEL_FAM6_SANDYBRIDGE_X,	7, 0x0000070c),
+	{}
+};
 
-	return (cpu_data(cpu).microcode < rev);
+static bool intel_snb_pebs_broken(void)
+{
+	return !x86_cpu_has_min_microcode_rev(pebs_ucodes);
 }
 
 static void intel_snb_check_microcode(void)
 {
-	int pebs_broken = 0;
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		if ((pebs_broken = intel_snb_pebs_broken(cpu)))
-			break;
-	}
-
-	if (pebs_broken == x86_pmu.pebs_broken)
+	if (intel_snb_pebs_broken() == x86_pmu.pebs_broken)
 		return;
 
 	/*
