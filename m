Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E05C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E1E2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Oyd8k/bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E1E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbeKGDgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:36:08 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57702 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbeKGDgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YRUtg4X3WgJ+F4vAx1oIFQMhqzWbuFUSlNzUdPfzWc4=; b=Oyd8k/bqkY9s
        Y7riBALHC8hnfDm3jR9Lck5lt1sxFb3tExkm3f6ZaVpcgG/JSm1mDqW1J4GGOyTcqt1YQqfgti9LS
        NiafBV5Wq+PFkMQWzl6yuF78IXRIw2Y3u9iH8LO68CR42/0LIMROot+TiVqt8+uY8V848QyaOXipK
        tYxLY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gK5nF-0002uX-SG; Tue, 06 Nov 2018 18:09:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 94942112266B; Tue,  6 Nov 2018 18:09:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        rohitkr@codeaurora.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6asm-dai: Only add routing once." to the asoc tree
In-Reply-To:  <20181106113857.19737-2-srinivas.kandagatla@linaro.org>
Message-Id: <20181106180937.94942112266B@debutante.sirena.org.uk>
Date:   Tue,  6 Nov 2018 18:09:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6asm-dai: Only add routing once.

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

From 9de57ff1566fd36a664c1b04a641e26fed472a9c Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 6 Nov 2018 11:38:56 +0000
Subject: [PATCH] ASoC: qdsp6: q6asm-dai: Only add routing once.

q6asm routing gets added multiple times as part of dai probe.
Move this to q6routing routes which has those widgets defined, this also
fixes the issue where these are added each time at dai probe.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 33 --------------------------------
 sound/soc/qcom/qdsp6/q6routing.c | 19 ++++++++++++++++++
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index a16c71c03058..86115de5c1b2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -122,7 +122,6 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 			.rate_max =	48000,				\
 		},							\
 		.name = "MultiMedia"#num,				\
-		.probe = fe_dai_probe,					\
 		.id = MSM_FRONTEND_DAI_MULTIMEDIA##num,			\
 	}
 
@@ -511,38 +510,6 @@ static void q6asm_dai_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
-static const struct snd_soc_dapm_route afe_pcm_routes[] = {
-	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
-	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
-	{"MM_DL3",  NULL, "MultiMedia3 Playback" },
-	{"MM_DL4",  NULL, "MultiMedia4 Playback" },
-	{"MM_DL5",  NULL, "MultiMedia5 Playback" },
-	{"MM_DL6",  NULL, "MultiMedia6 Playback" },
-	{"MM_DL7",  NULL, "MultiMedia7 Playback" },
-	{"MM_DL7",  NULL, "MultiMedia8 Playback" },
-	{"MultiMedia1 Capture", NULL, "MM_UL1"},
-	{"MultiMedia2 Capture", NULL, "MM_UL2"},
-	{"MultiMedia3 Capture", NULL, "MM_UL3"},
-	{"MultiMedia4 Capture", NULL, "MM_UL4"},
-	{"MultiMedia5 Capture", NULL, "MM_UL5"},
-	{"MultiMedia6 Capture", NULL, "MM_UL6"},
-	{"MultiMedia7 Capture", NULL, "MM_UL7"},
-	{"MultiMedia8 Capture", NULL, "MM_UL8"},
-
-};
-
-static int fe_dai_probe(struct snd_soc_dai *dai)
-{
-	struct snd_soc_dapm_context *dapm;
-
-	dapm = snd_soc_component_get_dapm(dai->component);
-	snd_soc_dapm_add_routes(dapm, afe_pcm_routes,
-				ARRAY_SIZE(afe_pcm_routes));
-
-	return 0;
-}
-
-
 static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.name		= DRV_NAME,
 	.ops		= &q6asm_dai_ops,
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index c6b51571be94..d61b8404f7da 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -909,6 +909,25 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"MM_UL6", NULL, "MultiMedia6 Mixer"},
 	{"MM_UL7", NULL, "MultiMedia7 Mixer"},
 	{"MM_UL8", NULL, "MultiMedia8 Mixer"},
+
+	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
+	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
+	{"MM_DL3",  NULL, "MultiMedia3 Playback" },
+	{"MM_DL4",  NULL, "MultiMedia4 Playback" },
+	{"MM_DL5",  NULL, "MultiMedia5 Playback" },
+	{"MM_DL6",  NULL, "MultiMedia6 Playback" },
+	{"MM_DL7",  NULL, "MultiMedia7 Playback" },
+	{"MM_DL8",  NULL, "MultiMedia8 Playback" },
+
+	{"MultiMedia1 Capture", NULL, "MM_UL1"},
+	{"MultiMedia2 Capture", NULL, "MM_UL2"},
+	{"MultiMedia3 Capture", NULL, "MM_UL3"},
+	{"MultiMedia4 Capture", NULL, "MM_UL4"},
+	{"MultiMedia5 Capture", NULL, "MM_UL5"},
+	{"MultiMedia6 Capture", NULL, "MM_UL6"},
+	{"MultiMedia7 Capture", NULL, "MM_UL7"},
+	{"MultiMedia8 Capture", NULL, "MM_UL8"},
+
 };
 
 static int routing_hw_params(struct snd_pcm_substream *substream,
-- 
2.19.0.rc2

