Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D71ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6965020684
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="iW+Xa5x9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6965020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbeGRNGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:06:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48834 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeGRNGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GUtDlyvWRjZfHyGWtO5fgiXzmoNTVNnYSvoPRFzjl+E=; b=iW+Xa5x9nDeZ
        zvCfLfcqmx3vwzFymDlFsmUNywNwVm6SEqDmD24/c6XBGkviGbKVB0dPJCEiMJ/qGgtsagwO6FGgq
        zznkuWOyYT29mozFAOTc6D8O+gu6yfDU2aCJbGx6L3KrJD4YXBYrl63Ye4G2s1c7gaW4ftQX8XwFM
        KG+20=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflZQ-0003W0-Q5; Wed, 18 Jul 2018 12:28:40 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflZQ-0007Nf-CO; Wed, 18 Jul 2018 13:28:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe-dai: remove component fw related code" to the asoc tree
In-Reply-To:  <20180713153632.32511-3-srinivas.kandagatla@linaro.org>
Message-Id: <E1fflZQ-0007Nf-CO@debutante>
Date:   Wed, 18 Jul 2018 13:28:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe-dai: remove component fw related code

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

From 605fcb69918528e1a448cba4d358cbd8ed532146 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 13 Jul 2018 16:36:29 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: remove component fw related code

Now that the component framework is integrated into the ASoC core,
remove any redundant code in this driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 34 ++++----------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 074582afda85..e988692a3ced 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -4,7 +4,6 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/component.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
@@ -1395,11 +1394,12 @@ static void of_q6afe_parse_dai_data(struct device *dev,
 	}
 }
 
-static int q6afe_dai_bind(struct device *dev, struct device *master, void *data)
+static int q6afe_dai_dev_probe(struct platform_device *pdev)
 {
 	struct q6afe_dai_data *dai_data;
+	struct device *dev = &pdev->dev;
 
-	dai_data = kzalloc(sizeof(*dai_data), GFP_KERNEL);
+	dai_data = devm_kzalloc(dev, sizeof(*dai_data), GFP_KERNEL);
 	if (!dai_data)
 		return -ENOMEM;
 
@@ -1407,35 +1407,10 @@ static int q6afe_dai_bind(struct device *dev, struct device *master, void *data)
 
 	of_q6afe_parse_dai_data(dev, dai_data);
 
-	return snd_soc_register_component(dev, &q6afe_dai_component,
+	return devm_snd_soc_register_component(dev, &q6afe_dai_component,
 					  q6afe_dais, ARRAY_SIZE(q6afe_dais));
 }
 
-static void q6afe_dai_unbind(struct device *dev, struct device *master,
-			     void *data)
-{
-	struct q6afe_dai_data *dai_data = dev_get_drvdata(dev);
-
-	snd_soc_unregister_component(dev);
-	kfree(dai_data);
-}
-
-static const struct component_ops q6afe_dai_comp_ops = {
-	.bind   = q6afe_dai_bind,
-	.unbind = q6afe_dai_unbind,
-};
-
-static int q6afe_dai_dev_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &q6afe_dai_comp_ops);
-}
-
-static int q6afe_dai_dev_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &q6afe_dai_comp_ops);
-	return 0;
-}
-
 static const struct of_device_id q6afe_dai_device_id[] = {
 	{ .compatible = "qcom,q6afe-dais" },
 	{},
@@ -1448,7 +1423,6 @@ static struct platform_driver q6afe_dai_platform_driver = {
 		.of_match_table = of_match_ptr(q6afe_dai_device_id),
 	},
 	.probe = q6afe_dai_dev_probe,
-	.remove = q6afe_dai_dev_remove,
 };
 module_platform_driver(q6afe_dai_platform_driver);
 
-- 
2.18.0

