Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90300C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEDE208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FJYs9Nsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEDE208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934992AbeFRMAf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46026 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934931AbeFRMAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cODi900G5xOZ0pXRFs7Lle3IzqrbKHVoAbh19dn8oYo=; b=FJYs9NsuyDX3
        VK/951n25ukAnIfvtLLN1lir0XtqOQF/UA8TgMuJuj++X700eLAERP5YWaxoziMqf0niEVqsPgb+h
        kwb+1KqCzQhol8NQL5wRqwCYY++F/37SQzHZmAb3brcVMVUNF/1iaIuXaIG/bHpXKUFNvLgDaG6O2
        G4pyY=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspa-0007yo-MX; Mon, 18 Jun 2018 12:00:22 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspa-0000EU-8H; Mon, 18 Jun 2018 13:00:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, ldv-project@linuxtesting.org,
        alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        linux-rockchip@lists.infradead.org, sil2review@lists.osadl.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: rockchip: put device_node on remove" to the asoc tree
In-Reply-To:  <1528582854-8402-1-git-send-email-khoroshilov@ispras.ru>
Message-Id: <E1fUspa-0000EU-8H@debutante>
Date:   Mon, 18 Jun 2018 13:00:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rockchip: put device_node on remove

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

From a56df73ba5960848f60f609c68770d2638bf1dd5 Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sun, 10 Jun 2018 01:20:54 +0300
Subject: [PATCH] ASoC: rockchip: put device_node on remove

snd_rk_mc_probe() gets a couple of device nodes with of_parse_phandle(),
but there is no release of them.

The patch adds remove handler and proper error handling in the probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_rt5645.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 4db4fd56db35..881c32498808 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -181,7 +181,8 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	if (!rk_dailink.cpu_of_node) {
 		dev_err(&pdev->dev,
 			"Property 'rockchip,i2s-controller' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_codec_of_node;
 	}
 
 	rk_dailink.platform_of_node = rk_dailink.cpu_of_node;
@@ -190,17 +191,36 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Soc parse card name failed %d\n", ret);
-		return ret;
+		goto put_cpu_of_node;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Soc register card failed %d\n", ret);
-		return ret;
+		goto put_cpu_of_node;
 	}
 
 	return ret;
+
+put_cpu_of_node:
+	of_node_put(rk_dailink.cpu_of_node);
+	rk_dailink.cpu_of_node = NULL;
+put_codec_of_node:
+	of_node_put(rk_dailink.codec_of_node);
+	rk_dailink.codec_of_node = NULL;
+
+	return ret;
+}
+
+static int snd_rk_mc_remove(struct platform_device *pdev)
+{
+	of_node_put(rk_dailink.cpu_of_node);
+	rk_dailink.cpu_of_node = NULL;
+	of_node_put(rk_dailink.codec_of_node);
+	rk_dailink.codec_of_node = NULL;
+
+	return 0;
 }
 
 static const struct of_device_id rockchip_rt5645_of_match[] = {
@@ -212,6 +232,7 @@ MODULE_DEVICE_TABLE(of, rockchip_rt5645_of_match);
 
 static struct platform_driver snd_rk_mc_driver = {
 	.probe = snd_rk_mc_probe,
+	.remove = snd_rk_mc_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &snd_soc_pm_ops,
-- 
2.17.1

