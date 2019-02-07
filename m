Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16402C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86ED21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FnR6rUvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfBGRB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:01:58 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10912 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfBGRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:57 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207170153epoutp04c48aed19c984e1b53e6c2c11e1dc17dc~BI58kqNL73094230942epoutp049;
        Thu,  7 Feb 2019 17:01:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207170153epoutp04c48aed19c984e1b53e6c2c11e1dc17dc~BI58kqNL73094230942epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558913;
        bh=fE4+fVEIOL9bpW/wkLXBtj63zNa5bOjpGy4ol9fWdv8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=FnR6rUvN3DUp81jVsg7oU4bvzZvEAgTueTTdJzldFJKMpn79Aj7bwArDixEX0GZzE
         361dWVoKsMhKGlLkkKp/P86nBdxfx91SZpzkRDs5J41/BChFb8QGjqtLTvDOy5N0cd
         JyDNqxYj0bV6Of8peho2/yRyqNOD3+swBdAcp6iM=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170152epcas1p13536f1de7bd4d93f1b2b10b84c125fa0~BI58Ei3F23187031870epcas1p1d;
        Thu,  7 Feb 2019 17:01:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.C9.04173.0846C5C5; Fri,  8 Feb 2019 02:01:52 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170152epcas1p254264a82287a54dc2452f5e73daab13d~BI570EVrh1779017790epcas1p21;
        Thu,  7 Feb 2019 17:01:52 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-4b-5c5c6480d51a
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.D8.04015.0846C5C5; Fri,  8 Feb 2019 02:01:52 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:52 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 19/22] ASoC: samsung: Drop DAI DMA data chan_name
 assignments
Date:   Thu, 07 Feb 2019 18:00:27 +0100
Message-id: <20190207170028.720-20-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG+c5tZ6PZcTP9mlmw7oKmEXHohmDBCYKK/ouJHtpBJafrHO/+
        M2velpNAEhkzUotk1aZHa85L5dawIpqzQbGhJBQlySDUtNLI7RD43/M+z+99eT4+ElVFMA1Z
        XFrO8aVsiZZQYE99B7MyTHqdLsuxupsOBb0IPdDpwunbc58JOhDol9E/Q80I/X7ETtCdgWcI
        /fjljIz2LTThdLBvCclRMP2L1wnGY5uRMaKjhWDahhyAWRR3XsAvK07ouZLiSo4/dKpAUeRt
        iCLGP4nVrkERMYGmrRYgJyF1BM523kAtQEGqqGEARzs8iDSsAOhr92EWQMaptaVqyR8FMGwe
        w6ThN4ADvUt47BRBZUOrvw3EdBKVDCP2lvhZlDIj0N51H40Fauo8/NLxWhbTGLUXRr81IDGt
        pI7B5VA9InXaBQNWZ5yRb/jh58OYxCTC1fbZuEY3mInQ13gLSL0goHtwDkjLp2HjmhNItVPh
        tP+kZNfBEfdNVOKbATRPuVEpOA59k0FcOpoAo8utuLSrhM2NKglhYPTOByC92ApgvX9Gdgto
        bJs62TZ1ugsQB0jmjIKhkBOyjYczBdYgVJQWZl4pM4gg/uXpR4dBz7tzXkCRQLtFeSBTp1Ph
        bKVQY/ACSKLaJGVawYal1LM1tRxfls9XlHCCF6SSmDZF6crJ1amoQracu8pxRo7/nyKkXGMC
        1qlJ9V92G2neQ3Bv7O0mjytV7A70VLI7uoo1+sQ0en9o4lJKnt+C9ojm6XTS5Wy4d43JGGr1
        KCIP1d3usDgYpKp6F1fG+z6N9+XWRZ/w89x6cMxX5d73qnHux3z9g0cXt4cXbOG3eVVBeUKy
        42yEW/915mO+Gqvt/q7TYkIRm52O8gL7DzTQMOnuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jAd2GlJgYg+6TIhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MQ63vmAp+C1as37yJqYGxnb+LkYND
        QsBE4s+Xii5GLg4hgZ2MEu1vWxkhnF+MEvem3mXpYuTkYBMwlOg92scIYosIiEncntPJDFLE
        LNDEJLHr9kV2kEnCAr4SX2bog9SwCKhKvHvRygRi8wpYSXy90ghmSwjIS5zvXccOYnMCxW/t
        3wE2X0jAUuLDhCZWiHpBiR+T74HFmYHqD155zjKBkW8WktQsJKkFjEyrGCVTC4pz03OLjQoM
        81LL9YoTc4tL89L1kvNzNzECQ3jbYa2+HYz3l8QfYhTgYFTi4b2gHRMjxJpYVlyZe4hRgoNZ
        SYRXNgEoxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA6OG
        +iTWyFYDuRUVd/RLz+Qz8pzXCPpqJbhFMvPjoaY3PivbUw3XXYxLrFM+U8D5qnPdgUfOvMem
        6piwFlyac8eo8nVQxI/uFs2D+R6W+zsXb79qZu5859mJlkfX8spfbwjdrBgxx8jBr7Kr+K5q
        friN1DOD51NCewqO8uWHlK+U1fXWPcnroMRSnJFoqMVcVJwIAJUpFRldAgAA
X-CMS-MailID: 20190207170152epcas1p254264a82287a54dc2452f5e73daab13d
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170152epcas1p254264a82287a54dc2452f5e73daab13d
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170152epcas1p254264a82287a54dc2452f5e73daab13d@epcas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now no need to pass DMA channel names through the DAI DMA data,
custom DMA config of the PCM is now used for this purpose.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c         | 4 ----
 sound/soc/samsung/s3c2412-i2s.c | 2 --
 sound/soc/samsung/s3c24xx-i2s.c | 2 --
 3 files changed, 8 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 2e91d183dd41..f012d892e6dc 100644
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

