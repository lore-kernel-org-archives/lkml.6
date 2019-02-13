Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC3C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF11A20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KagVYGp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfBMSvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:51:15 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:52089 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfBMSni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:38 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190213184336epoutp040a92a066cedd526065566831129aabf0~DAKeEXxwj2883528835epoutp04d;
        Wed, 13 Feb 2019 18:43:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190213184336epoutp040a92a066cedd526065566831129aabf0~DAKeEXxwj2883528835epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083416;
        bh=rxPbxHGZybOFRecRRk8y8hUn782hn33+8lzAUhhh5k8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=KagVYGp7hBYz76VYRcyWi2yHByAwClYoqnE0bAcMArL7iBBSBdNTj4otW5jQe7SyR
         JtxEmPK4lCdu63VpxxzYBy4B/JSR0M/MQFUjeBt9yKEe6YLb2UJsM1zylS6xQx9u5E
         0p7YP+Xb7kJHut/7UYzMyi5OnXVrDerBHKrB5HO0=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184335epcas1p35130f257f69a8581c1172c6cc348cf0f~DAKdu2pz_2300523005epcas1p3a;
        Wed, 13 Feb 2019 18:43:35 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.D9.04288.755646C5; Thu, 14 Feb 2019 03:43:35 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190213184335epcas1p4e8d7ef4cfb788dc882fa3678ad66bec4~DAKdRILPH2480424804epcas1p4Z;
        Wed, 13 Feb 2019 18:43:35 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-3a-5c646557136f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 0A.CE.04015.755646C5; Thu, 14 Feb
        2019 03:43:35 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:35 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 12/13] ASoC: samsung: i2s: Comments clean up
Date:   Wed, 13 Feb 2019 19:42:11 +0100
Message-id: <20190213184212.5473-13-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmrm54akqMwYy/RhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M3XvOMRZ8kq24fs23gfGaeBcjJ4eE
        gInE/g0LmLsYuTiEBHYwStybMZcNwvnOKHGi5RULTNW2vVcYIRIbGCXeHGxlgXB+MUo0TbzM
        DFLFJmAo0Xu0jxHEFhEQk7g9pxNsLrNAC5PEnLlLgRwODmEBe4mjP2VAalgEVCW2TfsPVs8r
        YC2xZuM7Zoht8hKrNxwAszmB4v/WPmcHmSMhsIBN4saSDYwQRS4Sq07cYQOZKSEgLXHpqC1E
        uFpi1/ZuZoj6DkaJlgvboYZaSxw+fpEVxGYW4JN497WHFaKXV6KjTQiixEPi3oR1UI/1AX35
        7RLbBEaJBYwMqxjFUguKc9NTiw0LTPSKE3OLS/PS9ZLzczcxgmNQy2IH455zPocYBTgYlXh4
        K4RSYoRYE8uKK3MPMUpwMCuJ8OpFAYV4UxIrq1KL8uOLSnNSiw8xSnOwKInzrndwjhESSE8s
        Sc1OTS1ILYLJMnFwSjUwatWW9Vo1Lg/hsD401eH0Q5653V4NXnOepZlNk1s2XfvOq9MvGcx2
        rWUMvdkQ/GlSYuGJWeacV049/1rNtziI2+bmBaP403cfBH+RFrzlVy3x40yZk97Cxwp/zfi3
        2i9bJm93fv5+v1odqRObjW7ZHn9Z3q9SF3D6eUvPCwmxv7P83jt585+7rcRSnJFoqMVcVJwI
        AByPXcG9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t9jQd3w1JQYg7mPBS2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZu/ecYyz4JFtx/ZpvA+M18S5GTg4J
        AROJbXuvMHYxcnEICaxjlFj+4Rg7hPOLUeLZ5J8sIFVsAoYSvUf7GEFsEQExidtzOplBipgF
        mpgkdt2+CNTBwSEsYC9x9KcMSA2LgKrEtmn/wep5Bawl1mx8xwyxTV5i9YYDYDYnUPzf2ufs
        ILaQgJXExA+XmCcw8ixgZFjFKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREYYtsOa/Xt
        YLy/JP4QowAHoxIPr4JASowQa2JZcWXuIUYJDmYlEV69KKAQb0piZVVqUX58UWlOavEhRmkO
        FiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFINjJM9djw6dDNups8k7/mCVwyCWx4yyfzWvC/T
        /+Rs2aRCjygWxapZ+Yr/rq68IlGaXWFYJZzG9LhninGk4L6WG83nDD54O5/qZt5jsmQ5M1+a
        QdhRZqb5S5+beeden/Lq4pnVDWtOqeraahpeY39pm+h6nGvKwoa12/+0CL89mRpSfWyTwjqx
        /UosxRmJhlrMRcWJAIflGyEtAgAA
X-CMS-MailID: 20190213184335epcas1p4e8d7ef4cfb788dc882fa3678ad66bec4
CMS-TYPE: 101P
X-CMS-RootMailID: 20190213184335epcas1p4e8d7ef4cfb788dc882fa3678ad66bec4
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184335epcas1p4e8d7ef4cfb788dc882fa3678ad66bec4@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling error fixes, upper/lower case letter changes.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index e0c151843f9e..4f13b514d9ce 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1,5 +1,4 @@
-/* sound/soc/samsung/i2s.c
- *
+/*
  * ALSA SoC Audio Layer - Samsung I2S Controller driver
  *
  * Copyright (c) 2010 Samsung Electronics Co. Ltd.
@@ -61,10 +60,10 @@ struct i2s_dai {
 	/* Platform device for this DAI */
 	struct platform_device *pdev;
 
-	/* Frame Clock */
+	/* Frame clock */
 	unsigned frmclk;
 	/*
-	 * Specifically requested RCLK,BCLK by MACHINE Driver.
+	 * Specifically requested RCLK, BCLK by machine driver.
 	 * 0 indicates CPU driver is free to choose any value.
 	 */
 	unsigned rfs, bfs;
@@ -72,8 +71,9 @@ struct i2s_dai {
 	struct i2s_dai *pri_dai;
 	/* Pointer to the Secondary_Fifo if it has one, NULL otherwise */
 	struct i2s_dai *sec_dai;
-#define DAI_OPENED	(1 << 0) /* Dai is opened */
-#define DAI_MANAGER	(1 << 1) /* Dai is the manager */
+
+#define DAI_OPENED	(1 << 0) /* DAI is opened */
+#define DAI_MANAGER	(1 << 1) /* DAI is the manager */
 	unsigned mode;
 
 	/* Driver for this DAI */
@@ -98,7 +98,7 @@ struct samsung_i2s_priv {
 	/* Spinlock protecting access to the device's registers */
 	spinlock_t lock;
 
-	/* Lock for cross i/f checks */
+	/* Lock for cross interface checks */
 	spinlock_t pcm_lock;
 
 	/* CPU DAIs and their corresponding drivers */
@@ -309,7 +309,7 @@ static inline void set_rfs(struct i2s_dai *i2s, unsigned rfs)
 	writel(mod, priv->addr + I2SMOD);
 }
 
-/* Read Bit-Clock of I2S (in multiples of LRCLK) */
+/* Read bit-clock of I2S (in multiples of LRCLK) */
 static inline unsigned get_bfs(struct i2s_dai *i2s)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
@@ -331,7 +331,7 @@ static inline unsigned get_bfs(struct i2s_dai *i2s)
 	}
 }
 
-/* Write Bit-Clock of I2S (in multiples of LRCLK) */
+/* Write bit-clock of I2S (in multiples of LRCLK) */
 static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
@@ -383,7 +383,7 @@ static inline void set_bfs(struct i2s_dai *i2s, unsigned bfs)
 	writel(mod, priv->addr + I2SMOD);
 }
 
-/* Sample-Size */
+/* Sample size */
 static inline int get_blc(struct i2s_dai *i2s)
 {
 	int blc = readl(i2s->priv->addr + I2SMOD);
@@ -397,7 +397,7 @@ static inline int get_blc(struct i2s_dai *i2s)
 	}
 }
 
-/* TX Channel Control */
+/* TX channel control */
 static void i2s_txctrl(struct i2s_dai *i2s, int on)
 {
 	struct samsung_i2s_priv *priv = i2s->priv;
@@ -742,7 +742,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_channels(params)) {
 	case 6:
 		val |= MOD_DC2_EN;
-		/* fall through */
+		/* Fall through */
 	case 4:
 		val |= MOD_DC1_EN;
 		break;
@@ -821,7 +821,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/* We set constraints on the substream acc to the version of I2S */
+/* We set constraints on the substream according to the version of I2S */
 static int i2s_startup(struct snd_pcm_substream *substream,
 	  struct snd_soc_dai *dai)
 {
@@ -1056,7 +1056,8 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 
 	pm_runtime_get_sync(dai->dev);
 
-	if (is_secondary(i2s)) { /* If this is probe on the secondary DAI */
+	if (is_secondary(i2s)) {
+		/* If this is probe on the secondary DAI */
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback, NULL);
 	} else {
 		snd_soc_dai_init_dma_data(dai, &i2s->dma_playback,
-- 
2.17.1

