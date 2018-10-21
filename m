Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E313BECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848252083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 18:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0Fx0pic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848252083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeJVCrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 22:47:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36894 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbeJVCrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 22:47:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so18774826pfi.4;
        Sun, 21 Oct 2018 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wDGST9YjPG3al/MimzetNy3VK4Rt7hKBF5GZGqlTh4=;
        b=B0Fx0picPqCoLfCOFQSZHeayucwttSMYU6RGDzp2/j4Cx2v2ql7lFnWWGm1TubPna6
         KaNFlzsjRv6QmYrjLXCE6gBMxXXbYJZ2en7aHZ+MslHyUQw3H7Vgyo8nFKEAjKR1wjP7
         dMTAVj47/T3Eof5V04/P8EOpmoNddHgJUkM+hzKagSnlCjehNs0vFZz98+/O9bzEBlSS
         /LVTWqhGKJOleuBmq4sdqwIJUPHSde9AjYaYi0lxZvPPvQNy8hDVbKIdeHwyAa4HSfhv
         RrGhcPu05nDZTS2C+PgQNhkUsjkJlupx3anjOMBYq94RiJ1LHGjNwPh+gc3xQ2n7VsGa
         byEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wDGST9YjPG3al/MimzetNy3VK4Rt7hKBF5GZGqlTh4=;
        b=kWxnvoI7EuHJRRS0TI0lVvDhJrwS9f9mymU29NHr0HBIRdVZdvLbOP3kqjsdEAFj8x
         lIXv6FvrcSuc4icW+feh+UQC5bZU5P0yPI9H5IzQEP5iQs0TohUCp/iqP80+mUNp7C0A
         UBZ8SE7R9g9YjQNTP1vpaNPMGVzIzYqYjxgtQgxBQT+sualrpF4SgN2AOxb7HHlIDuWe
         sMkBjp0SzcqSGLnO6dT7oEGRSh+iG+z6kQfnQRLizsAtpXf92QnNWKKIff2xKGuz4JmH
         kVCasJKeO35ZHZ4o2gDsMS/809KXbJRKyr3nnK8CxZz9GphIXqXPiC/7Ei+Slwem7aSc
         GpRA==
X-Gm-Message-State: ABuFfojbRLnwUfr9tSy92EbZjPU/cYoalOM5qzW0ilML38zRgX42asWh
        7flfhwH9cfLrEXM4cHOK087CmhyT
X-Google-Smtp-Source: ACcGV61BmrqX8ysWqPE1YrTqFlXj22rvwVubUMuETKJ9zlqF9oDGg7ZralUhj8MaiUBCgnsq7/9VxA==
X-Received: by 2002:a62:cac4:: with SMTP id y65-v6mr42504224pfk.27.1540146747046;
        Sun, 21 Oct 2018 11:32:27 -0700 (PDT)
Received: from localhost.localdomain ([109.252.91.118])
        by smtp.gmail.com with ESMTPSA id v5-v6sm45467047pfd.64.2018.10.21.11.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 11:32:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] memory: tegra: Introduce Tegra20 EMC driver
Date:   Sun, 21 Oct 2018 21:30:52 +0300
Message-Id: <20181021183052.32023-9-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021183052.32023-1-digetx@gmail.com>
References: <20181021183052.32023-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce driver for the External Memory Controller (EMC) found on Tegra20
chips, which controls the external DRAM on the board. The purpose of this
driver is to program memory timing for external memory on the EMC clock
rate change.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/memory/tegra/Kconfig       |  10 +
 drivers/memory/tegra/Makefile      |   1 +
 drivers/memory/tegra/tegra20-emc.c | 591 +++++++++++++++++++++++++++++
 3 files changed, 602 insertions(+)
 create mode 100644 drivers/memory/tegra/tegra20-emc.c

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index 6d74e499e18d..34e0b70f5c5f 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -6,6 +6,16 @@ config TEGRA_MC
 	  This driver supports the Memory Controller (MC) hardware found on
 	  NVIDIA Tegra SoCs.
 
+config TEGRA20_EMC
+	bool "NVIDIA Tegra20 External Memory Controller driver"
+	default y
+	depends on ARCH_TEGRA_2x_SOC
+	help
+	  This driver is for the External Memory Controller (EMC) found on
+	  Tegra20 chips. The EMC controls the external DRAM on the board.
+	  This driver is required to change memory timings / clock rate for
+	  external memory.
+
 config TEGRA124_EMC
 	bool "NVIDIA Tegra124 External Memory Controller driver"
 	default y
diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
index 94ab16ba075b..3971a6b7c487 100644
--- a/drivers/memory/tegra/Makefile
+++ b/drivers/memory/tegra/Makefile
@@ -10,5 +10,6 @@ tegra-mc-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210.o
 
 obj-$(CONFIG_TEGRA_MC) += tegra-mc.o
 
+obj-$(CONFIG_TEGRA20_EMC)  += tegra20-emc.o
 obj-$(CONFIG_TEGRA124_EMC) += tegra124-emc.o
 obj-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186.o
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
new file mode 100644
index 000000000000..9ee5bef49e47
--- /dev/null
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tegra20 External Memory Controller driver
+ *
+ * Author: Dmitry Osipenko <digetx@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/sort.h>
+#include <linux/types.h>
+
+#include <soc/tegra/fuse.h>
+
+#define EMC_INTSTATUS				0x000
+#define EMC_INTMASK				0x004
+#define EMC_TIMING_CONTROL			0x028
+#define EMC_RC					0x02c
+#define EMC_RFC					0x030
+#define EMC_RAS					0x034
+#define EMC_RP					0x038
+#define EMC_R2W					0x03c
+#define EMC_W2R					0x040
+#define EMC_R2P					0x044
+#define EMC_W2P					0x048
+#define EMC_RD_RCD				0x04c
+#define EMC_WR_RCD				0x050
+#define EMC_RRD					0x054
+#define EMC_REXT				0x058
+#define EMC_WDV					0x05c
+#define EMC_QUSE				0x060
+#define EMC_QRST				0x064
+#define EMC_QSAFE				0x068
+#define EMC_RDV					0x06c
+#define EMC_REFRESH				0x070
+#define EMC_BURST_REFRESH_NUM			0x074
+#define EMC_PDEX2WR				0x078
+#define EMC_PDEX2RD				0x07c
+#define EMC_PCHG2PDEN				0x080
+#define EMC_ACT2PDEN				0x084
+#define EMC_AR2PDEN				0x088
+#define EMC_RW2PDEN				0x08c
+#define EMC_TXSR				0x090
+#define EMC_TCKE				0x094
+#define EMC_TFAW				0x098
+#define EMC_TRPAB				0x09c
+#define EMC_TCLKSTABLE				0x0a0
+#define EMC_TCLKSTOP				0x0a4
+#define EMC_TREFBW				0x0a8
+#define EMC_QUSE_EXTRA				0x0ac
+#define EMC_ODT_WRITE				0x0b0
+#define EMC_ODT_READ				0x0b4
+#define EMC_FBIO_CFG5				0x104
+#define EMC_FBIO_CFG6				0x114
+#define EMC_AUTO_CAL_INTERVAL			0x2a8
+#define EMC_CFG_2				0x2b8
+#define EMC_CFG_DIG_DLL				0x2bc
+#define EMC_DLL_XFORM_DQS			0x2c0
+#define EMC_DLL_XFORM_QUSE			0x2c4
+#define EMC_ZCAL_REF_CNT			0x2e0
+#define EMC_ZCAL_WAIT_CNT			0x2e4
+#define EMC_CFG_CLKTRIM_0			0x2d0
+#define EMC_CFG_CLKTRIM_1			0x2d4
+#define EMC_CFG_CLKTRIM_2			0x2d8
+
+#define EMC_CLKCHANGE_REQ_ENABLE		BIT(0)
+#define EMC_CLKCHANGE_PD_ENABLE			BIT(1)
+#define EMC_CLKCHANGE_SR_ENABLE			BIT(2)
+
+#define EMC_TIMING_UPDATE			BIT(0)
+
+#define EMC_REFRESH_OVERFLOW_INT		BIT(3)
+#define EMC_CLKCHANGE_COMPLETE_INT		BIT(4)
+
+static const u16 emc_timing_registers[] = {
+	EMC_RC,
+	EMC_RFC,
+	EMC_RAS,
+	EMC_RP,
+	EMC_R2W,
+	EMC_W2R,
+	EMC_R2P,
+	EMC_W2P,
+	EMC_RD_RCD,
+	EMC_WR_RCD,
+	EMC_RRD,
+	EMC_REXT,
+	EMC_WDV,
+	EMC_QUSE,
+	EMC_QRST,
+	EMC_QSAFE,
+	EMC_RDV,
+	EMC_REFRESH,
+	EMC_BURST_REFRESH_NUM,
+	EMC_PDEX2WR,
+	EMC_PDEX2RD,
+	EMC_PCHG2PDEN,
+	EMC_ACT2PDEN,
+	EMC_AR2PDEN,
+	EMC_RW2PDEN,
+	EMC_TXSR,
+	EMC_TCKE,
+	EMC_TFAW,
+	EMC_TRPAB,
+	EMC_TCLKSTABLE,
+	EMC_TCLKSTOP,
+	EMC_TREFBW,
+	EMC_QUSE_EXTRA,
+	EMC_FBIO_CFG6,
+	EMC_ODT_WRITE,
+	EMC_ODT_READ,
+	EMC_FBIO_CFG5,
+	EMC_CFG_DIG_DLL,
+	EMC_DLL_XFORM_DQS,
+	EMC_DLL_XFORM_QUSE,
+	EMC_ZCAL_REF_CNT,
+	EMC_ZCAL_WAIT_CNT,
+	EMC_AUTO_CAL_INTERVAL,
+	EMC_CFG_CLKTRIM_0,
+	EMC_CFG_CLKTRIM_1,
+	EMC_CFG_CLKTRIM_2,
+};
+
+struct emc_timing {
+	unsigned long rate;
+	u32 data[ARRAY_SIZE(emc_timing_registers)];
+};
+
+struct tegra_emc {
+	struct device *dev;
+	struct completion clk_handshake_complete;
+	struct notifier_block clk_nb;
+	struct clk *backup_clk;
+	struct clk *emc_mux;
+	struct clk *pll_m;
+	struct clk *clk;
+	void __iomem *regs;
+
+	struct emc_timing *timings;
+	unsigned int num_timings;
+};
+
+static irqreturn_t tegra_emc_isr(int irq, void *data)
+{
+	struct tegra_emc *emc = data;
+	u32 intmask = EMC_REFRESH_OVERFLOW_INT | EMC_CLKCHANGE_COMPLETE_INT;
+	u32 status;
+
+	status = readl_relaxed(emc->regs + EMC_INTSTATUS) & intmask;
+	if (!status)
+		return IRQ_NONE;
+
+	/* notify about EMC-CAR handshake completion */
+	if (status & EMC_CLKCHANGE_COMPLETE_INT)
+		complete(&emc->clk_handshake_complete);
+
+	/* notify about HW problem */
+	if (status & EMC_REFRESH_OVERFLOW_INT)
+		dev_err_ratelimited(emc->dev,
+				    "refresh request overflow timeout\n");
+
+	/* clear interrupts */
+	writel_relaxed(status, emc->regs + EMC_INTSTATUS);
+
+	return IRQ_HANDLED;
+}
+
+static struct emc_timing *tegra_emc_find_timing(struct tegra_emc *emc,
+						unsigned long rate)
+{
+	struct emc_timing *timing = NULL;
+	unsigned int i;
+
+	for (i = 0; i < emc->num_timings; i++) {
+		if (emc->timings[i].rate >= rate) {
+			timing = &emc->timings[i];
+			break;
+		}
+	}
+
+	if (!timing) {
+		dev_err(emc->dev, "no timing for rate %lu\n", rate);
+		return NULL;
+	}
+
+	return timing;
+}
+
+static int emc_prepare_timing_change(struct tegra_emc *emc, unsigned long rate)
+{
+	struct emc_timing *timing = tegra_emc_find_timing(emc, rate);
+	unsigned int i;
+
+	if (!timing)
+		return -EINVAL;
+
+	dev_dbg(emc->dev, "%s: using timing rate %lu for requested rate %lu\n",
+		__func__, timing->rate, rate);
+
+	/* program shadow registers */
+	for (i = 0; i < ARRAY_SIZE(timing->data); i++)
+		writel_relaxed(timing->data[i],
+			       emc->regs + emc_timing_registers[i]);
+
+	/* wait until programming has settled */
+	readl_relaxed(emc->regs + emc_timing_registers[i - 1]);
+
+	reinit_completion(&emc->clk_handshake_complete);
+
+	return 0;
+}
+
+static int emc_complete_timing_change(struct tegra_emc *emc, bool flush)
+{
+	long timeout;
+
+	dev_dbg(emc->dev, "%s: flush %d\n", __func__, flush);
+
+	if (flush) {
+		/* manually initiate memory timing update */
+		writel_relaxed(EMC_TIMING_UPDATE,
+			       emc->regs + EMC_TIMING_CONTROL);
+		return 0;
+	}
+
+	timeout = wait_for_completion_timeout(&emc->clk_handshake_complete,
+					      usecs_to_jiffies(100));
+	if (timeout == 0) {
+		dev_err(emc->dev, "EMC-CAR handshake failed\n");
+		return -EIO;
+	} else if (timeout < 0) {
+		dev_err(emc->dev, "failed to wait for EMC-CAR handshake: %ld\n",
+			timeout);
+		return timeout;
+	}
+
+	return 0;
+}
+
+static int tegra_emc_clk_change_notify(struct notifier_block *nb,
+				       unsigned long msg, void *data)
+{
+	struct tegra_emc *emc = container_of(nb, struct tegra_emc, clk_nb);
+	struct clk_notifier_data *cnd = data;
+	int err;
+
+	switch (msg) {
+	case PRE_RATE_CHANGE:
+		err = emc_prepare_timing_change(emc, cnd->new_rate);
+		break;
+
+	case ABORT_RATE_CHANGE:
+		err = emc_prepare_timing_change(emc, cnd->old_rate);
+		if (err)
+			break;
+
+		err = emc_complete_timing_change(emc, true);
+		break;
+
+	case POST_RATE_CHANGE:
+		err = emc_complete_timing_change(emc, false);
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return notifier_from_errno(err);
+}
+
+static int load_one_timing_from_dt(struct tegra_emc *emc,
+				   struct emc_timing *timing,
+				   struct device_node *node)
+{
+	u32 rate;
+	int err;
+
+	if (!of_device_is_compatible(node, "nvidia,tegra20-emc-table")) {
+		dev_err(emc->dev, "incompatible DT node: %pOF\n", node);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(node, "clock-frequency", &rate);
+	if (err) {
+		dev_err(emc->dev, "timing %pOF: failed to read rate: %d\n",
+			node, err);
+		return err;
+	}
+
+	err = of_property_read_u32_array(node, "nvidia,emc-registers",
+					 timing->data,
+					 ARRAY_SIZE(emc_timing_registers));
+	if (err) {
+		dev_err(emc->dev,
+			"timing %pOF: failed to read emc timing data: %d\n",
+			node, err);
+		return err;
+	}
+
+	/*
+	 * The EMC clock rate is twice the bus rate, and the bus rate is
+	 * measured in kHz.
+	 */
+	timing->rate = rate * 2 * 1000;
+
+	dev_dbg(emc->dev, "%s: %pOF: EMC rate %lu\n",
+		__func__, node, timing->rate);
+
+	return 0;
+}
+
+static int cmp_timings(const void *_a, const void *_b)
+{
+	const struct emc_timing *a = _a;
+	const struct emc_timing *b = _b;
+
+	if (a->rate < b->rate)
+		return -1;
+
+	if (a->rate > b->rate)
+		return 1;
+
+	return 0;
+}
+
+static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
+					  struct device_node *node)
+{
+	struct device_node *child;
+	struct emc_timing *timing;
+	int child_count;
+	int err;
+
+	child_count = of_get_child_count(node);
+	if (!child_count) {
+		dev_err(emc->dev, "no memory timings in DT node: %pOF\n", node);
+		return -EINVAL;
+	}
+
+	emc->timings = devm_kcalloc(emc->dev, child_count, sizeof(*timing),
+				    GFP_KERNEL);
+	if (!emc->timings)
+		return -ENOMEM;
+
+	emc->num_timings = child_count;
+	timing = emc->timings;
+
+	for_each_child_of_node(node, child) {
+		err = load_one_timing_from_dt(emc, timing++, child);
+		if (err) {
+			of_node_put(child);
+			return err;
+		}
+	}
+
+	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
+	     NULL);
+
+	return 0;
+}
+
+static struct device_node *
+tegra_emc_find_node_by_ram_code(struct device *dev)
+{
+	struct device_node *np;
+	u32 value, ram_code;
+	int err;
+
+	if (!of_property_read_bool(dev->of_node, "nvidia,use-ram-code"))
+		return of_node_get(dev->of_node);
+
+	ram_code = tegra_read_ram_code();
+
+	for (np = of_find_node_by_name(dev->of_node, "emc-tables"); np;
+	     np = of_find_node_by_name(np, "emc-tables")) {
+		err = of_property_read_u32(np, "nvidia,ram-code", &value);
+		if (err || value != ram_code) {
+			of_node_put(np);
+			continue;
+		}
+
+		return np;
+	}
+
+	dev_err(dev, "no memory timings for RAM code %u found in device tree\n",
+		ram_code);
+
+	return NULL;
+}
+
+static int emc_setup_hw(struct tegra_emc *emc)
+{
+	u32 intmask = EMC_REFRESH_OVERFLOW_INT | EMC_CLKCHANGE_COMPLETE_INT;
+	u32 emc_cfg;
+
+	emc_cfg = readl_relaxed(emc->regs + EMC_CFG_2);
+
+	/*
+	 * Depending on a memory type, DRAM should enter either self-refresh
+	 * or power-down state on EMC clock change.
+	 */
+	if (!(emc_cfg & EMC_CLKCHANGE_PD_ENABLE) &&
+	    !(emc_cfg & EMC_CLKCHANGE_SR_ENABLE)) {
+		dev_err(emc->dev,
+			"bootloader didn't specify DRAM auto-suspend mode\n");
+		return -EINVAL;
+	}
+
+	/* enable EMC and CAR to handshake on PLL divider/source changes */
+	emc_cfg |= EMC_CLKCHANGE_REQ_ENABLE;
+	writel_relaxed(emc_cfg, emc->regs + EMC_CFG_2);
+
+	/* initialize interrupt */
+	writel_relaxed(intmask, emc->regs + EMC_INTMASK);
+	writel_relaxed(intmask, emc->regs + EMC_INTSTATUS);
+
+	return 0;
+}
+
+static int emc_init(struct tegra_emc *emc, unsigned long rate)
+{
+	int err;
+
+	err = clk_set_parent(emc->emc_mux, emc->backup_clk);
+	if (err) {
+		dev_err(emc->dev,
+			"failed to reparent to backup source: %d\n", err);
+		return err;
+	}
+
+	err = clk_set_rate(emc->pll_m, rate);
+	if (err) {
+		dev_err(emc->dev,
+			"failed to change pll_m rate: %d\n", err);
+		return err;
+	}
+
+	err = clk_set_parent(emc->emc_mux, emc->pll_m);
+	if (err) {
+		dev_err(emc->dev,
+			"failed to reparent to pll_m: %d\n", err);
+		return err;
+	}
+
+	err = clk_set_rate(emc->clk, rate);
+	if (err) {
+		dev_err(emc->dev,
+			"failed to change emc rate: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int tegra_emc_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	struct tegra_emc *emc;
+	struct resource *res;
+	int irq, err;
+
+	/* driver has nothing to do in a case of memory timing absence */
+	if (of_get_child_count(pdev->dev.of_node) == 0) {
+		dev_info(&pdev->dev,
+			 "EMC device tree node doesn't have memory timings\n");
+		return 0;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "interrupt not specified\n");
+		dev_err(&pdev->dev, "please update your device tree\n");
+		return irq;
+	}
+
+	np = tegra_emc_find_node_by_ram_code(&pdev->dev);
+	if (!np)
+		return -EINVAL;
+
+	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
+	if (!emc) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	init_completion(&emc->clk_handshake_complete);
+	emc->clk_nb.notifier_call = tegra_emc_clk_change_notify;
+	emc->dev = &pdev->dev;
+
+	err = tegra_emc_load_timings_from_dt(emc, np);
+	of_node_put(np);
+	if (err)
+		return err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	emc->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(emc->regs))
+		return PTR_ERR(emc->regs);
+
+	err = emc_setup_hw(emc);
+	if (err)
+		return err;
+
+	err = devm_request_irq(&pdev->dev, irq, tegra_emc_isr, 0,
+			       dev_name(&pdev->dev), emc);
+	if (err) {
+		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", irq, err);
+		return err;
+	}
+
+	emc->clk = devm_clk_get(&pdev->dev, "emc");
+	if (IS_ERR(emc->clk)) {
+		err = PTR_ERR(emc->clk);
+		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
+		return err;
+	}
+
+	emc->pll_m = clk_get_sys(NULL, "pll_m");
+	if (IS_ERR(emc->pll_m)) {
+		err = PTR_ERR(emc->pll_m);
+		dev_err(&pdev->dev, "failed to get pll_m clock: %d\n", err);
+		return err;
+	}
+
+	emc->backup_clk = clk_get_sys(NULL, "pll_p");
+	if (IS_ERR(emc->backup_clk)) {
+		err = PTR_ERR(emc->backup_clk);
+		dev_err(&pdev->dev, "failed to get pll_p clock: %d\n", err);
+		goto put_pll_m;
+	}
+
+	emc->emc_mux = clk_get_parent(emc->clk);
+	if (IS_ERR(emc->emc_mux)) {
+		err = PTR_ERR(emc->emc_mux);
+		dev_err(&pdev->dev, "failed to get emc_mux clock: %d\n", err);
+		goto put_backup;
+	}
+
+	err = clk_notifier_register(emc->clk, &emc->clk_nb);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
+			err);
+		goto put_backup;
+	}
+
+	/* set DRAM clock rate to maximum */
+	err = emc_init(emc, emc->timings[emc->num_timings - 1].rate);
+	if (err) {
+		dev_err(&pdev->dev, "failed to initialize EMC clock rate: %d\n",
+			err);
+		goto unreg_notifier;
+	}
+
+	return 0;
+
+unreg_notifier:
+	clk_notifier_unregister(emc->clk, &emc->clk_nb);
+put_backup:
+	clk_put(emc->backup_clk);
+put_pll_m:
+	clk_put(emc->pll_m);
+
+	return err;
+}
+
+static const struct of_device_id tegra_emc_of_match[] = {
+	{ .compatible = "nvidia,tegra20-emc", },
+	{},
+};
+
+static struct platform_driver tegra_emc_driver = {
+	.probe = tegra_emc_probe,
+	.driver = {
+		.name = "tegra20-emc",
+		.of_match_table = tegra_emc_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int __init tegra_emc_init(void)
+{
+	return platform_driver_register(&tegra_emc_driver);
+}
+subsys_initcall(tegra_emc_init);
-- 
2.19.0

