Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3868C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BB92075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hcu8MS8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfBFOrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:47:33 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6210 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbfBFOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:47:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5af3730002>; Wed, 06 Feb 2019 06:47:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 06:47:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 06:47:28 -0800
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:47:28 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:47:27 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Feb 2019 14:47:27 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.121]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5af37f0000>; Wed, 06 Feb 2019 06:47:27 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <digetx@gmail.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V13 4/5] i2c: tegra: update transfer timeout
Date:   Wed, 6 Feb 2019 06:47:20 -0800
Message-ID: <1549464441-1836-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
References: <1549464441-1836-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549464435; bh=cH5T4DzgqICyJiKkgxt4PJCoW9vZY2wMo/+D0GFPVR8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hcu8MS8CNDTsoIxf+FSxwPnqvptvT45HN3Dnse7VdLsQxo+pcTKt5J7xt3UkWpnZ2
         uDW8fdbGNIzQv1hGmnc+mI4SEhys/At+0NBlmZZYWI5IPcOq6vsYtAC7iVTaSrbABD
         I6nhx4/tYWGZY425aZ/IAqhBSp9VkyW0m6lE8C8HKCWqBTp13LSSOgdl/M3M96xQDU
         wEsAE9/YlQb9Iyr1cUSlG1AAWx7kDsJp61XmAWHXdTyBppqFv9+vvZpNJXTxF7cyZK
         E1knU5aBK0DB7JykNBxdTfQai/BsTDw+sJoqkyj3MzUZp/DDl85+mkRvpnrt0BZPoC
         LahIb9k7gpBng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra194 allows max of 64K bytes and Tegra186 and prior allows
max of 4K bytes of transfer per packet.

one sec timeout is not enough for transfers more than 10K bytes
at STD bus rate.

This patch updates I2C transfer timeout based on the transfer size
and I2C bus rate to allow enough time during max transfer size at
lower bus speed.

Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V10/V11/V12/V13] : Reduced the timeout for bus clear operation
	Added adapter timeout to cover worst case transfer rate (max transfer
	size at STD speed) incase if ARB LOST happens during middle/end of 
	the transaction.
 [V9] : Rebased to 5.0-rc4
	Minor updates for readability of xfer time
 [V8] : Added comment with explaination of xfer time calculation
 [V5/V6/V7] : Same as V4
 [V4] : V4 series includes bus clear support and this patch is updated with
	fixed timeout of 1sec for bus clear operation.
 [V3] : Same as V2
 [V2] : Added this patch in V2 series to allow enough time for data transfer
	to happen.
	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
	takes argument with this patch.


 drivers/i2c/busses/i2c-tegra.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 47b1d08f7a08..f38ebc61fc26 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -24,7 +24,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
-#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
 #define BYTES_PER_FIFO_WORD 4
 
 #define I2C_CNFG				0x000
@@ -938,8 +937,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
 		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
 		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
 
-		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-							TEGRA_I2C_TIMEOUT);
+		time_left = wait_for_completion_timeout(
+						&i2c_dev->msg_complete,
+						msecs_to_jiffies(50));
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "timed out for bus clear\n");
 			return -ETIMEDOUT;
@@ -966,6 +966,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	u32 *buffer = NULL;
 	int err = 0;
 	bool dma;
+	u16 xfer_time = 100;
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
@@ -986,6 +987,13 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
 	dma = i2c_dev->is_curr_dma_xfer;
 
+	/*
+	 * Transfer time in mSec = Total bits / transfer rate
+	 * Total bits = 9 bits per byte (including ACK bit) + Start & stop bits
+	 */
+	xfer_time += DIV_ROUND_CLOSEST(((xfer_size * 9) + 2) * MSEC_PER_SEC,
+					i2c_dev->bus_clk_rate);
+
 	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
 
 	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
@@ -1089,7 +1097,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 
 		time_left = wait_for_completion_timeout(
 						&i2c_dev->dma_complete,
-						TEGRA_I2C_TIMEOUT);
+						msecs_to_jiffies(xfer_time));
 
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
@@ -1116,8 +1124,9 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		}
 	}
 
-	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-						TEGRA_I2C_TIMEOUT);
+	time_left = wait_for_completion_timeout(
+					&i2c_dev->msg_complete,
+					msecs_to_jiffies(xfer_time));
 	tegra_i2c_mask_irq(i2c_dev, int_mask);
 
 	if (time_left == 0) {
@@ -1374,6 +1383,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->div_clk = div_clk;
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
 	i2c_dev->adapter.retries = 1;
+	i2c_dev->adapter.timeout = 6 * HZ;
 	i2c_dev->irq = irq;
 	i2c_dev->cont_id = pdev->id;
 	i2c_dev->dev = &pdev->dev;
-- 
2.7.4

