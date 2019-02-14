Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFC320821
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ovgP+pi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437928AbfBNJjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:39:01 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:31392 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437910AbfBNJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:39:00 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190214093856epoutp047f62aebdaa01d54e8e121e8eaae8b397~DMYNZMs701365913659epoutp04o;
        Thu, 14 Feb 2019 09:38:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190214093856epoutp047f62aebdaa01d54e8e121e8eaae8b397~DMYNZMs701365913659epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137136;
        bh=ufBzQMs8s4s7HJA/lN/kwyttViP+POxX5tShUtXQ1E4=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=ovgP+pi+pjHIJtaj8t8oY8xNrLOZ2bbATTDP4U+WN68phFihKRH2Oorde+u9hxvPA
         eNZPDCEONjs3BTZi1LbO19wYNqL4KL1nTSiRPWGusa8tmpGDcs0jLT93YRb5C/faXj
         iczcbJNzkH5HyUPItIjn/dhGGFLvwKPDT5/V1kmc=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190214093856epcas1p331f4f39101aa1e17f9d127a7cafc5f8c~DMYM4hz0C2145421454epcas1p3s;
        Thu, 14 Feb 2019 09:38:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.D9.04206.037356C5; Thu, 14 Feb 2019 18:38:56 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190214093856epcas1p333b119e4b70f2c0edaf0c181e45adfb7~DMYMkgLoL2145421454epcas1p3r;
        Thu, 14 Feb 2019 09:38:56 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-d8-5c65373008e4
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id ED.F3.04015.F27356C5; Thu, 14 Feb
        2019 18:38:55 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:55 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 12/13] ASoC: samsung: i2s: Comments clean up
Date:   Thu, 14 Feb 2019 10:37:46 +0100
Message-id: <20190214093747.2414-13-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCmnq6BeWqMwdyZQhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8brJbvYCxbLVexo38XWwNgk0cXIySEhYCKxb/Y35i5GLg4hgR2M
        EufPN0I53xklpve9ZYWpaj21hgkisYFR4mr7CTYI5xejxIozXYwgVWwChhK9R/vAbBEBMYnb
        czrBRjELrGSU2LJvExtIQljATeLJm50sIDaLgKrErI1bweK8AtYSu5tesUCsk5dYveEAM4jN
        CRSfuWk7I8ggCYEJbBJf3/QwQRS5SOzY8BGogQPIlpa4dNQWIlwtsWt7NzNEfQejRMuF7cwQ
        CWuJw8cvgv3DLMAn8e5rDytEL69ER5sQRImHxJuuBVBv9jFKrHv+hXUCo8QCRoZVjGKpBcW5
        6anFhgWmesWJucWleel6yfm5mxjBkaZluYPx2DmfQ4wCHIxKPLwVQikxQqyJZcWVuYcYJTiY
        lUR4LxqlxgjxpiRWVqUW5ccXleakFh9ilOZgURLnXe/gHCMkkJ5YkpqdmlqQWgSTZeLglGpg
        lHV6Fs2XMmf1ybM7lm/yWezwJLBWuHBZziz/8LifTdqcnIYWf7ZbM0x7dDrbsy18ls3nNNV7
        sevLTa8yFbj/bd1i9mjd839Ltkld5f/fzsJUcJSvLLjYd9uDncGPmyrN9Of9DQpfy/5w/f+i
        gl2CM4W95TI9pHj/zGm6uvDO53avVJ9FCjvKlViKMxINtZiLihMBzbdzM7ACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xoK6+eWqMwYYma4srFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK+P1kl3sBYvlKna072JrYGyS6GLk5JAQMJFoPbWGqYuRi0NIYB2j
        xPLXJ1ghnF+MEu9PL2QHqWITMJToPdrHCGKLCIhJ3J7TyQxSxCywklHiyPdVYAlhATeJJ292
        soDYLAKqErM2bmUDsXkFrCV2N71igVgnL7F6wwFmEJsTKD5z03agXg6gbVYS6w6VT2DkWcDI
        sIpRMrWgODc9t9iowDAvtVyvODG3uDQvXS85P3cTIzCMth3W6tvBeH9J/CFGAQ5GJR5eBYGU
        GCHWxLLiytxDjBIczEoivBeNUmOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKa
        nZpakFoEk2Xi4JRqYKz9tZeBUaJH4uC6gBzjr7v9joRE/JbhjI8TeeZV/Tv+/ovTga9f7oxf
        WLPgnsiK9i/KMVs4/bdMVOgytvcWCDK/vmTC5u6lsn53XON+f2HJrVqY2LRh/03fLSZ7nwae
        FfCQ+bLTOupR4ZrT4n9/1GbPEXmwQuz8getJ1/jCnz//8tH98A0GUQ0lluKMREMt5qLiRACv
        801gHwIAAA==
X-CMS-MailID: 20190214093856epcas1p333b119e4b70f2c0edaf0c181e45adfb7
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214093856epcas1p333b119e4b70f2c0edaf0c181e45adfb7
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093856epcas1p333b119e4b70f2c0edaf0c181e45adfb7@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling error fixes, upper/lower case letter changes.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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

