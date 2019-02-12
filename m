Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D10C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E60222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wmd0f4y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfBLRQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43210 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbfBLRQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so1596881plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fPu8+x56+bPaqE+Kt7QPAly49dZ2m5zcnSswTAaxNxU=;
        b=Wmd0f4y5WvxofS4IIk+dxekor1GLWA5HfI5d997lyaW20uM6gGnPRhTpEjUcN2xYhr
         XfdDxPEaxyvelxa9DuAKy+wIo/vZZXq5kpL1aYRyrWfV2R2NLEnU3R0f8BYjGKjBalFu
         U5tjNeJbUVnHwuZ1O1gYT6Bam1FmRP7Njaye9A9CZ/Rjqv4k1fuxD4afpTgcz4afOgIp
         1VV9aLv2+tEQQS8my2EHZp70eY4gYPJ1GF55AQUfHhVMlknG0upE1pWRsv0dR5dvfsun
         0NEmlUObt9WSKKmJRsZdNnT0y0Xqp+Cr/DgtU8QISnCP01VYvzOs5iBYceEop0GQfqIh
         WTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fPu8+x56+bPaqE+Kt7QPAly49dZ2m5zcnSswTAaxNxU=;
        b=hp4BTPfDfq37IQlxmou/GOpaUSrjrjLfr7ZRpj3+NAj05WB7YfPDxZBwmfCBbc1g5Q
         6znbl2hMfPGt7GBIV9pc7fM+NtkPBZWGgEQJDS0ZSvCBY0MzIRZOHi7LPvyKJSAqqaAk
         SnfWVM8qV3Fz+tnAwUu3n+dLFeOhBRug/l9r7umeC6Hx38h/iO53q/aJE2aEQKUsFXxj
         oM9qLlMqDURIc7AQKvmYwwnn3SFC6SejfRlyrXfQxIztsfvlNgA0Dtt53sAiT5nACuvb
         ZV5Rd2zGJ9D4FinPPA53cz1aGA1qCWITP536Ph3sijzhewcfQ6CJlSCsZGq4qiYnQxwg
         kg+w==
X-Gm-Message-State: AHQUAubpouddESiJJYfhpaBC96pDCG+81K0KxL5ie7FUGYUps4Vkn0eh
        lPHpLjvshqT56Z9paolozyuDxA==
X-Google-Smtp-Source: AHgI3IaZSfmJpvPaEi6xZg4Ttp0Sjv+78UJL6/7Q+XeG1Dd7ab+aNBtu9L20qwrLlgvG0xl1rHv1WQ==
X-Received: by 2002:a17:902:b581:: with SMTP id a1mr4999975pls.36.1549991794044;
        Tue, 12 Feb 2019 09:16:34 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:33 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] perf tools: Modularize main packet processing loop
Date:   Tue, 12 Feb 2019 10:16:17 -0700
Message-Id: <20190212171618.25355-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making the main packet processing loop modular so that it can be called
from different decoding context (timeless vs. non-timless), avoiding to
repeat code.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 129 ++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index cfa686fe223e..f607bc58bd03 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1519,6 +1519,72 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 	return ret;
 }
 
+static int cs_etm__process_decoder_queue(struct cs_etm_queue *etmq)
+{
+	int ret;
+
+		/* Process each packet in this chunk */
+		while (1) {
+			ret = cs_etm_decoder__get_packet(etmq->decoder,
+							 etmq->packet);
+			if (ret <= 0)
+				/*
+				 * Stop processing this chunk on
+				 * end of data or error
+				 */
+				break;
+
+			/*
+			 * Since packet addresses are swapped in packet
+			 * handling within below switch() statements,
+			 * thus setting sample flags must be called
+			 * prior to switch() statement to use address
+			 * information before packets swapping.
+			 */
+			ret = cs_etm__set_sample_flags(etmq);
+			if (ret < 0)
+				break;
+
+			switch (etmq->packet->sample_type) {
+			case CS_ETM_RANGE:
+				/*
+				 * If the packet contains an instruction
+				 * range, generate instruction sequence
+				 * events.
+				 */
+				cs_etm__sample(etmq);
+				break;
+			case CS_ETM_EXCEPTION:
+			case CS_ETM_EXCEPTION_RET:
+				/*
+				 * If the exception packet is coming,
+				 * make sure the previous instruction
+				 * range packet to be handled properly.
+				 */
+				cs_etm__exception(etmq);
+				break;
+			case CS_ETM_DISCONTINUITY:
+				/*
+				 * Discontinuity in trace, flush
+				 * previous branch stack
+				 */
+				cs_etm__flush(etmq);
+				break;
+			case CS_ETM_EMPTY:
+				/*
+				 * Should not receive empty packet,
+				 * report error.
+				 */
+				pr_err("CS ETM Trace: empty packet\n");
+				return -EINVAL;
+			default:
+				break;
+			}
+		}
+
+	return ret;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	int err = 0;
@@ -1544,64 +1610,13 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 			if (err)
 				return err;
 
-			/* Process each packet in this chunk */
-			while (1) {
-				err = cs_etm_decoder__get_packet(etmq->decoder,
-								 etmq->packet);
-				if (err <= 0)
-					/*
-					 * Stop processing this chunk on
-					 * end of data or error
-					 */
-					break;
+			/*
+			 * Process each packet in this chunk, nothing to do if
+			 * an error occurs other than hoping the next one will
+			 * be better.
+			 */
+			err = cs_etm__process_decoder_queue(etmq);
 
-				/*
-				 * Since packet addresses are swapped in packet
-				 * handling within below switch() statements,
-				 * thus setting sample flags must be called
-				 * prior to switch() statement to use address
-				 * information before packets swapping.
-				 */
-				err = cs_etm__set_sample_flags(etmq);
-				if (err < 0)
-					break;
-
-				switch (etmq->packet->sample_type) {
-				case CS_ETM_RANGE:
-					/*
-					 * If the packet contains an instruction
-					 * range, generate instruction sequence
-					 * events.
-					 */
-					cs_etm__sample(etmq);
-					break;
-				case CS_ETM_EXCEPTION:
-				case CS_ETM_EXCEPTION_RET:
-					/*
-					 * If the exception packet is coming,
-					 * make sure the previous instruction
-					 * range packet to be handled properly.
-					 */
-					cs_etm__exception(etmq);
-					break;
-				case CS_ETM_DISCONTINUITY:
-					/*
-					 * Discontinuity in trace, flush
-					 * previous branch stack
-					 */
-					cs_etm__flush(etmq);
-					break;
-				case CS_ETM_EMPTY:
-					/*
-					 * Should not receive empty packet,
-					 * report error.
-					 */
-					pr_err("CS ETM Trace: empty packet\n");
-					return -EINVAL;
-				default:
-					break;
-				}
-			}
 		} while (etmq->buf_len);
 
 		if (err == 0)
-- 
2.17.1

