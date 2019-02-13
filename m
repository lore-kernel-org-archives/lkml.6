Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517DCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BDA222D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tnmn7q1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405884AbfBMSn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:27 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30921 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405841AbfBMSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:24 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190213184323epoutp0261692bcb82039bcf119d1fbc9b267417~DAKRwwHET0221502215epoutp02G;
        Wed, 13 Feb 2019 18:43:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190213184323epoutp0261692bcb82039bcf119d1fbc9b267417~DAKRwwHET0221502215epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083403;
        bh=4r9BDhjJdgjV+qJedBadvh8+VBJ5DIXEhHxwe0CLdFI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Tnmn7q1fOMCaO1m+IdwndYcdVVFrqv7M14HKMRY+jahzYLS7sxqfBlN05iJHAAEwM
         enGBYiscBikYsQGX3zH1AuPygLlM4nSY/dJhwwduDkNoOtWakjWzpAn6KKFV+5ZC+F
         m89IrDMgZ7kUavv9md6wgcDEdmXVolQmRXkZjUCc=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190213184322epcas2p133f934a95bfcfab269d7217d0cf46631~DAKQ8Q2OV1584015840epcas2p1g;
        Wed, 13 Feb 2019 18:43:22 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.6C.04136.A45646C5; Thu, 14 Feb 2019 03:43:22 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190213184320epcas2p2d54cbd017c6c666239a4d6f8d78cf620~DAKP2G_HO2268322683epcas2p2i;
        Wed, 13 Feb 2019 18:43:20 +0000 (GMT)
X-AuditID: b6c32a46-2bfff70000001028-c2-5c64654a583e
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 18.ED.03689.845646C5; Thu, 14 Feb
        2019 03:43:20 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:20 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 08/13] ASoC: samsung: Drop DAI DMA data chan_name
 assignments
Date:   Wed, 13 Feb 2019 19:42:07 +0100
Message-id: <20190213184212.5473-9-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmma5XakqMwdy1rBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mrv9BBWuEKlZO6mNuYNzM38XIySEh
        YCLRNX0HcxcjF4eQwA5GiVfXrrJBON8ZJea3XmCCqVp88hUjiC0ksIFR4vSSRAj7F6PE0eMS
        IDabgKFE79E+sBoRATGJ23M6waYyC7QwScyZu5QZJCEsECRx+9krVhCbRUBVomHlHbAFvAJW
        EpNPzGKBWCYvsXrDAbB6TgFriX9rn7ODDJIQWMAmsWD/LHaIIheJOdd3skLY0hLPVm1khLCr
        JXZt72aGaOhglGi5sJ0ZImEtcfj4RbAGZgE+iY7Df4EGcQDFeSU62oQgSjwkJs0/xgLxfh+j
        ROejXqYJjBILGBlWMYqlFhTnpqcWGxUY6RUn5haX5qXrJefnbmIEx6CW2w7GJed8DjEKcDAq
        8fBWCKXECLEmlhVX5h5ilOBgVhLh1YsCCvGmJFZWpRblxxeV5qQWH2KU5mBREud9KD03Wkgg
        PbEkNTs1tSC1CCbLxMEp1cA46XeloK6P1/OEVG+BIDMzU57ipYE3nSe4rjrnpHvVaUt/3n1u
        n2LvU0rsV7Ntjy7tWKG/5YBiybNM4Ynn3a4aeakx+5840HLQXK4/ZfdDVd+Fx5cvFnvO/OlM
        +K3DMaWcp7dfy9mqMW1P7wT3P0uPH1WoesR3obcy/N41tkPL06d+s049LJqqxFKckWioxVxU
        nAgABGg5sL0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t9jQV2P1JQYg71N5hZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Mrv9BBWuEKlZO6mNuYNzM38XIySEh
        YCKx+OQrxi5GLg4hgXWMEpPPrmEBSQgJ/GKUmP00HMRmEzCU6D3axwhiiwiISdye08kM0sAs
        0MQksev2RXaQhLBAgET76YlMIDaLgKpEw8o7YDavgJXE5BOzWCC2yUus3nCAGcTmFLCW+Lf2
        OTvEMiuJiR8uMU9g5FnAyLCKUTK1oDg3PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMwxLYd1urf
        wfh4SfwhRgEORiUe3gqhlBgh1sSy4srcQ4wSHMxKIrx6UUAh3pTEyqrUovz4otKc1OJDjNIc
        LErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjBq8R+5d9HkcJWOeUnUm/ybDBf7AD+WVi1OS
        OH2NNgrcvbmWaapybG6o2Rnuh0ECLWZCyX02Vk3zPknmrDTdOLFB0Mdy1p7gp1wXF8gu9ff+
        c1yCcd6nZWv3a9m9LBaauO2qtU31TdeKqy3+Fu1l1kt2m1yS+SizdvN9FbnHd1SMe++snvA+
        SomlOCPRUIu5qDgRAJno4gctAgAA
X-CMS-MailID: 20190213184320epcas2p2d54cbd017c6c666239a4d6f8d78cf620
CMS-TYPE: 102P
X-CMS-RootMailID: 20190213184320epcas2p2d54cbd017c6c666239a4d6f8d78cf620
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184320epcas2p2d54cbd017c6c666239a4d6f8d78cf620@epcas2p2.samsung.com>
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
index 6ab99e38e6dd..16e6868376f6 100644
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
2.17.1

