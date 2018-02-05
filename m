Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeBET6Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:58:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbeBET46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:56:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6B217B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/10] x86/events/intel/ds: Add PERF_SAMPLE_PERIOD into PEBS_FREERUNNING_FLAGS
Date: Mon,  5 Feb 2018 16:56:18 -0300
Message-Id: <20180205195620.9010-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
References: <20180205195620.9010-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Stephane reported that we don't support period for enabling large PEBS
data, which there's no reason for. Adding PERF_SAMPLE_PERIOD into
freerunning flags.

Tested it with:

  # perf record -e cycles:P -c 100 --no-timestamp -C 0 --period

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Kan Liang <kan.liang@intel.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180201083812.11359-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/events/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8e4ea143ed96..78f91ec1056e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -93,7 +93,8 @@ struct amd_nb {
 	PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID | \
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
-	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)
+	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
+	PERF_SAMPLE_PERIOD)
 
 #define PEBS_REGS \
 	(PERF_REG_X86_AX | \
-- 
2.14.3
