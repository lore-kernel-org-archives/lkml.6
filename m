Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F352521841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545105020;
	bh=nf9/1bm3hBCP/Y6CurT6Mh3N1LPIZB808p5rFP/voUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wfytAfbfUIH9zthzEvQFbFKSjAk+IEaRnf2S7nxHAPHmYZC0jW4K1Mm5jcJ2BezaK
	 T3c+a+i10JXWwOD0jgToIeLw8vGx8YanyoAL7mgdRRCHfdhc1nFOFzK7bbUGXoTNbG
	 4LExuIovXa90TJMaH5XnxViqO/b9Denhpb9Pq2io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeLRDuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:50:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbeLRDuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:50:18 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8C4F2184B;
        Tue, 18 Dec 2018 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545105017;
        bh=nf9/1bm3hBCP/Y6CurT6Mh3N1LPIZB808p5rFP/voUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Izb3/GFOGJnyrJMxgIQQ7weSJI75nqElZD2I2AbpagDgIFKTa7mwKkJak+2NvWOov
         b6Up+49rZ5yEBoo/uUgAqG/fNbh8sbsOQvVE5uSuE6ZRGKiRc8garfBiJdnYARcQKO
         w8D33SCQsA8eIi/jNDRqFHVACMFzoGLAvXlMZpS0=
Received: by mail-wm1-f50.google.com with SMTP id y139so1185547wmc.5;
        Mon, 17 Dec 2018 19:50:16 -0800 (PST)
X-Gm-Message-State: AA+aEWZ9o13Wqrgkkx70gqDz6HLabJZKNo1DRfPciiSWHLAXpG5J+oZM
        alzFGcMxLBeKAXKv84oPZZOuO1eZrmvqYtiOOO8=
X-Google-Smtp-Source: AFSGD/XaW6U8YNzEALwgfEeQ/wOMZe2gyAQ8A8hBM1fKF440RmRbIXn0yIjf0ozEGePZFPmdwFVfbkjQ3exMNxWZMGM=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr1452607wmu.52.1545105015165;
 Mon, 17 Dec 2018 19:50:15 -0800 (PST)
MIME-Version: 1.0
References: <1545100937-16093-1-git-send-email-biao.huang@mediatek.com> <1545100937-16093-3-git-send-email-biao.huang@mediatek.com>
In-Reply-To: <1545100937-16093-3-git-send-email-biao.huang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 17 Dec 2018 19:49:47 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoWYdQ_PHgHbTmg35EvFY+kdFMZy5Pz7ndpPC0pUZ-uGg@mail.gmail.com>
Message-ID: <CAGp9LzoWYdQ_PHgHbTmg35EvFY+kdFMZy5Pz7ndpPC0pUZ-uGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net-next: stmmac: dwmac-mediatek: remove fine-tune property
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, nelson.chang@mediatek.com,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        Liguo Zhang <liguo.zhang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        joabreu@synopsys.com, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 6:43 PM Biao Huang <biao.huang@mediatek.com> wrote:
>
> 1. remove fine-tune property and related setting to simplify
> the timing adjustment flow.
> 2. set timing value according to the value from device tree,
> and will not care whether PHY insert internal delay.
>
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |   71 +++++++-------------
>  1 file changed, 24 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index e400cbd..801c797 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -44,7 +44,6 @@ struct mac_delay_struct {
>         u32 rx_delay;
>         bool tx_inv;
>         bool rx_inv;
> -       bool fine_tune;
>  };
>
>  struct mediatek_dwmac_plat_data {
> @@ -105,16 +104,28 @@ static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat)
>         return 0;
>  }
>
> -static void mt2712_delay_ps2stage(struct mac_delay_struct *mac_delay)
> +static void mt2712_delay_ps2stage(struct mediatek_dwmac_plat_data *plat)
>  {
> -       if (mac_delay->fine_tune) {
> -               /* 170ps per stage for fine tune delay macro circuit*/
> -               mac_delay->tx_delay /= 170;
> -               mac_delay->rx_delay /= 170;
> -       } else {
> -               /* 550ps per stage for coarse tune delay macro circuit*/
> +       struct mac_delay_struct *mac_delay = &plat->mac_delay;
> +
> +       switch (plat->phy_mode) {
> +       case PHY_INTERFACE_MODE_MII:
> +       case PHY_INTERFACE_MODE_RMII:
> +               /* 550ps per stage for mii/rmii*/
>                 mac_delay->tx_delay /= 550;
>                 mac_delay->rx_delay /= 550;
> +               break;
> +       case PHY_INTERFACE_MODE_RGMII:
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +               /* 170ps per stage for mii/rmii*/

mii/rmii appear to be a typo here.

Additionally, I'd suggest using the capital letters for these abbreviations.

> +               mac_delay->tx_delay /= 170;
> +               mac_delay->rx_delay /= 170;
> +               break;
> +       default:
> +               dev_err(plat->dev, "phy interface not supported\n");
> +               break;
>         }
>  }
>
> @@ -123,7 +134,7 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
>         struct mac_delay_struct *mac_delay = &plat->mac_delay;
>         u32 delay_val = 0, fine_val = 0;
>
> -       mt2712_delay_ps2stage(mac_delay);
> +       mt2712_delay_ps2stage(plat);
>
>         switch (plat->phy_mode) {
>         case PHY_INTERFACE_MODE_MII:
> @@ -167,13 +178,10 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
>                         fine_val = ETH_RMII_DLY_TX_INV;
>                 break;
>         case PHY_INTERFACE_MODE_RGMII:
> -               /* the PHY is not responsible for inserting any internal
> -                * delay by itself in PHY_INTERFACE_MODE_RGMII case,
> -                * so Ethernet MAC will insert delays for both transmit
> -                * and receive path here.
> -                */
> -               if (mac_delay->fine_tune)
> -                       fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
> +       case PHY_INTERFACE_MODE_RGMII_TXID:
> +       case PHY_INTERFACE_MODE_RGMII_RXID:
> +       case PHY_INTERFACE_MODE_RGMII_ID:
> +               fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
>
>                 delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
>                 delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES, mac_delay->tx_delay);
> @@ -183,36 +191,6 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
>                 delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
>                 delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
>                 break;
> -       case PHY_INTERFACE_MODE_RGMII_TXID:
> -               /* the PHY should insert an internal delay for the transmit
> -                * path in PHY_INTERFACE_MODE_RGMII_TXID case,
> -                * so Ethernet MAC will insert the delay for receive path here.
> -                */
> -               if (mac_delay->fine_tune)
> -                       fine_val = ETH_FINE_DLY_RXC;
> -
> -               delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
> -               delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
> -               delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
> -               break;
> -       case PHY_INTERFACE_MODE_RGMII_RXID:
> -               /* the PHY should insert an internal delay for the receive
> -                * path in PHY_INTERFACE_MODE_RGMII_RXID case,
> -                * so Ethernet MAC will insert the delay for transmit path here.
> -                */
> -               if (mac_delay->fine_tune)
> -                       fine_val = ETH_FINE_DLY_GTXC;
> -
> -               delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
> -               delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES, mac_delay->tx_delay);
> -               delay_val |= FIELD_PREP(ETH_DLY_GTXC_INV, mac_delay->tx_inv);
> -               break;
> -       case PHY_INTERFACE_MODE_RGMII_ID:
> -               /* the PHY should insert internal delays for both transmit
> -                * and receive path in PHY_INTERFACE_MODE_RGMII_RXID case,
> -                * so Ethernet MAC will NOT insert any delay here.
> -                */
> -               break;
>         default:
>                 dev_err(plat->dev, "phy interface not supported\n");
>                 return -EINVAL;
> @@ -270,7 +248,6 @@ static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
>
>         mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
>         mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
> -       mac_delay->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");
>         plat->rmii_rxc = of_property_read_bool(plat->np, "mediatek,rmii-rxc");
>
>         return 0;
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
