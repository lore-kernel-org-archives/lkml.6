Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746BA20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544127977;
	bh=0wPDtX5OA3DbjV7VbEIrXgyKIprM+1U9IRGO+jBtJS8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=a729IMi5fmIjZqqOgjHeJx9pU66LB8wmFnxGgRRJ+3+PQAGRvoYoUoYFPcMrHx8BC
	 Ay1OKl/WEqzGxyFy13mIHOkdLuWQfgL8J9ema569s8dNTgalv261ETv55o4LuNRTZH
	 5hPWMTvv9S1/fTNgmLV1M8/hz+HB13Z0aJAiAHPo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746BA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLFU0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:26:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37110 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLFU0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7Dpa3fEkZkb7TktocD6arHERMVCyxx1R12xaOFEbhqs=; b=CmSivIzw9UQ2
        0fLev91UngYmKptuD1uSujZ7tb76WbT3zqpiwA0710zFTls0oFR4gkj8JaQGtBHGinSxfQpIlfJ6p
        Fnmr1TiYL2rO/cuIeTcVahb0YWO9tzIUZcbsrA495bbT/0IIN83CfpKtsQuUR3O+xEMacAdwVWpge
        ILxUI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV0Dk-0001hS-HK; Thu, 06 Dec 2018 20:26:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3B4DD11252F7; Thu,  6 Dec 2018 20:26:04 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: use dma_ops of parent device for acp_audio_dma" to the asoc tree
In-Reply-To:  <20181204224253.216075-2-yuzhao@google.com>
X-Patchwork-Hint: ignore
Message-Id: <20181206202604.3B4DD11252F7@debutante.sirena.org.uk>
Date:   Thu,  6 Dec 2018 20:26:04 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: use dma_ops of parent device for acp_audio_dma

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 23aa128bb28d9da69bb1bdb2b70e50128857884a Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 4 Dec 2018 15:42:53 -0700
Subject: [PATCH] ASoC: use dma_ops of parent device for acp_audio_dma

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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2

