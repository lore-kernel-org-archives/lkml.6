Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D98C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A523EC8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hXU2As87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9A523EC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933682AbeGCPeG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:34:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932678AbeGCPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bH46LrjS5f8GaSFac/aURWJ2yPiFCGaaVRemvB30M3E=; b=hXU2As87Z2DU
        Tz80Fnb02hdRqZOOhB5leERAoEvozhyUenReNOh6sYZyoLLF2iIcJxR2IjFGUMnBvuq/28ICwG4zq
        6PIYmPotGbH/Ep4Um+HtCb05LJFUXuEEwiELX0m4vWPilVzmKLY26ahPC2GbFBDNzs3nEE6zYzkj2
        PdMV8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJa-0006AB-3o; Tue, 03 Jul 2018 15:34:02 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faNJZ-0003gg-Kk; Tue, 03 Jul 2018 16:34:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: es7134: correct required power supplies" to the asoc tree
In-Reply-To:  <20180703150600.17697-3-jbrunet@baylibre.com>
Message-Id: <E1faNJZ-0003gg-Kk@debutante>
Date:   Tue, 03 Jul 2018 16:34:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es7134: correct required power supplies

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

From 30ddfffd10b73d5d960650ea70b33a8ee0562679 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 3 Jul 2018 17:05:59 +0200
Subject: [PATCH] ASoC: es7134: correct required power supplies

Drop AVDD in favor of PVDD to match the names used in the datasheet
and only claim PVDD on the es7154. The es7134 and es7144 don't have
a separate supply for the digital I/O.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es7134.c | 44 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 5ad59c38fed1..80f2936cefed 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -35,6 +35,10 @@ struct es7134_clock_mode {
 struct es7134_chip {
 	const struct es7134_clock_mode *modes;
 	unsigned int mode_num;
+	const struct snd_soc_dapm_widget *extra_widgets;
+	unsigned int extra_widget_num;
+	const struct snd_soc_dapm_route *extra_routes;
+	unsigned int extra_route_num;
 };
 
 struct es7134_data {
@@ -110,6 +114,34 @@ static int es7134_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
+static int es7134_component_probe(struct snd_soc_component *c)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(c);
+	struct es7134_data *priv = snd_soc_component_get_drvdata(c);
+	const struct es7134_chip *chip = priv->chip;
+	int ret;
+
+	if (chip->extra_widget_num) {
+		ret = snd_soc_dapm_new_controls(dapm, chip->extra_widgets,
+						chip->extra_widget_num);
+		if (ret) {
+			dev_err(c->dev, "failed to add extra widgets\n");
+			return ret;
+		}
+	}
+
+	if (chip->extra_route_num) {
+		ret = snd_soc_dapm_add_routes(dapm, chip->extra_routes,
+					      chip->extra_route_num);
+		if (ret) {
+			dev_err(c->dev, "failed to add extra routes\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops es7134_dai_ops = {
 	.set_fmt	= es7134_set_fmt,
 	.hw_params	= es7134_hw_params,
@@ -158,9 +190,16 @@ static const struct es7134_clock_mode es7134_modes[] = {
 	},
 };
 
+/* Digital I/O are also supplied by VDD on the es7134 */
+static const struct snd_soc_dapm_route es7134_extra_routes[] = {
+	{ "Playback", NULL, "VDD", }
+};
+
 static const struct es7134_chip es7134_chip = {
 	.modes = es7134_modes,
 	.mode_num = ARRAY_SIZE(es7134_modes),
+	.extra_routes = es7134_extra_routes,
+	.extra_route_num = ARRAY_SIZE(es7134_extra_routes),
 };
 
 static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
@@ -168,17 +207,16 @@ static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("AOUTR"),
 	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD", 0, 0),
-	SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 0, 0),
 };
 
 static const struct snd_soc_dapm_route es7134_dapm_routes[] = {
 	{ "AOUTL", NULL, "DAC" },
 	{ "AOUTR", NULL, "DAC" },
-	{ "Playback", NULL, "VDD" },
-	{ "DAC", NULL, "AVDD" },
+	{ "DAC", NULL, "VDD" },
 };
 
 static const struct snd_soc_component_driver es7134_component_driver = {
+	.probe			= es7134_component_probe,
 	.dapm_widgets		= es7134_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(es7134_dapm_widgets),
 	.dapm_routes		= es7134_dapm_routes,
-- 
2.18.0.rc2

