Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491CAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1144E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfAQQkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:40:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:34045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbfAQQkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:40:36 -0500
Received: from corona.crabdance.com ([173.228.106.209]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MWxtA-1ggv232Yrc-00VuNA; Thu, 17 Jan 2019 17:40:08 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id B5FD66E85605; Thu, 17 Jan 2019 08:39:59 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org
Cc:     Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH v2 1/2] EDAC: Add Aspeed AST2500 EDAC driver
Date:   Thu, 17 Jan 2019 08:38:16 -0800
Message-Id: <1547743097-5236-2-git-send-email-schaecsn@gmx.net>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
References: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
X-Provags-ID: V03:K1:+fY04renWQ323x3J20odLoQ3HLqV+d3M04i4AOymp0jCW25O66J
 rTqnu1vOwmMVgRjBqk/GH1pDf+GPtDW+M+Ph6vTCo1dpSgRHGPrC6xUFdM2KegK2fEj1C3O
 she8wW1sPB8/pq8JBompD7t74A7fA2oNhGbqFlV+czpl+g3zSVNG8GtxcTkq1huKVGiLqMs
 XutRC7sug7Ed7EVl7H8fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CcPhrbODX+o=:Kn7kJZYevJN6lvXcmHUJ16
 8UHn16HqZwRyHZxmZszCcFzOElXL/ZO8HA7kfOItmWUB7DUXd90Hy27xrA+BLZm8FxZ1+4Se5
 o662VFM/YTBUTlHZhvL8p5L71p0EwhctQRPoiFkNLsCMZeJQl0e/L6JxU+jYhj6r7aAdTWQOv
 3JVBNMvbsbew9cxZNYHlfyVx0P6i44L5aIquyiHnJt9dtfooGBC7EEVGMm4ukCqIYLphjXQRj
 vTgEnvH8TYSJJ1SqrKpFWyRoPAZ8NcBGGnPN2dn2wTfy99YyjplxgHygBGSOIZI4u9eddUrzl
 blDJEayaUt21rB2wfRQe+terUeVvDIRLyfBDMyYSCqzhQqt0cOweLtsOhY9YXdL8qBNNg6Dqc
 lTxYEdBIiac/G7khZbO9EJbVKFpX++Czlw/JqB/wArEnZc/EnSTX2tJhvHkiIb+bDeY0zW7QK
 l2LI0QqoWnZh00UNaF6vJh2RsZo+IehF7iMpu0EmrSq3W9FGZBapmsGXEsGctMcxw6LH9lOuN
 px7mij5L2Tde/Ow2UgS0PhEw2NvWjCDriP6eG4OlkCWDmA1OFQhtl4x6H9uZR4E4PFfH4dFx3
 /wzGxip62AaBSksN60aLZqlRDELbEaskHLLd4Unn/hv5UPuXozDZ43IBRGn96B4HlG/4BsSpb
 8+r58LJ5VNqQK8dFl7B3zA880XnTXRllokKlCbdfK8VWnG9Kypxv0HF0ZroiNEYDFsFQ9liCE
 wuahkeWjdo5KMQHl+NeptElPGIMFfb0nFs1Up0Xow6jOvAo9R7XOjwvaMalFUIv6ajydyneUJ
 +EfsdPV7wcLedEepv/j0p9RH1tocWSMHNjRYme8sjTooRVyK9OTbsBwht6SF2MLlIuteGU2u1
 KB9CsWY6ymo824unzxganOd+/JWktvD9IcteyArP8Z3W3YCc61YFs6eyx4AGsi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan M Schaeckeler <sschaeck@cisco.com>

Add support for the Aspeed AST2500 SoC EDAC driver.

Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
---
 MAINTAINERS                      |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi |   7 +
 drivers/edac/Kconfig             |   8 +
 drivers/edac/Makefile            |   1 +
 drivers/edac/aspeed_edac.c       | 421 +++++++++++++++++++++++++++++++
 5 files changed, 443 insertions(+)
 create mode 100644 drivers/edac/aspeed_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3318f30903b2..1feb92b14029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5315,6 +5315,12 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/amd64_edac*
 
+EDAC-AST2500
+M:	Stefan Schaeckeler <sschaeck@cisco.com>
+S:	Supported
+F:	drivers/edac/aspeed_edac.c
+F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
+
 EDAC-CALXEDA
 M:	Robert Richter <rric@kernel.org>
 L:	linux-edac@vger.kernel.org
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d107459fc0f8..b4e479ab5a2d 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -47,6 +47,13 @@
 		reg = <0x80000000 0>;
 	};
 
+	edac: sdram@1e6e0000 {
+		compatible = "aspeed,ast2500-sdram-edac";
+		reg = <0x1e6e0000 0x174>;
+		interrupts = <0>;
+		status = "disabled";
+	};
+
 	ahb {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 41c9ccdd20d6..2ef2bb763577 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -475,4 +475,12 @@ config EDAC_QCOM
 	  For debugging issues having to do with stability and overall system
 	  health, you should probably say 'Y' here.
 
+config EDAC_ASPEED
+	tristate "Aspeed AST 2500 SoC"
+	depends on MACH_ASPEED_G5
+	help
+	  Support for error detection and correction on the Aspeed AST 2500 SoC.
+
+	  First, ECC must be configured in the bootloader. Then, this driver
+	  will expose error counters via the edac kernel framework.
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 716096d08ea0..e1f23d4ff860 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
+obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
new file mode 100644
index 000000000000..11833c0a5d07
--- /dev/null
+++ b/drivers/edac/aspeed_edac.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018, 2019 Cisco Systems
+ */
+
+#include <linux/edac.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/stop_machine.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include "edac_module.h"
+
+
+#define DRV_NAME "aspeed-edac"
+
+
+#define ASPEED_MCR_PROT        0x00 /* protection key register */
+#define ASPEED_MCR_CONF        0x04 /* configuration register */
+#define ASPEED_MCR_INTR_CTRL   0x50 /* interrupt control/status register */
+#define ASPEED_MCR_ADDR_UNREC  0x58 /* address of first un-recoverable error */
+#define ASPEED_MCR_ADDR_REC    0x5c /* address of last recoverable error */
+#define ASPEED_MCR_LAST        ASPEED_MCR_ADDR_REC
+
+
+#define ASPEED_MCR_PROT_PASSWD	            0xfc600309
+#define ASPEED_MCR_CONF_DRAM_TYPE               BIT(4)
+#define ASPEED_MCR_CONF_ECC                     BIT(7)
+#define ASPEED_MCR_INTR_CTRL_CLEAR             BIT(31)
+#define ASPEED_MCR_INTR_CTRL_CNT_REC   GENMASK(23, 16)
+#define ASPEED_MCR_INTR_CTRL_CNT_UNREC GENMASK(15, 12)
+#define ASPEED_MCR_INTR_CTRL_ENABLE  (BIT(0) | BIT(1))
+
+
+static struct regmap *aspeed_regmap;
+
+
+static int regmap_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	void __iomem *regs = (void __iomem *)context;
+
+	/* enable write to MCR register set */
+	writel(ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
+
+	writel(val, regs + reg);
+
+	/* disable write to MCR register set */
+	writel(~ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
+
+	return 0;
+}
+
+
+static int regmap_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	void __iomem *regs = (void __iomem *)context;
+
+	*val = readl(regs + reg);
+
+	return 0;
+}
+
+static bool regmap_is_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ASPEED_MCR_PROT:
+	case ASPEED_MCR_INTR_CTRL:
+	case ASPEED_MCR_ADDR_UNREC:
+	case ASPEED_MCR_ADDR_REC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+
+static const struct regmap_config aspeed_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = ASPEED_MCR_LAST,
+	.reg_write = regmap_reg_write,
+	.reg_read = regmap_reg_read,
+	.volatile_reg = regmap_is_volatile,
+	.fast_io = true,
+};
+
+
+static void count_rec(struct mem_ctl_info *mci, u8 rec_cnt, u32 rec_addr)
+{
+	struct csrow_info *csrow = mci->csrows[0];
+	u32 page, offset, syndrome;
+
+	if (!rec_cnt)
+		return;
+
+	/* report first few errors (if there are) */
+	/* note: no addresses are recorded */
+	if (rec_cnt > 1) {
+		/* page, offset and syndrome are not available */
+		page = 0;
+		offset = 0;
+		syndrome = 0;
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, rec_cnt-1,
+				     page, offset, syndrome, 0, 0, -1,
+				     "address(es) not available", "");
+	}
+
+	/* report last error */
+	/* note: rec_addr is the last recoverable error addr */
+	page = rec_addr >> PAGE_SHIFT;
+	offset = rec_addr & ~PAGE_MASK;
+	/* syndrome is not available */
+	syndrome = 0;
+	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
+			     csrow->first_page + page, offset, syndrome,
+			     0, 0, -1, "", "");
+}
+
+
+static void count_un_rec(struct mem_ctl_info *mci, u8 un_rec_cnt,
+			 u32 un_rec_addr)
+{
+	struct csrow_info *csrow = mci->csrows[0];
+	u32 page, offset, syndrome;
+
+	if (!un_rec_cnt)
+		return;
+
+	/* report 1. error */
+	/* note: un_rec_addr is the first unrecoverable error addr */
+	page = un_rec_addr >> PAGE_SHIFT;
+	offset = un_rec_addr & ~PAGE_MASK;
+	/* syndrome is not available */
+	syndrome = 0;
+	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
+			     csrow->first_page + page, offset, syndrome,
+			     0, 0, -1, "", "");
+
+	/* report further errors (if there are) */
+	/* note: no addresses are recorded */
+	if (un_rec_cnt > 1) {
+		/* page, offset and syndrome are not available */
+		page = 0;
+		offset = 0;
+		syndrome = 0;
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, un_rec_cnt-1,
+				     page, offset, syndrome, 0, 0, -1,
+				     "address(es) not available", "");
+	}
+}
+
+
+static irqreturn_t mcr_isr(int irq, void *arg)
+{
+	struct mem_ctl_info *mci = arg;
+	u32 rec_addr, un_rec_addr;
+	u32 reg50, reg5c, reg58;
+	u8  rec_cnt, un_rec_cnt;
+
+	regmap_read(aspeed_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
+	dev_dbg(mci->pdev, "received edac interrupt w/ mcr register 50: 0x%x\n",
+		reg50);
+
+	/* collect data about recoverable and unrecoverable errors */
+	rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_REC) >> 16;
+	un_rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_UNREC) >> 12;
+
+	dev_dbg(mci->pdev, "%d recoverable interrupts and %d unrecoverable interrupts\n",
+		rec_cnt, un_rec_cnt);
+
+	regmap_read(aspeed_regmap, ASPEED_MCR_ADDR_UNREC, &reg58);
+	un_rec_addr = reg58;
+
+	regmap_read(aspeed_regmap, ASPEED_MCR_ADDR_REC, &reg5c);
+	rec_addr = reg5c;
+
+	/* clear interrupt flags and error counters: */
+	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
+			   ASPEED_MCR_INTR_CTRL_CLEAR,
+			   ASPEED_MCR_INTR_CTRL_CLEAR);
+
+	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
+			   ASPEED_MCR_INTR_CTRL_CLEAR, 0);
+
+	/* process recoverable and unrecoverable errors */
+	count_rec(mci, rec_cnt, rec_addr);
+	count_un_rec(mci, un_rec_cnt, un_rec_addr);
+
+	if (!rec_cnt && !un_rec_cnt)
+		dev_dbg(mci->pdev, "received edac interrupt, but did not find any ECC counters\n");
+
+	regmap_read(aspeed_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
+	dev_dbg(mci->pdev, "edac interrupt handled. mcr reg 50 is now: 0x%x\n",
+		reg50);
+
+	return IRQ_HANDLED;
+}
+
+
+static int config_irq(void *ctx, struct platform_device *pdev)
+{
+	int irq;
+	int rc;
+
+	/* register interrupt handler */
+	irq = platform_get_irq(pdev, 0);
+	dev_dbg(&pdev->dev, "got irq %d\n", irq);
+	if (!irq)
+		return -ENODEV;
+
+	rc = devm_request_irq(&pdev->dev, irq, mcr_isr, IRQF_TRIGGER_HIGH,
+			      DRV_NAME, ctx);
+	if (rc) {
+		dev_err(&pdev->dev, "unable to request irq %d\n", irq);
+		return rc;
+	}
+
+	/* enable interrupts */
+	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
+			   ASPEED_MCR_INTR_CTRL_ENABLE,
+			   ASPEED_MCR_INTR_CTRL_ENABLE);
+
+	return 0;
+}
+
+
+static int init_csrows(struct mem_ctl_info *mci)
+{
+	struct csrow_info *csrow = mci->csrows[0];
+	u32 nr_pages, dram_type;
+	struct dimm_info *dimm;
+	struct device_node *np;
+	struct resource r;
+	u32 reg04;
+	int rc;
+
+	/* retrieve info about physical memory from device tree */
+	np = of_find_node_by_path("/memory");
+	if (!np) {
+		dev_err(mci->pdev, "dt: missing /memory node\n");
+		return -ENODEV;
+	};
+
+	rc = of_address_to_resource(np, 0, &r);
+
+	of_node_put(np);
+
+	if (rc) {
+		dev_err(mci->pdev, "dt: failed requesting resource for /memory node\n");
+		return rc;
+	};
+
+	dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
+		r.start, resource_size(&r), PAGE_SHIFT);
+
+	csrow->first_page = r.start >> PAGE_SHIFT;
+	nr_pages = resource_size(&r) >> PAGE_SHIFT;
+	csrow->last_page = csrow->first_page + nr_pages - 1;
+
+	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
+	dram_type = (reg04 & ASPEED_MCR_CONF_DRAM_TYPE) ? MEM_DDR4 : MEM_DDR3;
+
+	dimm = csrow->channels[0]->dimm;
+	dimm->mtype = dram_type;
+	dimm->edac_mode = EDAC_SECDED;
+	dimm->nr_pages = nr_pages / csrow->nr_channels;
+
+	dev_dbg(mci->pdev, "initialized dimm with first_page=0x%lx and nr_pages=0x%x\n",
+		csrow->first_page, nr_pages);
+
+	return 0;
+}
+
+
+static int aspeed_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct edac_mc_layer layers[2];
+	struct mem_ctl_info *mci;
+	struct device_node *np;
+	struct resource *res;
+	void __iomem *regs;
+	u32 reg04;
+	int rc;
+
+	/* setup regmap */
+	np = dev->of_node;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOENT;
+
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	aspeed_regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
+					 &aspeed_regmap_config);
+	if (IS_ERR(aspeed_regmap))
+		return PTR_ERR(aspeed_regmap);
+
+	/* bail out if ECC mode is not configured */
+	regmap_read(aspeed_regmap, ASPEED_MCR_CONF, &reg04);
+	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
+		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
+		return -EPERM;
+	}
+
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	/* allocate & init EDAC MC data structure */
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = 1;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = 1;
+	layers[1].is_virt_csrow = false;
+
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
+	if (!mci)
+		return -ENOMEM;
+
+	mci->pdev = &pdev->dev;
+	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
+	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
+	mci->scrub_mode = SCRUB_HW_SRC;
+	mci->mod_name = DRV_NAME;
+	mci->ctl_name = "MIC";
+	mci->dev_name = dev_name(&pdev->dev);
+
+	rc = init_csrows(mci);
+	if (rc) {
+		dev_err(&pdev->dev, "failed to init csrows\n");
+		goto probe_exit02;
+	}
+
+	platform_set_drvdata(pdev, mci);
+
+	/* register with edac core */
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		dev_err(&pdev->dev, "failed to register with EDAC core\n");
+		goto probe_exit02;
+	}
+
+	/* register interrupt handler and enable interrupts */
+	rc = config_irq(mci, pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "failed setting up irq\n");
+		goto probe_exit01;
+	}
+
+	return 0;
+
+probe_exit01:
+	edac_mc_del_mc(&pdev->dev);
+probe_exit02:
+	edac_mc_free(mci);
+	return rc;
+}
+
+
+static int aspeed_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci;
+
+	/* disable interrupts */
+	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
+			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
+
+	/* free resources */
+	mci = edac_mc_del_mc(&pdev->dev);
+	if (mci)
+		edac_mc_free(mci);
+
+	return 0;
+}
+
+
+static const struct of_device_id aspeed_of_match[] = {
+	{ .compatible = "aspeed,ast2500-sdram-edac" },
+	{},
+};
+
+
+static struct platform_driver aspeed_driver = {
+	.driver		= {
+		.name	= DRV_NAME,
+		.of_match_table = aspeed_of_match
+	},
+	.probe		= aspeed_probe,
+	.remove		= aspeed_remove
+};
+
+
+static int __init aspeed_init(void)
+{
+	return platform_driver_register(&aspeed_driver);
+}
+
+
+static void __exit aspeed_exit(void)
+{
+	platform_driver_unregister(&aspeed_driver);
+}
+
+
+module_init(aspeed_init);
+module_exit(aspeed_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
+MODULE_DESCRIPTION("Aspeed AST2500 EDAC driver");
+MODULE_VERSION("1.0");
-- 
2.19.1

