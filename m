Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D38C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADAE218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546621726;
	bh=BPj0J1BiSeJgM8zRFGw+k8daP0vn2z24ikffowNPjRA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PeXEeZEgy7f6yt3W6EdFa9/YIi1rwdWxOOoxEqDFKREw+bAvBd5PNc9/C8yjWIGqi
	 YcAwsdmPtinojDlMN1USkovlQa8+9sxCyhc0QioMNnT6r9XK8hPvlUwtZatSYzhG9S
	 AQyoJg0G+JrdRjnAfPZ/OywRGXIbJ4/FBDfPl10I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfADRIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:08:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57866 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfADRIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=d5yBQl7GhItGpxXtDdgJRkDb4DwgtP4xIKZU27aqlr0=; b=m5+/aLn66F/8
        +R2U/FHXGlGj/xlaEkYYWjJRybMSdo+up51vrEHJeOq08uJkyJuug/XDCMhWBm1bLwSOCZ4uOay6v
        7VwP2cPparliHxAAFXZFozfD+xaT+eL9Vc7iO8rRl5IHZC1ZjBIpg72f2x1fv71RxgTLREH1uLU1n
        /MXhw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gfSxZ-0001n3-HC; Fri, 04 Jan 2019 17:08:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2F15511270A3; Fri,  4 Jan 2019 17:08:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        jsarha@ti.com, robh+dt@kernel.org, misael.lopez@ti.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm callbacks" to the asoc tree
In-Reply-To:  <20190103140552.29809-2-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Message-Id: <20190104170837.2F15511270A3@debutante.sirena.org.uk>
Date:   Fri,  4 Jan 2019 17:08:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm callbacks

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

From 6175471755075d256c1c654151fc1cad183c1e33 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 3 Jan 2019 16:05:50 +0200
Subject: [PATCH] ASoC: ti: davinci-mcasp: Move context save/restore to
 runtime_pm callbacks

McASP can loose it's context when runtime_pm is disabled.
Save and restore the context when suspending and resuming the device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 136 +++++++++++++++++------------------
 1 file changed, 64 insertions(+), 72 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index eeda6d5565bc..a10fcb5963c6 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -108,7 +108,7 @@ struct davinci_mcasp {
 	/* Used for comstraint setting on the second stream */
 	u32	channels;
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 	struct davinci_mcasp_context context;
 #endif
 
@@ -1486,74 +1486,6 @@ static int davinci_mcasp_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
-{
-	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-	struct davinci_mcasp_context *context = &mcasp->context;
-	u32 reg;
-	int i;
-
-	context->pm_state = pm_runtime_active(mcasp->dev);
-	if (!context->pm_state)
-		pm_runtime_get_sync(mcasp->dev);
-
-	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
-		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
-
-	if (mcasp->txnumevt) {
-		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-		context->afifo_regs[0] = mcasp_get_reg(mcasp, reg);
-	}
-	if (mcasp->rxnumevt) {
-		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-		context->afifo_regs[1] = mcasp_get_reg(mcasp, reg);
-	}
-
-	for (i = 0; i < mcasp->num_serializer; i++)
-		context->xrsr_regs[i] = mcasp_get_reg(mcasp,
-						DAVINCI_MCASP_XRSRCTL_REG(i));
-
-	pm_runtime_put_sync(mcasp->dev);
-
-	return 0;
-}
-
-static int davinci_mcasp_resume(struct snd_soc_dai *dai)
-{
-	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
-	struct davinci_mcasp_context *context = &mcasp->context;
-	u32 reg;
-	int i;
-
-	pm_runtime_get_sync(mcasp->dev);
-
-	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
-		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
-
-	if (mcasp->txnumevt) {
-		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
-		mcasp_set_reg(mcasp, reg, context->afifo_regs[0]);
-	}
-	if (mcasp->rxnumevt) {
-		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
-		mcasp_set_reg(mcasp, reg, context->afifo_regs[1]);
-	}
-
-	for (i = 0; i < mcasp->num_serializer; i++)
-		mcasp_set_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
-			      context->xrsr_regs[i]);
-
-	if (!context->pm_state)
-		pm_runtime_put_sync(mcasp->dev);
-
-	return 0;
-}
-#else
-#define davinci_mcasp_suspend NULL
-#define davinci_mcasp_resume NULL
-#endif
-
 #define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_192000
 
 #define DAVINCI_MCASP_PCM_FMTS (SNDRV_PCM_FMTBIT_S8 | \
@@ -1571,8 +1503,6 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 	{
 		.name		= "davinci-mcasp.0",
 		.probe		= davinci_mcasp_dai_probe,
-		.suspend	= davinci_mcasp_suspend,
-		.resume		= davinci_mcasp_resume,
 		.playback	= {
 			.channels_min	= 1,
 			.channels_max	= 32 * 16,
@@ -1976,7 +1906,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	}
 
 	mcasp->num_serializer = pdata->num_serializer;
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 	mcasp->context.xrsr_regs = devm_kcalloc(&pdev->dev,
 					mcasp->num_serializer, sizeof(u32),
 					GFP_KERNEL);
@@ -2196,11 +2126,73 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int davinci_mcasp_runtime_suspend(struct device *dev)
+{
+	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
+	struct davinci_mcasp_context *context = &mcasp->context;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
+		context->config_regs[i] = mcasp_get_reg(mcasp, context_regs[i]);
+
+	if (mcasp->txnumevt) {
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+		context->afifo_regs[0] = mcasp_get_reg(mcasp, reg);
+	}
+	if (mcasp->rxnumevt) {
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+		context->afifo_regs[1] = mcasp_get_reg(mcasp, reg);
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		context->xrsr_regs[i] = mcasp_get_reg(mcasp,
+						DAVINCI_MCASP_XRSRCTL_REG(i));
+
+	return 0;
+}
+
+static int davinci_mcasp_runtime_resume(struct device *dev)
+{
+	struct davinci_mcasp *mcasp = dev_get_drvdata(dev);
+	struct davinci_mcasp_context *context = &mcasp->context;
+	u32 reg;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(context_regs); i++)
+		mcasp_set_reg(mcasp, context_regs[i], context->config_regs[i]);
+
+	if (mcasp->txnumevt) {
+		reg = mcasp->fifo_base + MCASP_WFIFOCTL_OFFSET;
+		mcasp_set_reg(mcasp, reg, context->afifo_regs[0]);
+	}
+	if (mcasp->rxnumevt) {
+		reg = mcasp->fifo_base + MCASP_RFIFOCTL_OFFSET;
+		mcasp_set_reg(mcasp, reg, context->afifo_regs[1]);
+	}
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		mcasp_set_reg(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
+			      context->xrsr_regs[i]);
+
+	return 0;
+}
+
+#endif
+
+static const struct dev_pm_ops davinci_mcasp_pm_ops = {
+	SET_RUNTIME_PM_OPS(davinci_mcasp_runtime_suspend,
+			   davinci_mcasp_runtime_resume,
+			   NULL)
+};
+
 static struct platform_driver davinci_mcasp_driver = {
 	.probe		= davinci_mcasp_probe,
 	.remove		= davinci_mcasp_remove,
 	.driver		= {
 		.name	= "davinci-mcasp",
+		.pm     = &davinci_mcasp_pm_ops,
 		.of_match_table = mcasp_dt_ids,
 	},
 };
-- 
2.20.1

