Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD094C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F412218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497673;
	bh=wPF0JAQrSjbgLPU1V/n7qHzABSRyZd6Jf7NJF3WgV/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wofHr789TvSJDoHUoATkGgEMsmnEgsJZc/aNgyjU7uy6rIfI2HF/QU58RZMCdW0al
	 OYxllLGF1b22mWAzqFPUkTrQDBkuMdkTXZWUPawvVSwKYLLMCVOq+/++fTBzc/3SUV
	 DpbAf2A2arnaD4OutcVYTmEhTEoPxXpc/1WYH98Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfBRNrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:47:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731826AbfBRNrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:47:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02650217F5;
        Mon, 18 Feb 2019 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497667;
        bh=wPF0JAQrSjbgLPU1V/n7qHzABSRyZd6Jf7NJF3WgV/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTtHfcafmPZNWl5nZey/2CPP9G63ytegXDpDolEqLJXgkr5Fq3bTuXhf99HzJUnFw
         4xcw79Wqf0taVm3ENnCx2DftgvUo2pvmjE0FfqXtN76Ud8ob0jdYE9DHWpicHVdqod
         Izr8XfqkAvQEMfGi4mm8XohaP7EER7svRLvKXkjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Blake <chrisrblake93@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.20 64/92] mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
Date:   Mon, 18 Feb 2019 14:43:07 +0100
Message-Id: <20190218133500.879016522@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>

commit d49d92ace4974510dd5845ff91860823cf30dc08 upstream.

Some H5 boards seem to not have proper trace lengths for eMMC to be able
to use the default setting for the delay chains under HS-DDR mode. These
include the Bananapi M2+ H5 and NanoPi NEO Core2. However the Libre
Computer ALL-H3-CC-H5 works just fine.

For the H5 (at least for now), default to not enabling HS-DDR modes in
the driver, and expect the device tree to signal HS-DDR capability on
boards that work.

Reported-by: Chris Blake <chrisrblake93@gmail.com>
Fixes: 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC controller")
Cc: <stable@vger.kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sunxi-mmc.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1399,7 +1399,16 @@ static int sunxi_mmc_probe(struct platfo
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
-	if (host->cfg->clk_delays || host->use_new_timings)
+	/*
+	 * Some H5 devices do not have signal traces precise enough to
+	 * use HS DDR mode for their eMMC chips.
+	 *
+	 * We still enable HS DDR modes for all the other controller
+	 * variants that support them.
+	 */
+	if ((host->cfg->clk_delays || host->use_new_timings) &&
+	    !of_device_is_compatible(pdev->dev.of_node,
+				     "allwinner,sun50i-h5-emmc"))
 		mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 	ret = mmc_of_parse(mmc);


