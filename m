Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D563BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F87620858
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UfITK1+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F87620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeGRNFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:05:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47546 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeGRNFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+8DMONg4rahyyemOjCd5m9hA7xNA/i+/H15GhfhMxBg=; b=UfITK1+wHABo
        yOeOZlncHVIBTAQqRUDVwwFtBleDTvlLMT3OK9yyB/SWQufNfY9mDc0RNLG34vcJJfaw8TGBUJQ2P
        Xh7qg81zKeHa8NgtETLbcRfApg/+SWR9vll4/T5kF8CUndjhdGVBV/2xEkof21Y/MPQdeWjCP1shX
        CMVLg=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflYd-0003VY-1p; Wed, 18 Jul 2018 12:27:51 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflYc-0007Je-JJ; Wed, 18 Jul 2018 13:27:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qcom: apq8096: remove component framework related code" to the asoc tree
In-Reply-To:  <20180713153632.32511-6-srinivas.kandagatla@linaro.org>
Message-Id: <E1fflYc-0007Je-JJ@debutante>
Date:   Wed, 18 Jul 2018 13:27:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: apq8096: remove component framework related code

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

From 90ae7105eaf19342bb11e554059d62b84e01da12 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 13 Jul 2018 16:36:32 +0100
Subject: [PATCH] ASoC: qcom: apq8096: remove component framework related code

Now that the component framework is integrated into the ASoC core,
remove any redundant code in this driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8096.c | 75 ++++------------------------------------
 1 file changed, 6 insertions(+), 69 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index cab8c4ff7c00..a56156281c8d 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -129,17 +129,18 @@ static int apq8096_sbc_parse_of(struct snd_soc_card *card)
 	return ret;
 }
 
-static int apq8096_bind(struct device *dev)
+static int apq8096_platform_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	card = kzalloc(sizeof(*card), GFP_KERNEL);
 	if (!card)
 		return -ENOMEM;
 
-	component_bind_all(dev, card);
 	card->dev = dev;
+	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
 	ret = apq8096_sbc_parse_of(card);
 	if (ret) {
@@ -154,82 +155,18 @@ static int apq8096_bind(struct device *dev)
 	return 0;
 
 err:
-	component_unbind_all(dev, card);
 	kfree(card);
 	return ret;
 }
 
-static void apq8096_unbind(struct device *dev)
+static int apq8096_platform_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
 
+	card->auto_bind = false;
 	snd_soc_unregister_card(card);
-	component_unbind_all(dev, card);
 	kfree(card->dai_link);
 	kfree(card);
-}
-
-static const struct component_master_ops apq8096_ops = {
-	.bind = apq8096_bind,
-	.unbind = apq8096_unbind,
-};
-
-static int apq8016_compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static void apq8016_release_of(struct device *dev, void *data)
-{
-	of_node_put(data);
-}
-
-static int add_audio_components(struct device *dev,
-				struct component_match **matchptr)
-{
-	struct device_node *np, *platform, *cpu, *node, *dai_node;
-
-	node = dev->of_node;
-
-	for_each_child_of_node(node, np) {
-		cpu = of_get_child_by_name(np, "cpu");
-		if (cpu) {
-			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
-			of_node_get(dai_node);
-			component_match_add_release(dev, matchptr,
-						    apq8016_release_of,
-						    apq8016_compare_of,
-						    dai_node);
-		}
-
-		platform = of_get_child_by_name(np, "platform");
-		if (platform) {
-			dai_node = of_parse_phandle(platform, "sound-dai", 0);
-			component_match_add_release(dev, matchptr,
-						    apq8016_release_of,
-						    apq8016_compare_of,
-						    dai_node);
-		}
-	}
-
-	return 0;
-}
-
-static int apq8096_platform_probe(struct platform_device *pdev)
-{
-	struct component_match *match = NULL;
-	int ret;
-
-	ret = add_audio_components(&pdev->dev, &match);
-	if (ret)
-		return ret;
-
-	return component_master_add_with_match(&pdev->dev, &apq8096_ops, match);
-}
-
-static int apq8096_platform_remove(struct platform_device *pdev)
-{
-	component_master_del(&pdev->dev, &apq8096_ops);
 
 	return 0;
 }
-- 
2.18.0

