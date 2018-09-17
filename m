Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C3EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A9D214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A9D214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeIQL4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:56:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33458 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728107AbeIQL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:56:39 -0400
X-UUID: 999b95fe6df14719b670bab1129111b6-20180917
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1944646417; Mon, 17 Sep 2018 14:29:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 17 Sep 2018 14:29:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 17 Sep 2018 14:29:41 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>
CC:     <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <biao.huang@mediatek.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] ethernet: mediatek: add support for MT2712 Ethernet
Date:   Mon, 17 Sep 2018 14:29:23 +0800
Message-ID: <1537165763-13112-3-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
References: <1537165763-13112-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ethernet support for MediaTek SoCs from the MT2712 family.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/net/ethernet/mediatek/Kconfig              |   16 +
 drivers/net/ethernet/mediatek/Makefile             |    1 +
 drivers/net/ethernet/mediatek/gmac/Makefile        |   16 +
 .../net/ethernet/mediatek/gmac/mt2712-platform.c   |  286 ++
 .../net/ethernet/mediatek/gmac/mtk-gmac-common.c   |  805 +++++
 drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.c |  537 +++
 drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.h |  151 +
 .../net/ethernet/mediatek/gmac/mtk-gmac-ethtool.c  |  342 ++
 drivers/net/ethernet/mediatek/gmac/mtk-gmac-hw.c   | 3446 ++++++++++++++++++++
 drivers/net/ethernet/mediatek/gmac/mtk-gmac-mdio.c |  274 ++
 drivers/net/ethernet/mediatek/gmac/mtk-gmac-net.c  | 1638 ++++++++++
 drivers/net/ethernet/mediatek/gmac/mtk-gmac-ptp.c  |  153 +
 drivers/net/ethernet/mediatek/gmac/mtk-gmac-reg.h  |  861 +++++
 drivers/net/ethernet/mediatek/gmac/mtk-gmac.h      |  683 ++++
 14 files changed, 9209 insertions(+)
 create mode 100644 drivers/net/ethernet/mediatek/gmac/Makefile
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mt2712-platform.c
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-common.c
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.c
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.h
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-ethtool.c
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-hw.c
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-mdio.c
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-net.c
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-ptp.c
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac-reg.h
 create mode 100644 drivers/net/ethernet/mediatek/gmac/mtk-gmac.h

diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
index f9149d2..646e250 100644
--- a/drivers/net/ethernet/mediatek/Kconfig
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -14,4 +14,20 @@ config NET_MEDIATEK_SOC
 	  This driver supports the gigabit ethernet MACs in the
 	  MediaTek SoC family.
 
+config MTK_GMAC
+	tristate "MediaTek Gigabit AVB Ethernet support"
+	select PHYLIB
+	select PTP_1588_CLOCK
+	select VLAN_8021Q
+	---help---
+	  This driver supports the gigabit avb ethernet MACs in the
+	  MediaTek MT27xx SoC family.
+
+if MTK_GMAC
+config MT2712_GMAC
+	tristate "MT2712 Gigabit Ethernet support"
+	---help---
+	  This driver supports the gigabit avb ethernet MACs in the
+	  MediaTek MT2712 SoC.
+endif #MTK_GMAC
 endif #NET_VENDOR_MEDIATEK
diff --git a/drivers/net/ethernet/mediatek/Makefile b/drivers/net/ethernet/mediatek/Makefile
index aa3f1c8..9c6a84a 100644
--- a/drivers/net/ethernet/mediatek/Makefile
+++ b/drivers/net/ethernet/mediatek/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_NET_MEDIATEK_SOC)			+= mtk_eth_soc.o
+obj-$(CONFIG_MTK_GMAC) += gmac/
diff --git a/drivers/net/ethernet/mediatek/gmac/Makefile b/drivers/net/ethernet/mediatek/gmac/Makefile
new file mode 100644
index 0000000..f0641df
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/Makefile
@@ -0,0 +1,16 @@
+# GPL-2.0
+#
+# Makefile for the MediaTek network device drivers
+#
+
+obj-$(CONFIG_MTK_GMAC) += mtk-gmac.o
+
+mtk-gmac-objs := mtk-gmac-net.o \
+		mtk-gmac-desc.o \
+		mtk-gmac-common.o \
+		mtk-gmac-hw.o \
+		mtk-gmac-ethtool.o \
+		mtk-gmac-ptp.o \
+		mtk-gmac-mdio.o
+
+mtk-gmac-${CONFIG_MT2712_GMAC} += mt2712-platform.o
diff --git a/drivers/net/ethernet/mediatek/gmac/mt2712-platform.c b/drivers/net/ethernet/mediatek/gmac/mt2712-platform.c
new file mode 100644
index 0000000..2d747ba
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mt2712-platform.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_net.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "mtk-gmac.h"
+
+/* Infra configuration register */
+#define TOP_DCMCTL		0x10
+
+/* Infra configuration register bits */
+#define INFRA_DCM_ENABLE	BIT(0)
+
+/* Peri configuration register */
+#define PERI_PHY_INTF_SEL	0x418
+#define PERI_PHY_DLY		0x428
+
+/* Peri configuration register bits and bitmasks */
+#define DLY_GTXC_ENABLE		BIT(5)
+#define DLY_GTXC_INV		BIT(6)
+#define DLY_GTXC_STAGES		GENMASK(4, 0)
+#define DLY_RXC_ENABLE		BIT(12)
+#define DLY_RXC_INV		BIT(13)
+#define DLY_RXC_STAGES		GENMASK(11, 7)
+#define DLY_TXC_ENABLE		BIT(19)
+#define DLY_TXC_INV		BIT(20)
+#define DLY_TXC_STAGES		GENMASK(18, 14)
+#define PHY_INTF_MASK		GENMASK(2, 0)
+#define RMII_CLK_SRC_MASK	GENMASK(5, 4)
+#define RMII_CLK_SRC_RXC	BIT(4)
+
+/* Peri configuration register value */
+#define DLY_VAL_RGMII		0x11a3
+#define DLY_VAL_RGMII_ID	0x0
+#define DLY_VAL_RGMII_RXID	0x23
+#define DLY_VAL_RGMII_TXID	0x1180
+#define PHY_INTF_MII_GMII	0x0
+#define PHY_INTF_RGMII		0x1
+#define PHY_INTF_RMII		0x4
+
+static const char * const gmac_clks_source_name[] = {
+	"axi", "apb", "mac_ext", "ptp", "ptp_parent", "ptp_top"
+};
+
+static int get_platform_resources(struct platform_device *pdev,
+				  struct gmac_resources *gmac_res)
+{
+	struct resource *res;
+	int gpio;
+
+	/* Get irq resource */
+	gmac_res->irq = platform_get_irq_byname(pdev, "macirq");
+	if (gmac_res->irq < 0) {
+		if (gmac_res->irq != -EPROBE_DEFER) {
+			dev_err(&pdev->dev,
+				"MAC IRQ configuration information not found\n");
+		}
+		return gmac_res->irq;
+	}
+
+	/* Get memory resource */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	gmac_res->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(gmac_res->base_addr)) {
+		dev_err(&pdev->dev, "cannot map register memory\n");
+		return PTR_ERR(gmac_res->base_addr);
+	}
+
+	gmac_res->mac_addr =
+		(const char *)of_get_mac_address(pdev->dev.of_node);
+
+	gpio = of_get_named_gpio(pdev->dev.of_node, "reset-gpio", 0);
+	if (!gpio_is_valid(gpio)) {
+		dev_err(&pdev->dev, "failed to parse phy reset gpio\n");
+		return gpio;
+	}
+
+	gmac_res->phy_rst = gpio;
+
+	return 0;
+}
+
+static int mt2712_gmac_top_regmap_get(struct plat_gmac_data *plat)
+{
+	plat->infra_regmap =
+		syscon_regmap_lookup_by_compatible("mediatek,mt2712-infracfg");
+	if (IS_ERR(plat->infra_regmap)) {
+		pr_err("Failed to get infracfg syscon\n");
+		return PTR_ERR(plat->infra_regmap);
+	}
+
+	plat->peri_regmap =
+		syscon_regmap_lookup_by_compatible("mediatek,mt2712-pericfg");
+	if (IS_ERR(plat->peri_regmap)) {
+		pr_err("Failed to get pericfg syscon\n");
+		return PTR_ERR(plat->infra_regmap);
+	}
+
+	return 0;
+}
+
+static int mt2712_gmac_clk_get(struct platform_device *pdev,
+			       struct plat_gmac_data *plat)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(plat->clks); i++) {
+		plat->clks[i] = devm_clk_get(&pdev->dev,
+					     gmac_clks_source_name[i]);
+		if (IS_ERR(plat->clks[i])) {
+			if (PTR_ERR(plat->clks[i]) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			plat->clks[i] = NULL;
+		}
+	}
+
+	return 0;
+}
+
+static int mt2712_gmac_clk_enable(struct plat_gmac_data *plat)
+{
+	int clk, ret;
+
+	for (clk = 0; clk < GMAC_CLK_MAX ; clk++) {
+		ret = clk_prepare_enable(plat->clks[clk]);
+		if (ret)
+			goto err_disable_clks;
+	}
+
+	ret = clk_set_parent(plat->clks[GMAC_CLK_PTP],
+			     plat->clks[GMAC_CLK_PTP_PARENT]);
+	if (ret)
+		goto err_disable_clks;
+
+	return 0;
+
+err_disable_clks:
+	while (--clk >= 0)
+		clk_disable_unprepare(plat->clks[clk]);
+
+	return ret;
+}
+
+static void mt2712_gmac_clk_disable(struct plat_gmac_data *plat)
+{
+	int clk;
+
+	for (clk = GMAC_CLK_MAX - 1; clk >= 0; clk--)
+		clk_disable_unprepare(plat->clks[clk]);
+}
+
+static int platform_data_get(struct platform_device *pdev,
+			     struct plat_gmac_data *plat)
+{
+	int ret;
+
+	ret = mt2712_gmac_top_regmap_get(plat);
+	if (ret)
+		return ret;
+
+	/* Get clock resource */
+	ret = mt2712_gmac_clk_get(pdev, plat);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void mt2712_gmac_set_interface(struct plat_gmac_data *plat)
+{
+	/* bus clock initialzation */
+	regmap_update_bits(plat->infra_regmap, TOP_DCMCTL,
+			   INFRA_DCM_ENABLE, INFRA_DCM_ENABLE);
+
+	regmap_write(plat->peri_regmap, PERI_PHY_DLY, 0);
+
+	/* select phy interface in top control domain */
+	switch (plat->phy_mode) {
+	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_GMII:
+		regmap_update_bits(plat->peri_regmap,
+				   PERI_PHY_INTF_SEL,
+				   PHY_INTF_MASK,
+				   PHY_INTF_MII_GMII);
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		regmap_update_bits(plat->peri_regmap,
+				   PERI_PHY_INTF_SEL,
+				   PHY_INTF_MASK,
+				   PHY_INTF_RMII);
+		/* bit[5:4] = 1 ref_clk connect to rxc pad */
+		regmap_update_bits(plat->peri_regmap,
+				   PERI_PHY_INTF_SEL,
+				   RMII_CLK_SRC_MASK,
+				   RMII_CLK_SRC_RXC);
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		regmap_update_bits(plat->peri_regmap,
+				   PERI_PHY_INTF_SEL,
+				   PHY_INTF_MASK,
+				   PHY_INTF_RGMII);
+		break;
+	default:
+		pr_err("phy interface not support\n");
+	}
+}
+
+static void mt2712_gmac_set_delay(struct plat_gmac_data *plat)
+{
+	switch (plat->phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+		regmap_write(plat->peri_regmap, PERI_PHY_DLY, DLY_VAL_RGMII);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		regmap_write(plat->peri_regmap, PERI_PHY_DLY, DLY_VAL_RGMII_ID);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		regmap_write(plat->peri_regmap, PERI_PHY_DLY, DLY_VAL_RGMII_RXID);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		regmap_write(plat->peri_regmap, PERI_PHY_DLY, DLY_VAL_RGMII_TXID);
+		break;
+	}
+}
+
+static int mt2712_gmac_probe(struct platform_device *pdev)
+{
+	struct plat_gmac_data *plat;
+	struct gmac_resources gmac_res;
+	int ret = 0;
+
+	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
+	if (!plat)
+		return -ENOMEM;
+
+	plat->np = pdev->dev.of_node;
+	plat->phy_mode = of_get_phy_mode(plat->np);
+	plat->gmac_clk_enable = mt2712_gmac_clk_enable;
+	plat->gmac_clk_disable = mt2712_gmac_clk_disable;
+	plat->gmac_set_interface = mt2712_gmac_set_interface;
+	plat->gmac_set_delay = mt2712_gmac_set_delay;
+
+	ret = get_platform_resources(pdev, &gmac_res);
+	if (ret)
+		return ret;
+
+	ret = platform_data_get(pdev, plat);
+	if (ret)
+		return ret;
+
+	return gmac_drv_probe(&pdev->dev, plat, &gmac_res);
+}
+
+int mt2712_gmac_remove(struct platform_device *pdev)
+{
+	return gmac_drv_remove(&pdev->dev);
+}
+
+static const struct of_device_id of_mt2712_gmac_match[] = {
+	{ .compatible = "mediatek,mt2712-eth"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, of_mt2712_gmac_match);
+
+static struct platform_driver mt2712_gmac_driver = {
+	.probe = mt2712_gmac_probe,
+	.remove = mt2712_gmac_remove,
+	.driver = {
+		.name = "mt2712_gmac_eth",
+		.of_match_table = of_mt2712_gmac_match,
+	},
+};
+
+module_platform_driver(mt2712_gmac_driver);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-common.c b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-common.c
new file mode 100644
index 0000000..fd9d0a8
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-common.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include "mtk-gmac.h"
+
+static int debug = -1;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "MediaTek Message Level (-1: default, 0=none,...,16=all)");
+static const u32 default_msg_level = (NETIF_MSG_DRV | NETIF_MSG_PROBE |
+				      NETIF_MSG_LINK | NETIF_MSG_IFUP |
+				      NETIF_MSG_IFDOWN | NETIF_MSG_TIMER);
+
+void gmac_dump_tx_desc(struct gmac_pdata *pdata, struct gmac_ring *ring,
+		       unsigned int idx, unsigned int count, unsigned int flag)
+{
+	struct gmac_desc_data *desc_data;
+	struct gmac_dma_desc *dma_desc;
+
+	while (count--) {
+		desc_data = GMAC_GET_DESC_DATA(ring, idx);
+		dma_desc = desc_data->dma_desc;
+
+		netdev_dbg(pdata->netdev, "TX: dma_desc=%p, dma_desc_addr=%pad\n",
+			   desc_data->dma_desc, &desc_data->dma_desc_addr);
+		netdev_dbg(pdata->netdev,
+			   "TX_NORMAL_DESC[%d %s] = %08x:%08x:%08x:%08x\n", idx,
+			   (flag == 1) ? "QUEUED FOR TX" : "TX BY DEVICE",
+			   le32_to_cpu(dma_desc->desc0),
+			   le32_to_cpu(dma_desc->desc1),
+			   le32_to_cpu(dma_desc->desc2),
+			   le32_to_cpu(dma_desc->desc3));
+
+		idx++;
+	}
+}
+
+void gmac_dump_rx_desc(struct gmac_pdata *pdata,
+		       struct gmac_ring *ring,
+		       unsigned int idx)
+{
+	struct gmac_desc_data *desc_data;
+	struct gmac_dma_desc *dma_desc;
+
+	desc_data = GMAC_GET_DESC_DATA(ring, idx);
+	dma_desc = desc_data->dma_desc;
+
+	netdev_dbg(pdata->netdev, "RX: dma_desc=%p, dma_desc_addr=%pad\n",
+		   desc_data->dma_desc, &desc_data->dma_desc_addr);
+	netdev_dbg(pdata->netdev,
+		   "RX_NORMAL_DESC[%d RX BY DEVICE] = %08x:%08x:%08x:%08x\n",
+		   idx,
+		   le32_to_cpu(dma_desc->desc0),
+		   le32_to_cpu(dma_desc->desc1),
+		   le32_to_cpu(dma_desc->desc2),
+		   le32_to_cpu(dma_desc->desc3));
+}
+
+void gmac_print_pkt(struct net_device *netdev,
+		    struct sk_buff *skb,
+		    bool tx_rx)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb->data;
+	unsigned char buffer[128];
+	unsigned int i;
+
+	netdev_dbg(netdev, "\n************** SKB dump ****************\n");
+
+	netdev_dbg(netdev, "%s packet of %d bytes\n",
+		   (tx_rx ? "TX" : "RX"), skb->len);
+
+	netdev_dbg(netdev, "Dst MAC addr: %pM\n", eth->h_dest);
+	netdev_dbg(netdev, "Src MAC addr: %pM\n", eth->h_source);
+	netdev_dbg(netdev, "Protocol: %#06hx\n", ntohs(eth->h_proto));
+
+	for (i = 0; i < skb->len; i += 32) {
+		unsigned int len = min(skb->len - i, 32U);
+
+		hex_dump_to_buffer(&skb->data[i], len, 32, 1,
+				   buffer, sizeof(buffer), false);
+		netdev_dbg(netdev, "  %#06x: %s\n", i, buffer);
+	}
+
+	netdev_dbg(netdev, "\n************** SKB dump ****************\n");
+}
+
+static void gmac_default_config(struct gmac_pdata *pdata)
+{
+	pdata->tx_osp_mode	= DMA_OSP_ENABLE;
+	pdata->tx_sf_mode	= MTL_TSF_ENABLE;
+	pdata->rx_sf_mode	= MTL_RSF_DISABLE;
+	pdata->pblx8		= DMA_PBL_X8_ENABLE;
+	pdata->tx_pbl		= DMA_PBL_32;
+	pdata->rx_pbl		= DMA_PBL_32;
+	pdata->tx_threshold	= MTL_TX_THRESHOLD_128;
+	pdata->rx_threshold	= MTL_RX_THRESHOLD_128;
+	pdata->tx_pause		= 1;
+	pdata->rx_pause		= 1;
+	pdata->phy_speed	= SPEED_1000;
+	pdata->sysclk_rate	= GMAC_SYSCLOCK;
+
+	strlcpy(pdata->drv_name, GMAC_DRV_NAME, sizeof(pdata->drv_name));
+	strlcpy(pdata->drv_ver, GMAC_DRV_VERSION, sizeof(pdata->drv_ver));
+}
+
+static void gmac_init_all_ops(struct gmac_pdata *pdata)
+{
+	gmac_init_desc_ops(&pdata->desc_ops);
+	gmac_init_hw_ops(&pdata->hw_ops);
+}
+
+static void gmac_get_all_hw_features(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_features *hw_feat = &pdata->hw_feat;
+	unsigned int mac_hfr0, mac_hfr1, mac_hfr2;
+
+	mac_hfr0 = GMAC_IOREAD(pdata, MAC_HWF0R);
+	mac_hfr1 = GMAC_IOREAD(pdata, MAC_HWF1R);
+	mac_hfr2 = GMAC_IOREAD(pdata, MAC_HWF2R);
+
+	memset(hw_feat, 0, sizeof(*hw_feat));
+
+	hw_feat->version = GMAC_IOREAD(pdata, MAC_VR);
+
+	/* Hardware feature register 0 */
+	hw_feat->mii		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_MIISEL_POS,
+						    MAC_HW_FEAT_MIISEL_LEN);
+	hw_feat->gmii		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_GMIISEL_POS,
+						    MAC_HW_FEAT_GMIISEL_LEN);
+	hw_feat->hd		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_HDSEL_POS,
+						    MAC_HW_FEAT_HDSEL_LEN);
+	hw_feat->pcs		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_PCSSEL_POS,
+						    MAC_HW_FEAT_PCSSEL_LEN);
+	hw_feat->vlhash		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_VLHASH_POS,
+						    MAC_HW_FEAT_VLHASH_LEN);
+	hw_feat->sma		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_SMASEL_POS,
+						    MAC_HW_FEAT_SMASEL_LEN);
+	hw_feat->rwk		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_RWKSEL_POS,
+						    MAC_HW_FEAT_RWKSEL_LEN);
+	hw_feat->mgk		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_MGKSEL_POS,
+						    MAC_HW_FEAT_MGKSEL_LEN);
+	hw_feat->mmc		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_MMCSEL_POS,
+						    MAC_HW_FEAT_MMCSEL_LEN);
+	hw_feat->aoe		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_ARPOFFSEL_POS,
+						    MAC_HW_FEAT_ARPOFFSEL_LEN);
+	hw_feat->ts		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_TSSEL_POS,
+						    MAC_HW_FEAT_TSSEL_LEN);
+	hw_feat->eee		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_EEESEL_POS,
+						    MAC_HW_FEAT_EEESEL_LEN);
+	hw_feat->tx_coe		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_TXCOSEL_POS,
+						    MAC_HW_FEAT_TXCOSEL_LEN);
+	hw_feat->rx_coe		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_RXCOESEL_POS,
+						    MAC_HW_FEAT_RXCOESEL_LEN);
+	hw_feat->addn_mac	= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_ADDMAC_POS,
+						    MAC_HW_FEAT_ADDMAC_LEN);
+	hw_feat->ts_src		= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_TSSTSSEL_POS,
+						    MAC_HW_FEAT_TSSTSSEL_LEN);
+	hw_feat->sa_vlan_ins	= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_SAVLANINS_POS,
+						    MAC_HW_FEAT_SAVLANINS_LEN);
+	hw_feat->phyifsel	= GMAC_GET_REG_BITS(mac_hfr0,
+						    MAC_HW_FEAT_ACTPHYSEL_POS,
+						    MAC_HW_FEAT_ACTPHYSEL_LEN);
+
+	/* Hardware feature register 1 */
+	hw_feat->rx_fifo_size	= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_RXFIFOSIZE_POS,
+						    MAC_HW_RXFIFOSIZE_LEN);
+	hw_feat->tx_fifo_size	= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_TXFIFOSIZE_POS,
+						    MAC_HW_TXFIFOSIZE_LEN);
+	hw_feat->one_step_en	= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_OSTEN_POS,
+						    MAC_HW_OSTEN_LEN);
+	hw_feat->ptp_offload	= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_PTOEN_POS,
+						    MAC_HW_PTOEN_LEN);
+	hw_feat->adv_ts_hi	= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_ADVTHWORD_POS,
+						    MAC_HW_ADVTHWORD_LEN);
+	hw_feat->dma_width	= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_ADDR64_POS,
+						    MAC_HW_ADDR64_LEN);
+	hw_feat->dcb		= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_DCBEN_POS,
+						    MAC_HW_DCBEN_LEN);
+	hw_feat->sph		= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_SPHEN_POS,
+						    MAC_HW_SPHEN_LEN);
+	hw_feat->tso		= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_TSOEN_POS,
+						    MAC_HW_TSOEN_LEN);
+	hw_feat->dma_debug	= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_DMADEBUGEN_POS,
+						    MAC_HW_DMADEBUGEN_LEN);
+	hw_feat->av		= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_AV_POS,
+						    MAC_HW_AV_LEN);
+	hw_feat->rav		= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_RAV_POS,
+						    MAC_HW_RAV_LEN);
+	hw_feat->pouost		= GMAC_GET_REG_BITS(mac_hfr1,
+						    MAC_HW_POUOST_POS,
+						    MAC_HW_POUOST_LEN);
+	hw_feat->hash_table_size = GMAC_GET_REG_BITS(mac_hfr1,
+						     MAC_HW_HASHTBLSZ_POS,
+						     MAC_HW_HASHTBLSZ_LEN);
+	hw_feat->l3l4_filter_num = GMAC_GET_REG_BITS(mac_hfr1,
+						     MAC_HW_L3L4FNUM_POS,
+						     MAC_HW_L3L4FNUM_LEN);
+
+	/* Hardware feature register 2 */
+	hw_feat->rx_q_cnt	= GMAC_GET_REG_BITS(mac_hfr2,
+						    MAC_HW_FEAT_RXQCNT_POS,
+						    MAC_HW_FEAT_RXQCNT_LEN);
+	hw_feat->tx_q_cnt	= GMAC_GET_REG_BITS(mac_hfr2,
+						    MAC_HW_FEAT_TXQCNT_POS,
+						    MAC_HW_FEAT_TXQCNT_LEN);
+	hw_feat->rx_ch_cnt	= GMAC_GET_REG_BITS(mac_hfr2,
+						    MAC_HW_FEAT_RXCHCNT_POS,
+						    MAC_HW_FEAT_RXCHCNT_LEN);
+	hw_feat->tx_ch_cnt	= GMAC_GET_REG_BITS(mac_hfr2,
+						    MAC_HW_FEAT_TXCHCNT_POS,
+						    MAC_HW_FEAT_TXCHCNT_LEN);
+	hw_feat->pps_out_num	= GMAC_GET_REG_BITS(mac_hfr2,
+						    MAC_HW_FEAT_PPSOUTNUM_POS,
+						    MAC_HW_FEAT_PPSOUTNUM_LEN);
+	hw_feat->aux_snap_num	= GMAC_GET_REG_BITS(mac_hfr2,
+						    MAC_HW_FEAT_AUXSNAPNUM_POS,
+						    MAC_HW_FEAT_AUXSNAPNUM_LEN);
+
+	/* Translate the Hash Table size into actual number */
+	switch (hw_feat->hash_table_size) {
+	case 0:
+		break;
+	case 1:
+		hw_feat->hash_table_size = 64;
+		break;
+	case 2:
+		hw_feat->hash_table_size = 128;
+		break;
+	case 3:
+		hw_feat->hash_table_size = 256;
+		break;
+	}
+
+	/* Translate the address width setting into actual number */
+	switch (hw_feat->dma_width) {
+	case 0:
+		hw_feat->dma_width = 32;
+		break;
+	case 1:
+		hw_feat->dma_width = 40;
+		break;
+	case 2:
+		hw_feat->dma_width = 48;
+		break;
+	default:
+		hw_feat->dma_width = 32;
+	}
+
+	/* The Queue and Channel counts are zero based so increment them
+	 * to get the actual number
+	 */
+	hw_feat->rx_q_cnt++;
+	hw_feat->tx_q_cnt++;
+	hw_feat->rx_ch_cnt++;
+	hw_feat->tx_ch_cnt++;
+}
+
+static void gmac_print_all_hw_features(struct gmac_pdata *pdata)
+{
+	char *str = NULL;
+
+	netif_info(pdata, probe, pdata->netdev, "\n");
+	netif_info(pdata, probe, pdata->netdev,
+		   "=====================================================\n");
+	netif_info(pdata, probe, pdata->netdev, "\n");
+	netif_info(pdata, probe, pdata->netdev,
+		   "HW support following features\n");
+	netif_info(pdata, probe, pdata->netdev, "\n");
+	/* HW Feature Register0 */
+	netif_info(pdata, probe, pdata->netdev,
+		   "10/100 Mbps Support                         : %s\n",
+		   pdata->hw_feat.mii ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "1000 Mbps Support                           : %s\n",
+		   pdata->hw_feat.gmii ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "Half-duplex Support                         : %s\n",
+		   pdata->hw_feat.hd ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "PCS Registers(TBI/SGMII/RTBI PHY interface) : %s\n",
+		   pdata->hw_feat.pcs ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "VLAN Hash Filter Selected                   : %s\n",
+		   pdata->hw_feat.vlhash ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "SMA (MDIO) Interface                        : %s\n",
+		   pdata->hw_feat.sma ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "PMT Remote Wake-up Packet Enable            : %s\n",
+		   pdata->hw_feat.rwk ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "PMT Magic Packet Enable                     : %s\n",
+		   pdata->hw_feat.mgk ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "RMON/MMC Module Enable                      : %s\n",
+		   pdata->hw_feat.mmc ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "ARP Offload Enabled                         : %s\n",
+		   pdata->hw_feat.aoe ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "IEEE 1588-2008 Timestamp Enabled            : %s\n",
+		   pdata->hw_feat.ts ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "Energy Efficient Ethernet Enabled           : %s\n",
+		   pdata->hw_feat.eee ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "Transmit Checksum Offload Enabled           : %s\n",
+		   pdata->hw_feat.tx_coe ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "Receive Checksum Offload Enabled            : %s\n",
+		   pdata->hw_feat.rx_coe ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "Additional MAC Addresses Selected           : %s\n",
+		   pdata->hw_feat.addn_mac ? "YES" : "NO");
+
+	if (pdata->hw_feat.addn_mac)
+		pdata->max_addr_reg_cnt = pdata->hw_feat.addn_mac;
+	else
+		pdata->max_addr_reg_cnt = 1;
+
+	switch (pdata->hw_feat.ts_src) {
+	case 0:
+		str = "RESERVED";
+		break;
+	case 1:
+		str = "INTERNAL";
+		break;
+	case 2:
+		str = "EXTERNAL";
+		break;
+	case 3:
+		str = "BOTH";
+		break;
+	}
+	netif_info(pdata, probe, pdata->netdev,
+		   "Timestamp System Time Source                : %s\n", str);
+
+	netif_info(pdata, probe, pdata->netdev,
+		   "Source Address or VLAN Insertion Enable     : %s\n",
+		   pdata->hw_feat.sa_vlan_ins ? "YES" : "NO");
+
+	switch (pdata->hw_feat.phyifsel) {
+	case 0:
+		str = "GMII/MII";
+		break;
+	case 1:
+		str = "RGMII";
+		break;
+	case 2:
+		str = "SGMII";
+		break;
+	case 3:
+		str = "TBI";
+		break;
+	case 4:
+		str = "RMII";
+		break;
+	case 5:
+		str = "RTBI";
+		break;
+	case 6:
+		str = "SMII";
+		break;
+	case 7:
+		str = "RevMII";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	netif_info(pdata, probe, pdata->netdev,
+		   "Active PHY Selected                         : %s\n",
+		   str);
+
+	/* HW Feature Register1 */
+	switch (pdata->hw_feat.rx_fifo_size) {
+	case 0:
+		str = "128 bytes";
+		break;
+	case 1:
+		str = "256 bytes";
+		break;
+	case 2:
+		str = "512 bytes";
+		break;
+	case 3:
+		str = "1 KBytes";
+		break;
+	case 4:
+		str = "2 KBytes";
+		break;
+	case 5:
+		str = "4 KBytes";
+		break;
+	case 6:
+		str = "8 KBytes";
+		break;
+	case 7:
+		str = "16 KBytes";
+		break;
+	case 8:
+		str = "32 kBytes";
+		break;
+	case 9:
+		str = "64 KBytes";
+		break;
+	case 10:
+		str = "128 KBytes";
+		break;
+	case 11:
+		str = "256 KBytes";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	netif_info(pdata, probe, pdata->netdev,
+		   "MTL Receive FIFO Size                       : %s\n",
+		   str);
+
+	switch (pdata->hw_feat.tx_fifo_size) {
+	case 0:
+		str = "128 bytes";
+		break;
+	case 1:
+		str = "256 bytes";
+		break;
+	case 2:
+		str = "512 bytes";
+		break;
+	case 3:
+		str = "1 KBytes";
+		break;
+	case 4:
+		str = "2 KBytes";
+		break;
+	case 5:
+		str = "4 KBytes";
+		break;
+	case 6:
+		str = "8 KBytes";
+		break;
+	case 7:
+		str = "16 KBytes";
+		break;
+	case 8:
+		str = "32 kBytes";
+		break;
+	case 9:
+		str = "64 KBytes";
+		break;
+	case 10:
+		str = "128 KBytes";
+		break;
+	case 11:
+		str = "256 KBytes";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	netif_info(pdata, probe, pdata->netdev,
+		   "MTL Transmit FIFO Size                      : %s\n",
+		   str);
+	netif_info(pdata, probe, pdata->netdev,
+		   "One-Step Timingstamping Enable              : %s\n",
+		   pdata->hw_feat.one_step_en ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "PTP Offload Enable                          : %s\n",
+		   pdata->hw_feat.ptp_offload ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "IEEE 1588 High Word Register Enable         : %s\n",
+		   pdata->hw_feat.adv_ts_hi ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "DMA Address width                           : %u\n",
+		   pdata->hw_feat.dma_width);
+	pdata->dma_width = pdata->hw_feat.dma_width + 1;
+	netif_info(pdata, probe, pdata->netdev,
+		   "DCB Feature Enable                          : %s\n",
+		   pdata->hw_feat.dcb ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "Split Header Feature Enable                 : %s\n",
+		   pdata->hw_feat.sph ? "YES" : "NO");
+	pdata->rx_sph = pdata->hw_feat.sph ? 1 : 0;
+	netif_info(pdata, probe, pdata->netdev,
+		   "TCP Segmentation Offload Enable             : %s\n",
+		   pdata->hw_feat.tso ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "DMA Debug Registers Enabled                 : %s\n",
+		   pdata->hw_feat.dma_debug ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "Audio-Vedio Bridge Feature Enabled          : %s\n",
+		   pdata->hw_feat.av ? "YES" : "NO");
+	netif_info(pdata, probe, pdata->netdev,
+		   "Rx Side AV Feature Enabled                  : %s\n",
+		   (pdata->hw_feat.rav ? "YES" : "NO"));
+	netif_info(pdata, probe, pdata->netdev,
+		   "One-Step for PTP over UDP/IP Feature        : %s\n",
+		   (pdata->hw_feat.pouost ? "YES" : "NO"));
+	netif_info(pdata, probe, pdata->netdev,
+		   "Hash Table Size                             : %u\n",
+		   pdata->hw_feat.hash_table_size);
+	netif_info(pdata, probe, pdata->netdev,
+		   "Total number of L3 or L4 Filters            : %u\n",
+		   pdata->hw_feat.l3l4_filter_num);
+
+	/* HW Feature Register2 */
+	netif_info(pdata, probe, pdata->netdev,
+		   "Number of MTL Receive Queues                : %u\n",
+		   pdata->hw_feat.rx_q_cnt);
+	netif_info(pdata, probe, pdata->netdev,
+		   "Number of MTL Transmit Queues               : %u\n",
+		   pdata->hw_feat.tx_q_cnt);
+	netif_info(pdata, probe, pdata->netdev,
+		   "Number of DMA Receive Channels              : %u\n",
+		   pdata->hw_feat.rx_ch_cnt);
+	netif_info(pdata, probe, pdata->netdev,
+		   "Number of DMA Transmit Channels             : %u\n",
+		   pdata->hw_feat.tx_ch_cnt);
+
+	switch (pdata->hw_feat.pps_out_num) {
+	case 0:
+		str = "No PPS output";
+		break;
+	case 1:
+		str = "1 PPS output";
+		break;
+	case 2:
+		str = "2 PPS output";
+		break;
+	case 3:
+		str = "3 PPS output";
+		break;
+	case 4:
+		str = "4 PPS output";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	netif_info(pdata, probe, pdata->netdev,
+		   "Number of PPS Outputs                       : %s\n",
+		   str);
+
+	switch (pdata->hw_feat.aux_snap_num) {
+	case 0:
+		str = "No auxiliary input";
+		break;
+	case 1:
+		str = "1 auxiliary input";
+		break;
+	case 2:
+		str = "2 auxiliary input";
+		break;
+	case 3:
+		str = "3 auxiliary input";
+		break;
+	case 4:
+		str = "4 auxiliary input";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	netif_info(pdata, probe, pdata->netdev,
+		   "Number of Auxiliary Snapshot Inputs         : %s",
+		   str);
+
+	netif_info(pdata, probe, pdata->netdev, "\n");
+	netif_info(pdata, probe, pdata->netdev,
+		   "=====================================================\n");
+	netif_info(pdata, probe, pdata->netdev, "\n");
+}
+
+static int gmac_init(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *netdev = pdata->netdev;
+	struct plat_gmac_data *plat = pdata->plat;
+	int ret;
+
+	/* power on PHY */
+	ret = gpio_request(pdata->phy_rst, "phy_rst");
+	if (ret < 0) {
+		dev_err(pdata->dev, "Unable to allocate PHY Reset");
+		return ret;
+	}
+	gpio_direction_output(pdata->phy_rst, 1);
+
+	/* Set the PHY mode, delay macro from top
+	 * it should be set before mac reset
+	 */
+	plat->gmac_set_interface(plat);
+	plat->gmac_set_delay(plat);
+
+	ret = plat->gmac_clk_enable(plat);
+	if (ret) {
+		dev_err(pdata->dev, "gmac clk enable failed\n");
+		return ret;
+	}
+
+	/* Set default configuration data */
+	gmac_default_config(pdata);
+
+	/* Set all the function pointers */
+	gmac_init_all_ops(pdata);
+
+	/* Issue software reset to device */
+	hw_ops->exit(pdata);
+
+	/* Populate the hardware features */
+	gmac_get_all_hw_features(pdata);
+
+	/* Set the DMA mask, 4GB mode enabled */
+	ret = dma_set_mask_and_coherent(pdata->dev,
+					DMA_BIT_MASK(pdata->dma_width));
+	if (ret) {
+		dev_err(pdata->dev, "dma_set_mask_and_coherent failed");
+		return ret;
+	}
+
+	/* Channel and ring params initializtion
+	 *  pdata->channel_count;
+	 *  pdata->tx_ring_count;
+	 *  pdata->rx_ring_count;
+	 *  pdata->tx_desc_count;
+	 *  pdata->rx_desc_count;
+	 */
+	BUILD_BUG_ON_NOT_POWER_OF_2(GMAC_TX_DESC_CNT);
+	BUILD_BUG_ON_NOT_POWER_OF_2(GMAC_RX_DESC_CNT);
+	pdata->tx_desc_count = GMAC_TX_DESC_CNT;
+	pdata->rx_desc_count = GMAC_RX_DESC_CNT;
+
+	pdata->tx_ring_count = min_t(unsigned int, pdata->hw_feat.tx_ch_cnt,
+				     pdata->hw_feat.tx_q_cnt);
+	pdata->tx_q_count = pdata->tx_ring_count;
+	ret = netif_set_real_num_tx_queues(netdev, pdata->tx_q_count);
+	if (ret) {
+		dev_err(pdata->dev, "error setting real tx queue count\n");
+		return ret;
+	}
+
+	pdata->rx_ring_count = min_t(unsigned int, pdata->hw_feat.rx_ch_cnt,
+				     pdata->hw_feat.rx_q_cnt);
+	pdata->rx_q_count = pdata->rx_ring_count;
+	ret = netif_set_real_num_rx_queues(netdev, pdata->rx_q_count);
+	if (ret) {
+		dev_err(pdata->dev, "error setting real rx queue count\n");
+		return ret;
+	}
+
+	pdata->channel_count =
+		max_t(unsigned int, pdata->tx_ring_count, pdata->rx_ring_count);
+
+	/* Set device operations */
+	netdev->netdev_ops = gmac_get_netdev_ops();
+	netdev->ethtool_ops = gmac_get_ethtool_ops();
+
+	/* Set device features */
+	if (pdata->hw_feat.tso) {
+		netdev->hw_features = NETIF_F_TSO;
+		netdev->hw_features |= NETIF_F_TSO6;
+		netdev->hw_features |= NETIF_F_SG;
+		netdev->hw_features |= NETIF_F_IP_CSUM;
+		netdev->hw_features |= NETIF_F_IPV6_CSUM;
+	} else if (pdata->hw_feat.tx_coe) {
+		netdev->hw_features = NETIF_F_IP_CSUM;
+		netdev->hw_features |= NETIF_F_IPV6_CSUM;
+	}
+
+	if (pdata->hw_feat.rx_coe) {
+		netdev->hw_features |= NETIF_F_RXCSUM;
+		netdev->hw_features |= NETIF_F_GRO;
+	}
+
+	netdev->vlan_features |= netdev->hw_features;
+
+	netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+	if (pdata->hw_feat.sa_vlan_ins)
+		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_TX;
+	if (pdata->hw_feat.vlhash)
+		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	netdev->features |= netdev->hw_features;
+	pdata->netdev_features = netdev->features;
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
+	/* Use default watchdog timeout */
+	netdev->watchdog_timeo = 0;
+
+	/* Tx coalesce parameters initialization */
+	pdata->tx_usecs = GMAC_INIT_DMA_TX_USECS;
+	pdata->tx_frames = GMAC_INIT_DMA_TX_FRAMES;
+
+	/* Rx coalesce parameters initialization */
+	pdata->rx_riwt = hw_ops->usec_to_riwt(pdata, GMAC_INIT_DMA_RX_USECS);
+	pdata->rx_usecs = GMAC_INIT_DMA_RX_USECS;
+	pdata->rx_frames = GMAC_INIT_DMA_RX_FRAMES;
+
+	return 0;
+}
+
+int gmac_drv_probe(struct device *dev,
+		   struct plat_gmac_data *plat,
+		   struct gmac_resources *res)
+{
+	struct gmac_pdata *pdata;
+	struct net_device *netdev;
+	int ret = 0;
+
+	netdev = alloc_etherdev_mq(sizeof(struct gmac_pdata),
+				   GMAC_MAX_DMA_CHANNELS);
+	if (!netdev) {
+		dev_err(dev, "Unable to alloc new net device\n");
+		return -ENOMEM;
+	}
+
+	SET_NETDEV_DEV(netdev, dev);
+	dev_set_drvdata(dev, netdev);
+	pdata = netdev_priv(netdev);
+	pdata->dev = dev;
+	pdata->netdev = netdev;
+	pdata->plat = plat;
+	pdata->mac_regs = res->base_addr;
+	pdata->dev_irq = res->irq;
+	pdata->phy_rst = res->phy_rst;
+	netdev->base_addr = (unsigned long)res->base_addr;
+	netdev->irq = res->irq;
+
+	if (res->mac_addr)
+		ether_addr_copy(netdev->dev_addr, res->mac_addr);
+
+	/* Check if the MAC address is valid, if not get a random one */
+	if (!is_valid_ether_addr(netdev->dev_addr)) {
+		pr_info("no valid MAC address supplied, using a random one\n");
+		eth_hw_addr_random(pdata->netdev);
+	}
+
+	pdata->msg_enable = netif_msg_init(debug, default_msg_level);
+	ret = gmac_init(pdata);
+	if (ret) {
+		dev_err(dev, "gmac init failed\n");
+		goto err_free_netdev;
+	}
+
+	ret = mdio_register(netdev);
+	if (ret < 0) {
+		dev_err(dev, "MDIO bus (id %d) registration failed\n",
+			pdata->bus_id);
+		goto err_free_netdev;
+	}
+
+	ret = register_netdev(netdev);
+	if (ret) {
+		dev_err(dev, "net device registration failed\n");
+		goto err_free_netdev;
+	}
+
+	gmac_print_all_hw_features(pdata);
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(netdev);
+
+	return ret;
+}
+
+int gmac_drv_remove(struct device *dev)
+{
+	struct net_device *netdev = dev_get_drvdata(dev);
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct plat_gmac_data *plat = pdata->plat;
+
+	plat->gmac_clk_disable(plat);
+	unregister_netdev(netdev);
+	free_netdev(netdev);
+
+	return 0;
+}
+
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.c b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.c
new file mode 100644
index 0000000..be15e5d
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include "mtk-gmac.h"
+
+static void gmac_unmap_desc_data(struct gmac_pdata *pdata,
+				 struct gmac_desc_data *desc_data,
+				 unsigned int tx_rx)
+{
+	/* since DMA memory of tx and rx owns different direction,
+	 * it should be a flag to distinguish whose DMA ummapping
+	 * is doing.
+	 */
+	if (desc_data->skb_dma) {
+		if (desc_data->mapped_as_page) {
+			dma_unmap_page(pdata->dev, desc_data->skb_dma,
+				       desc_data->skb_dma_len, DMA_TO_DEVICE);
+		} else if (tx_rx) {
+			dma_unmap_single(pdata->dev, desc_data->skb_dma,
+					 desc_data->skb_dma_len, DMA_TO_DEVICE);
+		} else {
+			dma_unmap_single(pdata->dev, desc_data->skb_dma,
+					 desc_data->skb_dma_len, DMA_FROM_DEVICE);
+		}
+		desc_data->skb_dma = 0;
+		desc_data->skb_dma_len = 0;
+	}
+
+	if (desc_data->skb) {
+		dev_kfree_skb_any(desc_data->skb);
+		desc_data->skb = NULL;
+	}
+
+	memset(&desc_data->trx, 0, sizeof(desc_data->trx));
+
+	desc_data->mapped_as_page = 0;
+
+	if (desc_data->state_saved) {
+		desc_data->state_saved = 0;
+		desc_data->state.skb = NULL;
+		desc_data->state.len = 0;
+		desc_data->state.error = 0;
+	}
+}
+
+static void gmac_free_ring(struct gmac_pdata *pdata,
+			   struct gmac_ring *ring,
+			   unsigned int tx_rx)
+{
+	struct gmac_desc_data *desc_data;
+	unsigned int i;
+
+	if (!ring)
+		return;
+
+	if (ring->desc_data_head) {
+		for (i = 0; i < ring->dma_desc_count; i++) {
+			desc_data = GMAC_GET_DESC_DATA(ring, i);
+			gmac_unmap_desc_data(pdata, desc_data, tx_rx);
+		}
+
+		kfree(ring->desc_data_head);
+		ring->desc_data_head = NULL;
+	}
+
+	if (ring->dma_desc_head) {
+		dma_free_coherent(pdata->dev,
+				  (sizeof(struct gmac_dma_desc) *
+				  ring->dma_desc_count),
+				  ring->dma_desc_head,
+				  ring->dma_desc_head_addr);
+		ring->dma_desc_head = NULL;
+	}
+}
+
+static int gmac_init_ring(struct gmac_pdata *pdata,
+			  struct gmac_ring *ring,
+			  unsigned int dma_desc_count)
+{
+	if (!ring)
+		return 0;
+
+	/* Descriptors */
+	ring->dma_desc_count = dma_desc_count;
+	ring->dma_desc_head = dma_alloc_coherent(pdata->dev,
+						 (sizeof(struct gmac_dma_desc) *
+						 dma_desc_count),
+						 &ring->dma_desc_head_addr,
+						 GFP_KERNEL);
+	if (!ring->dma_desc_head)
+		return -ENOMEM;
+
+	/* Array of descriptor data */
+	ring->desc_data_head = kcalloc(dma_desc_count,
+				       sizeof(struct gmac_desc_data),
+				       GFP_KERNEL);
+	if (!ring->desc_data_head)
+		return -ENOMEM;
+
+	netif_dbg(pdata, drv, pdata->netdev,
+		  "dma_desc_head=%p, dma_desc_head_addr=%pad, desc_data_head=%p\n",
+		ring->dma_desc_head,
+		&ring->dma_desc_head_addr,
+		ring->desc_data_head);
+
+	return 0;
+}
+
+static void gmac_free_rings(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+
+	if (!pdata->channel_head)
+		return;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		gmac_free_ring(pdata, channel->tx_ring, 1);
+		gmac_free_ring(pdata, channel->rx_ring, 0);
+	}
+}
+
+static int gmac_alloc_rings(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	int ret;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		netif_dbg(pdata, drv, pdata->netdev, "%s - Tx ring:\n",
+			  channel->name);
+
+		ret = gmac_init_ring(pdata, channel->tx_ring,
+				     pdata->tx_desc_count);
+
+		if (ret) {
+			netdev_alert(pdata->netdev,
+				     "error initializing Tx ring");
+			goto err_init_ring;
+		}
+
+		netif_dbg(pdata, drv, pdata->netdev, "%s - Rx ring:\n",
+			  channel->name);
+
+		ret = gmac_init_ring(pdata, channel->rx_ring,
+				     pdata->rx_desc_count);
+		if (ret) {
+			netdev_alert(pdata->netdev,
+				     "error initializing Rx ring\n");
+			goto err_init_ring;
+		}
+	}
+
+	return 0;
+
+err_init_ring:
+	gmac_free_rings(pdata);
+
+	return ret;
+}
+
+static void gmac_free_channels(struct gmac_pdata *pdata)
+{
+	if (!pdata->channel_head)
+		return;
+
+	kfree(pdata->channel_head->tx_ring);
+	pdata->channel_head->tx_ring = NULL;
+
+	kfree(pdata->channel_head->rx_ring);
+	pdata->channel_head->rx_ring = NULL;
+
+	kfree(pdata->channel_head);
+
+	pdata->channel_head = NULL;
+	pdata->channel_count = 0;
+}
+
+static int gmac_alloc_channels(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel_head, *channel;
+	struct gmac_ring *tx_ring, *rx_ring;
+	int ret = -ENOMEM;
+	unsigned int i;
+
+	channel_head = kcalloc(pdata->channel_count,
+			       sizeof(struct gmac_channel), GFP_KERNEL);
+	if (!channel_head)
+		return ret;
+
+	netif_dbg(pdata, drv, pdata->netdev,
+		  "channel_head=%p\n", channel_head);
+
+	tx_ring = kcalloc(pdata->tx_ring_count, sizeof(struct gmac_ring),
+			  GFP_KERNEL);
+	if (!tx_ring)
+		goto err_tx_ring;
+
+	rx_ring = kcalloc(pdata->rx_ring_count, sizeof(struct gmac_ring),
+			  GFP_KERNEL);
+	if (!rx_ring)
+		goto err_rx_ring;
+
+	for (i = 0, channel = channel_head; i < pdata->channel_count;
+		i++, channel++) {
+		snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
+		channel->pdata = pdata;
+		channel->queue_index = i;
+
+		if (pdata->per_channel_irq) {
+			/* Get the per DMA interrupt */
+			ret = pdata->channel_irq[i];
+			if (ret < 0) {
+				netdev_err(pdata->netdev,
+					   "get_irq %u failed\n",
+					   i + 1);
+				goto err_irq;
+			}
+			channel->dma_irq = ret;
+		}
+
+		if (i < pdata->tx_ring_count)
+			channel->tx_ring = tx_ring++;
+
+		if (i < pdata->rx_ring_count)
+			channel->rx_ring = rx_ring++;
+
+		netif_dbg(pdata, drv, pdata->netdev,
+			  "%s: dma_regs=%p, tx_ring=%p, rx_ring=%p\n",
+			  channel->name, channel->dma_regs,
+			  channel->tx_ring, channel->rx_ring);
+	}
+
+	pdata->channel_head = channel_head;
+
+	return 0;
+
+err_irq:
+	kfree(rx_ring);
+
+err_rx_ring:
+	kfree(tx_ring);
+
+err_tx_ring:
+	kfree(channel_head);
+
+	return ret;
+}
+
+static void gmac_free_channels_and_rings(struct gmac_pdata *pdata)
+{
+	gmac_free_rings(pdata);
+
+	gmac_free_channels(pdata);
+}
+
+static int gmac_alloc_channels_and_rings(struct gmac_pdata *pdata)
+{
+	int ret;
+
+	ret = gmac_alloc_channels(pdata);
+	if (ret)
+		goto err_alloc;
+
+	ret = gmac_alloc_rings(pdata);
+	if (ret)
+		goto err_alloc;
+
+	return 0;
+
+err_alloc:
+	gmac_free_channels_and_rings(pdata);
+
+	return ret;
+}
+
+static int gmac_map_rx_buffer(struct gmac_pdata *pdata,
+			      struct gmac_ring *ring,
+			      struct gmac_desc_data *desc_data)
+{
+	struct sk_buff *skb = desc_data->skb;
+
+	if (skb) {
+		skb_trim(skb, 0);
+		goto map_skb;
+	}
+
+	skb = __netdev_alloc_skb_ip_align(pdata->netdev,
+					  pdata->rx_buf_size,
+					  GFP_ATOMIC);
+	if (!skb) {
+		netdev_alert(pdata->netdev, "Failed to allocate skb\n");
+		return -ENOMEM;
+	}
+	desc_data->skb = skb;
+	desc_data->skb_dma_len = pdata->rx_buf_size;
+ map_skb:
+	desc_data->skb_dma = dma_map_single(pdata->dev,
+					    skb->data,
+					    pdata->rx_buf_size,
+					    DMA_FROM_DEVICE);
+	if (dma_mapping_error(pdata->dev, desc_data->skb_dma))
+		netdev_alert(pdata->netdev, "failed to do the RX dma map\n");
+
+	desc_data->mapped_as_page = 0;
+
+	return 0;
+}
+
+static void gmac_tx_desc_init(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct gmac_desc_data *desc_data;
+	struct gmac_dma_desc *dma_desc;
+	struct gmac_channel *channel;
+	struct gmac_ring *ring;
+	dma_addr_t dma_desc_addr;
+	unsigned int i, j;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->tx_ring;
+		if (!ring)
+			break;
+
+		dma_desc = ring->dma_desc_head;
+		dma_desc_addr = ring->dma_desc_head_addr;
+
+		for (j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = GMAC_GET_DESC_DATA(ring, j);
+
+			desc_data->dma_desc = dma_desc;
+			desc_data->dma_desc_addr = dma_desc_addr;
+
+			dma_desc++;
+			dma_desc_addr += sizeof(struct gmac_dma_desc);
+		}
+
+		ring->cur = 0;
+		ring->dirty = 0;
+		memset(&ring->tx, 0, sizeof(ring->tx));
+
+		hw_ops->tx_desc_init(channel);
+	}
+}
+
+static void gmac_rx_desc_init(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct gmac_desc_ops *desc_ops = &pdata->desc_ops;
+	struct gmac_desc_data *desc_data;
+	struct gmac_dma_desc *dma_desc;
+	struct gmac_channel *channel;
+	struct gmac_ring *ring;
+	dma_addr_t dma_desc_addr;
+	unsigned int i, j;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->rx_ring;
+		if (!ring)
+			break;
+
+		dma_desc = ring->dma_desc_head;
+		dma_desc_addr = ring->dma_desc_head_addr;
+
+		for (j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = GMAC_GET_DESC_DATA(ring, j);
+
+			desc_data->dma_desc = dma_desc;
+			desc_data->dma_desc_addr = dma_desc_addr;
+
+			if (desc_ops->map_rx_buffer(pdata, ring, desc_data))
+				break;
+
+			dma_desc++;
+			dma_desc_addr += sizeof(struct gmac_dma_desc);
+		}
+
+		ring->cur = 0;
+		ring->dirty = 0;
+
+		hw_ops->rx_desc_init(channel);
+	}
+}
+
+static int gmac_map_tx_skb(struct gmac_channel *channel,
+			   struct sk_buff *skb)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_ring *ring = channel->tx_ring;
+	unsigned int start_index, cur_index;
+	struct gmac_desc_data *desc_data;
+	unsigned int offset, datalen, len;
+	struct gmac_pkt_info *pkt_info;
+	struct skb_frag_struct *frag;
+	unsigned int tso, vlan;
+	dma_addr_t skb_dma;
+	unsigned int i;
+
+	offset = 0;
+	start_index = ring->cur;
+	cur_index = ring->cur;
+
+	pkt_info = &ring->pkt_info;
+	pkt_info->desc_count = 0;
+	pkt_info->length = 0;
+
+	tso = GMAC_GET_REG_BITS(pkt_info->attributes,
+				TX_PACKET_ATTRIBUTES_TSO_ENABLE_POS,
+				TX_PACKET_ATTRIBUTES_TSO_ENABLE_LEN);
+	vlan = GMAC_GET_REG_BITS(pkt_info->attributes,
+				 TX_PACKET_ATTRIBUTES_VLAN_CTAG_POS,
+				 TX_PACKET_ATTRIBUTES_VLAN_CTAG_LEN);
+
+	/* Save space for a context descriptor if needed */
+	if ((tso && pkt_info->mss != ring->tx.cur_mss) ||
+	    (vlan && pkt_info->vlan_ctag != ring->tx.cur_vlan_ctag))
+		cur_index++;
+
+	desc_data = GMAC_GET_DESC_DATA(ring, cur_index);
+
+	if (tso) {
+		/* Map the TSO header */
+		skb_dma = dma_map_single(pdata->dev, skb->data,
+					 pkt_info->header_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(pdata->dev, skb_dma)) {
+			netdev_alert(pdata->netdev, "dma_map_single failed\n");
+			goto err_out;
+		}
+		desc_data->skb_dma = skb_dma;
+		desc_data->skb_dma_len = pkt_info->header_len;
+		netif_dbg(pdata, tx_queued, pdata->netdev,
+			  "skb header: index=%u, dma=%pad, len=%u\n",
+			  cur_index, &skb_dma, pkt_info->header_len);
+
+		offset = pkt_info->header_len;
+
+		pkt_info->length += pkt_info->header_len;
+
+		cur_index++;
+		desc_data = GMAC_GET_DESC_DATA(ring, cur_index);
+	}
+
+	/* Map the (remainder of the) packet */
+	for (datalen = skb_headlen(skb) - offset; datalen; ) {
+		len = min_t(unsigned int, datalen, GMAC_TX_MAX_BUF_SIZE);
+
+		skb_dma = dma_map_single(pdata->dev, skb->data + offset, len,
+					 DMA_TO_DEVICE);
+		if (dma_mapping_error(pdata->dev, skb_dma)) {
+			netdev_alert(pdata->netdev, "dma_map_single failed\n");
+			goto err_out;
+		}
+		desc_data->skb_dma = skb_dma;
+		desc_data->skb_dma_len = len;
+		netif_dbg(pdata, tx_queued, pdata->netdev,
+			  "skb data: index=%u, dma=%pad, len=%u\n",
+			  cur_index, &skb_dma, len);
+
+		datalen -= len;
+		offset += len;
+
+		pkt_info->length += len;
+
+		cur_index++;
+		desc_data = GMAC_GET_DESC_DATA(ring, cur_index);
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		netif_dbg(pdata, tx_queued, pdata->netdev,
+			  "mapping frag %u\n", i);
+
+		frag = &skb_shinfo(skb)->frags[i];
+		offset = 0;
+
+		for (datalen = skb_frag_size(frag); datalen; ) {
+			len = min_t(unsigned int, datalen,
+				    GMAC_TX_MAX_BUF_SIZE);
+
+			skb_dma = skb_frag_dma_map(pdata->dev, frag, offset,
+						   len, DMA_TO_DEVICE);
+			if (dma_mapping_error(pdata->dev, skb_dma)) {
+				netdev_alert(pdata->netdev,
+					     "skb_frag_dma_map failed\n");
+				goto err_out;
+			}
+			desc_data->skb_dma = skb_dma;
+			desc_data->skb_dma_len = len;
+			desc_data->mapped_as_page = 1;
+			netif_dbg(pdata, tx_queued, pdata->netdev,
+				  "skb frag: index=%u, dma=%pad, len=%u\n",
+				  cur_index, &skb_dma, len);
+
+			datalen -= len;
+			offset += len;
+
+			pkt_info->length += len;
+
+			cur_index++;
+			desc_data = GMAC_GET_DESC_DATA(ring, cur_index);
+		}
+	}
+
+	/* Save the skb address in the last entry. We always have some data
+	 * that has been mapped so desc_data is always advanced past the last
+	 * piece of mapped data - use the entry pointed to by cur_index - 1.
+	 */
+	desc_data = GMAC_GET_DESC_DATA(ring, cur_index - 1);
+	desc_data->skb = skb;
+
+	/* Save the number of descriptor entries used */
+	pkt_info->desc_count = cur_index - start_index;
+
+	return pkt_info->desc_count;
+
+err_out:
+	while (start_index != cur_index) {
+		desc_data = GMAC_GET_DESC_DATA(ring, start_index++);
+		gmac_unmap_desc_data(pdata, desc_data, 1);
+	}
+
+	return 0;
+}
+
+void gmac_init_desc_ops(struct gmac_desc_ops *desc_ops)
+{
+	desc_ops->alloc_channles_and_rings = gmac_alloc_channels_and_rings;
+	desc_ops->free_channels_and_rings = gmac_free_channels_and_rings;
+	desc_ops->map_tx_skb = gmac_map_tx_skb;
+	desc_ops->map_rx_buffer = gmac_map_rx_buffer;
+	desc_ops->unmap_desc_data = gmac_unmap_desc_data;
+	desc_ops->tx_desc_init = gmac_tx_desc_init;
+	desc_ops->rx_desc_init = gmac_rx_desc_init;
+}
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.h b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.h
new file mode 100644
index 0000000..8c353ed
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-desc.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+#ifndef __MTK_GMAC_DESC_H__
+#define __MTK_GMAC_DESC_H__
+
+#include <linux/bitops.h>
+
+/* Normal transmit descriptor defines (without split feature) */
+
+#define GMAC_GET_REG_BITS_LE(var, pos, len) ({			\
+	typeof(pos) _pos = (pos);					\
+	typeof(len) _len = (len);					\
+	typeof(var) _var = le32_to_cpu((var));				\
+	((_var) & GENMASK(_pos + _len - 1, _pos)) >> (_pos);		\
+})
+
+#define GMAC_SET_REG_BITS_LE(var, pos, len, val) ({			\
+	typeof(var) _var = (var);					\
+	typeof(pos) _pos = (pos);					\
+	typeof(len) _len = (len);					\
+	typeof(val) _val = (val);					\
+	_val = (_val << _pos) & GENMASK(_pos + _len - 1, _pos);		\
+	_var = (_var & ~GENMASK(_pos + _len - 1, _pos)) | _val;		\
+	cpu_to_le32(_var);						\
+})
+
+#define TX_PACKET_ATTRIBUTES_CSUM_ENABLE_POS 0
+#define TX_PACKET_ATTRIBUTES_CSUM_ENABLE_LEN 1
+#define TX_PACKET_ATTRIBUTES_TSO_ENABLE_POS 1
+#define TX_PACKET_ATTRIBUTES_TSO_ENABLE_LEN 1
+#define TX_PACKET_ATTRIBUTES_VLAN_CTAG_POS 2
+#define TX_PACKET_ATTRIBUTES_VLAN_CTAG_LEN 1
+#define TX_PACKET_ATTRIBUTES_PTP_POS 3
+#define TX_PACKET_ATTRIBUTES_PTP_LEN 1
+
+#define TX_CONTEXT_DESC2_MSS_POS		0
+#define TX_CONTEXT_DESC2_MSS_LEN		14
+#define TX_CONTEXT_DESC3_CTXT_POS		30
+#define TX_CONTEXT_DESC3_CTXT_LEN		1
+#define TX_CONTEXT_DESC3_TCMSSV_POS		26
+#define TX_CONTEXT_DESC3_TCMSSV_LEN		1
+#define TX_CONTEXT_DESC3_VLTV_POS		16
+#define TX_CONTEXT_DESC3_VLTV_LEN		1
+#define TX_CONTEXT_DESC3_VT_POS			0
+#define TX_CONTEXT_DESC3_VT_LEN			16
+
+#define TX_NORMAL_DESC2_HL_B1L_POS		0
+#define TX_NORMAL_DESC2_HL_B1L_LEN		14
+#define TX_NORMAL_DESC2_IC_POS			31
+#define TX_NORMAL_DESC2_IC_LEN			1
+#define TX_NORMAL_DESC2_TTSE_POS		30
+#define TX_NORMAL_DESC2_TTSE_LEN		1
+#define TX_NORMAL_DESC2_VTIR_POS		14
+#define TX_NORMAL_DESC2_VTIR_LEN		2
+#define TX_NORMAL_DESC3_CIC_POS			16
+#define TX_NORMAL_DESC3_CIC_LEN			2
+#define TX_NORMAL_DESC3_CPC_POS			26
+#define TX_NORMAL_DESC3_CPC_LEN			2
+#define TX_NORMAL_DESC3_CTXT_POS		30
+#define TX_NORMAL_DESC3_CTXT_LEN		1
+#define TX_NORMAL_DESC3_FD_POS			29
+#define TX_NORMAL_DESC3_FD_LEN			1
+#define TX_NORMAL_DESC3_FL_POS			0
+#define TX_NORMAL_DESC3_FL_LEN			15
+#define TX_NORMAL_DESC3_LD_POS			28
+#define TX_NORMAL_DESC3_LD_LEN			1
+#define TX_NORMAL_DESC3_OWN_POS			31
+#define TX_NORMAL_DESC3_OWN_LEN			1
+#define TX_NORMAL_DESC3_TCPHDRLEN_POS		19
+#define TX_NORMAL_DESC3_TCPHDRLEN_LEN		4
+#define TX_NORMAL_DESC3_TCPPL_POS		0
+#define TX_NORMAL_DESC3_TCPPL_LEN		18
+#define TX_NORMAL_DESC3_TSE_POS			18
+#define TX_NORMAL_DESC3_TSE_LEN			1
+#define TX_NORMAL_DESC3_TTSS_POS		17
+#define TX_NORMAL_DESC3_TTSS_LEN		1
+
+#define TX_NORMAL_DESC2_VLAN_INSERT		0x2
+
+#define RX_PACKET_ATTRIBUTES_CSUM_DONE_POS	0
+#define RX_PACKET_ATTRIBUTES_CSUM_DONE_LEN	1
+#define RX_PACKET_ATTRIBUTES_VLAN_CTAG_POS	1
+#define RX_PACKET_ATTRIBUTES_VLAN_CTAG_LEN	1
+#define RX_PACKET_ATTRIBUTES_INCOMPLETE_POS	2
+#define RX_PACKET_ATTRIBUTES_INCOMPLETE_LEN	1
+#define RX_PACKET_ATTRIBUTES_CONTEXT_POS	3
+#define RX_PACKET_ATTRIBUTES_CONTEXT_LEN	1
+#define RX_PACKET_ATTRIBUTES_RX_TSTAMP_POS	4
+#define RX_PACKET_ATTRIBUTES_RX_TSTAMP_LEN	1
+
+#define RX_PACKET_ERRORS_CRC_POS		2
+#define RX_PACKET_ERRORS_CRC_LEN		1
+#define RX_PACKET_ERRORS_FRAME_POS		3
+#define RX_PACKET_ERRORS_FRAME_LEN		1
+#define RX_PACKET_ERRORS_LENGTH_POS		0
+#define RX_PACKET_ERRORS_LENGTH_LEN		1
+#define RX_PACKET_ERRORS_OVERRUN_POS		1
+#define RX_PACKET_ERRORS_OVERRUN_LEN		1
+
+#define RX_NORMAL_DESC0_OVT_POS			0
+#define RX_NORMAL_DESC0_OVT_LEN			16
+#define RX_NORMAL_DESC1_TSA_POS			14
+#define RX_NORMAL_DESC1_TSA_LEN			1
+#define RX_NORMAL_DESC1_IPHE_POS		3
+#define RX_NORMAL_DESC1_IPHE_LEN		1
+#define RX_NORMAL_DESC1_IPCB_POS		6
+#define RX_NORMAL_DESC1_IPCB_LEN		1
+#define RX_NORMAL_DESC1_IPCE_POS		7
+#define RX_NORMAL_DESC1_IPCE_LEN		1
+#define RX_NORMAL_DESC2_HL_POS			0
+#define RX_NORMAL_DESC2_HL_LEN			10
+#define RX_NORMAL_DESC3_CDA_POS			27
+#define RX_NORMAL_DESC3_CDA_LEN			1
+#define RX_NORMAL_DESC3_CTXT_POS		30
+#define RX_NORMAL_DESC3_CTXT_LEN		1
+#define RX_NORMAL_DESC3_ES_POS			15
+#define RX_NORMAL_DESC3_ES_LEN			1
+#define RX_NORMAL_DESC3_LT_POS			16
+#define RX_NORMAL_DESC3_LT_LEN			3
+#define RX_NORMAL_DESC3_FD_POS			29
+#define RX_NORMAL_DESC3_FD_LEN			1
+#define RX_NORMAL_DESC3_INTE_POS		30
+#define RX_NORMAL_DESC3_INTE_LEN		1
+#define RX_NORMAL_DESC3_BUF2V_POS		25
+#define RX_NORMAL_DESC3_BUF2V_LEN		1
+#define RX_NORMAL_DESC3_BUF1V_POS		24
+#define RX_NORMAL_DESC3_BUF1V_LEN		1
+#define RX_NORMAL_DESC3_L34T_POS		20
+#define RX_NORMAL_DESC3_L34T_LEN		4
+#define RX_NORMAL_DESC3_LD_POS			28
+#define RX_NORMAL_DESC3_LD_LEN			1
+#define RX_NORMAL_DESC3_OWN_POS			31
+#define RX_NORMAL_DESC3_OWN_LEN			1
+#define RX_NORMAL_DESC3_PL_POS			0
+#define RX_NORMAL_DESC3_PL_LEN			15
+#define RX_NORMAL_DESC3_RS2V_POS		27
+#define RX_NORMAL_DESC3_RS2V_LEN		1
+#define RX_NORMAL_DESC3_RS1V_POS		26
+#define RX_NORMAL_DESC3_RS1V_LEN		1
+#define RX_NORMAL_DESC3_RS0V_POS		25
+#define RX_NORMAL_DESC3_RS0V_LEN		1
+
+#define RX_CONTEXT_DESC3_OWN_POS		31
+#define RX_CONTEXT_DESC3_OWN_LEN		1
+#define RX_CONTEXT_DESC3_CTXT_POS		30
+#define RX_CONTEXT_DESC3_CTXT_LEN		1
+
+#endif /* __MT2712_DESCS_H__ */
+
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-ethtool.c b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-ethtool.c
new file mode 100644
index 0000000..68eb4cf
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-ethtool.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include <linux/ethtool.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+
+#include "mtk-gmac.h"
+
+struct gmac_stats_desc {
+	char stat_string[ETH_GSTRING_LEN];
+	int stat_offset;
+};
+
+#define GMAC_STAT(str, var)				\
+	{						\
+		str,					\
+		offsetof(struct gmac_pdata, stats.var),	\
+	}
+
+static const struct gmac_stats_desc gmac_gstring_stats[] = {
+	/* MMC TX counters */
+	GMAC_STAT("tx_bytes", txoctetcount_gb),
+	GMAC_STAT("tx_bytes_good", txoctetcount_g),
+	GMAC_STAT("tx_packets", txframecount_gb),
+	GMAC_STAT("tx_packets_good", txframecount_g),
+	GMAC_STAT("tx_unicast_packets", txunicastframes_gb),
+	GMAC_STAT("tx_broadcast_packets", txbroadcastframes_gb),
+	GMAC_STAT("tx_broadcast_packets_good", txbroadcastframes_g),
+	GMAC_STAT("tx_multicast_packets", txmulticastframes_gb),
+	GMAC_STAT("tx_multicast_packets_good", txmulticastframes_g),
+	GMAC_STAT("tx_vlan_packets_good", txvlanframes_g),
+	GMAC_STAT("tx_over_size_packets_good", txosizeframe_g),
+	GMAC_STAT("tx_64_byte_packets", tx64octets_gb),
+	GMAC_STAT("tx_65_to_127_byte_packets", tx65to127octets_gb),
+	GMAC_STAT("tx_128_to_255_byte_packets", tx128to255octets_gb),
+	GMAC_STAT("tx_256_to_511_byte_packets", tx256to511octets_gb),
+	GMAC_STAT("tx_512_to_1023_byte_packets", tx512to1023octets_gb),
+	GMAC_STAT("tx_1024_to_max_byte_packets", tx1024tomaxoctets_gb),
+	GMAC_STAT("tx_underflow_errors", txunderflowerror),
+	GMAC_STAT("tx_single_collision_good", txsinglecol_g),
+	GMAC_STAT("tx_multiple_collision_good", txmulticol_g),
+	GMAC_STAT("tx_deferred_packets", txdeferred),
+	GMAC_STAT("tx_late_collision_packets", txlatecol),
+	GMAC_STAT("tx_excessive-collision_packets", txexesscol),
+	GMAC_STAT("tx_carrier_error_packets", txcarriererror),
+	GMAC_STAT("tx_excessive_deferral_error", txexcessdef),
+	GMAC_STAT("tx_pause_frames", txpauseframes),
+	GMAC_STAT("tx_timestamp_packets", tx_timestamp_packets),
+	GMAC_STAT("tx_lpi_microseconds", txlpiusec),
+	GMAC_STAT("tx_lpi_transition", txlpitran),
+
+	/* MMC RX counters */
+	GMAC_STAT("rx_bytes", rxoctetcount_gb),
+	GMAC_STAT("rx_bytes_good", rxoctetcount_g),
+	GMAC_STAT("rx_packets", rxframecount_gb),
+	GMAC_STAT("rx_unicast_packets_good", rxunicastframes_g),
+	GMAC_STAT("rx_broadcast_packets_good", rxbroadcastframes_g),
+	GMAC_STAT("rx_multicast_packets_good", rxmulticastframes_g),
+	GMAC_STAT("rx_vlan_packets", rxvlanframes_gb),
+	GMAC_STAT("rx_64_byte_packets", rx64octets_gb),
+	GMAC_STAT("rx_65_to_127_byte_packets", rx65to127octets_gb),
+	GMAC_STAT("rx_128_to_255_byte_packets", rx128to255octets_gb),
+	GMAC_STAT("rx_256_to_511_byte_packets", rx256to511octets_gb),
+	GMAC_STAT("rx_512_to_1023_byte_packets", rx512to1023octets_gb),
+	GMAC_STAT("rx_1024_to_max_byte_packets", rx1024tomaxoctets_gb),
+	GMAC_STAT("rx_undersize_packets_good", rxundersize_g),
+	GMAC_STAT("rx_oversize_packets_good", rxoversize_g),
+	GMAC_STAT("rx_crc_errors", rxcrcerror),
+	GMAC_STAT("rx_alignment_error_packets", rxalignerror),
+	GMAC_STAT("rx_crc_errors_small_packets", rxrunterror),
+	GMAC_STAT("rx_crc_errors_giant_packets", rxjabbererror),
+	GMAC_STAT("rx_length_errors", rxlengtherror),
+	GMAC_STAT("rx_out_of_range_errors", rxoutofrangetype),
+	GMAC_STAT("rx_fifo_overflow_errors", rxfifooverflow),
+	GMAC_STAT("rx_watchdog_errors", rxwatchdogerror),
+	GMAC_STAT("rx_receive_errors", rxreceiveerror),
+	GMAC_STAT("rx_control_packets_good", rxctrlframes_g),
+	GMAC_STAT("rx_pause_frames", rxpauseframes),
+	GMAC_STAT("rx_timestamp_packets", rx_timestamp_packets),
+	GMAC_STAT("rx_lpi_microseconds", rxlpiusec),
+	GMAC_STAT("rx_lpi_transition", rxlpitran),
+
+	/* MMC RXIPC counters */
+	GMAC_STAT("rx_ipv4_good_packets", rxipv4_g),
+	GMAC_STAT("rx_ipv4_header_error_packets", rxipv4hderr),
+	GMAC_STAT("rx_ipv4_no_payload_packets", rxipv4nopay),
+	GMAC_STAT("rx_ipv4_fragmented_packets", rxipv4frag),
+	GMAC_STAT("rx_ipv4_udp_csum_dis_packets", rxipv4udsbl),
+	GMAC_STAT("rx_ipv6_good_packets", rxipv6octets_g),
+	GMAC_STAT("rx_ipv6_header_error_packets", rxipv6hderroctets),
+	GMAC_STAT("rx_ipv6_no_payload_packets", rxipv6nopayoctets),
+	GMAC_STAT("rx_udp_good_packets", rxudp_g),
+	GMAC_STAT("rx_udp_error_packets", rxudperr),
+	GMAC_STAT("rx_tcp_good_packets", rxtcp_g),
+	GMAC_STAT("rx_tcp_error_packets", rxtcperr),
+	GMAC_STAT("rx_icmp_good_packets", rxicmp_g),
+	GMAC_STAT("rx_icmp_error_packets", rxicmperr),
+	GMAC_STAT("rx_ipv4_good_bytes", rxipv4octets_g),
+	GMAC_STAT("rx_ipv4_header_error_bytes", rxipv4hderroctets),
+	GMAC_STAT("rx_ipv4_no_payload_bytes", rxipv4nopayoctets),
+	GMAC_STAT("rx_ipv4_fragmented_bytes", rxipv4fragoctets),
+	GMAC_STAT("rx_ipv4_udp_csum_dis_bytes", rxipv4udsbloctets),
+	GMAC_STAT("rx_ipv6_good_bytes", rxipv6_g),
+	GMAC_STAT("rx_ipv6_header_error_bytes", rxipv6hderr),
+	GMAC_STAT("rx_ipv6_no_payload_bytes", rxipv6nopay),
+	GMAC_STAT("rx_udp_good_bytes", rxudpoctets_g),
+	GMAC_STAT("rx_udp_error_bytes", rxudperroctets),
+	GMAC_STAT("rx_tcp_good_bytes", rxtcpoctets_g),
+	GMAC_STAT("rx_tcp_error_bytes", rxtcperroctets),
+	GMAC_STAT("rx_icmp_good_bytes", rxicmpoctets_g),
+	GMAC_STAT("rx_icmp_error_bytes", rxicmperroctets),
+
+	/* Extra counters */
+	GMAC_STAT("tx_tso_packets", tx_tso_packets),
+	GMAC_STAT("rx_split_header_packets", rx_split_header_packets),
+	GMAC_STAT("tx_process_stopped", tx_process_stopped),
+	GMAC_STAT("rx_process_stopped", rx_process_stopped),
+	GMAC_STAT("tx_buffer_unavailable", tx_buffer_unavailable),
+	GMAC_STAT("rx_buffer_unavailable", rx_buffer_unavailable),
+	GMAC_STAT("fatal_bus_error", fatal_bus_error),
+	GMAC_STAT("tx_vlan_packets", tx_vlan_packets),
+	GMAC_STAT("rx_vlan_packets", rx_vlan_packets),
+	GMAC_STAT("napi_poll_isr", napi_poll_isr),
+	GMAC_STAT("napi_poll_txtimer", napi_poll_txtimer),
+};
+
+#define GMAC_STATS_COUNT	ARRAY_SIZE(gmac_gstring_stats)
+
+static void gmac_ethtool_get_drvinfo(struct net_device *netdev,
+				     struct ethtool_drvinfo *drvinfo)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	u32 ver = pdata->hw_feat.version;
+	u32 snpsver, userver;
+
+	strlcpy(drvinfo->driver, pdata->drv_name, sizeof(drvinfo->driver));
+	strlcpy(drvinfo->version, pdata->drv_ver, sizeof(drvinfo->version));
+	strlcpy(drvinfo->bus_info, dev_name(pdata->dev),
+		sizeof(drvinfo->bus_info));
+	/* S|SNPSVER: Synopsys-defined Version
+	 * U|USERVER: User-defined Version
+	 */
+	snpsver = GMAC_GET_REG_BITS(ver,
+				    MAC_VR_SNPSVER_POS,
+				    MAC_VR_SNPSVER_LEN);
+	userver =  GMAC_GET_REG_BITS(ver,
+				     MAC_VR_USERVER_POS,
+				     MAC_VR_USERVER_LEN);
+	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+		 "S.U: %x.%x", snpsver, userver);
+}
+
+static u32 gmac_ethtool_get_msglevel(struct net_device *netdev)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+
+	return pdata->msg_enable;
+}
+
+static void gmac_ethtool_set_msglevel(struct net_device *netdev,
+				      u32 msglevel)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+
+	pdata->msg_enable = msglevel;
+}
+
+static void gmac_ethtool_get_channels(struct net_device *netdev,
+				      struct ethtool_channels *channel)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+
+	channel->max_rx = GMAC_MAX_DMA_CHANNELS;
+	channel->max_tx = GMAC_MAX_DMA_CHANNELS;
+	channel->rx_count = pdata->rx_q_count;
+	channel->tx_count = pdata->tx_q_count;
+}
+
+static int gmac_ethtool_get_coalesce(struct net_device *netdev,
+				     struct ethtool_coalesce *ec)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+
+	memset(ec, 0, sizeof(struct ethtool_coalesce));
+	ec->rx_coalesce_usecs = pdata->rx_usecs;
+	ec->rx_max_coalesced_frames = pdata->rx_frames;
+	ec->tx_max_coalesced_frames = pdata->tx_frames;
+
+	return 0;
+}
+
+static int gmac_ethtool_set_coalesce(struct net_device *netdev,
+				     struct ethtool_coalesce *ec)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	unsigned int rx_frames, rx_riwt, rx_usecs;
+	unsigned int tx_frames;
+
+	/* Check for not supported parameters */
+	if (ec->rx_coalesce_usecs_irq || ec->rx_max_coalesced_frames_irq ||
+	    ec->tx_coalesce_usecs || ec->tx_coalesce_usecs_high ||
+	    ec->tx_max_coalesced_frames_irq || ec->tx_coalesce_usecs_irq ||
+	    ec->stats_block_coalesce_usecs ||  ec->pkt_rate_low ||
+	    ec->use_adaptive_rx_coalesce || ec->use_adaptive_tx_coalesce ||
+	    ec->rx_max_coalesced_frames_low || ec->rx_coalesce_usecs_low ||
+	    ec->tx_coalesce_usecs_low || ec->tx_max_coalesced_frames_low ||
+	    ec->pkt_rate_high || ec->rx_coalesce_usecs_high ||
+	    ec->rx_max_coalesced_frames_high ||
+	    ec->tx_max_coalesced_frames_high ||
+	    ec->rate_sample_interval)
+		return -EOPNOTSUPP;
+
+	rx_usecs = ec->rx_coalesce_usecs;
+	rx_riwt = hw_ops->usec_to_riwt(pdata, rx_usecs);
+	rx_frames = ec->rx_max_coalesced_frames;
+	tx_frames = ec->tx_max_coalesced_frames;
+
+	if (rx_riwt > GMAC_MAX_DMA_RIWT ||
+	    rx_riwt < GMAC_MIN_DMA_RIWT ||
+	    rx_frames > pdata->rx_desc_count)
+		return -EINVAL;
+
+	if (tx_frames > pdata->tx_desc_count)
+		return -EINVAL;
+
+	pdata->rx_riwt = rx_riwt;
+	pdata->rx_usecs = rx_usecs;
+	pdata->rx_frames = rx_frames;
+	hw_ops->config_rx_coalesce(pdata);
+
+	pdata->tx_frames = tx_frames;
+	hw_ops->config_tx_coalesce(pdata);
+
+	return 0;
+}
+
+static void gmac_ethtool_get_strings(struct net_device *netdev,
+				     u32 stringset, u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < GMAC_STATS_COUNT; i++) {
+			memcpy(data, gmac_gstring_stats[i].stat_string,
+			       ETH_GSTRING_LEN);
+			data += ETH_GSTRING_LEN;
+		}
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
+static int gmac_ethtool_get_sset_count(struct net_device *netdev,
+				       int stringset)
+{
+	int ret;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		ret = GMAC_STATS_COUNT;
+		break;
+
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static void gmac_ethtool_get_ethtool_stats(struct net_device *netdev,
+					   struct ethtool_stats *stats,
+					   u64 *data)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	u8 *stat;
+	int i;
+
+	pdata->hw_ops.read_mmc_stats(pdata);
+	for (i = 0; i < GMAC_STATS_COUNT; i++) {
+		stat = (u8 *)pdata + gmac_gstring_stats[i].stat_offset;
+		*data++ = *(u64 *)stat;
+	}
+}
+
+static int gmac_get_ts_info(struct net_device *dev,
+			    struct ethtool_ts_info *info)
+{
+	struct gmac_pdata *pdata = netdev_priv(dev);
+
+	if (pdata->hw_feat.ts_src) {
+		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_TX_HARDWARE |
+					SOF_TIMESTAMPING_RX_SOFTWARE |
+					SOF_TIMESTAMPING_RX_HARDWARE |
+					SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_RAW_HARDWARE;
+
+		if (pdata->ptp_clock)
+			info->phc_index = ptp_clock_index(pdata->ptp_clock);
+
+		info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
+
+		info->rx_filters = ((1 << HWTSTAMP_FILTER_NONE) |
+				    (1 << HWTSTAMP_FILTER_PTP_V1_L4_EVENT) |
+				    (1 << HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
+				    (1 << HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
+				    (1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
+				    (1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
+				    (1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
+				    (1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
+				    (1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
+				    (1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ) |
+				    (1 << HWTSTAMP_FILTER_ALL));
+		return 0;
+	} else {
+		return ethtool_op_get_ts_info(dev, info);
+	}
+}
+
+static const struct ethtool_ops gmac_ethtool_ops = {
+	.get_drvinfo = gmac_ethtool_get_drvinfo,
+	.get_link = ethtool_op_get_link,
+	.get_msglevel = gmac_ethtool_get_msglevel,
+	.set_msglevel = gmac_ethtool_set_msglevel,
+	.get_channels = gmac_ethtool_get_channels,
+	.get_coalesce = gmac_ethtool_get_coalesce,
+	.set_coalesce = gmac_ethtool_set_coalesce,
+	.get_strings = gmac_ethtool_get_strings,
+	.get_sset_count = gmac_ethtool_get_sset_count,
+	.get_ethtool_stats = gmac_ethtool_get_ethtool_stats,
+	.get_ts_info = gmac_get_ts_info,
+};
+
+const struct ethtool_ops *gmac_get_ethtool_ops(void)
+{
+	return &gmac_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-hw.c b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-hw.c
new file mode 100644
index 0000000..82de2a57
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-hw.c
@@ -0,0 +1,3446 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include <linux/phy.h>
+#include <linux/mdio.h>
+#include <linux/bitrev.h>
+#include <linux/crc32.h>
+#include <linux/dcbnl.h>
+
+#include "mtk-gmac.h"
+
+static int gmac_tx_complete(struct gmac_dma_desc *dma_desc)
+{
+	return !GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				     TX_NORMAL_DESC3_OWN_POS,
+				     TX_NORMAL_DESC3_OWN_LEN);
+}
+
+static int gmac_disable_rx_csum(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_MCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_IPC_POS,
+				   MAC_MCR_IPC_LEN, 0);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	return 0;
+}
+
+static int gmac_enable_rx_csum(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_MCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_IPC_POS,
+				   MAC_MCR_IPC_LEN, 1);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	return 0;
+}
+
+static int gmac_set_mac_address(struct gmac_pdata *pdata,
+				u8 *addr,
+				unsigned int idx)
+{
+	unsigned int mac_addr_hi, mac_addr_lo;
+
+	mac_addr_hi = (addr[5] <<  8) | (addr[4] <<  0);
+	mac_addr_lo = (addr[3] << 24) | (addr[2] << 16) |
+		      (addr[1] <<  8) | (addr[0] <<  0);
+	mac_addr_hi = GMAC_SET_REG_BITS(mac_addr_hi,
+					MAC_ADDR_HR_AE_POS,
+					MAC_ADDR_HR_AE_LEN,
+					1);
+
+	GMAC_IOWRITE(pdata, MAC_ADDR_HR(idx), mac_addr_hi);
+	GMAC_IOWRITE(pdata, MAC_ADDR_LR(idx), mac_addr_lo);
+
+	return 0;
+}
+
+static void gmac_set_mac_reg(struct gmac_pdata *pdata,
+			     struct netdev_hw_addr *ha,
+			     unsigned int idx)
+{
+	unsigned int mac_addr_hi, mac_addr_lo;
+	u8 *mac_addr;
+
+	mac_addr_lo = 0;
+	mac_addr_hi = 0;
+
+	if (ha) {
+		mac_addr = (u8 *)&mac_addr_lo;
+		mac_addr[0] = ha->addr[0];
+		mac_addr[1] = ha->addr[1];
+		mac_addr[2] = ha->addr[2];
+		mac_addr[3] = ha->addr[3];
+		mac_addr = (u8 *)&mac_addr_hi;
+		mac_addr[0] = ha->addr[4];
+		mac_addr[1] = ha->addr[5];
+
+		netif_dbg(pdata, drv, pdata->netdev,
+			  "adding mac address %pM at %#x\n",
+			  ha->addr, idx);
+
+		mac_addr_hi = GMAC_SET_REG_BITS(mac_addr_hi,
+						MAC_ADDR_HR_AE_POS,
+						MAC_ADDR_HR_AE_LEN,
+						1);
+	}
+
+	GMAC_IOWRITE(pdata, MAC_ADDR_HR(idx), mac_addr_hi);
+	GMAC_IOWRITE(pdata, MAC_ADDR_LR(idx), mac_addr_lo);
+}
+
+static int gmac_enable_rx_vlan_stripping(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_VLANTR);
+	/* Put the VLAN tag in the Rx descriptor */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_EVLRXS_POS,
+				   MAC_VLANTR_EVLRXS_LEN, 1);
+	/* Don't check the VLAN type */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_DOVLTC_POS,
+				   MAC_VLANTR_DOVLTC_LEN, 1);
+	/* Check only C-TAG (0x8100) packets */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_ERSVLM_POS,
+				   MAC_VLANTR_ERSVLM_LEN, 0);
+	/* Don't consider an S-TAG (0x88A8) packet as a VLAN packet */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_ESVL_POS,
+				   MAC_VLANTR_ESVL_LEN, 0);
+	/* Enable VLAN tag stripping */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_EVLS_POS,
+				   MAC_VLANTR_EVLS_LEN, 0x3);
+	GMAC_IOWRITE(pdata, MAC_VLANTR, regval);
+
+	return 0;
+}
+
+static int gmac_disable_rx_vlan_stripping(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_VLANTR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_EVLS_POS,
+				   MAC_VLANTR_EVLS_LEN, 0);
+	GMAC_IOWRITE(pdata, MAC_VLANTR, regval);
+
+	return 0;
+}
+
+static int gmac_enable_rx_vlan_filtering(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_PFR);
+	/* Enable VLAN filtering */
+	regval = GMAC_SET_REG_BITS(regval, MAC_PFR_VTFE_POS,
+				   MAC_PFR_VTFE_LEN, 1);
+	GMAC_IOWRITE(pdata, MAC_PFR, regval);
+
+	regval = GMAC_IOREAD(pdata, MAC_VLANTR);
+	/* Enable VLAN Hash Table filtering */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_VTHM_POS,
+				   MAC_VLANTR_VTHM_LEN, 1);
+	/* Disable VLAN tag inverse matching */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_VTIM_POS,
+				   MAC_VLANTR_VTIM_LEN, 0);
+	/* Only filter on the lower 12-bits of the VLAN tag */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_ETV_POS,
+				   MAC_VLANTR_ETV_LEN, 1);
+	/* In order for the VLAN Hash Table filtering to be effective,
+	 * the VLAN tag identifier in the VLAN Tag Register must not
+	 * be zero.  Set the VLAN tag identifier to "1" to enable the
+	 * VLAN Hash Table filtering.  This implies that a VLAN tag of
+	 * 1 will always pass filtering.
+	 */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_VL_POS,
+				   MAC_VLANTR_VL_LEN, 1);
+	GMAC_IOWRITE(pdata, MAC_VLANTR, regval);
+
+	return 0;
+}
+
+static int gmac_disable_rx_vlan_filtering(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_PFR);
+	/* Disable VLAN filtering */
+	regval = GMAC_SET_REG_BITS(regval, MAC_PFR_VTFE_POS,
+				   MAC_PFR_VTFE_LEN, 0);
+	GMAC_IOWRITE(pdata, MAC_PFR, regval);
+
+	return 0;
+}
+
+static u32 gmac_vid_crc32_le(__le16 vid_le)
+{
+	unsigned char *data = (unsigned char *)&vid_le;
+	unsigned char data_byte = 0;
+	u32 poly = 0xedb88320;
+	u32 crc = ~0;
+	u32 temp = 0;
+	int i, bits;
+
+	bits = get_bitmask_order(VLAN_VID_MASK);
+	for (i = 0; i < bits; i++) {
+		if ((i % 8) == 0)
+			data_byte = data[i / 8];
+
+		temp = ((crc & 1) ^ data_byte) & 1;
+		crc >>= 1;
+		data_byte >>= 1;
+
+		if (temp)
+			crc ^= poly;
+	}
+
+	return crc;
+}
+
+static int gmac_update_vlan_hash_table(struct gmac_pdata *pdata)
+{
+	u16 vlan_hash_table = 0;
+	__le16 vid_le;
+	u32 regval;
+	u32 crc;
+	u16 vid;
+
+	/* Generate the VLAN Hash Table value */
+	for_each_set_bit(vid, pdata->active_vlans, VLAN_N_VID) {
+		/* Get the CRC32 value of the VLAN ID */
+		vid_le = cpu_to_le16(vid);
+		crc = bitrev32(~gmac_vid_crc32_le(vid_le)) >> 28;
+
+		vlan_hash_table |= (1 << crc);
+	}
+
+	regval = GMAC_IOREAD(pdata, MAC_VLANHTR);
+	/* Set the VLAN Hash Table filtering register */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANHTR_VLHT_POS,
+				   MAC_VLANHTR_VLHT_LEN, vlan_hash_table);
+	GMAC_IOWRITE(pdata, MAC_VLANHTR, regval);
+
+	return 0;
+}
+
+static void gmac_update_vlan_id(struct gmac_pdata *pdata,
+				u16 vid,
+				unsigned int enable,
+				unsigned int ofs)
+{
+	u32 regval;
+
+	/* Set the VLAN filtering register */
+	regval = GMAC_IOREAD(pdata, MAC_VLANTFR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTFR_VID_POS,
+				   MAC_VLANTFR_VID_LEN, vid);
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTFR_VEN_POS,
+				   MAC_VLANTFR_VEN_LEN, enable);
+	GMAC_IOWRITE(pdata, MAC_VLANTFR, regval);
+
+	/* Set the VLAN filtering register */
+	regval = GMAC_IOREAD(pdata, MAC_VLANTR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_OFS_POS,
+				   MAC_VLANTR_OFS_LEN, ofs);
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_CT_POS,
+				   MAC_VLANTR_CT_POS, 0);
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANTR_OB_POS,
+				   MAC_VLANTR_OB_POS, 1);
+	GMAC_IOWRITE(pdata, MAC_VLANTR, regval);
+
+	ofs++;
+}
+
+static int gmac_update_vlan(struct gmac_pdata *pdata)
+{
+	u32 ofs = 0;
+	u16 vid;
+
+	/* By default, receive only VLAN pkt with VID = 1
+	 * because writing 0 will pass all VLAN pkt
+	 * disable check vlan tag
+	 */
+	for (ofs = 0; ofs < pdata->vlan_weight; ofs++)
+		gmac_update_vlan_id(pdata, 1, 0, ofs);
+
+	ofs = 0;
+	/* Generate the VLAN Hash Table value */
+	for_each_set_bit(vid, pdata->active_vlans, VLAN_N_VID) {
+		gmac_update_vlan_id(pdata, vid, 1, ofs);
+		ofs++;
+	}
+
+	return 0;
+}
+
+static int gmac_set_promiscuous_mode(struct gmac_pdata *pdata,
+				     unsigned int enable)
+{
+	unsigned int val = enable ? 1 : 0;
+	u32 regval;
+
+	regval = GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_PFR),
+				   MAC_PFR_PR_POS, MAC_PFR_PR_LEN);
+	if (regval == val)
+		return 0;
+
+	netif_dbg(pdata, drv, pdata->netdev, "%s promiscuous mode\n",
+		  enable ? "entering" : "leaving");
+
+	regval = GMAC_IOREAD(pdata, MAC_PFR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_PFR_PR_POS,
+				   MAC_PFR_PR_LEN, val);
+	GMAC_IOWRITE(pdata, MAC_PFR, regval);
+
+	/* Hardware will still perform VLAN filtering in promiscuous mode */
+	if (enable) {
+		gmac_disable_rx_vlan_filtering(pdata);
+	} else {
+		if (pdata->netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+			gmac_enable_rx_vlan_filtering(pdata);
+	}
+
+	return 0;
+}
+
+static int gmac_set_all_multicast_mode(struct gmac_pdata *pdata,
+				       unsigned int enable)
+{
+	unsigned int val = enable ? 1 : 0;
+	u32 regval;
+
+	regval = GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_PFR),
+				   MAC_PFR_PM_POS, MAC_PFR_PM_LEN);
+	if (regval == val)
+		return 0;
+
+	netif_dbg(pdata, drv, pdata->netdev, "%s allmulti mode\n",
+		  enable ? "entering" : "leaving");
+
+	regval = GMAC_IOREAD(pdata, MAC_PFR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_PFR_PM_POS,
+				   MAC_PFR_PM_LEN, val);
+	GMAC_IOWRITE(pdata, MAC_PFR, regval);
+
+	return 0;
+}
+
+static void gmac_set_mac_addn_addrs(struct gmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	struct netdev_hw_addr *ha;
+	unsigned int addn_macs;
+	unsigned int addr_idx;
+
+	addr_idx = 1;
+	addn_macs = pdata->hw_feat.addn_mac;
+
+	if (netdev_uc_count(netdev) > addn_macs) {
+		gmac_set_promiscuous_mode(pdata, 1);
+	} else {
+		netdev_for_each_uc_addr(ha, netdev) {
+			gmac_set_mac_reg(pdata, ha, addr_idx);
+			addr_idx++;
+			addn_macs--;
+		}
+
+		if (netdev_mc_count(netdev) > addn_macs) {
+			gmac_set_all_multicast_mode(pdata, 1);
+		} else {
+			netdev_for_each_mc_addr(ha, netdev) {
+				gmac_set_mac_reg(pdata, ha, addr_idx);
+				addr_idx++;
+				addn_macs--;
+			}
+		}
+	}
+
+	/* Clear remaining additional MAC address entries */
+	while (addn_macs--) {
+		gmac_set_mac_reg(pdata, NULL, addr_idx);
+		addr_idx++;
+	}
+}
+
+static void gmac_set_mac_hash_table(struct gmac_pdata *pdata)
+{
+	unsigned int hash_table_shift, hash_table_count;
+	u32 hash_table[GMAC_MAC_HASH_TABLE_SIZE];
+	struct net_device *netdev = pdata->netdev;
+	struct netdev_hw_addr *ha;
+	unsigned int i;
+	u32 crc;
+
+	hash_table_shift = 26 - (pdata->hw_feat.hash_table_size >> 7);
+	hash_table_count = pdata->hw_feat.hash_table_size / 32;
+	memset(hash_table, 0, sizeof(hash_table));
+
+	/* Build the MAC Hash Table register values */
+	netdev_for_each_uc_addr(ha, netdev) {
+		crc = bitrev32(~crc32_le(~0, ha->addr, ETH_ALEN));
+		crc >>= hash_table_shift;
+		hash_table[crc >> 5] |= (1 << (crc & 0x1f));
+	}
+
+	netdev_for_each_mc_addr(ha, netdev) {
+		crc = bitrev32(~crc32_le(~0, ha->addr, ETH_ALEN));
+		crc >>= hash_table_shift;
+		hash_table[crc >> 5] |= (1 << (crc & 0x1f));
+	}
+
+	/* Set the MAC Hash Table registers */
+	for (i = 0; i < hash_table_count; i++)
+		GMAC_IOWRITE(pdata, MAC_HTR(i), hash_table[i]);
+}
+
+static int gmac_add_mac_addresses(struct gmac_pdata *pdata)
+{
+	if (pdata->hw_feat.hash_table_size)
+		gmac_set_mac_hash_table(pdata);
+	else
+		gmac_set_mac_addn_addrs(pdata);
+
+	return 0;
+}
+
+static void gmac_config_mac_address(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	gmac_set_mac_address(pdata, pdata->netdev->dev_addr, 0);
+
+	/* Filtering is done using perfect filtering and hash filtering */
+	if (pdata->hw_feat.hash_table_size) {
+		regval = GMAC_IOREAD(pdata, MAC_PFR);
+		regval = GMAC_SET_REG_BITS(regval, MAC_PFR_HPF_POS,
+					   MAC_PFR_HPF_LEN, 1);
+		regval = GMAC_SET_REG_BITS(regval, MAC_PFR_HUC_POS,
+					   MAC_PFR_HUC_LEN, 1);
+		regval = GMAC_SET_REG_BITS(regval, MAC_PFR_HMC_POS,
+					   MAC_PFR_HMC_LEN, 1);
+		GMAC_IOWRITE(pdata, MAC_PFR, regval);
+	}
+}
+
+static void gmac_config_jumbo_disable(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_MCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_JE_POS,
+				   MAC_MCR_JE_LEN, 0);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+}
+
+static void gmac_config_checksum_offload(struct gmac_pdata *pdata)
+{
+	if (pdata->netdev->features & NETIF_F_RXCSUM)
+		gmac_enable_rx_csum(pdata);
+	else
+		gmac_disable_rx_csum(pdata);
+}
+
+static void gmac_config_vlan_support(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_VLANIR);
+	/* Indicate that VLAN Tx CTAGs come from context descriptors */
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANIR_CSVL_POS,
+				   MAC_VLANIR_CSVL_LEN, 0);
+	regval = GMAC_SET_REG_BITS(regval, MAC_VLANIR_VLTI_POS,
+				   MAC_VLANIR_VLTI_LEN, 1);
+	GMAC_IOWRITE(pdata, MAC_VLANIR, regval);
+
+	/* Set the current VLAN Hash Table register value */
+	gmac_update_vlan_hash_table(pdata);
+
+	if (pdata->netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		gmac_enable_rx_vlan_filtering(pdata);
+	else
+		gmac_disable_rx_vlan_filtering(pdata);
+
+	if (pdata->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
+		gmac_enable_rx_vlan_stripping(pdata);
+	else
+		gmac_disable_rx_vlan_stripping(pdata);
+}
+
+static int gmac_config_rx_mode(struct gmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	unsigned int pr_mode, am_mode;
+
+	pr_mode = ((netdev->flags & IFF_PROMISC) != 0);
+	am_mode = ((netdev->flags & IFF_ALLMULTI) != 0);
+
+	gmac_set_promiscuous_mode(pdata, pr_mode);
+	gmac_set_all_multicast_mode(pdata, am_mode);
+
+	gmac_add_mac_addresses(pdata);
+
+	return 0;
+}
+
+static void gmac_prepare_tx_stop(struct gmac_pdata *pdata,
+				 struct gmac_channel *channel)
+{
+	unsigned int tx_dsr, tx_pos, tx_qidx;
+	unsigned long tx_timeout;
+	unsigned int tx_status;
+
+	/* Calculate the status register to read and the position within */
+	if (channel->queue_index < DMA_DSRX_FIRST_QUEUE) {
+		tx_dsr = DMA_DSR0;
+		tx_pos = (channel->queue_index * DMA_DSR_Q_LEN) +
+			 DMA_DSR0_TPS_START;
+	} else {
+		tx_qidx = channel->queue_index - DMA_DSRX_FIRST_QUEUE;
+
+		tx_dsr = DMA_DSR1 + ((tx_qidx / DMA_DSRX_QPR) * DMA_DSRX_INC);
+		tx_pos = ((tx_qidx % DMA_DSRX_QPR) * DMA_DSR_Q_LEN) +
+			 DMA_DSRX_TPS_START;
+	}
+
+	/* The Tx engine cannot be stopped if it is actively processing
+	 * descriptors. Wait for the Tx engine to enter the stopped or
+	 * suspended state.  Don't wait forever though...
+	 */
+	tx_timeout = jiffies + (GMAC_DMA_STOP_TIMEOUT * HZ);
+	while (time_before(jiffies, tx_timeout)) {
+		tx_status = GMAC_IOREAD(pdata, tx_dsr);
+		tx_status = GMAC_GET_REG_BITS(tx_status, tx_pos,
+					      DMA_DSR_TPS_LEN);
+		if (tx_status == tx_stopped ||
+		    tx_status == tx_suspended)
+			break;
+
+		usleep_range(500, 1000);
+	}
+
+	if (!time_before(jiffies, tx_timeout))
+		netdev_info(pdata->netdev,
+			    "timed out waiting for Tx DMA channel %u to stop\n",
+			    channel->queue_index);
+}
+
+static void gmac_enable_tx(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	/* Enable each Tx DMA channel */
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		regval = GMAC_IOREAD(pdata, DMA_CH_TCR(i));
+		regval = GMAC_SET_REG_BITS(regval, DMA_CH_TCR_ST_POS,
+					   DMA_CH_TCR_ST_LEN, 1);
+		GMAC_IOWRITE(pdata, DMA_CH_TCR(i), regval);
+	}
+
+	/* Enable each Tx queue */
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_TQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval, MTL_Q_TQOMR_TXQEN_POS,
+					   MTL_Q_TQOMR_TXQEN_LEN,
+					   MTL_Q_ENABLED);
+		GMAC_IOWRITE(pdata, MTL_Q_TQOMR(i), regval);
+	}
+
+	/* Enable MAC Tx */
+	regval = GMAC_IOREAD(pdata, MAC_MCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_TE_POS,
+				   MAC_MCR_TE_LEN, 1);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+}
+
+static void gmac_disable_tx(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	/* Disable each Tx DMA channel */
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+		/* Issue Tx dma stop command */
+		regval = GMAC_IOREAD(pdata, DMA_CH_TCR(i));
+		regval = GMAC_SET_REG_BITS(regval, DMA_CH_TCR_ST_POS,
+					   DMA_CH_TCR_ST_LEN, 0);
+		GMAC_IOWRITE(pdata, DMA_CH_TCR(i), regval);
+		/* Waiting for Tx DMA channel stop */
+		gmac_prepare_tx_stop(pdata, channel);
+	}
+
+	/* Disable MAC Tx */
+	regval = GMAC_IOREAD(pdata, MAC_MCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_TE_POS,
+				   MAC_MCR_TE_LEN, 0);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	/* Disable each Tx queue */
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_TQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval, MTL_Q_TQOMR_TXQEN_POS,
+					   MTL_Q_TQOMR_TXQEN_LEN, 0);
+		GMAC_IOWRITE(pdata, MTL_Q_TQOMR(i), regval);
+	}
+}
+
+static void gmac_prepare_rx_stop(struct gmac_pdata *pdata,
+				 struct gmac_channel *channel)
+{
+	unsigned int rx_dsr, rx_pos, rx_qidx;
+	unsigned long rx_timeout;
+	unsigned int rx_status;
+
+	/* Calculate the status register to read and the position within */
+	if (channel->queue_index < DMA_DSRX_FIRST_QUEUE) {
+		rx_dsr = DMA_DSR0;
+		rx_pos = (channel->queue_index * DMA_DSR_Q_LEN) +
+			 DMA_DSR0_RPS_START;
+	} else {
+		rx_qidx = channel->queue_index - DMA_DSRX_FIRST_QUEUE;
+
+		rx_dsr = DMA_DSR1 + ((rx_qidx / DMA_DSRX_QPR) * DMA_DSRX_INC);
+		rx_pos = ((rx_qidx % DMA_DSRX_QPR) * DMA_DSR_Q_LEN) +
+			 DMA_DSRX_RPS_START;
+	}
+
+		/* The Rx engine cannot be stopped if it is actively processing
+		 * descriptors. Wait for the Rx engine to enter the stopped or
+		 * suspended, waiting state.  Don't wait forever though...
+		 */
+		rx_timeout = jiffies + (GMAC_DMA_STOP_TIMEOUT * HZ);
+		while (time_before(jiffies, rx_timeout)) {
+			rx_status = GMAC_IOREAD(pdata, rx_dsr);
+			rx_status = GMAC_GET_REG_BITS(rx_status, rx_pos,
+						      DMA_DSR_RPS_LEN);
+			if (rx_status == rx_stopped ||
+			    rx_status == rx_suspended ||
+			    rx_status == rx_running_waiting)
+				break;
+
+			usleep_range(500, 1000);
+		}
+
+	if (!time_before(jiffies, rx_timeout))
+		netdev_info(pdata->netdev,
+			    "timed out waiting for Rx queue %u to empty\n",
+			    channel->queue_index);
+}
+
+static void gmac_enable_rx(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int regval, i;
+
+	/* Enable each Rx DMA channel */
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		regval = GMAC_IOREAD(pdata, DMA_CH_RCR(i));
+		regval = GMAC_SET_REG_BITS(regval, DMA_CH_RCR_SR_POS,
+					   DMA_CH_RCR_SR_LEN, 1);
+		GMAC_IOWRITE(pdata, DMA_CH_RCR(i), regval);
+	}
+
+	/* Enable each Rx queue */
+	regval = 0;
+	for (i = 0; i < pdata->rx_q_count; i++)
+		regval |= (0x02 << (i << 1));
+
+	GMAC_IOWRITE(pdata, MAC_RQC0R, regval);
+
+	/* Enable MAC Rx */
+	regval = GMAC_IOREAD(pdata, MAC_MCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_CST_POS,
+				   MAC_MCR_CST_LEN, 1);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_ACS_POS,
+				   MAC_MCR_ACS_LEN, 1);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_RE_POS,
+				   MAC_MCR_RE_LEN, 1);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+}
+
+static void gmac_disable_rx(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	/* Disable MAC Rx */
+	regval = GMAC_IOREAD(pdata, MAC_MCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_CST_POS,
+				   MAC_MCR_CST_LEN, 0);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_ACS_POS,
+				   MAC_MCR_ACS_LEN, 0);
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_RE_POS,
+				   MAC_MCR_RE_LEN, 0);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	/* Disable each Rx queue */
+	GMAC_IOWRITE(pdata, MAC_RQC0R, 0);
+
+	/* Disable each Rx DMA channel */
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		regval = GMAC_IOREAD(pdata, DMA_CH_RCR(i));
+		regval = GMAC_SET_REG_BITS(regval, DMA_CH_RCR_SR_POS,
+					   DMA_CH_RCR_SR_LEN, 0);
+		GMAC_IOWRITE(pdata, DMA_CH_RCR(i), regval);
+
+		/* Waiting for Rx DMA channel stop */
+		gmac_prepare_rx_stop(pdata, channel);
+	}
+}
+
+static void gmac_tx_start_xmit(struct gmac_channel *channel,
+			       struct gmac_ring *ring)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_desc_data *desc_data;
+	unsigned int q = channel->queue_index;
+
+	/* Make sure everything is written before the register write */
+	wmb();
+
+	/* Issue a poll command to Tx DMA by writing address
+	 * of next immediate free descriptor
+	 */
+	desc_data = GMAC_GET_DESC_DATA(ring, ring->cur);
+	GMAC_IOWRITE(pdata, DMA_CH_TDTR(q),
+		     lower_32_bits(desc_data->dma_desc_addr));
+
+	/* Start the Tx timer */
+	if (pdata->tx_usecs && !channel->tx_timer_active) {
+		channel->tx_timer_active = 1;
+		mod_timer(&channel->tx_timer,
+			  jiffies + usecs_to_jiffies(pdata->tx_usecs));
+	}
+
+	ring->tx.xmit_more = 0;
+}
+
+static void gmac_dev_xmit(struct gmac_channel *channel)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_ring *ring = channel->tx_ring;
+	unsigned int tso_context, vlan_context;
+	struct gmac_desc_data *desc_data;
+	struct gmac_dma_desc *dma_desc;
+	struct gmac_pkt_info *pkt_info;
+	unsigned int csum, tso, vlan;
+	int start_index = ring->cur;
+	int cur_index = ring->cur;
+	unsigned int tx_set_ic;
+	int i;
+
+	pkt_info = &ring->pkt_info;
+	csum = GMAC_GET_REG_BITS(pkt_info->attributes,
+				 TX_PACKET_ATTRIBUTES_CSUM_ENABLE_POS,
+				 TX_PACKET_ATTRIBUTES_CSUM_ENABLE_LEN);
+	tso = GMAC_GET_REG_BITS(pkt_info->attributes,
+				TX_PACKET_ATTRIBUTES_TSO_ENABLE_POS,
+				TX_PACKET_ATTRIBUTES_TSO_ENABLE_LEN);
+	vlan = GMAC_GET_REG_BITS(pkt_info->attributes,
+				 TX_PACKET_ATTRIBUTES_VLAN_CTAG_POS,
+				 TX_PACKET_ATTRIBUTES_VLAN_CTAG_LEN);
+
+	if (tso && pkt_info->mss != ring->tx.cur_mss)
+		tso_context = 1;
+	else
+		tso_context = 0;
+
+	if (vlan && pkt_info->vlan_ctag != ring->tx.cur_vlan_ctag)
+		vlan_context = 1;
+	else
+		vlan_context = 0;
+
+	/* Determine if an interrupt should be generated for this Tx:
+	 *   Interrupt:
+	 *     - Tx frame count exceeds the frame count setting
+	 *     - Addition of Tx frame count to the frame count since the
+	 *       last interrupt was set exceeds the frame count setting
+	 *   No interrupt:
+	 *     - No frame count setting specified (ethtool -C ethX tx-frames 0)
+	 *     - Addition of Tx frame count to the frame count since the
+	 *       last interrupt was set does not exceed the frame count setting
+	 */
+	ring->coalesce_count += pkt_info->tx_packets;
+	if (!pdata->tx_frames)
+		tx_set_ic = 0;
+	else if (pkt_info->tx_packets > pdata->tx_frames)
+		tx_set_ic = 1;
+	else if ((ring->coalesce_count % pdata->tx_frames) <
+		 pkt_info->tx_packets)
+		tx_set_ic = 1;
+	else
+		tx_set_ic = 0;
+
+	desc_data = GMAC_GET_DESC_DATA(ring, cur_index);
+	dma_desc = desc_data->dma_desc;
+
+	/* Create a context descriptor if this is a TSO pkt_info */
+	if (tso_context || vlan_context) {
+		if (tso_context) {
+			netif_dbg(pdata, tx_queued, pdata->netdev,
+				  "TSO context descriptor, mss=%u\n",
+				  pkt_info->mss);
+
+			/* Set the MSS size */
+			dma_desc->desc2 = GMAC_SET_REG_BITS_LE(dma_desc->desc2,
+							       TX_CONTEXT_DESC2_MSS_POS,
+							       TX_CONTEXT_DESC2_MSS_LEN,
+							       pkt_info->mss);
+
+			/* Mark it as a CONTEXT descriptor */
+			dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+							       TX_CONTEXT_DESC3_CTXT_POS,
+							       TX_CONTEXT_DESC3_CTXT_LEN,
+							       1);
+
+			/* Indicate this descriptor contains the MSS */
+			dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+							       TX_CONTEXT_DESC3_TCMSSV_POS,
+							       TX_CONTEXT_DESC3_TCMSSV_LEN,
+							       1);
+
+			ring->tx.cur_mss = pkt_info->mss;
+		}
+
+		if (vlan_context) {
+			netif_dbg(pdata, tx_queued, pdata->netdev,
+				  "VLAN context descriptor, ctag=%u\n",
+				  pkt_info->vlan_ctag);
+
+			/* Mark it as a CONTEXT descriptor */
+			dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+							       TX_CONTEXT_DESC3_CTXT_POS,
+							       TX_CONTEXT_DESC3_CTXT_LEN,
+							       1);
+
+			/* Set the VLAN tag */
+			dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+							       TX_CONTEXT_DESC3_VT_POS,
+							       TX_CONTEXT_DESC3_VT_LEN,
+							       pkt_info->vlan_ctag);
+
+			/* Indicate this descriptor contains the VLAN tag */
+			dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+							       TX_CONTEXT_DESC3_VLTV_POS,
+							       TX_CONTEXT_DESC3_VLTV_LEN,
+							       1);
+
+			ring->tx.cur_vlan_ctag = pkt_info->vlan_ctag;
+		}
+
+		cur_index++;
+		desc_data = GMAC_GET_DESC_DATA(ring, cur_index);
+		dma_desc = desc_data->dma_desc;
+	}
+
+	/* Update buffer address (for TSO this is the header) */
+	dma_desc->desc0 =  cpu_to_le32(lower_32_bits(desc_data->skb_dma));
+
+	/* Update the buffer length */
+	dma_desc->desc2 = GMAC_SET_REG_BITS_LE(dma_desc->desc2,
+					       TX_NORMAL_DESC2_HL_B1L_POS,
+					       TX_NORMAL_DESC2_HL_B1L_LEN,
+					       desc_data->skb_dma_len);
+
+	/* VLAN tag insertion check */
+	if (vlan) {
+		dma_desc->desc2 = GMAC_SET_REG_BITS_LE(dma_desc->desc2,
+						       TX_NORMAL_DESC2_VTIR_POS,
+						       TX_NORMAL_DESC2_VTIR_LEN,
+						       TX_NORMAL_DESC2_VLAN_INSERT);
+		pdata->stats.tx_vlan_packets++;
+	}
+
+	/* Timestamp enablement check */
+	if (GMAC_GET_REG_BITS(pkt_info->attributes,
+			      TX_PACKET_ATTRIBUTES_PTP_POS,
+			      TX_PACKET_ATTRIBUTES_PTP_LEN))
+		dma_desc->desc2 = GMAC_SET_REG_BITS_LE(dma_desc->desc2,
+						       TX_NORMAL_DESC2_TTSE_POS,
+						       TX_NORMAL_DESC2_TTSE_LEN,
+						       1);
+
+	/* Mark it as First Descriptor */
+	dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+					       TX_NORMAL_DESC3_FD_POS,
+					       TX_NORMAL_DESC3_FD_LEN,
+					       1);
+
+	/* Mark it as a NORMAL descriptor */
+	dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+					       TX_NORMAL_DESC3_CTXT_POS,
+					       TX_NORMAL_DESC3_CTXT_LEN,
+					       0);
+
+	/* Set OWN bit if not the first descriptor */
+	if (cur_index != start_index)
+		dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+						       TX_NORMAL_DESC3_OWN_POS,
+						       TX_NORMAL_DESC3_OWN_LEN,
+						       1);
+
+	if (tso) {
+		/* Enable TSO */
+		dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+						       TX_NORMAL_DESC3_TSE_POS,
+						       TX_NORMAL_DESC3_TSE_LEN,
+						       1);
+		dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+						       TX_NORMAL_DESC3_TCPPL_POS,
+						       TX_NORMAL_DESC3_TCPPL_LEN,
+						       pkt_info->tcp_payload_len);
+		dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+						       TX_NORMAL_DESC3_TCPHDRLEN_POS,
+						       TX_NORMAL_DESC3_TCPHDRLEN_LEN,
+						       pkt_info->tcp_header_len / 4);
+
+		pdata->stats.tx_tso_packets++;
+	} else {
+		/* Enable CRC and Pad Insertion */
+		dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+						       TX_NORMAL_DESC3_CPC_POS,
+						       TX_NORMAL_DESC3_CPC_LEN,
+						       0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+							       TX_NORMAL_DESC3_CIC_POS,
+							       TX_NORMAL_DESC3_CIC_LEN,
+							       0x3);
+
+		/* Set the total length to be transmitted */
+		dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+						       TX_NORMAL_DESC3_FL_POS,
+						       TX_NORMAL_DESC3_FL_LEN,
+						       pkt_info->length);
+	}
+
+	for (i = cur_index - start_index + 1; i < pkt_info->desc_count; i++) {
+		cur_index++;
+		desc_data = GMAC_GET_DESC_DATA(ring, cur_index);
+		dma_desc = desc_data->dma_desc;
+
+		/* Update buffer address */
+		dma_desc->desc0 =
+			cpu_to_le32(lower_32_bits(desc_data->skb_dma));
+
+		/* Update the buffer length */
+		dma_desc->desc2 = GMAC_SET_REG_BITS_LE(dma_desc->desc2,
+						       TX_NORMAL_DESC2_HL_B1L_POS,
+						       TX_NORMAL_DESC2_HL_B1L_LEN,
+						       desc_data->skb_dma_len);
+
+		/* Set OWN bit */
+		dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+						       TX_NORMAL_DESC3_OWN_POS,
+						       TX_NORMAL_DESC3_OWN_LEN,
+						       1);
+
+		/* Mark it as NORMAL descriptor */
+		dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+						       TX_NORMAL_DESC3_CTXT_POS,
+						       TX_NORMAL_DESC3_CTXT_LEN,
+						       0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+							       TX_NORMAL_DESC3_CIC_POS,
+							       TX_NORMAL_DESC3_CIC_LEN,
+							       0x3);
+	}
+
+	/* Set LAST bit for the last descriptor */
+	dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+					       TX_NORMAL_DESC3_LD_POS,
+					       TX_NORMAL_DESC3_LD_LEN,
+					       1);
+
+	/* Set IC bit based on Tx coalescing settings */
+	if (tx_set_ic)
+		dma_desc->desc2 = GMAC_SET_REG_BITS_LE(dma_desc->desc2,
+						       TX_NORMAL_DESC2_IC_POS,
+						       TX_NORMAL_DESC2_IC_LEN,
+						       1);
+
+	/* Save the Tx info to report back during cleanup */
+	desc_data->trx.packets = pkt_info->tx_packets;
+	desc_data->trx.bytes = pkt_info->tx_bytes;
+
+	/* In case the Tx DMA engine is running, make sure everything
+	 * is written to the descriptor(s) before setting the OWN bit
+	 * for the first descriptor
+	 */
+	dma_wmb();
+
+	/* Set OWN bit for the first descriptor */
+	desc_data = GMAC_GET_DESC_DATA(ring, start_index);
+	dma_desc = desc_data->dma_desc;
+	dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+					       TX_NORMAL_DESC3_OWN_POS,
+					       TX_NORMAL_DESC3_OWN_LEN,
+					       1);
+
+	if (netif_msg_tx_queued(pdata))
+		gmac_dump_tx_desc(pdata, ring, start_index,
+				  pkt_info->desc_count, 1);
+
+	/* Make sure ownership is written to the descriptor */
+	smp_wmb();
+
+	ring->cur = cur_index + 1;
+	if (!pkt_info->skb->xmit_more ||
+	    netif_xmit_stopped(netdev_get_tx_queue(pdata->netdev,
+						   channel->queue_index)))
+		gmac_tx_start_xmit(channel, ring);
+	else
+		ring->tx.xmit_more = 1;
+
+	netif_dbg(pdata, tx_queued, pdata->netdev,
+		  "%s: descriptors %u to %u written, %u:%u\n",
+		  channel->name, start_index & (ring->dma_desc_count - 1),
+		  (ring->cur - 1) & (ring->dma_desc_count - 1),
+		  start_index,
+		  ring->cur);
+}
+
+static int gmac_check_rx_tstamp(struct gmac_dma_desc *dma_desc)
+{
+	u32 own, ctxt;
+	int ret = 1;
+
+	own = GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				   RX_CONTEXT_DESC3_OWN_POS,
+				   RX_CONTEXT_DESC3_OWN_LEN);
+	ctxt = GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				    RX_CONTEXT_DESC3_CTXT_POS,
+				    RX_CONTEXT_DESC3_CTXT_LEN);
+
+	if (likely(!own && ctxt)) {
+		if (dma_desc->desc0 == 0xffffffff &&
+		    dma_desc->desc1 == 0xffffffff)
+			/* Corrupted value */
+			ret = -EINVAL;
+		else
+			/* A valid Timestamp is ready to be read */
+			ret = 0;
+	}
+
+	/* Timestamp not ready */
+	return ret;
+}
+
+static u64 gmac_get_rx_tstamp(struct gmac_dma_desc *dma_desc)
+{
+	u64 nsec;
+
+	nsec = le32_to_cpu(dma_desc->desc1);
+	nsec += le32_to_cpu(dma_desc->desc0) * 1000000000ULL;
+
+	return nsec;
+}
+
+static int gmac_get_rx_tstamp_status(struct gmac_pdata *pdata,
+				     struct gmac_dma_desc *next_desc,
+				     struct gmac_pkt_info *pkt_info)
+{
+	int ret = -EINVAL;
+
+	int i = 0;
+
+	/* Check if timestamp is OK from context descriptor */
+	do {
+		ret = gmac_check_rx_tstamp(next_desc);
+		if (ret <= 0)
+			goto exit;
+		i++;
+	} while ((ret == 1) && (i < 10));
+
+	if (i == 10) {
+		ret = -EBUSY;
+		netif_dbg(pdata, rx_status, pdata->netdev,
+			  "Device has not yet updated the context desc to hold Rx time stamp\n");
+	}
+exit:
+	if (likely(ret == 0)) {
+		/* Timestamp Context Descriptor */
+		pkt_info->rx_tstamp =
+			gmac_get_rx_tstamp(next_desc);
+		pkt_info->attributes =
+			GMAC_SET_REG_BITS(pkt_info->attributes,
+					  RX_PACKET_ATTRIBUTES_RX_TSTAMP_POS,
+					  RX_PACKET_ATTRIBUTES_RX_TSTAMP_LEN,
+					  1);
+		return 1;
+	}
+
+	netif_dbg(pdata, rx_status, pdata->netdev, "RX hw timestamp corrupted\n");
+
+	return ret;
+}
+
+static void gmac_tx_desc_reset(struct gmac_desc_data *desc_data)
+{
+	struct gmac_dma_desc *dma_desc = desc_data->dma_desc;
+
+	/* Reset the Tx descriptor
+	 *   Set buffer 1 (lo) address to zero
+	 *   Set buffer 1 (hi) address to zero
+	 *   Reset all other control bits (IC, TTSE, B2L & B1L)
+	 *   Reset all other control bits (OWN, CTXT, FD, LD, CPC, CIC, etc)
+	 */
+	dma_desc->desc0 = 0;
+	dma_desc->desc1 = 0;
+	dma_desc->desc2 = 0;
+	dma_desc->desc3 = 0;
+
+	/* Make sure ownership is written to the descriptor */
+	dma_wmb();
+}
+
+static void gmac_tx_desc_init(struct gmac_channel *channel)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_ring *ring = channel->tx_ring;
+	struct gmac_desc_data *desc_data;
+	unsigned int q = channel->queue_index;
+	int start_index = ring->cur;
+	int i;
+
+	/* Initialize all descriptors */
+	for (i = 0; i < ring->dma_desc_count; i++) {
+		desc_data = GMAC_GET_DESC_DATA(ring, i);
+
+		/* Initialize Tx descriptor */
+		gmac_tx_desc_reset(desc_data);
+	}
+
+	/* Update the total number of Tx descriptors */
+	GMAC_IOWRITE(pdata, DMA_CH_TDRLR(q), ring->dma_desc_count - 1);
+
+	/* Update the starting address of descriptor ring */
+	desc_data = GMAC_GET_DESC_DATA(ring, start_index);
+	GMAC_IOWRITE(pdata, DMA_CH_TDLR(q),
+		     lower_32_bits(desc_data->dma_desc_addr));
+}
+
+static void gmac_rx_desc_reset(struct gmac_pdata *pdata,
+			       struct gmac_desc_data *desc_data,
+			       unsigned int index)
+{
+	struct gmac_dma_desc *dma_desc = desc_data->dma_desc;
+	unsigned int rx_frames = pdata->rx_frames;
+	unsigned int rx_usecs = pdata->rx_usecs;
+	unsigned int inte;
+
+	memset(dma_desc, 0, sizeof(struct gmac_dma_desc));
+
+	if (!rx_usecs && !rx_frames) {
+		/* No coalescing, interrupt for every descriptor */
+		inte = 1;
+	} else {
+		/* Set interrupt based on Rx frame coalescing setting */
+		if (rx_frames && !((index + 1) % rx_frames))
+			inte = 1;
+		else
+			inte = 0;
+	}
+
+	/* Reset the Rx descriptor
+	 * Normal Frame
+	 *   Set buffer 1 address to skb dma address
+	 *   Set buffer 2 address to 0 and
+	 *   set control bits OWN and INTE
+	 */
+
+	dma_desc->desc0 = desc_data->skb_dma;
+	dma_desc->desc1 = 0;
+	dma_desc->desc2 = 0;
+	dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+					       RX_NORMAL_DESC3_BUF2V_POS,
+					       RX_NORMAL_DESC3_BUF2V_LEN,
+					       0);
+
+	dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+					       RX_NORMAL_DESC3_BUF1V_POS,
+					       RX_NORMAL_DESC3_BUF1V_LEN,
+					       1);
+
+	dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+					       RX_NORMAL_DESC3_INTE_POS,
+					       RX_NORMAL_DESC3_INTE_LEN,
+					       inte);
+
+	/* Since the Rx DMA engine is likely running, make sure everything
+	 * is written to the descriptor(s) before setting the OWN bit
+	 * for the descriptor
+	 */
+	dma_wmb();
+
+	dma_desc->desc3 = GMAC_SET_REG_BITS_LE(dma_desc->desc3,
+					       RX_NORMAL_DESC3_OWN_POS,
+					       RX_NORMAL_DESC3_OWN_LEN,
+					       1);
+
+	/* Make sure ownership is written to the descriptor */
+	dma_wmb();
+}
+
+static void gmac_rx_desc_init(struct gmac_channel *channel)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_ring *ring = channel->rx_ring;
+	unsigned int start_index = ring->cur;
+	struct gmac_desc_data *desc_data;
+	unsigned int q = channel->queue_index;
+	unsigned int i;
+
+	/* Initialize all descriptors */
+	for (i = 0; i < ring->dma_desc_count; i++) {
+		desc_data = GMAC_GET_DESC_DATA(ring, i);
+
+		/* Initialize Rx descriptor */
+		gmac_rx_desc_reset(pdata, desc_data, i);
+	}
+
+	/* Update the total number of Rx descriptors */
+	GMAC_IOWRITE(pdata, DMA_CH_RDRLR(q), ring->dma_desc_count - 1);
+
+	/* Update the starting address of descriptor ring */
+	desc_data = GMAC_GET_DESC_DATA(ring, start_index);
+	GMAC_IOWRITE(pdata, DMA_CH_RDLR(q),
+		     lower_32_bits(desc_data->dma_desc_addr));
+
+	/* Update the Rx Descriptor Tail Pointer */
+	desc_data = GMAC_GET_DESC_DATA(ring, start_index +
+				       ring->dma_desc_count - 1);
+	GMAC_IOWRITE(pdata, DMA_CH_RDTR(q),
+		     lower_32_bits(desc_data->dma_desc_addr));
+}
+
+static int gmac_is_context_desc(struct gmac_dma_desc *dma_desc)
+{
+	/* Rx and Tx share CTXT bit, so check TDES3.CTXT bit */
+	return GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				    TX_NORMAL_DESC3_CTXT_POS,
+				    TX_NORMAL_DESC3_CTXT_LEN);
+}
+
+static int gmac_is_last_desc(struct gmac_dma_desc *dma_desc)
+{
+	/* Rx and Tx share LD bit, so check TDES3.LD bit */
+	return GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				    TX_NORMAL_DESC3_LD_POS,
+				    TX_NORMAL_DESC3_LD_LEN);
+}
+
+static int gmac_is_rx_csum_error(struct gmac_dma_desc *dma_desc)
+{
+	/* Rx csum error, so check TDES1.IPHE/IPCB/IPCE bit */
+	return GMAC_GET_REG_BITS_LE(dma_desc->desc1,
+				    RX_NORMAL_DESC1_IPHE_POS,
+				    RX_NORMAL_DESC1_IPHE_LEN) ||
+	       GMAC_GET_REG_BITS_LE(dma_desc->desc1,
+				    RX_NORMAL_DESC1_IPCB_POS,
+				    RX_NORMAL_DESC1_IPCB_LEN) ||
+	       GMAC_GET_REG_BITS_LE(dma_desc->desc1,
+				    RX_NORMAL_DESC1_IPCE_POS,
+				    RX_NORMAL_DESC1_IPCE_LEN);
+}
+
+static int gmac_is_rx_csum_valid(struct gmac_dma_desc *dma_desc)
+{
+	unsigned int vlan_type;
+
+	vlan_type = GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+					 RX_NORMAL_DESC3_LT_POS,
+					 RX_NORMAL_DESC3_LT_LEN);
+
+	/* Rx csum error, so check TDES1.IPHE/IPCB/IPCE bit */
+	return GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				    RX_NORMAL_DESC3_RS0V_POS,
+				    RX_NORMAL_DESC3_RS0V_LEN) &&
+	       ((vlan_type == 4) || (vlan_type == 5));
+}
+
+static int gmac_disable_tx_flow_control(struct gmac_pdata *pdata)
+{
+	unsigned int max_q_count, q_count;
+	unsigned int regval;
+	unsigned int i;
+
+	/* Clear MTL flow control */
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_RQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval, MTL_Q_RQOMR_EHFC_POS,
+					   MTL_Q_RQOMR_EHFC_LEN, 0);
+		GMAC_IOWRITE(pdata, MTL_Q_RQOMR(i), regval);
+	}
+
+	/* Clear MAC flow control */
+	max_q_count = GMAC_MAX_FLOW_CONTROL_QUEUES;
+	q_count = min_t(unsigned int, pdata->tx_q_count, max_q_count);
+	for (i = 0; i < q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MAC_Q_TFCR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MAC_QTFCR_TFE_POS,
+					   MAC_QTFCR_TFE_LEN,
+					   0);
+		GMAC_IOWRITE(pdata, MAC_Q_TFCR(i), regval);
+	}
+
+	return 0;
+}
+
+static int gmac_enable_tx_flow_control(struct gmac_pdata *pdata)
+{
+	unsigned int max_q_count, q_count;
+	unsigned int regval;
+	unsigned int i;
+
+	/* Set MTL flow control */
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_RQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval, MTL_Q_RQOMR_EHFC_POS,
+					   MTL_Q_RQOMR_EHFC_LEN, 1);
+		GMAC_IOWRITE(pdata, MTL_Q_RQOMR(i), regval);
+	}
+
+	/* Set MAC flow control */
+	max_q_count = GMAC_MAX_FLOW_CONTROL_QUEUES;
+	q_count = min_t(unsigned int, pdata->tx_q_count, max_q_count);
+	for (i = 0; i < q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MAC_Q_TFCR(i));
+		/* Enable transmit flow control */
+		regval = GMAC_SET_REG_BITS(regval, MAC_QTFCR_TFE_POS,
+					   MAC_QTFCR_TFE_LEN, 1);
+		/* Set pause time */
+		regval = GMAC_SET_REG_BITS(regval, MAC_QTFCR_PT_POS,
+					   MAC_QTFCR_PT_LEN, 0xffff);
+		GMAC_IOWRITE(pdata, MAC_Q_TFCR(i), regval);
+	}
+
+	return 0;
+}
+
+static int gmac_disable_rx_flow_control(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_RFCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_RFCR_RFE_POS,
+				   MAC_RFCR_RFE_LEN, 0);
+	GMAC_IOWRITE(pdata, MAC_RFCR, regval);
+
+	return 0;
+}
+
+static int gmac_enable_rx_flow_control(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, MAC_RFCR);
+	regval = GMAC_SET_REG_BITS(regval, MAC_RFCR_RFE_POS,
+				   MAC_RFCR_RFE_LEN, 1);
+	GMAC_IOWRITE(pdata, MAC_RFCR, regval);
+
+	return 0;
+}
+
+static int gmac_config_tx_flow_control(struct gmac_pdata *pdata)
+{
+	if (pdata->tx_pause)
+		gmac_enable_tx_flow_control(pdata);
+	else
+		gmac_disable_tx_flow_control(pdata);
+
+	return 0;
+}
+
+static int gmac_config_rx_flow_control(struct gmac_pdata *pdata)
+{
+	if (pdata->rx_pause)
+		gmac_enable_rx_flow_control(pdata);
+	else
+		gmac_disable_rx_flow_control(pdata);
+
+	return 0;
+}
+
+static int gmac_config_rx_coalesce(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		regval = GMAC_IOREAD(pdata, DMA_CH_RIWT(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   DMA_CH_RIWT_RWT_POS,
+					   DMA_CH_RIWT_RWT_LEN,
+					   pdata->rx_riwt);
+		GMAC_IOWRITE(pdata, DMA_CH_RIWT(i), regval);
+	}
+
+	return 0;
+}
+
+static void gmac_config_flow_control(struct gmac_pdata *pdata)
+{
+	gmac_config_tx_flow_control(pdata);
+	gmac_config_rx_flow_control(pdata);
+}
+
+static void gmac_config_rx_fep_enable(struct gmac_pdata *pdata)
+{
+	unsigned int i;
+	u32 regval;
+
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_RQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_RQOMR_FEP_POS,
+					   MTL_Q_RQOMR_FEP_LEN,
+					   1);
+		GMAC_IOWRITE(pdata, MTL_Q_RQOMR(i), regval);
+	}
+}
+
+static void gmac_config_rx_fup_enable(struct gmac_pdata *pdata)
+{
+	unsigned int i;
+	u32 regval;
+
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_RQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_RQOMR_FUP_POS,
+					   MTL_Q_RQOMR_FUP_LEN,
+					   1);
+		GMAC_IOWRITE(pdata, MTL_Q_RQOMR(i), regval);
+	}
+}
+
+static int gmac_config_tx_coalesce(struct gmac_pdata *pdata)
+{
+	return 0;
+}
+
+static void gmac_config_rx_buffer_size(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		regval = GMAC_IOREAD(pdata, DMA_CH_RCR(i));
+		/* for normal case, Rx Buffer size = 2048bytes */
+		regval = GMAC_SET_REG_BITS(regval,
+					   DMA_CH_RCR_RBSZ_POS,
+					   DMA_CH_RCR_RBSZ_LEN,
+					   pdata->rx_buf_size);
+		GMAC_IOWRITE(pdata, DMA_CH_RCR(i), regval);
+	}
+}
+
+static void gmac_config_tso_mode(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		if (pdata->hw_feat.tso) {
+			regval = GMAC_IOREAD(pdata, DMA_CH_TCR(i));
+			regval = GMAC_SET_REG_BITS(regval,
+						   DMA_CH_TCR_TSE_POS,
+						   DMA_CH_TCR_TSE_LEN,
+						   1);
+			GMAC_IOWRITE(pdata, DMA_CH_TCR(i), regval);
+		}
+	}
+}
+
+static void gmac_config_sph_mode(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		/* not support sph feature */
+		regval = GMAC_IOREAD(pdata, DMA_CH_CR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   DMA_CH_CR_SPH_POS,
+					   DMA_CH_CR_SPH_LEN,
+					   0);
+		GMAC_IOWRITE(pdata, DMA_CH_CR(i), regval);
+	}
+}
+
+static unsigned int gmac_usec_to_riwt(struct gmac_pdata *pdata,
+				      unsigned int usec)
+{
+	unsigned long rate;
+	unsigned int ret;
+
+	rate = pdata->sysclk_rate;
+
+	/* Convert the input usec value to the watchdog timer value. Each
+	 * watchdog timer value is equivalent to 256 clock cycles.
+	 * Calculate the required value as:
+	 *   ( usec * ( system_clock_mhz / 10^6 ) / 256
+	 */
+	ret = (usec * (rate / 1000000)) / 256;
+
+	return ret;
+}
+
+static unsigned int gmac_riwt_to_usec(struct gmac_pdata *pdata,
+				      unsigned int riwt)
+{
+	unsigned long rate;
+	unsigned int ret;
+
+	rate = pdata->sysclk_rate;
+
+	/* Convert the input watchdog timer value to the usec value. Each
+	 * watchdog timer value is equivalent to 256 clock cycles.
+	 * Calculate the required value as:
+	 *   ( riwt * 256 ) / ( system_clock_mhz / 10^6 )
+	 */
+	ret = (riwt * 256) / (rate / 1000000);
+
+	return ret;
+}
+
+static int gmac_config_rx_threshold(struct gmac_pdata *pdata,
+				    unsigned int val)
+{
+	unsigned int i;
+	u32 regval;
+
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_RQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_RQOMR_RTC_POS,
+					   MTL_Q_RQOMR_RTC_LEN,
+					   val);
+		GMAC_IOWRITE(pdata, MTL_Q_RQOMR(i), regval);
+	}
+
+	return 0;
+}
+
+static void gmac_config_mtl_mode(struct gmac_pdata *pdata)
+{
+	unsigned int i;
+	u32 regval;
+
+	/* Set Tx to weighted round robin scheduling algorithm */
+	regval = GMAC_IOREAD(pdata, MTL_OMR);
+	regval = GMAC_SET_REG_BITS(regval,
+				   MTL_OMR_TSA_POS,
+				   MTL_OMR_TSA_LEN,
+				   MTL_TSA_WRR);
+	GMAC_IOWRITE(pdata, MTL_OMR, regval);
+
+	for (i = 0; i < pdata->hw_feat.tx_ch_cnt; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_TQWR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_TQWR_QW_POS,
+					   MTL_Q_TQWR_QW_LEN,
+					   (0x10 + i));
+		GMAC_IOWRITE(pdata, MTL_Q_TQWR(i), regval);
+	}
+
+	/* Set Rx to strict priority algorithm */
+	regval = GMAC_IOREAD(pdata, MTL_OMR);
+	regval = GMAC_SET_REG_BITS(regval,
+				   MTL_OMR_RAA_POS,
+				   MTL_OMR_RAA_LEN,
+				   MTL_RAA_SP);
+	GMAC_IOWRITE(pdata, MTL_OMR, regval);
+}
+
+static void gmac_config_queue_mapping(struct gmac_pdata *pdata)
+{
+	u32 value;
+
+	/* Configure one to one, MTL Rx queue to DMA Rx channel mapping
+	 *	ie Q0 <--> CH0, Q1 <--> CH1 ... Q7 <--> CH7
+	 */
+	value = (MTL_RQDCM0R_Q0MDMACH | MTL_RQDCM0R_Q1MDMACH |
+		MTL_RQDCM0R_Q2MDMACH | MTL_RQDCM0R_Q3MDMACH);
+	GMAC_IOWRITE(pdata, MTL_RQDCM0R, value);
+
+	value = (MTL_RQDCM1R_Q4MDMACH | MTL_RQDCM1R_Q5MDMACH |
+		MTL_RQDCM1R_Q5MDMACH | MTL_RQDCM1R_Q6MDMACH);
+	GMAC_IOWRITE(pdata, MTL_RQDCM1R, value);
+}
+
+static unsigned int gmac_calculate_per_queue_fifo(unsigned int fifo_size,
+						  unsigned int queue_count)
+{
+	unsigned int q_fifo_size;
+	unsigned int p_fifo;
+
+	/* Calculate the configured fifo size */
+	q_fifo_size = 1 << (fifo_size + 7);
+
+	/* The configured value may not be the actual amount of fifo RAM */
+	q_fifo_size = min_t(unsigned int, GMAC_MAX_FIFO, q_fifo_size);
+
+	q_fifo_size = q_fifo_size / queue_count;
+
+	/* Each increment in the queue fifo size represents 256 bytes of
+	 * fifo, with 0 representing 256 bytes. Distribute the fifo equally
+	 * between the queues.
+	 */
+	p_fifo = fls(q_fifo_size / 256) - 1;
+
+	p_fifo = (1 << p_fifo);
+
+	p_fifo--;
+
+	return p_fifo;
+}
+
+static void gmac_config_tx_fifo_size(struct gmac_pdata *pdata)
+{
+	unsigned int fifo_size;
+	unsigned int i;
+	u32 regval;
+
+	fifo_size = gmac_calculate_per_queue_fifo(pdata->hw_feat.tx_fifo_size,
+						  pdata->tx_q_count);
+
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_TQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_TQOMR_TQS_POS,
+					   MTL_Q_TQOMR_TQS_LEN,
+					   fifo_size);
+		GMAC_IOWRITE(pdata, MTL_Q_TQOMR(i), regval);
+	}
+
+	netif_info(pdata, drv, pdata->netdev,
+		   "%d Tx hardware queues, %d byte fifo per queue\n",
+		   pdata->tx_q_count, ((fifo_size + 1) * 256));
+}
+
+static void gmac_config_rx_fifo_size(struct gmac_pdata *pdata)
+{
+	unsigned int fifo_size;
+	unsigned int i;
+	u32 regval;
+
+	fifo_size = gmac_calculate_per_queue_fifo(pdata->hw_feat.rx_fifo_size,
+						  pdata->rx_q_count);
+
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_RQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_RQOMR_RQS_POS,
+					   MTL_Q_RQOMR_RQS_LEN,
+					   fifo_size);
+		GMAC_IOWRITE(pdata, MTL_Q_RQOMR(i), regval);
+	}
+
+	netif_info(pdata, drv, pdata->netdev,
+		   "%d Rx hardware queues, %d byte fifo per queue\n",
+		   pdata->rx_q_count, ((fifo_size + 1) * 256));
+}
+
+static void gmac_config_flow_control_threshold(struct gmac_pdata *pdata)
+{
+	unsigned int i;
+	u32 regval;
+
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_RQOMR(i));
+		/* Activate flow control when less than 1.5k left in fifo */
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_RQOMR_RFA_POS,
+					   MTL_Q_RQOMR_RFA_LEN,
+					   1);
+		/* De-activate flow control when more than 2.5k left in fifo */
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_RQOMR_RFD_POS,
+					   MTL_Q_RQOMR_RFD_LEN, 3);
+		GMAC_IOWRITE(pdata, MTL_Q_RQOMR(i), regval);
+	}
+}
+
+static int gmac_config_tx_threshold(struct gmac_pdata *pdata,
+				    unsigned int val)
+{
+	unsigned int i;
+	u32 regval;
+
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_TQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_TQOMR_TTC_POS,
+					   MTL_Q_TQOMR_TTC_LEN,
+					   val);
+		GMAC_IOWRITE(pdata, MTL_Q_TQOMR(i), regval);
+	}
+
+	return 0;
+}
+
+static int gmac_config_rsf_mode(struct gmac_pdata *pdata,
+				unsigned int val)
+{
+	unsigned int i;
+	u32 regval;
+
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_RQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_RQOMR_RSF_POS,
+					   MTL_Q_RQOMR_RSF_LEN, val);
+		GMAC_IOWRITE(pdata, MTL_Q_RQOMR(i), regval);
+	}
+
+	return 0;
+}
+
+static int gmac_config_tsf_mode(struct gmac_pdata *pdata,
+				unsigned int val)
+{
+	unsigned int i;
+	u32 regval;
+
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_TQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_Q_TQOMR_TSF_POS,
+					   MTL_Q_TQOMR_TSF_LEN,
+					   val);
+		GMAC_IOWRITE(pdata, MTL_Q_TQOMR(i), regval);
+	}
+
+	return 0;
+}
+
+static int gmac_config_osp_mode(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		regval = GMAC_IOREAD(pdata, DMA_CH_TCR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   DMA_CH_TCR_OSP_POS,
+					   DMA_CH_TCR_OSP_LEN,
+					   pdata->tx_osp_mode);
+		GMAC_IOWRITE(pdata, DMA_CH_TCR(i), regval);
+	}
+
+	return 0;
+}
+
+static int gmac_config_pblx8(struct gmac_pdata *pdata)
+{
+	unsigned int i;
+	u32 regval;
+
+	for (i = 0; i < pdata->channel_count; i++) {
+		regval = GMAC_IOREAD(pdata, DMA_CH_CR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   DMA_CH_CR_PBLX8_POS,
+					   DMA_CH_CR_PBLX8_LEN,
+					   pdata->pblx8);
+		GMAC_IOWRITE(pdata, DMA_CH_CR(i), regval);
+	}
+
+	return 0;
+}
+
+static int gmac_config_tx_pbl_val(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		regval = GMAC_IOREAD(pdata, DMA_CH_TCR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   DMA_CH_TCR_PBL_POS,
+					   DMA_CH_TCR_PBL_LEN,
+					   pdata->tx_pbl);
+		GMAC_IOWRITE(pdata, DMA_CH_TCR(i), regval);
+	}
+
+	return 0;
+}
+
+static int gmac_config_rx_pbl_val(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+	u32 regval;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		regval = GMAC_IOREAD(pdata, DMA_CH_RCR(i));
+		regval = GMAC_SET_REG_BITS(regval,
+					   DMA_CH_RCR_PBL_POS,
+					   DMA_CH_RCR_PBL_LEN,
+					   pdata->rx_pbl);
+		GMAC_IOWRITE(pdata, DMA_CH_RCR(i), regval);
+	}
+
+	return 0;
+}
+
+static void gmac_tx_mmc_int(struct gmac_pdata *pdata)
+{
+	unsigned int mmc_isr = GMAC_IOREAD(pdata, MMC_TISR);
+	struct gmac_stats *stats = &pdata->stats;
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXOCTETCOUNT_GB_POS,
+			      MMC_TISR_TXOCTETCOUNT_GB_LEN))
+		stats->txoctetcount_gb +=
+			GMAC_IOREAD(pdata, MMC_TXOCTETCOUNT_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXFRAMECOUNT_GB_POS,
+			      MMC_TISR_TXFRAMECOUNT_GB_LEN))
+		stats->txframecount_gb +=
+			GMAC_IOREAD(pdata, MMC_TXPACKETCOUNT_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXBROADCASTFRAMES_G_POS,
+			      MMC_TISR_TXBROADCASTFRAMES_G_LEN))
+		stats->txbroadcastframes_g +=
+			GMAC_IOREAD(pdata, MMC_TXBROADCASTFRAMES_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXMULTICASTFRAMES_G_POS,
+			      MMC_TISR_TXMULTICASTFRAMES_G_LEN))
+		stats->txmulticastframes_g +=
+			GMAC_IOREAD(pdata, MMC_TXMULTICASTFRAMES_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TX64OCTETS_GB_POS,
+			      MMC_TISR_TX64OCTETS_GB_LEN))
+		stats->tx64octets_gb +=
+			GMAC_IOREAD(pdata, MMC_TX64OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TX65TO127OCTETS_GB_POS,
+			      MMC_TISR_TX65TO127OCTETS_GB_LEN))
+		stats->tx65to127octets_gb +=
+			GMAC_IOREAD(pdata, MMC_TX65TO127OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TX128TO255OCTETS_GB_POS,
+			      MMC_TISR_TX128TO255OCTETS_GB_LEN))
+		stats->tx128to255octets_gb +=
+			GMAC_IOREAD(pdata, MMC_TX128TO255OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TX256TO511OCTETS_GB_POS,
+			      MMC_TISR_TX256TO511OCTETS_GB_LEN))
+		stats->tx256to511octets_gb +=
+			GMAC_IOREAD(pdata, MMC_TX256TO511OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TX512TO1023OCTETS_GB_POS,
+			      MMC_TISR_TX512TO1023OCTETS_GB_LEN))
+		stats->tx512to1023octets_gb +=
+			GMAC_IOREAD(pdata, MMC_TX512TO1023OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TX1024TOMAXOCTETS_GB_POS,
+			      MMC_TISR_TX1024TOMAXOCTETS_GB_LEN))
+		stats->tx1024tomaxoctets_gb +=
+			GMAC_IOREAD(pdata, MMC_TX1024TOMAXOCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXUNICASTFRAMES_GB_POS,
+			      MMC_TISR_TXUNICASTFRAMES_GB_LEN))
+		stats->txunicastframes_gb +=
+			GMAC_IOREAD(pdata, MMC_TXUNICASTFRAMES_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXMULTICASTFRAMES_GB_POS,
+			      MMC_TISR_TXMULTICASTFRAMES_GB_LEN))
+		stats->txmulticastframes_gb +=
+			GMAC_IOREAD(pdata, MMC_TXMULTICASTFRAMES_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXBROADCASTFRAMES_GB_POS,
+			      MMC_TISR_TXBROADCASTFRAMES_GB_LEN))
+		stats->txbroadcastframes_g +=
+			GMAC_IOREAD(pdata, MMC_TXBROADCASTFRAMES_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXUNDERFLOWERROR_POS,
+			      MMC_TISR_TXUNDERFLOWERROR_LEN))
+		stats->txunderflowerror +=
+			GMAC_IOREAD(pdata, MMC_TXUNDERFLOWERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXSINGLECOL_G_POS,
+			      MMC_TISR_TXSINGLECOL_G_POS))
+		stats->txsinglecol_g +=
+			GMAC_IOREAD(pdata, MMC_TXSINGLECOL_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXMULTICOL_G_POS,
+			      MMC_TISR_TXMULTICOL_G_LEN))
+		stats->txmulticol_g +=
+			GMAC_IOREAD(pdata, MMC_TXMULTICOL_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXDEFERRED_POS,
+			      MMC_TISR_TXDEFERRED_LEN))
+		stats->txdeferred +=
+			GMAC_IOREAD(pdata, MMC_TXDEFERRED);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXLATECOL_POS,
+			      MMC_TISR_TXLATECOL_LEN))
+		stats->txlatecol +=
+			GMAC_IOREAD(pdata, MMC_TXLATECOL);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXEXESSCOL_POS,
+			      MMC_TISR_TXEXESSCOL_LEN))
+		stats->txexesscol +=
+			GMAC_IOREAD(pdata, MMC_TXEXESSCOL);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXCARRIERERROR_POS,
+			      MMC_TISR_TXCARRIERERROR_LEN))
+		stats->txcarriererror +=
+			GMAC_IOREAD(pdata, MMC_TXCARRIERERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXOCTETCOUNT_G_POS,
+			      MMC_TISR_TXOCTETCOUNT_G_LEN))
+		stats->txoctetcount_g +=
+			GMAC_IOREAD(pdata, MMC_TXOCTETCOUNT_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXFRAMECOUNT_G_POS,
+			      MMC_TISR_TXFRAMECOUNT_G_LEN))
+		stats->txframecount_g +=
+			GMAC_IOREAD(pdata, MMC_TXPACKETSCOUNT_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXEXCESSDEF_POS,
+			      MMC_TISR_TXEXCESSDEF_LEN))
+		stats->txexcessdef +=
+			GMAC_IOREAD(pdata, MMC_TXEXCESSDEF);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXPAUSEFRAMES_POS,
+			      MMC_TISR_TXPAUSEFRAMES_LEN))
+		stats->txpauseframes +=
+			GMAC_IOREAD(pdata, MMC_TXPAUSEFRAMES);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXVLANFRAMES_G_POS,
+			      MMC_TISR_TXVLANFRAMES_G_LEN))
+		stats->txvlanframes_g +=
+			GMAC_IOREAD(pdata, MMC_TXVLANFRAMES_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXOVERSIZE_G_POS,
+			      MMC_TISR_TXOVERSIZE_G_LEN))
+		stats->txosizeframe_g +=
+			GMAC_IOREAD(pdata, MMC_TXOVERSIZE_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXLPIUSEC_POS,
+			      MMC_TISR_TXLPIUSEC_LEN))
+		stats->txlpiusec +=
+			GMAC_IOREAD(pdata, MMC_TXLPIUSEC);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_TISR_TXLPITRAN_POS,
+			      MMC_TISR_TXLPITRAN_LEN))
+		stats->txlpitran +=
+			GMAC_IOREAD(pdata, MMC_TXLPITRAN);
+}
+
+static void gmac_rx_mmc_int(struct gmac_pdata *pdata)
+{
+	unsigned int mmc_isr = GMAC_IOREAD(pdata, MMC_RISR);
+	struct gmac_stats *stats = &pdata->stats;
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXFRAMECOUNT_GB_POS,
+			      MMC_RISR_RXFRAMECOUNT_GB_LEN))
+		stats->rxframecount_gb +=
+			GMAC_IOREAD(pdata, MMC_RXPACKETCOUNT_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXOCTETCOUNT_GB_POS,
+			      MMC_RISR_RXOCTETCOUNT_GB_LEN))
+		stats->rxoctetcount_gb +=
+			GMAC_IOREAD(pdata, MMC_RXOCTETCOUNT_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXOCTETCOUNT_G_POS,
+			      MMC_RISR_RXOCTETCOUNT_G_LEN))
+		stats->rxoctetcount_g +=
+			GMAC_IOREAD(pdata, MMC_RXOCTETCOUNT_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXBROADCASTFRAMES_G_POS,
+			      MMC_RISR_RXBROADCASTFRAMES_G_LEN))
+		stats->rxbroadcastframes_g +=
+			GMAC_IOREAD(pdata, MMC_RXBROADCASTFRAMES_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXMULTICASTFRAMES_G_POS,
+			      MMC_RISR_RXMULTICASTFRAMES_G_LEN))
+		stats->rxmulticastframes_g +=
+			GMAC_IOREAD(pdata, MMC_RXMULTICASTFRAMES_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXCRCERROR_POS,
+			      MMC_RISR_RXCRCERROR_LEN))
+		stats->rxcrcerror +=
+			GMAC_IOREAD(pdata, MMC_RXCRCERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXALIGNMENTERROR_POS,
+			      MMC_RISR_RXALIGNMENTERROR_LEN))
+		stats->rxalignerror +=
+			GMAC_IOREAD(pdata, MMC_RXALIGNMENTERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXRUNTERROR_POS,
+			      MMC_RISR_RXRUNTERROR_LEN))
+		stats->rxrunterror +=
+			GMAC_IOREAD(pdata, MMC_RXRUNTERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXJABBERERROR_POS,
+			      MMC_RISR_RXJABBERERROR_LEN))
+		stats->rxjabbererror +=
+			GMAC_IOREAD(pdata, MMC_RXJABBERERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXUNDERSIZE_G_POS,
+			      MMC_RISR_RXUNDERSIZE_G_LEN))
+		stats->rxundersize_g +=
+			GMAC_IOREAD(pdata, MMC_RXUNDERSIZE_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXOVERSIZE_G_POS,
+			      MMC_RISR_RXOVERSIZE_G_LEN))
+		stats->rxoversize_g +=
+			GMAC_IOREAD(pdata, MMC_RXOVERSIZE_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RX64OCTETS_GB_POS,
+			      MMC_RISR_RX64OCTETS_GB_LEN))
+		stats->rx64octets_gb +=
+			GMAC_IOREAD(pdata, MMC_RX64OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RX65TO127OCTETS_GB_POS,
+			      MMC_RISR_RX65TO127OCTETS_GB_LEN))
+		stats->rx65to127octets_gb +=
+			GMAC_IOREAD(pdata, MMC_RX65TO127OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RX128TO255OCTETS_GB_POS,
+			      MMC_RISR_RX128TO255OCTETS_GB_LEN))
+		stats->rx128to255octets_gb +=
+			GMAC_IOREAD(pdata, MMC_RX128TO255OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RX256TO511OCTETS_GB_POS,
+			      MMC_RISR_RX256TO511OCTETS_GB_LEN))
+		stats->rx256to511octets_gb +=
+			GMAC_IOREAD(pdata, MMC_RX256TO511OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RX512TO1023OCTETS_GB_POS,
+			      MMC_RISR_RX512TO1023OCTETS_GB_LEN))
+		stats->rx512to1023octets_gb +=
+			GMAC_IOREAD(pdata, MMC_RX512TO1023OCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RX1024TOMAXOCTETS_GB_POS,
+			      MMC_RISR_RX1024TOMAXOCTETS_GB_LEN))
+		stats->rx1024tomaxoctets_gb +=
+			GMAC_IOREAD(pdata, MMC_RX1024TOMAXOCTETS_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXUNICASTFRAMES_G_POS,
+			      MMC_RISR_RXUNICASTFRAMES_G_LEN))
+		stats->rxunicastframes_g +=
+			GMAC_IOREAD(pdata, MMC_RXUNICASTFRAMES_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXLENGTHERROR_POS,
+			      MMC_RISR_RXLENGTHERROR_LEN))
+		stats->rxlengtherror +=
+			GMAC_IOREAD(pdata, MMC_RXLENGTHERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXOUTOFRANGETYPE_POS,
+			      MMC_RISR_RXOUTOFRANGETYPE_LEN))
+		stats->rxoutofrangetype +=
+			GMAC_IOREAD(pdata, MMC_RXOUTOFRANGETYPE);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXPAUSEFRAMES_POS,
+			      MMC_RISR_RXPAUSEFRAMES_LEN))
+		stats->rxpauseframes +=
+			GMAC_IOREAD(pdata, MMC_RXPAUSEFRAMES);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXFIFOOVERFLOW_POS,
+			      MMC_RISR_RXFIFOOVERFLOW_LEN))
+		stats->rxfifooverflow +=
+			GMAC_IOREAD(pdata, MMC_RXFIFOOVERFLOW);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXVLANFRAMES_GB_POS,
+			      MMC_RISR_RXVLANFRAMES_GB_LEN))
+		stats->rxvlanframes_gb +=
+			GMAC_IOREAD(pdata, MMC_RXVLANFRAMES_GB);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXWATCHDOGERROR_POS,
+			      MMC_RISR_RXWATCHDOGERROR_LEN))
+		stats->rxwatchdogerror +=
+			GMAC_IOREAD(pdata, MMC_RXWATCHDOGERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXRCVERROR_POS,
+			      MMC_RISR_RXRCVERROR_LEN))
+		stats->rxreceiveerror +=
+			GMAC_IOREAD(pdata, MMC_RXRCVERROR);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXCTRLFRAMES_POS,
+			      MMC_RISR_RXCTRLFRAMES_LEN))
+		stats->rxctrlframes_g +=
+			GMAC_IOREAD(pdata, MMC_RXCTRLFRAMES_G);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXLPIUSEC_POS,
+			      MMC_RISR_RXLPIUSEC_LEN))
+		stats->rxlpiusec +=
+			GMAC_IOREAD(pdata, MMC_RXLPIUSEC);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_RISR_RXLPITRAN_POS,
+			      MMC_RISR_RXLPITRAN_LEN))
+		stats->rxlpitran += GMAC_IOREAD(pdata, MMC_RXLPITRAN);
+}
+
+static void gmac_rxipc_mmc_int(struct gmac_pdata *pdata)
+{
+	unsigned int mmc_isr = GMAC_IOREAD(pdata, MMC_IPCSR);
+	struct gmac_stats *stats = &pdata->stats;
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4GDPKTS_POS,
+			      MMC_IPCSR_RXIPV4GDPKTS_LEN))
+		stats->rxipv4_g +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4GDPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4HDRERRPKTS_POS,
+			      MMC_IPCSR_RXIPV4HDRERRPKTS_LEN))
+		stats->rxipv4hderr +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4HDRERRPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4NOPAYPKTS_POS,
+			      MMC_IPCSR_RXIPV4NOPAYPKTS_LEN))
+		stats->rxipv4nopay +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4NOPAYPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4FRAGPKTS_POS,
+			      MMC_IPCSR_RXIPV4FRAGPKTS_LEN))
+		stats->rxipv4frag +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4FRAGPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4UBSBLPKTS_POS,
+			      MMC_IPCSR_RXIPV4UBSBLPKTS_LEN))
+		stats->rxipv4udsbl +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4UBSBLPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV6GDPKTS_POS,
+			      MMC_IPCSR_RXIPV6GDPKTS_LEN))
+		stats->rxipv6_g +=
+			GMAC_IOREAD(pdata, MMC_RXIPV6GDPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV6HDRERRPKTS_POS,
+			      MMC_IPCSR_RXIPV6HDRERRPKTS_LEN))
+		stats->rxipv6hderr +=
+			GMAC_IOREAD(pdata, MMC_RXIPV6HDRERRPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV6NOPAYPKTS_POS,
+			      MMC_IPCSR_RXIPV6NOPAYPKTS_LEN))
+		stats->rxipv6nopay +=
+			GMAC_IOREAD(pdata, MMC_RXIPV6NOPAYPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXUDPGDPKTS_POS,
+			      MMC_IPCSR_RXUDPGDPKTS_LEN))
+		stats->rxudp_g +=
+			GMAC_IOREAD(pdata, MMC_RXUDPGDPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXUDPERRPKTS_POS,
+			      MMC_IPCSR_RXUDPERRPKTS_LEN))
+		stats->rxudperr +=
+			GMAC_IOREAD(pdata, MMC_RXUDPERRPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXTCPGDPKTS_POS,
+			      MMC_IPCSR_RXTCPGDPKTS_LEN))
+		stats->rxtcp_g +=
+			GMAC_IOREAD(pdata, MMC_RXTCPGDPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXTCPERRPKTS_POS,
+			      MMC_IPCSR_RXTCPERRPKTS_LEN))
+		stats->rxtcperr +=
+			GMAC_IOREAD(pdata, MMC_RXTCPERRPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXICMPGDPKTS_POS,
+			      MMC_IPCSR_RXICMPGDPKTS_LEN))
+		stats->rxicmp_g +=
+			GMAC_IOREAD(pdata, MMC_RXICMPGDPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXICMPERRPKTS_POS,
+			      MMC_IPCSR_RXICMPERRPKTS_LEN))
+		stats->rxicmperr +=
+			GMAC_IOREAD(pdata, MMC_RXICMPERRPKTS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4GDOCTETS_POS,
+			      MMC_IPCSR_RXIPV4GDOCTETS_LEN))
+		stats->rxipv4octets_g +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4GDOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4GDOCTETS_POS,
+			      MMC_IPCSR_RXIPV4GDOCTETS_LEN))
+		stats->rxipv4hderroctets +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4HDRERROCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4NOPAYOCTETS_POS,
+			      MMC_IPCSR_RXIPV4NOPAYOCTETS_LEN))
+		stats->rxipv4nopayoctets +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4NOPAYOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4FRAGOCTETS_POS,
+			      MMC_IPCSR_RXIPV4FRAGOCTETS_LEN))
+		stats->rxipv4fragoctets +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4FRAGOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV4UDSBLOCTETS_POS,
+			      MMC_IPCSR_RXIPV4UDSBLOCTETS_LEN))
+		stats->rxipv4udsbloctets +=
+			GMAC_IOREAD(pdata, MMC_RXIPV4UDSBLOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV6GDOCTETS_POS,
+			      MMC_IPCSR_RXIPV6GDOCTETS_LEN))
+		stats->rxipv6octets_g +=
+			GMAC_IOREAD(pdata, MMC_RXIPV6GDOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV6HDRERROCTETS_POS,
+			      MMC_IPCSR_RXIPV6HDRERROCTETS_LEN))
+		stats->rxipv6hderroctets +=
+			GMAC_IOREAD(pdata, MMC_RXIPV6HDRERROCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXIPV6NOPAYOCTETS_POS,
+			      MMC_IPCSR_RXIPV6NOPAYOCTETS_LEN))
+		stats->rxipv6nopayoctets +=
+			GMAC_IOREAD(pdata, MMC_RXIPV6NOPAYOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXUDPGDOCTETS_POS,
+			      MMC_IPCSR_RXUDPGDOCTETS_LEN))
+		stats->rxudpoctets_g +=
+			GMAC_IOREAD(pdata, MMC_RXUDPGDOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXUDPERROCTETS_POS,
+			      MMC_IPCSR_RXUDPERROCTETS_LEN))
+		stats->rxudperroctets +=
+			GMAC_IOREAD(pdata, MMC_RXUDPERROCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXTCPGDOCTETS_POS,
+			      MMC_IPCSR_RXTCPGDOCTETS_LEN))
+		stats->rxtcpoctets_g +=
+			GMAC_IOREAD(pdata, MMC_RXTCPGDOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXTCPERROCTETS_POS,
+			      MMC_IPCSR_RXTCPERROCTETS_LEN))
+		stats->rxtcperroctets +=
+			GMAC_IOREAD(pdata, MMC_RXTCPERROCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXICMPGDOCTETS_POS,
+			      MMC_IPCSR_RXICMPGDOCTETS_LEN))
+		stats->rxicmpoctets_g +=
+			GMAC_IOREAD(pdata, MMC_RXICMPGDOCTETS);
+
+	if (GMAC_GET_REG_BITS(mmc_isr,
+			      MMC_IPCSR_RXICMPERROCTETS_POS,
+			      MMC_IPCSR_RXICMPERROCTETS_LEN))
+		stats->rxicmperroctets +=
+			GMAC_IOREAD(pdata, MMC_RXICMPERROCTETS);
+}
+
+static void gmac_read_mmc_stats(struct gmac_pdata *pdata)
+{
+	struct gmac_stats *stats = &pdata->stats;
+	u32 regval;
+
+	/* Freeze counters */
+	regval = GMAC_IOREAD(pdata, MMC_CR);
+	regval = GMAC_SET_REG_BITS(regval,
+				   MMC_CR_MCF_POS,
+				   MMC_CR_MCF_LEN,
+				   1);
+	GMAC_IOWRITE(pdata, MMC_CR, regval);
+
+	/* MMC TX counter registers */
+	stats->txoctetcount_gb +=
+		GMAC_IOREAD(pdata, MMC_TXOCTETCOUNT_GB);
+	stats->txframecount_gb +=
+		GMAC_IOREAD(pdata, MMC_TXPACKETCOUNT_GB);
+	stats->txbroadcastframes_g +=
+		GMAC_IOREAD(pdata, MMC_TXBROADCASTFRAMES_G);
+	stats->txmulticastframes_g +=
+		GMAC_IOREAD(pdata, MMC_TXMULTICASTFRAMES_G);
+	stats->tx64octets_gb +=
+		GMAC_IOREAD(pdata, MMC_TX64OCTETS_GB);
+	stats->tx65to127octets_gb +=
+		GMAC_IOREAD(pdata, MMC_TX65TO127OCTETS_GB);
+	stats->tx128to255octets_gb +=
+		GMAC_IOREAD(pdata, MMC_TX128TO255OCTETS_GB);
+	stats->tx256to511octets_gb +=
+		GMAC_IOREAD(pdata, MMC_TX256TO511OCTETS_GB);
+	stats->tx512to1023octets_gb +=
+		GMAC_IOREAD(pdata, MMC_TX512TO1023OCTETS_GB);
+	stats->tx1024tomaxoctets_gb +=
+		GMAC_IOREAD(pdata, MMC_TX1024TOMAXOCTETS_GB);
+	stats->txunicastframes_gb +=
+		GMAC_IOREAD(pdata, MMC_TXUNICASTFRAMES_GB);
+	stats->txmulticastframes_gb +=
+		GMAC_IOREAD(pdata, MMC_TXMULTICASTFRAMES_GB);
+	stats->txbroadcastframes_gb +=
+		GMAC_IOREAD(pdata, MMC_TXBROADCASTFRAMES_GB);
+	stats->txunderflowerror +=
+		GMAC_IOREAD(pdata, MMC_TXUNDERFLOWERROR);
+	stats->txsinglecol_g +=
+		GMAC_IOREAD(pdata, MMC_TXSINGLECOL_G);
+	stats->txmulticol_g +=
+		GMAC_IOREAD(pdata, MMC_TXMULTICOL_G);
+	stats->txdeferred +=
+		GMAC_IOREAD(pdata, MMC_TXDEFERRED);
+	stats->txlatecol +=
+		GMAC_IOREAD(pdata, MMC_TXLATECOL);
+	stats->txexesscol +=
+		GMAC_IOREAD(pdata, MMC_TXEXESSCOL);
+	stats->txcarriererror +=
+		GMAC_IOREAD(pdata, MMC_TXCARRIERERROR);
+	stats->txoctetcount_g +=
+		GMAC_IOREAD(pdata, MMC_TXOCTETCOUNT_G);
+	stats->txframecount_g +=
+		GMAC_IOREAD(pdata, MMC_TXPACKETSCOUNT_G);
+	stats->txexcessdef +=
+		GMAC_IOREAD(pdata, MMC_TXEXCESSDEF);
+	stats->txpauseframes +=
+		GMAC_IOREAD(pdata, MMC_TXPAUSEFRAMES);
+	stats->txvlanframes_g +=
+		GMAC_IOREAD(pdata, MMC_TXVLANFRAMES_G);
+	stats->txosizeframe_g +=
+		GMAC_IOREAD(pdata, MMC_TXOVERSIZE_G);
+	stats->txlpiusec +=
+		GMAC_IOREAD(pdata, MMC_TXLPIUSEC);
+	stats->txlpitran +=
+		GMAC_IOREAD(pdata, MMC_TXLPITRAN);
+
+	/* MMC RX counter registers */
+	stats->rxframecount_gb +=
+		GMAC_IOREAD(pdata, MMC_RXPACKETCOUNT_GB);
+	stats->rxoctetcount_gb +=
+		GMAC_IOREAD(pdata, MMC_RXOCTETCOUNT_GB);
+	stats->rxoctetcount_g +=
+		GMAC_IOREAD(pdata, MMC_RXOCTETCOUNT_G);
+	stats->rxbroadcastframes_g +=
+		GMAC_IOREAD(pdata, MMC_RXBROADCASTFRAMES_G);
+	stats->rxmulticastframes_g +=
+		GMAC_IOREAD(pdata, MMC_RXMULTICASTFRAMES_G);
+	stats->rxcrcerror +=
+		GMAC_IOREAD(pdata, MMC_RXCRCERROR);
+	stats->rxalignerror +=
+		GMAC_IOREAD(pdata, MMC_RXALIGNMENTERROR);
+	stats->rxrunterror +=
+		GMAC_IOREAD(pdata, MMC_RXRUNTERROR);
+	stats->rxjabbererror +=
+		GMAC_IOREAD(pdata, MMC_RXJABBERERROR);
+	stats->rxundersize_g +=
+		GMAC_IOREAD(pdata, MMC_RXUNDERSIZE_G);
+	stats->rxoversize_g +=
+		GMAC_IOREAD(pdata, MMC_RXOVERSIZE_G);
+	stats->rx64octets_gb +=
+		GMAC_IOREAD(pdata, MMC_RX64OCTETS_GB);
+	stats->rx65to127octets_gb +=
+		GMAC_IOREAD(pdata, MMC_RX65TO127OCTETS_GB);
+	stats->rx128to255octets_gb +=
+		GMAC_IOREAD(pdata, MMC_RX128TO255OCTETS_GB);
+	stats->rx256to511octets_gb +=
+		GMAC_IOREAD(pdata, MMC_RX256TO511OCTETS_GB);
+	stats->rx512to1023octets_gb +=
+		GMAC_IOREAD(pdata, MMC_RX512TO1023OCTETS_GB);
+	stats->rx1024tomaxoctets_gb +=
+		GMAC_IOREAD(pdata, MMC_RX1024TOMAXOCTETS_GB);
+	stats->rxunicastframes_g +=
+		GMAC_IOREAD(pdata, MMC_RXUNICASTFRAMES_G);
+	stats->rxlengtherror +=
+		GMAC_IOREAD(pdata, MMC_RXLENGTHERROR);
+	stats->rxoutofrangetype +=
+		GMAC_IOREAD(pdata, MMC_RXOUTOFRANGETYPE);
+	stats->rxpauseframes +=
+		GMAC_IOREAD(pdata, MMC_RXPAUSEFRAMES);
+	stats->rxfifooverflow +=
+		GMAC_IOREAD(pdata, MMC_RXFIFOOVERFLOW);
+	stats->rxvlanframes_gb +=
+		GMAC_IOREAD(pdata, MMC_RXVLANFRAMES_GB);
+	stats->rxwatchdogerror +=
+		GMAC_IOREAD(pdata, MMC_RXWATCHDOGERROR);
+	stats->rxreceiveerror +=
+		GMAC_IOREAD(pdata, MMC_RXRCVERROR);
+	stats->rxctrlframes_g +=
+		GMAC_IOREAD(pdata, MMC_RXCTRLFRAMES_G);
+	stats->rxlpiusec +=
+		GMAC_IOREAD(pdata, MMC_RXLPIUSEC);
+	stats->rxlpitran +=
+		GMAC_IOREAD(pdata, MMC_RXLPITRAN);
+
+	/* MMC RX IPC counter registers */
+	stats->rxipv4_g +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4GDPKTS);
+	stats->rxipv4hderr +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4HDRERRPKTS);
+	stats->rxipv4nopay +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4NOPAYPKTS);
+	stats->rxipv4frag +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4FRAGPKTS);
+	stats->rxipv4udsbl +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4UBSBLPKTS);
+	stats->rxipv6_g +=
+		GMAC_IOREAD(pdata, MMC_RXIPV6GDPKTS);
+	stats->rxipv6hderr +=
+		GMAC_IOREAD(pdata, MMC_RXIPV6HDRERRPKTS);
+	stats->rxipv6nopay +=
+		GMAC_IOREAD(pdata, MMC_RXIPV6NOPAYPKTS);
+	stats->rxudp_g +=
+		GMAC_IOREAD(pdata, MMC_RXUDPGDPKTS);
+	stats->rxudperr +=
+		GMAC_IOREAD(pdata, MMC_RXUDPERRPKTS);
+	stats->rxtcp_g +=
+		GMAC_IOREAD(pdata, MMC_RXTCPGDPKTS);
+	stats->rxtcperr +=
+		GMAC_IOREAD(pdata, MMC_RXTCPERRPKTS);
+	stats->rxicmp_g +=
+		GMAC_IOREAD(pdata, MMC_RXICMPGDPKTS);
+	stats->rxicmperr +=
+		GMAC_IOREAD(pdata, MMC_RXICMPERRPKTS);
+	stats->rxipv4octets_g +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4GDOCTETS);
+	stats->rxipv4hderroctets +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4HDRERROCTETS);
+	stats->rxipv4nopayoctets +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4NOPAYOCTETS);
+	stats->rxipv4fragoctets +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4FRAGOCTETS);
+	stats->rxipv4udsbloctets +=
+		GMAC_IOREAD(pdata, MMC_RXIPV4UDSBLOCTETS);
+	stats->rxipv6octets_g +=
+		GMAC_IOREAD(pdata, MMC_RXIPV6GDOCTETS);
+	stats->rxipv6hderroctets +=
+		GMAC_IOREAD(pdata, MMC_RXIPV6HDRERROCTETS);
+	stats->rxipv6nopayoctets +=
+		GMAC_IOREAD(pdata, MMC_RXIPV6NOPAYOCTETS);
+	stats->rxudpoctets_g +=
+		GMAC_IOREAD(pdata, MMC_RXUDPGDOCTETS);
+	stats->rxudperroctets +=
+		GMAC_IOREAD(pdata, MMC_RXUDPERROCTETS);
+	stats->rxtcpoctets_g +=
+		GMAC_IOREAD(pdata, MMC_RXTCPGDOCTETS);
+	stats->rxtcperroctets +=
+		GMAC_IOREAD(pdata, MMC_RXTCPERROCTETS);
+	stats->rxicmpoctets_g +=
+		GMAC_IOREAD(pdata, MMC_RXICMPGDOCTETS);
+	stats->rxicmperroctets +=
+		GMAC_IOREAD(pdata, MMC_RXICMPERROCTETS);
+
+	/* Un-freeze counters */
+	regval = GMAC_IOREAD(pdata, MMC_CR);
+	regval = GMAC_SET_REG_BITS(regval, MMC_CR_MCF_POS,
+				   MMC_CR_MCF_LEN, 0);
+	GMAC_IOWRITE(pdata, MMC_CR, regval);
+}
+
+static void gmac_config_mmc(struct gmac_pdata *pdata)
+{
+	unsigned int regval;
+
+	regval = GMAC_IOREAD(pdata, MMC_CR);
+	/* Set counters to reset on read */
+	regval = GMAC_SET_REG_BITS(regval, MMC_CR_ROR_POS,
+				   MMC_CR_ROR_LEN, 1);
+	/* Reset the counters */
+	regval = GMAC_SET_REG_BITS(regval, MMC_CR_CR_POS,
+				   MMC_CR_CR_LEN, 1);
+	GMAC_IOWRITE(pdata, MMC_CR, regval);
+}
+
+static void gmac_enable_dma_interrupts(struct gmac_pdata *pdata)
+{
+	unsigned int dma_ch_isr, dma_ch_ier;
+	struct gmac_channel *channel;
+	unsigned int i;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		/* Clear all the interrupts which are set */
+		dma_ch_isr =  GMAC_IOREAD(pdata, DMA_CH_SR(i));
+		GMAC_IOWRITE(pdata, DMA_CH_SR(i), dma_ch_isr);
+
+		/* Clear all interrupt enable bits */
+		dma_ch_ier = 0;
+
+		/* Enable following interrupts
+		 *   NIE  - Normal Interrupt Summary Enable
+		 *   AIE  - Abnormal Interrupt Summary Enable
+		 *   FBEE - Fatal Bus Error Enable
+		 */
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier,
+					       DMA_CH_IER_NIE_POS,
+					       DMA_CH_IER_NIE_LEN, 1);
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier,
+					       DMA_CH_IER_AIE_POS,
+					       DMA_CH_IER_AIE_LEN, 1);
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier,
+					       DMA_CH_IER_FBEE_POS,
+					       DMA_CH_IER_FBEE_LEN, 1);
+
+		if (channel->tx_ring) {
+			/* Enable the following Tx interrupts
+			 *   TIE  - Transmit Interrupt Enable (unless using
+			 *          per channel interrupts)
+			 */
+			if (!pdata->per_channel_irq)
+				dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier,
+							       DMA_CH_IER_TIE_POS,
+							       DMA_CH_IER_TIE_LEN,
+							       1);
+		}
+		if (channel->rx_ring) {
+			/* Enable following Rx interrupts
+			 *   RBUE - Receive Buffer Unavailable Enable
+			 *   RIE  - Receive Interrupt Enable (unless using
+			 *          per channel interrupts)
+			 */
+			dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier,
+						       DMA_CH_IER_RBUE_POS,
+						       DMA_CH_IER_RBUE_LEN,
+						       1);
+			if (!pdata->per_channel_irq)
+				dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier,
+							       DMA_CH_IER_RIE_POS,
+							       DMA_CH_IER_RIE_LEN,
+							       1);
+		}
+
+		GMAC_IOWRITE(pdata, DMA_CH_IER(i), dma_ch_ier);
+	}
+}
+
+static void gmac_enable_mtl_interrupts(struct gmac_pdata *pdata)
+{
+	unsigned int q_count, i;
+	unsigned int regval;
+
+	q_count = max(pdata->hw_feat.tx_q_cnt, pdata->hw_feat.rx_q_cnt);
+	for (i = 0; i < q_count; i++) {
+		/* No MTL interrupts to be enabled */
+		regval = 0;
+
+		/* Clear all the interrupts which are set */
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_ICR_RXOVFIS_POS,
+					   MTL_ICR_RXOVFIS_LEN,
+					   1);
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_ICR_ABPSIS_POS,
+					   MTL_ICR_ABPSIS_LEN,
+					   1);
+		regval = GMAC_SET_REG_BITS(regval,
+					   MTL_ICR_TXUNFIS_POS,
+					   MTL_ICR_TXUNFIS_LEN,
+					   1);
+		GMAC_IOWRITE(pdata, MTL_Q_ICSR(i), regval);
+	}
+}
+
+static void gmac_enable_mac_interrupts(struct gmac_pdata *pdata)
+{
+	unsigned int mac_ier = 0;
+
+	/* Enable RGMII interrupt */
+	mac_ier = GMAC_SET_REG_BITS(mac_ier, MAC_IER_RGMII_POS,
+				    MAC_IER_RGMII_LEN, 1);
+	GMAC_IOWRITE(pdata, MAC_IER, mac_ier);
+
+	/* Enable all TX interrupts */
+	GMAC_IOWRITE(pdata, MMC_TIER, 0);
+	/* Enable all RX interrupts */
+	GMAC_IOWRITE(pdata, MMC_RIER, 0);
+	/* Enable MMC Rx Interrupts for IPC */
+	GMAC_IOWRITE(pdata, MMC_IPCER, 0);
+}
+
+static int gmac_set_gmii_10_speed(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MCR),
+				   MAC_MCR_SS_POS, MAC_MCR_SS_LEN);
+	if (regval == 0x2)
+		return 0;
+
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_SS_POS,
+				   MAC_MCR_SS_LEN, 0x2);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	return 0;
+}
+
+static int gmac_set_gmii_100_speed(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MCR),
+				   MAC_MCR_SS_POS, MAC_MCR_SS_LEN);
+	if (regval == 0x3)
+		return 0;
+
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_SS_POS,
+				   MAC_MCR_SS_LEN, 0x3);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	return 0;
+}
+
+static int gmac_set_gmii_1000_speed(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MCR),
+				   MAC_MCR_SS_POS, MAC_MCR_SS_LEN);
+	if (regval == 0x0)
+		return 0;
+
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_SS_POS,
+				   MAC_MCR_SS_LEN, 0x0);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	return 0;
+}
+
+static void gmac_config_mac_speed(struct gmac_pdata *pdata)
+{
+	switch (pdata->phy_speed) {
+	case SPEED_10:
+		gmac_set_gmii_10_speed(pdata);
+		break;
+
+	case SPEED_100:
+		gmac_set_gmii_100_speed(pdata);
+		break;
+
+	case SPEED_1000:
+		gmac_set_gmii_1000_speed(pdata);
+		break;
+	}
+}
+
+static int gmac_set_full_duplex(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MCR),
+				   MAC_MCR_DM_POS, MAC_MCR_DM_LEN);
+	if (regval == 0x1)
+		return 0;
+
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_DM_POS,
+				   MAC_MCR_DM_LEN, 0x1);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	return 0;
+}
+
+static int gmac_set_half_duplex(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MCR),
+				   MAC_MCR_DM_POS, MAC_MCR_DM_LEN);
+	if (regval == 0x0)
+		return 0;
+
+	regval = GMAC_SET_REG_BITS(regval, MAC_MCR_DM_POS,
+				   MAC_MCR_DM_LEN, 0x0);
+	GMAC_IOWRITE(pdata, MAC_MCR, regval);
+
+	return 0;
+}
+
+static int gmac_dev_read(struct gmac_channel *channel)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_ring *ring = channel->rx_ring;
+	struct net_device *netdev = pdata->netdev;
+	struct gmac_desc_data *desc_data, *next_data;
+	struct gmac_dma_desc *dma_desc, *next_desc;
+	struct gmac_pkt_info *pkt_info;
+	int ret;
+
+	desc_data = GMAC_GET_DESC_DATA(ring, ring->cur);
+	dma_desc = desc_data->dma_desc;
+	pkt_info = &ring->pkt_info;
+
+	/* Check for data availability */
+	if (GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				 RX_NORMAL_DESC3_OWN_POS,
+				 RX_NORMAL_DESC3_OWN_LEN))
+		return 1;
+
+	/* Make sure descriptor fields are read after reading the OWN bit */
+	dma_rmb();
+
+	if (netif_msg_rx_status(pdata))
+		gmac_dump_rx_desc(pdata, ring, ring->cur);
+
+	/* Normal Descriptor, be sure Context Descriptor bit is off */
+	pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+						 RX_PACKET_ATTRIBUTES_CONTEXT_POS,
+						 RX_PACKET_ATTRIBUTES_CONTEXT_LEN,
+						 0);
+
+	/* Get the pkt_info length */
+	desc_data->trx.bytes = GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+						    RX_NORMAL_DESC3_PL_POS,
+						    RX_NORMAL_DESC3_PL_LEN);
+
+	if (!GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				  RX_NORMAL_DESC3_LD_POS,
+				  RX_NORMAL_DESC3_LD_LEN)) {
+		/* Not all the data has been transferred for this pkt_info */
+		pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+							 RX_PACKET_ATTRIBUTES_INCOMPLETE_POS,
+							 RX_PACKET_ATTRIBUTES_INCOMPLETE_LEN,
+							 1);
+		return 0;
+	}
+
+	/* This is the last of the data for this pkt_info */
+	pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+						 RX_PACKET_ATTRIBUTES_INCOMPLETE_POS,
+						 RX_PACKET_ATTRIBUTES_INCOMPLETE_LEN,
+						 0);
+
+	/* Set checksum done indicator as appropriate */
+	if (netdev->features & NETIF_F_RXCSUM)
+		pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+							 RX_PACKET_ATTRIBUTES_CSUM_DONE_POS,
+							 RX_PACKET_ATTRIBUTES_CSUM_DONE_LEN,
+							 1);
+
+	if (GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				 RX_NORMAL_DESC3_RS1V_POS,
+				 RX_NORMAL_DESC3_RS1V_LEN)) {
+		if (GMAC_GET_REG_BITS_LE(dma_desc->desc1,
+					 RX_NORMAL_DESC1_TSA_POS,
+					 RX_NORMAL_DESC1_TSA_LEN)){
+			ring->cur++;
+
+			next_data = GMAC_GET_DESC_DATA(ring, ring->cur);
+			next_desc = next_data->dma_desc;
+
+			ret = gmac_get_rx_tstamp_status(pdata,
+							next_desc,
+							pkt_info);
+			if (ret == -EBUSY) {
+				ring->cur--;
+				return ret;
+			}
+		}
+
+		if (gmac_is_rx_csum_error(dma_desc))
+			pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+								 RX_PACKET_ATTRIBUTES_CSUM_DONE_POS,
+								 RX_PACKET_ATTRIBUTES_CSUM_DONE_LEN,
+								 0);
+	}
+
+	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX) {
+		if (gmac_is_rx_csum_valid(dma_desc)) {
+			pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+								 RX_PACKET_ATTRIBUTES_VLAN_CTAG_POS,
+								 RX_PACKET_ATTRIBUTES_VLAN_CTAG_LEN,
+								 1);
+			pkt_info->vlan_ctag = GMAC_GET_REG_BITS_LE(dma_desc->desc0,
+								   RX_NORMAL_DESC0_OVT_POS,
+								   RX_NORMAL_DESC0_OVT_LEN);
+			netif_dbg(pdata, rx_status, netdev, "vlan-ctag=%#06x\n",
+				  pkt_info->vlan_ctag);
+		}
+	}
+
+	if (GMAC_GET_REG_BITS_LE(dma_desc->desc3,
+				 RX_NORMAL_DESC3_ES_POS,
+				 RX_NORMAL_DESC3_ES_LEN))
+		pkt_info->errors = GMAC_SET_REG_BITS(pkt_info->errors,
+						     RX_PACKET_ERRORS_FRAME_POS,
+						     RX_PACKET_ERRORS_FRAME_LEN,
+						     1);
+
+	netif_dbg(pdata, rx_status, netdev,
+		  "%s - descriptor=%u (cur=%d)\n", channel->name,
+		  ring->cur & (ring->dma_desc_count - 1), ring->cur);
+
+	return 0;
+}
+
+static int gmac_enable_int(struct gmac_channel *channel,
+			   enum gmac_int int_id)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	unsigned int dma_ch_ier;
+
+	dma_ch_ier = GMAC_IOREAD(pdata, DMA_CH_IER(channel->queue_index));
+
+	switch (int_id) {
+	case GMAC_INT_DMA_CH_SR_TI:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_TIE_POS,
+					       DMA_CH_IER_TIE_LEN, 1);
+		break;
+	case GMAC_INT_DMA_CH_SR_TPS:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_TXSE_POS,
+					       DMA_CH_IER_TXSE_LEN, 1);
+		break;
+	case GMAC_INT_DMA_CH_SR_TBU:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_TBUE_POS,
+					       DMA_CH_IER_TBUE_LEN, 1);
+		break;
+	case GMAC_INT_DMA_CH_SR_RI:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_RIE_POS,
+					       DMA_CH_IER_RIE_LEN, 1);
+		break;
+	case GMAC_INT_DMA_CH_SR_RBU:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_RBUE_POS,
+					       DMA_CH_IER_RBUE_LEN, 1);
+		break;
+	case GMAC_INT_DMA_CH_SR_RPS:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_RSE_POS,
+					       DMA_CH_IER_RSE_LEN, 1);
+		break;
+	case GMAC_INT_DMA_CH_SR_TI_RI:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_TIE_POS,
+					       DMA_CH_IER_TIE_LEN, 1);
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_RIE_POS,
+					       DMA_CH_IER_RIE_LEN, 1);
+		break;
+	case GMAC_INT_DMA_CH_SR_FBE:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_FBEE_POS,
+					       DMA_CH_IER_FBEE_LEN, 1);
+		break;
+	case GMAC_INT_DMA_ALL:
+		dma_ch_ier |= channel->saved_ier;
+		break;
+	default:
+		return -1;
+	}
+
+	GMAC_IOWRITE(pdata, DMA_CH_IER(channel->queue_index), dma_ch_ier);
+
+	return 0;
+}
+
+static int gmac_disable_int(struct gmac_channel *channel,
+			    enum gmac_int int_id)
+{
+	struct gmac_pdata *pdata =  channel->pdata;
+	unsigned int dma_ch_ier;
+
+	dma_ch_ier = GMAC_IOREAD(pdata, DMA_CH_IER(channel->queue_index));
+
+	switch (int_id) {
+	case GMAC_INT_DMA_CH_SR_TI:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_TIE_POS,
+					       DMA_CH_IER_TIE_LEN, 0);
+		break;
+	case GMAC_INT_DMA_CH_SR_TPS:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_TXSE_POS,
+					       DMA_CH_IER_TXSE_LEN, 0);
+		break;
+	case GMAC_INT_DMA_CH_SR_TBU:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_TBUE_POS,
+					       DMA_CH_IER_TBUE_LEN, 0);
+		break;
+	case GMAC_INT_DMA_CH_SR_RI:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_RIE_POS,
+					       DMA_CH_IER_RIE_LEN, 0);
+		break;
+	case GMAC_INT_DMA_CH_SR_RBU:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_RBUE_POS,
+					       DMA_CH_IER_RBUE_LEN, 0);
+		break;
+	case GMAC_INT_DMA_CH_SR_RPS:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_RSE_POS,
+					       DMA_CH_IER_RSE_LEN, 0);
+		break;
+	case GMAC_INT_DMA_CH_SR_TI_RI:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_TIE_POS,
+					       DMA_CH_IER_TIE_LEN, 0);
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_RIE_POS,
+					       DMA_CH_IER_RIE_LEN, 0);
+		break;
+	case GMAC_INT_DMA_CH_SR_FBE:
+		dma_ch_ier = GMAC_SET_REG_BITS(dma_ch_ier, DMA_CH_IER_FBEE_POS,
+					       DMA_CH_IER_FBEE_LEN, 0);
+		break;
+	case GMAC_INT_DMA_ALL:
+		channel->saved_ier = dma_ch_ier & GMAC_DMA_INTERRUPT_MASK;
+		dma_ch_ier &= ~GMAC_DMA_INTERRUPT_MASK;
+		break;
+	default:
+		return -1;
+	}
+
+	GMAC_IOWRITE(pdata, DMA_CH_IER(channel->queue_index), dma_ch_ier);
+
+	return 0;
+}
+
+static int gmac_flush_tx_queues(struct gmac_pdata *pdata)
+{
+	unsigned int i;
+	u32 regval;
+	int limit;
+
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		regval = GMAC_IOREAD(pdata, MTL_Q_TQOMR(i));
+		regval = GMAC_SET_REG_BITS(regval, MTL_Q_TQOMR_FTQ_POS,
+					   MTL_Q_TQOMR_FTQ_LEN, 1);
+		GMAC_IOWRITE(pdata, MTL_Q_TQOMR(i), regval);
+	}
+
+	/* Poll Until Poll Condition */
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		limit = 10;
+		while (limit-- &&
+		       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MTL_Q_TQOMR(i)),
+					 MTL_Q_TQOMR_FTQ_POS,
+					 MTL_Q_TQOMR_FTQ_LEN))
+			mdelay(10);
+
+		if (limit < 0)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void gmac_config_dma_bus(struct gmac_pdata *pdata)
+{
+	u32 regval;
+
+	regval = GMAC_IOREAD(pdata, DMA_SBMR);
+	/* Set maximum read outstanding request limit*/
+	regval = GMAC_SET_REG_BITS(regval,
+				   DMA_SBMR_WR_OSR_LMT_POS,
+				   DMA_SBMR_WR_OSR_LMT_LEN,
+				   DMA_SBMR_OSR_MAX);
+	regval = GMAC_SET_REG_BITS(regval,
+				   DMA_SBMR_RD_OSR_LMT_POS,
+				   DMA_SBMR_RD_OSR_LMT_LEN,
+				   DMA_SBMR_OSR_MAX);
+	/* Set the System Bus mode */
+	regval = GMAC_SET_REG_BITS(regval,
+				   DMA_SBMR_FB_POS,
+				   DMA_SBMR_FB_LEN,
+				   0);
+	regval = GMAC_SET_REG_BITS(regval,
+				   DMA_SBMR_BLEN_16_POS,
+				   DMA_SBMR_BLEN_16_LEN,
+				   1);
+	regval = GMAC_SET_REG_BITS(regval,
+				   DMA_SBMR_BLEN_8_POS,
+				   DMA_SBMR_BLEN_8_LEN,
+				   1);
+	regval = GMAC_SET_REG_BITS(regval,
+				   DMA_SBMR_BLEN_4_POS,
+				   DMA_SBMR_BLEN_4_LEN,
+				   1);
+	GMAC_IOWRITE(pdata, DMA_SBMR, regval);
+}
+
+static int gmac_hw_init(struct gmac_pdata *pdata)
+{
+	struct gmac_desc_ops *desc_ops = &pdata->desc_ops;
+	int ret;
+
+	/* Flush Tx queues */
+	ret = gmac_flush_tx_queues(pdata);
+	if (ret)
+		return ret;
+
+	/* Initialize DMA related features */
+	gmac_config_dma_bus(pdata);
+	gmac_config_osp_mode(pdata);
+	gmac_config_pblx8(pdata);
+	gmac_config_tx_pbl_val(pdata);
+	gmac_config_rx_pbl_val(pdata);
+	gmac_config_rx_coalesce(pdata);
+	gmac_config_tx_coalesce(pdata);
+	gmac_config_rx_buffer_size(pdata);
+	gmac_config_tso_mode(pdata);
+	gmac_config_sph_mode(pdata);
+	desc_ops->tx_desc_init(pdata);
+	desc_ops->rx_desc_init(pdata);
+	gmac_enable_dma_interrupts(pdata);
+
+	/* Initialize MTL related features */
+	gmac_config_mtl_mode(pdata);
+	gmac_config_queue_mapping(pdata);
+	gmac_config_tsf_mode(pdata, pdata->tx_sf_mode);
+	gmac_config_rsf_mode(pdata, pdata->rx_sf_mode);
+	gmac_config_tx_threshold(pdata, pdata->tx_threshold);
+	gmac_config_rx_threshold(pdata, pdata->rx_threshold);
+	gmac_config_tx_fifo_size(pdata);
+	gmac_config_rx_fifo_size(pdata);
+	gmac_config_flow_control_threshold(pdata);
+	gmac_config_rx_fep_enable(pdata);
+	gmac_config_rx_fup_enable(pdata);
+	gmac_enable_mtl_interrupts(pdata);
+
+	/* Initialize MAC related features */
+	gmac_config_mac_address(pdata);
+	gmac_config_rx_mode(pdata);
+	gmac_config_jumbo_disable(pdata);
+	gmac_config_flow_control(pdata);
+	gmac_config_mac_speed(pdata);
+	gmac_config_checksum_offload(pdata);
+	gmac_config_vlan_support(pdata);
+	gmac_config_mmc(pdata);
+	gmac_enable_mac_interrupts(pdata);
+
+	return 0;
+}
+
+static int gmac_hw_exit(struct gmac_pdata *pdata)
+{
+	u32 regval;
+	int limit;
+
+	/* Issue a software reset */
+	regval = GMAC_IOREAD(pdata, DMA_MR);
+	regval = GMAC_SET_REG_BITS(regval, DMA_MR_SWR_POS,
+				   DMA_MR_SWR_LEN, 1);
+	GMAC_IOWRITE(pdata, DMA_MR, regval);
+	limit = 10;
+	while (limit-- &&
+	       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, DMA_MR),
+				 DMA_MR_SWR_POS, DMA_MR_SWR_LEN))
+		mdelay(10);
+
+	if (limit < 0)
+		return -EBUSY;
+
+	return 0;
+}
+
+static void gmac_config_hw_timestamping(struct gmac_pdata *pdata,
+					u32 data)
+{
+	GMAC_IOWRITE(pdata, PTP_TCR, data);
+}
+
+static void gmac_config_sub_second_increment(struct gmac_pdata *pdata,
+					     u32 ptp_clock,
+					     u32 *ssinc)
+{
+	u32 value = GMAC_IOREAD(pdata, PTP_TCR);
+	unsigned long data;
+	u32 reg_value = 0;
+
+	/* Convert the ptp_clock to nano second
+	 *	formula = (1/ptp_clock) * 1000000000
+	 * where ptp_clock is 50MHz if fine method is used to update system
+	 */
+	if (GMAC_GET_REG_BITS(value,
+			      PTP_TCR_TSCFUPDT_POS,
+			      PTP_TCR_TSCFUPDT_LEN))
+		data = (1000000000ULL / 50000000);
+	else
+		data = (1000000000ULL / ptp_clock);
+
+	/* 0.465ns accuracy */
+	if (!GMAC_GET_REG_BITS(value,
+			       PTP_TCR_TSCTRLSSR_POS,
+			       PTP_TCR_TSCTRLSSR_LEN))
+		data = (data * 1000) / 465;
+
+	reg_value = GMAC_SET_REG_BITS(reg_value,
+				      PTP_SSIR_SSINC_POS,
+				      PTP_SSIR_SSINC_LEN,
+				      data);
+
+	GMAC_IOWRITE(pdata, PTP_SSIR, reg_value);
+
+	if (ssinc)
+		*ssinc = data;
+}
+
+static int gmac_init_systime(struct gmac_pdata *pdata, u32 sec, u32 nsec)
+{
+	int limit;
+	u32 value;
+
+	GMAC_IOWRITE(pdata, PTP_STSUR, sec);
+	GMAC_IOWRITE(pdata, PTP_STNSUR, nsec);
+
+	/* issue command to initialize the system time value */
+	value = GMAC_IOREAD(pdata, PTP_TCR);
+	value = GMAC_SET_REG_BITS(value, PTP_TCR_TSINIT_POS,
+				  PTP_TCR_TSINIT_LEN, 1);
+	GMAC_IOWRITE(pdata, PTP_TCR, value);
+
+	/* wait for present system time initialize to complete */
+	limit = 10;
+	while (limit-- &&
+	       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, PTP_TCR),
+				 PTP_TCR_TSINIT_POS, PTP_TCR_TSINIT_LEN))
+		mdelay(10);
+
+	if (limit < 0)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int gmac_config_addend(struct gmac_pdata *pdata, u32 addend)
+{
+	u32 value;
+	int limit;
+
+	GMAC_IOWRITE(pdata, PTP_TAR, addend);
+	/* issue command to update the addend value */
+	value = GMAC_IOREAD(pdata, PTP_TCR);
+	value = GMAC_SET_REG_BITS(value, PTP_TCR_TSADDREG_POS,
+				  PTP_TCR_TSADDREG_LEN, 1);
+	GMAC_IOWRITE(pdata, PTP_TCR, value);
+
+	/* wait for present addend update to complete */
+	limit = 10;
+	while (limit-- &&
+	       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, PTP_TCR),
+				 PTP_TCR_TSADDREG_POS,
+				 PTP_TCR_TSADDREG_LEN))
+		mdelay(10);
+
+	if (limit < 0)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int gmac_adjust_systime(struct gmac_pdata *pdata,
+			       u32 sec,
+			       u32 nsec,
+			       int add_sub)
+{
+	u32 value;
+	int limit;
+
+	if (add_sub) {
+		/* If the new sec value needs to be subtracted with
+		 * the system time, then MAC_STSUR reg should be
+		 * programmed with (2^32 - <new_sec_value>)
+		 */
+		sec = (0x100000000ULL - sec);
+
+		value = GMAC_IOREAD(pdata, PTP_TCR);
+		if (GMAC_GET_REG_BITS(value,
+				      PTP_TCR_TSCTRLSSR_POS,
+				      PTP_TCR_TSCTRLSSR_LEN))
+			nsec = (PTP_DIGITAL_ROLLOVER_MODE - nsec);
+		else
+			nsec = (PTP_BINARY_ROLLOVER_MODE - nsec);
+	}
+
+	GMAC_IOWRITE(pdata, PTP_STSUR, sec);
+
+	value = 0;
+	value = GMAC_SET_REG_BITS(value, PTP_STNSUR_ADDSUB_POS,
+				  PTP_STNSUR_ADDSUB_LEN, add_sub);
+	value = GMAC_SET_REG_BITS(value, PTP_STNSUR_TSSSS_POS,
+				  PTP_STNSUR_TSSSS_LEN, nsec);
+	GMAC_IOWRITE(pdata, PTP_STNSUR, value);
+
+	/* issue command to initialize the system time value */
+	value = GMAC_IOREAD(pdata, PTP_TCR);
+	value = GMAC_SET_REG_BITS(value, PTP_TCR_TSUPDT_POS,
+				  PTP_TCR_TSUPDT_LEN, 1);
+	GMAC_IOWRITE(pdata, PTP_TCR, value);
+
+	/* wait for present system time adjust/update to complete */
+	limit = 10;
+	while (limit-- &&
+	       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, PTP_TCR),
+				 PTP_TCR_TSUPDT_POS, PTP_TCR_TSUPDT_LEN))
+		mdelay(10);
+
+	if (limit < 0)
+		return -EBUSY;
+
+	return 0;
+}
+
+static void gmac_get_systime(struct gmac_pdata *pdata, u64 *systime)
+{
+	u64 ns;
+
+	/* Get the TSSS value */
+	ns = GMAC_IOREAD(pdata, PTP_STNSR);
+	/* Get the TSS and convert sec time value to nanosecond */
+	ns += GMAC_IOREAD(pdata, PTP_STSR) * 1000000000ULL;
+
+	if (systime)
+		*systime = ns;
+}
+
+static int gmac_get_tx_timestamp_status(struct gmac_dma_desc *dma_desc)
+{
+	return GMAC_GET_REG_BITS_LE(dma_desc->desc0,
+				    TX_NORMAL_DESC3_TTSS_POS,
+				    TX_NORMAL_DESC3_TTSS_LEN);
+}
+
+static void gmac_get_tx_timestamp(struct gmac_dma_desc *desc, u64 *ts)
+{
+	u64 ns;
+
+	ns = desc->desc0;
+	/* convert high/sec time stamp value to nanosecond */
+	ns += (desc->desc1 * 1000000000ULL);
+
+	*ts = ns;
+}
+
+static void gmac_get_tx_hwtstamp(struct gmac_pdata *pdata,
+				 struct gmac_dma_desc *desc,
+				 struct sk_buff *skb)
+{
+	struct skb_shared_hwtstamps shhwtstamp;
+	u64 ns;
+
+	if (!pdata->hwts_tx_en)
+		return;
+
+	/* exit if skb doesn't support hw tstamp */
+	if (likely(!skb || !(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS)))
+		return;
+
+	/* check tx tstamp status */
+	if (gmac_get_tx_timestamp_status(desc)) {
+		/* get the valid tstamp */
+		gmac_get_tx_timestamp(desc, &ns);
+
+		memset(&shhwtstamp, 0, sizeof(struct skb_shared_hwtstamps));
+		shhwtstamp.hwtstamp = ns_to_ktime(ns);
+
+		netdev_dbg(pdata->netdev,
+			   "get valid TX hw timestamp %llu\n",
+			   ns);
+		/* pass tstamp to stack */
+		skb_tstamp_tx(skb, &shhwtstamp);
+		pdata->stats.tx_timestamp_packets++;
+	}
+}
+
+void gmac_init_hw_ops(struct gmac_hw_ops *hw_ops)
+{
+	hw_ops->init = gmac_hw_init;
+	hw_ops->exit = gmac_hw_exit;
+
+	hw_ops->tx_complete = gmac_tx_complete;
+
+	hw_ops->enable_tx = gmac_enable_tx;
+	hw_ops->disable_tx = gmac_disable_tx;
+	hw_ops->enable_rx = gmac_enable_rx;
+	hw_ops->disable_rx = gmac_disable_rx;
+
+	hw_ops->dev_xmit = gmac_dev_xmit;
+	hw_ops->dev_read = gmac_dev_read;
+	hw_ops->enable_int = gmac_enable_int;
+	hw_ops->disable_int = gmac_disable_int;
+
+	hw_ops->set_mac_address = gmac_set_mac_address;
+	hw_ops->config_rx_mode = gmac_config_rx_mode;
+	hw_ops->enable_rx_csum = gmac_enable_rx_csum;
+	hw_ops->disable_rx_csum = gmac_disable_rx_csum;
+
+	/* For MII speed configuration */
+	hw_ops->set_gmii_10_speed = gmac_set_gmii_10_speed;
+	hw_ops->set_gmii_100_speed = gmac_set_gmii_100_speed;
+	hw_ops->set_gmii_1000_speed = gmac_set_gmii_1000_speed;
+
+	hw_ops->set_full_duplex = gmac_set_full_duplex;
+	hw_ops->set_half_duplex = gmac_set_half_duplex;
+
+	/* For descriptor related operation */
+	hw_ops->tx_desc_init = gmac_tx_desc_init;
+	hw_ops->rx_desc_init = gmac_rx_desc_init;
+	hw_ops->tx_desc_reset = gmac_tx_desc_reset;
+	hw_ops->rx_desc_reset = gmac_rx_desc_reset;
+	hw_ops->is_last_desc = gmac_is_last_desc;
+	hw_ops->is_context_desc = gmac_is_context_desc;
+	hw_ops->tx_start_xmit = gmac_tx_start_xmit;
+
+	/* For Flow Control */
+	hw_ops->config_tx_flow_control = gmac_config_tx_flow_control;
+	hw_ops->config_rx_flow_control = gmac_config_rx_flow_control;
+
+	/* For Vlan related config */
+	hw_ops->enable_rx_vlan_stripping = gmac_enable_rx_vlan_stripping;
+	hw_ops->disable_rx_vlan_stripping = gmac_disable_rx_vlan_stripping;
+	hw_ops->enable_rx_vlan_filtering = gmac_enable_rx_vlan_filtering;
+	hw_ops->disable_rx_vlan_filtering = gmac_disable_rx_vlan_filtering;
+	hw_ops->update_vlan_hash_table = gmac_update_vlan_hash_table;
+	hw_ops->update_vlan = gmac_update_vlan;
+
+	/* For RX coalescing */
+	hw_ops->config_rx_coalesce = gmac_config_rx_coalesce;
+	hw_ops->config_tx_coalesce = gmac_config_tx_coalesce;
+	hw_ops->usec_to_riwt = gmac_usec_to_riwt;
+	hw_ops->riwt_to_usec = gmac_riwt_to_usec;
+
+	/* For RX and TX threshold config */
+	hw_ops->config_rx_threshold = gmac_config_rx_threshold;
+	hw_ops->config_tx_threshold = gmac_config_tx_threshold;
+
+	/* For RX and TX Store and Forward Mode config */
+	hw_ops->config_rsf_mode = gmac_config_rsf_mode;
+	hw_ops->config_tsf_mode = gmac_config_tsf_mode;
+
+	/* For TX DMA Operating on Second Frame config */
+	hw_ops->config_osp_mode = gmac_config_osp_mode;
+
+	/* For RX and TX PBL config */
+	hw_ops->config_rx_pbl_val = gmac_config_rx_pbl_val;
+	hw_ops->config_tx_pbl_val = gmac_config_tx_pbl_val;
+	hw_ops->config_pblx8 = gmac_config_pblx8;
+
+	/* For MMC statistics support */
+	hw_ops->tx_mmc_int = gmac_tx_mmc_int;
+	hw_ops->rx_mmc_int = gmac_rx_mmc_int;
+	hw_ops->rxipc_mmc_int = gmac_rxipc_mmc_int;
+	hw_ops->read_mmc_stats = gmac_read_mmc_stats;
+
+	/* For HW timestamping */
+	hw_ops->config_hw_timestamping = gmac_config_hw_timestamping;
+	hw_ops->config_sub_second_increment = gmac_config_sub_second_increment;
+	hw_ops->init_systime = gmac_init_systime;
+	hw_ops->config_addend = gmac_config_addend;
+	hw_ops->adjust_systime = gmac_adjust_systime;
+	hw_ops->get_systime = gmac_get_systime;
+	hw_ops->get_tx_hwtstamp = gmac_get_tx_hwtstamp;
+}
+
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-mdio.c b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-mdio.c
new file mode 100644
index 0000000..2088498
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-mdio.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mii.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
+
+#include "mtk-gmac.h"
+
+static int gmac_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
+{
+	struct net_device *ndev = bus->priv;
+	struct gmac_pdata *pdata = netdev_priv(ndev);
+	int data;
+	u32 value = 0;
+	int limit;
+
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_PA_POS,
+				  MAC_MDIOAR_PA_LEN, phyaddr);
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_RDA_POS,
+				  MAC_MDIOAR_RDA_LEN, phyreg);
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_CR_POS,
+				  MAC_MDIOAR_CR_LEN, 0);
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_GOC_POS,
+				  MAC_MDIOAR_GOC_LEN, 3);
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_GB_POS,
+				  MAC_MDIOAR_GB_LEN, 1);
+
+	limit = 10;
+	while (limit-- &&
+	       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MDIOAR),
+				 MAC_MDIOAR_GB_POS,
+				 MAC_MDIOAR_GB_LEN))
+		mdelay(10);
+
+	if (limit < 0)
+		return -EBUSY;
+
+	GMAC_IOWRITE(pdata, MAC_MDIOAR, value);
+
+	limit = 10;
+	while (limit-- &&
+	       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MDIOAR),
+				 MAC_MDIOAR_GB_POS,
+				 MAC_MDIOAR_GB_LEN))
+		mdelay(10);
+
+	if (limit < 0)
+		return -EBUSY;
+
+	/* Read the data from the MII data register */
+	data = (int)GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MDIODR),
+				      MAC_MDIODR_GD_POS,
+				      MAC_MDIODR_GD_LEN);
+
+	return data;
+}
+
+static int gmac_mdio_write(struct mii_bus *bus,
+			   int phyaddr,
+			   int phyreg,
+			   u16 phydata)
+{
+	struct net_device *ndev = bus->priv;
+	struct gmac_pdata *pdata = netdev_priv(ndev);
+	u32 value = 0;
+	int limit;
+
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_PA_POS,
+				  MAC_MDIOAR_PA_LEN, phyaddr);
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_RDA_POS,
+				  MAC_MDIOAR_RDA_LEN, phyreg);
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_CR_POS,
+				  MAC_MDIOAR_CR_LEN, 0);
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_GOC_POS,
+				  MAC_MDIOAR_GOC_LEN, 1);
+	value = GMAC_SET_REG_BITS(value, MAC_MDIOAR_GB_POS,
+				  MAC_MDIOAR_GB_LEN, 1);
+
+	limit = 10;
+	while (limit-- &&
+	       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MDIOAR),
+				 MAC_MDIOAR_GB_POS,
+				 MAC_MDIOAR_GB_LEN))
+		mdelay(10);
+
+	if (limit < 0)
+		return -EBUSY;
+
+	/* Set the MII address register to write */
+	GMAC_IOWRITE(pdata, MAC_MDIODR, phydata);
+	GMAC_IOWRITE(pdata, MAC_MDIOAR, value);
+
+	limit = 10;
+	while (limit-- &&
+	       GMAC_GET_REG_BITS(GMAC_IOREAD(pdata, MAC_MDIOAR),
+				 MAC_MDIOAR_GB_POS,
+				 MAC_MDIOAR_GB_LEN))
+		mdelay(10);
+
+	if (limit < 0)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int gmac_mdio_reset(struct mii_bus *bus)
+{
+	struct net_device *ndev = bus->priv;
+	struct gmac_pdata *pdata = netdev_priv(ndev);
+
+	gpio_direction_output(pdata->phy_rst, 0);
+
+	msleep(20);
+
+	gpio_direction_output(pdata->phy_rst, 1);
+
+	return 0;
+}
+
+static void adjust_link(struct net_device *ndev)
+{
+	struct gmac_pdata *pdata = netdev_priv(ndev);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct phy_device *phydev = pdata->phydev;
+
+	if (!phydev)
+		return;
+
+	if (phydev->link) {
+		/* Now we make sure that we can be in full duplex mode.
+		 * If not, we operate in half-duplex mode
+		 */
+		if (phydev->duplex)
+			hw_ops->set_full_duplex(pdata);
+		else
+			hw_ops->set_full_duplex(pdata);
+
+		switch (phydev->speed) {
+		case SPEED_1000:
+			hw_ops->set_gmii_1000_speed(pdata);
+			break;
+		case SPEED_100:
+			hw_ops->set_gmii_100_speed(pdata);
+			break;
+		case SPEED_10:
+			hw_ops->set_gmii_10_speed(pdata);
+			break;
+		}
+	}
+}
+
+static int init_phy(struct net_device *ndev)
+{
+	struct gmac_pdata *pdata = netdev_priv(ndev);
+	struct phy_device *phydev = NULL;
+	char phy_id_fmt[MII_BUS_ID_SIZE + 3];
+	char bus_id[MII_BUS_ID_SIZE];
+
+	snprintf(bus_id, MII_BUS_ID_SIZE, "mtk_gmac-%x", pdata->bus_id);
+
+	snprintf(phy_id_fmt, MII_BUS_ID_SIZE + 3,
+		 PHY_ID_FMT, bus_id,
+		 pdata->phyaddr);
+
+	phydev = phy_connect(ndev, phy_id_fmt, &adjust_link,
+			     pdata->plat->phy_mode);
+	if (IS_ERR(phydev)) {
+		dev_err(pdata->dev, "%s: Could not attach to PHY\n", ndev->name);
+		return PTR_ERR(phydev);
+	}
+
+	if (phydev->phy_id == 0) {
+		phy_disconnect(phydev);
+		return -ENODEV;
+	}
+
+	if (pdata->plat->phy_mode == PHY_INTERFACE_MODE_GMII) {
+		phydev->supported = PHY_GBIT_FEATURES;
+	} else if ((pdata->plat->phy_mode == PHY_INTERFACE_MODE_MII) ||
+		(pdata->plat->phy_mode == PHY_INTERFACE_MODE_RMII)) {
+		phydev->supported = PHY_BASIC_FEATURES;
+	}
+
+	phydev->advertising = phydev->supported;
+
+	pdata->phydev = phydev;
+	phy_start(pdata->phydev);
+
+	return 0;
+}
+
+int mdio_register(struct net_device *ndev)
+{
+	struct gmac_pdata *pdata = netdev_priv(ndev);
+	struct mii_bus *new_bus = NULL;
+	int phyaddr = 0;
+	unsigned short phy_detected = 0;
+	int ret = 0;
+
+	new_bus = mdiobus_alloc();
+	if (!new_bus)
+		return -ENOMEM;
+
+	pdata->bus_id = 0x1;
+	new_bus->name = "mtk_gmac";
+	new_bus->read = gmac_mdio_read;
+	new_bus->write = gmac_mdio_write;
+	new_bus->reset = gmac_mdio_reset;
+	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%s-%x",
+		 new_bus->name, pdata->bus_id);
+	new_bus->priv = ndev;
+	new_bus->phy_mask = 0;
+	new_bus->parent = pdata->dev;
+
+	ret = mdiobus_register(new_bus);
+	if (ret != 0) {
+		dev_err(pdata->dev, "%s: Cannot register as MDIO bus\n", new_bus->name);
+		mdiobus_free(new_bus);
+		return ret;
+	}
+	pdata->mii = new_bus;
+
+	for (phyaddr = 0; phyaddr < PHY_MAX_ADDR; phyaddr++) {
+		struct phy_device *phydev = mdiobus_get_phy(new_bus, phyaddr);
+
+		if (!phydev)
+			continue;
+
+		pdata->phyaddr = phyaddr;
+
+		phy_attached_info(phydev);
+		phy_detected = 1;
+	}
+	if (!phy_detected) {
+		dev_warn(pdata->dev, "No PHY found\n");
+		ret = -ENODEV;
+		goto err_out_phy_connect;
+	}
+
+	ret = init_phy(ndev);
+	if (unlikely(ret)) {
+		dev_err(pdata->dev, "Cannot attach to PHY (error: %d)\n", ret);
+		goto err_out_phy_connect;
+	}
+
+	return ret;
+
+ err_out_phy_connect:
+	mdiobus_unregister(new_bus);
+	mdiobus_free(new_bus);
+	return ret;
+}
+
+void mdio_unregister(struct net_device *ndev)
+{
+	struct gmac_pdata *pdata = netdev_priv(ndev);
+
+	if (pdata->phydev) {
+		phy_stop(pdata->phydev);
+		phy_disconnect(pdata->phydev);
+		pdata->phydev = NULL;
+	}
+
+	mdiobus_unregister(pdata->mii);
+	pdata->mii->priv = NULL;
+	mdiobus_free(pdata->mii);
+	pdata->mii = NULL;
+}
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-net.c b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-net.c
new file mode 100644
index 0000000..ea504e3
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-net.c
@@ -0,0 +1,1638 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include <linux/netdevice.h>
+#include <linux/tcp.h>
+#include <linux/interrupt.h>
+
+#include "mtk-gmac.h"
+
+static int gmac_one_poll(struct napi_struct *, int);
+static int gmac_all_poll(struct napi_struct *, int);
+
+static inline unsigned int gmac_tx_avail_desc(struct gmac_ring *ring)
+{
+	return (ring->dma_desc_count - (ring->cur - ring->dirty));
+}
+
+static inline unsigned int gmac_rx_dirty_desc(struct gmac_ring *ring)
+{
+	return (ring->cur - ring->dirty);
+}
+
+static int gmac_maybe_stop_tx_queue(struct gmac_channel *channel,
+				    struct gmac_ring *ring,
+				    unsigned int count)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+
+	if (count > gmac_tx_avail_desc(ring)) {
+		netif_info(pdata, drv, pdata->netdev,
+			   "Tx queue stopped, not enough descriptors available\n");
+		netif_stop_subqueue(pdata->netdev, channel->queue_index);
+		ring->tx.queue_stopped = 1;
+
+		/* If we haven't notified the hardware because of xmit_more
+		 * support, tell it now
+		 */
+		if (ring->tx.xmit_more)
+			pdata->hw_ops.tx_start_xmit(channel, ring);
+
+		return NETDEV_TX_BUSY;
+	}
+
+	return 0;
+}
+
+static void gmac_prep_vlan(struct sk_buff *skb,
+			   struct gmac_pkt_info *pkt_info)
+{
+	if (skb_vlan_tag_present(skb))
+		pkt_info->vlan_ctag = skb_vlan_tag_get(skb);
+}
+
+static int gmac_prep_tso(struct gmac_pdata *pdata,
+			 struct sk_buff *skb,
+			 struct gmac_pkt_info *pkt_info)
+{
+	int ret;
+
+	if (!GMAC_GET_REG_BITS(pkt_info->attributes,
+			       TX_PACKET_ATTRIBUTES_TSO_ENABLE_POS,
+			       TX_PACKET_ATTRIBUTES_TSO_ENABLE_LEN))
+		return 0;
+
+	ret = skb_cow_head(skb, 0);
+	if (ret)
+		return ret;
+
+	pkt_info->header_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	pkt_info->tcp_header_len = tcp_hdrlen(skb);
+	pkt_info->tcp_payload_len = skb->len - pkt_info->header_len;
+	pkt_info->mss = skb_shinfo(skb)->gso_size;
+
+	netif_dbg(pdata, tx_queued, pdata->netdev,
+		  "header_len=%u\n", pkt_info->header_len);
+	netif_dbg(pdata, tx_queued, pdata->netdev,
+		  "tcp_header_len=%u, tcp_payload_len=%u\n",
+		  pkt_info->tcp_header_len, pkt_info->tcp_payload_len);
+	netif_dbg(pdata, tx_queued, pdata->netdev, "mss=%u\n", pkt_info->mss);
+
+	/* Update the number of packets that will ultimately be transmitted
+	 * along with the extra bytes for each extra packet
+	 */
+	pkt_info->tx_packets = skb_shinfo(skb)->gso_segs;
+	pkt_info->tx_bytes +=
+		(pkt_info->tx_packets - 1) * pkt_info->header_len;
+
+	return 0;
+}
+
+static int gmac_is_tso(struct sk_buff *skb)
+{
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	if (!skb_is_gso(skb))
+		return 0;
+
+	return 1;
+}
+
+static void gmac_prep_tx_pkt(struct gmac_pdata *pdata,
+			     struct gmac_ring *ring,
+			     struct sk_buff *skb,
+			     struct gmac_pkt_info *pkt_info)
+{
+	struct skb_frag_struct *frag;
+	unsigned int context_desc;
+	unsigned int len;
+	unsigned int i;
+
+	pkt_info->skb = skb;
+
+	context_desc = 0;
+	pkt_info->desc_count = 0;
+
+	pkt_info->tx_packets = 1;
+	pkt_info->tx_bytes = skb->len;
+
+	if (gmac_is_tso(skb)) {
+		/* TSO requires an extra descriptor if mss is different */
+		if (skb_shinfo(skb)->gso_size != ring->tx.cur_mss) {
+			context_desc = 1;
+			pkt_info->desc_count++;
+		}
+
+		/* TSO requires an extra descriptor for TSO header */
+		pkt_info->desc_count++;
+
+		pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+							 TX_PACKET_ATTRIBUTES_TSO_ENABLE_POS,
+							 TX_PACKET_ATTRIBUTES_TSO_ENABLE_LEN,
+							 1);
+		pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+							 TX_PACKET_ATTRIBUTES_CSUM_ENABLE_POS,
+							 TX_PACKET_ATTRIBUTES_CSUM_ENABLE_LEN,
+							 1);
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+							 TX_PACKET_ATTRIBUTES_CSUM_ENABLE_POS,
+							 TX_PACKET_ATTRIBUTES_CSUM_ENABLE_LEN,
+							 1);
+	}
+
+	if (skb_vlan_tag_present(skb)) {
+		/* VLAN requires an extra descriptor if tag is different */
+		if (skb_vlan_tag_get(skb) != ring->tx.cur_vlan_ctag)
+			/* We can share with the TSO context descriptor */
+			if (!context_desc) {
+				context_desc = 1;
+				pkt_info->desc_count++;
+			}
+
+		pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+							 TX_PACKET_ATTRIBUTES_VLAN_CTAG_POS,
+							 TX_PACKET_ATTRIBUTES_VLAN_CTAG_LEN,
+							 1);
+	}
+
+	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
+		     pdata->hw_feat.ts_src &&
+		     pdata->hwts_tx_en)) {
+		/* declare that device is doing timestamping */
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		pkt_info->attributes = GMAC_SET_REG_BITS(pkt_info->attributes,
+							 TX_PACKET_ATTRIBUTES_PTP_POS,
+							 TX_PACKET_ATTRIBUTES_PTP_LEN,
+							 1);
+	}
+
+	for (len = skb_headlen(skb); len;) {
+		pkt_info->desc_count++;
+		len -= min_t(unsigned int, len, GMAC_TX_MAX_BUF_SIZE);
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		frag = &skb_shinfo(skb)->frags[i];
+		for (len = skb_frag_size(frag); len; ) {
+			pkt_info->desc_count++;
+			len -= min_t(unsigned int, len, GMAC_TX_MAX_BUF_SIZE);
+		}
+	}
+}
+
+static int gmac_calc_rx_buf_size(struct net_device *netdev, unsigned int mtu)
+{
+	unsigned int rx_buf_size;
+
+	if (mtu > ETH_DATA_LEN) {
+		netdev_alert(netdev, "MTU exceeds maximum supported value\n");
+		return -EINVAL;
+	}
+
+	rx_buf_size = mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+
+	return rx_buf_size;
+}
+
+static void gmac_enable_rx_tx_ints(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct gmac_channel *channel;
+	enum gmac_int int_id;
+	unsigned int i;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (channel->tx_ring && channel->rx_ring)
+			int_id = GMAC_INT_DMA_CH_SR_TI_RI;
+		else if (channel->tx_ring)
+			int_id = GMAC_INT_DMA_CH_SR_TI;
+		else if (channel->rx_ring)
+			int_id = GMAC_INT_DMA_CH_SR_RI;
+		else
+			continue;
+
+		hw_ops->enable_int(channel, int_id);
+	}
+}
+
+static void gmac_disable_rx_tx_ints(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct gmac_channel *channel;
+	enum gmac_int int_id;
+	unsigned int i;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (channel->tx_ring && channel->rx_ring)
+			int_id = GMAC_INT_DMA_CH_SR_TI_RI;
+		else if (channel->tx_ring)
+			int_id = GMAC_INT_DMA_CH_SR_TI;
+		else if (channel->rx_ring)
+			int_id = GMAC_INT_DMA_CH_SR_RI;
+		else
+			continue;
+
+		hw_ops->disable_int(channel, int_id);
+	}
+}
+
+static void gmac_rgsmii(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *ndev = pdata->netdev;
+	u32 status, duplex;
+
+	status = GMAC_IOREAD(pdata, MAC_PCSR);
+	if (GMAC_GET_REG_BITS(status, MAC_RGMII_LNKSTS_POS,
+			      MAC_RGMII_LNKSTS_LEN)) {
+		int speed_value;
+
+		speed_value = GMAC_GET_REG_BITS(status,
+						MAC_RGMII_SPEED_POS,
+						MAC_RGMII_SPEED_LEN);
+		if (speed_value == GMAC_RGSMIIIS_SPEED_125) {
+			hw_ops->set_gmii_1000_speed(pdata);
+			pdata->phy_speed = SPEED_1000;
+		} else if (speed_value == GMAC_RGSMIIIS_SPEED_25) {
+			hw_ops->set_gmii_100_speed(pdata);
+			pdata->phy_speed = SPEED_100;
+		} else {
+			hw_ops->set_gmii_10_speed(pdata);
+			pdata->phy_speed = SPEED_10;
+		}
+
+		duplex = GMAC_GET_REG_BITS(status,
+					   MAC_RGMII_LNKMODE_POS,
+					   MAC_RGMII_LNKMODE_LEN);
+		if (duplex) {
+			hw_ops->set_full_duplex(pdata);
+			pdata->phy_speed = DUPLEX_FULL;
+		} else {
+			hw_ops->set_half_duplex(pdata);
+			pdata->phy_speed = DUPLEX_HALF;
+		}
+
+		netif_carrier_on(ndev);
+	} else {
+		netif_carrier_off(ndev);
+	}
+}
+
+static int gmac_hw_dma_interrupt(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int dma_isr, dma_ch_isr;
+	int ret = 0, i;
+
+	dma_isr = GMAC_IOREAD(pdata, DMA_ISR);
+
+	/* Handle DMA interrupts */
+	for (i = 0; i < pdata->channel_count; i++) {
+		if (!(dma_isr & (1 << i)))
+			continue;
+
+		channel = pdata->channel_head + i;
+
+		dma_ch_isr =
+			GMAC_IOREAD(pdata, DMA_CH_SR(channel->queue_index));
+		netif_dbg(pdata, intr, pdata->netdev, "DMA_CH%u_ISR=%#010x\n",
+			  i, dma_ch_isr);
+
+		if (GMAC_GET_REG_BITS(dma_ch_isr,
+				      DMA_CH_ISR_AIS_POS,
+				      DMA_CH_ISR_AIS_LEN)) {
+			if (GMAC_GET_REG_BITS(dma_ch_isr,
+					      DMA_CH_ISR_TPS_POS,
+					      DMA_CH_ISR_TPS_LEN))
+				pdata->stats.tx_process_stopped++;
+
+			if (GMAC_GET_REG_BITS(dma_ch_isr,
+					      DMA_CH_ISR_RPS_POS,
+					      DMA_CH_ISR_RPS_LEN))
+				pdata->stats.rx_process_stopped++;
+
+			if (GMAC_GET_REG_BITS(dma_ch_isr,
+					      DMA_CH_ISR_TBU_POS,
+					      DMA_CH_ISR_TBU_LEN))
+				pdata->stats.tx_buffer_unavailable++;
+
+			if (GMAC_GET_REG_BITS(dma_ch_isr,
+					      DMA_CH_ISR_RBU_POS,
+					      DMA_CH_ISR_RBU_LEN))
+				pdata->stats.rx_buffer_unavailable++;
+
+			/* Restart the device on a Fatal Bus Error */
+			if (GMAC_GET_REG_BITS(dma_ch_isr,
+					      DMA_CH_ISR_FBE_POS,
+					      DMA_CH_ISR_FBE_LEN)) {
+				pdata->stats.fatal_bus_error++;
+				schedule_work(&pdata->restart_work);
+				ret = tx_hard_error;
+			}
+		}
+
+		/* TX/RX NORMAL interrupts */
+		if (GMAC_GET_REG_BITS(dma_ch_isr,
+				      DMA_CH_ISR_NIS_POS,
+				      DMA_CH_ISR_NIS_LEN)) {
+			if (GMAC_GET_REG_BITS(dma_ch_isr,
+					      DMA_CH_ISR_RI_POS,
+					      DMA_CH_ISR_RI_LEN)) {
+				ret |= handle_rx;
+			}
+			if (GMAC_GET_REG_BITS(dma_ch_isr,
+					      DMA_CH_ISR_TI_POS,
+					      DMA_CH_ISR_TI_LEN))
+				ret |= handle_tx;
+		}
+
+		/* Clear the interrupt by writing a logic 1 to the CSR5[15-0] */
+		GMAC_IOWRITE(pdata,
+			     DMA_CH_SR(channel->queue_index),
+			     dma_ch_isr & 0x1ffff);
+	}
+
+	return ret;
+}
+
+static void gmac_dma_interrupt(struct gmac_pdata *pdata)
+{
+	int status;
+
+	status = gmac_hw_dma_interrupt(pdata);
+
+	if (!pdata->per_channel_irq &&
+	    likely((status & handle_rx) || (status & handle_tx)))
+		if (likely(napi_schedule_prep(&pdata->napi))) {
+			gmac_disable_rx_tx_ints(pdata);
+			pdata->stats.napi_poll_isr++;
+			/* Turn on polling */
+			__napi_schedule_irqoff(&pdata->napi);
+		}
+}
+
+static irqreturn_t gmac_isr(int irq, void *data)
+{
+	unsigned int dma_isr, mac_isr;
+	struct gmac_pdata *pdata = data;
+	struct gmac_hw_ops *hw_ops;
+
+	hw_ops = &pdata->hw_ops;
+
+	/* The DMA interrupt status register also reports MAC and MTL
+	 * interrupts. So for polling mode, we just need to check for
+	 * this register to be non-zero
+	 */
+	dma_isr = GMAC_IOREAD(pdata, DMA_ISR);
+	if (!dma_isr)
+		return IRQ_HANDLED;
+
+	netif_dbg(pdata, intr, pdata->netdev, "DMA_ISR=%#010x\n", dma_isr);
+
+	if (GMAC_GET_REG_BITS(dma_isr, DMA_ISR_MACIS_POS,
+			      DMA_ISR_MACIS_LEN)) {
+		mac_isr = GMAC_IOREAD(pdata, MAC_ISR);
+
+		if (GMAC_GET_REG_BITS(mac_isr,
+				      MAC_ISR_MMCTXIS_POS,
+				      MAC_ISR_MMCTXIS_LEN))
+			hw_ops->tx_mmc_int(pdata);
+
+		if (GMAC_GET_REG_BITS(mac_isr,
+				      MAC_ISR_MMCRXIS_POS,
+				      MAC_ISR_MMCRXIS_LEN))
+			hw_ops->rx_mmc_int(pdata);
+
+		if (GMAC_GET_REG_BITS(mac_isr,
+				      MAC_ISR_MMCRXIPIS_POS,
+				      MAC_ISR_MMCRXIPIS_LEN))
+			hw_ops->rxipc_mmc_int(pdata);
+
+		if (GMAC_GET_REG_BITS(mac_isr,
+				      MAC_ISR_RGSMIIS_POS,
+				      MAC_ISR_RGSMIIS_LEN))
+			gmac_rgsmii(pdata);
+	}
+
+	gmac_dma_interrupt(pdata);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t gmac_dma_isr(int irq, void *data)
+{
+	struct gmac_channel *channel = data;
+
+	/* Per channel DMA interrupts are enabled, so we use the per
+	 * channel napi structure and not the private data napi structure
+	 */
+	if (napi_schedule_prep(&channel->napi)) {
+		/* Disable Tx and Rx interrupts */
+		disable_irq_nosync(channel->dma_irq);
+
+		/* Turn on polling */
+		__napi_schedule_irqoff(&channel->napi);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void gmac_tx_timer(struct timer_list *t)
+{
+	struct gmac_channel *channel = from_timer(channel, t, tx_timer);
+	struct gmac_pdata *pdata = channel->pdata;
+	struct napi_struct *napi;
+
+	napi = (pdata->per_channel_irq) ? &channel->napi : &pdata->napi;
+
+	if (napi_schedule_prep(napi)) {
+		/* Disable Tx and Rx interrupts */
+		if (pdata->per_channel_irq)
+			disable_irq_nosync(channel->dma_irq);
+		else
+			gmac_disable_rx_tx_ints(pdata);
+
+		pdata->stats.napi_poll_txtimer++;
+		/* Turn on polling */
+		__napi_schedule(napi);
+	}
+
+	channel->tx_timer_active = 0;
+}
+
+static void gmac_init_timers(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		timer_setup(&channel->tx_timer, gmac_tx_timer, 0);
+	}
+}
+
+static void gmac_stop_timers(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		del_timer_sync(&channel->tx_timer);
+	}
+}
+
+static void gmac_napi_enable(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+
+	if (pdata->per_channel_irq) {
+		channel = pdata->channel_head;
+		for (i = 0; i < pdata->channel_count; i++, channel++) {
+			netif_napi_add(pdata->netdev,
+				       &channel->napi,
+				       gmac_one_poll,
+				       NAPI_POLL_WEIGHT);
+
+			napi_enable(&channel->napi);
+		}
+	} else {
+		netif_napi_add(pdata->netdev,
+			       &pdata->napi,
+			       gmac_all_poll,
+			       NAPI_POLL_WEIGHT);
+
+		napi_enable(&pdata->napi);
+	}
+}
+
+static void gmac_napi_disable(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+
+	if (pdata->per_channel_irq) {
+		channel = pdata->channel_head;
+		for (i = 0; i < pdata->channel_count; i++, channel++) {
+			napi_disable(&channel->napi);
+
+			netif_napi_del(&channel->napi);
+		}
+	} else {
+		napi_disable(&pdata->napi);
+
+		netif_napi_del(&pdata->napi);
+	}
+}
+
+static int gmac_request_irqs(struct gmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	struct gmac_channel *channel;
+	unsigned int i;
+	int ret;
+
+	ret = devm_request_irq(pdata->dev, pdata->dev_irq, gmac_isr,
+			       IRQF_SHARED, netdev->name, pdata);
+	if (ret) {
+		netdev_alert(netdev, "error requesting irq %d\n",
+			     pdata->dev_irq);
+		return ret;
+	}
+
+	if (!pdata->per_channel_irq)
+		return 0;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		snprintf(channel->dma_irq_name,
+			 sizeof(channel->dma_irq_name) - 1,
+			 "%s-TxRx-%u", netdev_name(netdev),
+			 channel->queue_index);
+
+		ret = devm_request_irq(pdata->dev, channel->dma_irq,
+				       gmac_dma_isr, 0,
+				       channel->dma_irq_name, channel);
+		if (ret) {
+			netdev_alert(netdev, "error requesting irq %d\n",
+				     channel->dma_irq);
+			goto err_irq;
+		}
+	}
+
+	return 0;
+
+err_irq:
+	/* Using an unsigned int, 'i' will go to UINT_MAX and exit */
+	for (i--, channel--; i < pdata->channel_count; i--, channel--)
+		devm_free_irq(pdata->dev, channel->dma_irq, channel);
+
+	devm_free_irq(pdata->dev, pdata->dev_irq, pdata);
+
+	return ret;
+}
+
+static void gmac_free_irqs(struct gmac_pdata *pdata)
+{
+	struct gmac_channel *channel;
+	unsigned int i;
+
+	devm_free_irq(pdata->dev, pdata->dev_irq, pdata);
+
+	if (!pdata->per_channel_irq)
+		return;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++)
+		devm_free_irq(pdata->dev, channel->dma_irq, channel);
+}
+
+static void gmac_free_tx_data(struct gmac_pdata *pdata)
+{
+	struct gmac_desc_ops *desc_ops = &pdata->desc_ops;
+	struct gmac_desc_data *desc_data;
+	struct gmac_channel *channel;
+	struct gmac_ring *ring;
+	unsigned int i, j;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->tx_ring;
+		if (!ring)
+			break;
+
+		for (j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = GMAC_GET_DESC_DATA(ring, j);
+			desc_ops->unmap_desc_data(pdata, desc_data, 1);
+		}
+	}
+}
+
+static void gmac_free_rx_data(struct gmac_pdata *pdata)
+{
+	struct gmac_desc_ops *desc_ops = &pdata->desc_ops;
+	struct gmac_desc_data *desc_data;
+	struct gmac_channel *channel;
+	struct gmac_ring *ring;
+	unsigned int i, j;
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->rx_ring;
+		if (!ring)
+			break;
+
+		for (j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = GMAC_GET_DESC_DATA(ring, j);
+			desc_ops->unmap_desc_data(pdata, desc_data, 0);
+		}
+	}
+}
+
+static int gmac_start(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *netdev = pdata->netdev;
+	int ret;
+
+	hw_ops->init(pdata);
+	gmac_napi_enable(pdata);
+
+	ret = gmac_request_irqs(pdata);
+	if (ret)
+		goto err_napi;
+
+	hw_ops->enable_tx(pdata);
+	hw_ops->enable_rx(pdata);
+	netif_tx_start_all_queues(netdev);
+
+	return 0;
+
+err_napi:
+	gmac_napi_disable(pdata);
+	hw_ops->exit(pdata);
+
+	return ret;
+}
+
+static void gmac_stop(struct gmac_pdata *pdata)
+{
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *netdev = pdata->netdev;
+	struct gmac_channel *channel;
+	struct netdev_queue *txq;
+	unsigned int i;
+
+	netif_tx_stop_all_queues(netdev);
+	gmac_stop_timers(pdata);
+	hw_ops->disable_tx(pdata);
+	hw_ops->disable_rx(pdata);
+	gmac_free_irqs(pdata);
+	gmac_napi_disable(pdata);
+	hw_ops->exit(pdata);
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			continue;
+
+		txq = netdev_get_tx_queue(netdev, channel->queue_index);
+		netdev_tx_reset_queue(txq);
+	}
+}
+
+static void gmac_restart_dev(struct gmac_pdata *pdata)
+{
+	/* If not running, "restart" will happen on open */
+	if (!netif_running(pdata->netdev))
+		return;
+
+	gmac_stop(pdata);
+
+	gmac_free_tx_data(pdata);
+	gmac_free_rx_data(pdata);
+
+	gmac_start(pdata);
+}
+
+static void gmac_restart(struct work_struct *work)
+{
+	struct gmac_pdata *pdata = container_of(work,
+						struct gmac_pdata,
+						restart_work);
+
+	rtnl_lock();
+
+	gmac_restart_dev(pdata);
+
+	rtnl_unlock();
+}
+
+static int gmac_open(struct net_device *netdev)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_desc_ops *desc_ops;
+	int ret;
+
+	desc_ops = &pdata->desc_ops;
+
+	/* Calculate the Rx buffer size before allocating rings */
+	ret = gmac_calc_rx_buf_size(netdev, netdev->mtu);
+	if (ret < 0)
+		return ret;
+	pdata->rx_buf_size = ret;
+
+	/* Allocate the channels and rings */
+	ret = desc_ops->alloc_channles_and_rings(pdata);
+	if (ret)
+		return ret;
+
+	INIT_WORK(&pdata->restart_work, gmac_restart);
+	gmac_init_timers(pdata);
+
+	ret = gmac_start(pdata);
+	if (ret)
+		goto err_channels_and_rings;
+
+	return 0;
+
+err_channels_and_rings:
+	desc_ops->free_channels_and_rings(pdata);
+
+	return ret;
+}
+
+static int gmac_close(struct net_device *netdev)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_desc_ops *desc_ops;
+
+	desc_ops = &pdata->desc_ops;
+
+	/* Stop the device */
+	gmac_stop(pdata);
+
+	gmac_free_tx_data(pdata);
+	gmac_free_rx_data(pdata);
+
+	/* Free the channels and rings */
+	desc_ops->free_channels_and_rings(pdata);
+
+	return 0;
+}
+
+static void gmac_tx_timeout(struct net_device *netdev)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+
+	netdev_warn(netdev, "tx timeout, device restarting\n");
+	schedule_work(&pdata->restart_work);
+}
+
+static int gmac_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_pkt_info *tx_pkt_info;
+	struct gmac_desc_ops *desc_ops;
+	struct gmac_channel *channel;
+	struct gmac_hw_ops *hw_ops;
+	struct netdev_queue *txq;
+	struct gmac_ring *ring;
+	int ret;
+
+	desc_ops = &pdata->desc_ops;
+	hw_ops = &pdata->hw_ops;
+
+	netif_dbg(pdata, tx_queued, pdata->netdev,
+		  "skb->len = %d\n", skb->len);
+
+	channel = pdata->channel_head + skb->queue_mapping;
+	txq = netdev_get_tx_queue(netdev, channel->queue_index);
+	ring = channel->tx_ring;
+	tx_pkt_info = &ring->pkt_info;
+
+	if (skb->len == 0) {
+		netif_err(pdata, tx_err, netdev,
+			  "empty skb received from stack\n");
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Prepare preliminary packet info for TX */
+	memset(tx_pkt_info, 0, sizeof(*tx_pkt_info));
+	gmac_prep_tx_pkt(pdata, ring, skb, tx_pkt_info);
+
+	/* Check that there are enough descriptors available */
+	ret = gmac_maybe_stop_tx_queue(channel,
+				       ring,
+				       tx_pkt_info->desc_count);
+	if (ret)
+		return ret;
+
+	ret = gmac_prep_tso(pdata, skb, tx_pkt_info);
+	if (ret) {
+		netif_err(pdata, tx_err, netdev,
+			  "error processing TSO packet\n");
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+	gmac_prep_vlan(skb, tx_pkt_info);
+
+	if (!desc_ops->map_tx_skb(channel, skb)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Report on the actual number of bytes (to be) sent */
+	netdev_tx_sent_queue(txq, tx_pkt_info->tx_bytes);
+
+	/* Fallback to software timestamping if
+	 * core doesn't support hardware timestamping
+	 */
+	if (pdata->hw_feat.ts_src == 0 ||
+	    pdata->hwts_tx_en == 0)
+		skb_tx_timestamp(skb);
+
+	/* Configure required descriptor fields for transmission */
+	hw_ops->dev_xmit(channel);
+
+	if (netif_msg_pktdata(pdata))
+		gmac_print_pkt(netdev, skb, true);
+
+	/* Stop the queue in advance if there may not be enough descriptors */
+	gmac_maybe_stop_tx_queue(channel, ring, GMAC_TX_MAX_DESC_NR);
+
+	return NETDEV_TX_OK;
+}
+
+static void gmac_get_stats64(struct net_device *netdev,
+			     struct rtnl_link_stats64 *s)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_stats *pstats = &pdata->stats;
+
+	pdata->hw_ops.read_mmc_stats(pdata);
+
+	s->rx_packets = pstats->rxframecount_gb;
+	s->rx_bytes = pstats->rxoctetcount_gb;
+	s->rx_errors = pstats->rxframecount_gb -
+		       pstats->rxbroadcastframes_g -
+		       pstats->rxmulticastframes_g -
+		       pstats->rxunicastframes_g;
+	s->multicast = pstats->rxmulticastframes_g;
+	s->rx_length_errors = pstats->rxlengtherror;
+	s->rx_crc_errors = pstats->rxcrcerror;
+	s->rx_fifo_errors = pstats->rxfifooverflow;
+
+	s->tx_packets = pstats->txframecount_gb;
+	s->tx_bytes = pstats->txoctetcount_gb;
+	s->tx_errors = pstats->txframecount_gb - pstats->txframecount_g;
+	s->tx_dropped = netdev->stats.tx_dropped;
+}
+
+static int gmac_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct sockaddr *saddr = addr;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	memcpy(netdev->dev_addr, saddr->sa_data, netdev->addr_len);
+
+	hw_ops->set_mac_address(pdata, netdev->dev_addr, 0);
+
+	return 0;
+}
+
+static int gmac_hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct hwtstamp_config config;
+	struct timespec64 now;
+	u64 temp = 0;
+	u32 value = 0;
+	u32 sec_inc;
+
+	if (!pdata->hw_feat.ts_src) {
+		netdev_alert(pdata->netdev, "No support for HW timestamping\n");
+		pdata->hwts_tx_en = 0;
+		pdata->hwts_rx_en = 0;
+
+		return -EOPNOTSUPP;
+	}
+
+	if (copy_from_user(&config, ifr->ifr_data,
+			   sizeof(struct hwtstamp_config)))
+		return -EFAULT;
+
+	netdev_dbg(pdata->netdev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
+		   __func__, config.flags, config.tx_type, config.rx_filter);
+
+	/* reserved for future extensions */
+	if (config.flags)
+		return -EINVAL;
+
+	if (config.tx_type != HWTSTAMP_TX_OFF &&
+	    config.tx_type != HWTSTAMP_TX_ON)
+		return -ERANGE;
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		/* time stamp no incoming packet at all */
+		config.rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+		/* PTP v1, UDP, any kind of event packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+		/* take time stamp for all event messages */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_SNAPTYPSEL_POS,
+					  PTP_TCR_SNAPTYPSEL_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+		/* PTP v1, UDP, Sync packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
+		/* take time stamp for SYNC messages only */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSEVNTENA_POS,
+					  PTP_TCR_TSEVNTENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+		/* PTP v1, UDP, Delay_req packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
+		/* take time stamp for Delay_Req messages only */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSMSTRENA_POS,
+					  PTP_TCR_TSMSTRENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSEVNTENA_POS,
+					  PTP_TCR_TSEVNTENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+		/* PTP v2, UDP, any kind of event packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSVER2ENA_POS,
+					  PTP_TCR_TSVER2ENA_LEN, 1);
+		/* take time stamp for all event messages */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_SNAPTYPSEL_POS,
+					  PTP_TCR_SNAPTYPSEL_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+		/* PTP v2, UDP, Sync packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
+
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSVER2ENA_POS,
+					  PTP_TCR_TSVER2ENA_LEN, 1);
+		/* take time stamp for SYNC messages only */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSEVNTENA_POS,
+					  PTP_TCR_TSEVNTENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		/* PTP v2, UDP, Delay_req packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
+
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSVER2ENA_POS,
+					  PTP_TCR_TSVER2ENA_LEN, 1);
+		/* take time stamp for Delay_Req messages only */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSMSTRENA_POS,
+					  PTP_TCR_TSMSTRENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSEVNTENA_POS,
+					  PTP_TCR_TSEVNTENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+		/* PTP v2/802.AS1 any layer, any kind of event packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSVER2ENA_POS,
+					  PTP_TCR_TSVER2ENA_LEN, 1);
+		/* take time stamp for all event messages */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_SNAPTYPSEL_POS,
+					  PTP_TCR_SNAPTYPSEL_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPENA_POS,
+					  PTP_TCR_TSIPENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_AV8021ASMEN_POS,
+					  PTP_TCR_AV8021ASMEN_LEN, 1);
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+		/* PTP v2/802.AS1, any layer, Sync packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
+
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSVER2ENA_POS,
+					  PTP_TCR_TSVER2ENA_LEN, 1);
+		/* take time stamp for SYNC messages only */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSEVNTENA_POS,
+					  PTP_TCR_TSEVNTENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPENA_POS,
+					  PTP_TCR_TSIPENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_AV8021ASMEN_POS,
+					  PTP_TCR_AV8021ASMEN_LEN, 1);
+		break;
+
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		/* PTP v2/802.AS1, any layer, Delay_req packet */
+		config.rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
+
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSVER2ENA_POS,
+					  PTP_TCR_TSVER2ENA_LEN, 1);
+		/* take time stamp for Delay_Req messages only */
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSMSTRENA_POS,
+					  PTP_TCR_TSMSTRENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSEVNTENA_POS,
+					  PTP_TCR_TSEVNTENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV4ENA_POS,
+					  PTP_TCR_TSIPV4ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPV6ENA_POS,
+					  PTP_TCR_TSIPV6ENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSIPENA_POS,
+					  PTP_TCR_TSIPENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_AV8021ASMEN_POS,
+					  PTP_TCR_AV8021ASMEN_LEN, 1);
+		break;
+
+	case HWTSTAMP_FILTER_ALL:
+		/* time stamp any incoming packet */
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSENALL_POS,
+					  PTP_TCR_TSENALL_LEN, 1);
+		break;
+
+	default:
+		return -ERANGE;
+	}
+	pdata->hwts_rx_en =
+		((config.rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
+	pdata->hwts_tx_en = config.tx_type == HWTSTAMP_TX_ON;
+
+	if (!pdata->hwts_tx_en && !pdata->hwts_rx_en) {
+		hw_ops->config_hw_timestamping(pdata, 0);
+	} else {
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSENA_POS,
+					  PTP_TCR_TSENA_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSCFUPDT_POS,
+					  PTP_TCR_TSCFUPDT_LEN, 1);
+		value = GMAC_SET_REG_BITS(value, PTP_TCR_TSCTRLSSR_POS,
+					  PTP_TCR_TSCTRLSSR_LEN, 1);
+		hw_ops->config_hw_timestamping(pdata, value);
+
+		/* program Sub Second Increment reg */
+		hw_ops->config_sub_second_increment(pdata,
+						    pdata->ptpclk_rate,
+						    &sec_inc);
+		temp = div_u64(1000000000, sec_inc);
+
+		/* calculate default added value:
+		 * formula is :
+		 * addend = (2^32)/freq_div_ratio;
+		 * where, freq_div_ratio = 1e9ns/sec_inc
+		 */
+		temp = (u64)(temp << 32);
+		pdata->default_addend = div_u64(temp, pdata->ptpclk_rate);
+		hw_ops->config_addend(pdata, pdata->default_addend);
+
+		/* initialize system time */
+		ktime_get_real_ts64(&now);
+
+		hw_ops->init_systime(pdata, (u32)now.tv_sec, now.tv_nsec);
+	}
+
+	return copy_to_user(ifr->ifr_data, &config,
+			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;
+}
+
+static int gmac_ioctl(struct net_device *netdev,
+		      struct ifreq *ifreq, int cmd)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (!netif_running(netdev))
+		return -ENODEV;
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP:
+		ret = gmac_hwtstamp_ioctl(netdev, ifreq);
+			break;
+	default:
+			break;
+	}
+
+	return ret;
+}
+
+static int gmac_change_mtu(struct net_device *netdev, int mtu)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	int ret;
+
+	if (netif_running(netdev)) {
+		netdev_err(netdev, "must be stopped to change its MTU\n");
+		return -EBUSY;
+	}
+
+	ret = gmac_calc_rx_buf_size(netdev, mtu);
+	if (ret < 0)
+		return ret;
+
+	pdata->rx_buf_size = ret;
+	netdev->mtu = mtu;
+
+	gmac_restart_dev(pdata);
+
+	return 0;
+}
+
+static int gmac_vlan_rx_add_vid(struct net_device *netdev,
+				__be16 proto,
+				u16 vid)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	if (pdata->hw_feat.vlhash) {
+		set_bit(vid, pdata->active_vlans);
+		hw_ops->update_vlan_hash_table(pdata);
+	} else if (pdata->vlan_weight < 4) {
+		set_bit(vid, pdata->active_vlans);
+		pdata->vlan_weight =
+			__bitmap_weight(pdata->active_vlans, VLAN_N_VID);
+		hw_ops->update_vlan(pdata);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gmac_vlan_rx_kill_vid(struct net_device *netdev,
+				 __be16 proto,
+				 u16 vid)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	clear_bit(vid, pdata->active_vlans);
+
+	if (pdata->hw_feat.vlhash)
+		hw_ops->update_vlan_hash_table(pdata);
+	else
+		hw_ops->update_vlan(pdata);
+
+	return 0;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void gmac_poll_controller(struct net_device *netdev)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_channel *channel;
+	unsigned int i;
+
+	if (pdata->per_channel_irq) {
+		channel = pdata->channel_head;
+		for (i = 0; i < pdata->channel_count; i++, channel++)
+			gmac_dma_isr(channel->dma_irq, channel);
+	} else {
+		disable_irq(pdata->dev_irq);
+		gmac_isr(pdata->dev_irq, pdata);
+		enable_irq(pdata->dev_irq);
+	}
+}
+#endif /* CONFIG_NET_POLL_CONTROLLER */
+
+static int gmac_set_features(struct net_device *netdev,
+			     netdev_features_t features)
+{
+	netdev_features_t rxcsum, rxvlan, rxvlan_filter;
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	rxcsum = pdata->netdev_features & NETIF_F_RXCSUM;
+	rxvlan = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_RX;
+	rxvlan_filter = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_FILTER;
+
+	if ((features & NETIF_F_RXCSUM) && !rxcsum)
+		hw_ops->enable_rx_csum(pdata);
+	else if (!(features & NETIF_F_RXCSUM) && rxcsum)
+		hw_ops->disable_rx_csum(pdata);
+
+	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && !rxvlan)
+		hw_ops->enable_rx_vlan_stripping(pdata);
+	else if (!(features & NETIF_F_HW_VLAN_CTAG_RX) && rxvlan)
+		hw_ops->disable_rx_vlan_stripping(pdata);
+
+	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) && !rxvlan_filter)
+		hw_ops->enable_rx_vlan_filtering(pdata);
+	else if (!(features & NETIF_F_HW_VLAN_CTAG_FILTER) && rxvlan_filter)
+		hw_ops->disable_rx_vlan_filtering(pdata);
+
+	pdata->netdev_features = features;
+
+	return 0;
+}
+
+static void gmac_set_rx_mode(struct net_device *netdev)
+{
+	struct gmac_pdata *pdata = netdev_priv(netdev);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	hw_ops->config_rx_mode(pdata);
+}
+
+static const struct net_device_ops gmac_netdev_ops = {
+	.ndo_open		= gmac_open,
+	.ndo_stop		= gmac_close,
+	.ndo_start_xmit		= gmac_xmit,
+	.ndo_tx_timeout		= gmac_tx_timeout,
+	.ndo_get_stats64	= gmac_get_stats64,
+	.ndo_change_mtu		= gmac_change_mtu,
+	.ndo_set_mac_address	= gmac_set_mac_address,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_do_ioctl		= gmac_ioctl,
+	.ndo_vlan_rx_add_vid	= gmac_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= gmac_vlan_rx_kill_vid,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= gmac_poll_controller,
+#endif
+	.ndo_set_features	= gmac_set_features,
+	.ndo_set_rx_mode	= gmac_set_rx_mode,
+};
+
+const struct net_device_ops *gmac_get_netdev_ops(void)
+{
+	return &gmac_netdev_ops;
+}
+
+static void gmac_rx_refresh(struct gmac_channel *channel)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_ring *ring = channel->rx_ring;
+	struct gmac_desc_data *desc_data;
+	struct gmac_desc_ops *desc_ops;
+	struct gmac_hw_ops *hw_ops;
+
+	desc_ops = &pdata->desc_ops;
+	hw_ops = &pdata->hw_ops;
+
+	while (ring->dirty != ring->cur) {
+		desc_data = GMAC_GET_DESC_DATA(ring, ring->dirty);
+
+		/* Reset desc_data values */
+		desc_ops->unmap_desc_data(pdata, desc_data, 0);
+
+		if (desc_ops->map_rx_buffer(pdata, ring, desc_data))
+			break;
+
+		hw_ops->rx_desc_reset(pdata, desc_data, ring->dirty);
+
+		ring->dirty++;
+	}
+
+	/* Make sure everything is written before the register write */
+	wmb();
+
+	/* Update the Rx Tail Pointer Register with address of
+	 * the last cleaned entry
+	 */
+	desc_data = GMAC_GET_DESC_DATA(ring, ring->dirty - 1);
+	GMAC_IOWRITE(pdata, DMA_CH_RDTR(channel->queue_index),
+		     lower_32_bits(desc_data->dma_desc_addr));
+}
+
+static int gmac_tx_poll(struct gmac_channel *channel)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_ring *ring = channel->tx_ring;
+	struct net_device *netdev = pdata->netdev;
+	unsigned int tx_packets = 0, tx_bytes = 0;
+	struct gmac_desc_data *desc_data;
+	struct gmac_dma_desc *dma_desc;
+	struct gmac_desc_ops *desc_ops;
+	struct gmac_hw_ops *hw_ops;
+	struct netdev_queue *txq;
+	int processed = 0;
+	unsigned int cur;
+
+	desc_ops = &pdata->desc_ops;
+	hw_ops = &pdata->hw_ops;
+
+	/* Nothing to do if there isn't a Tx ring for this channel */
+	if (!ring)
+		return 0;
+
+	cur = ring->cur;
+
+	/* Be sure we get ring->cur before accessing descriptor data */
+	smp_rmb();
+
+	txq = netdev_get_tx_queue(netdev, channel->queue_index);
+
+	while ((processed < GMAC_TX_DESC_MAX_PROC) &&
+	       (ring->dirty != cur)) {
+		desc_data = GMAC_GET_DESC_DATA(ring, ring->dirty);
+		dma_desc = desc_data->dma_desc;
+
+		if (!hw_ops->tx_complete(dma_desc))
+			break;
+
+		/* Make sure descriptor fields are read after reading
+		 * the OWN bit
+		 */
+		dma_rmb();
+
+		if (netif_msg_tx_done(pdata))
+			gmac_dump_tx_desc(pdata, ring, ring->dirty, 1, 0);
+
+		if (hw_ops->is_last_desc(dma_desc) &&
+		    !hw_ops->is_context_desc(dma_desc)) {
+			tx_packets += desc_data->trx.packets;
+			tx_bytes += desc_data->trx.bytes;
+			hw_ops->get_tx_hwtstamp(pdata, dma_desc,
+						desc_data->skb);
+		}
+
+		/* Free the SKB and reset the descriptor for re-use */
+		desc_ops->unmap_desc_data(pdata, desc_data, 1);
+		hw_ops->tx_desc_reset(desc_data);
+
+		processed++;
+		ring->dirty++;
+	}
+
+	if (!processed)
+		return 0;
+
+	netdev_tx_completed_queue(txq, tx_packets, tx_bytes);
+
+	if (ring->tx.queue_stopped == 1 &&
+	    gmac_tx_avail_desc(ring) > GMAC_TX_DESC_MIN_FREE) {
+		ring->tx.queue_stopped = 0;
+		netif_tx_wake_queue(txq);
+	}
+
+	netif_dbg(pdata, tx_done, pdata->netdev, "processed=%d\n", processed);
+
+	return processed;
+}
+
+static int gmac_rx_poll(struct gmac_channel *channel, int budget)
+{
+	struct gmac_pdata *pdata = channel->pdata;
+	struct gmac_ring *ring = channel->rx_ring;
+	struct net_device *netdev = pdata->netdev;
+	unsigned int frame_len, max_len;
+	unsigned int context_next, context;
+	struct gmac_desc_data *desc_data;
+	struct gmac_pkt_info *pkt_info;
+	unsigned int incomplete, error;
+	struct gmac_hw_ops *hw_ops;
+	unsigned int received = 0;
+	struct napi_struct *napi;
+	struct sk_buff *skb;
+	struct skb_shared_hwtstamps *shhwtstamp = NULL;
+	int packet_count = 0;
+
+	hw_ops = &pdata->hw_ops;
+
+	/* Nothing to do if there isn't a Rx ring for this channel */
+	if (!ring)
+		return 0;
+
+	incomplete = 0;
+	context_next = 0;
+
+	napi = (pdata->per_channel_irq) ? &channel->napi : &pdata->napi;
+
+	desc_data = GMAC_GET_DESC_DATA(ring, ring->cur);
+	pkt_info = &ring->pkt_info;
+	while (packet_count < budget) {
+		memset(pkt_info, 0, sizeof(*pkt_info));
+		skb = NULL;
+		error = 0;
+
+		desc_data = GMAC_GET_DESC_DATA(ring, ring->cur);
+
+		if (gmac_rx_dirty_desc(ring) > GMAC_RX_DESC_MAX_DIRTY)
+			gmac_rx_refresh(channel);
+
+		if (hw_ops->dev_read(channel))
+			break;
+
+		received++;
+		ring->cur++;
+
+		incomplete = GMAC_GET_REG_BITS(pkt_info->attributes,
+					       RX_PACKET_ATTRIBUTES_INCOMPLETE_POS,
+					       RX_PACKET_ATTRIBUTES_INCOMPLETE_LEN);
+		context = GMAC_GET_REG_BITS(pkt_info->attributes,
+					    RX_PACKET_ATTRIBUTES_CONTEXT_POS,
+					    RX_PACKET_ATTRIBUTES_CONTEXT_LEN);
+
+		if (error || pkt_info->errors || incomplete) {
+			if (pkt_info->errors)
+				netif_err(pdata, rx_err, netdev,
+					  "error in received packet\n");
+			dev_kfree_skb(skb);
+			goto next_packet;
+		}
+
+		if (!context) {
+			frame_len = desc_data->trx.bytes;
+
+			if (frame_len < GMAC_COPYBREAK_DEFAULT) {
+				skb = netdev_alloc_skb_ip_align(netdev,
+								frame_len);
+				if (unlikely(!skb)) {
+					if (net_ratelimit())
+						dev_warn(pdata->dev,
+							 "packet dropped\n");
+					pdata->netdev->stats.rx_dropped++;
+					break;
+				}
+
+				dma_sync_single_for_cpu(pdata->dev,
+							desc_data->skb_dma,
+							frame_len,
+							DMA_FROM_DEVICE);
+				skb_copy_to_linear_data(skb,
+							desc_data->skb->data,
+							frame_len);
+
+				skb_put(skb, frame_len);
+				dma_sync_single_for_device(pdata->dev,
+							   desc_data->skb_dma,
+							   frame_len,
+							   DMA_FROM_DEVICE);
+			} else {
+				skb = desc_data->skb;
+				desc_data->skb = NULL;
+				dma_unmap_single(pdata->dev,
+						 desc_data->skb_dma,
+						 pdata->rx_buf_size,
+						 DMA_FROM_DEVICE);
+				desc_data->skb_dma = 0;
+
+				skb_put(skb, frame_len);
+			}
+		}
+
+		/* Be sure we don't exceed the configured MTU */
+		max_len = netdev->mtu + ETH_HLEN;
+		if (!(netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+		    skb->protocol == htons(ETH_P_8021Q))
+			max_len += VLAN_HLEN;
+
+		if (skb->len > max_len) {
+			netif_err(pdata, rx_err, netdev,
+				  "packet length exceeds configured MTU\n");
+			dev_kfree_skb(skb);
+			goto next_packet;
+		}
+
+		if (netif_msg_pktdata(pdata))
+			gmac_print_pkt(netdev, skb, false);
+
+		skb_checksum_none_assert(skb);
+		if (GMAC_GET_REG_BITS(pkt_info->attributes,
+				      RX_PACKET_ATTRIBUTES_CSUM_DONE_POS,
+				      RX_PACKET_ATTRIBUTES_CSUM_DONE_LEN))
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (GMAC_GET_REG_BITS(pkt_info->attributes,
+				      RX_PACKET_ATTRIBUTES_VLAN_CTAG_POS,
+				      RX_PACKET_ATTRIBUTES_VLAN_CTAG_LEN)) {
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       pkt_info->vlan_ctag);
+			pdata->stats.rx_vlan_packets++;
+		}
+
+		if (GMAC_GET_REG_BITS(pkt_info->attributes,
+				      RX_PACKET_ATTRIBUTES_RX_TSTAMP_POS,
+				      RX_PACKET_ATTRIBUTES_RX_TSTAMP_LEN)) {
+			shhwtstamp = skb_hwtstamps(skb);
+			memset(shhwtstamp, 0,
+			       sizeof(struct skb_shared_hwtstamps));
+			shhwtstamp->hwtstamp =
+				ns_to_ktime(pkt_info->rx_tstamp);
+			pdata->stats.rx_timestamp_packets++;
+		}
+
+		skb->dev = netdev;
+		skb->protocol = eth_type_trans(skb, netdev);
+		skb_record_rx_queue(skb, channel->queue_index);
+
+		napi_gro_receive(napi, skb);
+
+next_packet:
+		packet_count++;
+	}
+
+	netif_dbg(pdata, rx_status, pdata->netdev,
+		  "packet_count = %d\n", packet_count);
+
+	return packet_count;
+}
+
+static int gmac_one_poll(struct napi_struct *napi, int budget)
+{
+	struct gmac_channel *channel = container_of(napi,
+						    struct gmac_channel,
+						    napi);
+	struct gmac_pdata *pdata = channel->pdata;
+	int processed = 0;
+
+	netif_dbg(pdata, intr, pdata->netdev, "budget=%d\n", budget);
+
+	/* Cleanup Tx ring first */
+	gmac_tx_poll(channel);
+
+	/* Process Rx ring next */
+	processed = gmac_rx_poll(channel, budget);
+
+	/* If we processed everything, we are done */
+	if (processed < budget) {
+		/* Turn off polling */
+		napi_complete_done(napi, processed);
+
+		/* Enable Tx and Rx interrupts */
+		enable_irq(channel->dma_irq);
+	}
+
+	netif_dbg(pdata, intr, pdata->netdev, "received = %d\n", processed);
+
+	return processed;
+}
+
+static int gmac_all_poll(struct napi_struct *napi, int budget)
+{
+	struct gmac_pdata *pdata = container_of(napi,
+						struct gmac_pdata,
+						napi);
+	struct gmac_channel *channel;
+	int processed, last_processed;
+	int ring_budget;
+	unsigned int i;
+
+	netif_dbg(pdata, intr, pdata->netdev, "budget=%d\n", budget);
+
+	processed = 0;
+	ring_budget = budget / pdata->rx_ring_count;
+	do {
+		last_processed = processed;
+
+		channel = pdata->channel_head;
+		for (i = 0; i < pdata->channel_count; i++, channel++) {
+			/* Cleanup Tx ring first */
+			gmac_tx_poll(channel);
+
+			/* Process Rx ring next */
+			if (ring_budget > (budget - processed))
+				ring_budget = budget - processed;
+			processed += gmac_rx_poll(channel, ring_budget);
+		}
+	} while ((processed < budget) && (processed != last_processed));
+
+	/* If we processed everything, we are done */
+	if (processed < budget) {
+		/* Turn off polling */
+		napi_complete_done(napi, processed);
+
+		/* Enable Tx and Rx interrupts */
+		gmac_enable_rx_tx_ints(pdata);
+	}
+
+	netif_dbg(pdata, intr, pdata->netdev, "received = %d\n", processed);
+
+	return processed;
+}
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-ptp.c b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-ptp.c
new file mode 100644
index 0000000..e74154c
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-ptp.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include "mtk-gmac.h"
+
+static int gmac_adjust_freq(struct ptp_clock_info *ptp, s32 ppb)
+{
+	struct gmac_pdata *pdata =
+		container_of(ptp, struct gmac_pdata, ptp_clock_info);
+	unsigned long adj, diff, freq_top;
+	int neg_adj = 0;
+
+	if (ppb < 0) {
+		neg_adj = 1;
+		ppb = -ppb;
+	}
+
+	freq_top = pdata->ptptop_rate;
+	adj = freq_top;
+	adj *= ppb;
+	/* div_u64 will divided the "adj" by "1000000000ULL"
+	 * and return the quotient.
+	 */
+	diff = div_u64(adj, 1000000000ULL);
+	freq_top = neg_adj ? (freq_top - diff) : (freq_top + diff);
+
+	clk_set_rate(pdata->plat->clks[GMAC_CLK_PTP_TOP], freq_top);
+
+	return 0;
+}
+
+static int gmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct gmac_pdata *pdata =
+		container_of(ptp, struct gmac_pdata, ptp_clock_info);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	unsigned long flags;
+	u32 sec, nsec, quotient, reminder;
+	int neg_adj = 0;
+
+	if (delta < 0) {
+		neg_adj = 1;
+		delta = -delta;
+	}
+
+	quotient = div_u64_rem(delta, 1000000000ULL, &reminder);
+	sec = quotient;
+	nsec = reminder;
+
+	spin_lock_irqsave(&pdata->ptp_lock, flags);
+
+	hw_ops->adjust_systime(pdata, sec, nsec, neg_adj);
+
+	spin_unlock_irqrestore(&pdata->ptp_lock, flags);
+
+	return 0;
+}
+
+static int gmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
+{
+	struct gmac_pdata *pdata =
+		container_of(ptp, struct gmac_pdata, ptp_clock_info);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	u64 ns;
+	u32 reminder;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->ptp_lock, flags);
+
+	hw_ops->get_systime(pdata, &ns);
+
+	spin_unlock_irqrestore(&pdata->ptp_lock, flags);
+
+	ts->tv_sec = div_u64_rem(ns, 1000000000ULL, &reminder);
+	ts->tv_nsec = reminder;
+
+	return 0;
+}
+
+static int gmac_set_time(struct ptp_clock_info *ptp,
+			 const struct timespec64 *ts)
+{
+	struct gmac_pdata *pdata =
+		container_of(ptp, struct gmac_pdata, ptp_clock_info);
+	struct gmac_hw_ops *hw_ops = &pdata->hw_ops;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->ptp_lock, flags);
+
+	hw_ops->init_systime(pdata, ts->tv_sec, ts->tv_nsec);
+
+	spin_unlock_irqrestore(&pdata->ptp_lock, flags);
+
+	return 0;
+}
+
+static int gmac_enable(struct ptp_clock_info *ptp,
+		       struct ptp_clock_request *rq,
+		       int on)
+{
+	return -EOPNOTSUPP;
+}
+
+int ptp_init(struct gmac_pdata *pdata)
+{
+	struct ptp_clock_info *info = &pdata->ptp_clock_info;
+	struct ptp_clock *clock;
+	int ret = 0;
+
+	if (!pdata->hw_feat.ts_src) {
+		pdata->ptp_clock = NULL;
+		pr_err("No PTP supports in HW\n"
+			"Aborting PTP clock driver registration\n");
+		return -EOPNOTSUPP;
+	}
+
+	spin_lock_init(&pdata->ptp_lock);
+
+	pdata->ptpclk_rate = clk_get_rate(pdata->plat->clks[GMAC_CLK_PTP]);
+	pdata->ptptop_rate = clk_get_rate(pdata->plat->clks[GMAC_CLK_PTP_TOP]);
+	pdata->ptp_divider = pdata->ptptop_rate / pdata->ptpclk_rate;
+
+	snprintf(info->name, sizeof(info->name), "%s",
+		 netdev_name(pdata->netdev));
+	info->owner = THIS_MODULE;
+	info->max_adj = pdata->ptpclk_rate;
+	info->adjfreq = gmac_adjust_freq;
+	info->adjtime = gmac_adjust_time;
+	info->gettime64 = gmac_get_time;
+	info->settime64 = gmac_set_time;
+	info->enable = gmac_enable;
+
+	clock = ptp_clock_register(info, pdata->dev);
+	if (IS_ERR(clock)) {
+		pdata->ptp_clock = NULL;
+		netdev_err(pdata->netdev, "ptp_clock_register() failed\n");
+	} else {
+		pdata->ptp_clock = clock;
+		netdev_info(pdata->netdev, "Added PTP HW clock successfully\n");
+	}
+
+	return ret;
+}
+
+void ptp_remove(struct gmac_pdata *pdata)
+{
+	if (pdata->ptp_clock) {
+		ptp_clock_unregister(pdata->ptp_clock);
+		pdata->ptp_clock = NULL;
+		pr_debug("Removed PTP HW clock successfully on %s\n",
+			 pdata->netdev->name);
+	}
+}
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac-reg.h b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-reg.h
new file mode 100644
index 0000000..2e462dc
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac-reg.h
@@ -0,0 +1,861 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+#ifndef __MTK_GMAC_REG_H__
+#define __MTK_GMAC_REG_H__
+
+/* Macros for reading or writing registers
+ *  The ioread macros will get bit fields or full values using the
+ *  register definitions formed using the input names
+ *
+ *  The iowrite macros will set bit fields or full values using the
+ *  register definitions formed using the input names
+ */
+#define GMAC_IOREAD(_pdata, _reg)					\
+	ioread32((_pdata)->mac_regs + (_reg))
+
+#define GMAC_IOWRITE(_pdata, _reg, _val)				\
+	iowrite32((_val), (_pdata)->mac_regs + (_reg))
+
+#define GMAC_GET_REG_BITS(var, pos, len) ({				\
+	typeof(pos) _pos = (pos);					\
+	typeof(len) _len = (len);					\
+	((var) & GENMASK(_pos + _len - 1, _pos)) >> (_pos);		\
+})
+
+#define GMAC_SET_REG_BITS(var, pos, len, val) ({			\
+	typeof(var) _var = (var);					\
+	typeof(pos) _pos = (pos);					\
+	typeof(len) _len = (len);					\
+	typeof(val) _val = (val);					\
+	_val = (_val << _pos) & GENMASK(_pos + _len - 1, _pos);		\
+	_var = (_var & ~GENMASK(_pos + _len - 1, _pos)) | _val;		\
+})
+
+enum dma_irq_status {
+	tx_hard_error = 0x1,
+	tx_hard_error_bump_tc = 0x2,
+	handle_rx = 0x4,
+	handle_tx = 0x8,
+};
+
+enum rx_dma_dbg_state {
+	rx_stopped = 0x0,
+	rx_running_fetching = 0x1,
+	rx_running_waiting = 0x3,
+	rx_suspended = 0x4,
+	rx_running_closing = 0x5,
+	rx_timestamp_write = 0x6,
+	rx_running_transfer = 0x7,
+};
+
+enum tx_dma_dbg_state {
+	tx_stopped = 0x0,
+	tx_running_fetching = 0x1,
+	tx_running_waiting = 0x2,
+	tx_running_queuing = 0x3,
+	tx_timestamp_write = 0x4,
+	tx_suspended = 0x6,
+	tx_running_closing = 0x7,
+};
+
+/* MAC register offsets */
+#define MAC_MCR				0x0000
+#define MAC_PFR				0x0008
+#define MAC_HTR(x)			(0x0010 + (x) * 4)
+#define MAC_VLANTR			0x0050
+#define MAC_VLANTFR			0x0054
+#define MAC_VLANHTR			0x0058
+#define MAC_VLANIR			0x0060
+#define MAC_Q_TFCR(x)			(0x70 + (x) * 4)
+#define MAC_RFCR			0x0090
+#define MAC_RQC0R			0x00a0
+#define MAC_RQC1R			0x00a4
+#define MAC_RQC2R			0x00a8
+#define MAC_RQC3R			0x00ac
+#define MAC_ISR				0x00b0
+#define MAC_IER				0x00b4
+#define MAC_PCSR			0x00f8
+#define MAC_VR				0x0110
+#define MAC_HWF0R			0x011c
+#define MAC_HWF1R			0x0120
+#define MAC_HWF2R			0x0124
+#define MAC_MDIOAR			0x0200
+#define MAC_MDIODR			0x0204
+#define MAC_ADDR_HR(x)			(0x0300 + (x) * 8)
+#define MAC_ADDR_LR(x)			(0x0304 + (x) * 8)
+
+/* MAC register entry bit positions and sizes */
+#define MAC_ADDR_HR_AE_POS		31
+#define MAC_ADDR_HR_AE_LEN		1
+#define MAC_HW_FEAT_ACTPHYSEL_POS	28
+#define MAC_HW_FEAT_ACTPHYSEL_LEN	3
+#define MAC_HW_FEAT_SAVLANINS_POS	27
+#define MAC_HW_FEAT_SAVLANINS_LEN	1
+#define MAC_HW_FEAT_TSSTSSEL_POS	25
+#define MAC_HW_FEAT_TSSTSSEL_LEN	2
+#define MAC_HW_FEAT_ADDMAC_POS		18
+#define MAC_HW_FEAT_ADDMAC_LEN		7
+#define MAC_HW_FEAT_RXCOESEL_POS	16
+#define MAC_HW_FEAT_RXCOESEL_LEN	1
+#define MAC_HW_FEAT_TXCOSEL_POS		14
+#define MAC_HW_FEAT_TXCOSEL_LEN		1
+#define MAC_HW_FEAT_EEESEL_POS		13
+#define MAC_HW_FEAT_EEESEL_LEN		1
+#define MAC_HW_FEAT_TSSEL_POS		12
+#define MAC_HW_FEAT_TSSEL_LEN		1
+#define MAC_HW_FEAT_ARPOFFSEL_POS	9
+#define MAC_HW_FEAT_ARPOFFSEL_LEN	1
+#define MAC_HW_FEAT_MMCSEL_POS		8
+#define MAC_HW_FEAT_MMCSEL_LEN		1
+#define MAC_HW_FEAT_MGKSEL_POS		7
+#define MAC_HW_FEAT_MGKSEL_LEN		1
+#define MAC_HW_FEAT_RWKSEL_POS		6
+#define MAC_HW_FEAT_RWKSEL_LEN		1
+#define MAC_HW_FEAT_SMASEL_POS		5
+#define MAC_HW_FEAT_SMASEL_LEN		1
+#define MAC_HW_FEAT_VLHASH_POS		4
+#define MAC_HW_FEAT_VLHASH_LEN		1
+#define MAC_HW_FEAT_PCSSEL_POS		3
+#define MAC_HW_FEAT_PCSSEL_LEN		1
+#define MAC_HW_FEAT_HDSEL_POS		2
+#define MAC_HW_FEAT_HDSEL_LEN		1
+#define MAC_HW_FEAT_GMIISEL_POS		1
+#define MAC_HW_FEAT_GMIISEL_LEN		1
+#define MAC_HW_FEAT_MIISEL_POS		0
+#define MAC_HW_FEAT_MIISEL_LEN		1
+#define MAC_HW_L3L4FNUM_POS		27
+#define MAC_HW_L3L4FNUM_LEN		4
+#define MAC_HW_HASHTBLSZ_POS		24
+#define MAC_HW_HASHTBLSZ_LEN		2
+#define MAC_HW_POUOST_POS		23
+#define MAC_HW_POUOST_LEN		1
+#define MAC_HW_RAV_POS			21
+#define MAC_HW_RAV_LEN			1
+#define MAC_HW_AV_POS			20
+#define MAC_HW_AV_LEN			1
+#define MAC_HW_DMADEBUGEN_POS		19
+#define MAC_HW_DMADEBUGEN_LEN		1
+#define MAC_HW_TSOEN_POS		18
+#define MAC_HW_TSOEN_LEN		1
+#define MAC_HW_SPHEN_POS		17
+#define MAC_HW_SPHEN_LEN		1
+#define MAC_HW_DCBEN_POS		16
+#define MAC_HW_DCBEN_LEN		1
+#define MAC_HW_ADDR64_POS		14
+#define MAC_HW_ADDR64_LEN		2
+#define MAC_HW_ADVTHWORD_POS		13
+#define MAC_HW_ADVTHWORD_LEN		1
+#define MAC_HW_PTOEN_POS		12
+#define MAC_HW_PTOEN_LEN		1
+#define MAC_HW_OSTEN_POS		11
+#define MAC_HW_OSTEN_LEN		1
+#define MAC_HW_TXFIFOSIZE_POS		6
+#define MAC_HW_TXFIFOSIZE_LEN		5
+#define MAC_HW_RXFIFOSIZE_POS		0
+#define MAC_HW_RXFIFOSIZE_LEN		5
+#define MAC_HW_FEAT_AUXSNAPNUM_POS	28
+#define MAC_HW_FEAT_AUXSNAPNUM_LEN	3
+#define MAC_HW_FEAT_PPSOUTNUM_POS	24
+#define MAC_HW_FEAT_PPSOUTNUM_LEN	3
+#define MAC_HW_FEAT_TXCHCNT_POS		18
+#define MAC_HW_FEAT_TXCHCNT_LEN		4
+#define MAC_HW_FEAT_RXCHCNT_POS		12
+#define MAC_HW_FEAT_RXCHCNT_LEN		4
+#define MAC_HW_FEAT_TXQCNT_POS		6
+#define MAC_HW_FEAT_TXQCNT_LEN		4
+#define MAC_HW_FEAT_RXQCNT_POS		0
+#define MAC_HW_FEAT_RXQCNT_LEN		4
+#define MAC_IER_RGMII_POS		0
+#define MAC_IER_RGMII_LEN		1
+#define MAC_ISR_MMCRXIS_POS		9
+#define MAC_ISR_MMCRXIS_LEN		1
+#define MAC_ISR_MMCTXIS_POS		10
+#define MAC_ISR_MMCTXIS_LEN		1
+#define MAC_ISR_MMCRXIPIS_POS		11
+#define MAC_ISR_MMCRXIPIS_LEN		1
+#define MAC_ISR_RGSMIIS_POS		0
+#define MAC_ISR_RGSMIIS_LEN		1
+#define MAC_MDIOAR_GB_POS		0
+#define MAC_MDIOAR_GB_LEN		1
+#define MAC_MDIOAR_C45E_POS		1
+#define MAC_MDIOAR_C45E_LEN		1
+#define MAC_MDIOAR_GOC_POS		2
+#define MAC_MDIOAR_GOC_LEN		2
+#define MAC_MDIOAR_CR_POS		8
+#define MAC_MDIOAR_CR_LEN		4
+#define MAC_MDIOAR_RDA_POS		16
+#define MAC_MDIOAR_RDA_LEN		5
+#define MAC_MDIOAR_PA_POS		21
+#define MAC_MDIOAR_PA_LEN		5
+#define MAC_MDIODR_GD_POS		0
+#define MAC_MDIODR_GD_LEN		16
+#define MAC_MDIODR_RA_POS		16
+#define MAC_MDIODR_RA_LEN		16
+#define MAC_MCR_ACS_POS			20
+#define MAC_MCR_ACS_LEN			1
+#define MAC_MCR_CST_POS			21
+#define MAC_MCR_CST_LEN			1
+#define MAC_MCR_IPC_POS			27
+#define MAC_MCR_IPC_LEN			1
+#define MAC_MCR_JE_POS			16
+#define MAC_MCR_JE_LEN			1
+#define MAC_MCR_LM_POS			12
+#define MAC_MCR_LM_LEN			1
+#define MAC_MCR_SS_POS			14
+#define MAC_MCR_SS_LEN			2
+#define MAC_MCR_DM_POS			13
+#define MAC_MCR_DM_LEN			2
+#define MAC_MCR_TE_POS			1
+#define MAC_MCR_TE_LEN			1
+#define MAC_MCR_RE_POS			0
+#define MAC_MCR_RE_LEN			1
+#define MAC_PFR_HMC_POS			2
+#define MAC_PFR_HMC_LEN			1
+#define MAC_PFR_HPF_POS			10
+#define MAC_PFR_HPF_LEN			1
+#define MAC_PFR_HUC_POS			1
+#define MAC_PFR_HUC_LEN			1
+#define MAC_PFR_PM_POS			4
+#define MAC_PFR_PM_LEN			1
+#define MAC_PFR_PR_POS			0
+#define MAC_PFR_PR_LEN			1
+#define MAC_PFR_VTFE_POS		16
+#define MAC_PFR_VTFE_LEN		1
+#define MAC_QTFCR_PT_POS		16
+#define MAC_QTFCR_PT_LEN		16
+#define MAC_QTFCR_TFE_POS		1
+#define MAC_QTFCR_TFE_LEN		1
+#define MAC_RFCR_RFE_POS		0
+#define MAC_RFCR_RFE_LEN		1
+#define MAC_RGMII_LNKSTS_POS		19
+#define MAC_RGMII_LNKSTS_LEN		1
+#define MAC_RGMII_SPEED_POS		17
+#define MAC_RGMII_SPEED_LEN		2
+#define MAC_RGMII_LNKMODE_POS		16
+#define MAC_RGMII_LNKMODE_LEN		1
+#define MAC_VLANHTR_VLHT_POS		0
+#define MAC_VLANHTR_VLHT_LEN		16
+#define MAC_VLANIR_VLTI_POS		20
+#define MAC_VLANIR_VLTI_LEN		1
+#define MAC_VLANIR_CSVL_POS		19
+#define MAC_VLANIR_CSVL_LEN		1
+#define MAC_VLANTR_EVLRXS_POS		24
+#define MAC_VLANTR_EVLRXS_LEN		1
+#define MAC_VLANTR_EVLS_POS		21
+#define MAC_VLANTR_EVLS_LEN		2
+#define MAC_VLANTR_DOVLTC_POS		20
+#define MAC_VLANTR_DOVLTC_LEN		1
+#define MAC_VLANTR_ERSVLM_POS		19
+#define MAC_VLANTR_ERSVLM_LEN		1
+#define MAC_VLANTR_ESVL_POS		18
+#define MAC_VLANTR_ESVL_LEN		1
+#define MAC_VLANTR_ETV_POS		16
+#define MAC_VLANTR_ETV_LEN		1
+#define MAC_VLANTR_VL_POS		0
+#define MAC_VLANTR_VL_LEN		16
+#define MAC_VLANTR_VTHM_POS		25
+#define MAC_VLANTR_VTHM_LEN		1
+#define MAC_VLANTR_VTIM_POS		17
+#define MAC_VLANTR_VTIM_LEN		1
+/* For HASH VLAN DISABLE */
+#define MAC_VLANTR_OFS_POS		2
+#define MAC_VLANTR_OFS_LEN		2
+#define MAC_VLANTR_CT_POS		1
+#define MAC_VLANTR_CT_LEN		1
+#define MAC_VLANTR_OB_POS		0
+#define MAC_VLANTR_OB_LEN		1
+#define MAC_VLANTFR_VEN_POS		16
+#define MAC_VLANTFR_VEN_LEN		1
+#define MAC_VLANTFR_VID_POS		0
+#define MAC_VLANTFR_VID_LEN		16
+#define MAC_VR_SNPSVER_POS		0
+#define MAC_VR_SNPSVER_LEN		8
+#define MAC_VR_USERVER_POS		8
+#define MAC_VR_USERVER_LEN		8
+
+/* MAC register value */
+#define GMAC_RGSMIIIS_SPEED_125		2
+#define GMAC_RGSMIIIS_SPEED_25		1
+#define GMAC_RGSMIIIS_SPEED_2_5		0
+
+/* MMC register offsets */
+/* Note:
+ * _GB register stands for good and bad frames
+ * _G is for good only.
+ */
+#define MMC_CR				0x0700
+#define MMC_RISR			0x0704
+#define MMC_TISR			0x0708
+#define MMC_RIER			0x070c
+#define MMC_TIER			0x0710
+#define MMC_IPCER			0x0800
+#define MMC_IPCSR			0x0808
+#define MMC_TXOCTETCOUNT_GB		0x714
+#define MMC_TXPACKETCOUNT_GB		0x718
+#define MMC_TXBROADCASTFRAMES_G		0x71c
+#define MMC_TXMULTICASTFRAMES_G		0x720
+#define MMC_TX64OCTETS_GB		0x724
+#define MMC_TX65TO127OCTETS_GB		0x728
+#define MMC_TX128TO255OCTETS_GB		0x72c
+#define MMC_TX256TO511OCTETS_GB		0x730
+#define MMC_TX512TO1023OCTETS_GB	0x734
+#define MMC_TX1024TOMAXOCTETS_GB	0x738
+#define MMC_TXUNICASTFRAMES_GB		0x73c
+#define MMC_TXMULTICASTFRAMES_GB	0x740
+#define MMC_TXBROADCASTFRAMES_GB	0x744
+#define MMC_TXUNDERFLOWERROR		0x748
+#define MMC_TXSINGLECOL_G		0x74c
+#define MMC_TXMULTICOL_G		0x750
+#define MMC_TXDEFERRED			0x754
+#define MMC_TXLATECOL			0x758
+#define MMC_TXEXESSCOL			0x75c
+#define MMC_TXCARRIERERROR		0x760
+#define MMC_TXOCTETCOUNT_G		0x764
+#define MMC_TXPACKETSCOUNT_G		0x768
+#define MMC_TXEXCESSDEF			0x76c
+#define MMC_TXPAUSEFRAMES		0x770
+#define MMC_TXVLANFRAMES_G		0x774
+#define MMC_TXOVERSIZE_G		0x778
+#define MMC_RXPACKETCOUNT_GB		0x780
+#define MMC_RXOCTETCOUNT_GB		0x784
+#define MMC_RXOCTETCOUNT_G		0x788
+#define MMC_RXBROADCASTFRAMES_G		0x78c
+#define MMC_RXMULTICASTFRAMES_G		0x790
+#define MMC_RXCRCERROR			0x794
+#define MMC_RXALIGNMENTERROR		0x798
+#define MMC_RXRUNTERROR			0x79c
+#define MMC_RXJABBERERROR		0x7a0
+#define MMC_RXUNDERSIZE_G		0x7a4
+#define MMC_RXOVERSIZE_G		0x7a8
+#define MMC_RX64OCTETS_GB		0x7ac
+#define MMC_RX65TO127OCTETS_GB		0x7b0
+#define MMC_RX128TO255OCTETS_GB		0x7b4
+#define MMC_RX256TO511OCTETS_GB		0x7b8
+#define MMC_RX512TO1023OCTETS_GB	0x7bc
+#define MMC_RX1024TOMAXOCTETS_GB	0x7c0
+#define MMC_RXUNICASTFRAMES_G		0x7c4
+#define MMC_RXLENGTHERROR		0x7c8
+#define MMC_RXOUTOFRANGETYPE		0x7cc
+#define MMC_RXPAUSEFRAMES		0x7d0
+#define MMC_RXFIFOOVERFLOW		0x7d4
+#define MMC_RXVLANFRAMES_GB		0x7d8
+#define MMC_RXWATCHDOGERROR		0x7dc
+#define MMC_RXRCVERROR			0x7e0
+#define MMC_RXCTRLFRAMES_G		0x7e4
+#define MMC_TXLPIUSEC			0x7ec
+#define MMC_TXLPITRAN			0x7f0
+#define MMC_RXLPIUSEC			0x7f4
+#define MMC_RXLPITRAN			0x7f8
+#define MMC_RXIPV4GDPKTS		0x810
+#define MMC_RXIPV4HDRERRPKTS		0x814
+#define MMC_RXIPV4NOPAYPKTS		0x818
+#define MMC_RXIPV4FRAGPKTS		0x81c
+#define MMC_RXIPV4UBSBLPKTS		0x820
+#define MMC_RXIPV6GDPKTS		0x824
+#define MMC_RXIPV6HDRERRPKTS		0x828
+#define MMC_RXIPV6NOPAYPKTS		0x82c
+#define MMC_RXUDPGDPKTS			0x830
+#define MMC_RXUDPERRPKTS		0x834
+#define MMC_RXTCPGDPKTS			0x838
+#define MMC_RXTCPERRPKTS		0x83c
+#define MMC_RXICMPGDPKTS		0x840
+#define MMC_RXICMPERRPKTS		0x844
+#define MMC_RXIPV4GDOCTETS		0x850
+#define MMC_RXIPV4HDRERROCTETS		0x854
+#define MMC_RXIPV4NOPAYOCTETS		0x858
+#define MMC_RXIPV4FRAGOCTETS		0x85c
+#define MMC_RXIPV4UDSBLOCTETS		0x860
+#define MMC_RXIPV6GDOCTETS		0x864
+#define MMC_RXIPV6HDRERROCTETS		0x868
+#define MMC_RXIPV6NOPAYOCTETS		0x86c
+#define MMC_RXUDPGDOCTETS		0x870
+#define MMC_RXUDPERROCTETS		0x874
+#define MMC_RXTCPGDOCTETS		0x878
+#define MMC_RXTCPERROCTETS		0x87c
+#define MMC_RXICMPGDOCTETS		0x880
+#define MMC_RXICMPERROCTETS		0x884
+
+/* MMC register entry bit positions and sizes */
+#define MMC_CR_MCF_POS				3
+#define MMC_CR_MCF_LEN				1
+#define MMC_CR_ROR_POS				2
+#define MMC_CR_ROR_LEN				1
+#define MMC_CR_CR_POS				0
+#define MMC_CR_CR_LEN				1
+#define MMC_IPCSR_RXICMPERROCTETS_POS		29
+#define MMC_IPCSR_RXICMPERROCTETS_LEN		1
+#define MMC_IPCSR_RXICMPGDOCTETS_POS		28
+#define MMC_IPCSR_RXICMPGDOCTETS_LEN		1
+#define MMC_IPCSR_RXTCPERROCTETS_POS		27
+#define MMC_IPCSR_RXTCPERROCTETS_LEN		1
+#define MMC_IPCSR_RXTCPGDOCTETS_POS		26
+#define MMC_IPCSR_RXTCPGDOCTETS_LEN		1
+#define MMC_IPCSR_RXUDPERROCTETS_POS		25
+#define MMC_IPCSR_RXUDPERROCTETS_LEN		1
+#define MMC_IPCSR_RXUDPGDOCTETS_POS		24
+#define MMC_IPCSR_RXUDPGDOCTETS_LEN		1
+#define MMC_IPCSR_RXIPV6NOPAYOCTETS_POS		23
+#define MMC_IPCSR_RXIPV6NOPAYOCTETS_LEN		1
+#define MMC_IPCSR_RXIPV6HDRERROCTETS_POS	22
+#define MMC_IPCSR_RXIPV6HDRERROCTETS_LEN	1
+#define MMC_IPCSR_RXIPV6GDOCTETS_POS		21
+#define MMC_IPCSR_RXIPV6GDOCTETS_LEN		1
+#define MMC_IPCSR_RXIPV4UDSBLOCTETS_POS		20
+#define MMC_IPCSR_RXIPV4UDSBLOCTETS_LEN		1
+#define MMC_IPCSR_RXIPV4FRAGOCTETS_POS		19
+#define MMC_IPCSR_RXIPV4FRAGOCTETS_LEN		1
+#define MMC_IPCSR_RXIPV4NOPAYOCTETS_POS		18
+#define MMC_IPCSR_RXIPV4NOPAYOCTETS_LEN		1
+#define MMC_IPCSR_RXIPV4HDRERROCTETS_POS	17
+#define MMC_IPCSR_RXIPV4HDRERROCTETS_LEN	1
+#define MMC_IPCSR_RXIPV4GDOCTETS_POS		16
+#define MMC_IPCSR_RXIPV4GDOCTETS_LEN		1
+#define MMC_IPCSR_RXICMPERRPKTS_POS		13
+#define MMC_IPCSR_RXICMPERRPKTS_LEN		1
+#define MMC_IPCSR_RXICMPGDPKTS_POS		12
+#define MMC_IPCSR_RXICMPGDPKTS_LEN		1
+#define MMC_IPCSR_RXTCPERRPKTS_POS		11
+#define MMC_IPCSR_RXTCPERRPKTS_LEN		1
+#define MMC_IPCSR_RXTCPGDPKTS_POS		10
+#define MMC_IPCSR_RXTCPGDPKTS_LEN		1
+#define MMC_IPCSR_RXUDPERRPKTS_POS		9
+#define MMC_IPCSR_RXUDPERRPKTS_LEN		1
+#define MMC_IPCSR_RXUDPGDPKTS_POS		8
+#define MMC_IPCSR_RXUDPGDPKTS_LEN		1
+#define MMC_IPCSR_RXIPV6NOPAYPKTS_POS		7
+#define MMC_IPCSR_RXIPV6NOPAYPKTS_LEN		1
+#define MMC_IPCSR_RXIPV6HDRERRPKTS_POS		6
+#define MMC_IPCSR_RXIPV6HDRERRPKTS_LEN		1
+#define MMC_IPCSR_RXIPV6GDPKTS_POS		5
+#define MMC_IPCSR_RXIPV6GDPKTS_LEN		1
+#define MMC_IPCSR_RXIPV4UBSBLPKTS_POS		4
+#define MMC_IPCSR_RXIPV4UBSBLPKTS_LEN		1
+#define MMC_IPCSR_RXIPV4FRAGPKTS_POS		3
+#define MMC_IPCSR_RXIPV4FRAGPKTS_LEN		1
+#define MMC_IPCSR_RXIPV4NOPAYPKTS_POS		2
+#define MMC_IPCSR_RXIPV4NOPAYPKTS_LEN		1
+#define MMC_IPCSR_RXIPV4HDRERRPKTS_POS		1
+#define MMC_IPCSR_RXIPV4HDRERRPKTS_LEN		1
+#define MMC_IPCSR_RXIPV4GDPKTS_POS		0
+#define MMC_IPCSR_RXIPV4GDPKTS_LEN		1
+#define MMC_RISR_RXLPITRAN_POS			27
+#define MMC_RISR_RXLPITRAN_LEN			1
+#define MMC_RISR_RXLPIUSEC_POS			26
+#define MMC_RISR_RXLPIUSEC_LEN			1
+#define MMC_RISR_RXCTRLFRAMES_POS		25
+#define MMC_RISR_RXCTRLFRAMES_LEN		1
+#define MMC_RISR_RXRCVERROR_POS			24
+#define MMC_RISR_RXRCVERROR_LEN			1
+#define MMC_RISR_RXWATCHDOGERROR_POS		23
+#define MMC_RISR_RXWATCHDOGERROR_LEN		1
+#define MMC_RISR_RXVLANFRAMES_GB_POS		22
+#define MMC_RISR_RXVLANFRAMES_GB_LEN		1
+#define MMC_RISR_RXFIFOOVERFLOW_POS		21
+#define MMC_RISR_RXFIFOOVERFLOW_LEN		1
+#define MMC_RISR_RXPAUSEFRAMES_POS		20
+#define MMC_RISR_RXPAUSEFRAMES_LEN		1
+#define MMC_RISR_RXOUTOFRANGETYPE_POS		19
+#define MMC_RISR_RXOUTOFRANGETYPE_LEN		1
+#define MMC_RISR_RXLENGTHERROR_POS		18
+#define MMC_RISR_RXLENGTHERROR_LEN		1
+#define MMC_RISR_RXUNICASTFRAMES_G_POS		17
+#define MMC_RISR_RXUNICASTFRAMES_G_LEN		1
+#define MMC_RISR_RX1024TOMAXOCTETS_GB_POS	16
+#define MMC_RISR_RX1024TOMAXOCTETS_GB_LEN	1
+#define MMC_RISR_RX512TO1023OCTETS_GB_POS	15
+#define MMC_RISR_RX512TO1023OCTETS_GB_LEN	1
+#define MMC_RISR_RX256TO511OCTETS_GB_POS	14
+#define MMC_RISR_RX256TO511OCTETS_GB_LEN	1
+#define MMC_RISR_RX128TO255OCTETS_GB_POS	13
+#define MMC_RISR_RX128TO255OCTETS_GB_LEN	1
+#define MMC_RISR_RX65TO127OCTETS_GB_POS		12
+#define MMC_RISR_RX65TO127OCTETS_GB_LEN		1
+#define MMC_RISR_RX64OCTETS_GB_POS		11
+#define MMC_RISR_RX64OCTETS_GB_LEN		1
+#define MMC_RISR_RXOVERSIZE_G_POS		10
+#define MMC_RISR_RXOVERSIZE_G_LEN		1
+#define MMC_RISR_RXUNDERSIZE_G_POS		9
+#define MMC_RISR_RXUNDERSIZE_G_LEN		1
+#define MMC_RISR_RXJABBERERROR_POS		8
+#define MMC_RISR_RXJABBERERROR_LEN		1
+#define MMC_RISR_RXRUNTERROR_POS		7
+#define MMC_RISR_RXRUNTERROR_LEN		1
+#define MMC_RISR_RXALIGNMENTERROR_POS		6
+#define MMC_RISR_RXALIGNMENTERROR_LEN		1
+#define MMC_RISR_RXCRCERROR_POS			5
+#define MMC_RISR_RXCRCERROR_LEN			1
+#define MMC_RISR_RXMULTICASTFRAMES_G_POS	4
+#define MMC_RISR_RXMULTICASTFRAMES_G_LEN	1
+#define MMC_RISR_RXBROADCASTFRAMES_G_POS	3
+#define MMC_RISR_RXBROADCASTFRAMES_G_LEN	1
+#define MMC_RISR_RXOCTETCOUNT_G_POS		2
+#define MMC_RISR_RXOCTETCOUNT_G_LEN		1
+#define MMC_RISR_RXOCTETCOUNT_GB_POS		1
+#define MMC_RISR_RXOCTETCOUNT_GB_LEN		1
+#define MMC_RISR_RXFRAMECOUNT_GB_POS		0
+#define MMC_RISR_RXFRAMECOUNT_GB_LEN		1
+#define MMC_TISR_TXLPITRAN_POS			27
+#define MMC_TISR_TXLPITRAN_LEN			1
+#define MMC_TISR_TXLPIUSEC_POS			26
+#define MMC_TISR_TXLPIUSEC_LEN			1
+#define MMC_TISR_TXOVERSIZE_G_POS		25
+#define MMC_TISR_TXOVERSIZE_G_LEN		1
+#define MMC_TISR_TXVLANFRAMES_G_POS		24
+#define MMC_TISR_TXVLANFRAMES_G_LEN		1
+#define MMC_TISR_TXPAUSEFRAMES_POS		23
+#define MMC_TISR_TXPAUSEFRAMES_LEN		1
+#define MMC_TISR_TXEXCESSDEF_POS		22
+#define MMC_TISR_TXEXCESSDEF_LEN		1
+#define MMC_TISR_TXFRAMECOUNT_G_POS		21
+#define MMC_TISR_TXFRAMECOUNT_G_LEN		1
+#define MMC_TISR_TXOCTETCOUNT_G_POS		20
+#define MMC_TISR_TXOCTETCOUNT_G_LEN		1
+#define MMC_TISR_TXCARRIERERROR_POS		19
+#define MMC_TISR_TXCARRIERERROR_LEN		1
+#define MMC_TISR_TXEXESSCOL_POS			18
+#define MMC_TISR_TXEXESSCOL_LEN			1
+#define MMC_TISR_TXLATECOL_POS			17
+#define MMC_TISR_TXLATECOL_LEN			1
+#define MMC_TISR_TXDEFERRED_POS			16
+#define MMC_TISR_TXDEFERRED_LEN			1
+#define MMC_TISR_TXMULTICOL_G_POS		15
+#define MMC_TISR_TXMULTICOL_G_LEN		1
+#define MMC_TISR_TXSINGLECOL_G_POS		14
+#define MMC_TISR_TXSINGLECOL_G_LEN		1
+#define MMC_TISR_TXUNDERFLOWERROR_POS		13
+#define MMC_TISR_TXUNDERFLOWERROR_LEN		1
+#define MMC_TISR_TXBROADCASTFRAMES_GB_POS	12
+#define MMC_TISR_TXBROADCASTFRAMES_GB_LEN	1
+#define MMC_TISR_TXMULTICASTFRAMES_GB_POS	11
+#define MMC_TISR_TXMULTICASTFRAMES_GB_LEN	1
+#define MMC_TISR_TXUNICASTFRAMES_GB_POS		10
+#define MMC_TISR_TXUNICASTFRAMES_GB_LEN		1
+#define MMC_TISR_TX1024TOMAXOCTETS_GB_POS	9
+#define MMC_TISR_TX1024TOMAXOCTETS_GB_LEN	1
+#define MMC_TISR_TX512TO1023OCTETS_GB_POS	8
+#define MMC_TISR_TX512TO1023OCTETS_GB_LEN	1
+#define MMC_TISR_TX256TO511OCTETS_GB_POS	7
+#define MMC_TISR_TX256TO511OCTETS_GB_LEN	1
+#define MMC_TISR_TX128TO255OCTETS_GB_POS	6
+#define MMC_TISR_TX128TO255OCTETS_GB_LEN	1
+#define MMC_TISR_TX65TO127OCTETS_GB_POS		5
+#define MMC_TISR_TX65TO127OCTETS_GB_LEN		1
+#define MMC_TISR_TX64OCTETS_GB_POS		4
+#define MMC_TISR_TX64OCTETS_GB_LEN		1
+#define MMC_TISR_TXMULTICASTFRAMES_G_POS	3
+#define MMC_TISR_TXMULTICASTFRAMES_G_LEN	1
+#define MMC_TISR_TXBROADCASTFRAMES_G_POS	2
+#define MMC_TISR_TXBROADCASTFRAMES_G_LEN	1
+#define MMC_TISR_TXFRAMECOUNT_GB_POS		1
+#define MMC_TISR_TXFRAMECOUNT_GB_LEN		1
+#define MMC_TISR_TXOCTETCOUNT_GB_POS		0
+#define MMC_TISR_TXOCTETCOUNT_GB_LEN		1
+
+/* IEEE 1588 PTP register offsets */
+#define	PTP_TCR		0xb00	/* Timestamp Control Reg */
+#define	PTP_SSIR	0xb04	/* Sub-Second Increment Reg */
+#define	PTP_STSR	0xb08	/* System Time  Seconds Reg */
+#define	PTP_STNSR	0xb0c	/* System Time  Nanoseconds Reg */
+#define	PTP_STSUR	0xb10	/* System Time  Seconds Update Reg */
+#define	PTP_STNSUR	0xb14	/* System Time  Nanoseconds Update Reg */
+#define	PTP_TAR		0xb18	/* Timestamp Addend Reg */
+#define PTP_TTSN	0xb30	/* Tx Timestamp status Nanoseconds Reg */
+#define PTP_TTN		0xb34	/* Tx Timestamp status Seconds Reg */
+
+/* PTP Timestamp control register entry bit positions and sizes */
+#define	PTP_SSIR_SSINC_POS		16
+#define	PTP_SSIR_SSINC_LEN		8
+#define PTP_STNSUR_ADDSUB_POS		31
+#define PTP_STNSUR_ADDSUB_LEN		1
+#define PTP_STNSUR_TSSSS_POS		0
+#define PTP_STNSUR_TSSSS_LEN		31
+#define PTP_TCR_AV8021ASMEN_POS		28
+#define PTP_TCR_AV8021ASMEN_LEN		1
+#define	PTP_TCR_SNAPTYPSEL_POS		16
+#define	PTP_TCR_SNAPTYPSEL_LEN		2
+#define	PTP_TCR_TSMSTRENA_POS		15
+#define	PTP_TCR_TSMSTRENA_LEN		1
+#define	PTP_TCR_TSEVNTENA_POS		14
+#define	PTP_TCR_TSEVNTENA_LEN		1
+#define	PTP_TCR_TSIPV4ENA_POS		13
+#define	PTP_TCR_TSIPV4ENA_LEN		1
+#define	PTP_TCR_TSIPV6ENA_POS		12
+#define	PTP_TCR_TSIPV6ENA_LEN		1
+#define	PTP_TCR_TSIPENA_POS		11
+#define	PTP_TCR_TSIPENA_LEN		1
+#define	PTP_TCR_TSVER2ENA_POS		10
+#define	PTP_TCR_TSVER2ENA_LEN		1
+#define	PTP_TCR_TSCTRLSSR_POS		9
+#define	PTP_TCR_TSCTRLSSR_LEN		1
+#define	PTP_TCR_TSENALL_POS		8
+#define	PTP_TCR_TSENALL_LEN		1
+#define	PTP_TCR_TSADDREG_POS		5
+#define	PTP_TCR_TSADDREG_LEN		1
+#define	PTP_TCR_TSUPDT_POS		3
+#define	PTP_TCR_TSUPDT_LEN		1
+#define	PTP_TCR_TSINIT_POS		2
+#define	PTP_TCR_TSINIT_LEN		1
+#define	PTP_TCR_TSCFUPDT_POS		1
+#define	PTP_TCR_TSCFUPDT_LEN		1
+#define	PTP_TCR_TSENA_POS		0
+#define	PTP_TCR_TSENA_LEN		1
+
+/* PTP Timestamp control register value */
+#define	PTP_DIGITAL_ROLLOVER_MODE	0x3B9ACA00	/* 10e9-1 ns */
+#define	PTP_BINARY_ROLLOVER_MODE	0x80000000	/* ~0.466 ns */
+
+/* MTL register offsets */
+#define MTL_OMR				0xc00
+#define MTL_RQDCM0R			0xc30
+#define MTL_RQDCM1R			0xc34
+
+/* MTL register entry bit positions and sizes */
+#define MTL_OMR_TSA_POS			5
+#define MTL_OMR_TSA_LEN			2
+#define MTL_OMR_RAA_POS			2
+#define MTL_OMR_RAA_LEN			1
+
+/* MTL queue register offsets
+ *   Multiple queues can be active.  The first queue has registers
+ *   that begin at 0xd00.  Each subsequent queue has registers that
+ *   are accessed using an offset of 0x40 from the previous queue.
+ */
+#define MTL_Q_BASE			0x0d00
+#define MTL_Q_BASE_OFFSET		0x0040
+#define MTL_QX_BASE(x)			(MTL_Q_BASE + \
+					((x) * MTL_Q_BASE_OFFSET))
+
+#define MTL_Q_TQOMR(x)			MTL_QX_BASE(x)
+#define MTL_Q_TESR(x)			(MTL_QX_BASE(x) + 0x14)
+#define MTL_Q_TQWR(x)			(MTL_QX_BASE(x) + 0x18)
+#define MTL_Q_ICSR(x)			(MTL_QX_BASE(x) + 0x2c)
+#define MTL_Q_RQOMR(x)			(MTL_QX_BASE(x) + 0x30)
+
+/* MTL queue register entry bit positions and sizes */
+#define MTL_ICR_RXOIE_POS		24
+#define MTL_ICR_RXOIE_LEN		1
+#define MTL_ICR_RXOVFIS_POS		16
+#define MTL_ICR_RXOVFIS_LEN		1
+#define MTL_ICR_ABPSIE_POS		9
+#define MTL_ICR_ABPSIE_LEN		1
+#define MTL_ICR_TXUIE_POS		8
+#define MTL_ICR_TXUIE_LEN		1
+#define MTL_ICR_ABPSIS_POS		1
+#define MTL_ICR_ABPSIS_LEN		1
+#define MTL_ICR_TXUNFIS_POS		0
+#define MTL_ICR_TXUNFIS_LEN		1
+#define MTL_Q_RQOMR_RQS_POS		20
+#define MTL_Q_RQOMR_RQS_LEN		10
+#define MTL_Q_RQOMR_RFD_POS		14
+#define MTL_Q_RQOMR_RFD_LEN		6
+#define MTL_Q_RQOMR_RFA_POS		8
+#define MTL_Q_RQOMR_RFA_LEN		6
+#define MTL_Q_RQOMR_EHFC_POS		7
+#define MTL_Q_RQOMR_EHFC_LEN		1
+#define MTL_Q_RQOMR_RSF_POS		5
+#define MTL_Q_RQOMR_RSF_LEN		1
+#define MTL_Q_RQOMR_FEP_POS		4
+#define MTL_Q_RQOMR_FEP_LEN		1
+#define MTL_Q_RQOMR_FUP_POS		3
+#define MTL_Q_RQOMR_FUP_LEN		1
+#define MTL_Q_RQOMR_RTC_POS		0
+#define MTL_Q_RQOMR_RTC_LEN		2
+#define MTL_Q_TQWR_QW_POS		0
+#define MTL_Q_TQWR_QW_LEN		21
+#define MTL_Q_TQOMR_FTQ_POS		0
+#define MTL_Q_TQOMR_FTQ_LEN		1
+#define MTL_Q_TQOMR_TQS_POS		16
+#define MTL_Q_TQOMR_TQS_LEN		10
+#define MTL_Q_TQOMR_TSF_POS		1
+#define MTL_Q_TQOMR_TSF_LEN		1
+#define MTL_Q_TQOMR_TTC_POS		4
+#define MTL_Q_TQOMR_TTC_LEN		3
+#define MTL_Q_TQOMR_TXQEN_POS		2
+#define MTL_Q_TQOMR_TXQEN_LEN		2
+
+/* MTL queue register value */
+#define MTL_RSF_DISABLE			0x00
+#define MTL_RSF_ENABLE			0x01
+#define MTL_TSF_DISABLE			0x00
+#define MTL_TSF_ENABLE			0x01
+#define MTL_RX_THRESHOLD_64		0x00
+#define MTL_RX_THRESHOLD_96		0x02
+#define MTL_RX_THRESHOLD_128		0x03
+#define MTL_TX_THRESHOLD_64		0x00
+#define MTL_TX_THRESHOLD_96		0x02
+#define MTL_TX_THRESHOLD_128		0x03
+#define MTL_TX_THRESHOLD_192		0x04
+#define MTL_TX_THRESHOLD_256		0x05
+#define MTL_TX_THRESHOLD_384		0x06
+#define MTL_TX_THRESHOLD_512		0x07
+#define MTL_TSA_WRR			0x00
+#define MTL_TSA_WFQ			0x01
+#define MTL_TSA_DWRR			0x02
+#define MTL_TSA_SP			0x03
+#define MTL_RAA_SP			0x00
+#define MTL_RAA_WSP			0x01
+#define MTL_Q_DISABLED			0x00
+#define MTL_Q_ENABLED			0x02
+#define MTL_RQDCM0R_Q0MDMACH		0x00000000
+#define MTL_RQDCM0R_Q1MDMACH		0x00000100
+#define MTL_RQDCM0R_Q2MDMACH		0x00020000
+#define MTL_RQDCM0R_Q3MDMACH		0x03000000
+#define MTL_RQDCM1R_Q4MDMACH		0x00000004
+#define MTL_RQDCM1R_Q5MDMACH		0x00000500
+#define MTL_RQDCM1R_Q6MDMACH		0x00060000
+#define MTL_RQDCM1R_Q7MDMACH		0x07000000
+
+/* DMA register offsets */
+#define DMA_MR				0x1000
+#define DMA_SBMR			0x1004
+#define DMA_ISR				0x1008
+#define DMA_DSR0			0x100c
+#define DMA_DSR1			0x1010
+
+/* DMA register entry bit positions and sizes */
+#define DMA_ISR_MACIS_POS		17
+#define DMA_ISR_MACIS_LEN		1
+#define DMA_ISR_MTLIS_POS		16
+#define DMA_ISR_MTLIS_LEN		1
+#define DMA_MR_SWR_POS			0
+#define DMA_MR_SWR_LEN			1
+#define DMA_SBMR_WR_OSR_LMT_POS		24
+#define DMA_SBMR_WR_OSR_LMT_LEN		3
+#define DMA_SBMR_RD_OSR_LMT_POS		16
+#define DMA_SBMR_RD_OSR_LMT_LEN		3
+#define DMA_SBMR_BLEN_16_POS		3
+#define DMA_SBMR_BLEN_16_LEN		1
+#define DMA_SBMR_BLEN_8_POS		2
+#define DMA_SBMR_BLEN_8_LEN		1
+#define DMA_SBMR_BLEN_4_POS		1
+#define DMA_SBMR_BLEN_4_LEN		1
+#define DMA_SBMR_FB_POS			0
+#define DMA_SBMR_FB_LEN			1
+
+/* DMA register values */
+#define DMA_SBMR_OSR_MAX		7
+#define DMA_DSR_RPS_LEN			4
+#define DMA_DSR_TPS_LEN			4
+#define DMA_DSR_Q_LEN			(DMA_DSR_RPS_LEN + DMA_DSR_TPS_LEN)
+#define DMA_DSR0_TPS_START		12
+#define DMA_DSR0_RPS_START		8
+#define DMA_DSRX_FIRST_QUEUE		3
+#define DMA_DSRX_INC			4
+#define DMA_DSRX_QPR			4
+#define DMA_DSRX_TPS_START		4
+#define DMA_DSRX_RPS_START		0
+#define DMA_ISR_MACIS_POS		17
+#define DMA_ISR_MACIS_LEN		1
+#define MAC_ISR_RGSMIIS_POS		0
+#define MAC_ISR_RGSMIIS_LEN		1
+
+/* DMA channel register offsets
+ *   Multiple channels can be active.  The first channel has registers
+ *   that begin at 0x1100.  Each subsequent channel has registers that
+ *   are accessed using an offset of 0x80 from the previous channel.
+ */
+#define DMA_CH_BASE			0x1100
+#define DMA_CH_INC			0x80
+
+#define DMA_CHX_BASE(x)			(DMA_CH_BASE + \
+					((x) * DMA_CH_INC))
+
+#define DMA_CH_CR(x)			DMA_CHX_BASE(x)
+#define DMA_CH_TCR(x)			(DMA_CHX_BASE(x) + 0x04)
+#define DMA_CH_RCR(x)			(DMA_CHX_BASE(x) + 0x08)
+#define DMA_CH_TDLR(x)			(DMA_CHX_BASE(x) + 0x14)
+#define DMA_CH_RDLR(x)			(DMA_CHX_BASE(x) + 0x1c)
+#define DMA_CH_TDTR(x)			(DMA_CHX_BASE(x) + 0x20)
+#define DMA_CH_RDTR(x)			(DMA_CHX_BASE(x) + 0x28)
+#define DMA_CH_TDRLR(x)			(DMA_CHX_BASE(x) + 0x2c)
+#define DMA_CH_RDRLR(x)			(DMA_CHX_BASE(x) + 0x30)
+#define DMA_CH_IER(x)			(DMA_CHX_BASE(x) + 0x34)
+#define DMA_CH_RIWT(x)			(DMA_CHX_BASE(x) + 0x38)
+#define DMA_CH_SR(x)			(DMA_CHX_BASE(x) + 0x60)
+
+/* DMA channel register entry bit positions and sizes */
+#define DMA_CH_CR_PBLX8_POS		16
+#define DMA_CH_CR_PBLX8_LEN		1
+#define DMA_CH_CR_SPH_POS		24
+#define DMA_CH_CR_SPH_LEN		1
+#define DMA_CH_IER_AIE_POS		14
+#define DMA_CH_IER_AIE_LEN		1
+#define DMA_CH_IER_FBEE_POS		12
+#define DMA_CH_IER_FBEE_LEN		1
+#define DMA_CH_IER_NIE_POS		15
+#define DMA_CH_IER_NIE_LEN		1
+#define DMA_CH_IER_RBUE_POS		7
+#define DMA_CH_IER_RBUE_LEN		1
+#define DMA_CH_IER_RIE_POS		6
+#define DMA_CH_IER_RIE_LEN		1
+#define DMA_CH_IER_RSE_POS		8
+#define DMA_CH_IER_RSE_LEN		1
+#define DMA_CH_IER_TBUE_POS		2
+#define DMA_CH_IER_TBUE_LEN		1
+#define DMA_CH_IER_TIE_POS		0
+#define DMA_CH_IER_TIE_LEN		1
+#define DMA_CH_IER_TXSE_POS		1
+#define DMA_CH_IER_TXSE_LEN		1
+#define DMA_CH_ISR_NIS_POS		15
+#define DMA_CH_ISR_NIS_LEN		1
+#define DMA_CH_ISR_AIS_POS		14
+#define DMA_CH_ISR_AIS_LEN		1
+#define DMA_CH_ISR_CDE_POS		13
+#define DMA_CH_ISR_CDE_LEN		1
+#define DMA_CH_ISR_FBE_POS		12
+#define DMA_CH_ISR_FBE_LEN		1
+#define DMA_CH_ISR_ERI_POS		11
+#define DMA_CH_ISR_ERI_LEN		1
+#define DMA_CH_ISR_ETI_POS		10
+#define DMA_CH_ISR_ETI_LEN		1
+#define DMA_CH_ISR_RWT_POS		9
+#define DMA_CH_ISR_RWT_LEN		1
+#define DMA_CH_ISR_RPS_POS		8
+#define DMA_CH_ISR_RPS_LEN		1
+#define DMA_CH_ISR_RBU_POS		7
+#define DMA_CH_ISR_RBU_LEN		1
+#define DMA_CH_ISR_RI_POS		6
+#define DMA_CH_ISR_RI_LEN		1
+#define DMA_CH_ISR_TBU_POS		2
+#define DMA_CH_ISR_TBU_LEN		1
+#define DMA_CH_ISR_TPS_POS		1
+#define DMA_CH_ISR_TPS_LEN		1
+#define DMA_CH_ISR_TI_POS		0
+#define DMA_CH_ISR_TI_LEN		1
+#define DMA_CH_RCR_PBL_POS		16
+#define DMA_CH_RCR_PBL_LEN		6
+#define DMA_CH_RCR_RBSZ_POS		1
+#define DMA_CH_RCR_RBSZ_LEN		14
+#define DMA_CH_RCR_SR_POS		0
+#define DMA_CH_RCR_SR_LEN		1
+#define DMA_CH_RIWT_RWT_POS		0
+#define DMA_CH_RIWT_RWT_LEN		8
+#define DMA_CH_TCR_PBL_POS		16
+#define DMA_CH_TCR_PBL_LEN		6
+#define DMA_CH_TCR_TSE_POS		12
+#define DMA_CH_TCR_TSE_LEN		1
+#define DMA_CH_TCR_OSP_POS		4
+#define DMA_CH_TCR_OSP_LEN		1
+#define DMA_CH_TCR_ST_POS		0
+#define DMA_CH_TCR_ST_LEN		1
+
+/* DMA channel register values */
+#define DMA_OSP_DISABLE			0x00
+#define DMA_OSP_ENABLE			0x01
+#define DMA_PBL_1			1
+#define DMA_PBL_2			2
+#define DMA_PBL_4			4
+#define DMA_PBL_8			8
+#define DMA_PBL_16			16
+#define DMA_PBL_32			32
+#define DMA_PBL_64			64
+#define DMA_PBL_128			128
+#define DMA_PBL_256			256
+#define DMA_PBL_X8_DISABLE		0x00
+#define DMA_PBL_X8_ENABLE		0x01
+
+#define GMAC_COPYBREAK_DEFAULT 256
+
+#endif /* __MT2712_REG_H__ */
diff --git a/drivers/net/ethernet/mediatek/gmac/mtk-gmac.h b/drivers/net/ethernet/mediatek/gmac/mtk-gmac.h
new file mode 100644
index 0000000..8dedcce
--- /dev/null
+++ b/drivers/net/ethernet/mediatek/gmac/mtk-gmac.h
@@ -0,0 +1,683 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+#ifndef __MTK_GMAC_H__
+#define __MTK_GMAC_H__
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/if_vlan.h>
+#include <linux/netdevice.h>
+#include <linux/net_tstamp.h>
+#include <linux/phy.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
+#include <linux/timer.h>
+#include <linux/time64.h>
+#include <linux/workqueue.h>
+
+#include "mtk-gmac-desc.h"
+#include "mtk-gmac-reg.h"
+
+#define GMAC_DRV_NAME			"mtk-gmac"
+#define GMAC_DRV_VERSION		"1.0.0"
+#define GMAC_DRV_DESC			"MediaTek GMAC Driver"
+
+/* Descriptor related parameters */
+#define GMAC_TX_DESC_CNT		1024
+#define GMAC_TX_DESC_MIN_FREE		(GMAC_TX_DESC_CNT >> 3)
+#define GMAC_TX_DESC_MAX_PROC		(GMAC_TX_DESC_CNT >> 1)
+#define GMAC_RX_DESC_CNT		1024
+#define GMAC_RX_DESC_MAX_DIRTY		(GMAC_RX_DESC_CNT >> 3)
+
+/* Descriptors required for maximum contiguous TSO/GSO packet */
+#define GMAC_TX_MAX_SPLIT	((GSO_MAX_SIZE / GMAC_TX_MAX_BUF_SIZE) + 1)
+
+/* Maximum possible descriptors needed for a SKB */
+#define GMAC_TX_MAX_DESC_NR	(MAX_SKB_FRAGS + GMAC_TX_MAX_SPLIT + 2)
+
+#define GMAC_TX_MAX_BUF_SIZE	(SZ_16K - 1)
+#define GMAC_RX_MIN_BUF_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN + VLAN_HLEN)
+#define GMAC_RX_BUF_ALIGN	64
+
+#define GMAC_MAX_FIFO			81920
+
+#define GMAC_MAX_DMA_CHANNELS		8
+#define GMAC_DMA_STOP_TIMEOUT		5
+#define GMAC_DMA_INTERRUPT_MASK		0x31c7
+
+/* Default coalescing parameters */
+#define GMAC_INIT_DMA_TX_USECS		1000
+#define GMAC_INIT_DMA_TX_FRAMES		25
+#define GMAC_INIT_DMA_RX_USECS		30
+#define GMAC_INIT_DMA_RX_FRAMES		25
+#define GMAC_MAX_DMA_RIWT		0xff
+#define GMAC_MIN_DMA_RIWT		0x01
+
+/* Flow control queue count */
+#define GMAC_MAX_FLOW_CONTROL_QUEUES	8
+
+/* System clock is axi clk */
+#define GMAC_SYSCLOCK			(273000000 / 2)
+
+/* Maximum MAC address hash table size (256 bits = 8 bytes) */
+#define GMAC_MAC_HASH_TABLE_SIZE	8
+
+/* Helper macro for descriptor handling
+ *  Always use GMAC_GET_DESC_DATA to access the descriptor data
+ */
+#define GMAC_GET_DESC_DATA(ring, idx) ({				\
+	typeof(ring) _ring = (ring);					\
+	((_ring)->desc_data_head +					\
+	 ((idx) & ((_ring)->dma_desc_count - 1)));			\
+})
+
+struct gmac_pdata;
+
+enum gmac_clks_map {
+	GMAC_CLK_AXI_DRAM,
+	GMAC_CLK_APB_REG,
+	GMAC_CLK_MAC_EXT,
+	GMAC_CLK_PTP,
+	GMAC_CLK_PTP_PARENT,
+	GMAC_CLK_PTP_TOP,
+	GMAC_CLK_MAX
+};
+
+enum gmac_int {
+	GMAC_INT_DMA_CH_SR_TI,
+	GMAC_INT_DMA_CH_SR_TPS,
+	GMAC_INT_DMA_CH_SR_TBU,
+	GMAC_INT_DMA_CH_SR_RI,
+	GMAC_INT_DMA_CH_SR_RBU,
+	GMAC_INT_DMA_CH_SR_RPS,
+	GMAC_INT_DMA_CH_SR_TI_RI,
+	GMAC_INT_DMA_CH_SR_FBE,
+	GMAC_INT_DMA_ALL,
+};
+
+struct gmac_stats {
+	/* MMC TX counters */
+	u64 txoctetcount_gb;
+	u64 txframecount_gb;
+	u64 txbroadcastframes_g;
+	u64 txmulticastframes_g;
+	u64 tx64octets_gb;
+	u64 tx65to127octets_gb;
+	u64 tx128to255octets_gb;
+	u64 tx256to511octets_gb;
+	u64 tx512to1023octets_gb;
+	u64 tx1024tomaxoctets_gb;
+	u64 txunicastframes_gb;
+	u64 txmulticastframes_gb;
+	u64 txbroadcastframes_gb;
+	u64 txunderflowerror;
+	u64 txsinglecol_g;
+	u64 txmulticol_g;
+	u64 txdeferred;
+	u64 txlatecol;
+	u64 txexesscol;
+	u64 txcarriererror;
+	u64 txoctetcount_g;
+	u64 txframecount_g;
+	u64 txexcessdef;
+	u64 txpauseframes;
+	u64 txvlanframes_g;
+	u64 txosizeframe_g;
+	u64 txlpiusec;
+	u64 txlpitran;
+
+	/* MMC RX counters */
+	u64 rxframecount_gb;
+	u64 rxoctetcount_gb;
+	u64 rxoctetcount_g;
+	u64 rxbroadcastframes_g;
+	u64 rxmulticastframes_g;
+	u64 rxcrcerror;
+	u64 rxalignerror;
+	u64 rxrunterror;
+	u64 rxjabbererror;
+	u64 rxundersize_g;
+	u64 rxoversize_g;
+	u64 rx64octets_gb;
+	u64 rx65to127octets_gb;
+	u64 rx128to255octets_gb;
+	u64 rx256to511octets_gb;
+	u64 rx512to1023octets_gb;
+	u64 rx1024tomaxoctets_gb;
+	u64 rxunicastframes_g;
+	u64 rxlengtherror;
+	u64 rxoutofrangetype;
+	u64 rxpauseframes;
+	u64 rxfifooverflow;
+	u64 rxvlanframes_gb;
+	u64 rxwatchdogerror;
+	u64 rxreceiveerror;
+	u64 rxctrlframes_g;
+	u64 rxlpiusec;
+	u64 rxlpitran;
+
+	/* MMC RXIPC counters */
+	u64 rxipv4_g;
+	u64 rxipv4hderr;
+	u64 rxipv4nopay;
+	u64 rxipv4frag;
+	u64 rxipv4udsbl;
+	u64 rxipv6octets_g;
+	u64 rxipv6hderroctets;
+	u64 rxipv6nopayoctets;
+	u64 rxudp_g;
+	u64 rxudperr;
+	u64 rxtcp_g;
+	u64 rxtcperr;
+	u64 rxicmp_g;
+	u64 rxicmperr;
+	u64 rxipv4octets_g;
+	u64 rxipv4hderroctets;
+	u64 rxipv4nopayoctets;
+	u64 rxipv4fragoctets;
+	u64 rxipv4udsbloctets;
+	u64 rxipv6_g;
+	u64 rxipv6hderr;
+	u64 rxipv6nopay;
+	u64 rxudpoctets_g;
+	u64 rxudperroctets;
+	u64 rxtcpoctets_g;
+	u64 rxtcperroctets;
+	u64 rxicmpoctets_g;
+	u64 rxicmperroctets;
+
+	/* Extra counters */
+	u64 tx_tso_packets;
+	u64 rx_split_header_packets;
+	u64 tx_process_stopped;
+	u64 rx_process_stopped;
+	u64 tx_buffer_unavailable;
+	u64 rx_buffer_unavailable;
+	u64 fatal_bus_error;
+	u64 tx_vlan_packets;
+	u64 rx_vlan_packets;
+	u64 tx_timestamp_packets;
+	u64 rx_timestamp_packets;
+	u64 napi_poll_isr;
+	u64 napi_poll_txtimer;
+};
+
+struct gmac_ring_buf {
+	struct sk_buff *skb;
+	dma_addr_t skb_dma;
+	unsigned int skb_len;
+};
+
+/* Common Tx and Rx DMA hardware descriptor */
+struct gmac_dma_desc {
+	u32 desc0;
+	u32 desc1;
+	u32 desc2;
+	u32 desc3;
+};
+
+/* TxRx-related desc data */
+struct gmac_trx_desc_data {
+	unsigned int packets;		/* BQL packet count */
+	unsigned int bytes;		/* BQL byte count */
+};
+
+struct gmac_pkt_info {
+	struct sk_buff *skb;
+
+	unsigned int attributes;
+
+	unsigned int errors;
+
+	/* descriptors needed for this packet */
+	unsigned int desc_count;
+	unsigned int length;
+
+	unsigned int tx_packets;
+	unsigned int tx_bytes;
+
+	unsigned int header_len;
+	unsigned int tcp_header_len;
+	unsigned int tcp_payload_len;
+	unsigned short mss;
+
+	unsigned short vlan_ctag;
+
+	u64 rx_tstamp;
+};
+
+struct gmac_desc_data {
+	/* dma_desc: Virtual address of descriptor
+	 *  dma_desc_addr: DMA address of descriptor
+	 */
+	struct gmac_dma_desc *dma_desc;
+	dma_addr_t dma_desc_addr;
+
+	/* skb: Virtual address of SKB
+	 *  skb_dma: DMA address of SKB data
+	 *  skb_dma_len: Length of SKB DMA area
+	 */
+	struct sk_buff *skb;
+	dma_addr_t skb_dma;
+	unsigned int skb_dma_len;
+
+	/* Tx/Rx -related data */
+	struct gmac_trx_desc_data trx;
+
+	unsigned int mapped_as_page;
+
+	/* Incomplete receive save location.  If the budget is exhausted
+	 * or the last descriptor (last normal descriptor or a following
+	 * context descriptor) has not been DMA'd yet the current state
+	 * of the receive processing needs to be saved.
+	 */
+	unsigned int state_saved;
+	struct {
+		struct sk_buff *skb;
+		unsigned int len;
+		unsigned int error;
+	} state;
+};
+
+struct gmac_ring {
+	/* Per packet related information */
+	struct gmac_pkt_info pkt_info;
+
+	/* Virtual/DMA addresses of DMA descriptor list and the total count */
+	struct gmac_dma_desc *dma_desc_head;
+	dma_addr_t dma_desc_head_addr;
+	unsigned int dma_desc_count;
+
+	/* Array of descriptor data corresponding the DMA descriptor
+	 * (always use the GMAC_GET_DESC_DATA macro to access this data)
+	 */
+	struct gmac_desc_data *desc_data_head;
+
+	/* Ring index values
+	 *  cur   - Tx: index of descriptor to be used for current transfer
+	 *          Rx: index of descriptor to check for packet availability
+	 *  dirty - Tx: index of descriptor to check for transfer complete
+	 *          Rx: index of descriptor to check for buffer reallocation
+	 */
+	unsigned int cur;
+	unsigned int dirty;
+
+	/* Coalesce frame count used for interrupt bit setting */
+	unsigned int coalesce_count;
+
+	union {
+		struct {
+			unsigned int xmit_more;
+			unsigned int queue_stopped;
+			unsigned short cur_mss;
+			unsigned short cur_vlan_ctag;
+		} tx;
+	};
+} ____cacheline_aligned;
+
+struct gmac_channel {
+	char name[16];
+
+	/* Address of private data area for device */
+	struct gmac_pdata *pdata;
+
+	/* Queue index and base address of queue's DMA registers */
+	unsigned int queue_index;
+	void __iomem *dma_regs;
+
+	/* Per channel interrupt irq number */
+	int dma_irq;
+	char dma_irq_name[IFNAMSIZ + 32];
+
+	/* Netdev related settings */
+	struct napi_struct napi;
+
+	unsigned int saved_ier;
+
+	unsigned int tx_timer_active;
+	struct timer_list tx_timer;
+
+	struct gmac_ring *tx_ring;
+	struct gmac_ring *rx_ring;
+} ____cacheline_aligned;
+
+struct gmac_desc_ops {
+	int (*alloc_channles_and_rings)(struct gmac_pdata *pdata);
+	void (*free_channels_and_rings)(struct gmac_pdata *pdata);
+	int (*map_tx_skb)(struct gmac_channel *channel,
+			  struct sk_buff *skb);
+	int (*map_rx_buffer)(struct gmac_pdata *pdata,
+			     struct gmac_ring *ring,
+			struct gmac_desc_data *desc_data);
+	void (*unmap_desc_data)(struct gmac_pdata *pdata,
+				struct gmac_desc_data *desc_data,
+				unsigned int tx_rx);
+	void (*tx_desc_init)(struct gmac_pdata *pdata);
+	void (*rx_desc_init)(struct gmac_pdata *pdata);
+};
+
+struct gmac_hw_ops {
+	int (*init)(struct gmac_pdata *pdata);
+	int (*exit)(struct gmac_pdata *pdata);
+
+	int (*tx_complete)(struct gmac_dma_desc *dma_desc);
+
+	void (*enable_tx)(struct gmac_pdata *pdata);
+	void (*disable_tx)(struct gmac_pdata *pdata);
+	void (*enable_rx)(struct gmac_pdata *pdata);
+	void (*disable_rx)(struct gmac_pdata *pdata);
+
+	int (*enable_int)(struct gmac_channel *channel,
+			  enum gmac_int int_id);
+	int (*disable_int)(struct gmac_channel *channel,
+			   enum gmac_int int_id);
+	void (*dev_xmit)(struct gmac_channel *channel);
+	int (*dev_read)(struct gmac_channel *channel);
+
+	int (*set_mac_address)(struct gmac_pdata *pdata, u8 *addr,
+			       unsigned int idx);
+	int (*config_rx_mode)(struct gmac_pdata *pdata);
+	int (*enable_rx_csum)(struct gmac_pdata *pdata);
+	int (*disable_rx_csum)(struct gmac_pdata *pdata);
+
+	/* For MII speed configuration */
+	int (*set_gmii_10_speed)(struct gmac_pdata *pdata);
+	int (*set_gmii_100_speed)(struct gmac_pdata *pdata);
+	int (*set_gmii_1000_speed)(struct gmac_pdata *pdata);
+
+	int (*set_full_duplex)(struct gmac_pdata *pdata);
+	int (*set_half_duplex)(struct gmac_pdata *pdata);
+
+	/* For descriptor related operation */
+	void (*tx_desc_init)(struct gmac_channel *channel);
+	void (*rx_desc_init)(struct gmac_channel *channel);
+	void (*tx_desc_reset)(struct gmac_desc_data *desc_data);
+	void (*rx_desc_reset)(struct gmac_pdata *pdata,
+			      struct gmac_desc_data *desc_data,
+			      unsigned int index);
+	int (*is_last_desc)(struct gmac_dma_desc *dma_desc);
+	int (*is_context_desc)(struct gmac_dma_desc *dma_desc);
+	void (*tx_start_xmit)(struct gmac_channel *channel,
+			      struct gmac_ring *ring);
+
+	/* For Flow Control */
+	int (*config_tx_flow_control)(struct gmac_pdata *pdata);
+	int (*config_rx_flow_control)(struct gmac_pdata *pdata);
+
+	/* For Vlan related config */
+	int (*enable_rx_vlan_stripping)(struct gmac_pdata *pdata);
+	int (*disable_rx_vlan_stripping)(struct gmac_pdata *pdata);
+	int (*enable_rx_vlan_filtering)(struct gmac_pdata *pdata);
+	int (*disable_rx_vlan_filtering)(struct gmac_pdata *pdata);
+	int (*update_vlan_hash_table)(struct gmac_pdata *pdata);
+	int (*update_vlan)(struct gmac_pdata *pdata);
+
+	/* For RX coalescing */
+	int (*config_rx_coalesce)(struct gmac_pdata *pdata);
+	int (*config_tx_coalesce)(struct gmac_pdata *pdata);
+	unsigned int (*usec_to_riwt)(struct gmac_pdata *pdata,
+				     unsigned int usec);
+	unsigned int (*riwt_to_usec)(struct gmac_pdata *pdata,
+				     unsigned int riwt);
+
+	/* For RX and TX threshold config */
+	int (*config_rx_threshold)(struct gmac_pdata *pdata,
+				   unsigned int val);
+	int (*config_tx_threshold)(struct gmac_pdata *pdata,
+				   unsigned int val);
+
+	/* For RX and TX Store and Forward Mode config */
+	int (*config_rsf_mode)(struct gmac_pdata *pdata,
+			       unsigned int val);
+	int (*config_tsf_mode)(struct gmac_pdata *pdata,
+			       unsigned int val);
+
+	/* For TX DMA Operate on Second Frame config */
+	int (*config_osp_mode)(struct gmac_pdata *pdata);
+
+	/* For RX and TX PBL config */
+	int (*config_rx_pbl_val)(struct gmac_pdata *pdata);
+	int (*config_tx_pbl_val)(struct gmac_pdata *pdata);
+	int (*config_pblx8)(struct gmac_pdata *pdata);
+
+	/* For MMC statistics */
+	void (*rxipc_mmc_int)(struct gmac_pdata *pdata);
+	void (*rx_mmc_int)(struct gmac_pdata *pdata);
+	void (*tx_mmc_int)(struct gmac_pdata *pdata);
+	void (*read_mmc_stats)(struct gmac_pdata *pdata);
+
+	void (*config_hw_timestamping)(struct gmac_pdata *pdata,
+				       u32 data);
+	void (*config_sub_second_increment)(struct gmac_pdata *pdata,
+					    u32 ptp_clock,
+					    u32 *ssinc);
+	int (*init_systime)(struct gmac_pdata *pdata, u32 sec, u32 nsec);
+	int (*config_addend)(struct gmac_pdata *pdata, u32 addend);
+	int (*adjust_systime)(struct gmac_pdata *pdata,
+			      u32 sec,
+			      u32 nsec,
+			      int add_sub);
+	void (*get_systime)(struct gmac_pdata *pdata, u64 *systime);
+	void (*get_tx_hwtstamp)(struct gmac_pdata *pdata,
+				struct gmac_dma_desc *desc,
+				struct sk_buff *skb);
+
+};
+
+/* This structure contains flags that indicate what hardware features
+ * or configurations are present in the device.
+ */
+struct gmac_hw_features {
+	/* HW Version */
+	unsigned int version;
+
+	/* HW Feature Register0 */
+	unsigned int mii;		/* 10/100Mbps support */
+	unsigned int gmii;		/* 1000Mbps support */
+	unsigned int hd;		/* Half Duplex support */
+	unsigned int pcs;		/* TBI/SGMII/RTBI PHY interface */
+	unsigned int vlhash;		/* VLAN Hash Filter */
+	unsigned int sma;		/* SMA(MDIO) Interface */
+	unsigned int rwk;		/* PMT remote wake-up packet */
+	unsigned int mgk;		/* PMT magic packet */
+	unsigned int mmc;		/* RMON module */
+	unsigned int aoe;		/* ARP Offload */
+	unsigned int ts;		/* IEEE 1588-2008 Advanced Timestamp */
+	unsigned int eee;		/* Energy Efficient Ethernet */
+	unsigned int tx_coe;		/* Tx Checksum Offload */
+	unsigned int rx_coe;		/* Rx Checksum Offload */
+	unsigned int addn_mac;		/* Additional MAC Addresses */
+	unsigned int ts_src;		/* Timestamp Source */
+	unsigned int sa_vlan_ins;	/* Source Address or VLAN Insertion */
+	unsigned int phyifsel;		/* PHY interface support */
+
+	/* HW Feature Register1 */
+	unsigned int rx_fifo_size;	/* MTL Receive FIFO Size */
+	unsigned int tx_fifo_size;	/* MTL Transmit FIFO Size */
+	unsigned int one_step_en;	/* One-Step Timingstamping Enable */
+	unsigned int ptp_offload;	/* PTP Offload Enable */
+	unsigned int adv_ts_hi;		/* Advance Timestamping High Word */
+	unsigned int dma_width;		/* DMA width */
+	unsigned int dcb;		/* DCB Feature */
+	unsigned int sph;		/* Split Header Feature */
+	unsigned int tso;		/* TCP Segmentation Offload */
+	unsigned int dma_debug;		/* DMA Debug Registers */
+	unsigned int av;		/* Audio-Vedio Bridge Option */
+	unsigned int rav;		/* Rx Side AV Feature */
+	unsigned int pouost;		/* One-Step for PTP over UDP/IP */
+	unsigned int hash_table_size;	/* Hash Table Size */
+	unsigned int l3l4_filter_num;	/* Number of L3-L4 Filters */
+
+	/* HW Feature Register2 */
+	unsigned int rx_q_cnt;		/* Number of MTL Receive Queues */
+	unsigned int tx_q_cnt;		/* Number of MTL Transmit Queues */
+	unsigned int rx_ch_cnt;		/* Number of DMA Receive Channels */
+	unsigned int tx_ch_cnt;		/* Number of DMA Transmit Channels */
+	unsigned int pps_out_num;	/* Number of PPS outputs */
+	unsigned int aux_snap_num;	/* Number of Aux snapshot inputs */
+};
+
+struct plat_gmac_data {
+	struct regmap *infra_regmap, *peri_regmap;
+	struct clk *clks[GMAC_CLK_MAX];
+	struct device_node *np;
+	int phy_mode;
+	void (*gmac_set_interface)(struct plat_gmac_data *plat);
+	void (*gmac_set_delay)(struct plat_gmac_data *plat);
+	int (*gmac_clk_enable)(struct plat_gmac_data *plat);
+	void (*gmac_clk_disable)(struct plat_gmac_data *plat);
+};
+
+struct gmac_resources {
+	void __iomem *base_addr;
+	const char *mac_addr;
+	int irq;
+	int phy_rst;
+};
+
+struct gmac_pdata {
+	struct net_device *netdev;
+	struct device *dev;
+
+	struct plat_gmac_data *plat;
+
+	struct gmac_hw_ops hw_ops;
+	struct gmac_desc_ops desc_ops;
+
+	/* Device statistics */
+	struct gmac_stats stats;
+
+	u32 msg_enable;
+
+	/* MAC registers base */
+	void __iomem *mac_regs;
+
+	/* phydev */
+	struct mii_bus *mii;
+	struct phy_device *phydev;
+	int phyaddr;
+	int bus_id;
+
+	/* Hardware features of the device */
+	struct gmac_hw_features hw_feat;
+
+	struct work_struct restart_work;
+
+	/* Rings for Tx/Rx on a DMA channel */
+	struct gmac_channel *channel_head;
+	unsigned int channel_count;
+	unsigned int tx_ring_count;
+	unsigned int rx_ring_count;
+	unsigned int tx_desc_count;
+	unsigned int rx_desc_count;
+	unsigned int tx_q_count;
+	unsigned int rx_q_count;
+
+	/* Tx/Rx common settings */
+	unsigned int pblx8;
+
+	/* Tx settings */
+	unsigned int tx_sf_mode;
+	unsigned int tx_threshold;
+	unsigned int tx_pbl;
+	unsigned int tx_osp_mode;
+
+	/* Rx settings */
+	unsigned int rx_sf_mode;
+	unsigned int rx_threshold;
+	unsigned int rx_pbl;
+	unsigned int rx_sph;
+
+	/* Tx coalescing settings */
+	unsigned int tx_usecs;
+	unsigned int tx_frames;
+
+	/* Rx coalescing settings */
+	unsigned int rx_riwt;
+	unsigned int rx_usecs;
+	unsigned int rx_frames;
+
+	/* Current Rx buffer size */
+	unsigned int rx_buf_size;
+
+	/* Flow control settings */
+	unsigned int tx_pause;
+	unsigned int rx_pause;
+
+	unsigned int max_addr_reg_cnt;
+
+	/* Device interrupt number */
+	int phy_rst;
+	int dev_irq;
+	unsigned int per_channel_irq;
+	int channel_irq[GMAC_MAX_DMA_CHANNELS];
+
+	/* Netdev related settings */
+	unsigned char mac_addr[ETH_ALEN];
+	netdev_features_t netdev_features;
+	struct napi_struct napi;
+
+	/* Filtering support */
+	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	int vlan_weight;
+
+	/* Device clocks */
+	unsigned long sysclk_rate;
+
+	/* DMA width */
+	unsigned int dma_width;
+
+	/* HW timestamping */
+	unsigned char hwts_tx_en;
+	unsigned char hwts_rx_en;
+	unsigned long ptpclk_rate, ptptop_rate;
+	unsigned int ptp_divider;
+	struct ptp_clock_info ptp_clock_info;
+	struct ptp_clock *ptp_clock;
+	u64 default_addend;
+	/* protects registers access */
+	spinlock_t ptp_lock;
+
+	int phy_speed;
+	int duplex;
+
+	char drv_name[32];
+	char drv_ver[32];
+};
+
+void gmac_init_desc_ops(struct gmac_desc_ops *desc_ops);
+void gmac_init_hw_ops(struct gmac_hw_ops *hw_ops);
+const struct net_device_ops *gmac_get_netdev_ops(void);
+const struct ethtool_ops *gmac_get_ethtool_ops(void);
+void gmac_dump_tx_desc(struct gmac_pdata *pdata,
+		       struct gmac_ring *ring,
+		       unsigned int idx,
+		       unsigned int count,
+		       unsigned int flag);
+void gmac_dump_rx_desc(struct gmac_pdata *pdata,
+		       struct gmac_ring *ring,
+		       unsigned int idx);
+void gmac_print_pkt(struct net_device *netdev,
+		    struct sk_buff *skb, bool tx_rx);
+int gmac_drv_probe(struct device *dev,
+		   struct plat_gmac_data *plat,
+		   struct gmac_resources *res);
+int gmac_drv_remove(struct device *dev);
+
+int mdio_register(struct net_device *ndev);
+void mdio_unregister(struct net_device *ndev);
+
+/* For debug prints */
+#ifdef GMAC_DEBUG
+#define GMAC_PR(fmt, args...) \
+	pr_alert("[%s,%d]:" fmt, __func__, __LINE__, ## args)
+#else
+#define GMAC_PR(x...)		do { } while (0)
+#endif
+
+#endif /* __MTK_GMAC_H__ */
-- 
1.7.9.5

