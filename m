Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B93C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEABE20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEABE20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439407AbeKWM7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:59:52 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:37077 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727343AbeKWM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:59:52 -0500
X-UUID: 75967576f72e4c3990d65c7339cca4bb-20181123
X-UUID: 75967576f72e4c3990d65c7339cca4bb-20181123
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 749348921; Fri, 23 Nov 2018 10:17:31 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 23 Nov
 2018 10:17:30 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 23 Nov 2018 10:17:29 +0800
Message-ID: <1542939448.24219.95.camel@mhfsdcap03>
Subject: Re: [v5, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for
 mt2712
From:   biao huang <biao.huang@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <nelson.chang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
        <netdev@vger.kernel.org>, Liguo Zhang <liguo.zhang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <joabreu@synopsys.com>, <linux-mediatek@lists.infradead.org>,
        <honghui.zhang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 23 Nov 2018 10:17:28 +0800
In-Reply-To: <CAGp9LzoJTVm4OP+SRWCDk0TUmU5jNMFCsT_yyURXzXxjTF+-=g@mail.gmail.com>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
         <1542882521-18874-2-git-send-email-biao.huang@mediatek.com>
         <CAGp9LzoJTVm4OP+SRWCDk0TUmU5jNMFCsT_yyURXzXxjTF+-=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sean,
	Thanks for your comments.

On Thu, 2018-11-22 at 16:54 -0800, Sean Wang wrote:
> On Thu, Nov 22, 2018 at 2:29 AM Biao Huang <biao.huang@mediatek.com> wrote:
> >
> > Add Ethernet support for MediaTek SoCs from the mt2712 family
> >
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
> >  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  364 ++++++++++++++++++++
> >  3 files changed, 373 insertions(+)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > index 324049e..6209cc1 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -75,6 +75,14 @@ config DWMAC_LPC18XX
> >         ---help---
> >           Support for NXP LPC18xx/43xx DWMAC Ethernet.
> >
> > +config DWMAC_MEDIATEK
> > +       tristate "MediaTek MT27xx GMAC support"
> > +       depends on OF && (ARCH_MEDIATEK || COMPILE_TEST)
> > +       help
> > +         Support for MediaTek GMAC Ethernet controller.
> > +
> > +         This selects the MT2712 SoC support for the stmmac driver.
> > +
> >  config DWMAC_MESON
> >         tristate "Amlogic Meson dwmac support"
> >         default ARCH_MESON
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > index 99967a8..bf09701 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_STMMAC_PLATFORM) += stmmac-platform.o
> >  obj-$(CONFIG_DWMAC_ANARION)    += dwmac-anarion.o
> >  obj-$(CONFIG_DWMAC_IPQ806X)    += dwmac-ipq806x.o
> >  obj-$(CONFIG_DWMAC_LPC18XX)    += dwmac-lpc18xx.o
> > +obj-$(CONFIG_DWMAC_MEDIATEK)   += dwmac-mediatek.o
> >  obj-$(CONFIG_DWMAC_MESON)      += dwmac-meson.o dwmac-meson8b.o
> >  obj-$(CONFIG_DWMAC_OXNAS)      += dwmac-oxnas.o
> >  obj-$(CONFIG_DWMAC_ROCKCHIP)   += dwmac-rk.o
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > new file mode 100644
> > index 0000000..dd8d4cc
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > @@ -0,0 +1,364 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + */
> > +#include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_net.h>
> > +#include <linux/regmap.h>
> > +#include <linux/stmmac.h>
> > +
> > +#include "stmmac.h"
> > +#include "stmmac_platform.h"
> > +
> > +/* Peri Configuration register for mt2712 */
> > +#define PERI_ETH_PHY_INTF_SEL  0x418
> > +#define PHY_INTF_MII_GMII      0
> > +#define PHY_INTF_RGMII         1
> > +#define PHY_INTF_RMII          4
> > +#define RMII_CLK_SRC_RXC       BIT(4)
> > +#define RMII_CLK_SRC_INTERNAL  BIT(5)
> > +
> > +#define PERI_ETH_PHY_DLY       0x428
> > +#define PHY_DLY_GTXC_INV       BIT(6)
> > +#define PHY_DLY_GTXC_ENABLE    BIT(5)
> > +#define PHY_DLY_GTXC_STAGES    GENMASK(4, 0)
> > +#define PHY_DLY_TXC_INV                BIT(20)
> > +#define PHY_DLY_TXC_ENABLE     BIT(19)
> > +#define PHY_DLY_TXC_STAGES     GENMASK(18, 14)
> > +#define PHY_DLY_TXC_SHIFT      14
> > +#define PHY_DLY_RXC_INV                BIT(13)
> > +#define PHY_DLY_RXC_ENABLE     BIT(12)
> > +#define PHY_DLY_RXC_STAGES     GENMASK(11, 7)
> > +#define PHY_DLY_RXC_SHIFT      7
> > +
> > +#define PERI_ETH_DLY_FINE      0x800
> > +#define ETH_RMII_DLY_TX_INV    BIT(2)
> > +#define ETH_FINE_DLY_GTXC      BIT(1)
> > +#define ETH_FINE_DLY_RXC       BIT(0)
> > +
> > +struct mac_delay_struct {
> > +       u32 tx_delay;
> > +       u32 rx_delay;
> > +       u32 tx_inv;
> bool should be enough
yes
> 
> > +       u32 rx_inv;
> bool should be enough
yes
> 
> > +};
> > +
> > +struct mediatek_dwmac_plat_data {
> > +       const struct mediatek_dwmac_variant *variant;
> > +       struct mac_delay_struct mac_delay;
> > +       struct clk_bulk_data *clks;
> > +       struct device_node *np;
> > +       struct regmap *peri_regmap;
> > +       struct device *dev;
> > +       int fine_tune;
> bool
> 
yes
> > +       int phy_mode;
> > +       int rmii_rxc;
> bool
yes
> 
> > +};
> > +
> > +struct mediatek_dwmac_variant {
> > +       int (*dwmac_set_phy_interface)(struct mediatek_dwmac_plat_data *plat);
> > +       int (*dwmac_set_delay)(struct mediatek_dwmac_plat_data *plat);
> > +
> > +       /* clock ids to be requested */
> > +       const char * const *clk_list;
> > +       int num_clks;
> > +
> > +       u32 dma_bit_mask;
> > +       u32 rx_delay_max;
> > +       u32 tx_delay_max;
> > +};
> > +
> > +/* list of clocks required for mac */
> > +static const char * const mt2712_dwmac_clk_l[] = {
> > +       "axi", "apb", "mac_main", "ptp_ref"
> > +};
> > +
> > +static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat)
> > +{
> > +       int rmii_rxc = plat->rmii_rxc ? RMII_CLK_SRC_RXC : 0;
> > +       u32 intf_val = 0;
> > +
> > +       /* select phy interface in top control domain */
> > +       switch (plat->phy_mode) {
> > +       case PHY_INTERFACE_MODE_MII:
> > +               intf_val |= PHY_INTF_MII_GMII;
> > +               break;
> > +       case PHY_INTERFACE_MODE_RMII:
> > +               intf_val |= PHY_INTF_RMII;
> > +               intf_val |= rmii_rxc;
> how about putting into one line such as intf_val |= (PHY_INTF_RMII | rmii_rxc) ?
> 
ok, will change in next version.
> > +               break;
> > +       case PHY_INTERFACE_MODE_RGMII:
> > +       case PHY_INTERFACE_MODE_RGMII_TXID:
> > +       case PHY_INTERFACE_MODE_RGMII_RXID:
> > +       case PHY_INTERFACE_MODE_RGMII_ID:
> > +               intf_val |= PHY_INTF_RGMII;
> > +               break;
> > +       default:
> > +               dev_err(plat->dev, "phy interface not supported\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       regmap_write(plat->peri_regmap, PERI_ETH_PHY_INTF_SEL, intf_val);
> > +
> > +       return 0;
> > +}
> > +
> > +static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
> > +{
> > +       struct mac_delay_struct *mac_delay = &plat->mac_delay;
> > +       u32 delay_val = 0;
> > +       u32 fine_val = 0;
> The same type declaration can be put into the one line
> 
Got it.
> > +
> > +       switch (plat->phy_mode) {
> 
> There exists some room for code optimization in the switch statement
> such as PHY_INTERFACE_MODE_MII and PHY_INTERFACE_MODE_RGMII both are
> almost the same and even the configuration for the other PHY modes can
> reuse their partial setup. It appears to be better using a common way
> to set up various PHY modes.
> 
I'll try define a function to handle it.
And how about like this:
	static u32 delay_setting(u32 delay, bool inv, u32 en_bit, u32
clk_shift, u32 clk_mask, u32 inv_bit) {
		u32 value = 0

		value |= delay ? en_bit : 0;
            	value |= (delay << clk_shift) & clk_mask;
              	value |= inv ? inv_bit : 0;
	}

	case PHY_INTERFACE_MODE_MII:
		delay_value |= delay_setting(mac_delay->tx_delay,
					     mac_delay->tx_inv,
					     PHY_DLY_TXC_ENABLE,
					     PHY_DLY_TXC_SHIFT,
					     PHY_DLY_TXC_STAGES,
					     PHY_DLY_TXC_INV);
		delay_value |= delay_setting(mac_delay->rx_delay,
					     mac_delay->rx_inv,
					     PHY_DLY_RXC_ENABLE,
					     PHY_DLY_RXC_SHIFT,
					     PHY_DLY_RXC_STAGES,
					     PHY_DLY_RXC_INV);

	case PHY_INTERFACE_MODE_RMII:
		if (plat->rmii_rxc) {
		     delay_value |= delay_setting(mac_delay->rx_delay,
					         mac_delay->rx_inv,
					         PHY_DLY_RXC_ENABLE,
					         PHY_DLY_RXC_SHIFT,
					         PHY_DLY_RXC_STAGES,
					         PHY_DLY_RXC_INV);
		    fine_val |= mac_delay->tx_inv ?
                                   ETH_RMII_DLY_TX_INV : 0;
		} else {
		     delay_value |= delay_setting(mac_delay->rx_delay,
					         mac_delay->rx_inv,
					         PHY_DLY_TXC_ENABLE,
					         PHY_DLY_TXC_SHIFT,
					         PHY_DLY_TXC_STAGES,
					         PHY_DLY_TXC_INV);
		    fine_val |= mac_delay->tx_inv ?
                                   ETH_RMII_DLY_TX_INV : 0;
		}
	case PHY_INTERFACE_MODE_RGMII:
              fine_val = plat->fine_tune ?
                          (ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC) : 0;
	      delay_value |= delay_setting(mac_delay->tx_delay,
					   mac_delay->tx_inv,
					   PHY_DLY_GTXC_ENABLE,
					   PHY_DLY_GTXC_SHIFT,
					   PHY_DLY_GTXC_STAGES,
					   PHY_DLY_GTXC_INV);
	     delay_value |= delay_setting(mac_delay->rx_delay,
					   mac_delay->rx_inv,
					   PHY_DLY_RXC_ENABLE,
					   PHY_DLY_RXC_SHIFT,
					   PHY_DLY_RXC_STAGES,
					   PHY_DLY_RXC_INV);
	case PHY_INTERFACE_MODE_RGMII_TXID:
              fine_val = plat->fine_tune ? ETH_FINE_DLY_RXC : 0;
	      delay_value |= delay_setting(mac_delay->rx_delay,
					   mac_delay->rx_inv,
					   PHY_DLY_RXC_ENABLE,
					   PHY_DLY_RXC_SHIFT,
					   PHY_DLY_RXC_STAGES,
					   PHY_DLY_RXC_INV);
	case PHY_INTERFACE_MODE_RGMII_RXID:
              fine_val = plat->fine_tune ? ETH_FINE_DLY_GTXC : 0;
	      delay_value |= delay_setting(mac_delay->tx_delay,
					   mac_delay->tx_inv,
					   PHY_DLY_GTXC_ENABLE,
					   PHY_DLY_GTXC_SHIFT,
					   PHY_DLY_GTXC_STAGES,
					   PHY_DLY_GTXC_INV);
	   
> > +       case PHY_INTERFACE_MODE_MII:
> > +               delay_val |= mac_delay->tx_delay ? PHY_DLY_TXC_ENABLE : 0;
> > +               delay_val |= (mac_delay->tx_delay << PHY_DLY_TXC_SHIFT) &
> > +                            PHY_DLY_TXC_STAGES;
> > +               delay_val |= mac_delay->tx_inv ? PHY_DLY_TXC_INV : 0;
> > +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> > +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> > +                            PHY_DLY_RXC_STAGES;
> > +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> > +               break;
> > +       case PHY_INTERFACE_MODE_RMII:
> > +               if (plat->rmii_rxc) {
> > +                       delay_val |= mac_delay->rx_delay ?
> > +                                    PHY_DLY_RXC_ENABLE : 0;
> > +                       delay_val |= (mac_delay->rx_delay <<
> > +                                     PHY_DLY_RXC_SHIFT) & PHY_DLY_RXC_STAGES;
> > +                       delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> > +                       fine_val |= mac_delay->tx_inv ?
> > +                                    ETH_RMII_DLY_TX_INV : 0;
> why is fine_val got from tx_inv?
> 
becase the tx inv will inverse the tx clock inside mac relative to
reference clock from external phy, and this bit is located in the same
register with fine-tune.
maybe I should rename fine_val to avoid misunderstanding.
> > +               } else {
> > +                       delay_val |= mac_delay->rx_delay ?
> > +                                    PHY_DLY_TXC_ENABLE : 0;
> > +                       delay_val |= (mac_delay->rx_delay <<
> > +                                    PHY_DLY_TXC_SHIFT) & PHY_DLY_TXC_STAGES;
> > +                       delay_val |= mac_delay->rx_inv ? PHY_DLY_TXC_INV : 0;
> > +                       fine_val |= mac_delay->tx_inv ?
> > +                                    ETH_RMII_DLY_TX_INV : 0;
> ditto, why is fine_val got from tx_inv?
> 
same as above. ETH_RMII_DLY_TX_INV is only for RMII, and located in the
same register with fine-tune.
> > +               }
> > +               break;
> > +       case PHY_INTERFACE_MODE_RGMII:
> > +               fine_val = plat->fine_tune ?
> > +                           (ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC) : 0;
> > +               delay_val |= mac_delay->tx_delay ? PHY_DLY_GTXC_ENABLE : 0;
> > +               delay_val |= mac_delay->tx_delay & PHY_DLY_GTXC_STAGES;
> > +               delay_val |= mac_delay->tx_inv ? PHY_DLY_GTXC_INV : 0;
> > +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> > +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> > +                            PHY_DLY_RXC_STAGES;
> > +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> > +               break;
> > +       case PHY_INTERFACE_MODE_RGMII_TXID:
> > +               fine_val = plat->fine_tune ? ETH_FINE_DLY_RXC : 0;
> > +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> > +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> > +                            PHY_DLY_RXC_STAGES;
> > +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> why is PHY_INTERFACE_MODE_RGMII_TXID applied with *_RXC_* register
> bits, not with *_TXC_* bits? I'm a little confused about what path the
> register PHY_DLY_RXC_* cause the effects to? MAC to PHY or PHY to MAC?
> 
The PHY_INTERFACE_MODE_RGMII_TXID is defined in
Documentation/networking/phy.txt
means phy will handle delay in tx path, so mac need handle delay in rx
path here.
> > +               break;
> > +       case PHY_INTERFACE_MODE_RGMII_RXID:
> > +               fine_val = plat->fine_tune ? ETH_FINE_DLY_GTXC : 0;
> > +               delay_val |= mac_delay->tx_delay ? PHY_DLY_GTXC_ENABLE : 0;
> > +               delay_val |= mac_delay->tx_delay & PHY_DLY_GTXC_STAGES;
> > +               delay_val |= mac_delay->tx_inv ? PHY_DLY_GTXC_INV : 0;
> ditto, as the above quetion
> 
Similar answer as above.
> > +               break;
> > +       case PHY_INTERFACE_MODE_RGMII_ID:
> > +               break;
> > +       default:
> > +               dev_err(plat->dev, "phy interface not supported\n");
> > +               return -EINVAL;
> > +       }
> > +       regmap_write(plat->peri_regmap, PERI_ETH_PHY_DLY, delay_val);
> > +       regmap_write(plat->peri_regmap, PERI_ETH_DLY_FINE, fine_val);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
> > +               .dwmac_set_phy_interface = mt2712_set_interface,
> > +               .dwmac_set_delay = mt2712_set_delay,
> > +               .clk_list = mt2712_dwmac_clk_l,
> > +               .num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
> > +               .dma_bit_mask = 33,
> > +               .rx_delay_max = 32,
> > +               .tx_delay_max = 32,
> > +};
> > +
> > +static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
> > +{
> > +       u32 tx_delay, rx_delay;
> > +
> > +       plat->peri_regmap = syscon_regmap_lookup_by_phandle(plat->np, "mediatek,pericfg");
> > +       if (IS_ERR(plat->peri_regmap)) {
> > +               dev_err(plat->dev, "Failed to get pericfg syscon\n");
> > +               return PTR_ERR(plat->peri_regmap);
> > +       }
> > +
> > +       plat->phy_mode = of_get_phy_mode(plat->np);
> > +       if (plat->phy_mode < 0) {
> > +               dev_err(plat->dev, "not find phy-mode\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (!of_property_read_u32(plat->np, "mediatek,tx-delay", &tx_delay)) {
> > +               if (tx_delay < plat->variant->tx_delay_max) {
> > +                       plat->mac_delay.tx_delay = tx_delay;
> > +               } else {
> > +                       dev_err(plat->dev, "Invalid TX clock delay: %d\n", tx_delay);
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       if (!of_property_read_u32(plat->np, "mediatek,rx-delay", &rx_delay)) {
> > +               if (rx_delay < plat->variant->rx_delay_max) {
> > +                       plat->mac_delay.rx_delay = rx_delay;
> > +               } else {
> > +                       dev_err(plat->dev, "Invalid RX clock delay: %d\n", rx_delay);
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       plat->mac_delay.tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
> > +       plat->mac_delay.rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
> > +       plat->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");
> > +       plat->rmii_rxc = of_property_read_bool(plat->np, "mediatek,rmii-rxc");
> > +
> > +       return 0;
> > +}
> > +
> > +static int mediatek_dwmac_clk_init(struct mediatek_dwmac_plat_data *plat)
> > +{
> > +       const struct mediatek_dwmac_variant *variant = plat->variant;
> > +       int num = variant->num_clks;
> > +       int i;
> put into the same line seems good
> 
ok
> > +
> > +       plat->clks = devm_kcalloc(plat->dev, num, sizeof(*plat->clks), GFP_KERNEL);
> > +       if (!plat->clks)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < num; i++)
> > +               plat->clks[i].id = variant->clk_list[i];
> > +
> > +       return devm_clk_bulk_get(plat->dev, num, plat->clks);
> > +}
> > +
> > +static int mediatek_dwmac_init(struct platform_device *pdev, void *priv)
> > +{
> > +       struct mediatek_dwmac_plat_data *plat = priv;
> > +       const struct mediatek_dwmac_variant *variant = plat->variant;
> > +       int ret = 0;
> zero initialized seems unnecessary
> 
ok, will not initialized here
> > +
> > +       ret = dma_set_mask_and_coherent(plat->dev, DMA_BIT_MASK(variant->dma_bit_mask));
> > +       if (ret) {
> > +               dev_err(plat->dev, "No suitable DMA available, err = %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = variant->dwmac_set_phy_interface(plat);
> > +       if (ret) {
> > +               dev_err(plat->dev, "failed to set phy interface, err = %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = variant->dwmac_set_delay(plat);
> > +       if (ret) {
> > +               dev_err(plat->dev, "failed to set delay value, err = %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = clk_bulk_prepare_enable(variant->num_clks, plat->clks);
> > +       if (ret) {
> > +               dev_err(plat->dev, "failed to enable clks, err = %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void mediatek_dwmac_exit(struct platform_device *pdev, void *priv)
> > +{
> > +       struct mediatek_dwmac_plat_data *plat = priv;
> > +       const struct mediatek_dwmac_variant *variant = plat->variant;
> > +
> > +       clk_bulk_disable_unprepare(variant->num_clks, plat->clks);
> > +}
> > +
> > +static int mediatek_dwmac_probe(struct platform_device *pdev)
> > +{
> > +       struct mediatek_dwmac_plat_data *priv_plat;
> > +       struct plat_stmmacenet_data *plat_dat;
> > +       struct stmmac_resources stmmac_res;
> > +       int ret = 0;
> zero initialized seems unnecessary
> 
ok, will not initialized here
> > +
> > +       priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
> > +       if (!priv_plat)
> > +               return -ENOMEM;
> > +
> > +       priv_plat->variant = of_device_get_match_data(&pdev->dev);
> > +       if (!priv_plat->variant) {
> > +               dev_err(&pdev->dev, "Missing dwmac-mediatek variant\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       priv_plat->dev = &pdev->dev;
> > +       priv_plat->np = pdev->dev.of_node;
> > +
> > +       ret = mediatek_dwmac_config_dt(priv_plat);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = mediatek_dwmac_clk_init(priv_plat);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > +       if (ret)
> > +               return ret;
> > +
> > +       plat_dat = stmmac_probe_config_dt(pdev, &stmmac_res.mac);
> > +       if (IS_ERR(plat_dat))
> > +               return PTR_ERR(plat_dat);
> > +
> > +       plat_dat->interface = priv_plat->phy_mode;
> > +       /* clk_csr_i = 250-300MHz & MDC = clk_csr_i/124 */
> > +       plat_dat->clk_csr = 5;
> > +       plat_dat->has_gmac4 = 1;
> > +       plat_dat->has_gmac = 0;
> > +       plat_dat->pmt = 0;
> > +       plat_dat->maxmtu = ETH_DATA_LEN;
> > +       plat_dat->bsp_priv = priv_plat;
> > +       plat_dat->init = mediatek_dwmac_init;
> > +       plat_dat->exit = mediatek_dwmac_exit;
> > +       mediatek_dwmac_init(pdev, priv_plat);
> > +
> > +       ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> > +       if (ret) {
> > +               stmmac_remove_config_dt(pdev, plat_dat);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id mediatek_dwmac_match[] = {
> > +       { .compatible = "mediatek,mt2712-gmac",
> > +         .data = &mt2712_gmac_variant },
> > +       { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, mediatek_dwmac_match);
> > +
> > +static struct platform_driver mediatek_dwmac_driver = {
> > +       .probe  = mediatek_dwmac_probe,
> > +       .remove = stmmac_pltfr_remove,
> > +       .driver = {
> > +               .name           = "dwmac-mediatek",
> > +               .pm             = &stmmac_pltfr_pm_ops,
> > +               .of_match_table = mediatek_dwmac_match,
> > +       },
> > +};
> > +module_platform_driver(mediatek_dwmac_driver);
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek


