Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D6DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5071E208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TiXyfT+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5071E208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934720AbeFRMAI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:00:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45030 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbeFRMAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RLdO7RY++Gu9dx/E7EPnh5iQbWr74N+Mo9/ZrEBnH0U=; b=TiXyfT+u1CpS
        EaC17B93tAMYXqOKymapJ+t02LJDpoHqV7qTTN3vClmf0j5iDJ83njdLAN2Ag4Gc7r2D+35UtKyYq
        cvC5XHE5Q5TjIxI0mx2UVSSamzm8uZhsT37R6VPsatNLfaYKIx993Q2wh9iXgxp3kU0q2TGSgts0C
        BXyDs=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsov-0007vw-0t; Mon, 18 Jun 2018 11:59:41 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsot-0008Lr-UI; Mon, 18 Jun 2018 12:59:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, ldv-project@linuxtesting.org,
        alsa-devel@alsa-project.org, sil2review@lists.osadl.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: tegra: fix device_node refcounting" to the asoc tree
In-Reply-To:  <1529101378-5543-1-git-send-email-khoroshilov@ispras.ru>
Message-Id: <E1fUsot-0008Lr-UI@debutante>
Date:   Mon, 18 Jun 2018 12:59:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tegra: fix device_node refcounting

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

From 7c5dfd549617b87db8e891ff4ecaa4a582b6c4cc Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 16 Jun 2018 01:22:58 +0300
Subject: [PATCH] ASoC: tegra: fix device_node refcounting

tegra_rt5677_probe() gets a couple of device nodes with of_parse_phandle(),
but there is no release of them.

The patch adds the release to tegra_rt5677_remove() and
to error handling paths in the probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Nicholas Mc Guire <der.herr@hofr.at>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_rt5677.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
index 0e4805c7b4ca..7081f15302cc 100644
--- a/sound/soc/tegra/tegra_rt5677.c
+++ b/sound/soc/tegra/tegra_rt5677.c
@@ -264,13 +264,13 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing or invalid\n");
 		ret = -EINVAL;
-		goto err;
+		goto err_put_codec_of_node;
 	}
 	tegra_rt5677_dai.platform_of_node = tegra_rt5677_dai.cpu_of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
-		goto err;
+		goto err_put_cpu_of_node;
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
@@ -283,6 +283,13 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
 
 err_fini_utils:
 	tegra_asoc_utils_fini(&machine->util_data);
+err_put_cpu_of_node:
+	of_node_put(tegra_rt5677_dai.cpu_of_node);
+	tegra_rt5677_dai.cpu_of_node = NULL;
+	tegra_rt5677_dai.platform_of_node = NULL;
+err_put_codec_of_node:
+	of_node_put(tegra_rt5677_dai.codec_of_node);
+	tegra_rt5677_dai.codec_of_node = NULL;
 err:
 	return ret;
 }
@@ -296,6 +303,12 @@ static int tegra_rt5677_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
+	tegra_rt5677_dai.platform_of_node = NULL;
+	of_node_put(tegra_rt5677_dai.codec_of_node);
+	tegra_rt5677_dai.codec_of_node = NULL;
+	of_node_put(tegra_rt5677_dai.cpu_of_node);
+	tegra_rt5677_dai.cpu_of_node = NULL;
+
 	return 0;
 }
 
-- 
2.17.1

