Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4038F21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X/bhTgEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfBGRBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:17 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10813 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfBGRBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:15 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207170111epoutp04d2c13f58a6d73843d2d18fa041cb9579~BI5VsVctu2868228682epoutp04P;
        Thu,  7 Feb 2019 17:01:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207170111epoutp04d2c13f58a6d73843d2d18fa041cb9579~BI5VsVctu2868228682epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558871;
        bh=9ExnuY/43UnV5ruD8Yez08W/97/GVzIM7ZfIACRWbgk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=X/bhTgEth2BE3oIjRwZymwOl+jO5KaF/aKw6jPNQbiBA+bFgYCRwvlg16uDaSkzdC
         DOiLkgv5mnKfsw1vkGgx7xi0BexrcypNP7u6IyWNRzJsfLOZLGPx8CVLmhGhKAiugh
         LEEtwUQxAoL+3aDBAiyTPVm2NPwvDyOSEgZLnlbA=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207170110epcas1p432ce516636791f0bfde1defa42400099~BI5Uc-JZO1053310533epcas1p4N;
        Thu,  7 Feb 2019 17:01:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.B3.04074.6546C5C5; Fri,  8 Feb 2019 02:01:10 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170109epcas1p20929934c01ae67a05cd6a56f13ed8486~BI5TjEGWE3249332493epcas1p28;
        Thu,  7 Feb 2019 17:01:09 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-5a-5c5c6456e799
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.C8.04015.4546C5C5; Fri,  8 Feb 2019 02:01:09 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:08 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 07/22] ASoC: samsung: i2s: Move clk supplier data to common
 driver data structure
Date:   Thu, 07 Feb 2019 18:00:15 +0100
Message-id: <20190207170028.720-8-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmrm5YSkyMwZ82dosrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfGk0tzWAtOWlW8vbqdsYHxjEEXIweH
        hICJxLLnbl2MXBxCAjsYJXrWrmGGcL4zSpyb183YxcgJVnRy0weoxG5GiV3vr7BBOL8YJdZ0
        72IHqWITMJToPdoH1iEiICZxe04nWAezQAuTxJy5S5lBEsICyRIz58wFa2ARUJW4c/sxmM0r
        YClx78d6doh18hLne9eB2ZwCVhK39u9ggagRlPgx+R6YzQxUc/DKcxaQBRICe9gkllzcDNXs
        IjHl3BNGiOekJS4dtYUIV0vs2t7NDFHfwSjRcmE7M0TCWuLw8YusEEP5JN597WGF6OWV6GgT
        gijxkOhZ/YAd4uNeRomV59exTWCUmoXkpllIblrAyLSKUSy1oDg3PbXYsMBQrzgxt7g0L10v
        OT93EyM4yrVMdzBOOedziFGAg1GJh1dDLyZGiDWxrLgy9xCjBAezkgivbAJQiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO96B+cYIYH0xJLU7NTUgtQimCwTB6dUA6P1ZpHlpW/uOrM8zHizjbHB
        tshaLce8Wihn0e+ml0lTmXcJeTTdeid4fE/I8oPfio+//OOfx2vwqG/XvEfTHV6dYDyhuNT8
        bdXrAztP3HOqkjmr4H9R/e9Jp+2HGvlue8fcleWZ+7Jnt+789d8Wzus9uzdjW+BtX8Pp0+yW
        zjz3jvFYnwJTT8EJJZbijERDLeai4kQAtxGKI+4CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsVy+t9jAd3QlJgYg4sT2C2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZTy7NYS04aVXx9up2xgbGMwZdjJwc
        EgImEic3fWDuYuTiEBLYySixdXkDO4Tzi1Hi1ZwrTCBVbAKGEr1H+xhBbBEBMYnbczrBOpgF
        mpgkdt2+yA6SEBZIlpg5Zy6YzSKgKnHn9mMwm1fAUuLej/XsEOvkJc73rgOzOQWsJG7t38EC
        YgsB1XyY0MQKUS8o8WPyPbA4M1D9wSvPWSYw8s1CkpqFJLWAkWkVo2RqQXFuem6xUYFhXmq5
        XnFibnFpXrpecn7uJkZgGG87rNW3g/H+kvhDjAIcjEo8vBe0Y2KEWBPLiitzDzFKcDArifDK
        JgCFeFMSK6tSi/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYORZx+7R
        ONe9+7zagSNGPDW5K83uzPndbmnNnhRmeqwu3Punp2vE82v1/6bXh8Xfa589S8Mi4BUXT+C2
        sKk3Y1pDp8hM/uv+q+6p9Zb9+z3r1ult8+zZ8vxx6VRhHoPrS56Zt+2a3Gy+cEmJTwjjfc8H
        Dkz77p/2v3kycquv9fqYtFTt9apqy5RYijMSDbWYi4oTAcoGgh9fAgAA
X-CMS-MailID: 20190207170109epcas1p20929934c01ae67a05cd6a56f13ed8486
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170109epcas1p20929934c01ae67a05cd6a56f13ed8486
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170109epcas1p20929934c01ae67a05cd6a56f13ed8486@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the clocks provider data in struct samsung_i2s_priv, i.e. per the I2S
controller instance, rather than per CPU DAI better models the hardware and
simplifies the code a little. The clock provider is common for both DAIs.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 68 ++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 994dcd4b01fb..978614673ffb 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -99,9 +99,7 @@ struct i2s_dai {
 
 	spinlock_t *lock;
 
-	/* Below fields are only valid if this is the primary FIFO */
-	struct clk *clk_table[3];
-	struct clk_onecell_data clk_data;
+	struct samsung_i2s_priv *priv;
 };
 
 /* Lock for cross i/f checks */
@@ -118,6 +116,10 @@ struct samsung_i2s_priv {
 	struct i2s_dai *dai;
 	struct snd_soc_dai_driver *dai_drv;
 	int num_dais;
+
+	/* The clock provider's data */
+	struct clk *clk_table[3];
+	struct clk_onecell_data clk_data;
 };
 
 struct i2s_dai *samsung_i2s_get_pri_dai(struct device *dev)
@@ -625,11 +627,10 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	return ret;
 }
 
-static int i2s_set_fmt(struct snd_soc_dai *dai,
-	unsigned int fmt)
+static int i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = get_other_dai(i2s);
 	int lrp_shift, sdf_shift, sdf_mask, lrp_rlow, mod_slave;
 	u32 mod, tmp = 0;
 	unsigned long flags;
@@ -687,8 +688,7 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
 		 * clock configuration assigned in DT is not overwritten.
 		 */
-		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL &&
-		    other->clk_data.clks == NULL)
+		if (i2s->rclk_srcrate == 0 && priv->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -725,8 +725,8 @@ static int i2s_set_fmt(struct snd_soc_dai *dai,
 static int i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
+	struct samsung_i2s_priv *priv = snd_soc_dai_get_drvdata(dai);
 	struct i2s_dai *i2s = to_info(dai);
-	struct i2s_dai *other = get_other_dai(i2s);
 	u32 mod, mask = 0, val = 0;
 	struct clk *rclksrc;
 	unsigned long flags;
@@ -811,10 +811,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 
 	i2s->frmclk = params_rate(params);
 
-	rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
-	if (!rclksrc || IS_ERR(rclksrc))
-		rclksrc = other->clk_table[CLK_I2S_RCLK_SRC];
-
+	rclksrc = priv->clk_table[CLK_I2S_RCLK_SRC];
 	if (rclksrc && !IS_ERR(rclksrc))
 		i2s->rclk_srcrate = clk_get_rate(rclksrc);
 
@@ -1221,31 +1218,30 @@ static int i2s_runtime_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
-static void i2s_unregister_clocks(struct i2s_dai *i2s)
+static void i2s_unregister_clocks(struct samsung_i2s_priv *priv)
 {
 	int i;
 
-	for (i = 0; i < i2s->clk_data.clk_num; i++) {
-		if (!IS_ERR(i2s->clk_table[i]))
-			clk_unregister(i2s->clk_table[i]);
+	for (i = 0; i < priv->clk_data.clk_num; i++) {
+		if (!IS_ERR(priv->clk_table[i]))
+			clk_unregister(priv->clk_table[i]);
 	}
 }
 
-static void i2s_unregister_clock_provider(struct platform_device *pdev)
+static void i2s_unregister_clock_provider(struct samsung_i2s_priv *priv)
 {
-	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(&pdev->dev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-	i2s_unregister_clocks(i2s);
+	of_clk_del_provider(priv->pdev->dev.of_node);
+	i2s_unregister_clocks(priv);
 }
 
-static int i2s_register_clock_provider(struct platform_device *pdev)
+
+static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 {
 
 	const char * const i2s_clk_desc[] = { "cdclk", "rclk_src", "prescaler" };
 	const char *clk_name[2] = { "i2s_opclk0", "i2s_opclk1" };
 	const char *p_names[2] = { NULL };
-	struct device *dev = &pdev->dev;
+	struct device *dev = &priv->pdev->dev;
 	struct i2s_dai *i2s = samsung_i2s_get_pri_dai(dev);
 	const struct samsung_i2s_variant_regs *reg_info = i2s->variant_regs;
 	const char *i2s_clk_name[ARRAY_SIZE(i2s_clk_desc)];
@@ -1277,37 +1273,37 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
 		u32 val = readl(i2s->addr + I2SPSR);
 		writel(val | PSR_PSREN, i2s->addr + I2SPSR);
 
-		i2s->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
+		priv->clk_table[CLK_I2S_RCLK_SRC] = clk_register_mux(dev,
 				i2s_clk_name[CLK_I2S_RCLK_SRC], p_names,
 				ARRAY_SIZE(p_names),
 				CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->rclksrc_off,
 				1, 0, i2s->lock);
 
-		i2s->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
+		priv->clk_table[CLK_I2S_RCLK_PSR] = clk_register_divider(dev,
 				i2s_clk_name[CLK_I2S_RCLK_PSR],
 				i2s_clk_name[CLK_I2S_RCLK_SRC],
 				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SPSR, 8, 6, 0, i2s->lock);
 
 		p_names[0] = i2s_clk_name[CLK_I2S_RCLK_PSR];
-		i2s->clk_data.clk_num = 2;
+		priv->clk_data.clk_num = 2;
 	}
 
-	i2s->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
+	priv->clk_table[CLK_I2S_CDCLK] = clk_register_gate(dev,
 				i2s_clk_name[CLK_I2S_CDCLK], p_names[0],
 				CLK_SET_RATE_PARENT,
 				i2s->addr + I2SMOD, reg_info->cdclkcon_off,
 				CLK_GATE_SET_TO_DISABLE, i2s->lock);
 
-	i2s->clk_data.clk_num += 1;
-	i2s->clk_data.clks = i2s->clk_table;
+	priv->clk_data.clk_num += 1;
+	priv->clk_data.clks = priv->clk_table;
 
 	ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
-				  &i2s->clk_data);
+				  &priv->clk_data);
 	if (ret < 0) {
 		dev_err(dev, "failed to add clock provider: %d\n", ret);
-		i2s_unregister_clocks(i2s);
+		i2s_unregister_clocks(priv);
 	}
 
 	return ret;
@@ -1426,6 +1422,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->quirks = quirks;
 	pri_dai->variant_regs = i2s_dai_data->i2s_variant_regs;
+	pri_dai->priv = priv;
 
 	if (quirks & QUIRK_PRI_6CHAN)
 		pri_dai->drv->playback.channels_max = 6;
@@ -1454,6 +1451,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->quirks = quirks;
 		sec_dai->idma_playback.addr = idma_addr;
 		sec_dai->pri_dai = pri_dai;
+		sec_dai->priv = priv;
 		pri_dai->sec_dai = sec_dai;
 
 		ret = i2s_create_secondary_device(priv);
@@ -1485,11 +1483,11 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = i2s_register_clock_provider(pdev);
+	ret = i2s_register_clock_provider(priv);
 	if (ret < 0)
 		goto err_disable_pm;
 
-	pri_dai->op_clk = clk_get_parent(pri_dai->clk_table[CLK_I2S_RCLK_SRC]);
+	pri_dai->op_clk = clk_get_parent(priv->clk_table[CLK_I2S_RCLK_SRC]);
 
 	return 0;
 
@@ -1512,7 +1510,7 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	i2s_unregister_clock_provider(pdev);
+	i2s_unregister_clock_provider(priv);
 	clk_disable_unprepare(pri_dai->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	i2s_delete_secondary_device(priv);
-- 
2.20.1

