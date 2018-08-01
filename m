Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CECCC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB994208AC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogqK00UO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB994208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbeHAXZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388730AbeHAXZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:44 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E36208A4;
        Wed,  1 Aug 2018 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159476;
        bh=CeK0mUT+vGVvWWvO/1bakgoy0dVdzh/jf+2pLGvFxBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogqK00UOBLXxOkpE7UWRo5XGJ/ZtqbRP4NcMwtAu8HtkYf2mvDhdGAtFeuaSA72l2
         lFpjhPFIGWyph05xgEYukWcgiCyJ6cSYZFxzaogNVZS3Q+uqbh0q5MIt5DUmOsE7LM
         oU3E3u3u2X6cAxLZwpXdg9zDjZre0WWud46c39Xk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ganapatrao Kulkarni <gklkml16@gmail.com>,
        Jan Glauber <jan.glauber@cavium.com>,
        Jayachandran C <jnair@caviumnetworks.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@cavium.com>,
        Vadim Lomovtsev <vadim.lomovtsev@cavium.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/21] perf vendor events arm64: Update ThunderX2 implementation defined pmu core events
Date:   Wed,  1 Aug 2018 18:36:43 -0300
Message-Id: <20180801213648.4814-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

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
-- 
2.14.4

