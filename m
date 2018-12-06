Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325ABC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74B520850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544128023;
	bh=wvIlvaJIkHBTuVm1AorZkrSzh/OLNegYzhXFR9YIT2o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=B+NvcP6hTRCWfLr2aX5DDN7s6qi8ycpyKPap3d4lqv7Xs1ctsJh/jeETp/R460+Pj
	 1381x5kUOYD6C6VWUi11iGRU2KmOiMYS6vaAr13vFlGf19dsFRjYoey4pQr1Tou27p
	 yd63mF4WBiL5aA37FY0M15m6JyEwDkICqvVgivkQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74B520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeLFU0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:26:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37140 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeLFU0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Z7UzodlCKTft1LigrjEIhiPMwbEx6l9cVJBcRQQ8pdQ=; b=rmudQoNhQgdS
        flx7X1Lsow6vihBDP55ru6ux/SnqMDO3oFSWoAP4kk6K6zJe9LwtLxqp0/hAtP1Q3Z7l2O3dH7DJV
        Jiqjnsbng+oWuscEdUQY5TF/M823C62dvusyxHhyFPFK18c5vIDSqAqyMMvHR8gtNCipv79gmejoy
        kidsY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV0Dm-0001hZ-Dy; Thu, 06 Dec 2018 20:26:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 16A7511252F7; Thu,  6 Dec 2018 20:26:06 +0000 (GMT)
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
Subject: Applied "ASoC: use DMA addr rather than CPU pa for acp_audio_dma" to the asoc tree
In-Reply-To:  <20181204224253.216075-1-yuzhao@google.com>
X-Patchwork-Hint: ignore
Message-Id: <20181206202606.16A7511252F7@debutante.sirena.org.uk>
Date:   Thu,  6 Dec 2018 20:26:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: use DMA addr rather than CPU pa for acp_audio_dma

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

From d6d08273996b3363178b920ccfa74acabaf67963 Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 4 Dec 2018 15:42:52 -0700
Subject: [PATCH] ASoC: use DMA addr rather than CPU pa for acp_audio_dma

We shouldn't assume CPU physical address we get from page_to_phys()
is same as DMA address we get from dma_alloc_coherent(). On x86_64,
we won't run into any problem with the assumption when dma_ops is
nommu_dma_ops. However, DMA address is IOVA when IOMMU is enabled.
And it's most likely different from CPU physical address when AMD
IOMMU is not in passthrough mode.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 15 +++++----------
 sound/soc/amd/acp.h         |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cdebab2f8ce5..fd3db4c37882 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -303,11 +303,10 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 }
 
 /* Create page table entries in ACP SRAM for the allocated memory */
-static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
+static void acp_pte_config(void __iomem *acp_mmio, dma_addr_t addr,
 			   u16 num_of_pages, u32 pte_offset)
 {
 	u16 page_idx;
-	u64 addr;
 	u32 low;
 	u32 high;
 	u32 offset;
@@ -317,7 +316,6 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 		/* Load the low address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8)),
 			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-		addr = page_to_phys(pg);
 
 		low = lower_32_bits(addr);
 		high = upper_32_bits(addr);
@@ -333,7 +331,7 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 		acp_reg_write(high, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 
 		/* Move to next physically contiguos page */
-		pg++;
+		addr += PAGE_SIZE;
 	}
 }
 
@@ -343,7 +341,7 @@ static void config_acp_dma(void __iomem *acp_mmio,
 {
 	u16 ch_acp_sysmem, ch_acp_i2s;
 
-	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
+	acp_pte_config(acp_mmio, rtd->dma_addr, rtd->num_of_pages,
 		       rtd->pte_offset);
 
 	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -850,7 +848,6 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	int status;
 	uint64_t size;
 	u32 val = 0;
-	struct page *pg;
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
@@ -986,16 +983,14 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		return status;
 
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
-	pg = virt_to_page(substream->dma_buffer.area);
 
-	if (pg) {
+	if (substream->dma_buffer.area) {
 		acp_set_sram_bank_state(rtd->acp_mmio, 0, true);
 		/* Save for runtime private data */
-		rtd->pg = pg;
+		rtd->dma_addr = substream->dma_buffer.addr;
 		rtd->order = get_order(size);
 
 		/* Fill the page table entries in ACP SRAM */
-		rtd->pg = pg;
 		rtd->size = size;
 		rtd->num_of_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 		rtd->direction = substream->stream;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index dbbb1a85638d..e5ab6c6040a6 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -123,7 +123,7 @@ enum acp_dma_priority_level {
 };
 
 struct audio_substream_data {
-	struct page *pg;
+	dma_addr_t dma_addr;
 	unsigned int order;
 	u16 num_of_pages;
 	u16 i2s_instance;
-- 
2.19.0.rc2

