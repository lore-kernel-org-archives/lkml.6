Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107F4C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E12B208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131750;
	bh=58MIey2wDj7CNRWCaPAUHGhmH5+vjF2O3IbtCiwZ30c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1lo3b6mA1xSgHKWjEKu6+sFL/qLT2z5HGpT4rFVpbvnIwPRfSRqGtrsTgeqTMdgGH
	 xrhbQeuLakujwd8hLPLQgx5pmyMx5Fe1d7BD0fXa51XoX/5VyR3zI/ioz9JkYug3o9
	 4aTtHMz8uSoQwU0/mEF6snWMAd0o1QSx3Is8skrI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E12B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeLFV3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeLFV3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:04 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8ACC20989;
        Thu,  6 Dec 2018 21:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131742;
        bh=58MIey2wDj7CNRWCaPAUHGhmH5+vjF2O3IbtCiwZ30c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5vTvahF9GkD2CVFP4I4WsReSDJPTVBaoEsYPTJIpPbaUlBSTmFz//zk9GyoIehme
         sP3fNdor0mnX7vg8lhajkdgrM7i2jn4k3O+ix0gD+EuKO3Lm+caYFgG1vzg7Ao1mnG
         qm7mMGT1CXD7H+1mnxIFeOLAib/MI8HFmK5TVo04=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/75] perf vendor events intel: Fix diverse typos
Date:   Thu,  6 Dec 2018 18:25:24 -0300
Message-Id: <20181206212602.20474-38-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

( Care should be taken not to re-import these typos in the future,
  if the JSON files get updated by the vendor without fixing the typos. )

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/x86/broadwell/cache.json  |  4 +--
 .../arch/x86/broadwell/pipeline.json          |  2 +-
 .../arch/x86/broadwellde/cache.json           |  4 +--
 .../arch/x86/broadwellde/pipeline.json        |  2 +-
 .../pmu-events/arch/x86/broadwellx/cache.json |  4 +--
 .../arch/x86/broadwellx/pipeline.json         |  2 +-
 .../pmu-events/arch/x86/jaketown/cache.json   |  4 +--
 .../arch/x86/jaketown/pipeline.json           |  2 +-
 .../arch/x86/knightslanding/cache.json        | 30 +++++++++----------
 .../arch/x86/sandybridge/cache.json           |  4 +--
 .../arch/x86/sandybridge/pipeline.json        |  2 +-
 .../arch/x86/skylakex/uncore-other.json       | 12 ++++----
 12 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/cache.json b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
index bba3152ec54a..0b080b0352d8 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
@@ -433,7 +433,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x41",
@@ -445,7 +445,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x42",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
index 97c5d0784c6c..999cf3066363 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
@@ -317,7 +317,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
         "EventCode": "0x87",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
index bf243fe2a0ec..4ad425312bdc 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
@@ -439,7 +439,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -451,7 +451,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "L1_Hit_Indication": "1",
         "CounterHTOff": "0,1,2,3"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 920c89da9111..0d04bf9db000 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -322,7 +322,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
         "Counter": "0,1,2,3",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
index bf0c51272068..141b1080429d 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
@@ -439,7 +439,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -451,7 +451,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "L1_Hit_Indication": "1",
         "CounterHTOff": "0,1,2,3"
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
index 920c89da9111..0d04bf9db000 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
@@ -322,7 +322,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
         "Counter": "0,1,2,3",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/cache.json b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
index f723e8f7bb09..ee22e4a5e30d 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/cache.json
@@ -31,7 +31,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x41",
@@ -42,7 +42,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x42",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
index 8a597e45ed84..34a519d9bfa0 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
@@ -778,7 +778,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceeding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
         "EventCode": "0x03",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
index 88ba5994b994..e434ec723001 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -121,7 +121,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any Prefetch requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -187,7 +187,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any Read request  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -253,7 +253,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -319,7 +319,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -385,7 +385,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -451,7 +451,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any request that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -539,7 +539,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts L1 data HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -605,7 +605,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Software Prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -682,7 +682,7 @@
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Bus locks and split lock requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -748,7 +748,7 @@
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -869,7 +869,7 @@
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -935,7 +935,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts L2 code HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -1067,7 +1067,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -1133,7 +1133,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data writes that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
@@ -1199,7 +1199,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
         "Offcore": "1"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
index bef73c499f83..16b04a20bc12 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
@@ -31,7 +31,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x41",
@@ -42,7 +42,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x42",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index 8a597e45ed84..34a519d9bfa0 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -778,7 +778,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceeding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
+        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
         "EventCode": "0x03",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
index de6e70e552e2..adb42c72f5c8 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
@@ -428,7 +428,7 @@
         "EventCode": "0x5C",
         "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This reponse will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
+        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This response will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
         "UMask": "0x10",
         "Unit": "CHA"
     },
@@ -967,7 +967,7 @@
         "EventCode": "0x57",
         "EventName": "UNC_M2M_PREFCAM_INSERTS",
         "PerPkg": "1",
-        "PublicDescription": "Counts when the M2M (Mesh to Memory) recieves a prefetch request and inserts it into its outstanding prefetch queue.  Explanatory Side Note: the prefect queue is made from CAM: Content Addressable Memory",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) receives a prefetch request and inserts it into its outstanding prefetch queue.  Explanatory Side Note: the prefect queue is made from CAM: Content Addressable Memory",
         "Unit": "M2M"
     },
     {
@@ -1041,7 +1041,7 @@
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
         "UMask": "0x1",
         "Unit": "UPI LL"
     },
@@ -1051,17 +1051,17 @@
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly across the BGF and into the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly across the BGF and into the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
         "UMask": "0x2",
         "Unit": "UPI LL"
     },
     {
-        "BriefDescription": "FLITs received which bypassed the Slot0 Recieve Buffer",
+        "BriefDescription": "FLITs received which bypassed the Slot0 Receive Buffer",
         "Counter": "0,1,2,3",
         "EventCode": "0x31",
         "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
         "PerPkg": "1",
-        "PublicDescription": "Counts incoming FLITs (FLow control unITs) whcih bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transferred, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
         "UMask": "0x4",
         "Unit": "UPI LL"
     },
-- 
2.19.2

