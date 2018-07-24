Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF61ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FF120882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HIprrZIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FF120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbeGXM4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:56:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34354 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbeGXM4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sCeJ7+EFRXJ1MNCwi3vUEXqBCMhpFqb5WwZN0Y3hLvA=; b=HIprrZIJ/tyS
        2cTFn+FYIOcrugF0qx3J9jNXTcK4tHjMR3INpk9Azp/+FjQGrsKHzatG3YNRKUetP+obzhq3axyfH
        EsWGd16i485yTaxrJrNBx6DQtrvRf56AvhelvPxp27orxnAr7jV8UTwVsudIM1r/dFSS7P8t8Z3Bt
        NqTq8=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhvpu-0005Mm-4q; Tue, 24 Jul 2018 11:50:38 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3DF0E440078; Tue, 24 Jul 2018 12:50:37 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, lee.jones@linaro.org,
        robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: core: add support to snd_soc_dai_get_channel_map()" to the asoc tree
In-Reply-To:  <20180723155410.9494-6-srinivas.kandagatla@linaro.org>
Message-Id: <20180724115037.3DF0E440078@finisterre.ee.mobilebroadband>
Date:   Tue, 24 Jul 2018 12:50:37 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: add support to snd_soc_dai_get_channel_map()

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

From 467b061f1ac80f323bedb56d20a24f7bc0d2cec5 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 23 Jul 2018 16:54:03 +0100
Subject: [PATCH] ASoC: core: add support to snd_soc_dai_get_channel_map()

On Qualcomm platforms, specifically with SLIMbus interfaced codecs,
the codec slim channel numbers are passed to DSP while configuring
the slim audio path. Having get_channel_map() would allow dais to
share such information across multiple dais.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  8 ++++++++
 sound/soc/soc-core.c    | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index a14bc0608ae9..f5d70041108f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -138,6 +138,11 @@ int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 			     int direction);
 
+
+int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
+		unsigned int *tx_num, unsigned int *tx_slot,
+		unsigned int *rx_num, unsigned int *rx_slot);
+
 int snd_soc_dai_is_dummy(struct snd_soc_dai *dai);
 
 struct snd_soc_dai_ops {
@@ -165,6 +170,9 @@ struct snd_soc_dai_ops {
 	int (*set_channel_map)(struct snd_soc_dai *dai,
 		unsigned int tx_num, unsigned int *tx_slot,
 		unsigned int rx_num, unsigned int *rx_slot);
+	int (*get_channel_map)(struct snd_soc_dai *dai,
+			unsigned int *tx_num, unsigned int *tx_slot,
+			unsigned int *rx_num, unsigned int *rx_slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad5b0ef16d82..81b27923303d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2679,6 +2679,28 @@ int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_channel_map);
 
+/**
+ * snd_soc_dai_get_channel_map - Get DAI audio channel map
+ * @dai: DAI
+ * @tx_num: how many TX channels
+ * @tx_slot: pointer to an array which imply the TX slot number channel
+ *           0~num-1 uses
+ * @rx_num: how many RX channels
+ * @rx_slot: pointer to an array which imply the RX slot number channel
+ *           0~num-1 uses
+ */
+int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
+	unsigned int *tx_num, unsigned int *tx_slot,
+	unsigned int *rx_num, unsigned int *rx_slot)
+{
+	if (dai->driver->ops->get_channel_map)
+		return dai->driver->ops->get_channel_map(dai, tx_num, tx_slot,
+			rx_num, rx_slot);
+	else
+		return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_get_channel_map);
+
 /**
  * snd_soc_dai_set_tristate - configure DAI system or master clock.
  * @dai: DAI
-- 
2.18.0

