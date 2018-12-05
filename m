Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20CDC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716622084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGg91RV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716622084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeLEJgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbeLEJgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:21 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4ED720851;
        Wed,  5 Dec 2018 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002580;
        bh=TLAGF3zeNGSzdfjq6p0aIKprWYjJifZAymBiycpaTrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGg91RV+8Q6dbfww41A231K15Q0fhQ3vJnh8XwaG8D/FUHcLpN9oWAV5IQvA9mG+7
         WikFitpWGYXYlhB+IdoseDvOmvqUmedE4CNOsp0eLoGAjhgFJiTMfAF+MCWfXiHsBF
         sOFFzJNNDCDU3gIoc9523/RLprbLPlSQcgXfqArE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 006/123] ASoC: qdsp6: q6afe-dai: Fix the dai widgets
Date:   Wed,  5 Dec 2018 04:33:58 -0500
Message-Id: <20181205093555.5386-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit e14856f6cfbb1b96aa45a68f188b147b5bde76b4 ]

For some reason the dapm widgets are incorrectly defined from the start,
Not sure how we ended up with such thing. Fix them now!

Without this fix the backend dais are always powered up even if there
is no active stream.

Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
Reported-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 208 +++++++++++++++----------------
 1 file changed, 104 insertions(+), 104 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 60ff4a2d3577..8f6c8fc073a9 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1112,204 +1112,204 @@ static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
 }
 
 static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
-	SND_SOC_DAPM_AIF_OUT("HDMI_RX", "HDMI Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_0_RX", "Slimbus Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_1_RX", "Slimbus1 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_2_RX", "Slimbus2 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_3_RX", "Slimbus3 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_RX", "Slimbus4 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_RX", "Slimbus5 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_RX", "Slimbus6 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_TX", "Slimbus Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_TX", "Slimbus1 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_TX", "Slimbus2 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_TX", "Slimbus3 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_TX", "Slimbus4 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_TX", "Slimbus5 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_TX", "Slimbus6 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_RX", "Quaternary MI2S Playback",
+	SND_SOC_DAPM_AIF_IN("HDMI_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_0_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_1_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_2_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_3_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_RX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_TX", "Quaternary MI2S Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_TX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_MI2S_RX", "Tertiary MI2S Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_MI2S_RX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_MI2S_TX", "Tertiary MI2S Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_MI2S_TX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_RX", "Secondary MI2S Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_MI2S_RX", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_MI2S_TX", "Secondary MI2S Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_TX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_RX_SD1",
+	SND_SOC_DAPM_AIF_IN("SEC_MI2S_RX_SD1",
 			"Secondary MI2S Playback SD1",
 			0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRI_MI2S_RX", "Primary MI2S Playback",
+	SND_SOC_DAPM_AIF_IN("PRI_MI2S_RX", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRI_MI2S_TX", "Primary MI2S Capture",
+	SND_SOC_DAPM_AIF_OUT("PRI_MI2S_TX", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_0", "Primary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_1", "Primary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_2", "Primary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_3", "Primary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_4", "Primary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_5", "Primary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_6", "Primary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_7", "Primary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_0", "Primary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_1", "Primary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_2", "Primary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_3", "Primary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_4", "Primary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_5", "Primary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_6", "Primary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_7", "Primary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_0", "Secondary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_1", "Secondary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_2", "Secondary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_3", "Secondary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_4", "Secondary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_5", "Secondary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_6", "Secondary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_7", "Secondary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_0", "Secondary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_1", "Secondary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_2", "Secondary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_3", "Secondary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_4", "Secondary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_5", "Secondary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_6", "Secondary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_7", "Secondary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_0", "Tertiary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_1", "Tertiary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_2", "Tertiary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_3", "Tertiary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_4", "Tertiary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_5", "Tertiary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_6", "Tertiary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_7", "Tertiary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_0", "Tertiary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_1", "Tertiary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_2", "Tertiary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_3", "Tertiary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_4", "Tertiary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_5", "Tertiary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_6", "Tertiary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_7", "Tertiary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_0", "Quaternary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_1", "Quaternary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_2", "Quaternary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_3", "Quaternary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_4", "Quaternary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_5", "Quaternary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_6", "Quaternary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_7", "Quaternary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_0", "Quaternary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_1", "Quaternary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_2", "Quaternary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_3", "Quaternary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_4", "Quaternary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_5", "Quaternary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_6", "Quaternary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_7", "Quaternary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_0", "Quinary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_1", "Quinary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_2", "Quinary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_3", "Quinary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_4", "Quinary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_5", "Quinary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_6", "Quinary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_7", "Quinary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_0", "Quinary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_1", "Quinary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_2", "Quinary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_3", "Quinary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_4", "Quinary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_5", "Quinary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_6", "Quinary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_7", "Quinary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 };
 
-- 
2.17.1

