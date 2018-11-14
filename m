Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB61BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684522175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ra0NuwDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684522175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeKNKiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:38:10 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60740 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeKNKiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pSGPnFG1CIUF7i6jLcPIAOXlqnhtt4zqA9N0JCqDKbQ=; b=ra0NuwDKAOAe
        8ZgsVJOmctvmo0bbapxEICgoQ27DPNgk/rdrkCZHZdIUMbQ4HE3HHprKAyqQwsDLan67l7plgRABd
        EfFIMvzXQlsTEdTmhNL5bbALeEA7pE80BgCTpIZXQEVrCc7OzcwEo6hv7gzGGoHUbA2A1EINACMwP
        NTghA=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMjBC-0002on-Ka; Wed, 14 Nov 2018 00:37:14 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4047B440078; Wed, 14 Nov 2018 00:37:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: pcm3060: Add DT property for single-ended output" to the asoc tree
In-Reply-To:  <20181112070834.16979-2-kmarinushkin@birdec.tech>
Message-Id: <20181114003707.4047B440078@finisterre.ee.mobilebroadband>
Date:   Wed, 14 Nov 2018 00:37:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pcm3060: Add DT property for single-ended output

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

From b1c0000bde8fb287f4fd3493ca4167efee344c3e Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Mon, 12 Nov 2018 08:08:33 +0100
Subject: [PATCH] ASoC: pcm3060: Add DT property for single-ended output

DAC output may be differential (default) or single-ended.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 14 ++++++++++++++
 sound/soc/codecs/pcm3060.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 771b46e1974b..1dd851a7b43b 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -270,9 +270,23 @@ EXPORT_SYMBOL(pcm3060_regmap);
 
 /* device */
 
+static void pcm3060_parse_dt(const struct device_node *np,
+			     struct pcm3060_priv *priv)
+{
+	priv->out_se = of_property_read_bool(np, "ti,out-single-ended");
+}
+
 int pcm3060_probe(struct device *dev)
 {
 	int rc;
+	struct pcm3060_priv *priv = dev_get_drvdata(dev);
+
+	if (dev->of_node)
+		pcm3060_parse_dt(dev->of_node, priv);
+
+	if (priv->out_se)
+		regmap_update_bits(priv->regmap, PCM3060_REG64,
+				   PCM3060_REG_SE, PCM3060_REG_SE);
 
 	rc = devm_snd_soc_register_component(dev, &pcm3060_soc_comp_driver,
 					     pcm3060_dai,
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index fd89a68aa8a7..c895cf40ee10 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -25,6 +25,7 @@ struct pcm3060_priv_dai {
 struct pcm3060_priv {
 	struct regmap *regmap;
 	struct pcm3060_priv_dai dai[PCM3060_DAI_IDS_NUM];
+	u8 out_se: 1;
 };
 
 int pcm3060_probe(struct device *dev);
-- 
2.19.1

