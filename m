Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E709C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06AEB222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nUW6b/T9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfBLSFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40216 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfBLSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:46 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190212180544epoutp019ad8330ce180371153fcf1a637dbc190~CsAId1uOF1898018980epoutp01y;
        Tue, 12 Feb 2019 18:05:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190212180544epoutp019ad8330ce180371153fcf1a637dbc190~CsAId1uOF1898018980epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994744;
        bh=HH2nWa9zF7xBDvnaV/eJcaBCQ+zJRPbcbb67+0bhunw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=nUW6b/T9BIEim556N/+4OxAcVYZNqgeZPOu0dv2fhbrFqoA8yz9CPu4Kv+dbuhLL5
         RNuHLoEGVBFFhS6yRRuKMoQJqA5urGSAZcYJTsOt7VkwIZAAaP+eWJie5qhQmL8la3
         kc3mgjNlk55GqK5VyHDUu03uy5z93sbXE8d8ceRg=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180544epcas2p1f014a6a079ec24e7470475bf43219c3d~CsAHrToJd2517625176epcas2p1J;
        Tue, 12 Feb 2019 18:05:44 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.A1.04138.7FA036C5; Wed, 13 Feb 2019 03:05:43 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180542epcas2p2f7252babc9b4dc97eaaa214658afe5d0~CsAGbsxBF0732907329epcas2p2B;
        Tue, 12 Feb 2019 18:05:42 +0000 (GMT)
X-AuditID: b6c32a45-5f3ff7000000102a-16-5c630af76665
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 9C.30.03689.6FA036C5; Wed, 13 Feb
        2019 03:05:42 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:42 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 18/21] ASoC: samsung: i2s: Comments clean up
Date:   Tue, 12 Feb 2019 19:03:39 +0100
Message-id: <20190212180342.32040-19-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWy7bCmue53ruQYg6vnLSyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZy27/YSn4JFtx6NdfpgbGa+JdjJwc
        EgImEr03NrF3MXJxCAnsYJRYsfY6lPOdUeJn+0JWmKorvz4zQSQ2MEq8WnqBGcL5xShxas4/
        JpAqNgFDid6jfYwgtoiAmMTtOZ1gRcwCLUwSc+YuZQZJCAvYS5z5t4QdxGYRUJU4cHAzC4jN
        K2AjMXPnHBaIdfIS53vXgdVwAsWfLfwGVSMo8WPyPTCbGajm4JXnLCALJAQOsElc39jNBtHs
        InFmxjOou6Ulnq3ayAhhV0vs2t7NDNHQwSjRcmE7M0TCWuLw8YusEFP5JDoO/wXazAEU55Xo
        aBOCKPGQmPP0ONT//UC9C1qYJzBKzUJy1CwkRy1gZFrFKJZaUJybnlpsVGCoV5yYW1yal66X
        nJ+7iREc6VquOxhnnPM5xCjAwajEw7viaFKMEGtiWXFl7iFGCQ5mJRHeNObkGCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8j6TnRgsJpCeWpGanphakFsFkmTg4pRoYc+6c6vu66995uYZNF6/9
        V51c1BRw21I0X0H2+rbV3ZJPbMzcf/fpHD796oP8mhunfKR1dON3ZR3eZZDVcZ3h0PnHTNwJ
        N069+3/t1YR/LttXVbm56p1UWFTJsfL2D+t/V6Qtk54/PcB2yNGlo4fNNrlIdfGu0j05xdK+
        Pos5557zW/f/YS3/YSWW4oxEQy3mouJEAPYC50vwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jQd1vXMkxBv9fqVlcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgylt3+w1LwSbbi0K+/TA2M18S7GDk5
        JARMJK78+szUxcjFISSwjlHids8iNgjnF6PEvFWb2ECq2AQMJXqP9jGC2CICYhK353QygxQx
        CzQxSey6fZEdJCEsYC9x5t8SMJtFQFXiwMHNLCA2r4CNxMydc1gg1slLnO9dB1bDCRR/tvAb
        UJwDaJu1xJVNthDlghI/Jt8DK2cGKj945TnLBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYqMMpL
        LdcrTswtLs1L10vOz93ECAzibYe1+ncwPl4Sf4hRgINRiYd3xdGkGCHWxLLiytxDjBIczEoi
        vGnMyTFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEefnzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGBM8
        zZY9eyR8KOQHb6JF71FF7mdcAitMZP4f232WeS7D29JfmpadXAf23xPbMiMpYIurcMGrg794
        DnP6b87bcTPgfKz2T482XV6XdfsSGta8Srt4clujXvh53XQpQ/8wnncKK90kbtm/O/O2LS35
        yV1l42jesJ8ny0V9WVsvm09ofbarTCFjuhJLcUaioRZzUXEiAASLUuReAgAA
X-CMS-MailID: 20190212180542epcas2p2f7252babc9b4dc97eaaa214658afe5d0
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180542epcas2p2f7252babc9b4dc97eaaa214658afe5d0
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180542epcas2p2f7252babc9b4dc97eaaa214658afe5d0@epcas2p2.samsung.com>
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
index debeaf51cc7e..77c0f70beab1 100644
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
2.20.1

