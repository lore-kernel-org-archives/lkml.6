Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482AFC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0337240CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dgFBIbLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0337240CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeFVK7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:59:30 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:1950
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751427AbeFVK71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMqPDw6OGNmxw/0AInyztBrEoTNJB57e+eSYjYYCX/Y=;
 b=dgFBIbLgr5D6ddtyNNDj0A8Sqo+GnsxmshFjfVjbyMxReAfBC9phzEfBIsYsevuGCuXBc+/2acc9B3YCKd5wQ/izsdXsUszroE/FAbVvX8A7iF3l8W2WMJ81TvPCmefkN31YTc99AoYbkEGj1Zw6SdTPIrChbIFPDVG7SXWmbXU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4161.eurprd04.prod.outlook.com (52.134.125.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 22 Jun 2018 10:59:23 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::5950:96b1:2ae5:b8ce%2]) with mapi id 15.20.0884.010; Fri, 22 Jun 2018
 10:59:23 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>
Subject: RE: [PATCH v4 2/2] pinctrl: imx: add driver for i.MX8MQ
Thread-Topic: [PATCH v4 2/2] pinctrl: imx: add driver for i.MX8MQ
Thread-Index: AQHUCJGbNjReVUQHFkaGah6vX8UjrqRsF2Qg
Date:   Fri, 22 Jun 2018 10:59:23 +0000
Message-ID: <AM0PR04MB42111690585D73FBD800663380750@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1529497429-8576-1-git-send-email-abel.vesa@nxp.com>
 <1529497429-8576-3-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1529497429-8576-3-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4161;7:3O4zEiV3PArvA0S9bLcZtt0BJiBSy/3CD7QPAZn9G7qm059Y7N6+/+vWlj6PzC0ZbVcdJgmo/Y39HgdBDISkymFxU0XQReF3FdH1kWSINkZtKzq9esulQ7lKIjTNWuAoyFzG36QW+M/X9wOwqG6cyZd4Z7He/h+1PmUw8nlKN1hVUWDvxKJ5jIr5U11hMUnOvUc4i6mQfy4wN1jiXR/qPVYqbSuKnodsSKCAVFpdpyww+TxyRHvdB57+qMSZA2k0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 42825bb9-7c5d-4324-019e-08d5d82f36ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4161;
x-ms-traffictypediagnostic: AM0PR04MB4161:
x-microsoft-antispam-prvs: <AM0PR04MB416165B6CA6DD5659A0502C780750@AM0PR04MB4161.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4161;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4161;
x-forefront-prvs: 071156160B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(39380400002)(376002)(396003)(189003)(13464003)(199004)(54906003)(106356001)(81166006)(81156014)(25786009)(7416002)(478600001)(8676002)(6116002)(3846002)(14454004)(6436002)(5660300001)(3280700002)(8936002)(74316002)(3660700001)(7736002)(105586002)(305945005)(55016002)(316002)(9686003)(110136005)(5250100002)(2900100001)(2906002)(97736004)(53936002)(59450400001)(99286004)(6246003)(53946003)(4326008)(446003)(68736007)(6506007)(33656002)(86362001)(7696005)(229853002)(53546011)(486006)(76176011)(11346002)(102836004)(476003)(66066001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4161;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rLdnt5eHvwfb5CbBxm0jOadciGz0KF23O6JPG40uNEdFsmmeEwzH4Vcx43t/TvZgPBI2RmA2b41Skd7wEeeEfTB0CwaFDhZV4HkyJwdmanh7wE71RoPdq5bdZtKmPm+vL5VQ+ffCyh15Z/B2lRAndMviRe9MkJ9l1nRcL7UMJl9WJKqltCwD+jYIU4BrBNXDDLmt77g7Ak52M0pa+E88REoEiWVK9/wKZHg01doh9POXD/uI9iFSMfPbe1fqNlrkQX3RPIgRalt1dV4K9BrD9NH8+k4LX0V3PN+8xpkxGwREvk1wzQJ0t97Gkpb8a0yuSwZuc+VQn8wZlFTF+MmXGQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42825bb9-7c5d-4324-019e-08d5d82f36ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2018 10:59:23.3757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

The patch mostly looks good to me.
Only a few minor comments.

> -----Original Message-----
> From: Abel Vesa
> Sent: Wednesday, June 20, 2018 8:24 PM
> To: Lucas Stach <l.stach@pengutronix.de>; A.s. Dong
> <aisheng.dong@nxp.com>
> Cc: linux-gpio@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Shawn
> Guo <shawnguo@kernel.org>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Linus Walleij <linus.walleij@linaro.org>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Abel Vesa
> <abelvesa@linux.com>; Abel Vesa <abel.vesa@nxp.com>
> Subject: [PATCH v4 2/2] pinctrl: imx: add driver for i.MX8MQ
>=20
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> The i.MX8MQ pincontrol works in a similar way to the earlier i.MX SoCs.
> This driver builds on top of the generic pinconf handling introduced with=
 the
> i.MX7ULP pinctrl driver.

The commit message needs update as it does not build on top
of the generic pinconf now.

>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/pinctrl/freescale/Kconfig          |   7 +
>  drivers/pinctrl/freescale/Makefile         |   1 +
>  drivers/pinctrl/freescale/pinctrl-imx8mq.c | 356
> +++++++++++++++++++++++++++++
>  3 files changed, 364 insertions(+)
>  create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8mq.c
>=20
> diff --git a/drivers/pinctrl/freescale/Kconfig
> b/drivers/pinctrl/freescale/Kconfig
> index 0d8ba1e..dccf64c 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -117,6 +117,13 @@ config PINCTRL_IMX7ULP
>  	help
>  	  Say Y here to enable the imx7ulp pinctrl driver
>=20
> +config PINCTRL_IMX8MQ
> +	bool "IMX8MQ pinctrl driver"
> +	depends on SOC_IMX8MQ
> +	select PINCTRL_IMX
> +	help
> +	  Say Y here to enable the imx8mq pinctrl driver
> +
>  config PINCTRL_VF610
>  	bool "Freescale Vybrid VF610 pinctrl driver"
>  	depends on SOC_VF610
> diff --git a/drivers/pinctrl/freescale/Makefile
> b/drivers/pinctrl/freescale/Makefile
> index 368be8c..73175b3 100644
> --- a/drivers/pinctrl/freescale/Makefile
> +++ b/drivers/pinctrl/freescale/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PINCTRL_IMX6SX)	+=3D pinctrl-imx6sx.o
>  obj-$(CONFIG_PINCTRL_IMX6UL)	+=3D pinctrl-imx6ul.o
>  obj-$(CONFIG_PINCTRL_IMX7D)	+=3D pinctrl-imx7d.o
>  obj-$(CONFIG_PINCTRL_IMX7ULP)	+=3D pinctrl-imx7ulp.o
> +obj-$(CONFIG_PINCTRL_IMX8MQ)	+=3D pinctrl-imx8mq.o
>  obj-$(CONFIG_PINCTRL_VF610)	+=3D pinctrl-vf610.o
>  obj-$(CONFIG_PINCTRL_MXS)	+=3D pinctrl-mxs.o
>  obj-$(CONFIG_PINCTRL_IMX23)	+=3D pinctrl-imx23.o
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> new file mode 100644
> index 0000000..be2c9c2
> --- /dev/null
> +++ b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
> @@ -0,0 +1,356 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017 NXP

2017-2018

> + * Copyright (C) 2018 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> +*/
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-imx.h"
> +
> +enum imx8mq_pads {
> +	MX8MQ_PAD_RESERVE0 =3D 0,
> +	MX8MQ_PAD_RESERVE1 =3D 1,
> +	MX8MQ_PAD_RESERVE2 =3D 2,
> +	MX8MQ_PAD_RESERVE3 =3D 3,
> +	MX8MQ_PAD_RESERVE4 =3D 4,
> +	MX8MQ_IOMUXC_PMIC_STBY_REQ_CCMSRCGPCMIX =3D 5,
> +	MX8MQ_IOMUXC_PMIC_ON_REQ_SNVSMIX =3D 6,
> +	MX8MQ_IOMUXC_ONOFF_SNVSMIX =3D 7,
> +	MX8MQ_IOMUXC_POR_B_SNVSMIX =3D 8,
> +	MX8MQ_IOMUXC_RTC_RESET_B_SNVSMIX =3D 9,
> +	MX8MQ_IOMUXC_GPIO1_IO00 =3D 10,
> +	MX8MQ_IOMUXC_GPIO1_IO01 =3D 11,
> +	MX8MQ_IOMUXC_GPIO1_IO02 =3D 12,
> +	MX8MQ_IOMUXC_GPIO1_IO03 =3D 13,
> +	MX8MQ_IOMUXC_GPIO1_IO04 =3D 14,
> +	MX8MQ_IOMUXC_GPIO1_IO05 =3D 15,
> +	MX8MQ_IOMUXC_GPIO1_IO06 =3D 16,
> +	MX8MQ_IOMUXC_GPIO1_IO07 =3D 17,
> +	MX8MQ_IOMUXC_GPIO1_IO08 =3D 18,
> +	MX8MQ_IOMUXC_GPIO1_IO09 =3D 19,
> +	MX8MQ_IOMUXC_GPIO1_IO10 =3D 20,
> +	MX8MQ_IOMUXC_GPIO1_IO11 =3D 21,
> +	MX8MQ_IOMUXC_GPIO1_IO12 =3D 22,
> +	MX8MQ_IOMUXC_GPIO1_IO13 =3D 23,
> +	MX8MQ_IOMUXC_GPIO1_IO14 =3D 24,
> +	MX8MQ_IOMUXC_GPIO1_IO15 =3D 25,
> +	MX8MQ_IOMUXC_ENET_MDC =3D 26,
> +	MX8MQ_IOMUXC_ENET_MDIO =3D 27,
> +	MX8MQ_IOMUXC_ENET_TD3 =3D 28,
> +	MX8MQ_IOMUXC_ENET_TD2 =3D 29,
> +	MX8MQ_IOMUXC_ENET_TD1 =3D 30,
> +	MX8MQ_IOMUXC_ENET_TD0 =3D 31,
> +	MX8MQ_IOMUXC_ENET_TX_CTL =3D 32,
> +	MX8MQ_IOMUXC_ENET_TXC =3D 33,
> +	MX8MQ_IOMUXC_ENET_RX_CTL =3D 34,
> +	MX8MQ_IOMUXC_ENET_RXC =3D 35,
> +	MX8MQ_IOMUXC_ENET_RD0 =3D 36,
> +	MX8MQ_IOMUXC_ENET_RD1 =3D 37,
> +	MX8MQ_IOMUXC_ENET_RD2 =3D 38,
> +	MX8MQ_IOMUXC_ENET_RD3 =3D 39,
> +	MX8MQ_IOMUXC_SD1_CLK =3D 40,
> +	MX8MQ_IOMUXC_SD1_CMD =3D 41,
> +	MX8MQ_IOMUXC_SD1_DATA0 =3D 42,
> +	MX8MQ_IOMUXC_SD1_DATA1 =3D 43,
> +	MX8MQ_IOMUXC_SD1_DATA2 =3D 44,
> +	MX8MQ_IOMUXC_SD1_DATA3 =3D 45,
> +	MX8MQ_IOMUXC_SD1_DATA4 =3D 46,
> +	MX8MQ_IOMUXC_SD1_DATA5 =3D 47,
> +	MX8MQ_IOMUXC_SD1_DATA6 =3D 48,
> +	MX8MQ_IOMUXC_SD1_DATA7 =3D 49,
> +	MX8MQ_IOMUXC_SD1_RESET_B =3D 50,
> +	MX8MQ_IOMUXC_SD1_STROBE =3D 51,
> +	MX8MQ_IOMUXC_SD2_CD_B =3D 52,
> +	MX8MQ_IOMUXC_SD2_CLK =3D 53,
> +	MX8MQ_IOMUXC_SD2_CMD =3D 54,
> +	MX8MQ_IOMUXC_SD2_DATA0 =3D 55,
> +	MX8MQ_IOMUXC_SD2_DATA1 =3D 56,
> +	MX8MQ_IOMUXC_SD2_DATA2 =3D 57,
> +	MX8MQ_IOMUXC_SD2_DATA3 =3D 58,
> +	MX8MQ_IOMUXC_SD2_RESET_B =3D 59,
> +	MX8MQ_IOMUXC_SD2_WP =3D 60,
> +	MX8MQ_IOMUXC_NAND_ALE =3D 61,
> +	MX8MQ_IOMUXC_NAND_CE0_B =3D 62,
> +	MX8MQ_IOMUXC_NAND_CE1_B =3D 63,
> +	MX8MQ_IOMUXC_NAND_CE2_B =3D 64,
> +	MX8MQ_IOMUXC_NAND_CE3_B =3D 65,
> +	MX8MQ_IOMUXC_NAND_CLE =3D 66,
> +	MX8MQ_IOMUXC_NAND_DATA00 =3D 67,
> +	MX8MQ_IOMUXC_NAND_DATA01 =3D 68,
> +	MX8MQ_IOMUXC_NAND_DATA02 =3D 69,
> +	MX8MQ_IOMUXC_NAND_DATA03 =3D 70,
> +	MX8MQ_IOMUXC_NAND_DATA04 =3D 71,
> +	MX8MQ_IOMUXC_NAND_DATA05 =3D 72,
> +	MX8MQ_IOMUXC_NAND_DATA06 =3D 73,
> +	MX8MQ_IOMUXC_NAND_DATA07 =3D 74,
> +	MX8MQ_IOMUXC_NAND_DQS =3D 75,
> +	MX8MQ_IOMUXC_NAND_RE_B =3D 76,
> +	MX8MQ_IOMUXC_NAND_READY_B =3D 77,
> +	MX8MQ_IOMUXC_NAND_WE_B =3D 78,
> +	MX8MQ_IOMUXC_NAND_WP_B =3D 79,
> +	MX8MQ_IOMUXC_SAI5_RXFS =3D 80,
> +	MX8MQ_IOMUXC_SAI5_RXC =3D 81,
> +	MX8MQ_IOMUXC_SAI5_RXD0 =3D 82,
> +	MX8MQ_IOMUXC_SAI5_RXD1 =3D 83,
> +	MX8MQ_IOMUXC_SAI5_RXD2 =3D 84,
> +	MX8MQ_IOMUXC_SAI5_RXD3 =3D 85,
> +	MX8MQ_IOMUXC_SAI5_MCLK =3D 86,
> +	MX8MQ_IOMUXC_SAI1_RXFS =3D 87,
> +	MX8MQ_IOMUXC_SAI1_RXC =3D 88,
> +	MX8MQ_IOMUXC_SAI1_RXD0 =3D 89,
> +	MX8MQ_IOMUXC_SAI1_RXD1 =3D 90,
> +	MX8MQ_IOMUXC_SAI1_RXD2 =3D 91,
> +	MX8MQ_IOMUXC_SAI1_RXD3 =3D 92,
> +	MX8MQ_IOMUXC_SAI1_RXD4 =3D 93,
> +	MX8MQ_IOMUXC_SAI1_RXD5 =3D 94,
> +	MX8MQ_IOMUXC_SAI1_RXD6 =3D 95,
> +	MX8MQ_IOMUXC_SAI1_RXD7 =3D 96,
> +	MX8MQ_IOMUXC_SAI1_TXFS =3D 97,
> +	MX8MQ_IOMUXC_SAI1_TXC =3D 98,
> +	MX8MQ_IOMUXC_SAI1_TXD0 =3D 99,
> +	MX8MQ_IOMUXC_SAI1_TXD1 =3D 100,
> +	MX8MQ_IOMUXC_SAI1_TXD2 =3D 101,
> +	MX8MQ_IOMUXC_SAI1_TXD3 =3D 102,
> +	MX8MQ_IOMUXC_SAI1_TXD4 =3D 103,
> +	MX8MQ_IOMUXC_SAI1_TXD5 =3D 104,
> +	MX8MQ_IOMUXC_SAI1_TXD6 =3D 105,
> +	MX8MQ_IOMUXC_SAI1_TXD7 =3D 106,
> +	MX8MQ_IOMUXC_SAI1_MCLK =3D 107,
> +	MX8MQ_IOMUXC_SAI2_RXFS =3D 108,
> +	MX8MQ_IOMUXC_SAI2_RXC =3D 109,
> +	MX8MQ_IOMUXC_SAI2_RXD0 =3D 110,
> +	MX8MQ_IOMUXC_SAI2_TXFS =3D 111,
> +	MX8MQ_IOMUXC_SAI2_TXC =3D 112,
> +	MX8MQ_IOMUXC_SAI2_TXD0 =3D 113,
> +	MX8MQ_IOMUXC_SAI2_MCLK =3D 114,
> +	MX8MQ_IOMUXC_SAI3_RXFS =3D 115,
> +	MX8MQ_IOMUXC_SAI3_RXC =3D 116,
> +	MX8MQ_IOMUXC_SAI3_RXD =3D 117,
> +	MX8MQ_IOMUXC_SAI3_TXFS =3D 118,
> +	MX8MQ_IOMUXC_SAI3_TXC =3D 119,
> +	MX8MQ_IOMUXC_SAI3_TXD =3D 120,
> +	MX8MQ_IOMUXC_SAI3_MCLK =3D 121,
> +	MX8MQ_IOMUXC_SPDIF_TX =3D 122,
> +	MX8MQ_IOMUXC_SPDIF_RX =3D 123,
> +	MX8MQ_IOMUXC_SPDIF_EXT_CLK =3D 124,
> +	MX8MQ_IOMUXC_ECSPI1_SCLK =3D 125,
> +	MX8MQ_IOMUXC_ECSPI1_MOSI =3D 126,
> +	MX8MQ_IOMUXC_ECSPI1_MISO =3D 127,
> +	MX8MQ_IOMUXC_ECSPI1_SS0 =3D 128,
> +	MX8MQ_IOMUXC_ECSPI2_SCLK =3D 129,
> +	MX8MQ_IOMUXC_ECSPI2_MOSI =3D 130,
> +	MX8MQ_IOMUXC_ECSPI2_MISO =3D 131,
> +	MX8MQ_IOMUXC_ECSPI2_SS0 =3D 132,
> +	MX8MQ_IOMUXC_I2C1_SCL =3D 133,
> +	MX8MQ_IOMUXC_I2C1_SDA =3D 134,
> +	MX8MQ_IOMUXC_I2C2_SCL =3D 135,
> +	MX8MQ_IOMUXC_I2C2_SDA =3D 136,
> +	MX8MQ_IOMUXC_I2C3_SCL =3D 137,
> +	MX8MQ_IOMUXC_I2C3_SDA =3D 138,
> +	MX8MQ_IOMUXC_I2C4_SCL =3D 139,
> +	MX8MQ_IOMUXC_I2C4_SDA =3D 140,
> +	MX8MQ_IOMUXC_UART1_RXD =3D 141,
> +	MX8MQ_IOMUXC_UART1_TXD =3D 142,
> +	MX8MQ_IOMUXC_UART2_RXD =3D 143,
> +	MX8MQ_IOMUXC_UART2_TXD =3D 144,
> +	MX8MQ_IOMUXC_UART3_RXD =3D 145,
> +	MX8MQ_IOMUXC_UART3_TXD =3D 146,
> +	MX8MQ_IOMUXC_UART4_RXD =3D 147,
> +	MX8MQ_IOMUXC_UART4_TXD =3D 148,
> +};
> +
> +/* Pad names for the pinmux subsystem */ static const struct
> +pinctrl_pin_desc imx8mq_pinctrl_pads[] =3D {
> +	IMX_PINCTRL_PIN(MX8MQ_PAD_RESERVE0),
> +	IMX_PINCTRL_PIN(MX8MQ_PAD_RESERVE1),
> +	IMX_PINCTRL_PIN(MX8MQ_PAD_RESERVE2),
> +	IMX_PINCTRL_PIN(MX8MQ_PAD_RESERVE3),
> +	IMX_PINCTRL_PIN(MX8MQ_PAD_RESERVE4),
> +
> 	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_PMIC_STBY_REQ_CCMSRCGP
> CMIX),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_PMIC_ON_REQ_SNVSMIX),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ONOFF_SNVSMIX),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_POR_B_SNVSMIX),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_RTC_RESET_B_SNVSMIX),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO00),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO01),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO02),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO03),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO04),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO05),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO06),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO07),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO08),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO09),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO10),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO11),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO12),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO13),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO14),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_GPIO1_IO15),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_MDC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_MDIO),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_TD3),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_TD2),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_TD1),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_TD0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_TX_CTL),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_TXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_RX_CTL),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_RXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_RD0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_RD1),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_RD2),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ENET_RD3),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_CLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_CMD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_DATA0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_DATA1),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_DATA2),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_DATA3),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_DATA4),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_DATA5),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_DATA6),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_DATA7),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_RESET_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD1_STROBE),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_CD_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_CLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_CMD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_DATA0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_DATA1),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_DATA2),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_DATA3),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_RESET_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SD2_WP),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_ALE),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_CE0_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_CE1_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_CE2_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_CE3_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_CLE),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DATA00),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DATA01),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DATA02),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DATA03),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DATA04),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DATA05),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DATA06),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DATA07),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_DQS),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_RE_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_READY_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_WE_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_NAND_WP_B),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI5_RXFS),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI5_RXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI5_RXD0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI5_RXD1),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI5_RXD2),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI5_RXD3),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI5_MCLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXFS),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXD0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXD1),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXD2),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXD3),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXD4),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXD5),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXD6),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_RXD7),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXFS),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXD0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXD1),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXD2),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXD3),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXD4),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXD5),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXD6),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_TXD7),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI1_MCLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI2_RXFS),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI2_RXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI2_RXD0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI2_TXFS),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI2_TXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI2_TXD0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI2_MCLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI3_RXFS),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI3_RXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI3_RXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI3_TXFS),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI3_TXC),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI3_TXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SAI3_MCLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SPDIF_TX),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SPDIF_RX),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_SPDIF_EXT_CLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ECSPI1_SCLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ECSPI1_MOSI),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ECSPI1_MISO),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ECSPI1_SS0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ECSPI2_SCLK),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ECSPI2_MOSI),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ECSPI2_MISO),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_ECSPI2_SS0),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_I2C1_SCL),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_I2C1_SDA),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_I2C2_SCL),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_I2C2_SDA),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_I2C3_SCL),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_I2C3_SDA),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_I2C4_SCL),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_I2C4_SDA),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_UART1_RXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_UART1_TXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_UART2_RXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_UART2_TXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_UART3_RXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_UART3_TXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_UART4_RXD),
> +	IMX_PINCTRL_PIN(MX8MQ_IOMUXC_UART4_TXD),
> +};
> +
> +static const struct imx_pinctrl_soc_info imx8mq_pinctrl_info =3D {
> +	.pins =3D imx8mq_pinctrl_pads,
> +	.npins =3D ARRAY_SIZE(imx8mq_pinctrl_pads),
> +	.gpr_compatible =3D "fsl,imx8mq-iomuxc-gpr", };
> +
> +static const struct of_device_id imx8mq_pinctrl_of_match[] =3D {
> +	{ .compatible =3D "fsl,imx8mq-iomuxc", .data =3D
> &imx8mq_pinctrl_info, },
> +	{ /* sentinel */ }
> +};
> +
> +static int imx8mq_pinctrl_probe(struct platform_device *pdev) {
> +	const struct imx_pinctrl_soc_info *pinctrl_info;
> +
> +	pinctrl_info =3D of_device_get_match_data(&pdev->dev);
> +	if (!pinctrl_info)
> +		return -ENODEV;
> +
> +	return imx_pinctrl_probe(pdev, pinctrl_info); }

We don't have another pinctrl_info with a different compatible string.
So I guess a simple direct call just works fine as before:
imx_pinctrl_probe(&imx8mq_pinctrl_info).

> +
> +static struct platform_driver imx8mq_pinctrl_driver =3D {
> +	.driver =3D {
> +		.name =3D "imx8mq-pinctrl",
> +		.of_match_table =3D of_match_ptr(imx8mq_pinctrl_of_match),

Better with:
.suppress_bind_attrs =3D true,

> +	},
> +	.probe =3D imx8mq_pinctrl_probe,
> +};
> +
> +static int __init imx8mq_pinctrl_init(void) {
> +	return platform_driver_register(&imx8mq_pinctrl_driver);
> +}
> +arch_initcall(imx8mq_pinctrl_init);

Otherwise:
Acked-by: Dong Aisheng <Aisheng.dong@nxp.com>

Regards
Dong Aisheng

> --
> 2.7.4

