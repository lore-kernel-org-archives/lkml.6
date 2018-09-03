Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A4CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A420862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HABRKcik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3A420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeICQ5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:57:33 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35578 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeICQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:57:32 -0400
Received: by mail-wr1-f53.google.com with SMTP id j26-v6so532046wre.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HKPlWMrTXSFSzXMCX8iPcSkQb0CTa/AOpm+DdGGB5hQ=;
        b=HABRKcikHjl/c9FyMsGmVFLGayJ2yq1QBEosCxMVMLLYZKKM4ENTEn4mKq9PZHsNfq
         Z1kigGpVeRwe4cnM/r9Hx5piPd8I+FPBSe+K87SAhVJ52wZzfKKGM71MAtrKkqHGwh8Q
         sBf220WEiGI7t2Q+QZAfPKIq/hlVjamkGi74E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HKPlWMrTXSFSzXMCX8iPcSkQb0CTa/AOpm+DdGGB5hQ=;
        b=Tv5MFEWBx+/TiP9G+S/kYP5VtG4ZABM7EweD+ngTG5STGcg+slOXeIkr2w2ulWe+9K
         PlwslchNORvpHb09RPwuD7XDU2y43U5hqVwbu8ZC2vUCiZCm8u0Mnc/YG1vKGMQ/pGud
         QKp1CH07mNXxWQehDuDG5E8is3Z5Em3p++p/VQSme3hL7By6NW3hSeBwXlCz3Ig17zsz
         eF49iLLP38YUFe9FuLcP8tYZ98IX7yQI/xeRRbU1LSZaMkaDcgMPyHguADpO1//RZCSt
         xSFBzZk/H5gG2mjUFWtKyeEIBEK6GqeRfZTiqMahRPp2O9VlgZE2oy0EPKwQwLJsSByk
         ejQg==
X-Gm-Message-State: APzg51Bo71OuJHqMDj9E+yq33+PPubQsvWuhQkX9FQIZMQ0Ot6p52lPc
        i/DUkjXBR0EffYEKPmCQmIo4+Q==
X-Google-Smtp-Source: ANB0Vda3fUxqNd6jhT5+gcg+qoBhr0qOLE0S4OUEdch3YMktitvHhlKtxg565S+j9rKqFeXVz/++OQ==
X-Received: by 2002:adf:c38e:: with SMTP id p14-v6mr20074043wrf.68.1535978253981;
        Mon, 03 Sep 2018 05:37:33 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id j44-v6sm27481099wre.40.2018.09.03.05.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 05:37:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] ASoC: qdsp6: q6asm: add support to MP3 format
Date:   Mon,  3 Sep 2018 13:34:54 +0100
Message-Id: <20180903123455.9290-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 2b2c7233bb5f..e98aee1baadd 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <uapi/sound/asound.h>
+#include <uapi/sound/compress_params.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -37,6 +38,7 @@
 #define ASM_PARAM_ID_ENCDEC_ENC_CFG_BLK_V2	0x00010DA3
 #define ASM_SESSION_CMD_RUN_V2			0x00010DAA
 #define ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2	0x00010DA5
+#define ASM_MEDIA_FMT_MP3			0x00010BE9
 #define ASM_DATA_CMD_WRITE_V2			0x00010DAB
 #define ASM_DATA_CMD_READ_V2			0x00010DAC
 #define ASM_SESSION_CMD_SUSPEND			0x00010DEC
@@ -869,6 +871,9 @@ int q6asm_open_write(struct audio_client *ac, uint32_t format,
 	open->postprocopo_id = ASM_NULL_POPP_TOPOLOGY;
 
 	switch (format) {
+	case SND_AUDIOCODEC_MP3:
+		open->dec_fmt_id = ASM_MEDIA_FMT_MP3;
+		break;
 	case FORMAT_LINEAR_PCM:
 		open->dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
 		break;
-- 
2.18.0

