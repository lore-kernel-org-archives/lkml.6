Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7B1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE7C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551198183;
	bh=nFK4a31hJE+WeyR+xDY2JHT0DY6wEO8n2QxH+b0I4rA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=f4VvAtP/WRsUdJtIKvJ80+LWnhy8wlwJ/QQtXpRdHr0vmb5cvC3gcZ0eE5qDIOcGJ
	 BNMyQKU05aW/E7qkeQQITJk+Es+zj4HyZRH4gSJ7qw1dbkW4blU56jUoAWCtq6ZbFn
	 czpPHMiOA0PBtjvNHCEC0p3klzl0Q3ogCVxtV8/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfBZQWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:22:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36168 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfBZQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=iBKPSsrkqD/I+NqUT441hOMdauH7N07h2jjHLfK+AnI=; b=PjhNqiCtrUbf
        2pr++4miFO197tNqqM5+bhkF93HKL4Uf8HAhYZcJxdviZLTjMEr62EffZV2yyLI0lbhMewf7SOIqQ
        7NkUa9Tq7NjqlTTmzUBVawUxXN9O3psRYo4MAKwS4DJgwvzB72rwAlh1sngbp7HhtcWiOJx17M/fa
        iaA3o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfUv-000091-Mt; Tue, 26 Feb 2019 16:22:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3DC5E1121A0A; Tue, 26 Feb 2019 16:22:25 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: i2s: fix race condition in irq handler" to the asoc tree
In-Reply-To:  <1551189070-15469-7-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190226162225.3DC5E1121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:22:25 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: fix race condition in irq handler

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

From 3005decf4fe43e65d882dce838716bd6715757c1 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:09 +0100
Subject: [PATCH] ASoC: stm32: i2s: fix race condition in irq handler

When snd_pcm_stop_xrun() is called in interrupt routine,
substream context may have already been released.
Add protection on substream context.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 9edb753ffa1b..42ce87a35104 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -201,6 +201,7 @@ enum i2s_datlen {
  * @base:  mmio register base virtual address
  * @phys_addr: I2S registers physical base address
  * @lock_fd: lock to manage race conditions in full duplex mode
+ * @irq_lock: prevent race condition with IRQ
  * @dais_name: DAI name
  * @mclk_rate: master clock frequency (Hz)
  * @fmt: DAI protocol
@@ -222,6 +223,7 @@ struct stm32_i2s_data {
 	void __iomem *base;
 	dma_addr_t phys_addr;
 	spinlock_t lock_fd; /* Manage race conditions for full duplex */
+	spinlock_t irq_lock; /* used to prevent race condition with IRQ */
 	char dais_name[STM32_I2S_DAI_NAME_SIZE];
 	unsigned int mclk_rate;
 	unsigned int fmt;
@@ -263,8 +265,10 @@ static irqreturn_t stm32_i2s_isr(int irq, void *devid)
 	if (flags & I2S_SR_TIFRE)
 		dev_dbg(&pdev->dev, "Frame error\n");
 
-	if (err)
+	spin_lock(&i2s->irq_lock);
+	if (err && i2s->substream)
 		snd_pcm_stop_xrun(i2s->substream);
+	spin_unlock(&i2s->irq_lock);
 
 	return IRQ_HANDLED;
 }
@@ -540,9 +544,12 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&i2s->irq_lock, flags);
 	i2s->substream = substream;
+	spin_unlock_irqrestore(&i2s->irq_lock, flags);
 
 	ret = clk_prepare_enable(i2s->i2sclk);
 	if (ret < 0) {
@@ -673,13 +680,16 @@ static void stm32_i2s_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
-
-	i2s->substream = NULL;
+	unsigned long flags;
 
 	regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
 			   I2S_CGFR_MCKOE, (unsigned int)~I2S_CGFR_MCKOE);
 
 	clk_disable_unprepare(i2s->i2sclk);
+
+	spin_lock_irqsave(&i2s->irq_lock, flags);
+	i2s->substream = NULL;
+	spin_unlock_irqrestore(&i2s->irq_lock, flags);
 }
 
 static int stm32_i2s_dai_probe(struct snd_soc_dai *cpu_dai)
@@ -874,6 +884,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 	i2s->pdev = pdev;
 	i2s->ms_flg = I2S_MS_NOT_SET;
 	spin_lock_init(&i2s->lock_fd);
+	spin_lock_init(&i2s->irq_lock);
 	platform_set_drvdata(pdev, i2s);
 
 	ret = stm32_i2s_dais_init(pdev, i2s);
-- 
2.20.1

