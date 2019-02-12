Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE654C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CD3222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZHvAcXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfBLRQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36447 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbfBLRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so1553181pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=meZtkgH5cImMXR3ybdUTFzkYUQz8/L+H84Qg8MqCSA8=;
        b=vZHvAcXJnsp/c3UfnpJh7hvmSVO5hZHPN6EpPFaiOWcnOQmgxR7mLYnW75CQa53EnQ
         vuu6iE04ioKMlJDDQcYK3AZwSqRDDiSQBxxswQ1YhBLtQKa6lzArcVmEnm7VXHBmruwH
         nIvOg7cAj4baH4AcnnsLs6p8mKRRNUvhOlL8TIZJW+cFd/EZed0AxwURN1HmmOaQJatq
         rwmQGoqcjGQg5VwGmD2/T1PDnixaIBOtVs6pdg/BKgpnw0qMcPFdx5KSbXp9sYvSnCse
         GV2AQBr3RzU8ZsqSryLfKUs64aSYFXEVgKhb74xJkAebcBLbsKEdK+Dy9EvV2jl4dqHT
         /bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=meZtkgH5cImMXR3ybdUTFzkYUQz8/L+H84Qg8MqCSA8=;
        b=VFLrte2qcq4YwwJ/OqXbGaIsPayFFuhd1meZmyCTNGVY+jQtQe880XYGCKpqFUwquo
         k9mp5FqEe5LbMKkWB82h+qfXojHB3YNUom1yqu8SmO3B1iYU9jZ9UbXnlX+S76d6GroH
         fzP6FO4+1V7KxElQJ6vYxeXTv4DgFWBRyMpziaOPyQTaSdfMGzraU4iodiuc8VeqMHZ8
         Jc5gelvY6gudv0nY5P6WEKRClHSmq/9hv7sEWKTjxShy/6ZsOitpuFDVRcSGo5/mCYqH
         AmR15K7NVZw+BZ9nIqS2LIWO2PW9Gk2ASFKFrxIx87AniqoujufioImhY2pbNWghTE1W
         cHrg==
X-Gm-Message-State: AHQUAubCvi/0+FM8s3FoovFYfo50VVzp/+1lpinj+XygqJuaFlAOItPI
        W2wCeZVc2bOXcwgla/KA/Yj4ZA==
X-Google-Smtp-Source: AHgI3IZMzQqn/Uw1YxeUqp9jeZQbp7wdytx2sBQK2j2/QgdNyB3NcVVXOKrYwmdnwwCjhdbk6Gn9mg==
X-Received: by 2002:a63:4611:: with SMTP id t17mr4526538pga.119.1549991791818;
        Tue, 12 Feb 2019 09:16:31 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:31 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] perf tools: Make cs_etm__run_decoder() queue independent
Date:   Tue, 12 Feb 2019 10:16:15 -0700
Message-Id: <20190212171618.25355-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes decoding of auxtrace buffer centered around a struct
cs_etm_queue.  This eliminates surperflous variables and is a precursor
for work that simplifies the main decoder loop.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 ---
 tools/perf/util/cs-etm.c                      | 52 +++++++++----------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 663309486784..3ab11dfa92ae 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -15,13 +15,6 @@
 
 struct cs_etm_decoder;
 
-struct cs_etm_buffer {
-	const unsigned char *buf;
-	size_t len;
-	u64 offset;
-	u64 ref_timestamp;
-};
-
 enum cs_etm_sample_type {
 	CS_ETM_EMPTY,
 	CS_ETM_RANGE,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2d2de898ea68..d2c90b369e7c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -76,6 +76,8 @@ struct cs_etm_queue {
 	size_t last_branch_pos;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
+	const unsigned char *buf;
+	size_t buf_len, buf_used;
 };
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
@@ -683,7 +685,7 @@ static int cs_etm__inject_event(union perf_event *event,
 
 
 static int
-cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
+cs_etm__get_trace(struct cs_etm_queue *etmq)
 {
 	struct auxtrace_buffer *aux_buffer = etmq->buffer;
 	struct auxtrace_buffer *old_buffer = aux_buffer;
@@ -697,7 +699,7 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	if (!aux_buffer) {
 		if (old_buffer)
 			auxtrace_buffer__drop_data(old_buffer);
-		buff->len = 0;
+		etmq->buf_len = 0;
 		return 0;
 	}
 
@@ -717,13 +719,11 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
 	if (old_buffer)
 		auxtrace_buffer__drop_data(old_buffer);
 
-	buff->offset = aux_buffer->offset;
-	buff->len = aux_buffer->size;
-	buff->buf = aux_buffer->data;
+	etmq->buf_used = 0;
+	etmq->buf_len = aux_buffer->size;
+	etmq->buf = aux_buffer->data;
 
-	buff->ref_timestamp = aux_buffer->reference;
-
-	return buff->len;
+	return etmq->buf_len;
 }
 
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
@@ -1493,24 +1493,23 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	struct cs_etm_buffer buffer;
-	size_t buffer_used, processed;
+	size_t processed;
 	int err = 0;
 
 	/* Go through each buffer in the queue and decode them one by one */
 	while (1) {
-		buffer_used = 0;
-		memset(&buffer, 0, sizeof(buffer));
-		err = cs_etm__get_trace(&buffer, etmq);
-		if (err <= 0)
-			return err;
-		/*
-		 * We cannot assume consecutive blocks in the data file are
-		 * contiguous, reset the decoder to force re-sync.
-		 */
-		err = cs_etm_decoder__reset(etmq->decoder);
-		if (err != 0)
-			return err;
+		if (!etmq->buf_len) {
+			err = cs_etm__get_trace(etmq);
+			if (err <= 0)
+				return err;
+			/*
+			 * We cannot assume consecutive blocks in the data file
+			 * are contiguous, reset the decoder to force re-sync.
+			 */
+			err = cs_etm_decoder__reset(etmq->decoder);
+			if (err != 0)
+				return err;
+		}
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
@@ -1518,14 +1517,15 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			err = cs_etm_decoder__process_data_block(
 				etmq->decoder,
 				etmq->offset,
-				&buffer.buf[buffer_used],
-				buffer.len - buffer_used,
+				&etmq->buf[etmq->buf_used],
+				etmq->buf_len,
 				&processed);
 			if (err)
 				return err;
 
 			etmq->offset += processed;
-			buffer_used += processed;
+			etmq->buf_used += processed;
+			etmq->buf_len -= processed;
 
 			/* Process each packet in this chunk */
 			while (1) {
@@ -1585,7 +1585,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					break;
 				}
 			}
-		} while (buffer.len > buffer_used);
+		} while (etmq->buf_len);
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
-- 
2.17.1

