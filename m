Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDD7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B9E2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YjusPo5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBHRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:50:07 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11943 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBHRuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:50:03 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dc1290000>; Fri, 08 Feb 2019 09:49:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 09:50:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 08 Feb 2019 09:50:02 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 17:50:01 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 17:50:01 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 8 Feb 2019 17:50:00 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.121]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5dc1480000>; Fri, 08 Feb 2019 09:50:01 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <wsa@the-dreams.de>, <peda@axentia.se>, <digetx@gmail.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V17 2/6] i2c: tegra: add bus clear Master Support
Date:   Fri, 8 Feb 2019 09:49:51 -0800
Message-ID: <1549648195-3989-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
References: <1549648195-3989-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549648169; bh=VeYpdWzyYO8o9i90elSfQnJfvWMOB1nHB+mLewvUnoM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YjusPo5OBATYz6YUIrhsRmv/MQiIiiiLVLajBPfQBT7FgXqj3tUbYwl3/umTLfyT8
         U/XWphd96Led53052++zJZ9VaeXcEyN4iWXizJFJUGYd1rzKJA+tLU4a1gwy0FyieN
         SXKLesMNcOVzMC3g4jeUJp8J4jwEycee1hDoskkjFd7/fMIH4PuoPo6aQAHvx8MT65
         ZWjfXvnXxgWQmjexkkgy/cpGErTrwZlr6U1gnNXiVgXKnUpTRiwD7iygYE+4I1n7mi
         bCDaNG8hoFXYGNXnI0fN1faq16CtilN4rAyHzrEhR2kJW0poqFKjNWr8dtmVKlMnov
         DpEAI+u69Q90g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bus clear feature of Tegra I2C controller helps to recover from
bus hang when I2C master loses the bus arbitration due to the
slave device holding SDA LOW continuously for some unknown reasons.

Per I2C specification, the device that held the bus LOW should
release it within 9 clock pulses.

During bus clear operation, Tegra I2C controller sends 9 clock
pulses and terminates the transaction with STOP condition.
Upon successful bus clear operation, bus goes to idle state and
driver retries the transaction.

Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V9/V10/V11/V12/V13/V14/V15/V16/V17] : Rebased to 5.0-rc4
 [V5/V6/V7/V8]	  : Same as V4
 [V4]		  : Added I2C Bus Clear support patch to this version of series.


 drivers/i2c/busses/i2c-tegra.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 79c6aa87499b..3758c7a2c781 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -51,6 +51,7 @@
 #define I2C_FIFO_STATUS_RX_SHIFT		0
 #define I2C_INT_MASK				0x064
 #define I2C_INT_STATUS				0x068
+#define I2C_INT_BUS_CLR_DONE			BIT(11)
 #define I2C_INT_PACKET_XFER_COMPLETE		BIT(7)
 #define I2C_INT_ALL_PACKETS_XFER_COMPLETE	BIT(6)
 #define I2C_INT_TX_FIFO_OVERFLOW		BIT(5)
@@ -93,6 +94,15 @@
 #define I2C_HEADER_MASTER_ADDR_SHIFT		12
 #define I2C_HEADER_SLAVE_ADDR_SHIFT		1
 
+#define I2C_BUS_CLEAR_CNFG			0x084
+#define I2C_BC_SCLK_THRESHOLD			9
+#define I2C_BC_SCLK_THRESHOLD_SHIFT		16
+#define I2C_BC_STOP_COND			BIT(2)
+#define I2C_BC_TERMINATE			BIT(1)
+#define I2C_BC_ENABLE				BIT(0)
+#define I2C_BUS_CLEAR_STATUS			0x088
+#define I2C_BC_STATUS				BIT(0)
+
 #define I2C_CONFIG_LOAD				0x08C
 #define I2C_MSTR_CONFIG_LOAD			BIT(0)
 #define I2C_SLV_CONFIG_LOAD			BIT(1)
@@ -154,6 +164,8 @@ enum msg_end_type {
  *		be transferred in one go.
  * @quirks: i2c adapter quirks for limiting write/read transfer size and not
  *		allowing 0 length transfers.
+ * @supports_bus_clear: Bus Clear support to recover from bus hang during
+ *		SDA stuck low from device for some unknown reasons.
  */
 struct tegra_i2c_hw_feature {
 	bool has_continue_xfer_support;
@@ -167,6 +179,7 @@ struct tegra_i2c_hw_feature {
 	bool has_slcg_override_reg;
 	bool has_mst_fifo;
 	const struct i2c_adapter_quirks *quirks;
+	bool supports_bus_clear;
 };
 
 /**
@@ -640,6 +653,13 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 		goto err;
 	}
 
+	/*
+	 * I2C transfer is terminated during the bus clear so skip
+	 * processing the other interrupts.
+	 */
+	if (i2c_dev->hw->supports_bus_clear && (status & I2C_INT_BUS_CLR_DONE))
+		goto err;
+
 	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
 		if (i2c_dev->msg_buf_remaining)
 			tegra_i2c_empty_rx_fifo(i2c_dev);
@@ -668,6 +688,8 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
 		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
 		I2C_INT_RX_FIFO_DATA_REQ);
+	if (i2c_dev->hw->supports_bus_clear)
+		tegra_i2c_mask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
@@ -678,6 +700,43 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
+{
+	int err;
+	unsigned long time_left;
+	u32 reg;
+
+	if (i2c_dev->hw->supports_bus_clear) {
+		reinit_completion(&i2c_dev->msg_complete);
+		reg = (I2C_BC_SCLK_THRESHOLD << I2C_BC_SCLK_THRESHOLD_SHIFT) |
+		      I2C_BC_STOP_COND | I2C_BC_TERMINATE;
+		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
+		if (i2c_dev->hw->has_config_load_reg) {
+			err = tegra_i2c_wait_for_config_load(i2c_dev);
+			if (err)
+				return err;
+		}
+		reg |= I2C_BC_ENABLE;
+		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
+		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
+
+		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
+							TEGRA_I2C_TIMEOUT);
+		if (time_left == 0) {
+			dev_err(i2c_dev->dev, "timed out for bus clear\n");
+			return -ETIMEDOUT;
+		}
+		reg = i2c_readl(i2c_dev, I2C_BUS_CLEAR_STATUS);
+		if (!(reg & I2C_BC_STATUS)) {
+			dev_err(i2c_dev->dev,
+				"un-recovered arbitration lost\n");
+			return -EIO;
+		}
+	}
+
+	return -EAGAIN;
+}
+
 static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	struct i2c_msg *msg, enum msg_end_type end_state)
 {
@@ -759,6 +818,13 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		return 0;
 
 	tegra_i2c_init(i2c_dev);
+	/* start recovery upon arbitration loss in single master mode */
+	if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
+		if (!i2c_dev->is_multimaster_mode)
+			return tegra_i2c_issue_bus_clear(i2c_dev);
+		return -EAGAIN;
+	}
+
 	if (i2c_dev->msg_err == I2C_ERR_NO_ACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
@@ -853,6 +919,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
+	.supports_bus_clear = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -867,6 +934,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
+	.supports_bus_clear = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -881,6 +949,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -895,6 +964,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -909,6 +979,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
@@ -923,6 +994,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = true,
 	.quirks = &tegra194_i2c_quirks,
+	.supports_bus_clear = true,
 };
 
 /* Match table for of_platform binding */
@@ -974,6 +1046,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->base = base;
 	i2c_dev->div_clk = div_clk;
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
+	i2c_dev->adapter.retries = 1;
 	i2c_dev->irq = irq;
 	i2c_dev->cont_id = pdev->id;
 	i2c_dev->dev = &pdev->dev;
-- 
2.7.4

