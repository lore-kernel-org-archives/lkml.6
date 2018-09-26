Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D74C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C265B21508
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k191EyrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C265B21508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIZQiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:38:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54749 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIZQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:38:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id c14-v6so1672762wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4syfqTgzquPxdJpZoTtqhiu/8ooDs0QTCE3IX5nC3NM=;
        b=k191EyrXLxWe+xiQxSAFleVYd57c5YfWYMhvy3ifTPCKeKUNV6EfTXWfrPdGHCSRdU
         DxJ8I9SNiz1uJP3Q8WbPqouHfzduVLENter9FM0Mre29fpJ2loEIapa2BizMqOVx6U9/
         EPGWwZGV3Vmg55d401Z5Ph+RzI1bl4JGnDfxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4syfqTgzquPxdJpZoTtqhiu/8ooDs0QTCE3IX5nC3NM=;
        b=rJztC2iKNDc78oPEs9B6bpYRyJn9w9fgbU2A2Ps9EWHMIxJC9PByr/bFKAzddnH1v/
         esdO0Op0elN2tv3fma9FUXo7JAoBzaaljfd/A5iGqfd+PyZFHnTBs1TifNd7sN6csg2X
         YbUrQXbP2sD8QWEalOqa/cfy+AEFCDgNgUc5o3dWevzpLZ+rmz3un1BQjaS3fPXjSKJO
         ZZOYTY+/F8X9UGBHbyJdLjsXQjn6jiIZE5/Z/+shVaj+AR1ohj/ml1voww9D3x1mEtAB
         cbV2KRs15GtJ1alt2sc3DfBpzPFJufCdSohCp2xYycpANetJBiXnIeNzIlqvhmxzpkQb
         dd8Q==
X-Gm-Message-State: ABuFfojQHZhELNHf3pw0wHoJ2OSTvj8bW2Qj0ZvwvMkY5poQ+VB1IoC/
        0eummKC3svaq3brx7DeZmYF9VA==
X-Google-Smtp-Source: ACcGV61i85jCbDz71x/RTs5M3lny71g92xieAMhZk4rXdqW0VR2CdPNm4PoWugbN19c61u83cF06yA==
X-Received: by 2002:a1c:7fc6:: with SMTP id a189-v6mr3682238wmd.42.1537957556849;
        Wed, 26 Sep 2018 03:25:56 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b12sm4442648wrx.11.2018.09.26.03.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 03:25:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/5] ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
Date:   Wed, 26 Sep 2018 11:23:45 +0100
Message-Id: <20180926102349.23481-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to set runtime dma buffer on compressed stream.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/compress_driver.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index ea8c93bbb0e0..0cdc3999ecfa 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -23,6 +23,7 @@ struct snd_compr_ops;
  * struct snd_compr_runtime: runtime stream description
  * @state: stream state
  * @ops: pointer to DSP callbacks
+ * @dma_buffer_p: runtime dma buffer pointer
  * @buffer: pointer to kernel buffer, valid only when not in mmap mode or
  *	DSP doesn't implement copy
  * @buffer_size: size of the above buffer
@@ -37,6 +38,7 @@ struct snd_compr_ops;
 struct snd_compr_runtime {
 	snd_pcm_state_t state;
 	struct snd_compr_ops *ops;
+	struct snd_dma_buffer *dma_buffer_p;
 	void *buffer;
 	u64 buffer_size;
 	u32 fragment_size;
@@ -175,6 +177,23 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	wake_up(&stream->runtime->sleep);
 }
 
+/**
+ * snd_compr_set_runtime_buffer - Set the Compress runtime buffer
+ * @substream: compress substream to set
+ * @bufp: the buffer information, NULL to clear
+ *
+ * Copy the buffer information to runtime buffer when @bufp is non-NULL.
+ * Otherwise it clears the current buffer information.
+ */
+static inline void snd_compr_set_runtime_buffer(
+					struct snd_compr_stream *substream,
+					struct snd_dma_buffer *bufp)
+{
+	struct snd_compr_runtime *runtime = substream->runtime;
+
+	runtime->dma_buffer_p = bufp;
+}
+
 int snd_compr_stop_error(struct snd_compr_stream *stream,
 			 snd_pcm_state_t state);
 
-- 
2.19.0

