Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03678ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F8E214D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NdHdtETV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F8E214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJTANn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:13:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41926 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeJTANn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=bT9bCinp5dex7+pQYzdNT1zHICEYP7Nh2/iqmvsKJ8I=; b=NdHdtETVGuRp
        KSwL7+OmTYK3bv//AuPSuohu9UUZRayLKOEfzkLNB0NEqjZ6BopOpI4jTU/sJ7z7SWWzR41V2uZu6
        ALrsOJKCPtB7e/TRS1pZCzQLQVcl7TGZXqFLUGok20gv4NI3jhBOGcue8XzWcCOlPAGXHCWVH3iOf
        +nFb4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gDXIC-0000P5-Bh; Fri, 19 Oct 2018 16:06:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 151BC1122548; Fri, 19 Oct 2018 17:06:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs42l51: fix mclk support" to the asoc tree
In-Reply-To:  <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
Message-Id: <20181019160628.151BC1122548@debutante.sirena.org.uk>
Date:   Fri, 19 Oct 2018 17:06:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: fix mclk support

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

From 318e741ee13b5a72f3051d9bb6852b1f4d02d0bb Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Fri, 19 Oct 2018 17:56:35 +0200
Subject: [PATCH] ASoC: cs42l51: fix mclk support

The MCLK clock is made optional for cs42l51 codec.
However, ASoC DAPM clock supply widget, expects the clock to be defined
unconditionally.
Register MCLK DAPM conditionally in codec driver,
depending on clock presence in DT.

Fixes: 5e8d63a726f8 ("ASoC: cs42l51: add mclk support")
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index eb40bff54cec..fd2bd74024c1 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -21,6 +21,7 @@
  *  - master mode *NOT* supported
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -41,6 +42,7 @@ enum master_slave_mode {
 
 struct cs42l51_private {
 	unsigned int mclk;
+	struct clk *mclk_handle;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
 };
@@ -492,9 +494,13 @@ static int cs42l51_component_probe(struct snd_soc_component *component)
 {
 	int ret, reg;
 	struct snd_soc_dapm_context *dapm;
+	struct cs42l51_private *cs42l51;
 
+	cs42l51 = snd_soc_component_get_drvdata(component);
 	dapm = snd_soc_component_get_dapm(component);
-	snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
+
+	if (cs42l51->mclk_handle)
+		snd_soc_dapm_new_controls(dapm, cs42l51_dapm_mclk_widgets, 1);
 
 	/*
 	 * DAC configuration
@@ -548,6 +554,13 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	dev_set_drvdata(dev, cs42l51);
 
+	cs42l51->mclk_handle = devm_clk_get(dev, "MCLK");
+	if (IS_ERR(cs42l51->mclk_handle)) {
+		if (PTR_ERR(cs42l51->mclk_handle) != -ENOENT)
+			return PTR_ERR(cs42l51->mclk_handle);
+		cs42l51->mclk_handle = NULL;
+	}
+
 	/* Verify that we have a CS42L51 */
 	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
-- 
2.19.0.rc2

