Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8B5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5908420858
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8YDohol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5908420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbeKQLSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeKQLSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:18:20 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF17220858;
        Sat, 17 Nov 2018 01:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542416619;
        bh=x6O8IynTaAxPQnIMJCZHqt8Ef8Th2CPtYWut4ZQeOwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k8YDoholHDkIOSpXmivVOjiU1ZJ4tLb0MxNL5ozf6Ue9DL4NpeZktNBqz+j1MfDdb
         hNIiW0TD/SG8d+Z6Z2/uEVdeiDxKuBBc2B1jvNHOLM+f5GkvBlwV9WBcXXARhqP3rl
         2HC63nJwhu6JbGiOWslx5w3vS24YNf6Tmd2xh8jY=
Received: by mail-wm1-f49.google.com with SMTP id r11-v6so258009wmb.2;
        Fri, 16 Nov 2018 17:03:38 -0800 (PST)
X-Gm-Message-State: AGRZ1gLV2YSuujNUu3JkvCVH3jnY2DWSIFTlaBCuaxFJTJIbRGQTBBtH
        Ai6JIh3Fx337LVRsXVhtMV8MmKY4kKp0BiweCWY=
X-Google-Smtp-Source: AJdET5ethw38XTu5/7FAjZFXxUpY092cIq7lr1VcOLg/M6YY+4j0FnQXMieMMiIpGRKNkjA5+oU5lwfJkTiDOW5QVjU=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr305238wmh.92.1542416617118;
 Fri, 16 Nov 2018 17:03:37 -0800 (PST)
MIME-Version: 1.0
References: <1542359926-28800-1-git-send-email-biao.huang@mediatek.com>
In-Reply-To: <1542359926-28800-1-git-send-email-biao.huang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Fri, 16 Nov 2018 17:03:25 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzq_4w656HpUYMNDp64e=0mKDGvs46d4fq61wp1GAyzmvA@mail.gmail.com>
Message-ID: <CAGp9Lzq_4w656HpUYMNDp64e=0mKDGvs46d4fq61wp1GAyzmvA@mail.gmail.com>
Subject: Re: [v3, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
To:     biao.huang@mediatek.com
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, nelson.chang@mediatek.com,
        andrew@lunn.ch, netdev@vger.kernel.org, liguo.zhang@mediatek.com,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        joabreu@synopsys.com, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 wi
On Fri, Nov 16, 2018 at 1:19 AM Biao Huang <biao.huang@mediatek.com> wrote:
>
> Add Ethernet support for MediaTek SoCs from the mt2712 family
>
> Change-Id: Id3c535627088227793bd36405994edf2dc765e6a

Drop change-Id

> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  383 ++++++++++++++++++++
>  3 files changed, 392 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index edf2036..28a7a28 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -75,6 +75,14 @@ config DWMAC_LPC18XX
>         ---help---
>           Support for NXP LPC18xx/43xx DWMAC Ethernet.
>
> +config DWMAC_MEDIATEK
> +       tristate "MediaTek MT27xx GMAC support"
> +       depends on OF && (ARCH_MEDIATEK || COMPILE_TEST)
> +       help
> +         Support for MediaTek GMAC Ethernet controller.
> +
> +         This selects the MT2712 SoC support for the stmmac driver.
> +
>  config DWMAC_MESON
>         tristate "Amlogic Meson dwmac support"
>         default ARCH_MESON
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index 99967a8..bf09701 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_STMMAC_PLATFORM) += stmmac-platform.o
>  obj-$(CONFIG_DWMAC_ANARION)    += dwmac-anarion.o
>  obj-$(CONFIG_DWMAC_IPQ806X)    += dwmac-ipq806x.o
>  obj-$(CONFIG_DWMAC_LPC18XX)    += dwmac-lpc18xx.o
> +obj-$(CONFIG_DWMAC_MEDIATEK)   += dwmac-mediatek.o
>  obj-$(CONFIG_DWMAC_MESON)      += dwmac-meson.o dwmac-meson8b.o
>  obj-$(CONFIG_DWMAC_OXNAS)      += dwmac-oxnas.o
>  obj-$(CONFIG_DWMAC_ROCKCHIP)   += dwmac-rk.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> new file mode 100644
> index 0000000..a80b3e0
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_net.h>
> +#include <linux/regmap.h>
> +#include <linux/stmmac.h>
> +
> +#include "stmmac.h"
> +#include "stmmac_platform.h"
> +
> +/* Peri Configuration register */
> +#define PERI_ETH_PHY_INTF_SEL  0x418
> +#define PHY_INTF_MII_GMII      0
> +#define PHY_INTF_RGMII         1
> +#define PHY_INTF_RMII          4
> +#define RMII_CLK_SRC_RXC       BIT(4)
> +#define RMII_CLK_SRC_INTERNAL  BIT(5)
> +
> +#define PERI_ETH_PHY_DLY       0x428
> +#define PHY_DLY_GTXC_INV       BIT(6)
> +#define PHY_DLY_GTXC_ENABLE    BIT(5)
> +#define PHY_DLY_GTXC_STAGES    GENMASK(4, 0)
> +#define PHY_DLY_TXC_INV                BIT(20)
> +#define PHY_DLY_TXC_ENABLE     BIT(19)
> +#define PHY_DLY_TXC_STAGES     GENMASK(18, 14)
> +#define PHY_DLY_TXC_SHIFT      14
> +#define PHY_DLY_RXC_INV                BIT(13)
> +#define PHY_DLY_RXC_ENABLE     BIT(12)
> +#define PHY_DLY_RXC_STAGES     GENMASK(11, 7)
> +#define PHY_DLY_RXC_SHIFT      7
> +
> +#define PERI_ETH_DLY_FINE      0x800
> +#define ETH_RMII_DLY_TX_INV    BIT(2)
> +#define ETH_FINE_DLY_GTXC      BIT(1)
> +#define ETH_FINE_DLY_RXC       BIT(0)
> +
> +enum dwmac_clks_map {
> +       DWMAC_CLK_AXI_DRAM,
> +       DWMAC_CLK_APB_REG,
> +       DWMAC_CLK_MAC_EXT,
> +       DWMAC_CLK_MAC_PARENT,
> +       DWMAC_CLK_PTP_REF,
> +       DWMAC_CLK_PTP_PARENT,
> +       DWMAC_CLK_PTP_TOP,
> +       DWMAC_CLK_MAX
> +};
> +
> +struct mac_delay_struct {
> +       u32 tx_delay;
> +       u32 rx_delay;
> +       u32 tx_inv;
> +       u32 rx_inv;
> +};
> +
> +struct mediatek_dwmac_plat_data {
> +       struct device *dev;
> +       struct regmap *peri_regmap;
> +       struct clk *clks[DWMAC_CLK_MAX];
> +       struct device_node *np;
> +       int phy_mode;
> +       struct mac_delay_struct mac_delay;
> +       const struct mediatek_dwmac_variant *variant;
> +       int fine_tune;
> +       int rmii_rxc;
> +};
> +
> +struct mediatek_dwmac_variant {
> +       int (*dwmac_config_dt)(struct mediatek_dwmac_plat_data *plat);
> +       int (*dwmac_enable_clks)(struct mediatek_dwmac_plat_data *plat);
> +       void (*dwmac_disable_clks)(struct mediatek_dwmac_plat_data *plat);

Each variant usually can reuse the same config_dt, enable/disable_clks function.

> +       u32 rx_delay_max;
> +       u32 tx_delay_max;
> +};
> +
> +static const char * const mediatek_dwmac_clks_name[] = {
> +       "axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> +};
> +
> +static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat)

Kconfig indicates it's a mt27xx driver. so it's good if there is a
more generic prefix.

> +{
> +       int rmii_rxc = plat->rmii_rxc ? RMII_CLK_SRC_RXC : 0;
> +       u32 intf_val = 0;
> +
> +       /* select phy interface in top control domain */
> +       switch (plat->phy_mode) {
> +       case PHY_INTERFACE_MODE_MII:
> +               intf_val |= PHY_INTF_MII_GMII;
> +               break;
> +       case PHY_INTERFACE_MODE_RMII:
> +               intf_val |= PHY_INTF_RMII;
> +               intf_val |= rmii_rxc;
> +               break;
> +       case PHY_INTERFACE_MODE_RGMII:
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +               intf_val |= PHY_INTF_RGMII;
> +               break;
> +       default:
> +               dev_err(plat->dev, "phy interface not supported\n");
> +               return -EINVAL;
> +       }
> +
> +       regmap_write(plat->peri_regmap, PERI_ETH_PHY_INTF_SEL, intf_val);
> +
> +       return 0;
> +}
> +
> +static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
> +{
> +       struct mac_delay_struct *mac_delay = &plat->mac_delay;
> +       u32 delay_val = 0;
> +       u32 fine_val = 0;
> +
> +       switch (plat->phy_mode) {
> +       case PHY_INTERFACE_MODE_MII:
> +               delay_val |= mac_delay->tx_delay ? PHY_DLY_TXC_ENABLE : 0;
> +               delay_val |= (mac_delay->tx_delay << PHY_DLY_TXC_SHIFT) &
> +                            PHY_DLY_TXC_STAGES;
> +               delay_val |= mac_delay->tx_inv ? PHY_DLY_TXC_INV : 0;
> +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> +                            PHY_DLY_RXC_STAGES;
> +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> +               break;
> +       case PHY_INTERFACE_MODE_RMII:
> +               if (plat->rmii_rxc) {
> +                       delay_val |= mac_delay->rx_delay ?
> +                                    PHY_DLY_RXC_ENABLE : 0;
> +                       delay_val |= (mac_delay->rx_delay <<
> +                                     PHY_DLY_RXC_SHIFT) & PHY_DLY_RXC_STAGES;
> +                       delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> +                       fine_val |= mac_delay->tx_inv ?
> +                                    ETH_RMII_DLY_TX_INV : 0;
> +               } else {
> +                       delay_val |= mac_delay->rx_delay ?
> +                                    PHY_DLY_TXC_ENABLE : 0;
> +                       delay_val |= (mac_delay->rx_delay <<
> +                                    PHY_DLY_TXC_SHIFT) & PHY_DLY_TXC_STAGES;
> +                       delay_val |= mac_delay->rx_inv ? PHY_DLY_TXC_INV : 0;
> +                       fine_val |= mac_delay->tx_inv ?
> +                                    ETH_RMII_DLY_TX_INV : 0;
> +               }
> +               break;
> +       case PHY_INTERFACE_MODE_RGMII:
> +               fine_val = plat->fine_tune ?
> +                           (ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC) : 0;
> +               delay_val |= mac_delay->tx_delay ? PHY_DLY_GTXC_ENABLE : 0;
> +               delay_val |= mac_delay->tx_delay & PHY_DLY_GTXC_STAGES;
> +               delay_val |= mac_delay->tx_inv ? PHY_DLY_GTXC_INV : 0;
> +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> +                            PHY_DLY_RXC_STAGES;
> +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> +               break;
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +               fine_val = plat->fine_tune ? ETH_FINE_DLY_RXC : 0;
> +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> +                            PHY_DLY_RXC_STAGES;
> +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> +               break;
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +               fine_val = plat->fine_tune ? ETH_FINE_DLY_GTXC : 0;
> +               delay_val |= mac_delay->tx_delay ? PHY_DLY_GTXC_ENABLE : 0;
> +               delay_val |= mac_delay->tx_delay & PHY_DLY_GTXC_STAGES;
> +               delay_val |= mac_delay->tx_inv ? PHY_DLY_GTXC_INV : 0;
> +               break;
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +               break;
> +       default:
> +               dev_err(plat->dev, "phy interface not supported\n");
> +               return -EINVAL;
> +       }
> +       regmap_write(plat->peri_regmap, PERI_ETH_PHY_DLY, delay_val);
> +       regmap_write(plat->peri_regmap, PERI_ETH_DLY_FINE, fine_val);
> +
> +       return 0;
> +}
> +
> +static int mt2712_get_clks(struct mediatek_dwmac_plat_data *plat)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(plat->clks); i++) {
> +               plat->clks[i] = devm_clk_get(plat->dev,
> +                                            mediatek_dwmac_clks_name[i]);
> +               if (IS_ERR(plat->clks[i]))
> +                       return PTR_ERR(plat->clks[i]);
> +       }

can we use devm_clk_bulk_get?

> +
> +       return 0;
> +}
> +
> +static int mt2712_enable_clks(struct mediatek_dwmac_plat_data *plat)
> +{
> +       int clk, ret;
> +
> +       for (clk = 0; clk < DWMAC_CLK_MAX ; clk++) {
> +               ret = clk_prepare_enable(plat->clks[clk]);
> +               if (ret)
> +                       goto err_disable_clks;
> +       }

can we use clk_bulk_enable?

> +
> +       ret = clk_set_parent(plat->clks[DWMAC_CLK_MAC_EXT], plat->clks[DWMAC_CLK_MAC_PARENT]);
> +       if (ret)
> +               goto err_disable_clks;
> +
> +       ret = clk_set_parent(plat->clks[DWMAC_CLK_PTP_REF], plat->clks[DWMAC_CLK_PTP_PARENT]);
> +       if (ret)
> +               goto err_disable_clks;
> +

I guess clk_set_parent can be trimmed if we involve assigned-clocks,
assigned-clock-parents, assigned-clock-rates in the dts

> +       return 0;
> +
> +err_disable_clks:
> +       while (--clk >= 0)
> +               clk_disable_unprepare(plat->clks[clk]);
> +

clk_bulk_enable would take care about the failed case

> +       return ret;
> +}
> +
> +static void mt2712_disable_clks(struct mediatek_dwmac_plat_data *plat)
> +{
> +       int clk;
> +
> +       for (clk = DWMAC_CLK_MAX - 1; clk >= 0; clk--)
> +               clk_disable_unprepare(plat->clks[clk]);
> +}

can we use clk_bulk_disable ?

> +
> +static int mt2712_config_dt(struct mediatek_dwmac_plat_data *plat)
> +{
> +       u32 tx_delay, rx_delay;
> +
> +       plat->peri_regmap = syscon_regmap_lookup_by_compatible("mediatek,mt2712-pericfg");

the driver would be not generic enough if we assigned a specific
string into here.
how about apply syscon_regmap_lookup_by_phandle in here?

> +       if (IS_ERR(plat->peri_regmap)) {
> +               dev_err(plat->dev, "Failed to get pericfg syscon\n");
> +               return PTR_ERR(plat->peri_regmap);
> +       }
> +
> +       if (!of_property_read_u32(plat->np, "tx-delay", &tx_delay)) {
> +               if (tx_delay < plat->variant->tx_delay_max) {
> +                       plat->mac_delay.tx_delay = tx_delay;
> +               } else {
> +                       dev_err(plat->dev, "Invalid TX clock delay: %d\n", tx_delay);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       if (!of_property_read_u32(plat->np, "rx-delay", &rx_delay)) {
> +               if (rx_delay < plat->variant->rx_delay_max) {
> +                       plat->mac_delay.rx_delay = rx_delay;
> +               } else {
> +                       dev_err(plat->dev, "Invalid RX clock delay: %d\n", rx_delay);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       plat->mac_delay.tx_inv = of_property_read_bool(plat->np, "txc-inverse");
> +
can we drop the empty line?

> +       plat->mac_delay.rx_inv = of_property_read_bool(plat->np, "rxc-inverse");
> +
can we drop the empty line?

> +       plat->fine_tune = of_property_read_bool(plat->np, "fine-tune");
> +
can we drop the empty line?

> +       plat->rmii_rxc = of_property_read_bool(plat->np, "rmii-rxc");
> +
> +       mt2712_set_interface(plat);
> +
> +       mt2712_set_delay(plat);
> +
> +       return mt2712_get_clks(plat);
> +}
> +
> +static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
> +               .dwmac_config_dt = mt2712_config_dt,
> +               .dwmac_enable_clks = mt2712_enable_clks,
> +               .dwmac_disable_clks = mt2712_disable_clks,
> +               .rx_delay_max = 32,
> +               .tx_delay_max = 32,
> +};

I thought we add the variant structure when the SoC variant is really in.

> +
> +static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
> +{
> +       const struct mediatek_dwmac_variant *variant = plat->variant;
> +
> +       /* Set the DMA mask, 4GB mode enabled */
> +       dma_set_mask_and_coherent(plat->dev, DMA_BIT_MASK(33));
> +
> +       return variant->dwmac_config_dt(plat);
> +}
> +
> +static int mediatek_dwmac_init(struct platform_device *pdev, void *priv)
> +{
> +       struct mediatek_dwmac_plat_data *plat = priv;
> +       const struct mediatek_dwmac_variant *variant = plat->variant;
> +
> +       return variant->dwmac_enable_clks(plat);
> +}
> +
> +static void mediatek_dwmac_exit(struct platform_device *pdev, void *priv)
> +{
> +       struct mediatek_dwmac_plat_data *plat = priv;
> +       const struct mediatek_dwmac_variant *variant = plat->variant;
> +
> +       variant->dwmac_disable_clks(plat);
> +}
> +
> +static int mediatek_dwmac_probe(struct platform_device *pdev)
> +{
> +       int ret = 0;
> +       struct plat_stmmacenet_data *plat_dat;
> +       struct stmmac_resources stmmac_res;
> +       struct mediatek_dwmac_plat_data *priv_plat;

sorting these declarations into reverse Xmas tree seems to be good

> +
> +       priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
> +       if (!priv_plat)
> +               return -ENOMEM;
> +
> +       priv_plat->variant = of_device_get_match_data(&pdev->dev);
> +       if (!priv_plat->variant) {
> +               dev_err(&pdev->dev, "Missing dwmac-mediatek variant\n");
> +               return -EINVAL;
> +       }
> +
> +       priv_plat->dev = &pdev->dev;
> +       priv_plat->np = pdev->dev.of_node;
> +       priv_plat->phy_mode = of_get_phy_mode(priv_plat->np);
> +
> +       ret = mediatek_dwmac_config_dt(priv_plat);
> +       if (ret)
> +               return ret;
> +
> +       ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +       if (ret)
> +               return ret;
> +
> +       plat_dat = stmmac_probe_config_dt(pdev, &stmmac_res.mac);
> +       if (IS_ERR(plat_dat))
> +               return PTR_ERR(plat_dat);
> +
> +       plat_dat->interface = priv_plat->phy_mode;
> +       /* clk_csr_i = 250-300MHz & MDC = clk_csr_i/124 */
> +       plat_dat->clk_csr = 5;
> +       plat_dat->has_gmac4 = 1;
> +       plat_dat->has_gmac = 0;
> +       plat_dat->pmt = 0;
> +       plat_dat->maxmtu = ETH_DATA_LEN;
> +       plat_dat->bsp_priv = priv_plat;
> +       plat_dat->init = mediatek_dwmac_init;
> +       plat_dat->exit = mediatek_dwmac_exit;
> +       mediatek_dwmac_init(pdev, priv_plat);
> +
> +       ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> +       if (ret) {
> +               stmmac_remove_config_dt(pdev, plat_dat);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id mediatek_dwmac_match[] = {
> +       { .compatible = "mediatek,mt2712-gmac",
> +         .data = &mt2712_gmac_variant },
> +       { }
> +};
> +
> +MODULE_DEVICE_TABLE(of, mediatek_dwmac_match);
> +
> +static struct platform_driver mediatek_dwmac_driver = {
> +       .probe  = mediatek_dwmac_probe,
> +       .remove = stmmac_pltfr_remove,
> +       .driver = {
> +               .name           = "dwmac-mediatek",
> +               .pm             = &stmmac_pltfr_pm_ops,
> +               .of_match_table = mediatek_dwmac_match,
> +       },
> +};
> +module_platform_driver(mediatek_dwmac_driver);
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
