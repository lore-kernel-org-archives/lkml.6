Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0326F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xEKgLy79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0326F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbeKGDgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:36:00 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57464 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbeKGDgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=edhnnVbU0jb/j2BNEuka80MCQNdhzMlpANJv1d4OeJw=; b=xEKgLy79WoU6
        aNaYSNZQYtwInGZxGHK0kORMwd/X093HDk6XmEpG6e+qhE5BeM1623Y97Gf8AK42P1ZbcwgEeGGEy
        m6Az/kR6rBPj7j2FVErCzfPRuhx0aX5PP+pMFtyS9K2EonB/9wdpkvmunigrb9UgYoB2rfMBPXGMs
        Pg4N8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gK5n6-0002uM-1T; Tue, 06 Nov 2018 18:09:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B8501112266B; Tue,  6 Nov 2018 18:09:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        rohitkr@codeaurora.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe-dai: Fix the dai widgets" to the asoc tree
In-Reply-To:  <20181106113857.19737-3-srinivas.kandagatla@linaro.org>
Message-Id: <20181106180927.B8501112266B@debutante.sirena.org.uk>
Date:   Tue,  6 Nov 2018 18:09:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe-dai: Fix the dai widgets

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e14856f6cfbb1b96aa45a68f188b147b5bde76b4 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 6 Nov 2018 11:38:57 +0000
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: Fix the dai widgets

For some reason the dapm widgets are incorrectly defined from the start,
Not sure how we ended up with such thing. Fix them now!

Without this fix the backend dais are always powered up even if there
is no active stream.

Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
Reported-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2

