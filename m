Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44653C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1510E21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549990755;
	bh=f6Htd//0IpTj9kzKprwRvYCkOW3kyD+gXSvySKikaE0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oeTL4swgsxbcNywd4UaAzA4CfVudmFICNuvA3o6rXNiJ1oD4OW087sPGA6w+0iI8T
	 4LCyKQXVC9CUzcala53ACEtdWGhJa5alXkIEu8YM6BuTGUaId5S/AQQo6FaUx6nCSF
	 00G1EHs/Bi5+h/3Uet4scHmA9kSFB2CODSOtt7N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfBLQ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:59:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfBLQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sCggGjmi8IGuFGOWFoWw2UheU29D/VPX3XaJAakmA0Y=; b=J28rhkdouzq0
        LQDehdjDqjjBwSocrcUDueRepgegF4seTCEUaasxStcgdSgxGRpKFRcxXk+qqszZn+O6KMwCRCeg+
        reZMErdE0rC4Qr8vJnE+3a2ibZkDe6vujp/Cu89bwjmUO1rTtuaOEhoE/scx4+/GWrA0A1lEgLGwj
        sES7U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtbOc-0005iY-5K; Tue, 12 Feb 2019 16:58:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B56751128113; Tue, 12 Feb 2019 16:58:57 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, sbkim73@samsung.com, lgirdwood@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: samsung: i2s: Fix prescaler setting for the secondary DAI" to the asoc tree
In-Reply-To:  <20190207170028.720-5-s.nawrocki@samsung.com>
X-Patchwork-Hint: ignore
Message-Id: <20190212165857.B56751128113@debutante.sirena.org.uk>
Date:   Tue, 12 Feb 2019 16:58:57 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: i2s: Fix prescaler setting for the secondary DAI

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

From 323fb7b947b265753de34703dbbf8acc8ea3a4de Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 7 Feb 2019 18:00:12 +0100
Subject: [PATCH] ASoC: samsung: i2s: Fix prescaler setting for the secondary
 DAI

Make sure i2s->rclk_srcrate is properly initialized also during
playback through the secondary DAI.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index ce00fe2f6aae..d4bde4834ce5 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -604,6 +604,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 	unsigned int fmt)
 {
 	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = get_other_dai(i2s);
 	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow, mod_slave;
 	u32 mod, tmp = 0;
 	unsigned long flags;
@@ -661,7 +662,8 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
 		 * clock configuration assigned in DT is not overwritten.
 		 */
-		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL)
+		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL &&
+		    other->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -699,6 +701,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct i2s_dai *i2s = to_info(dai);
+	struct i2s_dai *other = get_other_dai(i2s);
 	u32 mod, mask = 0, val = 0;
 	struct clk *rclksrc;
 	unsigned long flags;
@@ -784,6 +787,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	i2s->frmclk = params_rate(params);
 
 	rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
+	if (!rclksrc || IS_ERR(rclksrc))
+		rclksrc = other->clk_table[CLK_I2S_RCLK_SRC];
+
 	if (rclksrc && !IS_ERR(rclksrc))
 		i2s->rclk_srcrate = clk_get_rate(rclksrc);
 
-- 
2.20.1

