Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C35C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE612087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE612087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH2GBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:01:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20361 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726479AbeH2GBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:01:20 -0400
X-UUID: 453ec6123ed4426cae3eb72d8eb4d1a3-20180829
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1384569993; Wed, 29 Aug 2018 10:06:45 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 29 Aug 2018 10:06:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 29 Aug 2018 10:06:44 +0800
Message-ID: <1535508404.28775.1.camel@mtkswgap22>
Subject: Re: [PATCH v2] net: ethernet: Convert to using %pOFn instead of
 device_node.name
From:   Sean Wang <sean.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        "John Crispin" <john@phrozen.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        <netdev@vger.kernel.org>
Date:   Wed, 29 Aug 2018 10:06:44 +0800
In-Reply-To: <20180828154433.5693-4-robh@kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
         <20180828154433.5693-4-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-28 at 10:44 -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> Cc: Salil Mehta <salil.mehta@huawei.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Nelson Chang <nelson.chang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Wingman Kwok <w-kwok2@ti.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: netdev@vger.kernel.org
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - fix missing brackets in netcp
> 
>  drivers/net/ethernet/freescale/fsl_pq_mdio.c  |  4 +-
>  .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c |  8 ++--
>  drivers/net/ethernet/marvell/mv643xx_eth.c    |  6 +--
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c   |  2 +-

for mtk-eth

Acked-by: Sean Wang <sean.wang@mediatek.com>

>  drivers/net/ethernet/sun/sunhme.c             |  2 +-
>  drivers/net/ethernet/ti/netcp_core.c          | 22 ++++------
>  drivers/net/ethernet/ti/netcp_ethss.c         | 42 +++++++++----------
>  7 files changed, 40 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> index ac2c3f6a12bc..82722d05fedb 100644
> --- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> +++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
> @@ -446,8 +446,8 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
>  		goto error;
>  	}
> 
> -	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%s@%llx", np->name,
> -		(unsigned long long)res.start);
> +	snprintf(new_bus->id, MII_BUS_ID_SIZE, "%pOFn@%llx", np,
> +		 (unsigned long long)res.start);
> 
>  	priv->map = of_iomap(np, 0);
>  	if (!priv->map) {
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> index 1c2326bd76e2..6521d8d53745 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> @@ -807,8 +807,8 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
>  			 */
>  			put_device(&mac_cb->phy_dev->mdio.dev);
> 
> -			dev_dbg(mac_cb->dev, "mac%d phy_node: %s\n",
> -				mac_cb->mac_id, np->name);
> +			dev_dbg(mac_cb->dev, "mac%d phy_node: %pOFn\n",
> +				mac_cb->mac_id, np);
>  		}
>  		of_node_put(np);
> 
> @@ -825,8 +825,8 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
>  			 * if the phy_dev is found
>  			 */
>  			put_device(&mac_cb->phy_dev->mdio.dev);
> -			dev_dbg(mac_cb->dev, "mac%d phy_node: %s\n",
> -				mac_cb->mac_id, np->name);
> +			dev_dbg(mac_cb->dev, "mac%d phy_node: %pOFn\n",
> +				mac_cb->mac_id, np);
>  		}
>  		of_node_put(np);
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index 62f204f32316..1e9bcbdc6a90 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2733,17 +2733,17 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
> 
>  	memset(&res, 0, sizeof(res));
>  	if (of_irq_to_resource(pnp, 0, &res) <= 0) {
> -		dev_err(&pdev->dev, "missing interrupt on %s\n", pnp->name);
> +		dev_err(&pdev->dev, "missing interrupt on %pOFn\n", pnp);
>  		return -EINVAL;
>  	}
> 
>  	if (of_property_read_u32(pnp, "reg", &ppd.port_number)) {
> -		dev_err(&pdev->dev, "missing reg property on %s\n", pnp->name);
> +		dev_err(&pdev->dev, "missing reg property on %pOFn\n", pnp);
>  		return -EINVAL;
>  	}
> 
>  	if (ppd.port_number >= 3) {
> -		dev_err(&pdev->dev, "invalid reg property on %s\n", pnp->name);
> +		dev_err(&pdev->dev, "invalid reg property on %pOFn\n", pnp);
>  		return -EINVAL;
>  	}
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 6e6abdc399de..b44bcfd85b05 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -405,7 +405,7 @@ static int mtk_mdio_init(struct mtk_eth *eth)
>  	eth->mii_bus->priv = eth;
>  	eth->mii_bus->parent = eth->dev;
> 
> -	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%s", mii_np->name);
> +	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%pOFn", mii_np);
>  	ret = of_mdiobus_register(eth->mii_bus, mii_np);
> 
>  err_put_node:
> diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
> index 06da2f59fcbf..863fd602fd33 100644
> --- a/drivers/net/ethernet/sun/sunhme.c
> +++ b/drivers/net/ethernet/sun/sunhme.c
> @@ -2999,7 +2999,7 @@ static int happy_meal_pci_probe(struct pci_dev *pdev,
>  	/* Now make sure pci_dev cookie is there. */
>  #ifdef CONFIG_SPARC
>  	dp = pci_device_to_OF_node(pdev);
> -	strcpy(prom_name, dp->name);
> +	snprintf(prom_name, sizeof(prom_name), "%pOFn", dp);
>  #else
>  	if (is_quattro_p(pdev))
>  		strcpy(prom_name, "SUNW,qfe");
> diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
> index a1d335a3c5e4..1f612268c998 100644
> --- a/drivers/net/ethernet/ti/netcp_core.c
> +++ b/drivers/net/ethernet/ti/netcp_core.c
> @@ -225,17 +225,6 @@ static int emac_arch_get_mac_addr(char *x, void __iomem *efuse_mac, u32 swap)
>  	return 0;
>  }
> 
> -static const char *netcp_node_name(struct device_node *node)
> -{
> -	const char *name;
> -
> -	if (of_property_read_string(node, "label", &name) < 0)
> -		name = node->name;
> -	if (!name)
> -		name = "unknown";
> -	return name;
> -}
> -
>  /* Module management routines */
>  static int netcp_register_interface(struct netcp_intf *netcp)
>  {
> @@ -267,8 +256,13 @@ static int netcp_module_probe(struct netcp_device *netcp_device,
>  	}
> 
>  	for_each_available_child_of_node(devices, child) {
> -		const char *name = netcp_node_name(child);
> +		const char *name;
> +		char node_name[32];
> 
> +		if (of_property_read_string(node, "label", &name) < 0) {
> +			snprintf(node_name, sizeof(node_name), "%pOFn", child);
> +			name = node_name;
> +		}
>  		if (!strcasecmp(module->name, name))
>  			break;
>  	}
> @@ -2209,8 +2203,8 @@ static int netcp_probe(struct platform_device *pdev)
>  	for_each_available_child_of_node(interfaces, child) {
>  		ret = netcp_create_interface(netcp_device, child);
>  		if (ret) {
> -			dev_err(dev, "could not create interface(%s)\n",
> -				child->name);
> +			dev_err(dev, "could not create interface(%pOFn)\n",
> +				child);
>  			goto probe_quit_interface;
>  		}
>  	}
> diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
> index 72b98e27c992..0397ccb6597e 100644
> --- a/drivers/net/ethernet/ti/netcp_ethss.c
> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
> @@ -3137,15 +3137,15 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
>  	for_each_child_of_node(node, port) {
>  		slave = devm_kzalloc(dev, sizeof(*slave), GFP_KERNEL);
>  		if (!slave) {
> -			dev_err(dev, "memory alloc failed for secondary port(%s), skipping...\n",
> -				port->name);
> +			dev_err(dev, "memory alloc failed for secondary port(%pOFn), skipping...\n",
> +				port);
>  			continue;
>  		}
> 
>  		if (init_slave(gbe_dev, slave, port)) {
>  			dev_err(dev,
> -				"Failed to initialize secondary port(%s), skipping...\n",
> -				port->name);
> +				"Failed to initialize secondary port(%pOFn), skipping...\n",
> +				port);
>  			devm_kfree(dev, slave);
>  			continue;
>  		}
> @@ -3239,8 +3239,8 @@ static int set_xgbe_ethss10_priv(struct gbe_priv *gbe_dev,
>  	ret = of_address_to_resource(node, XGBE_SS_REG_INDEX, &res);
>  	if (ret) {
>  		dev_err(gbe_dev->dev,
> -			"Can't xlate xgbe of node(%s) ss address at %d\n",
> -			node->name, XGBE_SS_REG_INDEX);
> +			"Can't xlate xgbe of node(%pOFn) ss address at %d\n",
> +			node, XGBE_SS_REG_INDEX);
>  		return ret;
>  	}
> 
> @@ -3254,8 +3254,8 @@ static int set_xgbe_ethss10_priv(struct gbe_priv *gbe_dev,
>  	ret = of_address_to_resource(node, XGBE_SM_REG_INDEX, &res);
>  	if (ret) {
>  		dev_err(gbe_dev->dev,
> -			"Can't xlate xgbe of node(%s) sm address at %d\n",
> -			node->name, XGBE_SM_REG_INDEX);
> +			"Can't xlate xgbe of node(%pOFn) sm address at %d\n",
> +			node, XGBE_SM_REG_INDEX);
>  		return ret;
>  	}
> 
> @@ -3269,8 +3269,8 @@ static int set_xgbe_ethss10_priv(struct gbe_priv *gbe_dev,
>  	ret = of_address_to_resource(node, XGBE_SERDES_REG_INDEX, &res);
>  	if (ret) {
>  		dev_err(gbe_dev->dev,
> -			"Can't xlate xgbe serdes of node(%s) address at %d\n",
> -			node->name, XGBE_SERDES_REG_INDEX);
> +			"Can't xlate xgbe serdes of node(%pOFn) address at %d\n",
> +			node, XGBE_SERDES_REG_INDEX);
>  		return ret;
>  	}
> 
> @@ -3347,8 +3347,8 @@ static int get_gbe_resource_version(struct gbe_priv *gbe_dev,
>  	ret = of_address_to_resource(node, GBE_SS_REG_INDEX, &res);
>  	if (ret) {
>  		dev_err(gbe_dev->dev,
> -			"Can't translate of node(%s) of gbe ss address at %d\n",
> -			node->name, GBE_SS_REG_INDEX);
> +			"Can't translate of node(%pOFn) of gbe ss address at %d\n",
> +			node, GBE_SS_REG_INDEX);
>  		return ret;
>  	}
> 
> @@ -3372,8 +3372,8 @@ static int set_gbe_ethss14_priv(struct gbe_priv *gbe_dev,
>  	ret = of_address_to_resource(node, GBE_SGMII34_REG_INDEX, &res);
>  	if (ret) {
>  		dev_err(gbe_dev->dev,
> -			"Can't translate of gbe node(%s) address at index %d\n",
> -			node->name, GBE_SGMII34_REG_INDEX);
> +			"Can't translate of gbe node(%pOFn) address at index %d\n",
> +			node, GBE_SGMII34_REG_INDEX);
>  		return ret;
>  	}
> 
> @@ -3388,8 +3388,8 @@ static int set_gbe_ethss14_priv(struct gbe_priv *gbe_dev,
>  	ret = of_address_to_resource(node, GBE_SM_REG_INDEX, &res);
>  	if (ret) {
>  		dev_err(gbe_dev->dev,
> -			"Can't translate of gbe node(%s) address at index %d\n",
> -			node->name, GBE_SM_REG_INDEX);
> +			"Can't translate of gbe node(%pOFn) address at index %d\n",
> +			node, GBE_SM_REG_INDEX);
>  		return ret;
>  	}
> 
> @@ -3498,8 +3498,8 @@ static int set_gbenu_ethss_priv(struct gbe_priv *gbe_dev,
>  	ret = of_address_to_resource(node, GBENU_SM_REG_INDEX, &res);
>  	if (ret) {
>  		dev_err(gbe_dev->dev,
> -			"Can't translate of gbenu node(%s) addr at index %d\n",
> -			node->name, GBENU_SM_REG_INDEX);
> +			"Can't translate of gbenu node(%pOFn) addr at index %d\n",
> +			node, GBENU_SM_REG_INDEX);
>  		return ret;
>  	}
> 
> @@ -3642,7 +3642,7 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
>  		ret = netcp_xgbe_serdes_init(gbe_dev->xgbe_serdes_regs,
>  					     gbe_dev->ss_regs);
>  	} else {
> -		dev_err(dev, "unknown GBE node(%s)\n", node->name);
> +		dev_err(dev, "unknown GBE node(%pOFn)\n", node);
>  		ret = -ENODEV;
>  	}
> 
> @@ -3667,8 +3667,8 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
>  	for_each_child_of_node(interfaces, interface) {
>  		ret = of_property_read_u32(interface, "slave-port", &slave_num);
>  		if (ret) {
> -			dev_err(dev, "missing slave-port parameter, skipping interface configuration for %s\n",
> -				interface->name);
> +			dev_err(dev, "missing slave-port parameter, skipping interface configuration for %pOFn\n",
> +				interface);
>  			continue;
>  		}
>  		gbe_dev->num_slaves++;
> --
> 2.17.1


