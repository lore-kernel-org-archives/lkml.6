Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A11BECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50FE204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PPZTpPZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50FE204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJTWBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:01:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39854 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbeJTWBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:01:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id 61-v6so40206285wrb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOn3TG2+oeg5nI/Zp84WaB+7/5aTdGuPMNt8FHDTWnA=;
        b=PPZTpPZO80vh9zZBaaKNOL4JdAUBy9yGm0Xr8Izag8WOa+AKxS+L9doVywPV/KEQll
         vEUNG1y2yLhYjGSkxXy8rWOLJCyNNR+l5stxKVtxxKIvfdKfbR/C84B1H8M6xjjN11wn
         JCxRUtVwtNXwAfz9t/5mcE2O2LV+tjOQxKIbrAtZMrTQTP/w/zmBblxrLn6dMtowuW35
         M980anXFspBDQ/Tfp3w8SbwnFu8hD8nvjmb2bxqAdAYozmpRFPGqaXNHO5lL5jqlsDbb
         XUBMoklW01DJkz59pjn8u709RF6mC/V+7hZ8rOsIhIe1hDFfjlwTyRsnvEh6qDYCqJlY
         aEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOn3TG2+oeg5nI/Zp84WaB+7/5aTdGuPMNt8FHDTWnA=;
        b=pZL/eQzEFnUnyj47E7/xY3qPeC+bFizc00FoGxrhFKLg2ccFCFZ8HTZnmtDEoyrGxY
         4gifQrwdBu59deFflHPgxOL1QcAdyqm1WgoRwuo24Qm9+QE8TyWy9BlQEPRN8lWUjkt2
         YHQucMPbrCrD/x27eH3eKdQJ0gLhnsdpo47fnRzEZjCGehLUr2DfQe+B5tNfopuBkBGv
         rZ6KgZuJS8CR1JqKFNI1YATS87gURGYS82WNjYmcWn8kG7XdsKWylMrIhVLqaIF68s1f
         nEX8Jz4vfrQAMvIratFaIUIoVjQvgZQ9aKIPIEeHuI2oQZLEZPd+VOVeOW20cbnwZL2a
         t7PQ==
X-Gm-Message-State: ABuFfogVphBZuv5RQdNR009JU+Ah6ioV54XFYGGpYPtlvaLF2UnhtVEF
        zsvhjeTAkDDVzMKzwdEDKUb3Jg==
X-Google-Smtp-Source: ACcGV60UgKipdTT5M38/2IK0vvJSyxPxvFA8kBBIprOmtrEHUR7zB6z7FpZ+vDMLz5URIpUWu9kyMg==
X-Received: by 2002:a5d:610c:: with SMTP id v12-v6mr38218734wrt.308.1540043442373;
        Sat, 20 Oct 2018 06:50:42 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id o4-v6sm16906615wrj.45.2018.10.20.06.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 06:50:41 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 3/3] clk: sifive: add a driver for the SiFive FU540 PRCI IP block
Date:   Sat, 20 Oct 2018 06:50:24 -0700
Message-Id: <20181020135024.28573-4-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181020135024.28573-1-paul.walmsley@sifive.com>
References: <20181020135024.28573-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver code for the SiFive FU540 PRCI IP block.  This IP block
handles reset and clock control for the SiFive FU540 device and
implements SoC-level clock tree controls and dividers.

Based on code written by Wesley Terpstra <wesley@sifive.com>:
https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d221b2ee56bb60

Boot and PLL rate change were tested on a SiFive HiFive Unleashed
board.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Wesley W. Terpstra <wesley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Megan Wachs <megan@sifive.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/clk/Kconfig                   |   1 +
 drivers/clk/Makefile                  |   1 +
 drivers/clk/sifive/Kconfig            |  18 +
 drivers/clk/sifive/Makefile           |   1 +
 drivers/clk/sifive/fu540-prci.c       | 634 ++++++++++++++++++++++++++
 include/linux/clk/sifive-fu540-prci.h |  27 ++
 6 files changed, 682 insertions(+)
 create mode 100644 drivers/clk/sifive/Kconfig
 create mode 100644 drivers/clk/sifive/Makefile
 create mode 100644 drivers/clk/sifive/fu540-prci.c
 create mode 100644 include/linux/clk/sifive-fu540-prci.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index a34ccfcb54ac..0af5f6843a2f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -295,6 +295,7 @@ source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
 source "drivers/clk/samsung/Kconfig"
+source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d59c11ddfc5e..8b07ebab37f8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-y					+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
+obj-y					+= sifive/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
new file mode 100644
index 000000000000..8db4a3eb4782
--- /dev/null
+++ b/drivers/clk/sifive/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig CLK_SIFIVE
+	bool "SiFive SoC driver support"
+	help
+	  SoC drivers for SiFive Linux-capable SoCs.
+
+if CLK_SIFIVE
+
+config CLK_SIFIVE_FU540_PRCI
+	bool "PRCI driver for SiFive FU540 SoCs"
+	select CLK_ANALOGBITS_WRPLL_CLN28HPC
+	help
+	  Supports the Power Reset Clock interface (PRCI) IP block found in
+	  FU540 SoCs.  If this kernel is meant to run on a SiFive FU540 SoC,
+	  enable this driver.
+
+endif
diff --git a/drivers/clk/sifive/Makefile b/drivers/clk/sifive/Makefile
new file mode 100644
index 000000000000..74d58a4c0756
--- /dev/null
+++ b/drivers/clk/sifive/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_CLK_SIFIVE_FU540_PRCI)	+= fu540-prci.o
diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
new file mode 100644
index 000000000000..870cb8333648
--- /dev/null
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 SiFive, Inc.
+ * Wesley Terpstra
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * The FU540 PRCI implements clock and reset control for the SiFive
+ * FU540-C000 chip.   This driver assumes that it has sole control
+ * over all PRCI resources.
+ *
+ * This driver is based on the PRCI driver written by Wesley Terpstra:
+ * https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d221b2ee56bb60
+ *
+ * References:
+ * - SiFive FU540-C000 manual v1p0, Chapter 7 "Clocking and Reset"
+ */
+
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/clk/analogbits-wrpll-cln28hpc.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/log2.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/clk/sifive-fu540-prci.h>
+
+/*
+ * EXPECTED_CLK_PARENT_COUNT: how many parent clocks this driver expects:
+ *     hfclk and rtcclk
+ */
+#define EXPECTED_CLK_PARENT_COUNT		2
+
+/*
+ * Register offsets and bitmasks
+ */
+
+/* COREPLLCFG0 */
+#define PRCI_COREPLLCFG0_OFFSET			0x4
+# define PRCI_COREPLLCFG0_DIVR_SHIFT		0
+# define PRCI_COREPLLCFG0_DIVR_MASK		(0x3f << PRCI_COREPLLCFG0_DIVR_SHIFT)
+# define PRCI_COREPLLCFG0_DIVF_SHIFT		6
+# define PRCI_COREPLLCFG0_DIVF_MASK		(0x1ff << PRCI_COREPLLCFG0_DIVF_SHIFT)
+# define PRCI_COREPLLCFG0_DIVQ_SHIFT		15
+# define PRCI_COREPLLCFG0_DIVQ_MASK		(0x7 << PRCI_COREPLLCFG0_DIVQ_SHIFT)
+# define PRCI_COREPLLCFG0_RANGE_SHIFT		18
+# define PRCI_COREPLLCFG0_RANGE_MASK		(0x7 << PRCI_COREPLLCFG0_RANGE_SHIFT)
+# define PRCI_COREPLLCFG0_BYPASS_SHIFT		24
+# define PRCI_COREPLLCFG0_BYPASS_MASK		(0x1 << PRCI_COREPLLCFG0_BYPASS_SHIFT)
+# define PRCI_COREPLLCFG0_FSE_SHIFT		25
+# define PRCI_COREPLLCFG0_FSE_MASK		(0x1 << PRCI_COREPLLCFG0_FSE_SHIFT)
+# define PRCI_COREPLLCFG0_LOCK_SHIFT		31
+# define PRCI_COREPLLCFG0_LOCK_MASK		(0x1 << PRCI_COREPLLCFG0_LOCK_SHIFT)
+
+/* DDRPLLCFG0 */
+#define PRCI_DDRPLLCFG0_OFFSET			0xc
+# define PRCI_DDRPLLCFG0_DIVR_SHIFT		0
+# define PRCI_DDRPLLCFG0_DIVR_MASK		(0x3f << PRCI_DDRPLLCFG0_DIVR_SHIFT)
+# define PRCI_DDRPLLCFG0_DIVF_SHIFT		6
+# define PRCI_DDRPLLCFG0_DIVF_MASK		(0x1ff << PRCI_DDRPLLCFG0_DIVF_SHIFT)
+# define PRCI_DDRPLLCFG0_DIVQ_SHIFT		15
+# define PRCI_DDRPLLCFG0_DIVQ_MASK		(0x7 << PRCI_DDRPLLCFG0_DIVQ_SHIFT)
+# define PRCI_DDRPLLCFG0_RANGE_SHIFT		18
+# define PRCI_DDRPLLCFG0_RANGE_MASK		(0x7 << PRCI_DDRPLLCFG0_RANGE_SHIFT)
+# define PRCI_DDRPLLCFG0_BYPASS_SHIFT		24
+# define PRCI_DDRPLLCFG0_BYPASS_MASK		(0x1 << PRCI_DDRPLLCFG0_BYPASS_SHIFT)
+# define PRCI_DDRPLLCFG0_FSE_SHIFT		25
+# define PRCI_DDRPLLCFG0_FSE_MASK		(0x1 << PRCI_DDRPLLCFG0_FSE_SHIFT)
+# define PRCI_DDRPLLCFG0_LOCK_SHIFT		31
+# define PRCI_DDRPLLCFG0_LOCK_MASK		(0x1 << PRCI_DDRPLLCFG0_LOCK_SHIFT)
+
+/* DDRPLLCFG1 */
+#define PRCI_DDRPLLCFG1_OFFSET			0x10
+# define PRCI_DDRPLLCFG1_CKE_SHIFT		24
+# define PRCI_DDRPLLCFG1_CKE_MASK		(0x1 << PRCI_DDRPLLCFG1_CKE_SHIFT)
+
+/* GEMGXLPLLCFG0 */
+#define PRCI_GEMGXLPLLCFG0_OFFSET		0x1c
+# define PRCI_GEMGXLPLLCFG0_DIVR_SHIFT		0
+# define PRCI_GEMGXLPLLCFG0_DIVR_MASK		(0x3f << PRCI_GEMGXLPLLCFG0_DIVR_SHIFT)
+# define PRCI_GEMGXLPLLCFG0_DIVF_SHIFT		6
+# define PRCI_GEMGXLPLLCFG0_DIVF_MASK		(0x1ff << PRCI_GEMGXLPLLCFG0_DIVF_SHIFT)
+# define PRCI_GEMGXLPLLCFG0_DIVQ_SHIFT		15
+# define PRCI_GEMGXLPLLCFG0_DIVQ_MASK		(0x7 << PRCI_GEMGXLPLLCFG0_DIVQ_SHIFT)
+# define PRCI_GEMGXLPLLCFG0_RANGE_SHIFT		18
+# define PRCI_GEMGXLPLLCFG0_RANGE_MASK		(0x7 << PRCI_GEMGXLPLLCFG0_RANGE_SHIFT)
+# define PRCI_GEMGXLPLLCFG0_BYPASS_SHIFT	24
+# define PRCI_GEMGXLPLLCFG0_BYPASS_MASK		(0x1 << PRCI_GEMGXLPLLCFG0_BYPASS_SHIFT)
+# define PRCI_GEMGXLPLLCFG0_FSE_SHIFT		25
+# define PRCI_GEMGXLPLLCFG0_FSE_MASK		(0x1 << PRCI_GEMGXLPLLCFG0_FSE_SHIFT)
+# define PRCI_GEMGXLPLLCFG0_LOCK_SHIFT		31
+# define PRCI_GEMGXLPLLCFG0_LOCK_MASK		(0x1 << PRCI_GEMGXLPLLCFG0_LOCK_SHIFT)
+
+/* GEMGXLPLLCFG1 */
+#define PRCI_GEMGXLPLLCFG1_OFFSET		0x20
+# define PRCI_GEMGXLPLLCFG1_CKE_SHIFT		24
+# define PRCI_GEMGXLPLLCFG1_CKE_MASK		(0x1 << PRCI_GEMGXLPLLCFG1_CKE_SHIFT)
+
+/* CORECLKSEL */
+#define PRCI_CORECLKSEL_OFFSET			0x24
+# define PRCI_CORECLKSEL_CORECLKSEL_SHIFT	0
+# define PRCI_CORECLKSEL_CORECLKSEL_MASK	(0x1 << PRCI_CORECLKSEL_CORECLKSEL_SHIFT)
+
+/* DEVICESRESETREG */
+#define PRCI_DEVICESRESETREG_OFFSET			0x28
+# define PRCI_DEVICESRESETREG_DDR_CTRL_RST_N_SHIFT	0
+# define PRCI_DEVICESRESETREG_DDR_CTRL_RST_N_MASK	(0x1 << PRCI_DEVICESRESETREG_DDR_CTRL_RST_N_SHIFT)
+# define PRCI_DEVICESRESETREG_DDR_AXI_RST_N_SHIFT	1
+# define PRCI_DEVICESRESETREG_DDR_AXI_RST_N_MASK	(0x1 << PRCI_DEVICESRESETREG_DDR_AXI_RST_N_SHIFT)
+# define PRCI_DEVICESRESETREG_DDR_AHB_RST_N_SHIFT	2
+# define PRCI_DEVICESRESETREG_DDR_AHB_RST_N_MASK	(0x1 << PRCI_DEVICESRESETREG_DDR_AHB_RST_N_SHIFT)
+# define PRCI_DEVICESRESETREG_DDR_PHY_RST_N_SHIFT	3
+# define PRCI_DEVICESRESETREG_DDR_PHY_RST_N_MASK	(0x1 << PRCI_DEVICESRESETREG_DDR_PHY_RST_N_SHIFT)
+# define PRCI_DEVICESRESETREG_GEMGXL_RST_N_SHIFT	5
+# define PRCI_DEVICESRESETREG_GEMGXL_RST_N_MASK		(0x1 << PRCI_DEVICESRESETREG_GEMGXL_RST_N_SHIFT)
+
+/* CLKMUXSTATUSREG */
+#define PRCI_CLKMUXSTATUSREG_OFFSET			0x2c
+# define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT	1
+# define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_MASK	(0x1 << PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT)
+
+/*
+ * Private structures
+ */
+
+/**
+ * struct __prci_data - per-device-instance data
+ * @va: base virtual address of the PRCI IP block
+ * @hw_clks: encapsulates struct clk_hw records
+ *
+ * PRCI per-device instance data
+ */
+struct __prci_data {
+	void __iomem *va;
+	struct clk_hw_onecell_data hw_clks;
+};
+
+/**
+ * struct __prci_wrpll_data - WRPLL configuration and integration data
+ * @c: WRPLL current configuration record
+ * @bypass: fn ptr to code to bypass the WRPLL (if applicable; else NULL)
+ * @no_bypass: fn ptr to code to not bypass the WRPLL (if applicable; else NULL)
+ * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base address
+ *
+ * @bypass and @no_bypass are used for WRPLL instances that contain a separate
+ * external glitchless clock mux downstream from the PLL.  The WRPLL internal
+ * bypass mux is not glitchless.
+ */
+struct __prci_wrpll_data {
+	struct analogbits_wrpll_cfg c;
+	void (*bypass)(struct __prci_data *pd);
+	void (*no_bypass)(struct __prci_data *pd);
+	u8 cfg0_offs;
+};
+
+/**
+ * struct __prci_clock - describes a clock device managed by PRCI
+ * @name: user-readable clock name string - should match the manual
+ * @parent_name: parent name for this clock
+ * @ops: struct clk_ops for the Linux clock framework to use for control
+ * @hw: Linux-private clock data
+ * @pwd: WRPLL-specific data, associated with this clock (if not NULL)
+ * @pd: PRCI-specific data associated with this clock (if not NULL)
+ *
+ * PRCI clock data.  Used by the PRCI driver to register PRCI-provided
+ * clocks to the Linux clock infrastructure.
+ */
+struct __prci_clock {
+	const char *name;
+	const char *parent_name;
+	const struct clk_ops *ops;
+	struct clk_hw hw;
+	struct __prci_wrpll_data *pwd;
+	struct __prci_data *pd;
+};
+
+#define clk_hw_to_prci_clock(pwd) container_of(pwd, struct __prci_clock, hw)
+
+/*
+ * Private functions
+ */
+
+/**
+ * __prci_readl() - read from a PRCI register
+ * @pd: PRCI context
+ * @offs: register offset to read from (in bytes, from PRCI base address)
+ *
+ * Read the register located at offset @offs from the base virtual
+ * address of the PRCI register target described by @pd, and return
+ * the value to the caller.
+ *
+ * Context: Any context.
+ *
+ * Return: the contents of the register described by @pd and @offs.
+ */
+static u32 __prci_readl(struct __prci_data *pd, u32 offs)
+{
+	return readl_relaxed(pd->va + offs);
+}
+
+static void __prci_writel(u32 v, u32 offs, struct __prci_data *pd)
+{
+	return writel_relaxed(v, pd->va + offs);
+}
+
+/* WRPLL-related private functions */
+
+/**
+ * __prci_wrpll_unpack() - unpack WRPLL configuration registers into parameters
+ * @c: ptr to a struct analogbits_wrpll_cfg record to write config into
+ * @r: value read from the PRCI PLL configuration register
+ *
+ * Given a value @r read from an FU540 PRCI PLL configuration register,
+ * split it into fields and populate it into the WRPLL configuration record
+ * pointed to by @c.
+ *
+ * The COREPLLCFG0 macros are used below, but the other *PLLCFG0 macros
+ * have the same register layout.
+ *
+ * Context: Any context.
+ */
+static void __prci_wrpll_unpack(struct analogbits_wrpll_cfg *c, u32 r)
+{
+	u32 v;
+
+	v = r & PRCI_COREPLLCFG0_DIVR_MASK;
+	v >>= PRCI_COREPLLCFG0_DIVR_SHIFT;
+	c->divr = v;
+
+	v = r & PRCI_COREPLLCFG0_DIVF_MASK;
+	v >>= PRCI_COREPLLCFG0_DIVF_SHIFT;
+	c->divf = v;
+
+	v = r & PRCI_COREPLLCFG0_DIVQ_MASK;
+	v >>= PRCI_COREPLLCFG0_DIVQ_SHIFT;
+	c->divq = v;
+
+	v = r & PRCI_COREPLLCFG0_RANGE_MASK;
+	v >>= PRCI_COREPLLCFG0_RANGE_SHIFT;
+	c->range = v;
+
+	c->flags &= (WRPLL_FLAGS_INT_FEEDBACK_MASK |
+		     WRPLL_FLAGS_EXT_FEEDBACK_MASK);
+
+	if (r & PRCI_COREPLLCFG0_FSE_MASK)
+		c->flags |= WRPLL_FLAGS_INT_FEEDBACK_MASK;
+	else
+		c->flags |= WRPLL_FLAGS_EXT_FEEDBACK_MASK;
+}
+
+/**
+ * __prci_wrpll_pack() - pack PLL configuration parameters into a register value
+ * @c: pointer to a struct analogbits_wrpll_cfg record containing the PLL's cfg
+ *
+ * Using a set of WRPLL configuration values pointed to by @c,
+ * assemble a PRCI PLL configuration register value, and return it to
+ * the caller.
+ *
+ * Context: Any context.  Caller must ensure that the contents of the
+ *          record pointed to by @c do not change during the execution
+ *          of this function.
+ *
+ * Returns: a value suitable for writing into a PRCI PLL configuration
+ *          register
+ */
+static u32 __prci_wrpll_pack(struct analogbits_wrpll_cfg *c)
+{
+	u32 r = 0;
+
+	r |= c->divr << PRCI_COREPLLCFG0_DIVR_SHIFT;
+	r |= c->divf << PRCI_COREPLLCFG0_DIVF_SHIFT;
+	r |= c->divq << PRCI_COREPLLCFG0_DIVQ_SHIFT;
+	r |= c->range << PRCI_COREPLLCFG0_RANGE_SHIFT;
+	if (c->flags & WRPLL_FLAGS_INT_FEEDBACK_MASK)
+		r |= PRCI_COREPLLCFG0_FSE_MASK;
+
+	return r;
+}
+
+/**
+ * __prci_wrpll_read_cfg() - read the WRPLL configuration from the PRCI
+ * @pd: PRCI context
+ * @pwd: PRCI WRPLL metadata
+ *
+ * Read the current configuration of the PLL identified by @pwd from
+ * the PRCI identified by @pd, and store it into the local configuration
+ * cache in @pwd.
+ *
+ * Context: Any context.  Caller must prevent the records pointed to by
+ *          @pd and @pwd from changing during execution.
+ */
+static void __prci_wrpll_read_cfg(struct __prci_data *pd,
+				  struct __prci_wrpll_data *pwd)
+{
+	__prci_wrpll_unpack(&pwd->c, __prci_readl(pd, pwd->cfg0_offs));
+}
+
+/**
+ * __prci_wrpll_write_cfg() - write WRPLL configuration into the PRCI
+ * @pd: PRCI context
+ * @pwd: PRCI WRPLL metadata
+ * @c: WRPLL configuration record to write
+ *
+ * Write the WRPLL configuration described by @c into the WRPLL
+ * configuration register identified by @pwd in the PRCI instance
+ * described by @c.  Make a cached copy of the WRPLL's current
+ * configuration so it can be used by other code.
+ *
+ * Context: Any context.  Caller must prevent the records pointed to by
+ *          @pd and @pwd from changing during execution.
+ */
+static void __prci_wrpll_write_cfg(struct __prci_data *pd,
+				   struct __prci_wrpll_data *pwd,
+				   struct analogbits_wrpll_cfg *c)
+{
+	__prci_writel(__prci_wrpll_pack(c), pwd->cfg0_offs, pd);
+
+	memcpy(&pwd->c, c, sizeof(struct analogbits_wrpll_cfg));
+}
+
+/* Core clock mux control */
+
+/**
+ * __prci_coreclksel_use_hfclk() - switch the CORECLK mux to output HFCLK
+ * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
+ *
+ * Switch the CORECLK mux to the HFCLK input source; return once complete.
+ *
+ * Context: Any context.  Caller must prevent concurrent changes to the
+ *          PRCI_CORECLKSEL_OFFSET register.
+ */
+static void __prci_coreclksel_use_hfclk(struct __prci_data *pd)
+{
+	u32 r;
+
+	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
+	r |= PRCI_CORECLKSEL_CORECLKSEL_MASK;
+	__prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
+
+	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET); /* barrier */
+}
+
+/**
+ * __prci_coreclksel_use_corepll() - switch the CORECLK mux to output COREPLL
+ * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
+ *
+ * Switch the CORECLK mux to the PLL output clock; return once complete.
+ *
+ * Context: Any context.  Caller must prevent concurrent changes to the
+ *          PRCI_CORECLKSEL_OFFSET register.
+ */
+static void __prci_coreclksel_use_corepll(struct __prci_data *pd)
+{
+	u32 r;
+
+	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
+	r &= ~PRCI_CORECLKSEL_CORECLKSEL_MASK;
+	__prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
+
+	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET); /* barrier */
+}
+
+/*
+ * Linux clock framework integration
+ *
+ * See the Linux clock framework documentation for more information on
+ * these functions.
+ */
+
+static unsigned long sifive_fu540_prci_wrpll_recalc_rate(struct clk_hw *hw,
+							 unsigned long parent_rate)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_wrpll_data *pwd = pc->pwd;
+
+	return analogbits_wrpll_calc_output_rate(&pwd->c, parent_rate);
+}
+
+static long sifive_fu540_prci_wrpll_round_rate(struct clk_hw *hw,
+					       unsigned long rate,
+					       unsigned long *parent_rate)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_wrpll_data *pwd = pc->pwd;
+	struct analogbits_wrpll_cfg c;
+
+	memcpy(&c, &pwd->c, sizeof(c));
+
+	analogbits_wrpll_configure_for_rate(&c, rate, *parent_rate);
+
+	return analogbits_wrpll_calc_output_rate(&c, *parent_rate);
+}
+
+static int sifive_fu540_prci_wrpll_set_rate(struct clk_hw *hw,
+					    unsigned long rate,
+					    unsigned long parent_rate)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_wrpll_data *pwd = pc->pwd;
+	struct __prci_data *pd = pc->pd;
+	int r;
+
+	r = analogbits_wrpll_configure_for_rate(&pwd->c, rate, parent_rate);
+	if (r)
+		return -ERANGE;
+
+	if (pwd->bypass)
+		pwd->bypass(pd);
+
+	__prci_wrpll_write_cfg(pd, pwd, &pwd->c);
+
+	udelay(analogbits_wrpll_calc_max_lock_us(&pwd->c));
+
+	if (pwd->no_bypass)
+		pwd->no_bypass(pd);
+
+	return 0;
+}
+
+static const struct clk_ops sifive_fu540_prci_wrpll_clk_ops = {
+	.set_rate = sifive_fu540_prci_wrpll_set_rate,
+	.round_rate = sifive_fu540_prci_wrpll_round_rate,
+	.recalc_rate = sifive_fu540_prci_wrpll_recalc_rate,
+};
+
+static const struct clk_ops sifive_fu540_prci_wrpll_ro_clk_ops = {
+	.recalc_rate = sifive_fu540_prci_wrpll_recalc_rate,
+};
+
+/* TLCLKSEL clock integration */
+
+static unsigned long sifive_fu540_prci_tlclksel_recalc_rate(struct clk_hw *hw,
+							    unsigned long parent_rate)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_data *pd = pc->pd;
+	u32 v;
+	u8 div;
+
+	v = __prci_readl(pd, PRCI_CLKMUXSTATUSREG_OFFSET);
+	v &= PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_MASK;
+	div = v ? 1 : 2;
+
+	return div_u64(parent_rate, div);
+}
+
+static const struct clk_ops sifive_fu540_prci_tlclksel_clk_ops = {
+	.recalc_rate = sifive_fu540_prci_tlclksel_recalc_rate,
+};
+
+/*
+ * PRCI integration data for each WRPLL instance
+ */
+
+static struct __prci_wrpll_data __prci_corepll_data = {
+	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
+	.bypass = __prci_coreclksel_use_hfclk,
+	.no_bypass = __prci_coreclksel_use_corepll,
+};
+
+static struct __prci_wrpll_data __prci_ddrpll_data = {
+	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
+};
+
+static struct __prci_wrpll_data __prci_gemgxlpll_data = {
+	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
+};
+
+/*
+ * List of clock controls provided by the PRCI
+ */
+
+static struct __prci_clock __prci_init_clocks[] = {
+	[PRCI_CLK_COREPLL] = {
+		.name = "corepll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu540_prci_wrpll_clk_ops,
+		.pwd = &__prci_corepll_data,
+	},
+	[PRCI_CLK_DDRPLL] = {
+		.name = "ddrpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu540_prci_wrpll_ro_clk_ops,
+		.pwd = &__prci_ddrpll_data,
+	},
+	[PRCI_CLK_GEMGXLPLL] = {
+		.name = "gemgxlpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu540_prci_wrpll_clk_ops,
+		.pwd = &__prci_gemgxlpll_data,
+	},
+	[PRCI_CLK_TLCLK] = {
+		.name = "tlclk",
+		.parent_name = "corepll",
+		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
+	},
+};
+
+/**
+ * __prci_register_clocks() - register clock controls in the PRCI with Linux
+ * @dev: Linux struct device *
+ *
+ * Register the list of clock controls described in __prci_init_plls[] with
+ * the Linux clock framework.
+ *
+ * Return: 0 upon success or a negative Linux error code upon failure.
+ */
+static int __prci_register_clocks(struct device *dev)
+{
+	struct __prci_data *pd = dev_get_drvdata(dev);
+	struct clk_init_data init;
+	struct __prci_clock *pic;
+	int parent_count, i, clk_hw_count, r;
+
+	parent_count = of_clk_get_parent_count(dev->of_node);
+	if (parent_count != EXPECTED_CLK_PARENT_COUNT) {
+		dev_err(dev, "expected two parent clocks, only found %d\n",
+			parent_count);
+		return -EINVAL;
+	}
+
+	memset(&init, 0, sizeof(struct clk_init_data));
+
+	/* Register PLLs */
+	clk_hw_count = sizeof(__prci_init_clocks) / sizeof(struct __prci_clock);
+
+	for (i = 0; i < clk_hw_count; ++i) {
+		pic = &__prci_init_clocks[i];
+
+		init.name = pic->name;
+		init.parent_names = (const char *[]) { pic->parent_name };
+		init.num_parents = 1;
+		init.ops = pic->ops;
+		init.flags = CLK_IGNORE_UNUSED;
+		pic->hw.init = &init;
+
+		pic->pd = pd;
+
+		if (pic->pwd)
+			__prci_wrpll_read_cfg(pd, pic->pwd);
+
+		r = devm_clk_hw_register(dev, &pic->hw);
+		if (r) {
+			dev_warn(dev, "Failed to register clock %s: %d\n",
+				 init.name, r);
+			return r;
+		}
+
+		r = clk_hw_register_clkdev(&pic->hw, pic->name, dev_name(dev));
+		if (r) {
+			dev_warn(dev, "Failed to register clkdev for %s: %d\n",
+				 init.name, r);
+			return r;
+		}
+
+		pd->hw_clks.hws[i] = &pic->hw;
+	}
+
+	pd->hw_clks.num = i;
+
+	r = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					&pd->hw_clks);
+	if (r) {
+		dev_err(dev, "could not add hw_provider: %d\n", r);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Linux device model integration
+ *
+ * See the Linux device model documentation for more information about
+ * these functions.
+ */
+static int sifive_fu540_prci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct __prci_data *pd;
+	int r;
+
+	pd = devm_kzalloc(dev, sizeof(struct __prci_data), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, pd);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pd->va = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pd->va))
+		return PTR_ERR(pd->va);
+
+	r = __prci_register_clocks(dev);
+	if (r) {
+		dev_err(dev, "could not register clocks: %d\n", r);
+		return -EINVAL;
+	}
+
+	dev_info(dev, "SiFive FU540 PRCI probed\n");
+
+	return 0;
+}
+
+static const struct of_device_id sifive_fu540_prci_of_match[] = {
+	{ .compatible = "sifive,fu540-c000-prci0", },
+	{}
+};
+
+static struct platform_driver sifive_fu540_prci_driver = {
+	.driver	= {
+		.name = "sifive-fu540-prci",
+		.of_match_table = sifive_fu540_prci_of_match,
+	},
+	.probe = sifive_fu540_prci_probe,
+};
+
+static int __init sifive_fu540_prci_init(void)
+{
+	return platform_driver_register(&sifive_fu540_prci_driver);
+}
+core_initcall(sifive_fu540_prci_init);
diff --git a/include/linux/clk/sifive-fu540-prci.h b/include/linux/clk/sifive-fu540-prci.h
new file mode 100644
index 000000000000..5d03eae7d4ef
--- /dev/null
+++ b/include/linux/clk/sifive-fu540-prci.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 SiFive, Inc.
+ * Wesley Terpstra
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_CLK_SIFIVE_FU540_PRCI_H
+#define __LINUX_CLK_SIFIVE_FU540_PRCI_H
+
+/* Clock indexes for use by Device Tree data */
+
+#define PRCI_CLK_COREPLL		0
+#define PRCI_CLK_DDRPLL			1
+#define PRCI_CLK_GEMGXLPLL		2
+#define PRCI_CLK_TLCLK			3
+
+#endif
-- 
2.19.1

