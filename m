Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599BDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03822087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03822087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeH2GIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:08:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9505 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725199AbeH2GIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:08:01 -0400
X-UUID: dad5015255874c81b8fdda05897806f7-20180829
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2128605422; Wed, 29 Aug 2018 10:13:26 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 29 Aug 2018 10:13:23 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 29 Aug 2018 10:13:23 +0800
Message-ID: <1535508803.28775.4.camel@mtkswgap22>
Subject: Re: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
From:   Sean Wang <sean.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Jean-Christophe Plagniol-Villard" <plagnioj@jcrosoft.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Tony Lindgren" <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, <linux-gpio@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <linux-omap@vger.kernel.org>
Date:   Wed, 29 Aug 2018 10:13:23 +0800
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
         <20180828015252.28511-40-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 20:52 -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pinctrl/berlin/berlin.c               |  6 ++--
>  drivers/pinctrl/freescale/pinctrl-imx.c       |  7 ++--
>  drivers/pinctrl/freescale/pinctrl-imx1-core.c | 12 +++----
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  4 +--

For mediatek,
Acked-by: Sean Wang <sean.wang@mediatek.com>


