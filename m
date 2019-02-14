Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1025DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5BC2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RuKz0EPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437863AbfBNJij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:39 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43876 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395173AbfBNJie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:34 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214093831epoutp03aa7d99acdd89ee30019ba56bc2b3837c~DMX1-cgn40834508345epoutp03T;
        Thu, 14 Feb 2019 09:38:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214093831epoutp03aa7d99acdd89ee30019ba56bc2b3837c~DMX1-cgn40834508345epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137111;
        bh=ksBuew1Xn57azxYCc3VjsmJS9DByah38YvNWRM7BLGs=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=RuKz0EPLGtdVKG9Xzb0FbuCzAmNheCK6C4pz+vko5N+C1ycXSg21Fc4jI1bgsge1h
         i7VSMC5f1NxZ0m8z0unAsRTfvuaE6w9KEuxPL9UmNCvm0jqMH0zM9hwpSvpraNnQi6
         WPw0Vz6N2frUW0XRFrHiBFf45XJTHxxajG1QG2Xw=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214093831epcas1p1e948fc50b9af6bd621dc3e13b67dceff~DMX1xT7IL1434214342epcas1p1W;
        Thu, 14 Feb 2019 09:38:31 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.14.04288.717356C5; Thu, 14 Feb 2019 18:38:31 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093831epcas1p2a42c5b95424a251e7ae38dd21c1a4696~DMX1YBA9l2983229832epcas1p2L;
        Thu, 14 Feb 2019 09:38:31 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-7a-5c653717c251
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 0A.F3.04015.617356C5; Thu, 14 Feb
        2019 18:38:31 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:30 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 03/13] ASoC: samsung: i2s: Move IP variant data to
 common driver data structure
Date:   Thu, 14 Feb 2019 10:37:37 +0100
Message-id: <20190214093747.2414-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCmvq64eWqMQf8KOYsrFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK+PDh7UsBS/NKpYuvsfewDhJt4uRk0NCwETiW/Mq1i5GLg4hgR2M
        EtM2tLNAON8ZJe5deMoEU3X4+QM2iMQGRom5/+cyQji/GCWWbNzFCFLFJmAo0Xu0D8wWERCT
        uD2nkxmkiFlgJaPEln2b2EASwgLZEh8uz2MGsVkEVCVu3/wE1MDBwStgJXFvSQrENnmJ1RsO
        gJVwClhLzNy0HWyZhEAPm8TxDe1QJ7lILN//mxmkV0JAWuLSUVuIcLXEru3dzBD1HYwSLRe2
        M0MkrCUOH7/ICmIzC/BJvPvawwrRyyvR0SYEUeIh8bP9CDvEY32MEg+vrGSewCixgJFhFaNY
        akFxbnpqsWGBiV5xYm5xaV66XnJ+7iZGcJxpWexg3HPO5xCjAAejEg9vhVBKjBBrYllxZe4h
        RgkOZiUR3otGqTFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEedc7OMcICaQnlqRmp6YWpBbBZJk4
        OKUaGPNWS3ctMnbrDBMOdezr+GD9rz0mQeJqz+62uMnT9gZlnjs+YU7oir2KkwzW3o/WvV3Q
        0bDmZLuMkfrF4vP/bxuc/Ngq8HNew9/WaSvVvR+y7LsfvOhN00neD5+84t4ceHrr96GKWYa2
        1Zx+bi/Onv+0mI91yt4HDB/dvk7IMznqx7jxqNqNCR5KLMUZiYZazEXFiQDy6sW6rwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42I5/e+xoK64eWqMwecTbBZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8aHD2tZCl6aVSxdfI+9gXGSbhcjJ4eEgInE4ecP2LoYuTiEBNYx
        Smzqvc4O4fxilLj07wgbSBWbgKFE79E+RhBbREBM4vacTmaQImaBlYwSR76vAksIC2RLfLg8
        jxnEZhFQlbh98xNQnIODV8BK4t6SFIht8hKrNxwAK+EUsJaYuWk7WIkQUMm6Q+UTGHkWMDKs
        YpRMLSjOTc8tNiowzEst1ytOzC0uzUvXS87P3cQIDKJth7X6djDeXxJ/iFGAg1GJh1dBICVG
        iDWxrLgy9xCjBAezkgjvRaPUGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8t/OORQoJpCeWpGan
        phakFsFkmTg4pRoYt04ra5W6tOXzlgs97tMzJ7qod5nKeLWen5dzrTT42/0QI/YGjts3UtIt
        Voiys8bv+qv3fNP+n8f579+9c7N4/Y3utBcn/11VnMitEvqQ93GNxffdho3OzopzdZXmLDb0
        32h90W66rVMZz7wkv0OHV2ibPOBnWnvt5SHbnbs9765y3DD7ovZTIyWW4oxEQy3mouJEAJMr
        JmweAgAA
X-CMS-MailID: 20190214093831epcas1p2a42c5b95424a251e7ae38dd21c1a4696
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214093831epcas1p2a42c5b95424a251e7ae38dd21c1a4696
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093831epcas1p2a42c5b95424a251e7ae38dd21c1a4696@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP variant data is another thing common for both DAIs, move it
to the driver's common data structure.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index cf8615e23879..0c4c4de8c7e9 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -85,7 +85,6 @@ struct i2s_dai {
 	struct snd_dmaengine_dai_dma_data idma_playback;
 	dma_filter_fn filter;
 	u32	quirks;
-	const struct samsung_i2s_variant_regs *variant_regs;
 
 	struct samsung_i2s_priv *priv;
 };
@@ -122,6 +121,8 @@ struct samsung_i2s_priv {
 	u32 suspend_i2scon;
 	u32 suspend_i2spsr;
 
+	const struct samsung_i2s_variant_regs *variant_regs;
+
 	/* The clock provider's data */
 	struct clk *clk_table[3];
 	struct clk_onecell_data clk_data;
@@ -146,7 +147,7 @@ static inline bool is_slave(struct i2s_dai *i2s)
 	struct samsung_i2s_priv *priv = i2s->priv;
 
 	u32 mod = readl(priv->addr + I2SMOD);
-	return (mod & (1 << i2s->variant_regs->mss_off)) ? true : false;
+	return (mod & (1 << priv->variant_regs->mss_off)) ? true : false;
 }
 
 /* If this interface of the controller is transmitting data */
@@ -261,8 +262,8 @@ static inline unsigned get_rfs(struct i2s_dai *i2s)
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 rfs;
 
-	rfs = readl(priv->addr + I2SMOD) >> i2s->variant_regs->rfs_off;
-	rfs &= i2s->variant_regs->rfs_mask;
+	rfs = readl(priv->addr + I2SMOD) >> priv->variant_regs->rfs_off;
+	rfs &= priv->variant_regs->rfs_mask;
 
 	switch (rfs) {
 	case 7: return 192;
@@ -281,9 +282,9 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 mod = readl(priv->addr + I2SMOD);
-	int rfs_shift = i2s->variant_regs->rfs_off;
+	int rfs_shift = priv->variant_regs->rfs_off;
 
-	mod &= ~(i2s->variant_regs->rfs_mask << rfs_shift);
+	mod &= ~(priv->variant_regs->rfs_mask << rfs_shift);
 
 	switch (rfs) {
 	case 192:
@@ -321,8 +322,8 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 bfs;
 
-	bfs = readl(priv->addr + I2SMOD) >> i2s->variant_regs->bfs_off;
-	bfs &= i2s->variant_regs->bfs_mask;
+	bfs = readl(priv->addr + I2SMOD) >> priv->variant_regs->bfs_off;
+	bfs &= priv->variant_regs->bfs_mask;
 
 	switch (bfs) {
 	case 8: return 256;
@@ -343,7 +344,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 	struct samsung_i2s_priv *priv = i2s->priv;
 	u32 mod = readl(priv->addr + I2SMOD);
 	int tdm = i2s->quirks & QUIRK_SUPPORTS_TDM;
-	int bfs_shift = i2s->variant_regs->bfs_off;
+	int bfs_shift = priv->variant_regs->bfs_off;
 
 	/* Non-TDM I2S controllers do not support BCLK > 48 * FS */
 	if (!tdm && bfs > 48) {
@@ -351,7 +352,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 		return;
 	}
 
-	mod &= ~(i2s->variant_regs->bfs_mask << bfs_shift);
+	mod &= ~(priv->variant_regs->bfs_mask << bfs_shift);
 
 	switch (bfs) {
 	case 48:
@@ -408,7 +409,7 @@ static void i2s_txctrl(struct i2s_dai *i2s, int on)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
 	void __iomem *addr = priv->addr;
-	int txr_off = i2s->variant_regs->txr_off;
+	int txr_off = priv->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
 	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
 
@@ -459,7 +460,7 @@ static void i2s_rxctrl(struct i2s_dai *i2s, int on)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
 	void __iomem *addr = priv->addr;
-	int txr_off = i2s->variant_regs->txr_off;
+	int txr_off = priv->variant_regs->txr_off;
 	u32 con = readl(addr + I2SCON);
 	u32 mod = readl(addr + I2SMOD) & ~(3 << txr_off);
 
@@ -516,7 +517,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
 	struct i2s_dai *other = get_other_dai(i2s);
-	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
+	const struct samsung_i2s_variant_regs *i2s_regs = priv->variant_regs;
 	unsigned int cdcon_mask = 1 << i2s_regs->cdclkcon_off;
 	unsigned int rsrc_mask = 1 << i2s_regs->rclksrc_off;
 	u32 mod, mask, val = 0;
@@ -644,9 +645,9 @@ static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	u32 mod, tmp = 0;
 	unsigned long flags;
 
-	lrp_shift = i2s->variant_regs->lrp_off;
-	sdf_shift = i2s->variant_regs->sdf_off;
-	mod_slave = 1 << i2s->variant_regs->mss_off;
+	lrp_shift = priv->variant_regs->lrp_off;
+	sdf_shift = priv->variant_regs->sdf_off;
+	mod_slave = 1 << priv->variant_regs->mss_off;
 
 	sdf_mask = MOD_SDF_MASK << sdf_shift;
 	lrp_rlow = MOD_LR_RLOW << lrp_shift;
@@ -1023,7 +1024,6 @@ i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	struct i2s_dai *i2s = to_info(dai);
 	u32 reg = readl(priv->addr + I2SFIC);
 	snd_pcm_sframes_t delay;
-	const struct samsung_i2s_variant_regs *i2s_regs = i2s->variant_regs;
 
 	WARN_ON(!pm_runtime_active(dai->dev));
 
@@ -1032,7 +1032,7 @@ i2s_delay(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	else if (is_secondary(i2s))
 		delay = FICS_TXCOUNT(readl(priv->addr + I2SFICS));
 	else
-		delay = (reg >> i2s_regs->ftx0cnt_off) & 0x7f;
+		delay = (reg >> priv->variant_regs->ftx0cnt_off) & 0x7f;
 
 	return delay;
 }
@@ -1281,7 +1281,7 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 	const char *p_names[2] = { NULL };
 	struct device *dev = &priv->pdev->dev;
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
-	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
+	const struct samsung_i2s_variant_regs *reg_info = priv->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
 	struct clk *rclksrc;
 	int ret, i;
@@ -1400,6 +1400,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
+
 	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
 	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
@@ -1458,7 +1460,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_playback.addr_width = 4;
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->quirks = quirks;
-	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
 	pri_dai->priv = priv;
 
 	if (quirks & QUIRK_PRI_6CHAN)
@@ -1472,7 +1473,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
-		sec_dai->variant_regs = pri_dai->variant_regs;
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.chan_name = "tx-sec";
 
-- 
2.17.1

