Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9712C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CEC20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HL0minfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CEC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934845AbeFRMAV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934774AbeFRMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=y4OrGW1N7hlTHqtwKHXwXqscq6Zb/tUHzruiqKPnvB4=; b=HL0minfHEpGY
        L2USjJFpjDCIeJ3hXNgOwaNL5Iv+EYVm5hZvJ2BIgHuA8sUgCkNPArK3KJnMGic9Pvn3Wg9WhjPUZ
        sdnHudwf79Tv4hsHvvtV98sZvkUHS37zSh4XFA+p7n73LJQFIXhAb6mm5fpYYdpeCOyF0qIOz0c/H
        mVEiE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspQ-0007y7-BW; Mon, 18 Jun 2018 12:00:12 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspP-00009M-T8; Mon, 18 Jun 2018 13:00:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: simple-card: move hp and mic detection to soc_card probe" to the asoc tree
In-Reply-To:  <20180611083214.16858-2-suzuki.katsuhiro@socionext.com>
Message-Id: <E1fUspP-00009M-T8@debutante>
Date:   Mon, 18 Jun 2018 13:00:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card: move hp and mic detection to soc_card probe

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

From 8d1bd113a194407f9ad083403ea1cf92108edf5c Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Mon, 11 Jun 2018 17:32:13 +0900
Subject: [PATCH] ASoC: simple-card: move hp and mic detection to soc_card
 probe

This patch moves headphone and microphone detection to probe() of
snd_soc_card from init() of snd_soc_dai_link. This is because init()
is called (and an input device /dev/input/eventX is created too)
twice or above if simple card has two or more DAI links.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index a6477a022156..c5b6e04cd926 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -149,14 +149,6 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_hp(rtd->card, &priv->hp_jack, PREFIX);
-	if (ret < 0)
-		return ret;
-
-	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -350,6 +342,22 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	return ret;
 }
 
+static int asoc_simple_soc_card_probe(struct snd_soc_card *card)
+{
+	struct simple_card_data *priv = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, PREFIX);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, PREFIX);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct simple_card_data *priv;
@@ -385,6 +393,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
 	card->num_links		= num;
+	card->probe		= asoc_simple_soc_card_probe;
 
 	if (np && of_device_is_available(np)) {
 
-- 
2.17.1

