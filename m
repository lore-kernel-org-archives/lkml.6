Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F5FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DA4222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cObDZdMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfBLRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:29 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40365 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfBLRQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so1589538pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V0vDEzF3Mc5eeutz94nbRQZ6xPyugJQXobqfjuLKiSM=;
        b=cObDZdMvnlT9QoWFKtK5J0NH3yLnZBykk0W6O6czUdQ/wYALlhy+/89BGrRGgozWdD
         M9OBesQ2ZbzZmMEKzL3X5eFzKAfw5RToYyZFRGIjd7UT8ljdT3ekmZ0Up6mcbVozjiEL
         DRIx4WCIZNObHIFFf1/umNJU1yic69+R5q6hOLr5lBKjoZbkhQRA/D5TOqyaHIGld3P0
         8GHrzUVTDPRgUxbcQ1vy63emJiAy7J9y22QOVf8fiOd/y9RtvBtd4uP88uwaPSFIQjzZ
         +IOKPHt++r1IAu+P5vmeWCbjTOrYh7HW/LAof8xPoCWlwi7DRfpbGyGAjn1nMIBgh2Md
         TFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V0vDEzF3Mc5eeutz94nbRQZ6xPyugJQXobqfjuLKiSM=;
        b=ZYXMxD35uy1peE/1EFJOj01XBPWhD+f07fKQ1JUydo9kyFzPm78sP/yUGbdpPpffw3
         onWjVmILE8nG5IZWTOXACPM3OAlQBsGILbUZ+OvIgnO6ifX+TKVBI8wuzPEZHIVKbKQc
         9dcwmbq6RVYu12fty4YDpCRnsXHUxu0mXqEyP9LBUeT1ToMxewet6FKZW72LgiTQO3yR
         LUflvfV2R1OgTROXUHYU70sl+D2EyhZdlrktc38ugW31IKc/YiZkQCy7m1x6GbLO07uc
         tC3nxHZItV56GwZ6oNVK2uNo/kZPSKzw0f/kLWHWg/boooOuaoJIJKYz2MeyPPqvN0JT
         I1VA==
X-Gm-Message-State: AHQUAuZ1zg5UItwFsaCRV7pMy3KaLEuqqRVlscWEDwQ/9XgRiVeYKBFI
        hYzVCqcW1o6tEDZ7RzTfwgsHxoshASI=
X-Google-Smtp-Source: AHgI3IYKR0kXyO4xGvlkymDUvl4GyOnjKTSy8Wr+bhwCgfEF5lwn2EwlWC9Wtp1KVNdkwoOwPklo7Q==
X-Received: by 2002:a63:c345:: with SMTP id e5mr4571313pgd.103.1549991786088;
        Tue, 12 Feb 2019 09:16:26 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:25 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] perf tools: Fix memory leak in error path
Date:   Tue, 12 Feb 2019 10:16:10 -0700
Message-Id: <20190212171618.25355-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocated for variable 't_params' isn't released properly in the
error path of function cs_etm_queue *cs_etm__alloc_queue() and
cs_etm__dump_event(), something this patch addresses.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3011c6cae531..aac07f950074 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -175,6 +175,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 
 	/* Use metadata to fill in trace parameters for trace decoder */
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
+
+	if (!t_params)
+		return;
+
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
 			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
@@ -206,14 +210,12 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
 					CS_ETM_OPERATION_PRINT))
-		return;
+		goto out_free;
 
 	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!decoder)
-		return;
+		goto out_free;
 	do {
 		size_t consumed;
 
@@ -228,6 +230,9 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	} while (buffer_used < buffer->size);
 
 	cs_etm_decoder__free(decoder);
+
+out_free:
+	zfree(&t_params);
 }
 
 static int cs_etm__flush_events(struct perf_session *session,
@@ -379,7 +384,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 {
 	int i;
 	struct cs_etm_decoder_params d_params;
-	struct cs_etm_trace_params  *t_params;
+	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
 	size_t szp = sizeof(struct cs_etm_packet);
 
@@ -461,8 +466,6 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
 
-	zfree(&t_params);
-
 	if (!etmq->decoder)
 		goto out_free;
 
@@ -475,6 +478,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 					      cs_etm__mem_access))
 		goto out_free_decoder;
 
+	zfree(&t_params);
+
 	etmq->offset = 0;
 	etmq->period_instructions = 0;
 
@@ -483,6 +488,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 out_free_decoder:
 	cs_etm_decoder__free(etmq->decoder);
 out_free:
+	zfree(&t_params);
 	zfree(&etmq->event_buf);
 	zfree(&etmq->last_branch);
 	zfree(&etmq->last_branch_rb);
-- 
2.17.1

