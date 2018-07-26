Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12630C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A0E20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="p96lbAMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A0E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbeGZQTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:19:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EPa3G7fnI1mmDwOEguTfQ2D5nXGrTkmQqgHAZxbiVSQ=; b=p96lbAMPbHMR
        gxBlqR9wh/EfZ9nVMjCVkYda/nI1rRw6tgwAo+IoB8HIIXDjQFJPmNbPpDZapUrU3+WByzhLY4I1w
        fiSINlOsqFDkHYc/sJ15fFKJMPRIrMjrYbJqWhcSosL/DXWykQjmE1dm9rdJ+8Ir6DLGszgLgoVV4
        8kGzc=;
Received: from [2a00:23c4:5d8e:0:97c8:1971:bc17:6a1a] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fihls-0007gg-FJ; Thu, 26 Jul 2018 15:01:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F013E440078; Thu, 26 Jul 2018 16:01:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: align axg card driver with DT bindings documentation" to the asoc tree
In-Reply-To:  <20180726124544.14740-4-jbrunet@baylibre.com>
Message-Id: <20180726150139.F013E440078@finisterre.ee.mobilebroadband>
Date:   Thu, 26 Jul 2018 16:01:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: align axg card driver with DT bindings documentation

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

From 435857e015dc7b337c5f21d195ac2e4ffd694283 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 26 Jul 2018 14:45:44 +0200
Subject: [PATCH] ASoC: meson: align axg card driver with DT bindings
 documentation

Drop amlogic prefix in front of the generic DT properties and change
property "name" to "model".

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-card.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index d6d1081d94ad..2914ba0d965b 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -123,7 +123,7 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	struct snd_soc_aux_dev *aux;
 	int num, i;
 
-	num = of_count_phandle_with_args(node, PREFIX "aux-devs", NULL);
+	num = of_count_phandle_with_args(node, "audio-aux-devs", NULL);
 	if (num == -ENOENT) {
 		/*
 		 * It is ok to have no auxiliary devices but for this card it
@@ -144,8 +144,8 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	card->num_aux_devs = num;
 
 	for (i = 0; i < card->num_aux_devs; i++, aux++) {
-		aux->codec_of_node = of_parse_phandle(node,
-						      PREFIX "aux-devs", i);
+		aux->codec_of_node =
+			of_parse_phandle(node, "audio-aux-devs", i);
 		if (!aux->codec_of_node)
 			return -EINVAL;
 	}
@@ -610,18 +610,18 @@ static int axg_card_probe(struct platform_device *pdev)
 	priv->card.owner = THIS_MODULE;
 	priv->card.dev = dev;
 
-	ret = snd_soc_of_parse_card_name(&priv->card, PREFIX "name");
+	ret = snd_soc_of_parse_card_name(&priv->card, "model");
 	if (ret < 0)
 		return ret;
 
-	ret = axg_card_parse_of_optional(&priv->card, PREFIX "routing",
+	ret = axg_card_parse_of_optional(&priv->card, "audio-routing",
 					 snd_soc_of_parse_audio_routing);
 	if (ret) {
 		dev_err(dev, "error while parsing routing\n");
 		return ret;
 	}
 
-	ret = axg_card_parse_of_optional(&priv->card, PREFIX "widgets",
+	ret = axg_card_parse_of_optional(&priv->card, "audio-widgets",
 					 snd_soc_of_parse_audio_simple_widgets);
 	if (ret) {
 		dev_err(dev, "error while parsing widgets\n");
-- 
2.18.0

