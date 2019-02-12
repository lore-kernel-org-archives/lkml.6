Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C631C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9FF222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+p+weP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfBLRRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:17:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46551 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbfBLRQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id g6so1576396pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+oNal5RstQ3YgpTY86Id5Pbgg+JpmJKHh+fQyKrDyG0=;
        b=Q+p+weP6kUGU7tzqY8/EauId7g4FmWlr24ilDKPKxgWckBycZcn62SX1aYAakhrvKl
         EU8uVaZezJhjYnlXKr8Xrd8N4mRuXMpf9oTz+R1x9TKN0zVI+Rj5wx2F7ySlvozeGlEz
         pQRLTS+UFyARG9yLiPEqEDuLtSrRXFVKUkFouKMYFkI79JeiA+JpIFU0xPb3TkHAQE97
         AuLbZOXkWItJBL4mP7/tiVWHEzSX8x1m1+Pg4Faieyd/LdmydSzjI+XwY9qlr7VSHXJp
         biACrsYOC4i0nvCD4972EwbxVtlHOZiz0ISWdlAMJiUJg+CV5vsgMLBCB1YY7ya0KddX
         b3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+oNal5RstQ3YgpTY86Id5Pbgg+JpmJKHh+fQyKrDyG0=;
        b=aUYwp7eFlm98dlq7M4Q6LZix059YALDM9dWwIZHSvB5KbkaMP51AiM4p2obzc1FTVy
         RTdThWRmemQmD0bgz0Q/lIZ90rqRTes9oPpb+fTlghuST08XDAF25n+a5Pb3ad9nZD4q
         7zDRs82H7LGoWmGVuwTrd1PlZ7LnMSwAhj1CBlW19J2MxdYT6m1OaHG8Tf6L2vwiPKML
         kp2tSFJKstArtWlO77GQ/wD0Bs+0uKPFAujw/daAAenfImuu8SB1/7maEZYdzEA/z7da
         UVgHEltJWzGrX5VLqMu25mtC1U/Upk+xaefR/6qkENmIRRjNZIVHZJq6nYnD9zwuW4wO
         PXZg==
X-Gm-Message-State: AHQUAuZt7N20KJP9vgx7pWaAOffubmzbwX5wTkTsaK2V3PAl8uEuG8kw
        ZBj8fuF2jXfYnxcy6pHA6xVh0g==
X-Google-Smtp-Source: AHgI3IbfBAR1VsGCY/BgB3gelyUX9VPc9ORlkx/PGdh0Z5eHFdoEzUeTUezqIiaDPz95weNM4jHBWw==
X-Received: by 2002:a63:574e:: with SMTP id h14mr4369440pgm.336.1549991789518;
        Tue, 12 Feb 2019 09:16:29 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:28 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] perf tools: Cleaning up function cs_etm__alloc_queue()
Date:   Tue, 12 Feb 2019 10:16:13 -0700
Message-Id: <20190212171618.25355-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function cs_etm__alloc_queue() should only be concerned with the allocation
of memory for the etmq and accompanying decoder.  Everything else should
be done in the calling function.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4cc9fce97a86..c9a5b4935209 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -405,8 +405,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	return len;
 }
 
-static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
-						unsigned int queue_nr)
+static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 {
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
@@ -444,12 +443,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!etmq->event_buf)
 		goto out_free;
 
-	etmq->etm = etm;
-	etmq->queue_nr = queue_nr;
-	etmq->pid = -1;
-	etmq->tid = -1;
-	etmq->cpu = -1;
-
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 
@@ -479,10 +472,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 		goto out_free_decoder;
 
 	zfree(&t_params);
-
-	etmq->offset = 0;
-	etmq->period_instructions = 0;
-
 	return etmq;
 
 out_free_decoder:
@@ -503,24 +492,30 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
 			       unsigned int queue_nr)
 {
+	int ret = 0;
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
-		return 0;
+		goto out;
 
-	etmq = cs_etm__alloc_queue(etm, queue_nr);
+	etmq = cs_etm__alloc_queue(etm);
 
-	if (!etmq)
-		return -ENOMEM;
+	if (!etmq) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	queue->priv = etmq;
-
-	if (queue->cpu != -1)
-		etmq->cpu = queue->cpu;
-
+	etmq->etm = etm;
+	etmq->queue_nr = queue_nr;
+	etmq->cpu = queue->cpu;
 	etmq->tid = queue->tid;
+	etmq->pid = -1;
+	etmq->offset = 0;
+	etmq->period_instructions = 0;
 
-	return 0;
+out:
+	return ret;
 }
 
 static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
-- 
2.17.1

