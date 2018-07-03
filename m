Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8457EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2A123E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hBsql6gO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2A123E80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933775AbeGCPgr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:36:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37286 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932273AbeGCPeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QocwPLVb3IGJCt2m0lxuWia9vGj/xfmztjuF+qVgBME=; b=hBsql6gO4alV
        mhVyxAHshCLbfEVUDwClFi4OezAvhjttuIGN+1/YPtJrqBjymnqcVH9eczLC8utd3mHKx1VDApxDm
        DmQbejDhy8x0XMZtkFsFD+CMYwTyfUjvxE6r04daHUpJSKo0AjJKizU5jgkRmKjSS+GeJY1eMR9mG
        cfotI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJX-0006A1-Ur; Tue, 03 Jul 2018 15:33:59 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJX-0003fk-FU; Tue, 03 Jul 2018 16:33:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: es7134: add support for the es7154" to the asoc tree
In-Reply-To:  <20180703150600.17697-4-jbrunet@baylibre.com>
Message-Id: <E1faNJX-0003fk-FU@debutante>
Date:   Tue, 03 Jul 2018 16:33:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es7134: add support for the es7154

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

From 563c263248ff37dcd743549a0c0932fe2bf83980 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 3 Jul 2018 17:06:00 +0200
Subject: [PATCH] ASoC: es7134: add support for the es7154

Add support for the es7154 which is basically an es7134 with an
embedded power amplifier and lower maximum sample rate

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es7134.c | 60 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 80f2936cefed..6d7bca7b78ca 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -33,6 +33,7 @@ struct es7134_clock_mode {
 };
 
 struct es7134_chip {
+	struct snd_soc_dai_driver *dai_drv;
 	const struct es7134_clock_mode *modes;
 	unsigned int mode_num;
 	const struct snd_soc_dapm_widget *extra_widgets;
@@ -196,6 +197,7 @@ static const struct snd_soc_dapm_route es7134_extra_routes[] = {
 };
 
 static const struct es7134_chip es7134_chip = {
+	.dai_drv = &es7134_dai,
 	.modes = es7134_modes,
 	.mode_num = ARRAY_SIZE(es7134_modes),
 	.extra_routes = es7134_extra_routes,
@@ -227,6 +229,61 @@ static const struct snd_soc_component_driver es7134_component_driver = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static struct snd_soc_dai_driver es7154_dai = {
+	.name = "es7154-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = (SNDRV_PCM_RATE_8000_48000 |
+			  SNDRV_PCM_RATE_88200      |
+			  SNDRV_PCM_RATE_96000),
+		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
+			    SNDRV_PCM_FMTBIT_S18_3LE |
+			    SNDRV_PCM_FMTBIT_S20_3LE |
+			    SNDRV_PCM_FMTBIT_S24_3LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &es7134_dai_ops,
+};
+
+static const struct es7134_clock_mode es7154_modes[] = {
+	{
+		/* Single speed mode */
+		.rate_min = 8000,
+		.rate_max = 50000,
+		.mclk_fs = (unsigned int[]) { 32, 64, 128, 192, 256,
+					      384, 512, 768, 1024 },
+		.mclk_fs_num = 9,
+	}, {
+		/* Double speed mode */
+		.rate_min = 84000,
+		.rate_max = 100000,
+		.mclk_fs = (unsigned int[]) { 128, 192, 256, 384, 512,
+					      768, 1024},
+		.mclk_fs_num = 7,
+	}
+};
+
+/* Es7154 has a separate supply for digital I/O  */
+static const struct snd_soc_dapm_widget es7154_extra_widgets[] = {
+	SND_SOC_DAPM_REGULATOR_SUPPLY("PVDD", 0, 0),
+};
+
+static const struct snd_soc_dapm_route es7154_extra_routes[] = {
+	{ "Playback", NULL, "PVDD", }
+};
+
+static const struct es7134_chip es7154_chip = {
+	.dai_drv = &es7154_dai,
+	.modes = es7154_modes,
+	.mode_num = ARRAY_SIZE(es7154_modes),
+	.extra_routes = es7154_extra_routes,
+	.extra_route_num = ARRAY_SIZE(es7154_extra_routes),
+	.extra_widgets = es7154_extra_widgets,
+	.extra_widget_num = ARRAY_SIZE(es7154_extra_widgets),
+};
+
 static int es7134_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -245,13 +302,14 @@ static int es7134_probe(struct platform_device *pdev)
 
 	return devm_snd_soc_register_component(&pdev->dev,
 				      &es7134_component_driver,
-				      &es7134_dai, 1);
+				      priv->chip->dai_drv, 1);
 }
 
 #ifdef CONFIG_OF
 static const struct of_device_id es7134_ids[] = {
 	{ .compatible = "everest,es7134", .data = &es7134_chip },
 	{ .compatible = "everest,es7144", .data = &es7134_chip },
+	{ .compatible = "everest,es7154", .data = &es7154_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, es7134_ids);
-- 
2.18.0.rc2

