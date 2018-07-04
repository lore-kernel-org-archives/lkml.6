Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109BFC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF9D23E79
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mRUChldn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF9D23E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeGDOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:42:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52078 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeGDOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wuWoLOd5wY5pbS8rlLQ0D/JWGspm2odPpJX0bwpYGRM=; b=mRUChldn/BH8
        8WplKQnLWfD5uDm0O3I8sHq4d8Ze+CX0Dm9Lm13FBYFLYnzUp7mBqi+Swwf0XydELR6qs7xCOLXdI
        C5/ttn6gnXxnpbSI/3fw0U1OhOpSoKcajxF2WgcdYujyuyQbUwyP1hC1MwoB1knKK8uKI+WMGdyz1
        OxwAA=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faiyh-00073E-Ts; Wed, 04 Jul 2018 14:41:56 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1faiyh-0003wX-4A; Wed, 04 Jul 2018 15:41:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai num_channels" to the asoc tree
In-Reply-To:  <20180704094944.16440-5-srinivas.kandagatla@linaro.org>
Message-Id: <E1faiyh-0003wX-4A@debutante>
Date:   Wed, 04 Jul 2018 15:41:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai num_channels

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

From f1478a1476d45c5d7b070c726f46a7b581d3103c Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 4 Jul 2018 10:49:42 +0100
Subject: [PATCH] ASoC: qdsp6: q6afe-dai: Do not overwrite slim dai
 num_channels

num_channels for slim dais are aready set int set_channel_map,
do not overwrite them in hw_params.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 8dd3683eb367..074582afda85 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -81,7 +81,6 @@ static int q6slim_hw_params(struct snd_pcm_substream *substream,
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	struct q6afe_slim_cfg *slim = &dai_data->port_config[dai->id].slim;
 
-	slim->num_channels = params_channels(params);
 	slim->sample_rate = params_rate(params);
 
 	switch (params_format(params)) {
-- 
2.18.0.rc2

