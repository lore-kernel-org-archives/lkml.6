Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59881C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110A42081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIdvHdIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110A42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbeLDWnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:05 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39352 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:03 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so17161454itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZrTOGAnGJl3L90BtoRIG3cB3hsfNPuxk5U9f37VtyI=;
        b=OIdvHdIlPVSq8gUpeFcCkMCD8Q+edeKLAzPjlaArQHBzBBcmEwa9tBCPmQpiTQchVx
         C/oofZVBznqPCZEErZbXJh+DlsOpn9vrHqZV4SUowS0anfBwyx6q2uHAb02KUsi4vRyP
         BkpGtPSu9Qtu34vPlW4SOWKekFnsaSeGHCr2KemMV0YgSu8UOfqOeNfa+eH8T/fWSv5p
         bXjKEXnZnY7qVtwD1WQgbDKmlvtLb/557Ts8kl8VV+mseuuKmIgM1v1WqhtkJfMY6Cta
         jd6/BbFBGFxLHlVwgBl8tJKV7l1rDCa6u/g7ItZaGylEchF6Z/ccEiojeRultDUPpVuj
         pC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZrTOGAnGJl3L90BtoRIG3cB3hsfNPuxk5U9f37VtyI=;
        b=W3B8fEHSy++F/0PtqN06+T/54SefXnU+7/LVCcMvsRJpeRF4OQY99oUp/isW6iECNE
         0GeGil0gZlcXKs3Cr8V1OEpxQI6UjP60YW7JFqSnTc5Iv8fm6cN/uR1RY0nTjrdCLZN+
         v+Sabnq3r1ZRNBrAAX95faBhvdaGxxtSNns/IoUeekSX8qngui0TeqhKYfoPLUrWZruo
         vgKtHoeMbXLdAtRBKCyUaxylwr75W+BMLbIk4O1GpwBWorOOaYqg5nQ6KxOjXRONIxq6
         zzOJMx15qqWETl2Xxua77eJxHAmsqNeKFB1jzOBWELQpE1xd9V7gjPAWN27hnemp3DN9
         a94g==
X-Gm-Message-State: AA+aEWZlz2QbgDAjj1qmkMDf8J36+D/D5x0VVyG0HiFeNFN8MmaWDLn1
        mFTfymKX6GSsbtM9AN/vgBZcKg==
X-Google-Smtp-Source: AFSGD/UjopuLxGfVhqXS5rxnzrIVNAXnihOa3EBXH77zlD6QjPq5c1XhiNaxp/SnP9UFdtCyPEQkFQ==
X-Received: by 2002:a24:97c3:: with SMTP id k186mr14250988ite.125.1543963382553;
        Tue, 04 Dec 2018 14:43:02 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id 196sm2985872itu.37.2018.12.04.14.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:01 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH 2/2] ASoC: use dma_ops of parent device for acp_audio_dma
Date:   Tue,  4 Dec 2018 15:42:53 -0700
Message-Id: <20181204224253.216075-2-yuzhao@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204224253.216075-1-yuzhao@google.com>
References: <20181204224253.216075-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD platform device acp_audio_dma can only be created by parent PCI
device driver (drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c). Pass struct
device of the parent to snd_pcm_lib_preallocate_pages() so
dma_alloc_coherent() can use correct dma_ops. Otherwise, it will
use default dma_ops which is nommu_dma_ops on x86_64 even when
IOMMU is enabled and set to non passthrough mode.

Though platform device inherits some dma related fields during its
creation in mfd_add_device(), we can't simply pass its struct device
to snd_pcm_lib_preallocate_pages() because dma_ops is not among the
inherited fields. Even it were, drivers/iommu/amd_iommu.c would
ignore it because get_device_id() doesn't handle platform device.

This change shouldn't give us any trouble even struct device of the
parent becomes null or represents some non PCI device in the future,
because get_dma_ops() correctly handles null struct device or uses
the default dma_ops if struct device doesn't have it set.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 sound/soc/amd/acp-pcm-dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index fd3db4c37882..f4011bebc7ec 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1146,18 +1146,21 @@ static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
+	struct device *parent = component->dev->parent;
 
 	switch (adata->asic_type) {
 	case CHIP_STONEY:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 							    SNDRV_DMA_TYPE_DEV,
-							    NULL, ST_MIN_BUFFER,
+							    parent,
+							    ST_MIN_BUFFER,
 							    ST_MAX_BUFFER);
 		break;
 	default:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 							    SNDRV_DMA_TYPE_DEV,
-							    NULL, MIN_BUFFER,
+							    parent,
+							    MIN_BUFFER,
 							    MAX_BUFFER);
 		break;
 	}
-- 
2.20.0.rc1.387.gf8505762e3-goog

