Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94974C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50170208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hFKSBPvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50170208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934879AbeFRMAW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45514 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeFRMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZYeAf3woEKXy4ukDQ/rNTDHULGUFX4NZwDmFcfPYx0M=; b=hFKSBPvyNUaw
        VEUV8jVRLnt6D8E1ohbd86RPxzMInjJyveCBq0IHC6vpES2QR16/zeLlV+R2V9VDSQxznlHmQkoCs
        fD/aLT+pBYZXEi+aQWJi4OL6WsIXMs4YZ6WgfigC1OqGms89c2p1mMSS3DhWJ5Z4jZ2419LRbr+72
        OWeyA=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspO-0007xx-6b; Mon, 18 Jun 2018 12:00:10 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspN-00008A-PJ; Mon, 18 Jun 2018 13:00:09 +0100
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
Subject: Applied "ASoC: audio-graph-card: add hp and mic detect gpios same as simple-card" to the asoc tree
In-Reply-To:  <20180611051559.18082-3-suzuki.katsuhiro@socionext.com>
Message-Id: <E1fUspN-00008A-PJ@debutante>
Date:   Mon, 18 Jun 2018 13:00:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: audio-graph-card: add hp and mic detect gpios same as simple-card

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

From f6de35cc145fb55d842db94e74841ecd8382e012 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Mon, 11 Jun 2018 17:32:14 +0900
Subject: [PATCH] ASoC: audio-graph-card: add hp and mic detect gpios same as
 simple-card

This patch adds headphone and microphone jack detection gpios as same
as simple-card driver.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index d93bacacbd5b..a2a3e630f11c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -21,7 +21,6 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
-#include <sound/jack.h>
 #include <sound/simple_card_utils.h>
 
 struct graph_card_data {
@@ -32,6 +31,8 @@ struct graph_card_data {
 		unsigned int mclk_fs;
 	} *dai_props;
 	unsigned int mclk_fs;
+	struct asoc_simple_jack hp_jack;
+	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
 	struct gpio_desc *pa_gpio;
 };
@@ -278,6 +279,22 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	return count;
 }
 
+static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
+{
+	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int asoc_graph_card_probe(struct platform_device *pdev)
 {
 	struct graph_card_data *priv;
@@ -319,6 +336,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->num_links	= num;
 	card->dapm_widgets = asoc_graph_card_dapm_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
+	card->probe	= asoc_graph_soc_card_probe;
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-- 
2.17.1

