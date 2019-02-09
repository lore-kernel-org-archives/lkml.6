Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B115DC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1AF21773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBIM6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:58:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:58:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19Cupqv2633548
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:56:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CupGf2633545;
        Sat, 9 Feb 2019 04:56:51 -0800
Date:   Sat, 9 Feb 2019 04:56:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for William Cohen <tipbot@zytor.com>
Message-ID: <tip-2d08f87fe7a2e4d74dc8b0eb645737d83dd932a9@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com, acme@redhat.com,
        jolsa@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, namhyung@kernel.org,
        wcohen@redhat.com, alexander.shishkin@linux.intel.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, jolsa@redhat.com,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, alexander.shishkin@linux.intel.com,
          wcohen@redhat.com, peterz@infradead.org, mingo@kernel.org,
          namhyung@kernel.org
In-Reply-To: <20190129170536.22510-1-wcohen@redhat.com>
References: <20190129170536.22510-1-wcohen@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Fix
 Load_Miss_Real_Latency on CLX
Git-Commit-ID: 2d08f87fe7a2e4d74dc8b0eb645737d83dd932a9
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

Commit-ID:  2d08f87fe7a2e4d74dc8b0eb645737d83dd932a9
Gitweb:     https://git.kernel.org/tip/2d08f87fe7a2e4d74dc8b0eb645737d83dd932a9
Author:     William Cohen <wcohen@redhat.com>
AuthorDate: Tue, 29 Jan 2019 12:05:36 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf vendor events intel: Fix Load_Miss_Real_Latency on CLX

Fix incorrect event names for the Load_Miss_Real_Latency metric for
Cascadelake server in the same manner as commit 91b2b97025 for SKL/SKX.

Signed-off-by: William Cohen <wcohen@redhat.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190129170536.22510-1-wcohen@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 36c903faed0b..71e9737f4614 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -73,7 +73,7 @@
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS_PS + MEM_LOAD_RETIRED.FB_HIT_PS )",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
