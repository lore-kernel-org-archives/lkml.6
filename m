Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fUXOC7xnGVtnGAAAmS7hNA
	; Thu, 07 Jun 2018 17:27:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 215326074D; Thu,  7 Jun 2018 17:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528392450;
	bh=PmUm10j/pl5UStIMC9YbPI1JeAGZRqs3tE6SxFtxMMY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=P2f2BNStD/M2uWpmzHgNmqqbo2sKTZGdehS9DzSrN+CsQRIBXhuWo6cIF4BokXYB4
	 ulRWDt+KDnij2EHwE7KW6wGy/9bZx2SFlxpaosZVF4E71ChM+P1CZxYR+E2+hWN17v
	 zZL2zZX4mo7/9iB34tfBV3oEBhkL0ex9FDldK/sY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AF89260115;
	Thu,  7 Jun 2018 17:27:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U9fMFBJA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NPhfauQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF89260115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934673AbeFGR11 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:27:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933431AbeFGR1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:27:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 536FC60115; Thu,  7 Jun 2018 17:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528392443;
        bh=PmUm10j/pl5UStIMC9YbPI1JeAGZRqs3tE6SxFtxMMY=;
        h=From:To:Cc:Subject:Date:From;
        b=U9fMFBJA+KnshD4/RAjlzO//WTbWp5ccm3u7SdJZhwfVxhO9nUmu8QCt6cboj/kFD
         9OuifU1DvvBELZl0OYuCik6h5+3gGGkwU31ZTgjLsbxGFUOj2f91mmwDOQKaR0wiuX
         P/hWC0AzfmKQ2oCROfn038+USjIi+LoV1cQLfec4=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26201601B4;
        Thu,  7 Jun 2018 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528392441;
        bh=PmUm10j/pl5UStIMC9YbPI1JeAGZRqs3tE6SxFtxMMY=;
        h=From:To:Cc:Subject:Date:From;
        b=NPhfauQ/OnWFm/aLq+fwga/y4yNecVgGGt57dkEliJZQcFpe3d2Zf+t+bLikU0I6B
         lvdd9XdL7UbVRT3Q9aBUscnCt4f88ZozzFb2EvUx1yHK/e2T/ReyZmpTKSJuDoVyHD
         kDG+33SBKg2StD2mHUAT9JFhDniRqmXhS7pzv+9k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26201601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: vkoul@kernel.org, bjorn.andersson@linaro.org, ohad@wizery.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V2] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
Date: Thu,  7 Jun 2018 22:57:11 +0530
Message-Id: <1528392431-14172-1-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has an integrated Hexagon dsp core q6v5 and a wireless lan
(Lithium) IP. An mdt type single image format is used for the
firmware. So the mdt_load function can be directly used to load
the firmware. Also add the relevant resets required for this core.

Acked-by: Rob Herring <robh@kernel.org> (bindings)
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[bjorn: Rewrote as a separate driver, intead of extending q6v5_pil.c]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
  [v2] Fixed Kconfig to remove SMD dependency and addressed
       Vinod's comments.

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |   7 +-
 drivers/remoteproc/Kconfig                         |  15 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/qcom_q6v5_wcss.c                | 601 +++++++++++++++++++++
 4 files changed, 623 insertions(+), 1 deletion(-)
 create mode 100644 drivers/remoteproc/qcom_q6v5_wcss.c

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 00d3d58..d52d05e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -11,6 +11,7 @@ on the Qualcomm Hexagon core.
 		    "qcom,msm8916-mss-pil",
 		    "qcom,msm8974-mss-pil"
 		    "qcom,msm8996-mss-pil"
+		    "qcom,ipq8074-wcss-pil"
 
 - reg:
 	Usage: required
@@ -49,11 +50,15 @@ on the Qualcomm Hexagon core.
 	Usage: required
 	Value type: <phandle>
 	Definition: reference to the reset-controller for the modem sub-system
+		    reference to the list of 3 reset-controllers for the
+		    wcss sub-system
 
 - reset-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "mss_restart"
+	Definition: must be "mss_restart" for the modem sub-system
+	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
+		    for the wcss syb-system
 
 - cx-supply:
 - mss-supply:
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index be76619..93e9f83 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -123,6 +123,21 @@ config QCOM_Q6V5_PIL
 	  Say y here to support the Qualcomm Peripherial Image Loader for the
 	  Hexagon V5 based remote processors.
 
+config QCOM_Q6V5_WCSS
+	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
+	depends on OF && ARCH_QCOM
+	depends on QCOM_SMEM
+	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
+	depends on QCOM_SYSMON || QCOM_SYSMON=n
+	select MFD_SYSCON
+	select QCOM_MDT_LOADER
+	select QCOM_Q6V5_COMMON
+	select QCOM_RPROC_COMMON
+	select QCOM_SCM
+	help
+	  Say y here to support the Qualcomm Peripheral Image Loader for the
+	  Hexagon V5 based WCSS remote processors.
+
 config QCOM_SYSMON
 	tristate "Qualcomm sysmon driver"
 	depends on RPMSG
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 5dd0249..03332fa 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_QCOM_ADSP_PIL)		+= qcom_adsp_pil.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
 obj-$(CONFIG_QCOM_Q6V5_PIL)		+= qcom_q6v5_pil.o
+obj-$(CONFIG_QCOM_Q6V5_WCSS)		+= qcom_q6v5_wcss.o
 obj-$(CONFIG_QCOM_SYSMON)		+= qcom_sysmon.o
 obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
 qcom_wcnss_pil-y			+= qcom_wcnss.o
diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
new file mode 100644
index 0000000..f93e1e4
--- /dev/null
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016-2018 Linaro Ltd.
+ * Copyright (C) 2014 Sony Mobile Communications AB
+ * Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ */
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/soc/qcom/mdt_loader.h>
+#include "qcom_common.h"
+#include "qcom_q6v5.h"
+
+#define WCSS_CRASH_REASON		421
+
+/* Q6SS Register Offsets */
+#define Q6SS_RESET_REG		0x014
+#define Q6SS_GFMUX_CTL_REG		0x020
+#define Q6SS_PWR_CTL_REG		0x030
+#define Q6SS_MEM_PWR_CTL		0x0B0
+
+/* AXI Halt Register Offsets */
+#define AXI_HALTREQ_REG			0x0
+#define AXI_HALTACK_REG			0x4
+#define AXI_IDLE_REG			0x8
+
+#define HALT_ACK_TIMEOUT_MS		100
+
+/* Q6SS_RESET */
+#define Q6SS_STOP_CORE			BIT(0)
+#define Q6SS_CORE_ARES			BIT(1)
+#define Q6SS_BUS_ARES_ENABLE		BIT(2)
+
+/* Q6SS_GFMUX_CTL */
+#define Q6SS_CLK_ENABLE			BIT(1)
+
+/* Q6SS_PWR_CTL */
+#define Q6SS_L2DATA_STBY_N		BIT(18)
+#define Q6SS_SLP_RET_N			BIT(19)
+#define Q6SS_CLAMP_IO			BIT(20)
+#define QDSS_BHS_ON			BIT(21)
+
+/* Q6SS parameters */
+#define Q6SS_LDO_BYP		BIT(25)
+#define Q6SS_BHS_ON		BIT(24)
+#define Q6SS_CLAMP_WL		BIT(21)
+#define Q6SS_CLAMP_QMC_MEM		BIT(22)
+#define HALT_CHECK_MAX_LOOPS		200
+#define Q6SS_XO_CBCR		GENMASK(5, 3)
+
+/* Q6SS config/status registers */
+#define TCSR_GLOBAL_CFG0	0x0
+#define TCSR_GLOBAL_CFG1	0x4
+#define SSCAON_CONFIG		0x8
+#define SSCAON_STATUS		0xc
+#define Q6SS_BHS_STATUS		0x78
+#define Q6SS_RST_EVB		0x10
+
+#define BHS_EN_REST_ACK		BIT(0)
+#define SSCAON_ENABLE		BIT(13)
+#define SSCAON_BUS_EN		BIT(15)
+#define SSCAON_BUS_MUX_MASK	GENMASK(18, 16)
+
+#define MEM_BANKS		19
+#define TCSR_WCSS_CLK_MASK	0x1F
+#define TCSR_WCSS_CLK_ENABLE	0x14
+
+struct q6v5_wcss {
+	struct device *dev;
+
+	void __iomem *reg_base;
+	void __iomem *rmb_base;
+
+	struct regmap *halt_map;
+	u32 halt_q6;
+	u32 halt_wcss;
+	u32 halt_nc;
+
+	struct reset_control *wcss_aon_reset;
+	struct reset_control *wcss_reset;
+	struct reset_control *wcss_q6_reset;
+
+	struct qcom_q6v5 q6v5;
+
+	phys_addr_t mem_phys;
+	phys_addr_t mem_reloc;
+	void *mem_region;
+	size_t mem_size;
+};
+
+static int q6v5_wcss_reset(struct q6v5_wcss *wcss)
+{
+	int ret;
+	u32 val;
+	int i;
+
+	/* Assert resets, stop core */
+	val = readl(wcss->reg_base + Q6SS_RESET_REG);
+	val |= Q6SS_CORE_ARES | Q6SS_BUS_ARES_ENABLE | Q6SS_STOP_CORE;
+	writel(val, wcss->reg_base + Q6SS_RESET_REG);
+
+	/* BHS require xo cbcr to be enabled */
+	val = readl(wcss->reg_base + Q6SS_XO_CBCR);
+	val |= 0x1;
+	writel(val, wcss->reg_base + Q6SS_XO_CBCR);
+
+	/* Read CLKOFF bit to go low indicating CLK is enabled */
+	ret = readl_poll_timeout(wcss->reg_base + Q6SS_XO_CBCR,
+				 val, !(val & BIT(31)), 1,
+				 HALT_CHECK_MAX_LOOPS);
+	if (ret) {
+		dev_err(wcss->dev,
+			"xo cbcr enabling timed out (rc:%d)\n", ret);
+		return ret;
+	}
+	/* Enable power block headswitch and wait for it to stabilize */
+	val = readl(wcss->reg_base + Q6SS_PWR_CTL_REG);
+	val |= Q6SS_BHS_ON;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+	udelay(1);
+
+	/* Put LDO in bypass mode */
+	val |= Q6SS_LDO_BYP;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* Deassert Q6 compiler memory clamp */
+	val = readl(wcss->reg_base + Q6SS_PWR_CTL_REG);
+	val &= ~Q6SS_CLAMP_QMC_MEM;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* Deassert memory peripheral sleep and L2 memory standby */
+	val |= Q6SS_L2DATA_STBY_N | Q6SS_SLP_RET_N;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* Turn on L1, L2, ETB and JU memories 1 at a time */
+	val = readl(wcss->reg_base + Q6SS_MEM_PWR_CTL);
+	for (i = MEM_BANKS; i >= 0; i--) {
+		val |= BIT(i);
+		writel(val, wcss->reg_base + Q6SS_MEM_PWR_CTL);
+		/*
+		 * Read back value to ensure the write is done then
+		 * wait for 1us for both memory peripheral and data
+		 * array to turn on.
+		 */
+		val |= readl(wcss->reg_base + Q6SS_MEM_PWR_CTL);
+		udelay(1);
+	}
+	/* Remove word line clamp */
+	val = readl(wcss->reg_base + Q6SS_PWR_CTL_REG);
+	val &= ~Q6SS_CLAMP_WL;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* Remove IO clamp */
+	val &= ~Q6SS_CLAMP_IO;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* Bring core out of reset */
+	val = readl(wcss->reg_base + Q6SS_RESET_REG);
+	val &= ~Q6SS_CORE_ARES;
+	writel(val, wcss->reg_base + Q6SS_RESET_REG);
+
+	/* Turn on core clock */
+	val = readl(wcss->reg_base + Q6SS_GFMUX_CTL_REG);
+	val |= Q6SS_CLK_ENABLE;
+	writel(val, wcss->reg_base + Q6SS_GFMUX_CTL_REG);
+
+	/* Start core execution */
+	val = readl(wcss->reg_base + Q6SS_RESET_REG);
+	val &= ~Q6SS_STOP_CORE;
+	writel(val, wcss->reg_base + Q6SS_RESET_REG);
+
+	return 0;
+}
+
+static int q6v5_wcss_start(struct rproc *rproc)
+{
+	struct q6v5_wcss *wcss = rproc->priv;
+	int ret;
+
+	qcom_q6v5_prepare(&wcss->q6v5);
+
+	/* Release Q6 and WCSS reset */
+	ret = reset_control_deassert(wcss->wcss_reset);
+	if (ret) {
+		dev_err(wcss->dev, "wcss_reset failed\n");
+		return ret;
+	}
+
+	ret = reset_control_deassert(wcss->wcss_q6_reset);
+	if (ret) {
+		dev_err(wcss->dev, "wcss_q6_reset failed\n");
+		goto wcss_reset;
+	}
+
+	/* Lithium configuration - clock gating and bus arbitration */
+	ret = regmap_update_bits(wcss->halt_map,
+				 wcss->halt_nc + TCSR_GLOBAL_CFG0,
+				 TCSR_WCSS_CLK_MASK,
+				 TCSR_WCSS_CLK_ENABLE);
+	if (ret)
+		goto wcss_q6_reset;
+
+	ret = regmap_update_bits(wcss->halt_map,
+				 wcss->halt_nc + TCSR_GLOBAL_CFG1,
+				 1, 0);
+	if (ret)
+		goto wcss_q6_reset;
+
+	/* Write bootaddr to EVB so that Q6WCSS will jump there after reset */
+	writel(rproc->bootaddr >> 4, wcss->reg_base + Q6SS_RST_EVB);
+
+	ret = q6v5_wcss_reset(wcss);
+	if (ret)
+		goto wcss_q6_reset;
+
+	ret = qcom_q6v5_wait_for_start(&wcss->q6v5, 5 * HZ);
+	if (ret == -ETIMEDOUT)
+		dev_err(wcss->dev, "start timed out\n");
+
+	return ret;
+
+wcss_q6_reset:
+	reset_control_assert(wcss->wcss_q6_reset);
+
+wcss_reset:
+	reset_control_assert(wcss->wcss_reset);
+
+	return ret;
+}
+
+static void q6v5_wcss_halt_axi_port(struct q6v5_wcss *wcss,
+				    struct regmap *halt_map,
+				    u32 offset)
+{
+	unsigned long timeout;
+	unsigned int val;
+	int ret;
+
+	/* Check if we're already idle */
+	ret = regmap_read(halt_map, offset + AXI_IDLE_REG, &val);
+	if (!ret && val)
+		return;
+
+	/* Assert halt request */
+	regmap_write(halt_map, offset + AXI_HALTREQ_REG, 1);
+
+	/* Wait for halt */
+	timeout = jiffies + msecs_to_jiffies(HALT_ACK_TIMEOUT_MS);
+	for (;;) {
+		ret = regmap_read(halt_map, offset + AXI_HALTACK_REG, &val);
+		if (ret || val || time_after(jiffies, timeout))
+			break;
+
+		msleep(1);
+	}
+
+	ret = regmap_read(halt_map, offset + AXI_IDLE_REG, &val);
+	if (ret || !val)
+		dev_err(wcss->dev, "port failed halt\n");
+
+	/* Clear halt request (port will remain halted until reset) */
+	regmap_write(halt_map, offset + AXI_HALTREQ_REG, 0);
+}
+
+static int q6v5_wcss_powerdown(struct q6v5_wcss *wcss)
+{
+	int ret;
+	u32 val;
+
+	/* 1 - Assert WCSS/Q6 HALTREQ */
+	q6v5_wcss_halt_axi_port(wcss, wcss->halt_map, wcss->halt_wcss);
+
+	/* 2 - Enable WCSSAON_CONFIG */
+	val = readl(wcss->rmb_base + SSCAON_CONFIG);
+	val |= SSCAON_ENABLE;
+	writel(val, wcss->rmb_base + SSCAON_CONFIG);
+
+	/* 3 - Set SSCAON_CONFIG */
+	val |= SSCAON_BUS_EN;
+	val &= ~SSCAON_BUS_MUX_MASK;
+	writel(val, wcss->rmb_base + SSCAON_CONFIG);
+
+	/* 4 - SSCAON_CONFIG 1 */
+	val |= BIT(1);
+	writel(val, wcss->rmb_base + SSCAON_CONFIG);
+
+	/* 5 - wait for SSCAON_STATUS */
+	ret = readl_poll_timeout(wcss->rmb_base + SSCAON_STATUS,
+				 val, (val & 0xffff) == 0x400, 1000,
+				 HALT_CHECK_MAX_LOOPS);
+	if (ret) {
+		dev_err(wcss->dev,
+			"can't get SSCAON_STATUS rc:%d)\n", ret);
+		return ret;
+	}
+
+	/* 6 - De-assert WCSS_AON reset */
+	reset_control_assert(wcss->wcss_aon_reset);
+
+	/* 7 - Disable WCSSAON_CONFIG 13 */
+	val = readl(wcss->rmb_base + SSCAON_CONFIG);
+	val &= ~SSCAON_ENABLE;
+	writel(val, wcss->rmb_base + SSCAON_CONFIG);
+
+	/* 8 - De-assert WCSS/Q6 HALTREQ */
+	reset_control_assert(wcss->wcss_reset);
+
+	return 0;
+}
+
+static int q6v5_q6_powerdown(struct q6v5_wcss *wcss)
+{
+	int ret;
+	u32 val;
+	int i;
+
+	/* 1 - Halt Q6 bus interface */
+	q6v5_wcss_halt_axi_port(wcss, wcss->halt_map, wcss->halt_q6);
+
+	/* 2 - Disable Q6 Core clock */
+	val = readl(wcss->reg_base + Q6SS_GFMUX_CTL_REG);
+	val &= ~Q6SS_CLK_ENABLE;
+	writel(val, wcss->reg_base + Q6SS_GFMUX_CTL_REG);
+
+	/* 3 - Clamp I/O */
+	val = readl(wcss->reg_base + Q6SS_PWR_CTL_REG);
+	val |= Q6SS_CLAMP_IO;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* 4 - Clamp WL */
+	val |= QDSS_BHS_ON;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* 5 - Clear Erase standby */
+	val &= ~Q6SS_L2DATA_STBY_N;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* 6 - Clear Sleep RTN */
+	val &= ~Q6SS_SLP_RET_N;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* 7 - turn off Q6 memory foot/head switch one bank at a time */
+	for (i = 0; i < 20; i++) {
+		val = readl(wcss->reg_base + Q6SS_MEM_PWR_CTL);
+		val &= ~BIT(i);
+		writel(val, wcss->reg_base + Q6SS_MEM_PWR_CTL);
+		mdelay(1);
+	}
+
+	/* 8 - Assert QMC memory RTN */
+	val = readl(wcss->reg_base + Q6SS_PWR_CTL_REG);
+	val |= Q6SS_CLAMP_QMC_MEM;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+
+	/* 9 - Turn off BHS */
+	val &= ~Q6SS_BHS_ON;
+	writel(val, wcss->reg_base + Q6SS_PWR_CTL_REG);
+	udelay(1);
+
+	/* 10 - Wait till BHS Reset is done */
+	ret = readl_poll_timeout(wcss->reg_base + Q6SS_BHS_STATUS,
+				 val, !(val & BHS_EN_REST_ACK), 1000,
+				 HALT_CHECK_MAX_LOOPS);
+	if (ret) {
+		dev_err(wcss->dev, "BHS_STATUS not OFF (rc:%d)\n", ret);
+		return ret;
+	}
+
+	/* 11 -  Assert WCSS reset */
+	reset_control_assert(wcss->wcss_reset);
+
+	/* 12 - Assert Q6 reset */
+	reset_control_assert(wcss->wcss_q6_reset);
+
+	return 0;
+}
+
+static int q6v5_wcss_stop(struct rproc *rproc)
+{
+	struct q6v5_wcss *wcss = rproc->priv;
+	int ret;
+
+	/* WCSS powerdown */
+	ret = qcom_q6v5_request_stop(&wcss->q6v5);
+	if (ret == -ETIMEDOUT) {
+		dev_err(wcss->dev, "timed out on wait\n");
+		return ret;
+	}
+
+	ret = q6v5_wcss_powerdown(wcss);
+	if (ret)
+		return ret;
+
+	/* Q6 Power down */
+	ret = q6v5_q6_powerdown(wcss);
+	if (ret)
+		return ret;
+
+	qcom_q6v5_unprepare(&wcss->q6v5);
+
+	return 0;
+}
+
+static void *q6v5_wcss_da_to_va(struct rproc *rproc, u64 da, int len)
+{
+	struct q6v5_wcss *wcss = rproc->priv;
+	int offset;
+
+	offset = da - wcss->mem_reloc;
+	if (offset < 0 || offset + len > wcss->mem_size)
+		return NULL;
+
+	return wcss->mem_region + offset;
+}
+
+static int q6v5_wcss_load(struct rproc *rproc, const struct firmware *fw)
+{
+	struct q6v5_wcss *wcss = rproc->priv;
+
+	return qcom_mdt_load_no_init(wcss->dev, fw, rproc->firmware,
+				     0, wcss->mem_region, wcss->mem_phys,
+				     wcss->mem_size, &wcss->mem_reloc);
+}
+
+static const struct rproc_ops q6v5_wcss_ops = {
+	.start = q6v5_wcss_start,
+	.stop = q6v5_wcss_stop,
+	.da_to_va = q6v5_wcss_da_to_va,
+	.load = q6v5_wcss_load,
+	.get_boot_addr = rproc_elf_get_boot_addr,
+};
+
+static int q6v5_wcss_init_reset(struct q6v5_wcss *wcss)
+{
+	struct device *dev = wcss->dev;
+
+	wcss->wcss_aon_reset = devm_reset_control_get(dev, "wcss_aon_reset");
+	if (IS_ERR(wcss->wcss_aon_reset)) {
+		dev_err(wcss->dev, "unable to acquire wcss_aon_reset\n");
+		return PTR_ERR(wcss->wcss_aon_reset);
+	}
+
+	wcss->wcss_reset = devm_reset_control_get(dev, "wcss_reset");
+	if (IS_ERR(wcss->wcss_reset)) {
+		dev_err(wcss->dev, "unable to acquire wcss_reset\n");
+		return PTR_ERR(wcss->wcss_reset);
+	}
+
+	wcss->wcss_q6_reset = devm_reset_control_get(dev, "wcss_q6_reset");
+	if (IS_ERR(wcss->wcss_q6_reset)) {
+		dev_err(wcss->dev, "unable to acquire wcss_q6_reset\n");
+		return PTR_ERR(wcss->wcss_q6_reset);
+	}
+
+	return 0;
+}
+
+static int q6v5_wcss_init_mmio(struct q6v5_wcss *wcss,
+			       struct platform_device *pdev)
+{
+	struct of_phandle_args args;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qdsp6");
+	wcss->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wcss->reg_base))
+		return PTR_ERR(wcss->reg_base);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rmb");
+	wcss->rmb_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(wcss->rmb_base))
+		return PTR_ERR(wcss->rmb_base);
+
+	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+					       "qcom,halt-regs", 3, 0, &args);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to parse qcom,halt-regs\n");
+		return -EINVAL;
+	}
+
+	wcss->halt_map = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(wcss->halt_map))
+		return PTR_ERR(wcss->halt_map);
+
+	wcss->halt_q6 = args.args[0];
+	wcss->halt_wcss = args.args[1];
+	wcss->halt_nc = args.args[2];
+
+	return 0;
+}
+
+static int q6v5_alloc_memory_region(struct q6v5_wcss *wcss)
+{
+	struct reserved_mem *rmem = NULL;
+	struct device_node *node;
+	struct device *dev = wcss->dev;
+
+	node = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (node)
+		rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+
+	if (!rmem) {
+		dev_err(dev, "unable to acquire memory-region\n");
+		return -EINVAL;
+	}
+
+	wcss->mem_phys = rmem->base;
+	wcss->mem_reloc = rmem->base;
+	wcss->mem_size = rmem->size;
+	wcss->mem_region = devm_ioremap_wc(dev, wcss->mem_phys, wcss->mem_size);
+	if (!wcss->mem_region) {
+		dev_err(dev, "unable to map memory region: %pa+%pa\n",
+			&rmem->base, &rmem->size);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int q6v5_wcss_probe(struct platform_device *pdev)
+{
+	struct q6v5_wcss *wcss;
+	struct rproc *rproc;
+	int ret;
+
+	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_wcss_ops,
+			    "IPQ8074/q6_fw.mdt", sizeof(*wcss));
+	if (!rproc) {
+		dev_err(&pdev->dev, "failed to allocate rproc\n");
+		return -ENOMEM;
+	}
+
+	wcss = rproc->priv;
+	wcss->dev = &pdev->dev;
+
+	ret = q6v5_wcss_init_mmio(wcss, pdev);
+	if (ret)
+		goto free_rproc;
+
+	ret = q6v5_alloc_memory_region(wcss);
+	if (ret)
+		goto free_rproc;
+
+	ret = q6v5_wcss_init_reset(wcss);
+	if (ret)
+		goto free_rproc;
+
+	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, WCSS_CRASH_REASON, NULL);
+	if (ret)
+		goto free_rproc;
+
+	ret = rproc_add(rproc);
+	if (ret)
+		goto free_rproc;
+
+	platform_set_drvdata(pdev, rproc);
+
+	return 0;
+
+free_rproc:
+	rproc_free(rproc);
+
+	return ret;
+}
+
+static int q6v5_wcss_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+
+	rproc_del(rproc);
+	rproc_free(rproc);
+
+	return 0;
+}
+
+static const struct of_device_id q6v5_wcss_of_match[] = {
+	{ .compatible = "qcom,ipq8074-wcss-pil" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, q6v5_wcss_of_match);
+
+static struct platform_driver q6v5_wcss_driver = {
+	.probe = q6v5_wcss_probe,
+	.remove = q6v5_wcss_remove,
+	.driver = {
+		.name = "qcom-q6v5-wcss-pil",
+		.of_match_table = q6v5_wcss_of_match,
+	},
+};
+module_platform_driver(q6v5_wcss_driver);
+
+MODULE_DESCRIPTION("Hexagon WCSS Peripheral Image Loader");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
