Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC05FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CDF2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Xghk4eUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfA2XSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:18:18 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14918 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfA2XRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:17:54 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c50df040001>; Tue, 29 Jan 2019 15:17:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 15:17:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 15:17:51 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 23:17:51 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 23:17:51 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 23:17:50 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c50df1e0008>; Tue, 29 Jan 2019 15:17:51 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V5 4/5] i2c: tegra: Update transfer timeout
Date:   Tue, 29 Jan 2019 15:16:10 -0800
Message-ID: <1548803771-13424-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
References: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548803844; bh=VuoZAK/haIrMe42M1Oy3zBDyeBLJit1KIHZXczd2Hos=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Xghk4eUtaQ417pOLe2TmtyLe9N+78qoRK4CPgQWR6dRwGrov5EMuXS8Vsf0u9Sq8S
         MnooPmGP2ZkC9a+J1bnNbeVeWExdRECyihqUe4fUsz0OrOyrVEs/3hFdKrFpS/lysj
         iJEwLFiwL5ZsTZZZeZVVmzJuGqpWQ0jZP+Nfw1yE4hBmlha6LvhMZW9vAdAnEnq/4T
         173CUuLVXJe5kAT+1m99fIsLGQUfJ5vaLRk5blg+SuqavT1uJ3TCHB+aaPDOvCUMGQ
         rCTEpMlHY8fKZRkKzXAJDH5spAhE1+BiFfkjmBKAPr5kfYnjUJObtTuAA8cj2G3Dt9
         dA+Y2xoEogrJw==
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

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V5] : Same as V4
 [V4] : V4 series includes bus clear support and this patch is updated with
	fixed timeout of 1sec for bus clear operation.
 [V3] : Same as V2
 [V2] : Added this patch in V2 series to allow enough time for data transfer
	to happen.
	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
	takes argument with this patch.

 drivers/i2c/busses/i2c-tegra.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 651b55fd9aa5..e33bbc1b2212 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -25,7 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
-#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
+#define TEGRA_I2C_TIMEOUT(ms) (msecs_to_jiffies(ms))
 #define BYTES_PER_FIFO_WORD 4
 
 #define I2C_CNFG				0x000
@@ -900,8 +900,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
 		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
 		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
 
-		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-							TEGRA_I2C_TIMEOUT);
+		time_left = wait_for_completion_timeout(
+						&i2c_dev->msg_complete,
+						TEGRA_I2C_TIMEOUT(1000));
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "timed out for bus clear\n");
 			return -ETIMEDOUT;
@@ -928,6 +929,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	u32 *buffer = 0;
 	int ret = 0;
 	bool dma = false;
+	u16 xfer_time = 100;
 
 	if (msg->flags & I2C_M_RD)
 		xfer_size = msg->len;
@@ -935,6 +937,9 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		xfer_size = msg->len + I2C_PACKET_HEADER_SIZE;
 
 	xfer_size = ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
+	xfer_time += DIV_ROUND_CLOSEST((xfer_size * 9) * 1000,
+					i2c_dev->bus_clk_rate);
+
 	dma = i2c_dev->has_dma && (xfer_size > I2C_PIO_MODE_MAX_LEN);
 	if (dma) {
 		if ((msg->flags & I2C_M_RD) && !i2c_dev->rx_dma_chan)
@@ -1071,7 +1076,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (dma) {
 		time_left = wait_for_completion_timeout(
 						&i2c_dev->dma_complete,
-						TEGRA_I2C_TIMEOUT);
+						TEGRA_I2C_TIMEOUT(xfer_time));
 
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
@@ -1094,7 +1099,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	}
 
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-						TEGRA_I2C_TIMEOUT);
+						TEGRA_I2C_TIMEOUT(xfer_time));
 	tegra_i2c_mask_irq(i2c_dev, int_mask);
 
 	if (time_left == 0) {
-- 
2.7.4

