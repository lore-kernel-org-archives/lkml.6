Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C241C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C90222FD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393208AbfBOJng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:43:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389363AbfBOJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:43:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9hJ4b1118885
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:43:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9hJBL1118882;
        Fri, 15 Feb 2019 01:43:19 -0800
Date:   Fri, 15 Feb 2019 01:43:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-e4aa592d183228e5fbd3b49a317248c2895d3819@git.kernel.org>
Cc:     jolsa@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        leo.yan@linaro.org, mathieu.poirier@linaro.org, acme@redhat.com,
        suzuki.poulose@arm.com, tglx@linutronix.de
Reply-To: suzuki.poulose@arm.com, tglx@linutronix.de, acme@redhat.com,
          mathieu.poirier@linaro.org, mingo@kernel.org, leo.yan@linaro.org,
          hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <20190212171618.25355-8-mathieu.poirier@linaro.org>
References: <20190212171618.25355-8-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Fix erroneous comment
Git-Commit-ID: e4aa592d183228e5fbd3b49a317248c2895d3819
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

Commit-ID:  e4aa592d183228e5fbd3b49a317248c2895d3819
Gitweb:     https://git.kernel.org/tip/e4aa592d183228e5fbd3b49a317248c2895d3819
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:12 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:07 -0300

perf cs-etm: Fix erroneous comment

The comment just before initialising the decoder is plane wrong since it
is part of the decoding queue setup function and the operation code
specifically mention that trace data is to be decoded rather than printed
out.

This patch simply fix the comment to prevent people from getting really
confused.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-8-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f3a6dfaf3026..4cc9fce97a86 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -459,7 +459,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (cs_etm__init_trace_params(t_params, etm))
 		goto out_free;
 
-	/* Set decoder parameters to simply print the trace packets */
+	/* Set decoder parameters to decode trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
 					CS_ETM_OPERATION_DECODE))
 		goto out_free;
