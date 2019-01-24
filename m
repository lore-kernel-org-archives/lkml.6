Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28780C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E18218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YRwp2C/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfAXUwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:52:12 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13927 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfAXUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:52:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4a25580000>; Thu, 24 Jan 2019 12:51:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 12:52:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 24 Jan 2019 12:52:01 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 20:52:01 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 20:52:00 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4a25710000>; Thu, 24 Jan 2019 12:52:01 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 4/4] i2c: tegra: Update transfer timeout
Date:   Thu, 24 Jan 2019 12:51:53 -0800
Message-ID: <1548363113-25969-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548363096; bh=LEx3nM21hkfe6apUv9Ihl4Psnny7++BBTj8eL2R3fJg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YRwp2C/BxC1HjlBh+lvtQtJqNL0SOBK/peYoPoyn5YGaiU3yjTMgAVLe2Mi65QQ7L
         8DuroAEi95yPLUdYFVv0aoDwXBdOTtwslaxMmrI/xNWIBPOSOGrBi5MyHnfbZmnzkD
         PNloOpCcEOMNPRMTe5kiIM01vXtdMExQ7m/fCwMBtZ3W7owq07fHA2+e5J8QxSdDBe
         MQqeNoXDX6mHKvkpw3Nj0mu35EJoQ5J2oamwQUIUNsiQKLNjozZYTDCyQqLViM3YbR
         DFBJYyt9XVHkoO3zp8hryWxKaCBkp5BSxjlvC7sdmngIesFp/pFAKcXe7O4WL5pWmT
         mApS+Lc4hF27w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update I2C transfer timeout based on transfer bytes and I2C bus
rate to allow enough time during max transfer size based on the
speed.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V2] : Added this patch in V2 series to allow enough time for data transfer
	to happen.
	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
	takes argument with this patch.

 drivers/i2c/busses/i2c-tegra.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 769700d5a7f3..2f8de837f660 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -27,7 +27,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
+#define TEGRA_I2C_TIMEOUT(ms) (msecs_to_jiffies(ms))
 #define BYTES_PER_FIFO_WORD 4
 
 #define I2C_CNFG				0x000
@@ -857,7 +857,8 @@ static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
 	dmaengine_slave_config(chan, &dma_sconfig);
 }
 
-static int tegra_i2c_start_dma_xfer(struct tegra_i2c_dev *i2c_dev)
+static int tegra_i2c_start_dma_xfer(struct tegra_i2c_dev *i2c_dev,
+				    u16 xfer_time)
 {
 	u32 *buffer = (u32 *)i2c_dev->msg_buf;
 	unsigned long time_left, flags;
@@ -929,7 +930,7 @@ static int tegra_i2c_start_dma_xfer(struct tegra_i2c_dev *i2c_dev)
 		i2c_readl(i2c_dev, I2C_INT_MASK));
 
 	time_left = wait_for_completion_timeout(&i2c_dev->dma_complete,
-						TEGRA_I2C_TIMEOUT);
+						TEGRA_I2C_TIMEOUT(xfer_time));
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "DMA transfer timeout\n");
 		dmaengine_terminate_all(chan);
@@ -995,6 +996,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	int ret = 0;
 	size_t xfer_size = 0;
 	bool dma = false;
+	u16 xfer_time = 100;
 
 	buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
 			 I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
@@ -1012,6 +1014,9 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 
 	i2c_dev->is_curr_dma_xfer = dma;
 
+	xfer_time += DIV_ROUND_CLOSEST((xfer_size * 9) * 1000,
+					i2c_dev->bus_clk_rate);
+
 	tegra_i2c_flush_fifos(i2c_dev);
 
 	i2c_dev->msg_buf = (u8 *)buffer;
@@ -1048,7 +1053,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		memcpy(buffer, msg->buf, msg->len);
 
 	if (dma)
-		ret = tegra_i2c_start_dma_xfer(i2c_dev);
+		ret = tegra_i2c_start_dma_xfer(i2c_dev, xfer_time);
 	else
 		ret = tegra_i2c_start_pio_xfer(i2c_dev);
 
@@ -1058,7 +1063,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		goto end_xfer;
 
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
-						TEGRA_I2C_TIMEOUT);
+						TEGRA_I2C_TIMEOUT(xfer_time));
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
 		if (i2c_dev->is_curr_dma_xfer) {
-- 
2.7.4

