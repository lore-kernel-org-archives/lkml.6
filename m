Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD85AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B3A20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+7hNdhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B3A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbeGYTNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbeGYTNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:13:45 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADB32088E;
        Wed, 25 Jul 2018 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541658;
        bh=zQQbTf/nZ2aG5oN8tJsQ9IfuageL+TiIuLQLkaQSM60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+7hNdhcIeT0e2S00r9l0VU6PwjD2261DEc6XBAY6x8rs0pddHujDpmPEE34jv18z
         Mpo1jJxBQ4xoRRYk8ewuEM9wmD2Yb/Q8jXYkIn8/Pk233SuukOv4mUs9txIEHI9aoQ
         yu/RhAEl7LRmOqgDBCHCsamzALupqYM2f++iO2TU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/27] perf list: Add s390 support for detailed PMU event description
Date:   Wed, 25 Jul 2018 14:59:40 -0300
Message-Id: <20180725180001.15108-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Correct the support of detailed/verbose PMU event description by using
the "Unit": keyword in the json files to address event names refering to
the /sys/devices/cpum_[cs]f devices.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180621080452.61012-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z10/basic.json  | 12 +++++
 tools/perf/pmu-events/arch/s390/cf_z10/crypto.json | 16 +++++++
 .../perf/pmu-events/arch/s390/cf_z10/extended.json | 18 +++++++
 tools/perf/pmu-events/arch/s390/cf_z13/basic.json  | 12 +++++
 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json | 16 +++++++
 .../perf/pmu-events/arch/s390/cf_z13/extended.json | 56 ++++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/cf_z14/basic.json  |  8 ++++
 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json | 16 +++++++
 .../perf/pmu-events/arch/s390/cf_z14/extended.json | 53 ++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/cf_z196/basic.json | 12 +++++
 .../perf/pmu-events/arch/s390/cf_z196/crypto.json  | 16 +++++++
 .../pmu-events/arch/s390/cf_z196/extended.json     | 24 ++++++++++
 .../perf/pmu-events/arch/s390/cf_zec12/basic.json  | 12 +++++
 .../perf/pmu-events/arch/s390/cf_zec12/crypto.json | 16 +++++++
 .../pmu-events/arch/s390/cf_zec12/extended.json    | 35 ++++++++++++++
 tools/perf/pmu-events/jevents.c                    |  2 +
 16 files changed, 324 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
index 8bf16759ca53..2dd8dafff2ef 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
@@ -1,71 +1,83 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "0",
 		"EventName": "CPU_CYCLES",
 		"BriefDescription": "CPU Cycles",
 		"PublicDescription": "Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "1",
 		"EventName": "INSTRUCTIONS",
 		"BriefDescription": "Instructions",
 		"PublicDescription": "Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "2",
 		"EventName": "L1I_DIR_WRITES",
 		"BriefDescription": "L1I Directory Writes",
 		"PublicDescription": "Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "3",
 		"EventName": "L1I_PENALTY_CYCLES",
 		"BriefDescription": "L1I Penalty Cycles",
 		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "4",
 		"EventName": "L1D_DIR_WRITES",
 		"BriefDescription": "L1D Directory Writes",
 		"PublicDescription": "Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "5",
 		"EventName": "L1D_PENALTY_CYCLES",
 		"BriefDescription": "L1D Penalty Cycles",
 		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "32",
 		"EventName": "PROBLEM_STATE_CPU_CYCLES",
 		"BriefDescription": "Problem-State CPU Cycles",
 		"PublicDescription": "Problem-State Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "33",
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "34",
 		"EventName": "PROBLEM_STATE_L1I_DIR_WRITES",
 		"BriefDescription": "Problem-State L1I Directory Writes",
 		"PublicDescription": "Problem-State Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "35",
 		"EventName": "PROBLEM_STATE_L1I_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1I Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "36",
 		"EventName": "PROBLEM_STATE_L1D_DIR_WRITES",
 		"BriefDescription": "Problem-State L1D Directory Writes",
 		"PublicDescription": "Problem-State Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "37",
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
index 7e5b72492141..db286f19e7b6 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
@@ -1,95 +1,111 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "64",
 		"EventName": "PRNG_FUNCTIONS",
 		"BriefDescription": "PRNG Functions",
 		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "65",
 		"EventName": "PRNG_CYCLES",
 		"BriefDescription": "PRNG Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "66",
 		"EventName": "PRNG_BLOCKED_FUNCTIONS",
 		"BriefDescription": "PRNG Blocked Functions",
 		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "67",
 		"EventName": "PRNG_BLOCKED_CYCLES",
 		"BriefDescription": "PRNG Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "68",
 		"EventName": "SHA_FUNCTIONS",
 		"BriefDescription": "SHA Functions",
 		"PublicDescription": "Total number of SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "69",
 		"EventName": "SHA_CYCLES",
 		"BriefDescription": "SHA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "70",
 		"EventName": "SHA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "SHA Blocked Functions",
 		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "71",
 		"EventName": "SHA_BLOCKED_CYCLES",
 		"BriefDescription": "SHA Bloced Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "72",
 		"EventName": "DEA_FUNCTIONS",
 		"BriefDescription": "DEA Functions",
 		"PublicDescription": "Total number of the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "73",
 		"EventName": "DEA_CYCLES",
 		"BriefDescription": "DEA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "74",
 		"EventName": "DEA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "DEA Blocked Functions",
 		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "75",
 		"EventName": "DEA_BLOCKED_CYCLES",
 		"BriefDescription": "DEA Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "76",
 		"EventName": "AES_FUNCTIONS",
 		"BriefDescription": "AES Functions",
 		"PublicDescription": "Total number of AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "77",
 		"EventName": "AES_CYCLES",
 		"BriefDescription": "AES Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "78",
 		"EventName": "AES_BLOCKED_FUNCTIONS",
 		"BriefDescription": "AES Blocked Functions",
 		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "79",
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
index 0feedb40f30f..b6b7f29ca831 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
@@ -1,107 +1,125 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "128",
 		"EventName": "L1I_L2_SOURCED_WRITES",
 		"BriefDescription": "L1I L2 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from the Level-2 (L1.5) cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "L1D_L2_SOURCED_WRITES",
 		"BriefDescription": "L1D L2 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the installed cache line was sourced from the Level-2 (L1.5) cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "130",
 		"EventName": "L1I_L3_LOCAL_WRITES",
 		"BriefDescription": "L1I L3 Local Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the installed cache line was sourced from the Level-3 cache that is on the same book as the Instruction cache (Local L2 cache)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "L1D_L3_LOCAL_WRITES",
 		"BriefDescription": "L1D L3 Local Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the installtion cache line was source from the Level-3 cache that is on the same book as the Data cache (Local L2 cache)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "132",
 		"EventName": "L1I_L3_REMOTE_WRITES",
 		"BriefDescription": "L1I L3 Remote Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the installed cache line was sourced from a Level-3 cache that is not on the same book as the Instruction cache (Remote L2 cache)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "L1D_L3_REMOTE_WRITES",
 		"BriefDescription": "L1D L3 Remote Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the installed cache line was sourced from a Level-3 cache that is not on the same book as the Data cache (Remote L2 cache)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "L1D_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1D Local Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "L1I_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1I Local Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache where the installed cache line was sourced from memory that is attached to the s ame book as the Instruction cache (Local Memory)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "136",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "L1I_CACHELINE_INVALIDATES",
 		"BriefDescription": "L1I Cacheline Invalidates",
 		"PublicDescription": "A cache line in the Level-1 I-Cache has been invalidated by a store on the same CPU as the Level-1 I-Cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "ITLB1_WRITES",
 		"BriefDescription": "ITLB1 Writes",
 		"PublicDescription": "A translation entry has been written into the Level-1 Instruction Translation Lookaside Buffer"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "DTLB1_WRITES",
 		"BriefDescription": "DTLB1 Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "142",
 		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
 		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "ITLB1_MISSES",
 		"BriefDescription": "ITLB1 Misses",
 		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle an ITLB1 miss is in progress"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "DTLB1_MISSES",
 		"BriefDescription": "DTLB1 Misses",
 		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle an DTLB1 miss is in progress"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L2C_STORES_SENT",
 		"BriefDescription": "L2C Stores Sent",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
index 8bf16759ca53..2dd8dafff2ef 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
@@ -1,71 +1,83 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "0",
 		"EventName": "CPU_CYCLES",
 		"BriefDescription": "CPU Cycles",
 		"PublicDescription": "Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "1",
 		"EventName": "INSTRUCTIONS",
 		"BriefDescription": "Instructions",
 		"PublicDescription": "Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "2",
 		"EventName": "L1I_DIR_WRITES",
 		"BriefDescription": "L1I Directory Writes",
 		"PublicDescription": "Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "3",
 		"EventName": "L1I_PENALTY_CYCLES",
 		"BriefDescription": "L1I Penalty Cycles",
 		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "4",
 		"EventName": "L1D_DIR_WRITES",
 		"BriefDescription": "L1D Directory Writes",
 		"PublicDescription": "Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "5",
 		"EventName": "L1D_PENALTY_CYCLES",
 		"BriefDescription": "L1D Penalty Cycles",
 		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "32",
 		"EventName": "PROBLEM_STATE_CPU_CYCLES",
 		"BriefDescription": "Problem-State CPU Cycles",
 		"PublicDescription": "Problem-State Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "33",
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "34",
 		"EventName": "PROBLEM_STATE_L1I_DIR_WRITES",
 		"BriefDescription": "Problem-State L1I Directory Writes",
 		"PublicDescription": "Problem-State Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "35",
 		"EventName": "PROBLEM_STATE_L1I_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1I Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "36",
 		"EventName": "PROBLEM_STATE_L1D_DIR_WRITES",
 		"BriefDescription": "Problem-State L1D Directory Writes",
 		"PublicDescription": "Problem-State Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "37",
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
index 7e5b72492141..db286f19e7b6 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
@@ -1,95 +1,111 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "64",
 		"EventName": "PRNG_FUNCTIONS",
 		"BriefDescription": "PRNG Functions",
 		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "65",
 		"EventName": "PRNG_CYCLES",
 		"BriefDescription": "PRNG Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "66",
 		"EventName": "PRNG_BLOCKED_FUNCTIONS",
 		"BriefDescription": "PRNG Blocked Functions",
 		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "67",
 		"EventName": "PRNG_BLOCKED_CYCLES",
 		"BriefDescription": "PRNG Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "68",
 		"EventName": "SHA_FUNCTIONS",
 		"BriefDescription": "SHA Functions",
 		"PublicDescription": "Total number of SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "69",
 		"EventName": "SHA_CYCLES",
 		"BriefDescription": "SHA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "70",
 		"EventName": "SHA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "SHA Blocked Functions",
 		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "71",
 		"EventName": "SHA_BLOCKED_CYCLES",
 		"BriefDescription": "SHA Bloced Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "72",
 		"EventName": "DEA_FUNCTIONS",
 		"BriefDescription": "DEA Functions",
 		"PublicDescription": "Total number of the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "73",
 		"EventName": "DEA_CYCLES",
 		"BriefDescription": "DEA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "74",
 		"EventName": "DEA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "DEA Blocked Functions",
 		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "75",
 		"EventName": "DEA_BLOCKED_CYCLES",
 		"BriefDescription": "DEA Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "76",
 		"EventName": "AES_FUNCTIONS",
 		"BriefDescription": "AES Functions",
 		"PublicDescription": "Total number of AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "77",
 		"EventName": "AES_CYCLES",
 		"BriefDescription": "AES Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "78",
 		"EventName": "AES_BLOCKED_FUNCTIONS",
 		"BriefDescription": "AES Blocked Functions",
 		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "79",
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
index 9a002b6967f1..436ce33f1182 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
@@ -1,335 +1,391 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "DTLB1_WRITES",
 		"BriefDescription": "DTLB1 Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "130",
 		"EventName": "DTLB1_MISSES",
 		"BriefDescription": "DTLB1 Misses",
 		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle a DTLB1 miss is in progress."
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "DTLB1_HPAGE_WRITES",
 		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "132",
 		"EventName": "DTLB1_GPAGE_WRITES",
 		"BriefDescription": "DTLB1 Two-Gigabyte Page Writes",
 		"PublicDescription": "Counter:132	Name:DTLB1_GPAGE_WRITES A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a two-gigabyte page."
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "L1D_L2D_SOURCED_WRITES",
 		"BriefDescription": "L1D L2D Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "ITLB1_WRITES",
 		"BriefDescription": "ITLB1 Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "ITLB1_MISSES",
 		"BriefDescription": "ITLB1 Misses",
 		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle an ITLB1 miss is in progress"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "136",
 		"EventName": "L1I_L2I_SOURCED_WRITES",
 		"BriefDescription": "L1I L2I Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
 		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Combined Region Segment Table Entry arrays for a one-megabyte large page translation"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Combined Region Segment Table Entry arrays"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "TX_C_TEND",
 		"BriefDescription": "Completed TEND instructions in constrained TX mode",
 		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "TX_NC_TEND",
 		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
 		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "143",
 		"EventName": "L1C_TLB1_MISSES",
 		"BriefDescription": "L1C TLB1 Misses",
 		"PublicDescription": "Increments by one for any cycle where a Level-1 cache or Level-1 TLB miss is in progress."
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "144",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "L1D_ONNODE_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Node L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L1D_ONNODE_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Node L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "L1D_ONNODE_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Node L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "149",
 		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_ONDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Drawer L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "151",
 		"EventName": "L1D_ONDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFDRAWER_SCOL_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Same-Column L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Drawer Same-Column L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "154",
 		"EventName": "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Same-Column L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1D_OFFDRAWER_FCOL_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "156",
 		"EventName": "L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "157",
 		"EventName": "L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "158",
 		"EventName": "L1D_ONNODE_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Node Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Node memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "159",
 		"EventName": "L1D_ONDRAWER_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "160",
 		"EventName": "L1D_OFFDRAWER_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "161",
 		"EventName": "L1D_ONCHIP_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "162",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "163",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "164",
 		"EventName": "L1I_ONNODE_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "165",
 		"EventName": "L1I_ONNODE_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Node L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "166",
 		"EventName": "L1I_ONNODE_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Node L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "167",
 		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "168",
 		"EventName": "L1I_ONDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Drawer L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "169",
 		"EventName": "L1I_ONDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "170",
 		"EventName": "L1I_OFFDRAWER_SCOL_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Same-Column L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "171",
 		"EventName": "L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Drawer Same-Column L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "172",
 		"EventName": "L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Same-Column L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "173",
 		"EventName": "L1I_OFFDRAWER_FCOL_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Far-Column L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "174",
 		"EventName": "L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Drawer Far-Column L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "175",
 		"EventName": "L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Far-Column L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "176",
 		"EventName": "L1I_ONNODE_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Node Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Node memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "177",
 		"EventName": "L1I_ONDRAWER_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "178",
 		"EventName": "L1I_OFFDRAWER_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "179",
 		"EventName": "L1I_ONCHIP_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Chip memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "218",
 		"EventName": "TX_NC_TABORT",
 		"BriefDescription": "Aborted transactions in non-constrained TX mode",
 		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "219",
 		"EventName": "TX_C_TABORT_NO_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
 		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "220",
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
 		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "448",
 		"EventName": "MT_DIAG_CYCLES_ONE_THR_ACTIVE",
 		"BriefDescription": "Cycle count with one thread active",
 		"PublicDescription": "Cycle count with one thread active"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "449",
 		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
 		"BriefDescription": "Cycle count with two threads active",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
index 8f653c9d899d..17fb5241928b 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
@@ -1,47 +1,55 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "0",
 		"EventName": "CPU_CYCLES",
 		"BriefDescription": "CPU Cycles",
 		"PublicDescription": "Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "1",
 		"EventName": "INSTRUCTIONS",
 		"BriefDescription": "Instructions",
 		"PublicDescription": "Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "2",
 		"EventName": "L1I_DIR_WRITES",
 		"BriefDescription": "L1I Directory Writes",
 		"PublicDescription": "Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "3",
 		"EventName": "L1I_PENALTY_CYCLES",
 		"BriefDescription": "L1I Penalty Cycles",
 		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "4",
 		"EventName": "L1D_DIR_WRITES",
 		"BriefDescription": "L1D Directory Writes",
 		"PublicDescription": "Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "5",
 		"EventName": "L1D_PENALTY_CYCLES",
 		"BriefDescription": "L1D Penalty Cycles",
 		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "32",
 		"EventName": "PROBLEM_STATE_CPU_CYCLES",
 		"BriefDescription": "Problem-State CPU Cycles",
 		"PublicDescription": "Problem-State Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "33",
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
index 7e5b72492141..db286f19e7b6 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
@@ -1,95 +1,111 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "64",
 		"EventName": "PRNG_FUNCTIONS",
 		"BriefDescription": "PRNG Functions",
 		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "65",
 		"EventName": "PRNG_CYCLES",
 		"BriefDescription": "PRNG Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "66",
 		"EventName": "PRNG_BLOCKED_FUNCTIONS",
 		"BriefDescription": "PRNG Blocked Functions",
 		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "67",
 		"EventName": "PRNG_BLOCKED_CYCLES",
 		"BriefDescription": "PRNG Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "68",
 		"EventName": "SHA_FUNCTIONS",
 		"BriefDescription": "SHA Functions",
 		"PublicDescription": "Total number of SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "69",
 		"EventName": "SHA_CYCLES",
 		"BriefDescription": "SHA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "70",
 		"EventName": "SHA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "SHA Blocked Functions",
 		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "71",
 		"EventName": "SHA_BLOCKED_CYCLES",
 		"BriefDescription": "SHA Bloced Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "72",
 		"EventName": "DEA_FUNCTIONS",
 		"BriefDescription": "DEA Functions",
 		"PublicDescription": "Total number of the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "73",
 		"EventName": "DEA_CYCLES",
 		"BriefDescription": "DEA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "74",
 		"EventName": "DEA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "DEA Blocked Functions",
 		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "75",
 		"EventName": "DEA_BLOCKED_CYCLES",
 		"BriefDescription": "DEA Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "76",
 		"EventName": "AES_FUNCTIONS",
 		"BriefDescription": "AES Functions",
 		"PublicDescription": "Total number of AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "77",
 		"EventName": "AES_CYCLES",
 		"BriefDescription": "AES Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "78",
 		"EventName": "AES_BLOCKED_FUNCTIONS",
 		"BriefDescription": "AES Blocked Functions",
 		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "79",
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index aa4dfb46b65b..e7a3524b748f 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -1,317 +1,370 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
 		"PublicDescription": "Counter:128	Name:L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "DTLB2_WRITES",
 		"BriefDescription": "DTLB2 Writes",
 		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the data cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "130",
 		"EventName": "DTLB2_MISSES",
 		"BriefDescription": "DTLB2 Misses",
 		"PublicDescription": "A TLB2 miss is in progress for a request made by the data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "DTLB2_HPAGE_WRITES",
 		"BriefDescription": "DTLB2 One-Megabyte Page Writes",
 		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page or a Last Host Translation was done"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "132",
 		"EventName": "DTLB2_GPAGE_WRITES",
 		"BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
 		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "L1D_L2D_SOURCED_WRITES",
 		"BriefDescription": "L1D L2D Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "ITLB2_WRITES",
 		"BriefDescription": "ITLB2 Writes",
 		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "ITLB2_MISSES",
 		"BriefDescription": "ITLB2 Misses",
 		"PublicDescription": "A TLB2 miss is in progress for a request made by the instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "136",
 		"EventName": "L1I_L2I_SOURCED_WRITES",
 		"BriefDescription": "L1I L2I Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
 		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
 		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "TLB2_ENGINES_BUSY",
 		"BriefDescription": "TLB2 Engines Busy",
 		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "TX_C_TEND",
 		"BriefDescription": "Completed TEND instructions in constrained TX mode",
 		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "TX_NC_TEND",
 		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
 		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "143",
 		"EventName": "L1C_TLB2_MISSES",
 		"BriefDescription": "L1C TLB2 Misses",
 		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "144",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "L1D_ONCHIP_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Cluster L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Cluster Level-3 cache withountervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "L1D_ONCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Cluster Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "149",
 		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Cluster L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "151",
 		"EventName": "L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Cluster Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Cluster memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "154",
 		"EventName": "L1D_OFFDRAWER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "156",
 		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "157",
 		"EventName": "L1D_OFFDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "158",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_RO",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes read-only",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip L3 but a read-only invalidate was done to remove other copies of the cache line"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "162",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "163",
 		"EventName": "L1I_ONCHIP_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from On-Chip memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "164",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "165",
 		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Cluster L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "166",
 		"EventName": "L1I_ONCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Cluster Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "167",
 		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Cluster L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Cluster Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "168",
 		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "169",
 		"EventName": "L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Cluster Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Cluster memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "170",
 		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "171",
 		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "172",
 		"EventName": "L1I_OFFDRAWER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "173",
 		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "174",
 		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "175",
 		"EventName": "L1I_OFFDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "224",
 		"EventName": "BCD_DFP_EXECUTION_SLOTS",
 		"BriefDescription": "BCD DFP Execution Slots",
 		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "225",
 		"EventName": "VX_BCD_EXECUTION_SLOTS",
 		"BriefDescription": "VX BCD Execution Slots",
 		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "226",
 		"EventName": "DECIMAL_INSTRUCTIONS",
 		"BriefDescription": "Decimal Instructions",
 		"PublicDescription": "Decimal instructions dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "232",
 		"EventName": "LAST_HOST_TRANSLATIONS",
 		"BriefDescription": "Last host translation done",
 		"PublicDescription": "Last Host Translation done"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "243",
 		"EventName": "TX_NC_TABORT",
 		"BriefDescription": "Aborted transactions in non-constrained TX mode",
 		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "244",
 		"EventName": "TX_C_TABORT_NO_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
 		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "245",
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
 		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "448",
 		"EventName": "MT_DIAG_CYCLES_ONE_THR_ACTIVE",
 		"BriefDescription": "Cycle count with one thread active",
 		"PublicDescription": "Cycle count with one thread active"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "449",
 		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
 		"BriefDescription": "Cycle count with two threads active",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
index 8bf16759ca53..2dd8dafff2ef 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
@@ -1,71 +1,83 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "0",
 		"EventName": "CPU_CYCLES",
 		"BriefDescription": "CPU Cycles",
 		"PublicDescription": "Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "1",
 		"EventName": "INSTRUCTIONS",
 		"BriefDescription": "Instructions",
 		"PublicDescription": "Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "2",
 		"EventName": "L1I_DIR_WRITES",
 		"BriefDescription": "L1I Directory Writes",
 		"PublicDescription": "Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "3",
 		"EventName": "L1I_PENALTY_CYCLES",
 		"BriefDescription": "L1I Penalty Cycles",
 		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "4",
 		"EventName": "L1D_DIR_WRITES",
 		"BriefDescription": "L1D Directory Writes",
 		"PublicDescription": "Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "5",
 		"EventName": "L1D_PENALTY_CYCLES",
 		"BriefDescription": "L1D Penalty Cycles",
 		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "32",
 		"EventName": "PROBLEM_STATE_CPU_CYCLES",
 		"BriefDescription": "Problem-State CPU Cycles",
 		"PublicDescription": "Problem-State Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "33",
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "34",
 		"EventName": "PROBLEM_STATE_L1I_DIR_WRITES",
 		"BriefDescription": "Problem-State L1I Directory Writes",
 		"PublicDescription": "Problem-State Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "35",
 		"EventName": "PROBLEM_STATE_L1I_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1I Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "36",
 		"EventName": "PROBLEM_STATE_L1D_DIR_WRITES",
 		"BriefDescription": "Problem-State L1D Directory Writes",
 		"PublicDescription": "Problem-State Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "37",
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
index 7e5b72492141..db286f19e7b6 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
@@ -1,95 +1,111 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "64",
 		"EventName": "PRNG_FUNCTIONS",
 		"BriefDescription": "PRNG Functions",
 		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "65",
 		"EventName": "PRNG_CYCLES",
 		"BriefDescription": "PRNG Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "66",
 		"EventName": "PRNG_BLOCKED_FUNCTIONS",
 		"BriefDescription": "PRNG Blocked Functions",
 		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "67",
 		"EventName": "PRNG_BLOCKED_CYCLES",
 		"BriefDescription": "PRNG Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "68",
 		"EventName": "SHA_FUNCTIONS",
 		"BriefDescription": "SHA Functions",
 		"PublicDescription": "Total number of SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "69",
 		"EventName": "SHA_CYCLES",
 		"BriefDescription": "SHA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "70",
 		"EventName": "SHA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "SHA Blocked Functions",
 		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "71",
 		"EventName": "SHA_BLOCKED_CYCLES",
 		"BriefDescription": "SHA Bloced Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "72",
 		"EventName": "DEA_FUNCTIONS",
 		"BriefDescription": "DEA Functions",
 		"PublicDescription": "Total number of the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "73",
 		"EventName": "DEA_CYCLES",
 		"BriefDescription": "DEA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "74",
 		"EventName": "DEA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "DEA Blocked Functions",
 		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "75",
 		"EventName": "DEA_BLOCKED_CYCLES",
 		"BriefDescription": "DEA Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "76",
 		"EventName": "AES_FUNCTIONS",
 		"BriefDescription": "AES Functions",
 		"PublicDescription": "Total number of AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "77",
 		"EventName": "AES_CYCLES",
 		"BriefDescription": "AES Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "78",
 		"EventName": "AES_BLOCKED_FUNCTIONS",
 		"BriefDescription": "AES Blocked Functions",
 		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "79",
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
index b6d7fec7c2e7..b7b42a870bb0 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
@@ -1,143 +1,167 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "128",
 		"EventName": "L1D_L2_SOURCED_WRITES",
 		"BriefDescription": "L1D L2 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from the Level-2 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "L1I_L2_SOURCED_WRITES",
 		"BriefDescription": "L1I L2 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from the Level-2 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "130",
 		"EventName": "DTLB1_MISSES",
 		"BriefDescription": "DTLB1 Misses",
 		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle a DTLB1 miss is in progress."
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "ITLB1_MISSES",
 		"BriefDescription": "ITLB1 Misses",
 		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle a ITLB1 miss is in progress."
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "L2C_STORES_SENT",
 		"BriefDescription": "L2C Stores Sent",
 		"PublicDescription": "Incremented by one for every store sent to Level-2 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Book L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Book Level-3 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "L1D_ONBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Book L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an On Book Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "136",
 		"EventName": "L1I_ONBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Book L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an On Book Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "L1D_OFFBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Book L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "L1I_OFFBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Book L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "DTLB1_HPAGE_WRITES",
 		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "L1D_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1D Local Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "142",
 		"EventName": "L1I_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1I Local Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "143",
 		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Book L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Book Level-3 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "144",
 		"EventName": "DTLB1_WRITES",
 		"BriefDescription": "DTLB1 Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "ITLB1_WRITES",
 		"BriefDescription": "ITLB1 Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
 		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an On Chip Level-3 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an On Chip Level-3 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
index 8bf16759ca53..2dd8dafff2ef 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
@@ -1,71 +1,83 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "0",
 		"EventName": "CPU_CYCLES",
 		"BriefDescription": "CPU Cycles",
 		"PublicDescription": "Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "1",
 		"EventName": "INSTRUCTIONS",
 		"BriefDescription": "Instructions",
 		"PublicDescription": "Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "2",
 		"EventName": "L1I_DIR_WRITES",
 		"BriefDescription": "L1I Directory Writes",
 		"PublicDescription": "Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "3",
 		"EventName": "L1I_PENALTY_CYCLES",
 		"BriefDescription": "L1I Penalty Cycles",
 		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "4",
 		"EventName": "L1D_DIR_WRITES",
 		"BriefDescription": "L1D Directory Writes",
 		"PublicDescription": "Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "5",
 		"EventName": "L1D_PENALTY_CYCLES",
 		"BriefDescription": "L1D Penalty Cycles",
 		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "32",
 		"EventName": "PROBLEM_STATE_CPU_CYCLES",
 		"BriefDescription": "Problem-State CPU Cycles",
 		"PublicDescription": "Problem-State Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "33",
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
 		"BriefDescription": "Problem-State Instructions",
 		"PublicDescription": "Problem-State Instruction Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "34",
 		"EventName": "PROBLEM_STATE_L1I_DIR_WRITES",
 		"BriefDescription": "Problem-State L1I Directory Writes",
 		"PublicDescription": "Problem-State Level-1 I-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "35",
 		"EventName": "PROBLEM_STATE_L1I_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1I Penalty Cycles",
 		"PublicDescription": "Problem-State Level-1 I-Cache Penalty Cycle Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "36",
 		"EventName": "PROBLEM_STATE_L1D_DIR_WRITES",
 		"BriefDescription": "Problem-State L1D Directory Writes",
 		"PublicDescription": "Problem-State Level-1 D-Cache Directory Write Count"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "37",
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
 		"BriefDescription": "Problem-State L1D Penalty Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
index 7e5b72492141..db286f19e7b6 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
@@ -1,95 +1,111 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "64",
 		"EventName": "PRNG_FUNCTIONS",
 		"BriefDescription": "PRNG Functions",
 		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "65",
 		"EventName": "PRNG_CYCLES",
 		"BriefDescription": "PRNG Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "66",
 		"EventName": "PRNG_BLOCKED_FUNCTIONS",
 		"BriefDescription": "PRNG Blocked Functions",
 		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "67",
 		"EventName": "PRNG_BLOCKED_CYCLES",
 		"BriefDescription": "PRNG Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "68",
 		"EventName": "SHA_FUNCTIONS",
 		"BriefDescription": "SHA Functions",
 		"PublicDescription": "Total number of SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "69",
 		"EventName": "SHA_CYCLES",
 		"BriefDescription": "SHA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "70",
 		"EventName": "SHA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "SHA Blocked Functions",
 		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "71",
 		"EventName": "SHA_BLOCKED_CYCLES",
 		"BriefDescription": "SHA Bloced Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "72",
 		"EventName": "DEA_FUNCTIONS",
 		"BriefDescription": "DEA Functions",
 		"PublicDescription": "Total number of the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "73",
 		"EventName": "DEA_CYCLES",
 		"BriefDescription": "DEA Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "74",
 		"EventName": "DEA_BLOCKED_FUNCTIONS",
 		"BriefDescription": "DEA Blocked Functions",
 		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "75",
 		"EventName": "DEA_BLOCKED_CYCLES",
 		"BriefDescription": "DEA Blocked Cycles",
 		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "76",
 		"EventName": "AES_FUNCTIONS",
 		"BriefDescription": "AES Functions",
 		"PublicDescription": "Total number of AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "77",
 		"EventName": "AES_CYCLES",
 		"BriefDescription": "AES Cycles",
 		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "78",
 		"EventName": "AES_BLOCKED_FUNCTIONS",
 		"BriefDescription": "AES Blocked Functions",
 		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "79",
 		"EventName": "AES_BLOCKED_CYCLES",
 		"BriefDescription": "AES Blocked Cycles",
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
index 8682126aabb2..162251037219 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
@@ -1,209 +1,244 @@
 [
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "128",
 		"EventName": "DTLB1_MISSES",
 		"BriefDescription": "DTLB1 Misses",
 		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle a DTLB1 miss is in progress."
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "ITLB1_MISSES",
 		"BriefDescription": "ITLB1 Misses",
 		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle a ITLB1 miss is in progress."
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "130",
 		"EventName": "L1D_L2I_SOURCED_WRITES",
 		"BriefDescription": "L1D L2I Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "L1I_L2I_SOURCED_WRITES",
 		"BriefDescription": "L1I L2I Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "132",
 		"EventName": "L1D_L2D_SOURCED_WRITES",
 		"BriefDescription": "L1D L2D Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "DTLB1_WRITES",
 		"BriefDescription": "DTLB1 Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "L1D_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1D Local Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "L1I_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1I Local Memory Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
 		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "DTLB1_HPAGE_WRITES",
 		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "ITLB1_WRITES",
 		"BriefDescription": "ITLB1 Writes",
 		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "142",
 		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
 		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "143",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
 		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "144",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On Chip Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Book L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L1D_ONBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Book L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On Book Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "L1D_OFFBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Book L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "149",
 		"EventName": "TX_NC_TEND",
 		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
 		"PublicDescription": "A TEND instruction has completed in a nonconstrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from a On Chip Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "151",
 		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Chip L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Book L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "154",
 		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Book L3 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-3 cache without intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "156",
 		"EventName": "L1I_ONBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Book L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Book Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "157",
 		"EventName": "L1I_OFFBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Book L4 Sourced Writes",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "158",
 		"EventName": "TX_C_TEND",
 		"BriefDescription": "Completed TEND instructions in constrained TX mode",
 		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "159",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "160",
 		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Chip L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "161",
 		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Book L3 Sourced Writes with Intervention",
 		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-3 cache with intervention"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "177",
 		"EventName": "TX_NC_TABORT",
 		"BriefDescription": "Aborted transactions in non-constrained TX mode",
 		"PublicDescription": "A transaction abort has occurred in a nonconstrained transactional-execution mode"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "178",
 		"EventName": "TX_C_TABORT_NO_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
 		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
 	},
 	{
+		"Unit": "CPU-M-CF",
 		"EventCode": "179",
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index db3a594ee1e4..68c92bb599ee 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -233,6 +233,8 @@ static struct map {
 	{ "QPI LL", "uncore_qpi" },
 	{ "SBO", "uncore_sbox" },
 	{ "iMPH-U", "uncore_arb" },
+	{ "CPU-M-CF", "cpum_cf" },
+	{ "CPU-M-SF", "cpum_sf" },
 	{}
 };
 
-- 
2.14.4

