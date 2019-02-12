Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C6F222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYgl3NNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfBLRQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37206 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfBLRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so1550559pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/UH8SrTya5tl/qVTuklo7mGBNz+HUAk8Fnba3ZSHvA4=;
        b=wYgl3NNS2JG8qwab9R9cIm8sIzbImuxDxN/dEDQKbHn/IZUxPZN4CrrHj/nYcEJ1/t
         k6e8vUwg3Q0MY2UCkeCKEZg7zsYkRBA2GJ/GuRjwOXc+MOl7EPcEu9AF4GivB6xj1c5J
         mupsEFF7+AIvSu5UrKasfzWJNwMa8+63ZiNnzfSRhKi/FW+EdOUavkb+s4OD64ZPCMiM
         5NUe4upIhs3RiQ3XivQgnTPmmHYasY7g7hJK2AjoCngqbQJkJWPcX8w9OZg7pC2omM7a
         m7NepYWwAZAaY/CQ3wcCKiqWx8J6WGI0cZs+qudK88BiSlBpZiW9/OtU8z6SyKjWL+63
         Tk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/UH8SrTya5tl/qVTuklo7mGBNz+HUAk8Fnba3ZSHvA4=;
        b=ZUfKI4Ca6Onrud2lZ8jT+rHg5aKWQkTAsh5OB6eQlS1t8F1TGssb0dHJWYFApReWBJ
         zPtGloDjBw1rt2d7NQvVqKIP4HXoPNPWbfB9KECPQpDxdDf+6VQJJ29IqcwD55nYX7iS
         Gv23bwz3a5LSpdMwScOqhQgXMZlJJO8uPf90rxCrilhKploZYPDgfjUGZNtgviCsQzF2
         04uIYp0HDvh2UmhJ+cEES4fCn/dquJXleiv1RwhhX8pAAxzd/gsoMzawV8pxPhqrwBdL
         Ip3a64P9h+KH9Wgfox4IwukWsw2tmk4uyLxxLDFD2bFPLX32HYBitC+WffLES/ec8PYj
         mVIg==
X-Gm-Message-State: AHQUAuYLslN6cRju0H0OSpdC91TCbUiP+dW0D6t98Tfx/q9rqoaoSkbZ
        9OmQdSljMmmg9gZYo6ac/xvm+g==
X-Google-Smtp-Source: AHgI3IbPeLvGGSj7sEXTX99OIebwz8qfGFIesAcnfY+REMjVGkxG+jmv3dCOEEzUD0A/U91rpEDS5Q==
X-Received: by 2002:a65:514c:: with SMTP id g12mr4481382pgq.169.1549991792926;
        Tue, 12 Feb 2019 09:16:32 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:32 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] perf tools: Modularize main decoder function
Date:   Tue, 12 Feb 2019 10:16:16 -0700
Message-Id: <20190212171618.25355-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making the main decoder block modular so that it can be called from
different decoding context (timeless vs. non-timeless), avoiding
to repeat code.

No change in functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d2c90b369e7c..cfa686fe223e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1491,9 +1491,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
+{
+	int ret = 0;
+	size_t processed = 0;
+
+	/*
+	 * Packets are decoded and added to the decoder's packet queue
+	 * until the decoder packet processing callback has requested that
+	 * processing stops or there is nothing left in the buffer.  Normal
+	 * operations that stop processing are a timestamp packet or a full
+	 * decoder buffer queue.
+	 */
+	ret = cs_etm_decoder__process_data_block(etmq->decoder,
+						 etmq->offset,
+						 &etmq->buf[etmq->buf_used],
+						 etmq->buf_len,
+						 &processed);
+	if (ret)
+		goto out;
+
+	etmq->offset += processed;
+	etmq->buf_used += processed;
+	etmq->buf_len -= processed;
+
+out:
+	return ret;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
-	size_t processed;
 	int err = 0;
 
 	/* Go through each buffer in the queue and decode them one by one */
@@ -1513,20 +1540,10 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		/* Run trace decoder until buffer consumed or end of trace */
 		do {
-			processed = 0;
-			err = cs_etm_decoder__process_data_block(
-				etmq->decoder,
-				etmq->offset,
-				&etmq->buf[etmq->buf_used],
-				etmq->buf_len,
-				&processed);
+			err = cs_etm__decode_data_block(etmq);
 			if (err)
 				return err;
 
-			etmq->offset += processed;
-			etmq->buf_used += processed;
-			etmq->buf_len -= processed;
-
 			/* Process each packet in this chunk */
 			while (1) {
 				err = cs_etm_decoder__get_packet(etmq->decoder,
-- 
2.17.1

