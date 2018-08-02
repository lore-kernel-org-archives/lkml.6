Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5019AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC6D2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC6D2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeHBKFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:05:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39301 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeHBKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:05:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728EdbQ3431457
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:14:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728Ed4a3431454;
        Thu, 2 Aug 2018 01:14:39 -0700
Date:   Thu, 2 Aug 2018 01:14:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-14a85b1eca348e00a9f209b522f94ec3ead94acb@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mathieu.poirier@linaro.org, acme@redhat.com, robert.walker@arm.com,
        mike.leach@linaro.org, hpa@zytor.com, kim.phillips@arm.com
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          jolsa@redhat.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          leo.yan@linaro.org, kim.phillips@arm.com, robert.walker@arm.com,
          hpa@zytor.com, mike.leach@linaro.org, tglx@linutronix.de,
          mathieu.poirier@linaro.org, acme@redhat.com
In-Reply-To: <1531295145-596-7-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-7-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Generate branch sample for
 CS_ETM_TRACE_ON packet
Git-Commit-ID: 14a85b1eca348e00a9f209b522f94ec3ead94acb
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

Commit-ID:  14a85b1eca348e00a9f209b522f94ec3ead94acb
Gitweb:     https://git.kernel.org/tip/14a85b1eca348e00a9f209b522f94ec3ead94acb
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Wed, 11 Jul 2018 15:45:45 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 11:22:50 -0300

perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet

CS_ETM_TRACE_ON packet itself can give the info that there have a
discontinuity in the trace, this patch is to add branch sample for
CS_ETM_TRACE_ON packet if it is inserted in the middle of CS_ETM_RANGE
packets; as result we can have hint for the trace discontinuity.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1531295145-596-7-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d3b794286bca..2ae640257fdb 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -910,13 +910,23 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		etmq->period_instructions = instrs_over;
 	}
 
-	if (etm->sample_branches &&
-	    etmq->prev_packet &&
-	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
-	    etmq->prev_packet->last_instr_taken_branch) {
-		ret = cs_etm__synth_branch_sample(etmq);
-		if (ret)
-			return ret;
+	if (etm->sample_branches && etmq->prev_packet) {
+		bool generate_sample = false;
+
+		/* Generate sample for tracing on packet */
+		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
+			generate_sample = true;
+
+		/* Generate sample for branch taken packet */
+		if (etmq->prev_packet->sample_type == CS_ETM_RANGE &&
+		    etmq->prev_packet->last_instr_taken_branch)
+			generate_sample = true;
+
+		if (generate_sample) {
+			ret = cs_etm__synth_branch_sample(etmq);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (etm->sample_branches || etm->synth_opts.last_branch) {
