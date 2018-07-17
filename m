Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67B7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9617D20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9617D20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbeGQNcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:32:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10036 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731186AbeGQNcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:32:55 -0400
X-UUID: a7b61c0b97d14ecab026e04965d1c5af-20180717
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2051947313; Tue, 17 Jul 2018 21:00:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 17 Jul 2018 21:00:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 17 Jul 2018 21:00:13 +0800
Message-ID: <1531832413.8953.30.camel@mtkswgap22>
Subject: Re: [PATCH v5 04/11] soc: mediatek: add MT6765 scpsys support
From:   Sean Wang <sean.wang@mediatek.com>
To:     Mars Cheng <mars.cheng@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, Owen Chen <owen.chen@mediatek.com>
Date:   Tue, 17 Jul 2018 21:00:13 +0800
In-Reply-To: <1531817552-17221-5-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
         <1531817552-17221-5-git-send-email-mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 16:52 +0800, Mars Cheng wrote:
> This adds scpsys support for MT6765
> 

it looks like 4/11 have to depend on 6/11 and 7/11 to get a full function on scpsys for MT6765.

you should keep dependency in order to submit these patches

> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c        |   88 ++++++++++++++++++++++++++++++
>  include/dt-bindings/power/mt6765-power.h |   14 +++++
>  2 files changed, 102 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt6765-power.h
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 5b24bb4..4bb6c7a 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -23,6 +23,7 @@
>  
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/power/mt2712-power.h>
> +#include <dt-bindings/power/mt6765-power.h>
>  #include <dt-bindings/power/mt6797-power.h>
>  #include <dt-bindings/power/mt7622-power.h>
>  #include <dt-bindings/power/mt7623a-power.h>
> @@ -680,6 +681,79 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  };
>  
>  /*
> + * MT6765 power domain support
> + */
> +#define SPM_PWR_STATUS_MT6765			0x0180
> +#define SPM_PWR_STATUS_2ND_MT6765		0x0184
> +
> +static const struct scp_domain_data scp_domain_data_mt6765[] = {
> +	[MT6765_POWER_DOMAIN_VCODEC] = {
> +		.name = "vcodec",
> +		.sta_mask = BIT(26),
> +		.ctl_offs = 0x300,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT6765_POWER_DOMAIN_ISP] = {
> +		.name = "isp",
> +		.sta_mask = BIT(5),
> +		.ctl_offs = 0x308,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT6765_POWER_DOMAIN_MM] = {
> +		.name = "mm",
> +		.sta_mask = BIT(3),
> +		.ctl_offs = 0x30C,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT6765_POWER_DOMAIN_CONN] = {
> +		.name = "conn",
> +		.sta_mask = BIT(1),
> +		.ctl_offs = 0x32C,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +	},
> +	[MT6765_POWER_DOMAIN_MFG_ASYNC] = {
> +		.name = "mfg_async",
> +		.sta_mask = BIT(23),
> +		.ctl_offs = 0x334,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +	},
> +	[MT6765_POWER_DOMAIN_MFG] = {
> +		.name = "mfg",
> +		.sta_mask = BIT(4),
> +		.ctl_offs = 0x338,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},
> +	[MT6765_POWER_DOMAIN_CAM] = {
> +		.name = "cam",
> +		.sta_mask = BIT(25),
> +		.ctl_offs = 0x344,
> +		.sram_pdn_bits = GENMASK(8, 9),
> +		.sram_pdn_ack_bits = GENMASK(12, 13),
> +	},
> +	[MT6765_POWER_DOMAIN_MFG_CORE0] = {
> +		.name = "mfg_core0",
> +		.sta_mask = BIT(7),
> +		.ctl_offs = 0x34C,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +	},

Above power domains really don't require any clock controlled with
clk_id before any access on them?

> +};
> +
> +static const struct scp_subdomain scp_subdomain_mt6765[] = {
> +	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_CAM},
> +	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_ISP},
> +	{MT6765_POWER_DOMAIN_MM, MT6765_POWER_DOMAIN_VCODEC},
> +	{MT6765_POWER_DOMAIN_MFG_ASYNC, MT6765_POWER_DOMAIN_MFG},
> +	{MT6765_POWER_DOMAIN_MFG, MT6765_POWER_DOMAIN_MFG_CORE0},
> +};
> +
> +/*
>   * MT6797 power domain support
>   */
>  
> @@ -962,6 +1036,17 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  	.bus_prot_reg_update = false,
>  };
>  
> +static const struct scp_soc_data mt6765_data = {
> +	.domains = scp_domain_data_mt6765,
> +	.num_domains = ARRAY_SIZE(scp_domain_data_mt6765),
> +	.subdomains = scp_subdomain_mt6765,
> +	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt6765),
> +	.regs = {
> +		.pwr_sta_offs = SPM_PWR_STATUS_MT6765,
> +		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6765,
> +	},
> +};
> +
>  static const struct scp_soc_data mt6797_data = {
>  	.domains = scp_domain_data_mt6797,
>  	.num_domains = ARRAY_SIZE(scp_domain_data_mt6797),
> @@ -1018,6 +1103,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>  		.compatible = "mediatek,mt2712-scpsys",
>  		.data = &mt2712_data,
>  	}, {
> +		.compatible = "mediatek,mt6765-scpsys",
> +		.data = &mt6765_data,
> +	}, {
>  		.compatible = "mediatek,mt6797-scpsys",
>  		.data = &mt6797_data,
>  	}, {
> diff --git a/include/dt-bindings/power/mt6765-power.h b/include/dt-bindings/power/mt6765-power.h
> new file mode 100644
> index 0000000..d347b4e
> --- /dev/null
> +++ b/include/dt-bindings/power/mt6765-power.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _DT_BINDINGS_POWER_MT6765_POWER_H
> +#define _DT_BINDINGS_POWER_MT6765_POWER_H
> +
> +#define MT6765_POWER_DOMAIN_CONN		0
> +#define MT6765_POWER_DOMAIN_MM			1
> +#define MT6765_POWER_DOMAIN_MFG_ASYNC		2
> +#define MT6765_POWER_DOMAIN_ISP			3
> +#define MT6765_POWER_DOMAIN_MFG			4
> +#define MT6765_POWER_DOMAIN_MFG_CORE0		5
> +#define MT6765_POWER_DOMAIN_CAM			6
> +#define MT6765_POWER_DOMAIN_VCODEC		7
> +
> +#endif /* _DT_BINDINGS_POWER_MT6765_POWER_H */


