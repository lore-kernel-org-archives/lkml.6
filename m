Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925F62086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfA2RFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:05:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbfA2RFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:05:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF3D2A1F6A;
        Tue, 29 Jan 2019 17:05:39 +0000 (UTC)
Received: from cervelo.rdu.redhat.com (dhcp129-79.rdu.redhat.com [10.13.129.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EDF660152;
        Tue, 29 Jan 2019 17:05:38 +0000 (UTC)
From:   William Cohen <wcohen@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com,
        William Cohen <wcohen@redhat.com>
Subject: [PATCH] perf vendor events intel: Fix Load_Miss_Real_Latency on CLX
Date:   Tue, 29 Jan 2019 12:05:36 -0500
Message-Id: <20190129170536.22510-1-wcohen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 29 Jan 2019 17:05:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect event names for the Load_Miss_Real_Latency metric for
Cascadelake server in the same manner as commit 91b2b97025 for SKL/SKX.

Signed-off-by: William Cohen <wcohen@redhat.com>
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
-- 
2.20.1

