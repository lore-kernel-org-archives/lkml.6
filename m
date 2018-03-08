Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966365AbeCHLCY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:02:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755734AbeCHK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:59:44 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 05/11] perf vendor events arm64: Relocate ThunderX2 JSON to cavium subdirectory
Date: Thu, 8 Mar 2018 18:58:30 +0800
Message-ID: <1520506716-197429-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since jevents now supports vendor subdirectory, relocate
the ThunderX2 JSON to Cavium subdirectory.

Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/cavium/thunderx2-imp-def.json       | 62 ----------------------
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 62 ++++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |  2 +-
 3 files changed, 63 insertions(+), 63 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
deleted file mode 100644
index 2db45c4..0000000
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
+++ /dev/null
@@ -1,62 +0,0 @@
-[
-    {
-        "PublicDescription": "Attributable Level 1 data cache access, read",
-        "EventCode": "0x40",
-        "EventName": "l1d_cache_rd",
-        "BriefDescription": "L1D cache read",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data cache access, write ",
-        "EventCode": "0x41",
-        "EventName": "l1d_cache_wr",
-        "BriefDescription": "L1D cache write",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data cache refill, read",
-        "EventCode": "0x42",
-        "EventName": "l1d_cache_refill_rd",
-        "BriefDescription": "L1D cache refill read",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data cache refill, write",
-        "EventCode": "0x43",
-        "EventName": "l1d_cache_refill_wr",
-        "BriefDescription": "L1D refill write",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data TLB refill, read",
-        "EventCode": "0x4C",
-        "EventName": "l1d_tlb_refill_rd",
-        "BriefDescription": "L1D tlb refill read",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data TLB refill, write",
-        "EventCode": "0x4D",
-        "EventName": "l1d_tlb_refill_wr",
-        "BriefDescription": "L1D tlb refill write",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
-        "EventCode": "0x4E",
-        "EventName": "l1d_tlb_rd",
-        "BriefDescription": "L1D tlb read",
-    },
-    {
-        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
-        "EventCode": "0x4F",
-        "EventName": "l1d_tlb_wr",
-        "BriefDescription": "L1D tlb write",
-    },
-    {
-        "PublicDescription": "Bus access read",
-        "EventCode": "0x60",
-        "EventName": "bus_access_rd",
-        "BriefDescription": "Bus access read",
-   },
-   {
-        "PublicDescription": "Bus access write",
-        "EventCode": "0x61",
-        "EventName": "bus_access_wr",
-        "BriefDescription": "Bus access write",
-   }
-]
diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
new file mode 100644
index 0000000..2db45c4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -0,0 +1,62 @@
+[
+    {
+        "PublicDescription": "Attributable Level 1 data cache access, read",
+        "EventCode": "0x40",
+        "EventName": "l1d_cache_rd",
+        "BriefDescription": "L1D cache read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache access, write ",
+        "EventCode": "0x41",
+        "EventName": "l1d_cache_wr",
+        "BriefDescription": "L1D cache write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache refill, read",
+        "EventCode": "0x42",
+        "EventName": "l1d_cache_refill_rd",
+        "BriefDescription": "L1D cache refill read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data cache refill, write",
+        "EventCode": "0x43",
+        "EventName": "l1d_cache_refill_wr",
+        "BriefDescription": "L1D refill write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill, read",
+        "EventCode": "0x4C",
+        "EventName": "l1d_tlb_refill_rd",
+        "BriefDescription": "L1D tlb refill read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data TLB refill, write",
+        "EventCode": "0x4D",
+        "EventName": "l1d_tlb_refill_wr",
+        "BriefDescription": "L1D tlb refill write",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access, read",
+        "EventCode": "0x4E",
+        "EventName": "l1d_tlb_rd",
+        "BriefDescription": "L1D tlb read",
+    },
+    {
+        "PublicDescription": "Attributable Level 1 data or unified TLB access, write",
+        "EventCode": "0x4F",
+        "EventName": "l1d_tlb_wr",
+        "BriefDescription": "L1D tlb write",
+    },
+    {
+        "PublicDescription": "Bus access read",
+        "EventCode": "0x60",
+        "EventName": "bus_access_rd",
+        "BriefDescription": "Bus access read",
+   },
+   {
+        "PublicDescription": "Bus access write",
+        "EventCode": "0x61",
+        "EventName": "bus_access_wr",
+        "BriefDescription": "Bus access write",
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index e61c9ca..952a05c 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,5 +12,5 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000420f5160,v1,cavium,core
+0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
-- 
1.9.1
