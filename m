Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B6FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4288020882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G56+r7bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbfA3OuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:50:06 -0500
Received: from m50-132.163.com ([123.125.50.132]:57260 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfA3OuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:50:06 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 09:50:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=uE4/UP5wc0l4lhT37E
        UPqa3KyorclaOmvJ65eSZXlfA=; b=G56+r7blu6cYyLBmu59XFOvXAzLlzT9M77
        8e2nzkm5TbuAPfYo2/y0fulYDApJMAMVMAesECP88nPuXMQrdu11NuuWSylFIm8o
        r25HPaOVQFzYBdYucRJt/M2ThLkTkPRLc2lMCVK6mTS9cZEhCSb82OrqlQO+YiNL
        oX6jRmxoM=
Received: from localhost.localdomain (unknown [27.42.92.102])
        by smtp2 (Coremail) with SMTP id DNGowAC30CfBtVFcdxHPAg--.1390S3;
        Wed, 30 Jan 2019 22:33:53 +0800 (CST)
From:   lsh <lshua312@163.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        heiko@sntech.de, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lsh <lshua312@163.com>
Subject: [PATCH] ASoC: rockchip: fix small typo
Date:   Wed, 30 Jan 2019 22:33:35 +0800
Message-Id: <1548858815-20161-1-git-send-email-lshua312@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: DNGowAC30CfBtVFcdxHPAg--.1390S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1UJF1DWr43ZrWrXFy5Jwb_yoWDGrg_t3
        47WFyUu3y8urWfA3yUGasxAws3Z3ZIkFyUGF1YyF4UJFn8Ca4rGFy8Jw17uFZxWa1Sg3sY
        9r1YvrW3Jr1rtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRf-P5UUUUU==
X-Originating-IP: [27.42.92.102]
X-CM-SenderInfo: 5ovk3tqtrsqiywtou0bp/xtbBDgRLalra-A3ZCQABsL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

codec_dai -> cpu_dai

Signed-off-by: lsh <lshua312@163.com>
---
 sound/soc/rockchip/rockchip_rt5645.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 881c324..f88adf0 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -95,14 +95,16 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
 	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
 				     SND_SOC_CLOCK_OUT);
 	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		dev_err(cpu_dai->dev,
+			"Can't set clock for cpu_dai %d\n", ret);
 		return ret;
 	}
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 				     SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		dev_err(codec_dai->dev,
+			"Can't set clock for codec_dai %d\n", ret);
 		return ret;
 	}
 
-- 
1.9.1


