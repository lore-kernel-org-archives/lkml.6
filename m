Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 21RzKRY8GltJMgAAmS7hNA
	; Fri, 08 Jun 2018 08:19:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8A35A607DC; Fri,  8 Jun 2018 08:19:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaEj11y6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E6FFE606FA;
	Fri,  8 Jun 2018 08:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6FFE606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932143AbeFHITa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:19:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41674 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbeFHITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:19:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so6256107pff.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyYJFC/ULg+WaShQE42PX674Gh+T+hIOdh6V3P9Zpto=;
        b=jaEj11y6u5WdwqbmDEk+6GiMoeZP2JBcneGCwomVUnfqid11cG/0gS1KG1GH7bCqj3
         +R1wveFnmjKW7Ywf2GQ289H7vpOAQaYw3VxF/7ToMRHvb2eO6KNSqqypuVIqs7QYpxGy
         Pg8k5cZvXA1x8CVcDliAlb1sZ7k2XE3jzb4Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OyYJFC/ULg+WaShQE42PX674Gh+T+hIOdh6V3P9Zpto=;
        b=JoPLy4z+lNNfhNPECHKd4++Yzv41nS1RN/rlM6RE68sI0JQDrWxKlAf8g2FRE7ALKC
         WP6BZFdDKhnLe2BcaEC+dytB+k6Ij5L89oJ6EJmkxgNQPC/PHtJbVYyp1y/RUD0xSxyh
         qqu1WXkatu71PotpP15ADXueoZuYvaJC8SumXW36fKCLFTl0lhZvTmeskHUBRB1AoSdu
         ZHsatjHSofq+Rc+ZSd1oMKTIWb2he48XGPGM235S2p006YO9KGAOhUjlsnoJFZEEoVHY
         XRlGstZr/GmnMD9gXc7Ylaphc5zeE+nhgGpXO+q9epwNgkZpiTJNAr0wYpqopdgRDT6C
         RiXw==
X-Gm-Message-State: APt69E0dgASHpKtqKTU55vH2GrG7nkS+Ylox6hcxTWYh4u56DrlHrCYc
        2sNs/h7tGXu3JbHsYFER53rlzQ==
X-Google-Smtp-Source: ADUXVKIQSqsqYki7cvvSc+N/FjmtgLgWRhuGtPXhHa33w9sEDtM+e75kLINmxL6kBIUz4k/ohDXU3w==
X-Received: by 2002:a62:f551:: with SMTP id n78-v6mr5067968pfh.200.1528445961866;
        Fri, 08 Jun 2018 01:19:21 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s4-v6sm72243947pgp.35.2018.06.08.01.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 01:19:20 -0700 (PDT)
From: Chunyan Zhang <zhang.chunyan@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH 6/6] mmc: host: sdhci-sprd: added Spreadtrum's host controller R11
Date: Fri,  8 Jun 2018 16:18:13 +0800
Message-Id: <1528445893-14530-7-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
References: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

This patch adds the initial support of Secure Digital Host Controller
Interface compliant controller - R11 found in some latest Spreadtrum
chipsets.

R11 is a variant based on SD v4.0 specification.

With this driver, mmc can be initialized, can be mounted, read and
written.

Original-by: Billows Wu <billows.wu@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/mmc/host/Kconfig          |  13 ++
 drivers/mmc/host/Makefile         |   1 +
 drivers/mmc/host/sdhci-sprd-r11.c | 472 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 486 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-sprd-r11.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9589f9c..563baf5 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -584,6 +584,19 @@ config MMC_SDRICOH_CS
 	  To compile this driver as a module, choose M here: the
 	  module will be called sdricoh_cs.
 
+config MMC_SDHCI_SPRD_R11
+	tristate "Spreadtrum SDIO host Controller(IP version: R11P0)"
+	depends on ARCH_SPRD
+	depends on MMC_SDHCI_PLTFM
+	select MMC_SDHCI_IO_ACCESSORS
+	help
+	  This selects the SDIO Host Controller(R11P0) in Spreadtrum
+	  SoCs.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_TMIO_CORE
 	tristate
 
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 6aead24..417394d 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+= sdhci-pic32.o
 obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+= sdhci-brcmstb.o
 obj-$(CONFIG_MMC_SDHCI_OMAP)		+= sdhci-omap.o
 obj-$(CONFIG_MMC_CQHCI)			+= cqhci.o
+obj-$(CONFIG_MMC_SDHCI_SPRD_R11)	+= sdhci-sprd-r11.o
 
 ifeq ($(CONFIG_CB710_DEBUG),y)
 	CFLAGS-cb710-mmc	+= -DDEBUG
diff --git a/drivers/mmc/host/sdhci-sprd-r11.c b/drivers/mmc/host/sdhci-sprd-r11.c
new file mode 100644
index 0000000..fcd093a5
--- /dev/null
+++ b/drivers/mmc/host/sdhci-sprd-r11.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Secure Digital Host Controller
+//
+// Copyright (C) 2018 Spreadtrum, Inc.
+// Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/highmem.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include "sdhci-pltfm.h"
+
+#define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET	0x208
+#define  SDHCIBSPRD_IT_WR_DLY_INV		(1 << 5)
+#define  SDHCI_SPRD_BIT_CMD_DLY_INV		(1 << 13)
+#define  SDHCI_SPRD_BIT_POSRD_DLY_INV		(1 << 21)
+#define  SDHCI_SPRD_BIT_NEGRD_DLY_INV		(1 << 29)
+
+#define SDHCI_SPRD_REG_32_BUSY_POSI		0x250
+#define  SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN	(1 << 25)
+#define  SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN	(1 << 24)
+
+#define SDHCI_SPRD_REG_DEBOUNCE		0x28C
+#define  SDHCI_SPRD_BIT_DLL_BAK		(1 << 0)
+#define  SDHCI_SPRD_BIT_DLL_VAL		(1 << 1)
+
+#define  SDHCI_SPRD_INT_SIGNAL_MASK	0x1B7F410B
+
+/* SDHCI_HOST_CONTROL2 */
+#define  SDHCI_SPRD_CTRL_HS200		0x0005
+#define  SDHCI_SPRD_CTRL_HS400		0x0006
+
+/* SDHCI_SOFTWARE_RESET */
+#define  SDHCI_HW_RESET_CARD		0x8 /* For Spreadtrum's design */
+
+#define SDHCI_SPRD_MAX_CUR		1020
+#define SDHCI_SPRD_CLK_MAX_DIV		0x3FF
+
+struct sdhci_sprd_host {
+	u32 version;
+	struct clk *clk_sdio;
+	struct clk *clk_source;
+	struct clk *clk_enable;
+	u32 base_rate;
+};
+
+#define TO_SPRD_HOST(host) sdhci_pltfm_priv(sdhci_priv(host))
+
+static int sdhci_sprd_get_dt_resource(struct platform_device *pdev,
+		struct sdhci_sprd_host *sprd_host)
+{
+	int ret = 0;
+	struct clk *clk;
+
+	clk = devm_clk_get(&pdev->dev, "sdio");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_warn(&pdev->dev, "Failed to get sdio clock (%d)\n", ret);
+		goto out;
+	}
+	sprd_host->clk_sdio = clk;
+
+	clk = devm_clk_get(&pdev->dev, "source");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_warn(&pdev->dev, "Failed to get source clock (%d)\n", ret);
+		goto out;
+	}
+	sprd_host->clk_source = clk;
+
+	clk_set_parent(sprd_host->clk_sdio, sprd_host->clk_source);
+	sprd_host->base_rate = clk_get_rate(sprd_host->clk_source);
+	if (!sprd_host->base_rate) {
+		sprd_host->base_rate = 26000000;
+		dev_warn(&pdev->dev, "The source clock rate is 0\n");
+	}
+
+	clk = devm_clk_get(&pdev->dev, "enable");
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		dev_warn(&pdev->dev, "Failed to get gate clock (%d)\n", ret);
+		goto out;
+	}
+	sprd_host->clk_enable = clk;
+
+out:
+	return ret;
+}
+
+static void sdhci_sprd_set_mmc_struct(struct platform_device *pdev,
+				struct mmc_host *mmc)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
+		MMC_CAP_ERASE | MMC_CAP_CMD23;
+
+	mmc_of_parse(mmc);
+	mmc_of_parse_voltage(np, &host->ocr_mask);
+
+	mmc->ocr_avail = 0x40000;
+	mmc->ocr_avail_sdio = mmc->ocr_avail;
+	mmc->ocr_avail_sd = mmc->ocr_avail;
+	mmc->ocr_avail_mmc = mmc->ocr_avail;
+
+	mmc->max_current_330 = SDHCI_SPRD_MAX_CUR;
+	mmc->max_current_300 = SDHCI_SPRD_MAX_CUR;
+	mmc->max_current_180 = SDHCI_SPRD_MAX_CUR;
+
+	host->dma_mask = DMA_BIT_MASK(64);
+	mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
+}
+
+static void sdhci_sprd_init_config(struct sdhci_host *host)
+{
+	u16 val;
+
+	/* set 64-bit addressing modes */
+	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	val |= SDHCI_CTRL_64BIT_ADDR;
+	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
+
+	/* set dll backup mode */
+	val = sdhci_readl(host, SDHCI_SPRD_REG_DEBOUNCE);
+	val |= SDHCI_SPRD_BIT_DLL_BAK | SDHCI_SPRD_BIT_DLL_VAL;
+	sdhci_writel(host, val, SDHCI_SPRD_REG_DEBOUNCE);
+}
+
+static inline u32 sdhci_sprd_readl(struct sdhci_host *host, int reg)
+{
+	if (unlikely(reg == SDHCI_MAX_CURRENT))
+		return SDHCI_SPRD_MAX_CUR;
+
+	return readl_relaxed(host->ioaddr + reg);
+}
+
+static inline void sdhci_sprd_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	/* SDHCI_MAX_CURRENT is reserved on Spreadtrum's platform */
+	if (unlikely(reg == SDHCI_MAX_CURRENT))
+		return;
+
+	if (unlikely(reg == SDHCI_SIGNAL_ENABLE || reg == SDHCI_INT_ENABLE))
+		val = val & SDHCI_SPRD_INT_SIGNAL_MASK;
+
+	return writel_relaxed(val, host->ioaddr + reg);
+}
+
+static inline void sdhci_sprd_writeb(struct sdhci_host *host, u8 val, int reg)
+{
+	if (unlikely(reg == SDHCI_SOFTWARE_RESET)) {
+		if (readb_relaxed(host->ioaddr + reg) & SDHCI_HW_RESET_CARD)
+			val |= SDHCI_HW_RESET_CARD;
+	}
+
+	return writeb_relaxed(val, host->ioaddr + reg);
+}
+
+static inline void sdhci_sprd_sd_clk_off(struct sdhci_host *host)
+{
+	u16 ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	ctrl &= (~SDHCI_CLOCK_CARD_EN);
+	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+}
+
+static inline void
+sdhci_sprd_set_dll_invert(struct sdhci_host *host, u32 mask, bool en)
+{
+	u32 dll_dly_offset;
+
+	dll_dly_offset = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_DLY_OFFSET);
+	if (en)
+		dll_dly_offset |= mask;
+	else
+		dll_dly_offset &= ~mask;
+	sdhci_writel(host, dll_dly_offset, SDHCI_SPRD_REG_32_DLL_DLY_OFFSET);
+}
+
+static inline u32 sdhci_sprd_calc_div(u32 base_clk, u32 clk)
+{
+	u32 div;
+
+	/* select 2x clock source */
+	if (base_clk <= clk * 2)
+		return 0;
+
+	div = (u32) (base_clk / (clk * 2));
+
+	if ((base_clk / div) > (clk * 2))
+		div++;
+
+	if (div > SDHCI_SPRD_CLK_MAX_DIV)
+		div = SDHCI_SPRD_CLK_MAX_DIV;
+
+	if (div % 2)
+		div = (div + 1) / 2;
+	else
+		div = div / 2;
+
+	return div;
+}
+
+static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
+					unsigned int clk)
+{
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+	u32 div, val, mask;
+
+	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+
+	clk |= ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
+	sdhci_enable_clk(host, clk);
+
+	/* enable auto gate sdhc_enable_auto_gate */
+	val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
+	mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
+	       SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
+	if (mask != (val & mask)) {
+		val |= mask;
+		sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
+	}
+}
+
+static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	bool en = false;
+
+	if (clock == 0) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	} else if (clock != host->clock) {
+		sdhci_sprd_sd_clk_off(host);
+		_sdhci_sprd_set_clock(host, clock);
+
+		if (clock <= 400000)
+			en = true;
+		sdhci_sprd_set_dll_invert(host, SDHCI_SPRD_BIT_CMD_DLY_INV |
+					  SDHCI_SPRD_BIT_POSRD_DLY_INV, en);
+	} else {
+		_sdhci_sprd_set_clock(host, clock);
+	}
+
+}
+
+static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+
+	return clk_round_rate(sprd_host->clk_sdio, ULONG_MAX);
+}
+
+static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
+{
+	return 400000;
+}
+
+static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+}
+
+static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
+					 unsigned int timing)
+{
+	u16 ctrl_2;
+
+	if (timing == host->timing)
+		return;
+
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	switch (timing) {
+	case MMC_TIMING_UHS_SDR12:
+		ctrl_2 = SDHCI_CTRL_UHS_SDR12;
+		break;
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+	case MMC_TIMING_UHS_SDR25:
+		ctrl_2 = SDHCI_CTRL_UHS_SDR25;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		ctrl_2 = SDHCI_CTRL_UHS_SDR50;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		ctrl_2 = SDHCI_CTRL_UHS_SDR104;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
+		ctrl_2 = SDHCI_CTRL_UHS_DDR50;
+		break;
+	case MMC_TIMING_MMC_HS200:
+		ctrl_2 = SDHCI_SPRD_CTRL_HS200;
+		break;
+	case MMC_TIMING_MMC_HS400:
+		ctrl_2 = SDHCI_SPRD_CTRL_HS400;
+		break;
+	default:
+		break;
+	}
+
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
+
+static void sdhci_sprd_hw_reset(struct sdhci_host *host)
+{
+	int val;
+
+	/* Note: don't use sdhci_readb/writeb() API here */
+	val = readb_relaxed(host->ioaddr + SDHCI_SOFTWARE_RESET);
+	val &= ~SDHCI_HW_RESET_CARD;
+	writeb_relaxed(val, host->ioaddr + SDHCI_SOFTWARE_RESET);
+	udelay(10);
+
+	val |= SDHCI_HW_RESET_CARD;
+	writeb_relaxed(val, host->ioaddr + SDHCI_SOFTWARE_RESET);
+	udelay(300);
+}
+
+static struct sdhci_ops sdhci_sprd_ops = {
+	.read_l = sdhci_sprd_readl,
+	.write_l = sdhci_sprd_writel,
+	.write_b = sdhci_sprd_writeb,
+	.set_clock = sdhci_sprd_set_clock,
+	.get_max_clock = sdhci_sprd_get_max_clock,
+	.get_min_clock = sdhci_sprd_get_min_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_sprd_reset,
+	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
+	.hw_reset = sdhci_sprd_hw_reset,
+};
+
+static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200,
+	.ops = &sdhci_sprd_ops,
+};
+
+static int sdhci_sprd_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	struct sdhci_sprd_host *sprd_host;
+	int ret = 0;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_sprd_pdata, sizeof(*sprd_host));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	sprd_host = TO_SPRD_HOST(host);
+
+	ret = sdhci_sprd_get_dt_resource(pdev, sprd_host);
+	if (ret)
+		goto pltfm_free;
+
+	clk_prepare_enable(sprd_host->clk_sdio);
+	clk_prepare_enable(sprd_host->clk_enable);
+
+	sdhci_sprd_init_config(host);
+
+	sdhci_sprd_set_mmc_struct(pdev, host->mmc);
+
+	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
+	sprd_host->version = ((host->version & SDHCI_VENDOR_VER_MASK) >>
+			       SDHCI_VENDOR_VER_SHIFT);
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_suspend_ignore_children(&pdev->dev, 1);
+
+	ret = sdhci_add_host(host);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add mmc host: %d\n", ret);
+		goto pm_runtime_disable;
+	}
+
+	return 0;
+
+pm_runtime_disable:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
+	clk_disable_unprepare(sprd_host->clk_sdio);
+	clk_disable_unprepare(sprd_host->clk_enable);
+
+pltfm_free:
+	sdhci_pltfm_free(pdev);
+	return ret;
+}
+
+static int sdhci_sprd_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+	struct mmc_host *mmc = host->mmc;
+
+	mmc_remove_host(mmc);
+	clk_disable_unprepare(sprd_host->clk_sdio);
+	clk_disable_unprepare(sprd_host->clk_enable);
+
+	mmc_free_host(mmc);
+
+	return 0;
+}
+
+static const struct of_device_id sdhci_sprd_of_match[] = {
+	{ .compatible = "sprd,sdhc-r11", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_sprd_of_match);
+
+#ifdef CONFIG_PM
+static int sdhci_sprd_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+
+	sdhci_runtime_suspend_host(host);
+
+	clk_disable_unprepare(sprd_host->clk_sdio);
+	clk_disable_unprepare(sprd_host->clk_enable);
+
+	return 0;
+}
+
+static int sdhci_sprd_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+
+	clk_prepare_enable(sprd_host->clk_enable);
+	clk_prepare_enable(sprd_host->clk_sdio);
+
+	sdhci_runtime_resume_host(host);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sdhci_sprd_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(sdhci_sprd_runtime_suspend,
+			   sdhci_sprd_runtime_resume, NULL)
+};
+
+static struct platform_driver sdhci_sprd_driver = {
+	.probe = sdhci_sprd_probe,
+	.remove = sdhci_sprd_remove,
+	.driver = {
+		.name = "sdhci_sprd_r11",
+		.of_match_table = of_match_ptr(sdhci_sprd_of_match),
+		.pm = &sdhci_sprd_pm_ops,
+	},
+};
+module_platform_driver(sdhci_sprd_driver);
+
+MODULE_DESCRIPTION("Spreadtrum sdio host controller r11 driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:sdhci-sprd-r11");
-- 
2.7.4
