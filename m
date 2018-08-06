Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C49CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EA3219F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KC/7NBZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EA3219F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeHFMXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:23:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52895 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeHFMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:23:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so13168953wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sblejbO/Xk6lWeRoCFskglXCoeRG0prfit3ELpPbVBU=;
        b=KC/7NBZlbwhm2SrJXq+SaBX1PU1FaBpFyq0CVX7t5pt+cBuhXICvjdVwpgJxEQts18
         qwOP1q8NzGZeqJfcTzDo7LQvTeduRyVytr0z3N0Azmkai8zkbswg1r60TJ806CMxHr9A
         kFC0uFEI1Ye0u/3P8QXHx5hXxYjpnJqGWUR8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sblejbO/Xk6lWeRoCFskglXCoeRG0prfit3ELpPbVBU=;
        b=oQ/goSXoQdHP+JPHKLD2fIEliKxfIJ0e1s6fvwZDeJau29VFM8E/Lokqd2u4Hhf4GH
         4qN/Fbv0RqgX6YUSo19kqJ0h9RPnU/9Fp7XvZ6rHHMpa5VynXY1iMvIVJ0ckRPJsvo0f
         w7LqX2cMmjZXuW6iJtPlQIlFnmyOObA+ut9efbNlBPqXK/GOjI2bbuTDmJ7MrEmFN0US
         wrdbjp9RT82AYf5HqQrMp/SXesV4kvmnofuPohKbhd2Og4L7rhJx3fVaSXAwjpfdJjI1
         DisSGnbSltT2nNMXJFpPI/Qs5gEkgNiYKUaOWltOb9lG4YrsuOS6U+IfR4mgl0coc2g2
         y73g==
X-Gm-Message-State: AOUpUlE7oRFWqfUJyFvcUaJNoJ4LOzYmtLeIG4RwKySadoKX3fEBdpFA
        kBqYuQDTIEeGTM/1eGb12N2utA==
X-Google-Smtp-Source: AAOMgpc4zZt/cP4m/rruUjZWQAjy6YEEuo3oexn3Pns2bjLi9pqSN23lKkEUtaQw6h6/qldHdouNow==
X-Received: by 2002:a7b:c041:: with SMTP id u1-v6mr11479524wmc.53.1533550487228;
        Mon, 06 Aug 2018 03:14:47 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id s2-v6sm8095644wrw.52.2018.08.06.03.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 03:14:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/5] ASoC: qdsp6: q6afe-dai: add SLIM tx AIF_IN dapm
Date:   Mon,  6 Aug 2018 11:12:09 +0100
Message-Id: <20180806101209.15167-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing AIF_IN dapm for slim tx ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 475d193c5e2e..60ff4a2d3577 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1120,6 +1120,13 @@ static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_RX", "Slimbus4 Playback", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_RX", "Slimbus5 Playback", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_RX", "Slimbus6 Playback", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_TX", "Slimbus Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_TX", "Slimbus1 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_TX", "Slimbus2 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_TX", "Slimbus3 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_TX", "Slimbus4 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_TX", "Slimbus5 Capture", 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_TX", "Slimbus6 Capture", 0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_RX", "Quaternary MI2S Playback",
 						0, 0, 0, 0),
 	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_TX", "Quaternary MI2S Capture",
-- 
2.16.2

