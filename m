Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF16C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BD920827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oizDAuIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BD920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeJ2S4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:56:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40706 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbeJ2S4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:56:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so7326626wme.5;
        Mon, 29 Oct 2018 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9EIjKMPr46uGAX/p7A8OUDxi20zhkEsgXxmsBW0O0Fw=;
        b=oizDAuIkAImS1VwK+Tw8x/BQ1SFCYxfs2kc/i+1pjvlcydCrwsnM/sTGVD4P3z4CoZ
         cXZu4I/SB9KpoKyBw7Yay1BgXxklnr/oCo2tDXdA6+xLnY6BoHr/cqiXOhNdmatXy2Ip
         N6Q4Y7+PFrn4rVvqYDEhGC2VNHcB8tlrxpQJmUxpA1BtHm9qJ6MUWhfvp3tOaRpyn0Fv
         CK7TfM6hc9Fi30WA8Upxh95V7H8P580YgNbfKXUv6cH/YLoEY2a//Vlx3UXp0L0SWKRV
         sCrJWIrLhGAXjJ4mZ8k9u89LivpdOIw7uyBs89AwL2H0YFdOuHEQU+8s3mFu1fF8Cd0y
         jR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9EIjKMPr46uGAX/p7A8OUDxi20zhkEsgXxmsBW0O0Fw=;
        b=lU7GauTorDOYnC7xnquHy2mcmWUVI/IpxbBVz4dExKhyyIfmj1xuywFMKcq0F03ypf
         d5eM74raIKLIj9own/Zn0hcRdB5E3bjGk4C6J0bCMmzURUibAuOtZVohzgCPUoTBbOls
         8d0XURZbQkv3X4OZx9BbIWP5cE2iprveGuv1rgtkTMYTX6fCDaFOMRYVmQceCO39CgcX
         sSK62YPQ1efaDRsciCNk8H5P4kcydvI8XuJRSl7Zc0WOwG50ggC8fyMuBx5MpmLhCope
         HR3sbReqNdG2L7xRnJCaJvfYL4rqo+QNUmENhz04q7uDxrVBQxGHgcbr1IpT30GF5ARN
         wbZA==
X-Gm-Message-State: AGRZ1gK0shZEUf/th1lnnhhzuutX9qGDc+5jfdHGyoKEZR2p7irAnjHb
        t1pZ0qOiWgM2NUjPDmVOb2c=
X-Google-Smtp-Source: AJdET5fyGbkO9C0ojhfKkUZ8VagTaJ5h4DEIh2G2fZCa8q6bDB3HSmX7G/fRn9ZiCW21NrV6DDZ+QQ==
X-Received: by 2002:a1c:59c4:: with SMTP id n187-v6mr9737825wmb.98.1540807711369;
        Mon, 29 Oct 2018 03:08:31 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id d6-v6sm18559302wro.72.2018.10.29.03.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 03:08:30 -0700 (PDT)
Date:   Mon, 29 Oct 2018 11:08:28 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, nelson.chang@mediatek.com,
        andrew@lunn.ch, netdev@vger.kernel.org, sean.wang@mediatek.com,
        liguo.zhang@mediatek.com, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, joabreu@synopsys.com,
        linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
        yt.shen@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
Message-ID: <20181029100828.GA19103@Red>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
 <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I have some minor comments below

On Mon, Oct 29, 2018 at 11:04:53AM +0800, Biao Huang wrote:
> Add Ethernet support for MediaTek SoCs from the mt2712 family
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  364 ++++++++++++++++++++
>  3 files changed, 373 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index edf2036..76d779e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -75,6 +75,14 @@ config DWMAC_LPC18XX
>  	---help---
>  	  Support for NXP LPC18xx/43xx DWMAC Ethernet.
>  
> +config DWMAC_MEDIATEK
> +	tristate "MediaTek MT27xx GMAC support"
> +	depends on OF

You should add something like && (COMPILE_TEST || ARCH_MEDIATEK)

[...]
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> new file mode 100644
> index 0000000..9ccf3a5
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -0,0 +1,364 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.

Only SPDX can use the // comment style, the rest should use /**/


[...]
> +static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat)
> +{
> +	int rmii_rxc = plat->rmii_rxc ? RMII_CLK_SRC_RXC : 0;
> +	u32 intf_val = 0;
> +
> +	/* select phy interface in top control domain */
> +	switch (plat->phy_mode) {
> +	case PHY_INTERFACE_MODE_MII:
> +		intf_val |= PHY_INTF_MII_GMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		intf_val |= PHY_INTF_RMII;
> +		intf_val |= rmii_rxc;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		intf_val |= PHY_INTF_RGMII;
> +		break;
> +	default:
> +		pr_err("phy interface not support\n");

I think you could use dev_err() instead.
And I think it is better spelled "not supported".


[...]
> +static int mediatek_dwmac_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct mediatek_dwmac_plat_data *priv_plat;
> +
> +	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
> +	if (!priv_plat)
> +		return -ENOMEM;
> +
> +	priv_plat->variant = of_device_get_match_data(&pdev->dev);
> +	if (!priv_plat->variant) {
> +		dev_err(&pdev->dev, "Missing dwmac-mediatek variant\n");
> +		return -EINVAL;
> +	}
> +
> +	priv_plat->dev = &pdev->dev;
> +	priv_plat->np = pdev->dev.of_node;
> +	priv_plat->phy_mode = of_get_phy_mode(priv_plat->np);
> +
> +	ret = mediatek_dwmac_config_dt(priv_plat);
> +	if (ret)
> +		return ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return ret;
> +
> +	plat_dat = stmmac_probe_config_dt(pdev, &stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return PTR_ERR(plat_dat);
> +
> +	plat_dat->interface = priv_plat->phy_mode;
> +	/* clk_csr_i = 250-300MHz & MDC = clk_csr_i/124 */
> +	plat_dat->clk_csr = 5;
> +	plat_dat->has_gmac4 = 1;
> +	plat_dat->has_gmac = 0;
> +	plat_dat->pmt = 0;
> +	plat_dat->maxmtu = 1500;

ETH_DATA_LEN ?

Regards
