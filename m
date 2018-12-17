Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B2EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5F72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i2D/WPKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbeLQEae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:30:34 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:27795
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbeLQEad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVM/u1SwPjPXikn42aSuXDo2KeXYHUiAdeznFL7qiT4=;
 b=i2D/WPKHPTQptUFu0SizuvSndYfvu4IzDXVgOj5PAgqJERWxkogeP0KsPlFT9VjJbCVsa5A0+iuH3rgHu7Srv4045CoQfOSegR831qB/q86Oe/LC/E/PJvQWt4LN2QxkAMRSInym+0Wzu/xNuMzJb7zo1eL0/P0D23PSMNtoboY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5475.eurprd04.prod.outlook.com (20.178.113.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 04:30:26 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 04:30:26 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 3/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
Thread-Topic: [PATCH v3 3/3] reset: imx7: Add support for i.MX8MQ IP block
 variant
Thread-Index: AQHUlbGpZLhb5vhy5kOlQw0ltavusqWCViBQ
Date:   Mon, 17 Dec 2018 04:30:26 +0000
Message-ID: <AM0PR04MB42114239FC75F5514554B55280BC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181217023827.7947-1-andrew.smirnov@gmail.com>
 <20181217023827.7947-4-andrew.smirnov@gmail.com>
In-Reply-To: <20181217023827.7947-4-andrew.smirnov@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5475;6:3oT5cCfjrkckT75W/FsusYX1LXpGNsonESi4sSTuZdKlLADJ/kbg/qgGoSQ7B7xc530qiqeIlY6q39ZLKuBy/NKBsJZ68E73qH+hm+NTsrTTXAdIPlZPzrYznAB2HUSIQKl5MXCnCea4zX77ZEW43b0BoSe9hHIKvKr0MV+f6YBuxkmRtK2LwEOEaH2KGT13mtmeeuRebVBOxjFh3vY0xF7iSSpFkHyN8L6wOpJocF782mhBmC/bqrHEilPFNvn/WRiDk814mziGBuRCSS5OfSiU2SWqsovOzVSyaGCc0TEpffh74pyrVAL0hoSR0lQgIMvPvUFG19+MqNVXHWUriZiIGbp1LsCd3qm1UgJ610HkSRZWQQjqpRjXQAQTjj0MDPQcNwiffcDuEwc5E/2EG6h3Ux7DsPYmAJRLWzJAvfEIR3FzbLZJP6f7R4DhzJWlhm7xJVo/ifcgICgVynorUw==;5:nVQKLDn46Y9Vk8xlhBIIY8uj4fVb/63yq3WlproBmwxkc2dFafSXO430v/2ogyIYp/ZIOdY/CQMgPE49PoTMTfgJ4Rkl5urV04Xv8fHeVlOIKCT54TYR0gFX7LtjFVPfqfIEyGD7wtsOZGIo6LoqVaQbIjL+q3RbVtymENRriB4=;7:tK8+oZ7v92Vt8VtmvBlpufYap8g8XjJvVYe2opr/yXOJI3e34KKJCQq1oMRY+HUj37ElDvS+VZYOY6+zKPVOEP+8ELmQczFnAYY1892pkyWP3l9Buc3ar1f8+96PUuiwrAhxfnrA82eBkgTh6SnczA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5a48f20a-9ee0-4dbe-f5da-08d663d85e74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5475;
x-ms-traffictypediagnostic: AM0PR04MB5475:
x-microsoft-antispam-prvs: <AM0PR04MB5475B117682619B8454AD14D80BC0@AM0PR04MB5475.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5475;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5475;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(13464003)(2501003)(33656002)(81166006)(11346002)(8676002)(97736004)(5660300001)(66066001)(55016002)(6246003)(53936002)(74316002)(71190400001)(2906002)(9686003)(6116002)(14454004)(39060400002)(99286004)(4326008)(25786009)(305945005)(478600001)(8936002)(14444005)(6436002)(71200400001)(3846002)(86362001)(53546011)(105586002)(229853002)(106356001)(486006)(44832011)(446003)(316002)(81156014)(110136005)(68736007)(26005)(7736002)(7696005)(186003)(76176011)(6506007)(54906003)(476003)(256004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5475;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H2rdqHO9VW7TFTLERac0aeRnHAw09CzItj4NspFYMbC4fzLuLpJDTZQ5oVoGKQjjE0yQyvlP8W8yb/Vkuf/7+GZsbl2cipLZ0/HVtOueH3++rrYeGYPdaFS8Le5Ub00Yu2IqojU4DeFUmPy7ndeMrqJVwN4WCKv6ByNmERm+QRVWr+7SXQeCGlo6ZjmGh3bTrJuPgl6n83/h2E8a0eNGKbA3EUdX1BxqSRxEvoI9y7UpDFCnwE897GVgrk708hOykHn88jWf6bEJ/SjFFc+G0oEfYx1zKwbpR7Km7DloBPex/TtgQNrtXl7nJ2WlYe9l
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a48f20a-9ee0-4dbe-f5da-08d663d85e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 04:30:26.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrey Smirnov [mailto:andrew.smirnov@gmail.com]
> Sent: Monday, December 17, 2018 10:38 AM
> To: linux-kernel@vger.kernel.org
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>; p.zabel@pengutronix.de;
> Fabio Estevam <fabio.estevam@nxp.com>; cphealy@gmail.com;
> l.stach@pengutronix.de; Leonard Crestez <leonard.crestez@nxp.com>; Aishen=
g
> Dong <aisheng.dong@nxp.com>; Richard Zhu <hongxing.zhu@nxp.com>; Rob
> Herring <robh@kernel.org>; devicetree@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH v3 3/3] reset: imx7: Add support for i.MX8MQ IP block var=
iant
>=20
> Add bits and pieces needed to support IP block variant found on i.MX8MQ
> SoCs.
>=20
> Cc: p.zabel@pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: cphealy@gmail.com
> Cc: l.stach@pengutronix.de
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/reset/Kconfig      |   2 +-
>  drivers/reset/reset-imx7.c | 106
> +++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig index
> c21da9fe51ec..4909aab7401b 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -50,7 +50,7 @@ config RESET_HSDK
>  config RESET_IMX7
>  	bool "i.MX7 Reset Driver" if COMPILE_TEST
>  	depends on HAS_IOMEM
> -	default SOC_IMX7D
> +	default SOC_IMX7D || SOC_IMX8MQ

SOC_IMX8MQ has been removed in Shawn's tree.
I'd suggest simply using ARCH_MXC.

Regards
Dong Aisheng

>  	select MFD_SYSCON
>  	help
>  	  This enables the reset controller driver for i.MX7 SoCs.
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c inde=
x
> 3a36d5863891..bb826935db6d 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -22,6 +22,7 @@
>  #include <linux/reset-controller.h>
>  #include <linux/regmap.h>
>  #include <dt-bindings/reset/imx7-reset.h>
> +#include <dt-bindings/reset/imx8mq-reset.h>
>=20
>  struct imx7_src_signal {
>  	unsigned int offset, bit;
> @@ -113,6 +114,110 @@ static const struct imx7_src_variant variant_imx7 =
=3D
> {
>  	.prepare =3D imx7_src_prepare,
>  };
>=20
> +enum imx8mq_src_registers {
> +	SRC_A53RCR0		=3D 0x0004,
> +	SRC_HDMI_RCR		=3D 0x0030,
> +	SRC_DISP_RCR		=3D 0x0034,
> +	SRC_GPU_RCR		=3D 0x0040,
> +	SRC_VPU_RCR		=3D 0x0044,
> +	SRC_PCIE2_RCR		=3D 0x0048,
> +	SRC_MIPIPHY1_RCR	=3D 0x004c,
> +	SRC_MIPIPHY2_RCR	=3D 0x0050,
> +	SRC_DDRC2_RCR		=3D 0x1004,
> +};
> +
> +static const struct imx7_src_signal
> imx8mq_src_signals[IMX8MQ_RESET_NUM] =3D {
> +	[IMX8MQ_RESET_A53_CORE_POR_RESET0]	=3D { SRC_A53RCR0, BIT(0) },
> +	[IMX8MQ_RESET_A53_CORE_POR_RESET1]	=3D { SRC_A53RCR0, BIT(1) },
> +	[IMX8MQ_RESET_A53_CORE_POR_RESET2]	=3D { SRC_A53RCR0, BIT(2) },
> +	[IMX8MQ_RESET_A53_CORE_POR_RESET3]	=3D { SRC_A53RCR0, BIT(3) },
> +	[IMX8MQ_RESET_A53_CORE_RESET0]		=3D { SRC_A53RCR0, BIT(4) },
> +	[IMX8MQ_RESET_A53_CORE_RESET1]		=3D { SRC_A53RCR0, BIT(5) },
> +	[IMX8MQ_RESET_A53_CORE_RESET2]		=3D { SRC_A53RCR0, BIT(6) },
> +	[IMX8MQ_RESET_A53_CORE_RESET3]		=3D { SRC_A53RCR0, BIT(7) },
> +	[IMX8MQ_RESET_A53_DBG_RESET0]		=3D { SRC_A53RCR0, BIT(8) },
> +	[IMX8MQ_RESET_A53_DBG_RESET1]		=3D { SRC_A53RCR0, BIT(9) },
> +	[IMX8MQ_RESET_A53_DBG_RESET2]		=3D { SRC_A53RCR0, BIT(10) },
> +	[IMX8MQ_RESET_A53_DBG_RESET3]		=3D { SRC_A53RCR0, BIT(11) },
> +	[IMX8MQ_RESET_A53_ETM_RESET0]		=3D { SRC_A53RCR0, BIT(12) },
> +	[IMX8MQ_RESET_A53_ETM_RESET1]		=3D { SRC_A53RCR0, BIT(13) },
> +	[IMX8MQ_RESET_A53_ETM_RESET2]		=3D { SRC_A53RCR0, BIT(14) },
> +	[IMX8MQ_RESET_A53_ETM_RESET3]		=3D { SRC_A53RCR0, BIT(15) },
> +	[IMX8MQ_RESET_A53_SOC_DBG_RESET]	=3D { SRC_A53RCR0, BIT(20) },
> +	[IMX8MQ_RESET_A53_L2RESET]		=3D { SRC_A53RCR0, BIT(21) },
> +	[IMX8MQ_RESET_SW_NON_SCLR_M4C_RST]	=3D { SRC_M4RCR, BIT(0) },
> +	[IMX8MQ_RESET_OTG1_PHY_RESET]		=3D { SRC_USBOPHY1_RCR,
> BIT(0) },
> +	[IMX8MQ_RESET_OTG2_PHY_RESET]		=3D { SRC_USBOPHY2_RCR,
> BIT(0) },
> +	[IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N]	=3D { SRC_MIPIPHY_RCR,
> BIT(1) },
> +	[IMX8MQ_RESET_MIPI_DSI_RESET_N]		=3D { SRC_MIPIPHY_RCR,
> BIT(2) },
> +	[IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N]	=3D { SRC_MIPIPHY_RCR,
> BIT(3) },
> +	[IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N]	=3D { SRC_MIPIPHY_RCR,
> BIT(4) },
> +	[IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N]	=3D { SRC_MIPIPHY_RCR,
> BIT(5) },
> +	[IMX8MQ_RESET_PCIEPHY]			=3D { SRC_PCIEPHY_RCR,
> +						    BIT(2) | BIT(1) },
> +	[IMX8MQ_RESET_PCIEPHY_PERST]		=3D { SRC_PCIEPHY_RCR,
> BIT(3) },
> +	[IMX8MQ_RESET_PCIE_CTRL_APPS_EN]	=3D { SRC_PCIEPHY_RCR,
> BIT(6) },
> +	[IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF]	=3D { SRC_PCIEPHY_RCR,
> BIT(11) },
> +	[IMX8MQ_RESET_HDMI_PHY_APB_RESET]	=3D { SRC_HDMI_RCR, BIT(0) },
> +	[IMX8MQ_RESET_DISP_RESET]		=3D { SRC_DISP_RCR, BIT(0) },
> +	[IMX8MQ_RESET_GPU_RESET]		=3D { SRC_GPU_RCR, BIT(0) },
> +	[IMX8MQ_RESET_VPU_RESET]		=3D { SRC_VPU_RCR, BIT(0) },
> +	[IMX8MQ_RESET_PCIEPHY2]			=3D { SRC_PCIE2_RCR,
> +						    BIT(2) | BIT(1) },
> +	[IMX8MQ_RESET_PCIEPHY2_PERST]		=3D { SRC_PCIE2_RCR, BIT(3) },
> +	[IMX8MQ_RESET_PCIE2_CTRL_APPS_EN]	=3D { SRC_PCIE2_RCR, BIT(6) },
> +	[IMX8MQ_RESET_PCIE2_CTRL_APPS_TURNOFF]	=3D { SRC_PCIE2_RCR,
> BIT(11) },
> +	[IMX8MQ_RESET_MIPI_CSI1_CORE_RESET]	=3D { SRC_MIPIPHY1_RCR,
> BIT(0) },
> +	[IMX8MQ_RESET_MIPI_CSI1_PHY_REF_RESET]	=3D { SRC_MIPIPHY1_RCR,
> BIT(1) },
> +	[IMX8MQ_RESET_MIPI_CSI1_ESC_RESET]	=3D { SRC_MIPIPHY1_RCR,
> BIT(2) },
> +	[IMX8MQ_RESET_MIPI_CSI2_CORE_RESET]	=3D { SRC_MIPIPHY2_RCR,
> BIT(0) },
> +	[IMX8MQ_RESET_MIPI_CSI2_PHY_REF_RESET]	=3D { SRC_MIPIPHY2_RCR,
> BIT(1) },
> +	[IMX8MQ_RESET_MIPI_CSI2_ESC_RESET]	=3D { SRC_MIPIPHY2_RCR,
> BIT(2) },
> +	[IMX8MQ_RESET_DDRC1_PRST]		=3D { SRC_DDRC_RCR, BIT(0) },
> +	[IMX8MQ_RESET_DDRC1_CORE_RESET]		=3D { SRC_DDRC_RCR,
> BIT(1) },
> +	[IMX8MQ_RESET_DDRC1_PHY_RESET]		=3D { SRC_DDRC_RCR, BIT(2) },
> +	[IMX8MQ_RESET_DDRC2_PHY_RESET]		=3D { SRC_DDRC2_RCR, BIT(0) },
> +	[IMX8MQ_RESET_DDRC2_CORE_RESET]		=3D { SRC_DDRC2_RCR,
> BIT(1) },
> +	[IMX8MQ_RESET_DDRC2_PRST]		=3D { SRC_DDRC2_RCR, BIT(2) },
> +};
> +
> +static unsigned int
> +imx8mq_src_prepare(struct imx7_src *imx7src, unsigned long id, bool
> +assert) {
> +	const unsigned int bit =3D imx7src->variant->signals[id].bit;
> +	unsigned int value =3D assert ? bit : 0;
> +
> +	switch (id) {
> +	case IMX8MQ_RESET_PCIEPHY:
> +	case IMX8MQ_RESET_PCIEPHY2: /* fallthrough */
> +		/*
> +		 * wait for more than 10us to release phy g_rst and
> +		 * btnrst
> +		 */
> +		if (!assert)
> +			udelay(10);
> +		break;
> +
> +	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
> +	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
> +	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	/* fallthrough */
> +	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	/* fallthrough */
> +	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	/* fallthrough */
> +	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
> +	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
> +		value =3D assert ? 0 : bit;
> +		break;
> +	}
> +
> +	return value;
> +}
> +
> +static const struct imx7_src_variant variant_imx8mq =3D {
> +	.signals =3D imx8mq_src_signals,
> +	.signals_num =3D ARRAY_SIZE(imx8mq_src_signals),
> +	.prepare =3D imx8mq_src_prepare,
> +};
> +
>  static struct imx7_src *to_imx7_src(struct reset_controller_dev *rcdev) =
 {
>  	return container_of(rcdev, struct imx7_src, rcdev); @@ -175,6 +280,7
> @@ static int imx7_reset_probe(struct platform_device *pdev)
>=20
>  static const struct of_device_id imx7_reset_dt_ids[] =3D {
>  	{ .compatible =3D "fsl,imx7d-src", .data =3D &variant_imx7 },
> +	{ .compatible =3D "fsl,imx8mq-src", .data =3D &variant_imx8mq },
>  	{ /* sentinel */ },
>  };
>=20
> --
> 2.19.1

