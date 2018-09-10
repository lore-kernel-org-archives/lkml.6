Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347902087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Lk3avSO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347902087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeIJQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:28:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38692 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9X8qssQ+w3DjNW3Lp/6D0PkXwJH/g1BONAtbjTopSXY=; b=Lk3avSO8ltGM
        tShW4qRb6+M8nbg7DQHbIN3zvsbVQh0MOesTY3zpNHJXfD4iUt4c1gQ/UfgA78tJLqYceLeaqAU70
        fvcUDVYq3JKBVtflpds6M+UOIQmqrzasgfZZ8J9Fm7RoPKQ21x4oJQiRkY87A3ZVz/B1M8b7tUbXL
        PpfZ4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzKT6-0001vT-H5; Mon, 10 Sep 2018 11:35:00 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2C25F1122D51; Mon, 10 Sep 2018 12:35:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        Mark Brown <broonie@kernel.org>,
        "Mukunda,, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        akshu.agrawal@amd.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: AMD: Ensure reset bit is cleared before configuring" to the asoc tree
In-Reply-To:  <1536566815-3271-2-git-send-email-akshu.agrawal@amd.com>
Message-Id: <20180910113500.2C25F1122D51@debutante.sirena.org.uk>
Date:   Mon, 10 Sep 2018 12:35:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: AMD: Ensure reset bit is cleared before configuring

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

From 2a665dba016d5493c7d826fec82b0cb643b30d42 Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 10 Sep 2018 13:36:30 +0530
Subject: [PATCH] ASoC: AMD: Ensure reset bit is cleared before configuring

HW register descriptions says:
"DMA Channel Reset...Software must confirm that this bit is
cleared before reprogramming any of the channel configuration registers."
There could be cases where dma stop errored out leaving dma channel
in reset state. We need to ensure that before the start of another dma,
channel is out of the reset state.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e359938e3d7e..77b265bd0505 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/sizes.h>
 #include <linux/pm_runtime.h>
 
@@ -184,6 +185,24 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
 	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 }
 
+static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
+{
+	u32 dma_ctrl;
+	int ret;
+
+	/* clear the reset bit */
+	dma_ctrl = acp_reg_read(acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
+	dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRst_MASK;
+	acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
+	/* check the reset bit before programming configuration registers */
+	ret = readl_poll_timeout(acp_mmio + ((mmACP_DMA_CNTL_0 + ch_num) * 4),
+				 dma_ctrl,
+				 !(dma_ctrl & ACP_DMA_CNTL_0__DMAChRst_MASK),
+				 100, ACP_DMA_RESET_TIME);
+	if (ret < 0)
+		pr_err("Failed to clear reset of channel : %d\n", ch_num);
+}
+
 /*
  * Initialize the DMA descriptor information for transfer between
  * system memory <-> ACP SRAM
@@ -236,6 +255,7 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 					      &dmadscr[i]);
 	}
+	pre_config_reset(acp_mmio, ch);
 	config_acp_dma_channel(acp_mmio, ch,
 			       dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,
@@ -275,6 +295,7 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 					      &dmadscr[i]);
 	}
+	pre_config_reset(acp_mmio, ch);
 	/* Configure the DMA channel with the above descriptore */
 	config_acp_dma_channel(acp_mmio, ch, dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,
-- 
2.19.0.rc1

