Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042A9C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA87A222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzyNQMny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfBLRRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:17:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43075 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731784AbfBLRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so1587065pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XOTxqo9OH5aLAc5Vxl6Hirh4+uNIGwOwzNR9lCBfbZ0=;
        b=TzyNQMnyrMRx6Y03GfKuRDaDoyBCPgxtVbwbn+yIjf7NIdqbElgGSzg2CYYQ6OGLh6
         XvT6xAW3yQT5YqEcw9iqBEU1XZOVLOHM5SLE5L+exa1VCE8dkm9fXvMhg4sC+V2QJi/A
         5CuG2AOCjjHGJ2Ok8wXOC1QVlS7gYQq5frcZWTEMtLrUNh59UpMJ8zTJ6EiFQUu5L+Ce
         TE58F/dufPL/i3irM2lthKRkJhcMTrRx2eoxQ8w/a39eMxcfKiKzRIND7iyZzVA+xYum
         UXQbZq17Mz4stq7GIvAvkgRke/Wtr2TF9/BhRb8bWwoPblOIT6MFE2hoIv3s7U9K2nME
         VgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XOTxqo9OH5aLAc5Vxl6Hirh4+uNIGwOwzNR9lCBfbZ0=;
        b=LNzz3zstUe5XHNXA7LUAknu5i4xivwny5XondDhgGftx7TMOvGven+cKP4U3UYK/tJ
         0LFMElCZtyGQjZBZCKJngIylXkk9yFFcOpMTg37/nWVY1VlUEIWu8AZAGixKlo6D+Msb
         CT5XZhBwpc7J9LTLxqtFaFbkUdE6FfQUEHEMJGgwG0D7VXxvV5BiBULdfv5MJAUPSXbc
         6ogd2nZ0SLD/TTjOhOwzGq7L8nz1SjAR2GEzSjdpMEaQLb0rB1c0VAvICweUBEnMWo1B
         f+LooGEHQpfbCl4tzO1/Diq1Sjd7jk5PLM6NJPx3WQyelXqPhgUMvmbn7NbK/wMlxESl
         N2cQ==
X-Gm-Message-State: AHQUAubtLAiCUm4/+q8olvq6rHoFGiroQPTbxCdWE0CaeTqQC7LH9pjX
        bZdI5xwNlnnK40ChvfxjkmoiNw==
X-Google-Smtp-Source: AHgI3IbyEQPXS5XlqajkeNC3crlslWESDoQrWKmidpETwW6xhgEji2GKIaZtV/f8cxfDXsvk7PdGgg==
X-Received: by 2002:a63:a:: with SMTP id 10mr4523207pga.121.1549991788408;
        Tue, 12 Feb 2019 09:16:28 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:27 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] perf tools: Fix erroneous comment
Date:   Tue, 12 Feb 2019 10:16:12 -0700
Message-Id: <20190212171618.25355-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment just before initialising the decoder is plane wrong since it
is part of the decoding queue setup function and the operation code
specifically mention that trace data is to be decoded rather than printed
out.

This patch simply fix the comment to prevent people from getting really
confused.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
-- 
2.17.1

