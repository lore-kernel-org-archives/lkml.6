Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeBFRAN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:00:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51743 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752927AbeBFQ4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:56:09 -0500
From: John Garry <john.garry@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>, <wcohen@redhat.com>,
        <will.deacon@arm.com>, <ganapatrao.kulkarni@cavium.com>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 7/9] perf utils: fixup Cavium ThunderX2 JSON to use ARMv8 recommended events
Date: Wed, 7 Feb 2018 01:45:02 +0800
Message-ID: <1517939104-230881-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
References: <1517939104-230881-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the Cavium ThunderX2 JSON to use event definitions
from the ARMv8 recommended events.

The brief description is kept for readability for arch standard events,
but is not strictly required.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 60 ++++++++--------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
index 2db45c4..f47bf0f 100644
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -1,62 +1,42 @@
 [
     {
-        "PublicDescription": "Attributable Level 1 data cache access, read",
-        "EventCode": "0x40",
-        "EventName": "l1d_cache_rd",
-        "BriefDescription": "L1D cache read",
+        "ArchStdEvent": "0x40",
+        "BriefDescription": "L1D cache access, read"
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache access, write ",
-        "EventCode": "0x41",
-        "EventName": "l1d_cache_wr",
-        "BriefDescription": "L1D cache write",
+        "ArchStdEvent": "0x41",
+        "BriefDescription": "L1D cache access, write"
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache refill, read",
-        "EventCode": "0x42",
-        "EventName": "l1d_cache_refill_rd",
-        "BriefDescription": "L1D cache refill read",
+        "ArchStdEvent": "0x42",
+        "BriefDescription": "L1D cache refill, read"
     },
     {
-        "PublicDescription": "Attributable Level 1 data cache refill, write",
-        "EventCode": "0x43",
-        "EventName": "l1d_cache_refill_wr",
-        "BriefDescription": "L1D refill write",
+        "ArchStdEvent": "0x43",
+        "BriefDescription": "L1D cache refill, write"
     },
     {
-        "PublicDescription": "Attributable Level 1 data TLB refill, read",
-        "EventCode": "0x4C",
-        "EventName": "l1d_tlb_refill_rd",
-        "BriefDescription": "L1D tlb refill read",
+        "ArchStdEvent": "0x4C",
+        "BriefDescription": "L1D cache refill, inner"
     },
     {
-        "PublicDescription": "Attributable Level 1 data TLB refill, write",
-        "EventCode": "0x4D",
-        "EventName": "l1d_tlb_refill_wr",
-        "BriefDescription": "L1D tlb refill write",
+        "ArchStdEvent": "0x4D",
+        "BriefDescription": "L1D tlb refill, write"
     },
     {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
-        "EventCode": "0x4E",
-        "EventName": "l1d_tlb_rd",
-        "BriefDescription": "L1D tlb read",
+        "ArchStdEvent": "0x4E",
+        "BriefDescription": "L1D tlb access, read"
     },
     {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
-        "EventCode": "0x4F",
-        "EventName": "l1d_tlb_wr",
-        "BriefDescription": "L1D tlb write",
+        "ArchStdEvent": "0x4F",
+        "BriefDescription": "L1D tlb access, write"
     },
     {
-        "PublicDescription": "Bus access read",
-        "EventCode": "0x60",
-        "EventName": "bus_access_rd",
-        "BriefDescription": "Bus access read",
+        "ArchStdEvent": "0x60",
+        "BriefDescription": "Bus access read"
    },
    {
-        "PublicDescription": "Bus access write",
-        "EventCode": "0x61",
-        "EventName": "bus_access_wr",
-        "BriefDescription": "Bus access write",
+        "ArchStdEvent": "0x61",
+        "BriefDescription": "Bus access write"
    }
 ]
-- 
1.9.1
