Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B502147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576854;
	bh=QV/yQ/aaxTz6U0iRpJUqDOJWUr+vNHUl5KLVTOYjDtk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=adjzgrdpwo4MgEPUgukQ9E27nDcZ8zmz2vt+aNTwrzTBIAjSGOEWre2I016uJGvEE
	 Ip+0cpQgLfC7YZM6d1d11apAgJhdzhG9qluH87PgxcekRCehVuu2ouubtZf5aJ3KxY
	 9bHWamC0xthOPd79D72xsNx9lCsADYprVdD/NtDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfBSLrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:47:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfBSLr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=p6Aw3NNnIP4LVC4pA028r3wni+o8p3Cvh5fLFCzuJ30=; b=bOA/4/ceuqQU
        Rfdb/bld6SF7EiZKo+AeHLjK5xHq3RCK0Ypxh7Z7S5OboGqjgNoth4JDFeN8fdoGlwwkkh+hrNt91
        2/t+mXbqq8kSKuta0H0A5YURmnTY8fwDkYuIx0X4eE5U8hyxetSAJwSaFlzbGnp3NhInCBvVwDhmo
        7Q4XQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3rg-0008ST-Tq; Tue, 19 Feb 2019 11:47:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7EC7E11284A6; Tue, 19 Feb 2019 11:47:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <yellowriver2010@hotmail.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav@sirena.org.uk,
        Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, alsa-devel@alsa-project.org
Subject: Applied "SoC: imx-sgtl5000: add missing put_device()" to the asoc tree
In-Reply-To:  <HK0PR02MB3634C18C42652DC3A2893043B2630@HK0PR02MB3634.apcprd02.prod.outlook.com>
X-Patchwork-Hint: ignore
Message-Id: <20190219114708.7EC7E11284A6@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   SoC: imx-sgtl5000: add missing put_device()

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

From 8fa857da9744f513036df1c43ab57f338941ae7d Mon Sep 17 00:00:00 2001
From: Wen Yang <yellowriver2010@hotmail.com>
Date: Mon, 18 Feb 2019 15:13:47 +0000
Subject: [PATCH] SoC: imx-sgtl5000: add missing put_device()

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Detected by coccinelle with the following warnings:
./sound/soc/fsl/imx-sgtl5000.c:169:1-7: ERROR: missing put_device;
call of_find_device_by_node on line 105, but without a corresponding
object release within this function.
./sound/soc/fsl/imx-sgtl5000.c:177:1-7: ERROR: missing put_device;
call of_find_device_by_node on line 105, but without a corresponding
object release within this function.

Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index b6cb80480b60..bf8597f57dce 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -108,6 +108,7 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 		ret = -EPROBE_DEFER;
 		goto fail;
 	}
+	put_device(&ssi_pdev->dev);
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
 		dev_dbg(&pdev->dev, "failed to find codec platform device\n");
-- 
2.20.1

