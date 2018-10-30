Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D617AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698A92082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 07:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698A92082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJ3QJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 12:09:31 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:54872 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726172AbeJ3QJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 12:09:31 -0400
X-UUID: 2904521077c34705b5a1301bfa5d371d-20181030
X-UUID: 2904521077c34705b5a1301bfa5d371d-20181030
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 256067452; Tue, 30 Oct 2018 15:16:55 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 30 Oct
 2018 15:16:53 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Oct 2018 15:16:52 +0800
Message-ID: <1540883812.26982.15.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
From:   biao huang <biao.huang@mediatek.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
CC:     <davem@davemloft.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <nelson.chang@mediatek.com>, <andrew@lunn.ch>,
        <netdev@vger.kernel.org>, <sean.wang@mediatek.com>,
        <liguo.zhang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <joabreu@synopsys.com>,
        <linux-mediatek@lists.infradead.org>, <honghui.zhang@mediatek.com>,
        <yt.shen@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 30 Oct 2018 15:16:52 +0800
In-Reply-To: <20181029100828.GA19103@Red>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
         <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
         <20181029100828.GA19103@Red>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your nice comments.
On Mon, 2018-10-29 at 11:08 +0100, Corentin Labbe wrote:
> Hello
> I have some minor comments below
> 
> On Mon, Oct 29, 2018 at 11:04:53AM +0800, Biao Huang wrote:
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
> > index edf2036..76d779e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -75,6 +75,14 @@ config DWMAC_LPC18XX
> >  	---help---
> >  	  Support for NXP LPC18xx/43xx DWMAC Ethernet.
> >  
> > +config DWMAC_MEDIATEK
> > +	tristate "MediaTek MT27xx GMAC support"
> > +	depends on OF
> 
> You should add something like && (COMPILE_TEST || ARCH_MEDIATEK)
ok, I'll add it in next patch.
> 
> [...]
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > new file mode 100644
> > index 0000000..9ccf3a5
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> > @@ -0,0 +1,364 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (c) 2018 MediaTek Inc.
> 
> Only SPDX can use the // comment style, the rest should use /**/
will fix it.
> 
> 
> [...]
> > +static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat)
> > +{
> > +	int rmii_rxc = plat->rmii_rxc ? RMII_CLK_SRC_RXC : 0;
> > +	u32 intf_val = 0;
> > +
> > +	/* select phy interface in top control domain */
> > +	switch (plat->phy_mode) {
> > +	case PHY_INTERFACE_MODE_MII:
> > +		intf_val |= PHY_INTF_MII_GMII;
> > +		break;
> > +	case PHY_INTERFACE_MODE_RMII:
> > +		intf_val |= PHY_INTF_RMII;
> > +		intf_val |= rmii_rxc;
> > +		break;
> > +	case PHY_INTERFACE_MODE_RGMII:
> > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > +		intf_val |= PHY_INTF_RGMII;
> > +		break;
> > +	default:
> > +		pr_err("phy interface not support\n");
> 
> I think you could use dev_err() instead.
> And I think it is better spelled "not supported".
yes, take it.
> 
> 
> [...]
> > +static int mediatek_dwmac_probe(struct platform_device *pdev)
> > +{
> > +	int ret = 0;
> > +	struct plat_stmmacenet_data *plat_dat;
> > +	struct stmmac_resources stmmac_res;
> > +	struct mediatek_dwmac_plat_data *priv_plat;
> > +
> > +	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
> > +	if (!priv_plat)
> > +		return -ENOMEM;
> > +
> > +	priv_plat->variant = of_device_get_match_data(&pdev->dev);
> > +	if (!priv_plat->variant) {
> > +		dev_err(&pdev->dev, "Missing dwmac-mediatek variant\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	priv_plat->dev = &pdev->dev;
> > +	priv_plat->np = pdev->dev.of_node;
> > +	priv_plat->phy_mode = of_get_phy_mode(priv_plat->np);
> > +
> > +	ret = mediatek_dwmac_config_dt(priv_plat);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > +	if (ret)
> > +		return ret;
> > +
> > +	plat_dat = stmmac_probe_config_dt(pdev, &stmmac_res.mac);
> > +	if (IS_ERR(plat_dat))
> > +		return PTR_ERR(plat_dat);
> > +
> > +	plat_dat->interface = priv_plat->phy_mode;
> > +	/* clk_csr_i = 250-300MHz & MDC = clk_csr_i/124 */
> > +	plat_dat->clk_csr = 5;
> > +	plat_dat->has_gmac4 = 1;
> > +	plat_dat->has_gmac = 0;
> > +	plat_dat->pmt = 0;
> > +	plat_dat->maxmtu = 1500;
> 
> ETH_DATA_LEN ?
how about getting maxmtu from device tree rather than assignment here?
> 
> Regards


