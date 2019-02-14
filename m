Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3921C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849402075B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JhajqXTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438144AbfBNS2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:28:55 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53138 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394206AbfBNS2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:28:19 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EISBme055159;
        Thu, 14 Feb 2019 12:28:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550168891;
        bh=XwetEAlHQh3GbViG6Tq5GWfgSFcuZ2WVy0IQ0wY8f40=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JhajqXTcRZmPmDTzpKtn4ebkEmDPnbj3izWmD7xe7F25nsiGdnV2YtsB8ZDx+WMxr
         oD+OLoeXOes6+s8jK7I3mD6XmsIZxIYvkChpExavBjCPKqyMB6CZveyvWm/xqmONr8
         hLfuDm9jj0SQprqRGjBQ4O7mG8xkhMiD8rKEGWpk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EISAIS085815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 12:28:10 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 12:28:09 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 12:28:10 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EIS9U0029821;
        Thu, 14 Feb 2019 12:28:09 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.120.181])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x1EIS8U11309;
        Thu, 14 Feb 2019 12:28:08 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 1/5] can: m_can: Create a m_can platform framework
Date:   Thu, 14 Feb 2019 12:27:50 -0600
Message-ID: <20190214182754.30721-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190214182754.30721-1-dmurphy@ti.com>
References: <20190214182754.30721-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a m_can platform framework that peripherial
devices can register to and use common code and register sets.
The peripherial devices may provide read/write and configuration
support of the IP.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v5 - Created ops struct, renamed header to m_can.h, updated license and copyright
added MODULE_AUTHOR and removed unneeded changes - https://lore.kernel.org/patchwork/patch/1033094/

 drivers/net/can/m_can/m_can.h          | 159 ++++++++++++++++++++
 drivers/net/can/m_can/m_can_platform.c | 198 +++++++++++++++++++++++++
 2 files changed, 357 insertions(+)
 create mode 100644 drivers/net/can/m_can/m_can.h
 create mode 100644 drivers/net/can/m_can/m_can_platform.c

diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
new file mode 100644
index 000000000000..36b1b833d41b
--- /dev/null
+++ b/drivers/net/can/m_can/m_can.h
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#ifndef _CAN_M_CAN_H_
+#define _CAN_M_CAN_H_
+
+#include <linux/can/core.h>
+#include <linux/can/led.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/freezer.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
+#include <linux/can/dev.h>
+#include <linux/pinctrl/consumer.h>
+
+/* m_can lec values */
+enum m_can_lec_type {
+	LEC_NO_ERROR = 0,
+	LEC_STUFF_ERROR,
+	LEC_FORM_ERROR,
+	LEC_ACK_ERROR,
+	LEC_BIT1_ERROR,
+	LEC_BIT0_ERROR,
+	LEC_CRC_ERROR,
+	LEC_UNUSED,
+};
+
+enum m_can_mram_cfg {
+	MRAM_SIDF = 0,
+	MRAM_XIDF,
+	MRAM_RXF0,
+	MRAM_RXF1,
+	MRAM_RXB,
+	MRAM_TXE,
+	MRAM_TXB,
+	MRAM_CFG_NUM,
+};
+
+/* registers definition */
+enum m_can_reg {
+	M_CAN_CREL	= 0x0,
+	M_CAN_ENDN	= 0x4,
+	M_CAN_CUST	= 0x8,
+	M_CAN_DBTP	= 0xc,
+	M_CAN_TEST	= 0x10,
+	M_CAN_RWD	= 0x14,
+	M_CAN_CCCR	= 0x18,
+	M_CAN_NBTP	= 0x1c,
+	M_CAN_TSCC	= 0x20,
+	M_CAN_TSCV	= 0x24,
+	M_CAN_TOCC	= 0x28,
+	M_CAN_TOCV	= 0x2c,
+	M_CAN_ECR	= 0x40,
+	M_CAN_PSR	= 0x44,
+/* TDCR Register only available for version >=3.1.x */
+	M_CAN_TDCR	= 0x48,
+	M_CAN_IR	= 0x50,
+	M_CAN_IE	= 0x54,
+	M_CAN_ILS	= 0x58,
+	M_CAN_ILE	= 0x5c,
+	M_CAN_GFC	= 0x80,
+	M_CAN_SIDFC	= 0x84,
+	M_CAN_XIDFC	= 0x88,
+	M_CAN_XIDAM	= 0x90,
+	M_CAN_HPMS	= 0x94,
+	M_CAN_NDAT1	= 0x98,
+	M_CAN_NDAT2	= 0x9c,
+	M_CAN_RXF0C	= 0xa0,
+	M_CAN_RXF0S	= 0xa4,
+	M_CAN_RXF0A	= 0xa8,
+	M_CAN_RXBC	= 0xac,
+	M_CAN_RXF1C	= 0xb0,
+	M_CAN_RXF1S	= 0xb4,
+	M_CAN_RXF1A	= 0xb8,
+	M_CAN_RXESC	= 0xbc,
+	M_CAN_TXBC	= 0xc0,
+	M_CAN_TXFQS	= 0xc4,
+	M_CAN_TXESC	= 0xc8,
+	M_CAN_TXBRP	= 0xcc,
+	M_CAN_TXBAR	= 0xd0,
+	M_CAN_TXBCR	= 0xd4,
+	M_CAN_TXBTO	= 0xd8,
+	M_CAN_TXBCF	= 0xdc,
+	M_CAN_TXBTIE	= 0xe0,
+	M_CAN_TXBCIE	= 0xe4,
+	M_CAN_TXEFC	= 0xf0,
+	M_CAN_TXEFS	= 0xf4,
+	M_CAN_TXEFA	= 0xf8,
+};
+
+/* address offset and element number for each FIFO/Buffer in the Message RAM */
+struct mram_cfg {
+	u16 off;
+	u8  num;
+};
+
+struct m_can_priv;
+struct m_can_ops {
+	/* Device specific call backs */
+	int (*clr_dev_interrupts) (struct m_can_priv *m_can_class);
+	u32 (*read_reg) (struct m_can_priv *m_can_class, int reg);
+	int (*write_reg) (struct m_can_priv *m_can_class, int reg, int val);
+	u32 (*read_fifo) (struct m_can_priv *m_can_class, int addr_offset);
+	int (*write_fifo) (struct m_can_priv *m_can_class, int addr_offset, int val);
+	int (*device_init) (struct m_can_priv *m_can_class);
+};
+
+struct m_can_priv {
+	struct can_priv can;
+	struct napi_struct napi;
+	struct net_device *net;
+	struct device *dev;
+	struct clk *hclk;
+	struct clk *cclk;
+
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+	struct sk_buff *skb;
+
+	struct can_bittiming_const *bit_timing;
+	struct can_bittiming_const *data_timing;
+
+	struct m_can_ops *ops;
+
+	void *device_data;
+
+	int version;
+	int freq;
+	u32 irqstatus;
+
+	int pm_clock_support;
+	bool is_peripherial;
+
+	struct mram_cfg mcfg[MRAM_CFG_NUM];
+};
+
+struct m_can_priv *m_can_class_allocate_dev(struct device *dev);
+int m_can_class_register(struct m_can_priv *m_can_dev);
+void m_can_class_unregister(struct m_can_priv *m_can_dev);
+int m_can_class_get_clocks(struct m_can_priv *m_can_dev);
+void m_can_init_ram(struct m_can_priv *priv);
+void m_can_config_endisable(struct m_can_priv *priv, bool enable);
+
+int m_can_class_suspend(struct device *dev);
+int m_can_class_resume(struct device *dev);
+#endif	/* _CAN_M_H_ */
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
new file mode 100644
index 000000000000..d8d51bd64205
--- /dev/null
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+// IOMapped CAN bus driver for Bosch M_CAN controller
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
+//	Dong Aisheng <b29396@freescale.com>
+//
+// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/platform_device.h>
+
+#include "m_can.h"
+
+struct m_can_plat_priv {
+	void __iomem *base;
+	void __iomem *mram_base;
+};
+
+static u32 iomap_read_reg(struct m_can_priv *m_can_class, int reg)
+{
+	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
+
+	return readl(priv->base + reg);
+}
+
+static u32 iomap_read_fifo(struct m_can_priv *m_can_class, int offset)
+{
+	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
+
+	return readl(priv->mram_base + offset);
+}
+
+static int iomap_write_reg(struct m_can_priv *m_can_class, int reg, int val)
+{
+	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
+
+	writel(val, priv->base + reg);
+
+	return 0;
+}
+
+static int iomap_write_fifo(struct m_can_priv *m_can_class, int offset, int val)
+{
+	struct m_can_plat_priv *priv = (struct m_can_plat_priv *)m_can_class->device_data;
+
+	writel(val, priv->mram_base + offset);
+
+	return 0;
+}
+
+static struct m_can_ops m_can_plat_ops = {
+	.read_reg = iomap_read_reg,
+	.write_reg = iomap_write_reg,
+	.write_fifo = iomap_write_fifo,
+	.read_fifo = iomap_read_fifo,
+};
+
+static int m_can_plat_probe(struct platform_device *pdev)
+{
+	struct m_can_priv *mcan_class;
+	struct m_can_plat_priv *priv;
+	struct resource *res;
+	void __iomem *addr;
+	void __iomem *mram_addr;
+	int irq, ret = 0;
+
+	mcan_class = m_can_class_allocate_dev(&pdev->dev);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mcan_class->device_data = priv;
+
+	m_can_class_get_clocks(mcan_class);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
+	addr = devm_ioremap_resource(&pdev->dev, res);
+	irq = platform_get_irq_byname(pdev, "int0");
+	if (IS_ERR(addr) || irq < 0) {
+		ret = -EINVAL;
+		goto failed_ret;
+	}
+
+	/* message ram could be shared */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
+	if (!res) {
+		ret = -ENODEV;
+		goto failed_ret;
+	}
+
+	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!mram_addr) {
+		ret = -ENOMEM;
+		goto failed_ret;
+	}
+
+	priv->base = addr;
+	priv->mram_base = mram_addr;
+
+	mcan_class->net->irq = irq;
+	mcan_class->pm_clock_support = 1;
+	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
+	mcan_class->dev = &pdev->dev;
+
+	mcan_class->ops = &m_can_plat_ops;
+
+	mcan_class->is_peripherial = false;
+
+	platform_set_drvdata(pdev, mcan_class->dev);
+
+	m_can_init_ram(mcan_class);
+
+	ret = m_can_class_register(mcan_class);
+
+failed_ret:
+	return ret;
+}
+
+static __maybe_unused int m_can_suspend(struct device *dev)
+{
+	return m_can_class_suspend(dev);
+}
+
+static __maybe_unused int m_can_resume(struct device *dev)
+{
+	return m_can_class_resume(dev);
+}
+
+static int m_can_plat_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct m_can_priv *mcan_class = netdev_priv(dev);
+
+	m_can_class_unregister(mcan_class);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static int __maybe_unused m_can_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_priv *mcan_class = netdev_priv(ndev);
+
+	m_can_class_suspend(dev);
+
+	clk_disable_unprepare(mcan_class->cclk);
+	clk_disable_unprepare(mcan_class->hclk);
+
+	return 0;
+}
+
+static int __maybe_unused m_can_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_priv *mcan_class = netdev_priv(ndev);
+	int err;
+
+	err = clk_prepare_enable(mcan_class->hclk);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(mcan_class->cclk);
+	if (err)
+		clk_disable_unprepare(mcan_class->hclk);
+
+	m_can_class_resume(dev);
+
+	return err;
+}
+
+static const struct dev_pm_ops m_can_pmops = {
+	SET_RUNTIME_PM_OPS(m_can_runtime_suspend,
+			   m_can_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
+};
+
+static const struct of_device_id m_can_of_table[] = {
+	{ .compatible = "bosch,m_can", .data = NULL },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, m_can_of_table);
+
+static struct platform_driver m_can_plat_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = m_can_of_table,
+		.pm     = &m_can_pmops,
+	},
+	.probe = m_can_plat_probe,
+	.remove = m_can_plat_remove,
+};
+
+module_platform_driver(m_can_plat_driver);
+
+MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
-- 
2.20.1.390.gb5101f9297

