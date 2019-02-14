Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1875222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HcC90KAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395165AbfBNJib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43818 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395113AbfBNJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:29 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214093826epoutp03e4a508eebb0ef4652a312bde51523b7a~DMXxX9ieU0840508405epoutp03I;
        Thu, 14 Feb 2019 09:38:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214093826epoutp03e4a508eebb0ef4652a312bde51523b7a~DMXxX9ieU0840508405epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137106;
        bh=UyhfJTbo6SaxmfkXHyy33sPK1/ZKpe2+WV/TfxZKw30=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=HcC90KAWyjA8N8UAR25x+MvLE2qMfLQOR/bq2aSsY3JTYHuINICMi13dn+RD+VDlG
         Hsx0ConZX1+3+ssxP24LE//Jy+MtshcOHLp7kaX+bcOJbzApH8MZWkXvG/AlPgwv3P
         s2HvoQZ9kf5hmwW3CjYZ75KBZjK5WOu7dYKvdltE=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214093826epcas1p1dea33f9450d4cdd089db78488c9cf003~DMXw6hzX70748207482epcas1p1M;
        Thu, 14 Feb 2019 09:38:26 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.14.04288.217356C5; Thu, 14 Feb 2019 18:38:26 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093825epcas1p24af57e964af261c979af4d4cbffcfa6c~DMXwP_dV_2981729817epcas1p2K;
        Thu, 14 Feb 2019 09:38:25 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-6d-5c6537122c9b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 89.F3.04015.117356C5; Thu, 14 Feb
        2019 18:38:25 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:25 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 01/13] ASoC: samsung: i2s: Move SFR pointer to
 common driver data structure
Date:   Thu, 14 Feb 2019 10:37:35 +0100
Message-id: <20190214093747.2414-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCmnq6QeWqMwYXDghZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8b15SIFmzMrLl06z9bA+Dq0i5GTQ0LAROLm4h6mLkYuDiGBHYwS
        L1ouMUM43xklDq+5xwhTtW79PBYQW0hgA6PE+lepEEW/GCX2TlnCBJJgEzCU6D3aB9YgIiAm
        cXtOJ9gkZoGVjBJb9m1iA0kIC6RL/N/xDaiIg4NFQFVi5yQlkDCvgJXEvovL2CCWyUus3nCA
        GcTmFLCWmLlpO9QRPWwSS3cVQdguEm/fgYzkALKlJS4dtYUIV0vs2t4NtlZCoINRouXCdmaI
        hLXE4eMXWUFsZgE+iXdfe1ghenklOtqEIEo8JDb9us4C8Vcfo8TmCQuZJjBKLGBkWMUollpQ
        nJueWmxYYKJXnJhbXJqXrpecn7uJERxhWhY7GPec8znEKMDBqMTDWyGUEiPEmlhWXJl7iFGC
        g1lJhPeiUWqMEG9KYmVValF+fFFpTmrxIUZpDhYlcd71Ds4xQgLpiSWp2ampBalFMFkmDk6p
        BsbtAobFe98s+vNIq75q6eSCh7t4djFfZ9HkF1WJeHHVOm6TteGnvf0+Ue5vZq19UPgncsYq
        jYr/LgEH++bKzPqTa2dkF8y87f57G6UdutlLaxiSJj70r1Hv/lf0yOJ9v7dtasbbsK+OzXef
        BajwpPeUBX+LmnZL8an8Yt1+jb5OefazbgYVi5VYijMSDbWYi4oTASuAPFGsAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42I5/e+xoK6geWqMwfEVahZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8b15SIFmzMrLl06z9bA+Dq0i5GTQ0LARGLd+nksXYxcHEIC6xgl
        Lu3rY4dwfjFKPNzTxwRSxSZgKNF7tI8RxBYREJO4PaeTGaSIWWAlo8SR76vAEsIC6RJ/et8A
        JTg4WARUJXZOUgIJ8wpYSey7uIwNYpu8xOoNB5hBbE4Ba4mZm7YzgpQLAdWsO1Q+gZFnASPD
        KkbJ1ILi3PTcYqMCw7zUcr3ixNzi0rx0veT83E2MwBDadlirbwfj/SXxhxgFOBiVeHgVBFJi
        hFgTy4orcw8xSnAwK4nwXjRKjRHiTUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQQHpiSWp2
        ampBahFMlomDU6qBkS+O56z2imUXXmx3YmGPulu5KTp+0z3/HofCdq9vJ1P3v8jXfi2ofOEU
        J4fei9Mserq63AfbxX0FY9x8ErOPThHRWfBi3WW2ZZ6iQqK3hPe4v1txr8/wZNgtFddHanxv
        dx9f3dYcW/zy6s+Su7knNXbraEgcbS5ZHlpkkJv5qSGJn4utMTNHiaU4I9FQi7moOBEAVski
        5R0CAAA=
X-CMS-MailID: 20190214093825epcas1p24af57e964af261c979af4d4cbffcfa6c
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214093825epcas1p24af57e964af261c979af4d4cbffcfa6c
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093825epcas1p24af57e964af261c979af4d4cbffcfa6c@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SFR region is common for both DAIs so move related data structure
field from struct i2s_dai to the common driver data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 106 ++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 47 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 72f0cb7abb30..3f8955608a94 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -60,8 +60,7 @@ struct samsung_i2s_dai_data {
 struct i2s_dai {
 	/* Platform device for this DAI */
 	struct platform_device *pdev;
-	/* Memory mapped SFR region */
-	void __iomem	*addr;
+
 	/* Frame Clock */
 	unsigned frmclk;
 	/*
@@ -100,6 +99,9 @@ struct samsung_i2s_priv {
 	struct platform_device *pdev;
 	struct platform_device *pdev_sec;
 
+	/* Memory mapped SFR region */
+	void __iomem *addr;
+
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t spinlock;
 
@@ -143,7 +145,9 @@ static inline bool is_secondary(struct i2s_dai *i2s)
 /* If operating in SoC-Slave mode */
 static inline bool is_slave(struct i2s_dai *i2s)
 {
-	u32 mod = readl(i2s->addr + I2SMOD);
+	struct samsung_i2s_priv *priv = i2s->priv;
+
+	u32 mod = readl(priv->addr + I2SMOD);
 	return (mod & (1 << i2s->variant_regs->mss_off)) ? true : false;
 }
 
@@ -155,7 +159,7 @@ static inline bool tx_active(struct i2s_dai *i2s)
 	if (!i2s)
 		return false;
 
-	active = readl(i2s->addr + I2SCON);
+	active = readl(i2s->priv->addr + I2SCON);
 
 	if (is_secondary(i2s))
 		active &= CON_TXSDMA_ACTIVE;
@@ -193,7 +197,7 @@ static inline bool rx_active(struct i2s_dai *i2s)
 	if (!i2s)
 		return false;
 
-	active = readl(i2s->addr + I2SCON) & CON_RXDMA_ACTIVE;
+	active = readl(i2s->priv->addr + I2SCON) & CON_RXDMA_ACTIVE;
 
 	return active ? true : false;
 }
@@ -256,8 +260,10 @@ static inline bool is_manager(struct i2s_dai *i2s)
 /* Read RCLK of I2S (in multiples of LRCLK) */
 static inline unsigned get_rfs(struct i2s_dai *i2s)
 {
+	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 rfs;
-	rfs = readl(i2s->addr + I2SMOD) >> i2s->variant_regs->rfs_off;
+
+	rfs = readl(priv->addr + I2SMOD) >> i2s->variant_regs->rfs_off;
 	rfs &= i2s->variant_regs->rfs_mask;
 
 	switch (rfs) {
@@ -275,7 +281,8 @@ static inline unsigned get_rfs(struct i2s_dai *i2s)
 /* Write RCLK of I2S (in multiples of LRCLK) */
 static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 {
-	u32 mod = readl(i2s->addr + I2SMOD);
+	struct samsung_i2s_priv *priv = i2s->priv;
+	u32 mod = readl(priv->addr + I2SMOD);
 	int rfs_shift = i2s->variant_regs->rfs_off;
 
 	mod &= ~(i2s->variant_regs->rfs_mask << rfs_shift);
@@ -307,14 +314,16 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 		break;
 	}
 
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 }
 
 /* Read Bit-Clock of I2S (in multiples of LRCLK) */
 static inline unsigned get_bfs(struct i2s_dai *i2s)
 {
+	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 bfs;
-	bfs = readl(i2s->addr + I2SMOD) >> i2s->variant_regs->bfs_off;
+
+	bfs = readl(priv->addr + I2SMOD) >> i2s->variant_regs->bfs_off;
 	bfs &= i2s->variant_regs->bfs_mask;
 
 	switch (bfs) {
@@ -333,7 +342,8 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 /* Write Bit-Clock of I2S (in multiples of LRCLK) */
 static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
-	u32 mod = readl(i2s->addr + I2SMOD);
+	struct samsung_i2s_priv *priv = i2s->priv;
+	u32 mod = readl(priv->addr + I2SMOD);
 	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
 	int bfs_shift = i2s->variant_regs->bfs_off;
 
@@ -378,13 +388,13 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 		return;
 	}
 
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 }
 
 /* Sample-Size */
 static inline int get_blc(struct i2s_dai *i2s)
 {
-	int blc = readl(i2s->addr + I2SMOD);
+	int blc = readl(i2s->priv->addr + I2SMOD);
 
 	blc = (blc >> 13) & 0x3;
 
@@ -398,7 +408,8 @@ static inline int get_blc(struct i2s_dai *i2s)
 /* TX Channel Control */
 static void i2s_txctrl(struct i2s_dai *i2s, int on)
 {
-	void __iomem *addr = i2s->addr;
+	struct samsung_i2s_priv *priv = i2s->priv;
+	void __iomem *addr = priv->addr;
 	int txr_off = i2s->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
 	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
@@ -448,7 +459,8 @@ static void i2s_txctrl(struct i2s_dai *i2s, int on)
 /* RX Channel Control */
 static void i2s_rxctrl(struct i2s_dai *i2s, int on)
 {
-	void __iomem *addr = i2s->addr;
+	struct samsung_i2s_priv *priv = i2s->priv;
+	void __iomem *addr = priv->addr;
 	int txr_off = i2s->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
 	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
@@ -485,9 +497,9 @@ static inline void i2s_fifo(struct i2s_dai *i2s, u32 flush)
 		return;
 
 	if (is_secondary(i2s))
-		fic = i2s->addr + I2SFICS;
+		fic = i2s->priv->addr + I2SFICS;
 	else
-		fic = i2s->addr + I2SFIC;
+		fic = i2s->priv->addr + I2SFIC;
 
 	/* Flush the FIFO */
 	writel(readl(fic) | flush, fic);
@@ -516,7 +528,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 	pm_runtime_get_sync(dai->dev);
 
 	spin_lock_irqsave(i2s->lock, flags);
-	mod = readl(i2s->addr + I2SMOD);
+	mod = readl(priv->addr + I2SMOD);
 	spin_unlock_irqrestore(i2s->lock, flags);
 
 	switch (clk_id) {
@@ -613,9 +625,9 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 	}
 
 	spin_lock_irqsave(i2s->lock, flags);
-	mod = readl(i2s->addr + I2SMOD);
+	mod = readl(priv->addr + I2SMOD);
 	mod = (mod & ~mask) | val;
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 	spin_unlock_irqrestore(i2s->lock, flags);
 done:
 	pm_runtime_put(dai->dev);
@@ -698,7 +710,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	pm_runtime_get_sync(dai->dev);
 	spin_lock_irqsave(i2s->lock, flags);
-	mod = readl(i2s->addr + I2SMOD);
+	mod = readl(priv->addr + I2SMOD);
 	/*
 	 * Don't change the I2S mode if any controller is active on this
 	 * channel.
@@ -714,7 +726,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	mod &= ~(sdf_mask | lrp_rlow | mod_slave);
 	mod |= tmp;
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 	spin_unlock_irqrestore(i2s->lock, flags);
 	pm_runtime_put(dai->dev);
 
@@ -801,9 +813,9 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	spin_lock_irqsave(i2s->lock, flags);
-	mod = readl(i2s->addr + I2SMOD);
+	mod = readl(priv->addr + I2SMOD);
 	mod = (mod & ~mask) | val;
-	writel(mod, i2s->addr + I2SMOD);
+	writel(mod, priv->addr + I2SMOD);
 	spin_unlock_irqrestore(i2s->lock, flags);
 
 	snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, &i2s->dma_capture);
@@ -837,7 +849,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 		i2s->mode |= DAI_MANAGER;
 
 	if (!any_active(i2s) && (i2s->quirks & QUIRK_NEED_RSTCLR))
-		writel(CON_RSTCLR, i2s->addr + I2SCON);
+		writel(CON_RSTCLR, i2s->priv->addr + I2SCON);
 
 	spin_unlock_irqrestore(&lock, flags);
 
@@ -920,7 +932,7 @@ static int config_setup(struct i2s_dai *i2s)
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
 		psr = priv->rclk_srcrate / i2s->frmclk / rfs;
-		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
+		writel(((psr - 1) << 8) | PSR_PSREN, priv->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
 			"RCLK_SRC=%luHz PSR=%u, RCLK=%dfs, BCLK=%dfs\n",
 				priv->rclk_srcrate, psr, rfs, bfs);
@@ -1008,8 +1020,9 @@ static int i2s_set_clkdiv(struct snd_soc_dai *dai,
 static snd_pcm_sframes_t
 i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
-	u32 reg = readl(i2s->addr + I2SFIC);
+	u32 reg = readl(priv->addr + I2SFIC);
 	snd_pcm_sframes_t delay;
 	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 
@@ -1018,7 +1031,7 @@ i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 		delay = FIC_RXCOUNT(reg);
 	else if (is_secondary(i2s))
-		delay = FICS_TXCOUNT(readl(i2s->addr + I2SFICS));
+		delay = FICS_TXCOUNT(readl(priv->addr + I2SFICS));
 	else
 		delay = (reg >> i2s_regs->ftx0cnt_off) & 0x7f;
 
@@ -1042,6 +1055,7 @@ static int i2s_resume(struct snd_soc_dai *dai)
 
 static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
@@ -1056,10 +1070,10 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 					   &i2s->dma_capture);
 
 		if (i2s->quirks & QUIRK_NEED_RSTCLR)
-			writel(CON_RSTCLR, i2s->addr + I2SCON);
+			writel(CON_RSTCLR, priv->addr + I2SCON);
 
 		if (i2s->quirks & QUIRK_SUPPORTS_IDMA)
-			idma_reg_addr_init(i2s->addr,
+			idma_reg_addr_init(priv->addr,
 					i2s->sec_dai->idma_playback.addr);
 	}
 
@@ -1086,6 +1100,7 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	unsigned long flags;
 
@@ -1094,7 +1109,7 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 	if (!is_secondary(i2s)) {
 		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
 			spin_lock_irqsave(i2s->lock, flags);
-			writel(0, i2s->addr + I2SCON);
+			writel(0, priv->addr + I2SCON);
 			spin_unlock_irqrestore(i2s->lock, flags);
 		}
 	}
@@ -1205,11 +1220,10 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 static int i2s_runtime_suspend(struct device *dev)
 {
 	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 
-	priv->suspend_i2smod = readl(i2s->addr + I2SMOD);
-	priv->suspend_i2scon = readl(i2s->addr + I2SCON);
-	priv->suspend_i2spsr = readl(i2s->addr + I2SPSR);
+	priv->suspend_i2smod = readl(priv->addr + I2SMOD);
+	priv->suspend_i2scon = readl(priv->addr + I2SCON);
+	priv->suspend_i2spsr = readl(priv->addr + I2SPSR);
 
 	if (priv->op_clk)
 		clk_disable_unprepare(priv->op_clk);
@@ -1221,7 +1235,6 @@ static int i2s_runtime_suspend(struct device *dev)
 static int i2s_runtime_resume(struct device *dev)
 {
 	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	int ret;
 
 	ret = clk_prepare_enable(priv->clk);
@@ -1236,9 +1249,9 @@ static int i2s_runtime_resume(struct device *dev)
 		}
 	}
 
-	writel(priv->suspend_i2scon, i2s->addr + I2SCON);
-	writel(priv->suspend_i2smod, i2s->addr + I2SMOD);
-	writel(priv->suspend_i2spsr, i2s->addr + I2SPSR);
+	writel(priv->suspend_i2scon, priv->addr + I2SCON);
+	writel(priv->suspend_i2smod, priv->addr + I2SMOD);
+	writel(priv->suspend_i2spsr, priv->addr + I2SPSR);
 
 	return 0;
 }
@@ -1296,21 +1309,21 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
 		/* Activate the prescaler */
-		u32 val = readl(i2s->addr + I2SPSR);
-		writel(val | PSR_PSREN, i2s->addr + I2SPSR);
+		u32 val = readl(priv->addr + I2SPSR);
+		writel(val | PSR_PSREN, priv->addr + I2SPSR);
 
 		priv->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
 				i2s_clk_name[CLK_I2S_RCLK_SRC], p_names,
 				ARRAY_SIZE(p_names),
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
-				i2s->addr + I2SMOD, reg_info->rclksrc_off,
+				priv->addr + I2SMOD, reg_info->rclksrc_off,
 				1, 0, i2s->lock);
 
 		priv->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
 				i2s_clk_name[CLK_I2S_RCLK_PSR],
 				i2s_clk_name[CLK_I2S_RCLK_SRC],
 				CLK_SET_RATE_PARENT,
-				i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
+				priv->addr + I2SPSR, 8, 6, 0, i2s->lock);
 
 		p_names[0] = i2s_clk_name[CLK_I2S_RCLK_PSR];
 		priv->clk_data.clk_num = 2;
@@ -1319,7 +1332,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	priv->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
 				i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
 				CLK_SET_RATE_PARENT,
-				i2s->addr + I2SMOD, reg_info->cdclkcon_off,
+				priv->addr + I2SMOD, reg_info->cdclkcon_off,
 				CLK_GATE_SET_TO_DISABLE, i2s->lock);
 
 	priv->clk_data.clk_num += 1;
@@ -1423,9 +1436,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pri_dai->addr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pri_dai->addr))
-		return PTR_ERR(pri_dai->addr);
+	priv->addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->addr))
+		return PTR_ERR(priv->addr);
 
 	regs_base = res->start;
 
@@ -1472,7 +1485,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		}
 
 		sec_dai->dma_playback.addr_width = 4;
-		sec_dai->addr = pri_dai->addr;
 		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
-- 
2.17.1

