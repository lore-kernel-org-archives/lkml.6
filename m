Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06AFECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895272075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DbzdEK9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbeGRNFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:05:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47542 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeGRNFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=zppDgBKqlClnCkQMZk6ngSfqmpx68yrd4Z6oSU7tnao=; b=DbzdEK9d6L3a
        uXb2vsRQxdBMIKSlF3vaMiaMtNwqmz436jx3NWd5XYiJ/WhnBn7h39xFJS8oZJfKIuZfNir0BPdr/
        ygV9IMRKIkbaydStNNkqn2AaaPDcmhW440CE23Or8xKVJXT67ZizwI6i9zt/95JBLjB6sV1f0SV+P
        gEcjk=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflYf-0003Vb-6R; Wed, 18 Jul 2018 12:27:53 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflYe-0007Kl-OZ; Wed, 18 Jul 2018 13:27:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        tiwai@suse.com, vkoul@kernel.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6routing: remove component framework related code" to the asoc tree
In-Reply-To:  <20180713153632.32511-5-srinivas.kandagatla@linaro.org>
Message-Id: <E1fflYe-0007Kl-OZ@debutante>
Date:   Wed, 18 Jul 2018 13:27:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6routing: remove component framework related code

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

From 791940779d651c2219e97702d2245b5420b0c8ae Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 13 Jul 2018 16:36:31 +0100
Subject: [PATCH] ASoC: qdsp6: q6routing: remove component framework related
 code

Now that the component framework is integrated into the ASoC core,
remove any redundant code in this driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 35269b492761..1d33b00e5b44 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -8,7 +8,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/bitops.h>
-#include <linux/component.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
@@ -977,9 +976,10 @@ static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.num_dapm_routes = ARRAY_SIZE(intercon),
 };
 
-static int q6routing_dai_bind(struct device *dev, struct device *master,
-			      void *data)
+static int q6pcm_routing_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+
 	routing_data = kzalloc(sizeof(*routing_data), GFP_KERNEL);
 	if (!routing_data)
 		return -ENOMEM;
@@ -989,35 +989,15 @@ static int q6routing_dai_bind(struct device *dev, struct device *master,
 	mutex_init(&routing_data->lock);
 	dev_set_drvdata(dev, routing_data);
 
-	return snd_soc_register_component(dev, &msm_soc_routing_component,
+	return devm_snd_soc_register_component(dev, &msm_soc_routing_component,
 					  NULL, 0);
 }
 
-static void q6routing_dai_unbind(struct device *dev, struct device *master,
-				 void *d)
+static int q6pcm_routing_remove(struct platform_device *pdev)
 {
-	struct msm_routing_data *data = dev_get_drvdata(dev);
-
-	snd_soc_unregister_component(dev);
-
-	kfree(data);
-
+	kfree(routing_data);
 	routing_data = NULL;
-}
 
-static const struct component_ops q6routing_dai_comp_ops = {
-	.bind   = q6routing_dai_bind,
-	.unbind = q6routing_dai_unbind,
-};
-
-static int q6pcm_routing_probe(struct platform_device *pdev)
-{
-	return component_add(&pdev->dev, &q6routing_dai_comp_ops);
-}
-
-static int q6pcm_routing_remove(struct platform_device *pdev)
-{
-	component_del(&pdev->dev, &q6routing_dai_comp_ops);
 	return 0;
 }
 
-- 
2.18.0

