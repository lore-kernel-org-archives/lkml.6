Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA934C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BC821A12
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Duz1tjnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BC821A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbeGDJxd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:53:33 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:51833 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932536AbeGDJvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:51:55 -0400
Received: by mail-wm0-f48.google.com with SMTP id s12-v6so5154165wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2hHRQMSfbTJdMwinfMPKwYGBAvEGeRcl/rJ/8+GBz4g=;
        b=Duz1tjnjtRXMuPwmhRlFOQivg21BsxguiHAoiRMcn82x+R1ZxXfJOOyYUUlE0RC2pV
         EznQcR+ZSX0/mmP8TBhXvAB6qsGFIuPLybcqeuND7AW6EmyXnqnyD6J+jXI5JuckKasM
         014GAWIJzBeEx5gQiFhGg087pb1WJBDtEYQCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2hHRQMSfbTJdMwinfMPKwYGBAvEGeRcl/rJ/8+GBz4g=;
        b=LZUkYehSX5gST71N3bDl6kl466Y85w46OVEJipjOAwntYxC8wWlR7ArJAkRYtjlibL
         3++YONTM4244AGRS2+ADAUvb82qFMWEl+Cphy4EM6w1j5gl94WYdbDcTukUFI3jRVf+T
         3YwnD6X4tNLrv+HfvMlPvULSZvkxhBxYNTP24dm2UEvFc6RVocBy07UQhJ+nQWpoQQOy
         m4UJY7wJeM8qTsWo8QcGl7nRBFA26RLkY6Qjv4xeaPbmxiPdxSVD1lVZP/KHOYKi8nMX
         enHB/qP948rePmgFu47MGoB377MV5g6sPnIuj+ZTrsGCyQngIpBmYaAzvpLzRbwySX+z
         UTPw==
X-Gm-Message-State: APt69E2nNwzNoyhz2VgDuD1VtCWqweyoE+jCJpHNiN6O+iAsiLFM5fYf
        fm+fyVpGxamQwQhVaX+AdFtnRA==
X-Google-Smtp-Source: AAOMgpc+ffPQ5ZJyOGvqpHi43GLBVCx8hF4g/NqGhXzodkQhEgOaJKengmmGS/9q35UPxU+KSr5uoQ==
X-Received: by 2002:a1c:6f44:: with SMTP id k65-v6mr1069186wmc.19.1530697914193;
        Wed, 04 Jul 2018 02:51:54 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6370089wmw.9.2018.07.04.02.51.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 02:51:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] ASoC: qdsp6: q6afe: Add missing slimbus capture ports
Date:   Wed,  4 Jul 2018 10:49:39 +0100
Message-Id: <20180704094944.16440-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing code already has support for SLIMbus TX and RX, only thing
that was missing from TX side was mapping between virtual to actual
DSP port ids.

This patch adds those mappings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 621b67b34db9..90e2d8e658bf 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -514,6 +514,20 @@ static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 				SLIMBUS_5_RX, 1, 1},
 	[SLIMBUS_6_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX,
 				SLIMBUS_6_RX, 1, 1},
+	[SLIMBUS_0_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX,
+				SLIMBUS_0_TX, 0, 1},
+	[SLIMBUS_1_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX,
+				SLIMBUS_1_TX, 0, 1},
+	[SLIMBUS_2_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX,
+				SLIMBUS_2_TX, 0, 1},
+	[SLIMBUS_3_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX,
+				SLIMBUS_3_TX, 0, 1},
+	[SLIMBUS_4_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX,
+				SLIMBUS_4_TX, 0, 1},
+	[SLIMBUS_5_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX,
+				SLIMBUS_5_TX, 0, 1},
+	[SLIMBUS_6_TX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX,
+				SLIMBUS_6_TX, 0, 1},
 	[PRIMARY_MI2S_RX] = { AFE_PORT_ID_PRIMARY_MI2S_RX,
 				PRIMARY_MI2S_RX, 1, 1},
 	[PRIMARY_MI2S_TX] = { AFE_PORT_ID_PRIMARY_MI2S_TX,
@@ -1372,6 +1386,13 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX:
 	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX:
-- 
2.16.2

