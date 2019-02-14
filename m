Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB8CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FD22229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cZBu4IUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395190AbfBNJiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:46 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43908 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437855AbfBNJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:37 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214093835epoutp03c0a9a8899b3fd73ba1ca1a426da675ae~DMX4-wrq_0840808408epoutp03P;
        Thu, 14 Feb 2019 09:38:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214093835epoutp03c0a9a8899b3fd73ba1ca1a426da675ae~DMX4-wrq_0840808408epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137115;
        bh=cdxa69xtYLHciSEnv9sUjq5OE7F/lZIZBuYcOBsw/Hw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=cZBu4IUkvunjH+fjQlsci/hMamGnOkoUiVPq86nz2Sd1YEeESUryhhjk9qlyQdA3e
         qhUEq5Hd7W6XOq08NQ9UDZUpJ7M8HLmrvbiwRjvljBFry9Alw9AE1omaOsdBWJw3O5
         MomZ2DP45XS/eeSDGjHZMAPkLhUaVe8IfOJt6iq0=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190214093834epcas2p4bf70ab607348b148a6b6921f6a4c8845~DMX4mm5fP2520525205epcas2p4q;
        Thu, 14 Feb 2019 09:38:34 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.0D.04134.A17356C5; Thu, 14 Feb 2019 18:38:34 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190214093833epcas2p1cd99c749360aadf06a551810862d9bf4~DMX35vhSJ1579015790epcas2p13;
        Thu, 14 Feb 2019 09:38:33 +0000 (GMT)
X-AuditID: b6c32a47-8c3ff70000001026-58-5c65371a74dc
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 1C.52.03689.917356C5; Thu, 14 Feb
        2019 18:38:33 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:33 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 04/13] ASoC: samsung: i2s: Move quirks data to
 common driver data structure
Date:   Thu, 14 Feb 2019 10:37:38 +0100
Message-id: <20190214093747.2414-5-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCmqa6UeWqMwd8uVYsrFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK2N2k3BBm27F3VmXWBsY/6h0MXJySAiYSKz59Yipi5GLQ0hgB6PE
        /ksT2CCc74wSx7b/BnLYwap+10KENzBKvF57mRXC+cUocfvoXiaQSWwChhK9R/sYQWwRATGJ
        23M6mUGKmAVWMkps2beJDSQhLJAusWDFR2YQm0VAVWJhx08wm1fASuLKlTWsECfJS6zecAAs
        zilgLTFz03ZGkEESAj1sEms/f4AqcpHo+XaZCcKWlni2aiMjhF0tsWt7NzNEQwejRMuF7cwQ
        CWuJw8cvgjUzC/BJdBz+y97FyAEU55XoaBOCKPGQ+HBwFdT7fYwSZ7+tYJnAKLGAkWEVo1hq
        QXFuemqxUYGxXnFibnFpXrpecn7uJkZwlGm572Dcds7nEKMAB6MSD2+FUEqMEGtiWXFl7iFG
        CQ5mJRHei0apMUK8KYmVValF+fFFpTmpxYcYpTlYlMR5H0rPjRYSSE8sSc1OTS1ILYLJMnFw
        SjUwGqyblCfb/kH2zctY3W+e8166bct+vbCqgXnmW+UJpvU8a6v3Mv6aLeysa7ODIy/iw53d
        xy1WXeSuzHm2L72t4ajdSrHC2xoJz9O3GfZEOwk+j2fJeaMbvrvJ8ezuTj0ZpeZnoqtrtE/O
        EdIwk7ryv+y0pBsf61T/U83cCds+/inY2WfoLLdBiaU4I9FQi7moOBEAyKaHO64CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkluLIzCtJLcpLzFFi42I5/e+xoK6keWqMQX+vscWVi4eYLKY+fMJm
        cf78BnaLb1c6mCwu75rDZnH4TTurxcUVX5gc2D02fG5i89g56y67x6ZVnWwefVtWMXp83iQX
        wBrFZZOSmpNZllqkb5fAlTG7SbigTbfi7qxLrA2Mf1S6GNk5JARMJH7XdjFycQgJrGOUeHPv
        ICuE84tR4nPzcfYuRk4ONgFDid6jfYwgtoiAmMTtOZ3MIEXMAisZJY58XwWWEBZIl5i6chZY
        A4uAqsTCjp/MIDavgJXElStrWEFsCQF5idUbDoDFOQWsJWZu2g7UywG0zUpi3aHyCYw8CxgZ
        VjFKphYU56bnFhsVGOWllusVJ+YWl+al6yXn525iBAbQtsNa/TsYHy+JP8QowMGoxMNbIZQS
        I8SaWFZcmXuIUYKDWUmE96JRaowQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZ
        qakFqUUwWSYOTqkGxmPRx55Z5+9keF8d98lNUceA99vN7b3fbt3WkL7r7/9mUtTLdbdzPfYw
        qgjN+rOoaD+X2QVbhvlaziFPWV5lLnI8u0hEKbD4gOv0cxHiT+o/Zk7aZJX7/yGnv1otd9tl
        qaOrud9P7037+5S/IOTp7LTL4fXzOowZ+XW2pt1xU/O9Pkm3w8xihRJLcUaioRZzUXEiAD11
        ZmocAgAA
X-CMS-MailID: 20190214093833epcas2p1cd99c749360aadf06a551810862d9bf4
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214093833epcas2p1cd99c749360aadf06a551810862d9bf4
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093833epcas2p1cd99c749360aadf06a551810862d9bf4@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quirk flags are common for the primary and the secondary DAI
so move respective field from struct i2s_dai to common driver data
structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 0c4c4de8c7e9..8f0af4b0f25a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -84,7 +84,6 @@ struct i2s_dai {
 	struct snd_dmaengine_dai_dma_data dma_capture;
 	struct snd_dmaengine_dai_dma_data idma_playback;
 	dma_filter_fn filter;
-	u32	quirks;
 
 	struct samsung_i2s_priv *priv;
 };
@@ -122,19 +121,13 @@ struct samsung_i2s_priv {
 	u32 suspend_i2spsr;
 
 	const struct samsung_i2s_variant_regs *variant_regs;
+	u32 quirks;
 
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
 };
 
-struct i2s_dai *samsung_i2s_get_pri_dai(struct device *dev)
-{
-	struct samsung_i2s_priv *priv = dev_get_drvdata(dev);
-
-	return &priv->dai[SAMSUNG_I2S_ID_PRIMARY - 1];
-}
-
 /* Returns true if this is the 'overlay' stereo DAI */
 static inline bool is_secondary(struct i2s_dai *i2s)
 {
@@ -343,7 +336,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 mod = readl(priv->addr + I2SMOD);
-	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
+	int tdm = priv->quirks & QUIRK_SUPPORTS_TDM;
 	int bfs_shift = priv->variant_regs->bfs_off;
 
 	/* Non-TDM I2S controllers do not support BCLK > 48 * FS */
@@ -563,7 +556,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 	case SAMSUNG_I2S_RCLKSRC_1: /* clock corrsponding to IISMOD[10] := 1 */
 		mask = 1 << i2s_regs->rclksrc_off;
 
-		if ((i2s->quirks & QUIRK_NO_MUXPSR)
+		if ((priv->quirks & QUIRK_NO_MUXPSR)
 				|| (clk_id == SAMSUNG_I2S_RCLKSRC_0))
 			clk_id = 0;
 		else
@@ -832,6 +825,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 static int i2s_startup(struct snd_pcm_substream *substream,
 	  struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
 	unsigned long flags;
@@ -847,7 +841,7 @@ static int i2s_startup(struct snd_pcm_substream *substream,
 	else
 		i2s->mode |= DAI_MANAGER;
 
-	if (!any_active(i2s) && (i2s->quirks & QUIRK_NEED_RSTCLR))
+	if (!any_active(i2s) && (priv->quirks & QUIRK_NEED_RSTCLR))
 		writel(CON_RSTCLR, i2s->priv->addr + I2SCON);
 
 	spin_unlock_irqrestore(&lock, flags);
@@ -929,7 +923,7 @@ static int config_setup(struct i2s_dai *i2s)
 	if (is_slave(i2s))
 		return 0;
 
-	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+	if (!(priv->quirks & QUIRK_NO_MUXPSR)) {
 		psr = priv->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, priv->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
@@ -1068,10 +1062,10 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback,
 					   &i2s->dma_capture);
 
-		if (i2s->quirks & QUIRK_NEED_RSTCLR)
+		if (priv->quirks & QUIRK_NEED_RSTCLR)
 			writel(CON_RSTCLR, priv->addr + I2SCON);
 
-		if (i2s->quirks & QUIRK_SUPPORTS_IDMA)
+		if (priv->quirks & QUIRK_SUPPORTS_IDMA)
 			idma_reg_addr_init(priv->addr,
 					i2s->sec_dai->idma_playback.addr);
 	}
@@ -1106,7 +1100,7 @@ static int samsung_i2s_dai_remove(struct snd_soc_dai *dai)
 	pm_runtime_get_sync(dai->dev);
 
 	if (!is_secondary(i2s)) {
-		if (i2s->quirks & QUIRK_NEED_RSTCLR) {
+		if (priv->quirks & QUIRK_NEED_RSTCLR) {
 			spin_lock_irqsave(&priv->lock, flags);
 			writel(0, priv->addr + I2SCON);
 			spin_unlock_irqrestore(&priv->lock, flags);
@@ -1280,7 +1274,6 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
 	struct device *dev = &priv->pdev->dev;
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	const struct samsung_i2s_variant_regs *reg_info = priv->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
@@ -1306,7 +1299,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 			return -ENOMEM;
 	}
 
-	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+	if (!(priv->quirks & QUIRK_NO_MUXPSR)) {
 		/* Activate the prescaler */
 		u32 val = readl(priv->addr + I2SPSR);
 		writel(val | PSR_PSREN, priv->addr + I2SPSR);
@@ -1400,11 +1393,11 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
-
 	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
 	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
+	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
+	priv->quirks = quirks;
 
 	ret = i2s_alloc_dais(priv, i2s_dai_data, num_dais);
 	if (ret < 0)
@@ -1459,7 +1452,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.chan_name = "rx";
 	pri_dai->dma_playback.addr_width = 4;
 	pri_dai->dma_capture.addr_width = 4;
-	pri_dai->quirks = quirks;
 	pri_dai->priv = priv;
 
 	if (quirks & QUIRK_PRI_6CHAN)
@@ -1482,7 +1474,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		}
 
 		sec_dai->dma_playback.addr_width = 4;
-		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
 		sec_dai->priv = priv;
-- 
2.17.1

