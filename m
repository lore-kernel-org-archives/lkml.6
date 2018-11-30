Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC4FC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B9620863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B9620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeK3RLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:11:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:37819 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbeK3RLm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:11:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 22:03:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="114083883"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2018 22:03:31 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 4/4] perf report: Documentation average IPC and IPC coverage
Date:   Fri, 30 Nov 2018 21:54:57 +0800
Message-Id: <1543586097-27632-5-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543586097-27632-1-git-send-email-yao.jin@linux.intel.com>
References: <1543586097-27632-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add explanations for new columns "IPC" and "IPC coverage" in perf
documentation.

 v5:
 ---
 Update the description according to Ingo's comments.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 tools/perf/Documentation/perf-report.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 474a494..ed2bf37 100644
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
-- 
2.7.4

