Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0398613F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10D720894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="veWxI5ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10D720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeG3Mhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:37:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50300 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeG3Mhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ctB5JL92VoYNZvYSz6X6ThwG4567aUmrayABB6PmceI=; b=veWxI5yekfGN
        niB7emSez9nDvyDmDiYBCXtCFTJHj0slcwn5l6B3p/0ZGpJf5vTGtoqs9uNK8/D+cm3xIAHcdfS3r
        5UTlgauUAU5gqQpoM1eFVhZPN6RYBVqEtEwL5nC1TOHXsQlM/jsETuQF9W5+La7v+dNouVTvKKg0V
        Rwb9I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5x7-00053W-VB; Mon, 30 Jul 2018 11:03:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 72F1F1124216; Mon, 30 Jul 2018 12:03:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: uniphier: change functions to static" to the asoc tree
In-Reply-To:  <20180727023744.7865-1-suzuki.katsuhiro@socionext.com>
Message-Id: <20180730110301.72F1F1124216@debutante.sirena.org.uk>
Date:   Mon, 30 Jul 2018 12:03:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: uniphier: change functions to static

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

From d8504acca759ae672c6d34d49a33d54ace094cbb Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Fri, 27 Jul 2018 11:37:44 +0900
Subject: [PATCH] ASoC: uniphier: change functions to static

This patch changes some functions that are not used by other objects
to static.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/aio-core.c | 6 +++---
 sound/soc/uniphier/aio.h      | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 8b09bbb0f8d0..9bcba06ba52e 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -327,7 +327,7 @@ static int aio_port_set_ch(struct uniphier_aio_sub *sub)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
+static int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	struct device *dev = &sub->aio->chip->pdev->dev;
@@ -446,7 +446,7 @@ int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_fmt(struct uniphier_aio_sub *sub)
+static int aio_port_set_fmt(struct uniphier_aio_sub *sub)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	struct device *dev = &sub->aio->chip->pdev->dev;
@@ -511,7 +511,7 @@ int aio_port_set_fmt(struct uniphier_aio_sub *sub)
  *
  * Return: Zero if successful, otherwise a negative value on error.
  */
-int aio_port_set_clk(struct uniphier_aio_sub *sub)
+static int aio_port_set_clk(struct uniphier_aio_sub *sub)
 {
 	struct uniphier_aio_chip *chip = sub->aio->chip;
 	struct device *dev = &sub->aio->chip->pdev->dev;
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index 23a5c3c68658..ca6ccbae0ee8 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -325,9 +325,6 @@ int aio_chip_set_pll(struct uniphier_aio_chip *chip, int pll_id,
 void aio_chip_init(struct uniphier_aio_chip *chip);
 int aio_init(struct uniphier_aio_sub *sub);
 void aio_port_reset(struct uniphier_aio_sub *sub);
-int aio_port_set_rate(struct uniphier_aio_sub *sub, int rate);
-int aio_port_set_fmt(struct uniphier_aio_sub *sub);
-int aio_port_set_clk(struct uniphier_aio_sub *sub);
 int aio_port_set_param(struct uniphier_aio_sub *sub, int pass_through,
 		       const struct snd_pcm_hw_params *params);
 void aio_port_set_enable(struct uniphier_aio_sub *sub, int enable);
-- 
2.18.0

