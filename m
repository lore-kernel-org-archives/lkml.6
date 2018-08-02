Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC74C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328022145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328022145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeHBKFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:05:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHBKFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:05:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728E8Tx3431400
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:14:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728E82H3431397;
        Thu, 2 Aug 2018 01:14:08 -0700
Date:   Thu, 2 Aug 2018 01:14:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-d603b4e9f9c3181f2dacb989bba60081b99befe4@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@redhat.com, mike.leach@linaro.org,
        hpa@zytor.com, leo.yan@linaro.org, peterz@infradead.org,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org,
        kim.phillips@arm.com, mingo@kernel.org, robert.walker@arm.com,
        tglx@linutronix.de
Reply-To: robert.walker@arm.com, tglx@linutronix.de, kim.phillips@arm.com,
          mingo@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
          mike.leach@linaro.org, hpa@zytor.com, namhyung@kernel.org
In-Reply-To: <1531295145-596-6-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-6-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Generate branch sample when receiving
 a CS_ETM_TRACE_ON packet
Git-Commit-ID: d603b4e9f9c3181f2dacb989bba60081b99befe4
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

Commit-ID:  d603b4e9f9c3181f2dacb989bba60081b99befe4
Gitweb:     https://git.kernel.org/tip/d603b4e9f9c3181f2dacb989bba60081b99befe4
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Wed, 11 Jul 2018 15:45:44 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 11:22:11 -0300

perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON packet

If one CS_ETM_TRACE_ON packet is inserted, we miss to generate branch
sample for the previous CS_ETM_RANGE packet.

This patch is to generate branch sample when receiving a CS_ETM_TRACE_ON
packet, so this can save complete info for the previous CS_ETM_RANGE
packet just before CS_ETM_TRACE_ON packet.

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
Link: http://lkml.kernel.org/r/1531295145-596-6-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 976db8483478..d3b794286bca 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -935,6 +935,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 static int cs_etm__flush(struct cs_etm_queue *etmq)
 {
 	int err = 0;
+	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 
 	if (!etmq->prev_packet)
@@ -965,6 +966,13 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 
 	}
 
+	if (etm->sample_branches &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		err = cs_etm__synth_branch_sample(etmq);
+		if (err)
+			return err;
+	}
+
 swap_packet:
 	if (etmq->etm->synth_opts.last_branch) {
 		/*
