Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeBAIie (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:38:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbeBAIiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:38:25 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 3/3] x86/events/intel/ds: Add PERF_SAMPLE_PERIOD into PEBS_FREERUNNING_FLAGS
Date: Thu,  1 Feb 2018 09:38:12 +0100
Message-Id: <20180201083812.11359-4-jolsa@kernel.org>
In-Reply-To: <20180201083812.11359-1-jolsa@kernel.org>
References: <20180201083812.11359-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan reported that we don't support period for
enabling large PEBS data, which there's no reason
for. Adding PERF_SAMPLE_PERIOD into freerunning
flags.

Reported-by: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-hx5yqua1c9u7iewm3h8frq5h@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.13.6
