Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A1E20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfAQQqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:46:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54711 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbfAQQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:46:02 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gkAni-000665-IB; Thu, 17 Jan 2019 17:45:54 +0100
Message-ID: <1547743553.4009.16.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/3] dt-bindings: reset: imx7: Document usage on
 i.MX8MQ SoCs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 17:45:53 +0100
In-Reply-To: <20181220010700.8598-3-andrew.smirnov@gmail.com>
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
         <20181220010700.8598-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

sorry for the delay. Thank you for the update, apart from the comments
below, the list now looks to be complete.

On Wed, 2018-12-19 at 17:06 -0800, Andrey Smirnov wrote:
> The driver now supports i.MX8MQ, so update bindings accordingly.
> 
> Cc: p.zabel@pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  .../bindings/reset/fsl,imx7-src.txt           |  7 +-
>  include/dt-bindings/reset/imx8mq-reset.h      | 64 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/reset/imx8mq-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> index 1ab1d109318e..2ecf33815d18 100644
> --- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> @@ -5,7 +5,9 @@ Please also refer to reset.txt in this directory for common reset
>  controller binding usage.
>  
>  Required properties:
> -- compatible: Should be "fsl,imx7d-src", "syscon"
> +- compatible:
> +	- For i.MX7 SoCs should be "fsl,imx7d-src", "syscon"
> +	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
>  - reg: should be register base and length as documented in the
>    datasheet
>  - interrupts: Should contain SRC interrupt
> @@ -44,4 +46,5 @@ Example:
>  
>  
>  For list of all valid reset indicies see
> -<dt-bindings/reset/imx7-reset.h>
> +<dt-bindings/reset/imx7-reset.h> for i.MX7 and
> +<dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ
> diff --git a/include/dt-bindings/reset/imx8mq-reset.h b/include/dt-bindings/reset/imx8mq-reset.h
> new file mode 100644
> index 000000000000..57c592498aa0
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx8mq-reset.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Zodiac Inflight Innovations
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + */
> +
> +#ifndef DT_BINDING_RESET_IMX8MQ_H
> +#define DT_BINDING_RESET_IMX8MQ_H
> +
> +#define IMX8MQ_RESET_A53_CORE_POR_RESET0	0
> +#define IMX8MQ_RESET_A53_CORE_POR_RESET1	1
> +#define IMX8MQ_RESET_A53_CORE_POR_RESET2	2
> +#define IMX8MQ_RESET_A53_CORE_POR_RESET3	3
> +#define IMX8MQ_RESET_A53_CORE_RESET0		4
> +#define IMX8MQ_RESET_A53_CORE_RESET1		5
> +#define IMX8MQ_RESET_A53_CORE_RESET2		6
> +#define IMX8MQ_RESET_A53_CORE_RESET3		7
> +#define IMX8MQ_RESET_A53_DBG_RESET0		8
> +#define IMX8MQ_RESET_A53_DBG_RESET1		9
> +#define IMX8MQ_RESET_A53_DBG_RESET2		10
> +#define IMX8MQ_RESET_A53_DBG_RESET3		11
> +#define IMX8MQ_RESET_A53_ETM_RESET0		12
> +#define IMX8MQ_RESET_A53_ETM_RESET1		13
> +#define IMX8MQ_RESET_A53_ETM_RESET2		14
> +#define IMX8MQ_RESET_A53_ETM_RESET3		15
> +#define IMX8MQ_RESET_A53_SOC_DBG_RESET		16
> +#define IMX8MQ_RESET_A53_L2RESET		17
> +#define IMX8MQ_RESET_SW_NON_SCLR_M4C_RST	18
                           ^^^^^^^^

This might be an implementation detail. The reset line is
(SW_?)M4C_RST. I suppose the self-clearing SW_M4C_RST bit could be used
to implement .reset() functionality for the same line if needed.

What about the self-clearing SW_M4P_RST bit? Has that been left out on
purpose?

> +#define IMX8MQ_RESET_OTG1_PHY_RESET		19
> +#define IMX8MQ_RESET_OTG2_PHY_RESET		20
> +#define IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N	21
> +#define IMX8MQ_RESET_MIPI_DSI_RESET_N		22
> +#define IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N	23
> +#define IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N	24
> +#define IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N	25
> +#define IMX8MQ_RESET_PCIEPHY			26
> +#define IMX8MQ_RESET_PCIEPHY_PERST		27
> +#define IMX8MQ_RESET_PCIE_CTRL_APPS_EN		28
> +#define IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF	29

To be honest, I don't like these two, I'm not convinced anymore that
they actually qualify as reset signals. To me it looks like this is
something that the PCIe glue code should handle via syscon like i.MX6.
Leonard, Lucas, what do you think?

> +#define IMX8MQ_RESET_HDMI_PHY_APB_RESET		30
> +#define IMX8MQ_RESET_DISP_RESET			31
> +#define IMX8MQ_RESET_GPU_RESET			32
> +#define IMX8MQ_RESET_VPU_RESET			33
> +#define IMX8MQ_RESET_PCIEPHY2			34
> +#define IMX8MQ_RESET_PCIEPHY2_PERST		35
> +#define IMX8MQ_RESET_PCIE2_CTRL_APPS_EN		36
> +#define IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF	37

Same issue as PCIe #1

> +#define IMX8MQ_RESET_MIPI_CSI1_CORE_RESET	38
> +#define IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET	39
> +#define IMX8MQ_RESET_MIPI_CSI1_ESC_RESET	40
> +#define IMX8MQ_RESET_MIPI_CSI2_CORE_RESET	41
> +#define IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET	42
> +#define IMX8MQ_RESET_MIPI_CSI2_ESC_RESET	43
> +#define IMX8MQ_RESET_DDRC1_PRST			44
> +#define IMX8MQ_RESET_DDRC1_CORE_RESET		45
> +#define IMX8MQ_RESET_DDRC1_PHY_RESET		46

Does anybody know what the DDRC1_PHY_PWROKIN bit is, right next to the
PHY reset?

> +#define IMX8MQ_RESET_DDRC2_PRST			47
> +#define IMX8MQ_RESET_DDRC2_CORE_RESET		48
> +#define IMX8MQ_RESET_DDRC2_PHY_RESET		49
> +
> +#define IMX8MQ_RESET_NUM			50
> +
> +#endif

regards
Philipp
