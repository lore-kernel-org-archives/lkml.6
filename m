Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5E3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974C021852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeLROBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:01:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLROBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:01:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIE0cb32852400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:00:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIE0cXn2852393;
        Tue, 18 Dec 2018 06:00:38 -0800
Date:   Tue, 18 Dec 2018 06:00:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-239ca3e78609378a1ed5d9db1c7db629a71c2857@git.kernel.org>
Cc:     hpa@zytor.com, kan.liang@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
Reply-To: jolsa@kernel.org, tglx@linutronix.de, mingo@kernel.org,
          acme@redhat.com, yao.jin@linux.intel.com, ak@linux.intel.com,
          hpa@zytor.com, kan.liang@linux.intel.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org
In-Reply-To: <1543586097-27632-5-git-send-email-yao.jin@linux.intel.com>
References: <1543586097-27632-5-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Documentation average IPC and IPC
 coverage
Git-Commit-ID: 239ca3e78609378a1ed5d9db1c7db629a71c2857
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

Commit-ID:  239ca3e78609378a1ed5d9db1c7db629a71c2857
Gitweb:     https://git.kernel.org/tip/239ca3e78609378a1ed5d9db1c7db629a71c2857
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Fri, 30 Nov 2018 21:54:57 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:55:49 -0300

perf report: Documentation average IPC and IPC coverage

Add explanations for new columns "IPC" and "IPC coverage" in perf
documentation.

 v5:
 ---
 Update the description according to Ingo's comments.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1543586097-27632-5-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 474a4941f65d..ed2bf37ab132 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -126,6 +126,14 @@ OPTIONS
 	And default sort keys are changed to comm, dso_from, symbol_from, dso_to
 	and symbol_to, see '--branch-stack'.
 
+	When the sort key symbol is specified, columns "IPC" and "IPC Coverage"
+	are enabled automatically. Column "IPC" reports the average IPC per function
+	and column "IPC coverage" reports the percentage of instructions with
+	sampled IPC in this function. IPC means Instruction Per Cycle. If it's low,
+	it indicates there may be a performance bottleneck when the function is
+	executed, such as a memory access bottleneck. If a function has high overhead
+	and low IPC, it's worth further analyzing it to optimize its performance.
+
 	If the --mem-mode option is used, the following sort keys are also available
 	(incompatible with --branch-stack):
 	symbol_daddr, dso_daddr, locked, tlb, mem, snoop, dcacheline.
