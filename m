Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3990C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F1B20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131703;
	bh=aupo69Rt7c8xwKfOOD2rKj14MJW/bWk3OpVB//dUfMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R+ayQaF2K30iKIttAktcAvClAklXrfLQaSBTGLieqyIqfSDRCDtXpDnHGrhaxeZQ/
	 PopiZ8/xvGdF7niWUGkAi7isZK/RbOjxHMSNrdQbaJFRceJ65t/oLrljGDo8zoV+TI
	 pYiEEv3myMhh9H87xB5K0IKxflSrhEBUnbCwP/D8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F1B20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbeLFV2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeLFV2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:18 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBDF2146D;
        Thu,  6 Dec 2018 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131698;
        bh=aupo69Rt7c8xwKfOOD2rKj14MJW/bWk3OpVB//dUfMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqtjHBOrnB8y6duY93fRBHKKfoPRj4A5qGyVlJ6GE+skfKVpp3PIv67n9szFbZG4R
         nnP0mPgD5xboSTVtFjyXOrc1JFkEldtpn82Dq9CZE1W0YdOZYRbzYI7iKo5eyMnUe0
         PSRtQFWA4zUBmP+R5T4N0tTYkT6oHSde/RGEfl3U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/75] perf report: Documentation average IPC and IPC coverage
Date:   Thu,  6 Dec 2018 18:25:13 -0300
Message-Id: <20181206212602.20474-27-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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
-- 
2.19.2

