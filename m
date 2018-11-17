Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB41C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F253220815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oK5kjmMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F253220815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeKQVfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:35:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38492 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKQVe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:34:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id e3-v6so27379013wrs.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 03:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XuyrEGD6TS4oyB2tx9zjUDIbcyg/HEYa7VZtQJcCKsc=;
        b=oK5kjmMSqm7DpBPr4kYLFrkMLq+CcVFy1CVvoDsJWuziED8PIb8JjIp9r452m9c2w2
         GzrwlswND/IBL6UFZK2wmOybnTFfKfvhbcEnvvWCFILQkzFtnuztdd45KUXPIOMakyip
         +Ih92se2GI25Sk/kBlu7weaE7LC/twY9D8x6VPirLqmOUkWXgIf4kbLzlh7r+vf3tX5G
         iznINvO1wjByCr7MUnKOYThvGisvJ6Nv3J0jJ/9SF00v68kbo8iJ3HdWAuTxwcJSAfit
         kVQtmC+WfEpBDdQNi/pbYROrGjopm1Ys2BWldbcRXQ8m+mxCNFPgHBtp5xizTqjfvGwX
         cZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XuyrEGD6TS4oyB2tx9zjUDIbcyg/HEYa7VZtQJcCKsc=;
        b=cZjwfdR+/JCstK5s8HiO81g7blf3odPow2p3qIiytYcI4GGrXV5AJf7cdVe0+NGMTc
         5CtfA4eMfce5IXULPWNFEDLq+SUNtz954aYDhEb3YR0nmAsqpehxMpkK1+LuihPB0MZY
         GVEe+7VumovFmjMRCvDqU/QmFY94qBf9nP8+ku3Tw2gmAdBF5a4xmm83/Wxvi2hH4B3j
         JoSePr1r2VfZ5uq0a0kKt66fyYz+RdLABFG9of3mu33Kj/8RPxAZD4sd/I8PKZi7njCQ
         5zAWlGnhAVI5XMDCkikJP2E9JwKOeIcLacOnvfb7VYMPIUGrkuGVvgnYobd1KMjFsgVb
         +utg==
X-Gm-Message-State: AGRZ1gJvM88VcFKBrq6hx+xTGelzH3DjbtqurjXg9bbMeZSgxhXS8Apj
        6cybl4JTzgC1858JMeVMccxK4A==
X-Google-Smtp-Source: AJdET5cHkHcyntjKZzdNa7ujHTu7NJF8XyCODCGhnTYajhLlgcMBPjrF8LWdd4iIwXncyim0On2+YA==
X-Received: by 2002:adf:8b90:: with SMTP id o16-v6mr12745065wra.81.1542453515859;
        Sat, 17 Nov 2018 03:18:35 -0800 (PST)
Received: from localhost.localdomain (176-137-58-115.abo.bbox.fr. [176.137.58.115])
        by smtp.gmail.com with ESMTPSA id k5-v6sm50797646wre.82.2018.11.17.03.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 03:18:35 -0800 (PST)
From:   abailon@baylibre.com
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com.com>
Subject: [RFC PATCH 1/2] Add support of imx7ulp to interconnect framework
Date:   Sat, 17 Nov 2018 12:19:04 +0100
Message-Id: <20181117111905.29091-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181117111905.29091-1-abailon@baylibre.com>
References: <20181117111905.29091-1-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@baylibre.com>

This is a PoC of interconnect driver for the imx7ulp.
This scales the clock of nic0 and nic1 (the two interconnects).
In order too solve some issue with clocks (I will give more details
later in code), the bus topology described in the driver differ a little
from the one in the datasheet.
In addition, the driver manages nic0 and nic1 as an unique
interconnect. It would have been better to manage them separately but
it was harder to do it because of the clocks (again).
Later, I will add third clock for the MMDC endpoint, which is the
DDR controller. This will be used to scale the DDR in addition of
interconnect.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com.com>
---
 drivers/interconnect/Kconfig       |   1 +
 drivers/interconnect/Makefile      |   1 +
 drivers/interconnect/imx/Kconfig   |   9 +
 drivers/interconnect/imx/Makefile  |   1 +
 drivers/interconnect/imx/imx7ulp.c | 369 +++++++++++++++++++++++++++++
 5 files changed, 381 insertions(+)
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx7ulp.c

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index 07a8276fa35a..99955906bea8 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -11,5 +11,6 @@ menuconfig INTERCONNECT
 if INTERCONNECT
 
 source "drivers/interconnect/qcom/Kconfig"
+source "drivers/interconnect/imx/Kconfig"
 
 endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 7944cbca0527..4c8814fc2b4b 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_INTERCONNECT)		+= core.o
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
+obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
diff --git a/drivers/interconnect/imx/Kconfig b/drivers/interconnect/imx/Kconfig
new file mode 100644
index 000000000000..5eb88eafc1fd
--- /dev/null
+++ b/drivers/interconnect/imx/Kconfig
@@ -0,0 +1,9 @@
+config INTERCONNECT_IMX
+	bool "IMX Network-on-Chip interconnect drivers"
+	depends on INTERCONNECT
+	depends on ARCH_MXC
+	default y
+
+config INTERCONNECT_IMX7ULP
+	tristate "i.MX7ULP NIC-301 interconnect driver"
+	depends on INTERCONNECT_IMX
diff --git a/drivers/interconnect/imx/Makefile b/drivers/interconnect/imx/Makefile
new file mode 100644
index 000000000000..61d994b8fe2c
--- /dev/null
+++ b/drivers/interconnect/imx/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_INTERCONNECT_IMX7ULP) += imx7ulp.o
diff --git a/drivers/interconnect/imx/imx7ulp.c b/drivers/interconnect/imx/imx7ulp.c
new file mode 100644
index 000000000000..7715198ad151
--- /dev/null
+++ b/drivers/interconnect/imx/imx7ulp.c
@@ -0,0 +1,369 @@
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define IMX7ULP_MAX_LINKS	32
+
+/**
+ * Clock property of node
+ * @name: The name of the clock
+ * @clk: A pointer to the clock
+ * @rate: The rate to use, when the clock frequency is updated
+ */
+struct imx7ulp_bus_clock {
+	char *name;
+	struct clk *clk;
+	u64 rate;
+};
+
+/**
+ * IMX7ULP specific interconnect nodes
+ * @name: the node name used in debugfs
+ * @id: a unique node identifier
+ * @links: an array of nodes where we can go next while traversing
+ * @num_links: the total number of @links
+ * @buswidth: width (in bit) of the interconnect between a node and the bus
+ * @bus_clk: If not NULL, define clock properties of the node
+ * @ep: true if the node is an end point. Used to scale the frequency
+ */
+struct imx7ulp_icc_node {
+	char *name;
+	u16 id;
+	u16 links[IMX7ULP_MAX_LINKS];
+	u16 num_links;
+	u16 buswidth;
+	struct imx7ulp_bus_clock *bus_clk;
+	bool ep;
+};
+
+/**
+ * @dev: device pointer for the overall interconnect
+ *       Although there are 2 interconnects, they are represented using one
+ *       device.
+ * @nodes: Array of nodes
+ * @num_nodes: The total number of nodes
+ * @nic0: Clock properties for nic0 interconnect
+ * @nic1: Clock properties for nic1 interconnect
+ */
+struct imx7ulp_icc_desc {
+	struct device *dev;
+	struct imx7ulp_icc_node *nodes;
+	size_t num_nodes;
+	struct imx7ulp_bus_clock *nic0;
+	struct imx7ulp_bus_clock *nic1;
+};
+
+#define DEFINE_AXI_INTERCONNECT(_name, _id, _buswidth, _ep, _clk,	\
+				_numlinks, ...)				\
+	{								\
+		.id = _id,						\
+		.name = #_name,						\
+		.buswidth = (_buswidth * 4),				\
+		.num_links = _numlinks,					\
+		.links = { __VA_ARGS__ },				\
+		.ep = _ep,						\
+		.bus_clk = _clk,					\
+	}
+
+#define DEFINE_AXI_MASTER(_name, _id, _buswidth, dest_id)		\
+	DEFINE_AXI_INTERCONNECT(_name, _id, _buswidth, false, NULL,	\
+				1, dest_id)
+
+#define DEFINE_AXI_SLAVE(_name, _id, _buswidth, _numlinks, ...)		\
+	DEFINE_AXI_INTERCONNECT(_name, _id, _buswidth, false, NULL,	\
+				_numlinks, __VA_ARGS__)
+
+#define DEFINE_AXI_SLAVE_EP(_name, _id, _buswidth)			\
+	DEFINE_AXI_INTERCONNECT(_name, _id, _buswidth, true, NULL, 0, 0)
+
+#define DEFINE_AHB_SLAVE_EP(_name, _id)					\
+	DEFINE_AXI_SLAVE_EP(_name, _id, 4)
+
+static struct imx7ulp_bus_clock nic0_clock = {
+	.name = "nic0_div",
+};
+
+static struct imx7ulp_bus_clock nic1_clock = {
+	.name = "nic1_div",
+};
+
+static struct imx7ulp_icc_node imx7ulp_nodes[] = {
+	/* NIC0 Masters */
+	DEFINE_AXI_MASTER(a7, 2000, 16, 1000),
+	DEFINE_AXI_MASTER(nic1_s1, 2001, 8, 1000),
+	DEFINE_AXI_MASTER(dsi, 2002, 4, 1000),
+	DEFINE_AXI_MASTER(gpu3d, 2003, 8, 1000),
+	DEFINE_AXI_MASTER(gpu2d, 2004, 16, 1000),
+
+	/* NIC0 Slaves */
+	DEFINE_AXI_SLAVE_EP(mmdc, 2005, 16),
+	DEFINE_AXI_SLAVE_EP(sram0, 2006, 8),
+
+	/* NIC0 */
+	DEFINE_AXI_INTERCONNECT(nic0_m, 1000, 8, false, &nic0_clock, 1, 1001),
+	DEFINE_AXI_INTERCONNECT(nic0_s, 1001, 8, false, NULL, 3,
+				2005, 2006, 1008),
+
+	/* NIC1 Masters */
+	DEFINE_AXI_MASTER(dma1_m, 2011, 8, 1008),
+	DEFINE_AXI_MASTER(caam_m, 2013, 4, 1008),
+	DEFINE_AXI_MASTER(usbotg_m, 2014, 4, 1008),
+	DEFINE_AXI_MASTER(viu_m, 2015, 8, 1008),
+	DEFINE_AXI_MASTER(usdhc0_m, 2016, 4, 1008),
+	DEFINE_AXI_MASTER(usdhc1_m, 2017, 4, 1008),
+
+	/* NIC1 Slaves */
+	DEFINE_AXI_SLAVE_EP(sram1, 2018, 8),
+	DEFINE_AXI_SLAVE_EP(secure_ram, 2020, 4),
+	DEFINE_AXI_SLAVE_EP(rom, 2023, 4), /* Also flexbus, gpu 2d and 3d */
+	DEFINE_AXI_SLAVE_EP(m4xbar, 2024, 4),
+
+	/* AHB0 */
+	DEFINE_AHB_SLAVE_EP(dma1, 8),
+	DEFINE_AHB_SLAVE_EP(dmadesc1, 9),
+	DEFINE_AHB_SLAVE_EP(rgpio2p, 15),
+	DEFINE_AHB_SLAVE_EP(flexbus, 16),
+	DEFINE_AHB_SLAVE_EP(sema42_1, 27),
+	DEFINE_AHB_SLAVE_EP(dmamux1, 33),
+	DEFINE_AHB_SLAVE_EP(mu_b, 34),
+	DEFINE_AHB_SLAVE_EP(caam, 36),
+	DEFINE_AHB_SLAVE_EP(tpm4, 37),
+	DEFINE_AHB_SLAVE_EP(tpm5, 38),
+	DEFINE_AHB_SLAVE_EP(lpit1, 39),
+	DEFINE_AHB_SLAVE_EP(lpspi2, 41),
+	DEFINE_AHB_SLAVE_EP(lpspi3, 42),
+	DEFINE_AHB_SLAVE_EP(lpi2c4, 43),
+	DEFINE_AHB_SLAVE_EP(lpi2c5, 44),
+	DEFINE_AHB_SLAVE_EP(lpuart4, 45),
+	DEFINE_AHB_SLAVE_EP(lpuart5, 46),
+	DEFINE_AHB_SLAVE_EP(flexio1, 49),
+	DEFINE_AHB_SLAVE_EP(usbotg1, 51),
+	DEFINE_AHB_SLAVE_EP(usbotg2, 52),
+	DEFINE_AHB_SLAVE_EP(usbphy, 53),
+	DEFINE_AHB_SLAVE_EP(usbpl301, 54),
+	DEFINE_AHB_SLAVE_EP(usdhc0, 55),
+	DEFINE_AHB_SLAVE_EP(usdhc1, 56),
+	DEFINE_AHB_SLAVE_EP(trgmux1, 59),
+	DEFINE_AHB_SLAVE_EP(wdog1, 61),
+	DEFINE_AHB_SLAVE_EP(scg1, 62),
+	DEFINE_AHB_SLAVE_EP(pcc2, 63),
+	DEFINE_AHB_SLAVE_EP(pmc1, 64),
+	DEFINE_AHB_SLAVE_EP(cmc1, 65),
+	DEFINE_AHB_SLAVE_EP(wdog2, 67),
+
+	DEFINE_AXI_SLAVE(ahb0, 2021, 4, 32,
+			 8, 9, 15, 16, 27, 33, 34, 35, 36, 37, 38, 39, 41, 42,
+			 43, 44, 45, 46, 49, 51, 52, 53, 54, 55, 56, 59, 61, 62,
+			 63, 64, 65, 67),
+
+	/* AHB1 */
+	DEFINE_AHB_SLAVE_EP(romc1, 116),
+	DEFINE_AHB_SLAVE_EP(tpm6, 133),
+	DEFINE_AHB_SLAVE_EP(tpm7, 134),
+	DEFINE_AHB_SLAVE_EP(lpi2c6, 136),
+	DEFINE_AHB_SLAVE_EP(lpi2c7, 137),
+	DEFINE_AHB_SLAVE_EP(lpuart6, 138),
+	DEFINE_AHB_SLAVE_EP(lpuart7, 139),
+	DEFINE_AHB_SLAVE_EP(viu, 140),
+	DEFINE_AHB_SLAVE_EP(dsi, 141),
+	DEFINE_AHB_SLAVE_EP(lcdif, 142),
+	DEFINE_AHB_SLAVE_EP(mmdc, 143),
+	DEFINE_AHB_SLAVE_EP(iomuxc1, 144),
+	DEFINE_AHB_SLAVE_EP(iomuxc_ddr, 145),
+	DEFINE_AHB_SLAVE_EP(pctlc, 146),
+	DEFINE_AHB_SLAVE_EP(pctld, 147),
+	DEFINE_AHB_SLAVE_EP(pctle, 148),
+	DEFINE_AHB_SLAVE_EP(pctlf, 149),
+	DEFINE_AHB_SLAVE_EP(pcc3, 151),
+
+	DEFINE_AXI_SLAVE(ahb1, 2022, 4, 19,
+			 116, 133, 134, 136, 137, 138, 139, 140, 141,
+			 142, 143, 144, 145, 146, 147, 148, 149, 151),
+
+	/* NIC1 */
+	DEFINE_AXI_INTERCONNECT(nic1_m, 1008, 8, false, &nic1_clock, 1, 1009),
+	DEFINE_AXI_INTERCONNECT(nic1_s, 1009, 8, false, NULL, 7,
+				2018, 1000, 2020, 2021, 2022, 2023, 2024),
+};
+
+static struct imx7ulp_icc_desc icc_desc = {
+	.nodes = (struct imx7ulp_icc_node *)&imx7ulp_nodes,
+	.num_nodes = ARRAY_SIZE(imx7ulp_nodes),
+};
+
+static int imx7ulp_icc_aggregate(struct icc_node *node, u32 avg_bw,
+				  u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static int imx7ulp_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	int ret;
+	struct imx7ulp_icc_node *node;
+	struct imx7ulp_icc_desc *desc = src->provider->data;
+
+	/* If node has a clock, compute the new rate */
+	node = src->data;
+	if (node->bus_clk) {
+		u64 rate;
+		struct imx7ulp_bus_clock *bus_clk = node->bus_clk;
+
+		rate = (src->peak_bw / node->buswidth) * 1000;
+		rate = clk_round_rate(bus_clk->clk, rate);
+		if (rate != bus_clk->rate) {
+			dev_dbg(desc->dev, "%s: new rate = %llu\n",
+				bus_clk->name, rate);
+			bus_clk->rate = rate;
+		}
+	}
+
+	/*
+	 * If the node is an endpoint, update the clock rate of nic0 and nic1
+	 * nodes. nic1 clock derives from nic0, so we usually have to update
+	 * both of them even if bandwidth changed only for one of the
+	 * interconnect.
+	 */
+	node = dst->data;
+	if (node->ep) {
+		struct imx7ulp_bus_clock *nic0_clk = desc->nic0;
+		struct imx7ulp_bus_clock *nic1_clk = desc->nic1;
+
+		if (nic1_clk->rate > nic0_clk->rate)
+			nic0_clk->rate = nic1_clk->rate;
+
+		if (clk_get_rate(nic0_clk->clk) != nic0_clk->rate) {
+			dev_dbg(desc->dev, "%s: apply rate = %llu\n",
+				nic0_clk->name, nic0_clk->rate);
+			ret = clk_set_rate(nic0_clk->clk, nic0_clk->rate);
+			if (ret)
+				dev_err(desc->dev, "Failed to set clock: %d\n",
+					ret);
+		}
+
+		if (clk_get_rate(nic1_clk->clk) != nic1_clk->rate) {
+			dev_dbg(desc->dev, "%s: apply rate = %llu\n",
+				nic1_clk->name, nic1_clk->rate);
+			ret = clk_set_rate(nic1_clk->clk, nic1_clk->rate);
+			if (ret)
+				dev_err(desc->dev, "Failed to set clock: %d\n",
+					ret);
+		}
+	}
+
+	return 0;
+}
+
+static int imx7ulp_probe(struct platform_device *pdev)
+{
+	struct imx7ulp_icc_desc *desc = &icc_desc;
+	struct icc_provider *provider;
+	size_t i;
+	int ret;
+
+	desc->dev = &pdev->dev;
+	desc->nic0 = &nic0_clock;
+	desc->nic1 = &nic1_clock;
+
+	provider = devm_kzalloc(&pdev->dev, sizeof(*provider), GFP_KERNEL);
+	provider->set = imx7ulp_icc_set;
+	provider->aggregate = imx7ulp_icc_aggregate;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data = desc;
+
+	ret = icc_provider_add(provider);
+	if (ret) {
+		dev_err(&pdev->dev, "error adding interconnect provider\n");
+		return ret;
+	}
+
+	for (i = 0; i < desc->num_nodes; i++) {
+		struct icc_node *node;
+		int ret;
+		size_t j;
+
+		if (desc->nodes[i].bus_clk) {
+			struct imx7ulp_bus_clock *bus_clk;
+
+			bus_clk = desc->nodes[i].bus_clk;
+			bus_clk->clk = devm_clk_get(&pdev->dev, bus_clk->name);
+			if (IS_ERR(bus_clk->clk)) {
+				dev_err(&pdev->dev,
+					"Failed to get clock %s: %d\n",
+					bus_clk->name, PTR_ERR(bus_clk->clk));
+				ret = PTR_ERR(bus_clk->clk);
+				goto err;
+			}
+
+			ret = clk_prepare_enable(bus_clk->clk);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"error enabling clock: %s %d\n",
+					bus_clk->name, ret);
+				goto err;
+			}
+		}
+
+		node = icc_node_create(desc->nodes[i].id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			dev_err(&pdev->dev, "Failed to create node %s\n",
+				desc->nodes[i].name);
+			goto err;
+		}
+
+		node->name = desc->nodes[i].name;
+		node->data = &desc->nodes[i];
+		icc_node_add(node, provider);
+
+		dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
+			desc->nodes[i].name, node->id);
+
+		for (j = 0; j < desc->nodes[i].num_links; j++)
+			if (desc->nodes[i].links[j])
+				icc_link_create(node, desc->nodes[i].links[j]);
+	}
+
+	platform_set_drvdata(pdev, provider);
+
+	return 0;
+err:
+	icc_provider_del(provider);
+	return ret;
+}
+
+static int imx7ulp_remove(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+
+	icc_provider_del(provider);
+
+	return 0;
+}
+
+static const struct of_device_id imx7ulp_of_match[] = {
+	{ .compatible = "fsl,imx7ulp-icc" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx7ulp_of_match);
+
+static struct platform_driver imx7ulp_driver = {
+	.probe = imx7ulp_probe,
+	.remove = imx7ulp_remove,
+	.driver = {
+		.name = "imx7ulp-icc",
+		.of_match_table = imx7ulp_of_match,
+	},
+};
+module_platform_driver(imx7ulp_driver);
+MODULE_AUTHOR("Alexandre Bailon <abailon@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.1

