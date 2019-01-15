Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EA92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547579337;
	bh=Zu0t7LCR2Xok8AHrrwimgLbgVKDivmypjsSy9ycAorE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bKboKEj6EVtoXmrG23ak0HA+Vk2OYEXw/thlqXr0ZcM79u4syXG6UJClWA9W1G8mJ
	 pqP7URCKLQvpeYHpmhP8pTy2155o/2fkt09ce6djArsPhY0XW8Z3ntE2kIUCcYogxv
	 J/ttxVkFNt23eg7JTUfX7UbVMWgbwozbYJlT1UPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389231AbfAOTI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:08:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57502 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388564AbfAOTIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2phbaKzwnkB9mPN9q9C/MZPugBUoe3ZvFLLcCHKPRHs=; b=veeBAUh3A7ud
        iaRPzWu8jPwu2ghaWrWQ/Tyicns7I+ray+8ZAArLDVRuTrC3rmNchR0ghQB7P3ApuGzuTWivfgtnA
        TmOZZkJFrLeQjLwbcj+PE0ujBPmSajb5UzPUo3ULFMfdXadjnDVCbx/D/Bqt8ov9ke/FBQnxyHJxQ
        ajPng=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjU4h-000287-Ra; Tue, 15 Jan 2019 19:08:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 768671127848; Tue, 15 Jan 2019 19:08:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lanqing Liu <lanqing.liu@spreadtrum.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: sprd: Fix the error data length in SPI read-only mode" to the spi tree
In-Reply-To:  <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190115190835.768671127848@debutante.sirena.org.uk>
Date:   Tue, 15 Jan 2019 19:08:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: sprd: Fix the error data length in SPI read-only mode

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 63f5ffc46d4f53b309a93b83420b2e4bd0da5aba Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@spreadtrum.com>
Date: Tue, 15 Jan 2019 21:46:50 +0800
Subject: [PATCH] spi: sprd: Fix the error data length in SPI read-only mode

In SPI read-only mode, we will always return the writing length,
which is always the power of "bits_per_word", but the length unit
using by users is byte.

Thus this patch fixes the returning length by getting from
read_bufs() function to get the correct length.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 8daa24eec624..fa324ce194b2 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -380,7 +380,7 @@ static int sprd_spi_txrx_bufs(struct spi_device *sdev, struct spi_transfer *t)
 {
 	struct sprd_spi *ss = spi_controller_get_devdata(sdev->controller);
 	u32 trans_len = ss->trans_len, len;
-	int ret, write_size = 0;
+	int ret, write_size = 0, read_size = 0;
 
 	while (trans_len) {
 		len = trans_len > SPRD_SPI_FIFO_SIZE ? SPRD_SPI_FIFO_SIZE :
@@ -416,13 +416,15 @@ static int sprd_spi_txrx_bufs(struct spi_device *sdev, struct spi_transfer *t)
 			goto complete;
 
 		if (ss->trans_mode & SPRD_SPI_RX_MODE)
-			ss->read_bufs(ss, len);
+			read_size += ss->read_bufs(ss, len);
 
 		trans_len -= len;
 	}
 
-	ret = write_size;
-
+	if (ss->trans_mode & SPRD_SPI_TX_MODE)
+		ret = write_size;
+	else
+		ret = read_size;
 complete:
 	sprd_spi_enter_idle(ss);
 
-- 
2.20.1

