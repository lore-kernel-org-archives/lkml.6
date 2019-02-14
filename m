Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF74BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7390D20821
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q7YEc2WZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfBNJjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:39:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64972 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395095AbfBNJis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:48 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190214093845epoutp0224cb7aa3ef564c177070e99c7c8dc5c1~DMYCu2KLJ1800018000epoutp02l;
        Thu, 14 Feb 2019 09:38:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190214093845epoutp0224cb7aa3ef564c177070e99c7c8dc5c1~DMYCu2KLJ1800018000epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137125;
        bh=4r9BDhjJdgjV+qJedBadvh8+VBJ5DIXEhHxwe0CLdFI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=q7YEc2WZOLw5zpurKIksBRKLFBl8A3T5wXAXwvjJi2S8Kj0CV0xjqgWunoTqMSYru
         OBSpWSl6EsBrGJCT4JFhQeZIwyvsJpmU5QfjbK9xmgdHQsf7EOQLVgDX/OP/CYaERQ
         j7/rjRkkT9PYwKfZpVGQUZL6fBsbtizrwGXC5TC4=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093845epcas1p2f74acb4ee8580a9f2d51863e3a666239~DMYCglHl62812928129epcas1p2F;
        Thu, 14 Feb 2019 09:38:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.CE.04173.527356C5; Thu, 14 Feb 2019 18:38:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190214093844epcas1p432e337986df8edc10206413da8a7cd08~DMYCM-4Ix0480804808epcas1p4h;
        Thu, 14 Feb 2019 09:38:44 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-01-5c653725ddc0
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id DB.F3.04015.427356C5; Thu, 14 Feb
        2019 18:38:44 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:44 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 08/13] ASoC: samsung: Drop DAI DMA data chan_name
 assignments
Date:   Thu, 14 Feb 2019 10:37:42 +0100
Message-id: <20190214093747.2414-9-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCmvq6qeWqMwctFnBZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV0bX/6CCNUIVKyf1MTcwbubvYuTkkBAwkVh5fAlrFyMXh5DADkaJ
        vpVnmSCc74wSUy/uYYepam25yAyR2MAo8fniRnYI5xejxIfpX5lAqtgEDCV6j/YxgtgiAmIS
        t+d0gnUwC6xklNiybxMbSEJYIFLi55ftYEUsAqoSjT+OADVzcPAKWEmc/BUGsU1eYvWGA8wg
        NqeAtcTMTRDlEgIdbBJ3pvNC2C4SXz7NYwVplRCQlrh01BYiXC2xa3s32FqgckaJlgvbmSES
        1hKHj19kBbGZBfgk3n3tgerllehoE4IwPSTutzhCvNXHKHHp/RrWCYwSCxgZVjGKpRYU56an
        FhsWGOkVJ+YWl+al6yXn525iBEeYltkOxkXnfA4xCnAwKvHwVgilxAixJpYVV+YeYpTgYFYS
        4b1olBojxJuSWFmVWpQfX1Sak1p8iFGag0VJnHe9g3OMkEB6YklqdmpqQWoRTJaJg1OqgdGR
        W2nmC9+/cTc5Vny8/p/pZ+70lbL8Sq/3TPdQ+5jCut3p+7ovYcGZL0RMdazYQv51C7RcTdXL
        Vyt3MDN9M2fZuY2lc3TDLVWvvHf4xZV918SyIrj87RQWxy8H3PsLpJP92ngn2TwWNOJ93rWM
        V1Ji56WJ6U796nEmwmJdqTrtwXMb/yiqK7EUZyQaajEXFScCAAf0N4ysAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42I5/e+xoK6KeWqMwbNbZhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV0bX/6CCNUIVKyf1MTcwbubvYuTkkBAwkWhtucjcxcjFISSwjlFi
        4Yr5LBDOL0aJhrf7GEGq2AQMJXqP9oHZIgJiErfndIJ1MAusZJQ48n0VWEJYIFLi55ftYDaL
        gKpE448jTF2MHBy8AlYSJ3+FQWyTl1i94QAziM0pYC0xcxNIOQfQMiuJdYfKJzDyLGBkWMUo
        mVpQnJueW2xUYJiXWq5XnJhbXJqXrpecn7uJERhC2w5r9e1gvL8k/hCjAAejEg+vgkBKjBBr
        YllxZe4hRgkOZiUR3otGqTFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0t
        SC2CyTJxcEo1MHpMYFzTOTvmbLEp12ut76FfY/tWf2S93COqq8d/bLW76AVOjdJG9mmXD/ju
        Wi4lvapJVeRaNHNL0MYL5w/yOr76brWhSXrPzZ8NEU+CzYPYJzpdW+vSNo3VWlP7AIvQ8+tu
        fv3fbri2RycvflgSKVfUte/aZ+Wgk7Efvm3gnBaw+BvXIu7lfkosxRmJhlrMRcWJABLfeokd
        AgAA
X-CMS-MailID: 20190214093844epcas1p432e337986df8edc10206413da8a7cd08
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214093844epcas1p432e337986df8edc10206413da8a7cd08
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093844epcas1p432e337986df8edc10206413da8a7cd08@epcas1p4.samsung.com>
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

