Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07917C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB5F2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB5F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbeHBKFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:05:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHBKFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:05:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728FCq83431664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:15:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728FCUh3431661;
        Thu, 2 Aug 2018 01:15:12 -0700
Date:   Thu, 2 Aug 2018 01:15:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ganapatrao Kulkarni <tipbot@zytor.com>
Message-ID: <tip-b9b77222d4ff6b5bb8f5d87fca20de0910618bb9@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com,
        ganapatrao.kulkarni@cavium.com, acme@redhat.com,
        gklkml16@gmail.com, tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        jnair@caviumnetworks.com, jan.glauber@cavium.com, jolsa@redhat.com,
        will.deacon@arm.com, mark.rutland@arm.com,
        vadim.lomovtsev@cavium.com, mingo@kernel.org,
        robert.richter@cavium.com
Reply-To: mingo@kernel.org, robert.richter@cavium.com, jolsa@redhat.com,
          will.deacon@arm.com, mark.rutland@arm.com,
          vadim.lomovtsev@cavium.com, gklkml16@gmail.com, acme@redhat.com,
          tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          jnair@caviumnetworks.com, jan.glauber@cavium.com,
          alexander.shishkin@linux.intel.com,
          ganapatrao.kulkarni@cavium.com, hpa@zytor.com
In-Reply-To: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
References: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Update ThunderX2
 implementation defined pmu core events
Git-Commit-ID: b9b77222d4ff6b5bb8f5d87fca20de0910618bb9
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

Commit-ID:  b9b77222d4ff6b5bb8f5d87fca20de0910618bb9
Gitweb:     https://git.kernel.org/tip/b9b77222d4ff6b5bb8f5d87fca20de0910618bb9
Author:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
AuthorDate: Tue, 31 Jul 2018 15:32:51 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 11:28:44 -0300

perf vendor events arm64: Update ThunderX2 implementation defined pmu core events

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: Jan Glauber <jan.glauber@cavium.com>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@cavium.com>
Cc: Vadim Lomovtsev <vadim.lomovtsev@cavium.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20180731100251.23575-1-ganapatrao.kulkarni@cavium.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
index bc03c06c3918..752e47eb6977 100644
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -11,6 +11,21 @@
     {
         "ArchStdEvent": "L1D_CACHE_REFILL_WR",
     },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+    },
     {
         "ArchStdEvent": "L1D_TLB_REFILL_RD",
     },
@@ -23,10 +38,76 @@
     {
         "ArchStdEvent": "L1D_TLB_WR",
     },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR",
+    },
     {
         "ArchStdEvent": "BUS_ACCESS_RD",
-   },
-   {
+    },
+    {
         "ArchStdEvent": "BUS_ACCESS_WR",
-   }
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+    }
 ]
