Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B63C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC741222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o/QuVJEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfBLSFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:34 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40187 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbfBLSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:32 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190212180530epoutp01f23cf58c33372d2da0e58011c4426e16~Cr-6sA4px1898018980epoutp01x;
        Tue, 12 Feb 2019 18:05:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190212180530epoutp01f23cf58c33372d2da0e58011c4426e16~Cr-6sA4px1898018980epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994730;
        bh=mDsrQB9XFl+b+gU0NhyopnqhCmadZz0dft/zEEJkkWo=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=o/QuVJEgy0fo7vRkmlXQe8xOV2eVzcMynZtzm3ZuY/PmH9PLffhlf4dAxeS4RU4kL
         uyVFOhpzBcNCs4Wvs5yHsC28p8xqn4pcWjjaUsjSiXQ4hXtYzlEUPup+bpR/88Qw6T
         lKELggR3NOEigNsaNGxSdetPC3H3awyxOQzJl3kg=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190212180528epcas2p49b2c3cbbb17dc46f2fb679c735f3224f~Cr-5SQf8A2309023090epcas2p4K;
        Tue, 12 Feb 2019 18:05:28 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.5C.04136.8EA036C5; Wed, 13 Feb 2019 03:05:28 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180528epcas2p1a534f0f69932c28608b0a139ddfd3596~Cr-46qRR82517825178epcas2p1F;
        Tue, 12 Feb 2019 18:05:28 +0000 (GMT)
X-AuditID: b6c32a46-2bfff70000001028-96-5c630ae8f109
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 3B.30.03689.8EA036C5; Wed, 13 Feb
        2019 03:05:28 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:28 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 14/21] ASoC: samsung: Drop DAI DMA data chan_name
 assignments
Date:   Tue, 12 Feb 2019 19:03:35 +0100
Message-id: <20190212180342.32040-15-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmhe4LruQYg+lTFSyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZby8rFKwRqjh5O7SBcTN/FyMnh4SA
        icTs92eYuxi5OIQEdjBKrG/bzQrhfGeU+NKwgB2mat+jn+wQiQ2MEoemnGKDcH4xSrzadpIJ
        pIpNwFCi92gfI4gtIiAmcXtOJ9hcZoEWJok5c5cygySEBYIkFnR0gdksAqoSTU9XsYHYvAI2
        EgverWKBWCcvcb53HdhqTqD4s4XfWCBqBCV+TL4HZjMD1Ry88pwFZIGEwB42iRlfrrJBNLtI
        tO7uYIWwpSWerdrICGFXS+za3s0M0dDBKNFyYTszRMJa4vDxi6wQU/kkOg7/BdrMARTnleho
        E4IwPSRaHshCfNzPKLG57xTjBEapWUhumoXkpgWMTKsYxVILinPTU4uNCoz0ihNzi0vz0vWS
        83M3MYJjXMttB+OScz6HGAU4GJV4eFccTYoRYk0sK67MPcQowcGsJMKbxpwcI8SbklhZlVqU
        H19UmpNafIhRmoNFSZz3ofTcaCGB9MSS1OzU1ILUIpgsEwenVAPjoa8njmhmcmxk0Uu7ZaGf
        Y/Xzx6K/U343rFpzz740wWyWwOrrracaNU8v3JIyMbzSZffnHy+9khvzrQ8zSGh0+K3uP6mk
        fSVA6onjnbK7M+aa58bMmqESVuOmKLmje76UfCXzmsOZr6ZNTVpx1PfDQVZR8Uka3M0G71qO
        PdJfIe4uIqg3SU5GiaU4I9FQi7moOBEAyd50De0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jQd0XXMkxBlNWclhcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgy3l5WKFgjVHHydmgD42b+LkZODgkB
        E4l9j36ydzFycQgJrGOUWHqnhQ3C+cUosePhKSaQKjYBQ4neo32MILaIgJjE7TmdzCBFzAJN
        TBK7bl9kB0kICwRILH67kw3EZhFQlWh6ugrM5hWwkVjwbhULxDp5ifO968DqOYHizxZ+A4pz
        AG2zlriyyRaiXFDix+R7YOXMQOUHrzxnmcDINwtJahaS1AJGplWMkqkFxbnpucVGBUZ5qeV6
        xYm5xaV56XrJ+bmbGIEBvO2wVv8OxsdL4g8xCnAwKvHwrjiaFCPEmlhWXJl7iFGCg1lJhDeN
        OTlGiDclsbIqtSg/vqg0J7X4EKM0B4uSOC9//rFIIYH0xJLU7NTUgtQimCwTB6dUA6Ptt62c
        MfFx94OO94b1zLpeoSb0g21PyE3vw+0/QtemNLGE5b/6tiv1T26/yZ0lz5e2ly4TqSo+aa6n
        XnQ0lI17Wn3AU96w2YGpBrtcF7bnqqffYmGrmbVKtimL9ZG4Nt/U/QIr+p5rOiR28Wj/nKms
        drZ6V8qp12aHpiqs7rZZnbXRkf1XjhJLcUaioRZzUXEiACsm1hhcAgAA
X-CMS-MailID: 20190212180528epcas2p1a534f0f69932c28608b0a139ddfd3596
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180528epcas2p1a534f0f69932c28608b0a139ddfd3596
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180528epcas2p1a534f0f69932c28608b0a139ddfd3596@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now no need to pass DMA channel names through the DAI DMA data,
custom DMA config of the PCM is now used for this purpose.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/i2s.c         | 4 ----
 sound/soc/samsung/s3c2412-i2s.c | 2 --
 sound/soc/samsung/s3c24xx-i2s.c | 2 --
 3 files changed, 8 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 72282d08d2c1..f438558c4d21 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1450,8 +1450,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	}
 	pri_dai->dma_playback.addr = regs_base + I2STXD;
 	pri_dai->dma_capture.addr = regs_base + I2SRXD;
-	pri_dai->dma_playback.chan_name = "tx";
-	pri_dai->dma_capture.chan_name = "rx";
 	pri_dai->dma_playback.addr_width = 4;
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->priv = priv;
@@ -1466,9 +1464,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	if (quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
-
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
-		sec_dai->dma_playback.chan_name = "tx-sec";
 
 		if (!np) {
 			sec_dai->dma_playback.filter_data = i2s_pdata->dma_play_sec;
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index c08638b0e458..a00e35147e50 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -35,12 +35,10 @@
 #include <linux/platform_data/asoc-s3c.h>
 
 static struct snd_dmaengine_dai_dma_data s3c2412_i2s_pcm_stereo_out = {
-	.chan_name	= "tx",
 	.addr_width	= 4,
 };
 
 static struct snd_dmaengine_dai_dma_data s3c2412_i2s_pcm_stereo_in = {
-	.chan_name	= "rx",
 	.addr_width	= 4,
 };
 
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index a8026b640c95..600b3b4cdb5b 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -31,12 +31,10 @@
 #include "s3c24xx-i2s.h"
 
 static struct snd_dmaengine_dai_dma_data s3c24xx_i2s_pcm_stereo_out = {
-	.chan_name	= "tx",
 	.addr_width	= 2,
 };
 
 static struct snd_dmaengine_dai_dma_data s3c24xx_i2s_pcm_stereo_in = {
-	.chan_name	= "rx",
 	.addr_width	= 2,
 };
 
-- 
2.20.1

