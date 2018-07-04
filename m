Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E395C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C0523E79
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Wh60pm42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C0523E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeGDOmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:42:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeGDOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rQVBQo6a9CiS/Idmx0Fzg0y8UplZ3vkXqbICCyLmAJQ=; b=Wh60pm42WTqB
        mn+8bjuO8tQYJDiwdTilo3F1Auk77uzZk4BwDz8saa2LODMXGQxg2SSQ5WkHEBpa31bxbmRFBNGX5
        Y4EfUbNIsVKhRgO6rmAB0pyLKX3efvQJFuKzMwjiylxl135KBQ0Ing8x85Zqv3Ye8H9xsEM5NlgKY
        3gH/c=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faiyj-00073K-NI; Wed, 04 Jul 2018 14:41:57 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faiyj-0003xf-9K; Wed, 04 Jul 2018 15:41:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6routing: add slim rx routings" to the asoc tree
In-Reply-To:  <20180704094944.16440-4-srinivas.kandagatla@linaro.org>
Message-Id: <E1faiyj-0003xf-9K@debutante>
Date:   Wed, 04 Jul 2018 15:41:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6routing: add slim rx routings

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

From 9191ffe2d212f64aa2ec311f4294ba7066d1f8a1 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:41 +0100
Subject: [PATCH] ASoC: qdsp6: q6routing: add slim rx routings

This patch add routings mixer controls for slim rx ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.18.0.rc2

