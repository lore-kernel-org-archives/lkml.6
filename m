Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71E0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DAC214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DAC214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeKOLxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:53:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:36658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbeKOLxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:53:12 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40821DF79A79F;
        Thu, 15 Nov 2018 09:47:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 15 Nov 2018 09:47:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: amd: remove set but not used variable 'dma_buffer'
Date:   Thu, 15 Nov 2018 01:56:35 +0000
Message-ID: <1542246995-180932-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/amd/raven/acp3x-pcm-dma.c: In function 'acp3x_dma_hw_params':
sound/soc/amd/raven/acp3x-pcm-dma.c:333:25: warning:
 variable 'dma_buffer' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
8de1b5ed0337 ("ASoC: amd: add acp3x system resume pm op")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 2e61cef..28a867f 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -330,7 +330,6 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	int status;
 	u64 size;
-	struct snd_dma_buffer *dma_buffer;
 	struct page *pg;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct i2s_stream_instance *rtd = runtime->private_data;
@@ -338,7 +337,6 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 	if (!rtd)
 		return -EINVAL;
 
-	dma_buffer = &substream->dma_buffer;
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)



