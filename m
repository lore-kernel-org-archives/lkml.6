Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2A3C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CAE22565
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSExf8Po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CAE22565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeGDJwl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:52:41 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50621 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932835AbeGDJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:51:57 -0400
Received: by mail-wm0-f51.google.com with SMTP id v25-v6so5156926wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q8SZ5AGv+OGHVpwVTp0NwXvz0pcK6+whzIzyJVlZ900=;
        b=GSExf8PoGC3OhjxuWxIT8cLIZKicGYueuSqXbKp47NAOGoHeiRPovSPB+m3cOjJwRm
         2x+FwqyKW9shyuTcXrizquH/A4Oyt7cLZqM7rdAX6osCOA/UJ45vR/kZeqokI4DUA07/
         eukC7BagOjl+7+qiJrk53XTiuTuAGD3UUnMkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q8SZ5AGv+OGHVpwVTp0NwXvz0pcK6+whzIzyJVlZ900=;
        b=po4oVqN1yFz+wvTkX0NCbwPtvpIR8wx/tYOjADDaU+gkTXk8eUY95PxrdJDvouO4Rg
         cdwTDEmxOUrVVqazdvu/iPEFBxjI3O+txFJnZL8WFetEu/jjzkXg2KV/Wuzv8kE9K1ZS
         XPYzQ8RkgVqTmimgR3xwGk0meD07AdrxU2DyOvxbM6uKwoH5yMOUFXCvMzKGOi5hDAop
         V9ZyWkLsAl71bXhTo6+ApYChDLJaek9oeD3N0Nty0IIuZnkYtMm9jExWWLoFcqiFNM0W
         GYCoSEOPDz9Bv/y9nbGKQEztvRo4TfCcG4iFUTk0cHdqkkovlsFHXx0p3OTbKGtFdmi4
         sOMg==
X-Gm-Message-State: APt69E0W/s/ZM5YvEIV/YKCRCD8eIp07pRsnaqZs3Uq34TpW/b2inAHS
        aOV8+E0qpqkI4avrQkgVhhmPIw==
X-Google-Smtp-Source: AAOMgpdQKmxS310bKgCwWM0WtLJ/4JPU5dXJQoeyQfdgEgHg4PkzznY+bsGEHrqEK3PflVwoEbvGmQ==
X-Received: by 2002:a1c:f014:: with SMTP id a20-v6mr1064767wmb.97.1530697916181;
        Wed, 04 Jul 2018 02:51:56 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6370089wmw.9.2018.07.04.02.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 02:51:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] ASoC: qdsp6: q6routing: add slim rx routings
Date:   Wed,  4 Jul 2018 10:49:41 +0100
Message-Id: <20180704094944.16440-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add routings mixer controls for slim rx ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index c80fdbc2442e..35269b492761 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -68,6 +68,13 @@
 	{ mix_name, "SEC_MI2S_TX", "SEC_MI2S_TX" },	\
 	{ mix_name, "QUAT_MI2S_TX", "QUAT_MI2S_TX" },	\
 	{ mix_name, "TERT_MI2S_TX", "TERT_MI2S_TX" },		\
+	{ mix_name, "SLIMBUS_0_TX", "SLIMBUS_0_TX" },		\
+	{ mix_name, "SLIMBUS_1_TX", "SLIMBUS_1_TX" },		\
+	{ mix_name, "SLIMBUS_2_TX", "SLIMBUS_2_TX" },		\
+	{ mix_name, "SLIMBUS_3_TX", "SLIMBUS_3_TX" },		\
+	{ mix_name, "SLIMBUS_4_TX", "SLIMBUS_4_TX" },		\
+	{ mix_name, "SLIMBUS_5_TX", "SLIMBUS_5_TX" },		\
+	{ mix_name, "SLIMBUS_6_TX", "SLIMBUS_6_TX" },		\
 	{ mix_name, "PRIMARY_TDM_TX_0", "PRIMARY_TDM_TX_0"},	\
 	{ mix_name, "PRIMARY_TDM_TX_1", "PRIMARY_TDM_TX_1"},	\
 	{ mix_name, "PRIMARY_TDM_TX_2", "PRIMARY_TDM_TX_2"},	\
@@ -122,6 +129,27 @@
 	SOC_SINGLE_EXT("QUAT_MI2S_TX", QUATERNARY_MI2S_TX,		\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_0_TX", SLIMBUS_0_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_1_TX", SLIMBUS_1_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_2_TX", SLIMBUS_2_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_3_TX", SLIMBUS_3_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_4_TX", SLIMBUS_4_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_5_TX", SLIMBUS_5_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
+	SOC_SINGLE_EXT("SLIMBUS_6_TX", SLIMBUS_6_TX,			\
+		id, 1, 0, msm_routing_get_audio_mixer,			\
+		msm_routing_put_audio_mixer),				\
 	SOC_SINGLE_EXT("PRIMARY_TDM_TX_0", PRIMARY_TDM_TX_0,		\
 		id, 1, 0, msm_routing_get_audio_mixer,			\
 		msm_routing_put_audio_mixer),				\
-- 
2.16.2

