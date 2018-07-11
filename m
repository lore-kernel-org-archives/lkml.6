Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E169C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC07920862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7Xtv+YT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC07920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbeGKHtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:49:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33665 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732303AbeGKHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:49:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so2648475pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q2cz7hS4ymUe508HKlZEdy7VtTg+KDUjwdA1vqoP2wM=;
        b=h7Xtv+YTPIWuCzsvcxgE0fOLvKn7EC/Vst3Nvg1vSZHKr1BAsymKCEM5YMpsPQyibq
         adk44DUmKMhhVqhkgH0OWps1Y6/XAzaCp2jz6Xte+YcjC5U6Xa/ki1cjpNyEPzQxcv35
         UqHMOUAuWx58WGjqhUwwAsfoXANPK+OeJ+ZKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q2cz7hS4ymUe508HKlZEdy7VtTg+KDUjwdA1vqoP2wM=;
        b=SbvOG1vaW7KNUXZ4M2900zLSpiJCR0bg4kWhkfOYJ+0SVRY+1GgVNIfWSZTMoSe46p
         5h/A4pLKSglm0z9ly0cYL+CmEgD/fNNx53JRfWRO64HV4BtpvrslWDquNnaeAoRKUhMX
         6QfCra/5O3qUCvHAxdHi5X2HOO3d+74Pas/8erh9xZfFH+bUdJCMxqkgOs/A2fbOJcPu
         4wgYwDYLp3C+y7i46COZGs80iFR/YVNuVL/4+UMVqYxRjx5/wEs31/nXSzSraK4g6cY3
         8hT7A8UwQ4m3rEC3BVmU5lfJUn7p09FcjWxln+Q4YL3xlpprAchstZ7N1JzvSqh6qozS
         aSgA==
X-Gm-Message-State: APt69E1EQjV0Ap5mkrqfkB8n62dOb5aY86VkSaV+xuowpGLVSsZL3+Rt
        mkptmKRAUW0pdEeqcW7woqVu1A==
X-Google-Smtp-Source: AAOMgpei/rWfaXIETLY5spsdIOJRUT9yXSxS3P7KiVJNsZtb79NpG7Lu1vEvuIKJiykVClo1T2CLhA==
X-Received: by 2002:a65:64cf:: with SMTP id t15-v6mr25393915pgv.79.1531295216858;
        Wed, 11 Jul 2018 00:46:56 -0700 (PDT)
Received: from localhost.localdomain (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id 16-v6sm9260374pfp.6.2018.07.11.00.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 00:46:56 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 6/6] perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
Date:   Wed, 11 Jul 2018 15:45:45 +0800
Message-Id: <1531295145-596-7-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CS_ETM_TRACE_ON packet itself can give the info that there have a
discontinuity in the trace, this patch is to add branch sample for
CS_ETM_TRACE_ON packet if it is inserted in the middle of CS_ETM_RANGE
packets; as result we can have hint for the trace discontinuity.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d3b7942..2ae6402 100644
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
-- 
2.7.4

