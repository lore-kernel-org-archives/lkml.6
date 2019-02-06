Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD13C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8CF218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YGbZ8n/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBFTQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:16:30 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11489 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfBFTQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:16:20 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5b32850000>; Wed, 06 Feb 2019 11:16:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 11:16:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 06 Feb 2019 11:16:17 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 19:16:17 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 19:16:17 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Feb 2019 19:16:16 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.121]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5b32800005>; Wed, 06 Feb 2019 11:16:17 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <digetx@gmail.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V14 5/5] i2c: tegra: add i2c interface timing support
Date:   Wed, 6 Feb 2019 11:16:09 -0800
Message-ID: <1549480569-24860-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549480581; bh=AJSlsRHBQSxf5esSEcNsx9YzQYHXRrzeOZrCEX0DAak=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=YGbZ8n/BFc1/p5bRGJTtfKvvA+kahfXLIqHTU1CUGItLGeffxCsROuw4opHnFfAZI
         rGxk6UsAMs6ONPC3ihDTgOASIWiY6budnr6PY6MQqQXLJB2AAwiFUSybThrPknvb/0
         u1q1zA4gBMZ9peOSdL3BeTqlNFFHa/zAG8C4fH9MerKewyfSp41PJ7rqnei0ks7QFF
         KjEgj748wd8NwXBcnqsvt6nqQT8qPQnf/mnvZbfKqsqswwTAABsefVDCGjQCc52SwU
         nEDhU1DSjlimyITAnbA4fEPx2szBRkMkc90lDO14rfea0qwXNQNAzreRm8Ac59szLC
         Ovfn5SOWi4/wA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds I2C interface timing registers support for
proper bus rate configuration along with meeting the i2c spec
setup and hold times based on the tuning performed on Tegra210,
Tegra186 and Tegra194 platforms.

I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
and Tegra I2C controller design uses them as a part of internal
clock divisor.

I2C_INTERFACE_TIMING_1 register contains the setup and hold times
for start and stop conditions.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V14]		: INTERFACE_TIMING registers doesnt exist on Tegra114 and prior.
		  Added flag to hw feature to identify this and program only on supported
		  tegra chips.
 [V13]		: Same as V12
 [V12] 		: Fixed strict coding style check issues
 [V9/V10/V11]	: Same as V8
 [V8] 		: Updated to handle timing implementation within tegra_i2c_init directly
 [V7] 		: Minor updates to timing implementation
 [V5/V6] 	: Added this Interface timing patch in V5 of the patch series.


 drivers/i2c/busses/i2c-tegra.c | 200 +++++++++++++++++++++++++++++++++++------
 1 file changed, 171 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index e7abf82f4ee9..7921d3e6237d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -128,6 +128,15 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+#define I2C_INTERFACE_TIMING_0			0x94
+#define I2C_THIGH_SHIFT				8
+#define I2C_INTERFACE_TIMING_1			0x98
+
+#define I2C_STANDARD_MODE			100000
+#define I2C_FAST_MODE				400000
+#define I2C_FAST_PLUS_MODE			1000000
+#define I2C_HS_MODE				3500000
+
 /* Packet header size in bytes */
 #define I2C_PACKET_HEADER_SIZE			12
 
@@ -162,7 +171,10 @@ enum msg_end_type {
  * @has_config_load_reg: Has the config load register to load the new
  *		configuration.
  * @clk_divisor_hs_mode: Clock divisor in HS mode.
- * @clk_divisor_std_fast_mode: Clock divisor in standard/fast mode. It is
+ * @clk_divisor_std_mode: Clock divisor in standard mode. It is
+ *		applicable if there is no fast clock source i.e. single clock
+ *		source.
+ * @clk_divisor_fast_mode: Clock divisor in fast mode. It is
  *		applicable if there is no fast clock source i.e. single clock
  *		source.
  * @clk_divisor_fast_plus_mode: Clock divisor in fast mode plus. It is
@@ -180,6 +192,18 @@ enum msg_end_type {
  * @supports_bus_clear: Bus Clear support to recover from bus hang during
  *		SDA stuck low from device for some unknown reasons.
  * @has_apb_dma: Support of APBDMA on corresponding Tegra chip.
+ * @tlow_std_mode: Low period of the clock in standard mode.
+ * @thigh_std_mode: High period of the clock in standard mode.
+ * @tlow_fast_fastplus_mode: Low period of the clock in fast/fast-plus modes.
+ * @thigh_fast_fastplus_mode: High period of the clock in fast/fast-plus modes.
+ * @setup_hold_time_std_mode: Setup and hold time for start and stop conditions
+ *		in standard mode.
+ * @setup_hold_time_fast_fast_plus_mode: Setup and hold time for start and stop
+ *		conditions in fast/fast-plus modes.
+ * @setup_hold_time_hs_mode: Setup and hold time for start and stop conditions
+ *		in HS mode.
+ * @has_interface_timing_reg: Has interface timing register to program the tuned
+ *		timing settings.
  */
 struct tegra_i2c_hw_feature {
 	bool has_continue_xfer_support;
@@ -187,7 +211,8 @@ struct tegra_i2c_hw_feature {
 	bool has_single_clk_source;
 	bool has_config_load_reg;
 	int clk_divisor_hs_mode;
-	int clk_divisor_std_fast_mode;
+	int clk_divisor_std_mode;
+	int clk_divisor_fast_mode;
 	u16 clk_divisor_fast_plus_mode;
 	bool has_multi_master_mode;
 	bool has_slcg_override_reg;
@@ -195,6 +220,14 @@ struct tegra_i2c_hw_feature {
 	const struct i2c_adapter_quirks *quirks;
 	bool supports_bus_clear;
 	bool has_apb_dma;
+	u8 tlow_std_mode;
+	u8 thigh_std_mode;
+	u8 tlow_fast_fastplus_mode;
+	u8 thigh_fast_fastplus_mode;
+	u32 setup_hold_time_std_mode;
+	u32 setup_hold_time_fast_fast_plus_mode;
+	u32 setup_hold_time_hs_mode;
+	bool has_interface_timing_reg;
 };
 
 /**
@@ -662,11 +695,13 @@ static int tegra_i2c_wait_for_config_load(struct tegra_i2c_dev *i2c_dev)
 	return 0;
 }
 
-static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
+static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev, bool clk_reinit)
 {
 	u32 val;
 	int err;
-	u32 clk_divisor;
+	u32 clk_divisor, clk_multiplier;
+	u32 tsu_thd = 0;
+	u8 tlow, thigh;
 
 	err = pm_runtime_get_sync(i2c_dev->dev);
 	if (err < 0) {
@@ -696,6 +731,37 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 					I2C_CLK_DIVISOR_STD_FAST_MODE_SHIFT;
 	i2c_writel(i2c_dev, clk_divisor, I2C_CLK_DIVISOR);
 
+	if (i2c_dev->bus_clk_rate > I2C_STANDARD_MODE &&
+	    i2c_dev->bus_clk_rate <= I2C_FAST_PLUS_MODE) {
+		tlow = i2c_dev->hw->tlow_fast_fastplus_mode;
+		thigh = i2c_dev->hw->thigh_fast_fastplus_mode;
+		tsu_thd = i2c_dev->hw->setup_hold_time_fast_fast_plus_mode;
+	} else {
+		tlow = i2c_dev->hw->tlow_std_mode;
+		thigh = i2c_dev->hw->thigh_std_mode;
+		tsu_thd = i2c_dev->hw->setup_hold_time_std_mode;
+	}
+
+	if (i2c_dev->hw->has_interface_timing_reg && val) {
+		val = (thigh << I2C_THIGH_SHIFT) | tlow;
+		i2c_writel(i2c_dev, val, I2C_INTERFACE_TIMING_0);
+	}
+
+	if (i2c_dev->hw->has_interface_timing_reg && tsu_thd)
+		i2c_writel(i2c_dev, tsu_thd, I2C_INTERFACE_TIMING_1);
+
+	if (!clk_reinit) {
+		clk_multiplier = (tlow + thigh + 2);
+		clk_multiplier *= (i2c_dev->clk_divisor_non_hs_mode + 1);
+		err = clk_set_rate(i2c_dev->div_clk,
+				   i2c_dev->bus_clk_rate * clk_multiplier);
+		if (err) {
+			dev_err(i2c_dev->dev,
+				"failed changing clock rate: %d\n", err);
+			goto err;
+		}
+	}
+
 	if (!i2c_dev->is_dvc) {
 		u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
 
@@ -1104,7 +1170,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 			dmaengine_terminate_sync(i2c_dev->msg_read ?
 						  i2c_dev->rx_dma_chan :
 						  i2c_dev->tx_dma_chan);
-			tegra_i2c_init(i2c_dev);
+			tegra_i2c_init(i2c_dev, true);
 			return -ETIMEDOUT;
 		}
 
@@ -1132,7 +1198,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
 
-		tegra_i2c_init(i2c_dev);
+		tegra_i2c_init(i2c_dev, true);
 		return -ETIMEDOUT;
 	}
 
@@ -1144,7 +1210,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
 		return 0;
 
-	tegra_i2c_init(i2c_dev);
+	tegra_i2c_init(i2c_dev, true);
 	/* start recovery upon arbitration loss in single master mode */
 	if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
 		if (!i2c_dev->is_multimaster_mode)
@@ -1239,7 +1305,8 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = false,
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
-	.clk_divisor_std_fast_mode = 0,
+	.clk_divisor_std_mode = 0,
+	.clk_divisor_fast_mode = 0,
 	.clk_divisor_fast_plus_mode = 0,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1248,6 +1315,14 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = false,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
+	.has_interface_timing_reg = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -1255,7 +1330,8 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = false,
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
-	.clk_divisor_std_fast_mode = 0,
+	.clk_divisor_std_mode = 0,
+	.clk_divisor_fast_mode = 0,
 	.clk_divisor_fast_plus_mode = 0,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1264,6 +1340,14 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = false,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
+	.has_interface_timing_reg = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -1271,7 +1355,8 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1280,6 +1365,14 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
+	.has_interface_timing_reg = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -1287,7 +1380,8 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = false,
@@ -1296,6 +1390,14 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
+	.has_interface_timing_reg = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -1303,7 +1405,8 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = true,
@@ -1312,27 +1415,70 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0,
+	.setup_hold_time_fast_fast_plus_mode = 0,
+	.setup_hold_time_hs_mode = 0,
+	.has_interface_timing_reg = true,
 };
 
-static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
+static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
 	.has_continue_xfer_support = true,
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x16,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = true,
+	.quirks = &tegra_i2c_quirks,
+	.supports_bus_clear = true,
+	.has_apb_dma = false,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x3,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0,
+	.setup_hold_time_fast_fast_plus_mode = 0,
+	.setup_hold_time_hs_mode = 0,
+	.has_interface_timing_reg = true,
+};
+
+static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
+	.has_continue_xfer_support = true,
+	.has_per_pkt_xfer_complete_irq = true,
+	.has_single_clk_source = true,
+	.clk_divisor_hs_mode = 1,
+	.clk_divisor_std_mode = 0x4f,
+	.clk_divisor_fast_mode = 0x3c,
+	.clk_divisor_fast_plus_mode = 0x16,
+	.has_config_load_reg = true,
+	.has_multi_master_mode = true,
+	.has_slcg_override_reg = true,
+	.has_mst_fifo = true,
 	.quirks = &tegra194_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = false,
+	.tlow_std_mode = 0x8,
+	.thigh_std_mode = 0x7,
+	.tlow_fast_fastplus_mode = 0x2,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x08080808,
+	.setup_hold_time_fast_fast_plus_mode = 0x02020202,
+	.setup_hold_time_hs_mode = 0x090909,
+	.has_interface_timing_reg = true,
 };
 
 /* Match table for of_platform binding */
 static const struct of_device_id tegra_i2c_of_match[] = {
 	{ .compatible = "nvidia,tegra194-i2c", .data = &tegra194_i2c_hw, },
+	{ .compatible = "nvidia,tegra186-i2c", .data = &tegra186_i2c_hw, },
 	{ .compatible = "nvidia,tegra210-i2c", .data = &tegra210_i2c_hw, },
 	{ .compatible = "nvidia,tegra124-i2c", .data = &tegra124_i2c_hw, },
 	{ .compatible = "nvidia,tegra114-i2c", .data = &tegra114_i2c_hw, },
@@ -1353,7 +1499,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	phys_addr_t base_phys;
 	int irq;
 	int ret = 0;
-	int clk_multiplier = I2C_CLK_MULTIPLIER_STD_FAST_MODE;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base_phys = res->start;
@@ -1424,20 +1569,17 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
-	i2c_dev->clk_divisor_non_hs_mode =
-			i2c_dev->hw->clk_divisor_std_fast_mode;
-	if (i2c_dev->hw->clk_divisor_fast_plus_mode &&
-		(i2c_dev->bus_clk_rate == 1000000))
+	if (i2c_dev->bus_clk_rate > I2C_FAST_MODE &&
+	    i2c_dev->bus_clk_rate <= I2C_FAST_PLUS_MODE)
 		i2c_dev->clk_divisor_non_hs_mode =
-			i2c_dev->hw->clk_divisor_fast_plus_mode;
-
-	clk_multiplier *= (i2c_dev->clk_divisor_non_hs_mode + 1);
-	ret = clk_set_rate(i2c_dev->div_clk,
-			   i2c_dev->bus_clk_rate * clk_multiplier);
-	if (ret) {
-		dev_err(i2c_dev->dev, "Clock rate change failed %d\n", ret);
-		goto unprepare_fast_clk;
-	}
+				i2c_dev->hw->clk_divisor_fast_plus_mode;
+	else if (i2c_dev->bus_clk_rate > I2C_STANDARD_MODE &&
+		 i2c_dev->bus_clk_rate <= I2C_FAST_MODE)
+		i2c_dev->clk_divisor_non_hs_mode =
+				i2c_dev->hw->clk_divisor_fast_mode;
+	else
+		i2c_dev->clk_divisor_non_hs_mode =
+				i2c_dev->hw->clk_divisor_std_mode;
 
 	ret = clk_prepare(i2c_dev->div_clk);
 	if (ret < 0) {
@@ -1467,7 +1609,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto disable_div_clk;
 
-	ret = tegra_i2c_init(i2c_dev);
+	ret = tegra_i2c_init(i2c_dev, false);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
 		goto disable_div_clk;
-- 
2.7.4

