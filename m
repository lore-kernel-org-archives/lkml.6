Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA009C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891F12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qD0bkynP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfBTD04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:26:56 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:11011
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbfBTD04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ/63euEjE6GsVogFOOyYeFYkM76bg5T20Eho1e6HCI=;
 b=qD0bkynPPVvkpc76vOYxlzP6TbwC09KT7PG+QLJRFXHLyG2FRozcov/60MEXIks828KLI9AkBbmMXhfgwXPZ1j6pq16ro/WraswZyjFYnSOaskv+yBk1MdphbjKnyKDHaZo82qDBtESvHWhdXrN99Q3gXutL/JafPiuYy6XFN7g=
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com (52.135.168.141) by
 AM6PR04MB5127.eurprd04.prod.outlook.com (20.177.34.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 03:26:50 +0000
Received: from AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08]) by AM6PR04MB4215.eurprd04.prod.outlook.com
 ([fe80::e944:6749:3ee6:4e08%5]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 03:26:50 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUvsrbmfXgtz1KZEeItOtlZ1aFAqXoGd6w
Date:   Wed, 20 Feb 2019 03:26:50 +0000
Message-ID: <AM6PR04MB4215E32892899A6E84182D43807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb288baa-c6ce-49d0-60c1-08d696e34090
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5127;
x-ms-traffictypediagnostic: AM6PR04MB5127:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB5127;23:MZczyAfKgmWT53TB++0fkONPErgRYyGiX2CHgM3zm?=
 =?us-ascii?Q?c7toD8i09r7YnsRRAIL06FM5fTusuAa6DOlfzeZoiWAq5hzYiZgGszIeIj5/?=
 =?us-ascii?Q?3w5+Hrorr3Yb4lwm/kIg63lNPWumRs3uVhqcBcKue8Gtsy+CU9Ae+D2hPMeP?=
 =?us-ascii?Q?mDUfIBeLH0AtpRmdphR8DVOzzCnFC7wV90Tt45/QmJQ7ND3tB/wawn2qBwgd?=
 =?us-ascii?Q?cFD8zrnMSjenvHuOXQaKI197+zFj00pBe5g+QBARyf5fp3Sx8vU2xIYijV0N?=
 =?us-ascii?Q?8qndKBTH8/XHUUvdLquOGPe5ivsqInnYvR/gPcrGxLiBemipU9lv2vA78gTU?=
 =?us-ascii?Q?1U4jSxYyAzHRY+7Mra3FkiCaNPc86jiC+77X5Ax8o6mJnvHICuM1wCd0dEW8?=
 =?us-ascii?Q?KABHcR0z32RHVZv91qUfDpJiWHWZcFri4OhmcfJC5rOgwZnS7PZgmF7CewIO?=
 =?us-ascii?Q?UJZWt2kWcChZ+ZOdVkaAt1GKXXgXjAIyYkvm3AXnlYPkOUQgDafVDij61U8C?=
 =?us-ascii?Q?2TPXhllJQWOqxfE0yC93Xlkqb1eYNBu3ZxcpOyW8O0SKla+zUexeQ7pLJ3ra?=
 =?us-ascii?Q?dlGIKyLnJaMS/YPeNr3flBFcbIaWSxmBBeHIzm6sGRQtzqRtJ/U30UUm0MeC?=
 =?us-ascii?Q?ez65c6D0w63GiUAtar7jPhh9qFrvMhmkHeDdBaLh5XiAUwW80CAPLMkGFnrc?=
 =?us-ascii?Q?PsDb7qVSWceo9LNlIcSD0SqDaVo799W5VvTMEiZOkqWsAjvf+NWC5Ea2pBWu?=
 =?us-ascii?Q?7DAKgbgMSYzAkoBXRraCtV4WVr/P721torPBNV/kW4f3scHxlseLSquwrbYX?=
 =?us-ascii?Q?xNl1EJspKP6Jsr4Vx/1b2v6lAycrtTbbxTYcEcnTKzLN+mF7Cxzc9oCJkTSJ?=
 =?us-ascii?Q?7V9Zff06LBBkU185gEa2YOoxieE/fwlJ3XBajnQChbhAgJlwesckanG3yxvh?=
 =?us-ascii?Q?gGAy/yYf2AujY8FwpNIaMcE9Q6c/gTOkQZ8AQg8NQpr2LT5MEHSAu/Rb4ePt?=
 =?us-ascii?Q?ZoJEDn5l9FM1uW1K+BNNlTe/qIYML8lI0pujId4g1zRKJaCeOJ7aZRtY9i86?=
 =?us-ascii?Q?MV8yDBvJBsEFXcMBFdZS7Mt1ccHXnWVdzOzwrXtdI4JfGb3BCLI6BESp7tIy?=
 =?us-ascii?Q?oPte+8x2vH4QOxZuorDFFOA7kVfHhQMNuu8JYvHwjgGPvItNgbiz1KPVLCq7?=
 =?us-ascii?Q?5OYqf6DzQxx+Gici9kMy4Nk14tD3AVucvMa2FaNHbpgAFB6QpSby0sDFsRT/?=
 =?us-ascii?Q?rkZ3GXGGEJ9jAQAO1v6uxJDuK4FxAqmwA7ICxqBonsCBu1jOh0VOsCbLJmDS?=
 =?us-ascii?Q?sQwUWqKrKwbKZ6gYrza5NY=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB5127DF312A9A717A4ED19C7E807D0@AM6PR04MB5127.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(54534003)(2501003)(9686003)(8936002)(44832011)(6436002)(97736004)(8676002)(55016002)(81156014)(486006)(81166006)(76176011)(33656002)(7696005)(229853002)(71190400001)(99286004)(71200400001)(6116002)(476003)(446003)(11346002)(4326008)(3846002)(256004)(68736007)(110136005)(74316002)(105586002)(6246003)(5660300002)(305945005)(7736002)(106356001)(26005)(66066001)(86362001)(186003)(7416002)(478600001)(2906002)(316002)(2201001)(6506007)(53936002)(102836004)(14454004)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5127;H:AM6PR04MB4215.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UbXaWKWVjhniRD9SS+4G50LSGO3JsZKeW7HfCQyoFqGchz9xIhyNb95yBFjjVV3uEc59FRNhS8Aqje1FwH0z7YchLV/Xliv8OXoygfAyN6A1dJtAsc9irYzIADvH8rdSXDmMk+X2IJS1zUHaYTPIa0ERQEpcBGisxudZHTCelUY2FV2R7xkTR3ct1La1YTbxy7PsA/5mmb28WY7Z4Mu4ZW6SFugijHygbCwAvbdeZSHTsWtopm2GV6jcfQG630bR4+fxL7F4CHZ7FT9JQHioOnufGhYBF5aw+mUHFtAPYFhgnJWHRtt9ODHFA+JCr0qZnSYjXn68WfrDZUfVrvxyvREnrmyY5sppw2yz1WIHTcSL3WHG+nnmZ3Q36jQouaQeBFiZXeN6l4gUBnQBEMqU+oY+uSG57tiuF+uWOgy6hRE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb288baa-c6ce-49d0-60c1-08d696e34090
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 03:26:50.2819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
> Sent: Thursday, February 7, 2019 5:53 PM
[...]
>=20
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as system
> controller, the system controller is in charge of system power, clock and
> thermal sensors etc. management, Linux kernel has to communicate with
> system controller via MU (message unit) IPC to get temperature from therm=
al
> sensors, this patch adds binding doc for i.MX system controller thermal d=
river.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> ChangeLog since V5:
> 	- add "imx,sensor-resource-id" in each thermal zone to pass resource ID
> for thermal driver.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt    | 20
> ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 72d481c..4b79751 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -122,6 +122,20 @@ RTC bindings based on SCU Message Protocol
> Required properties:
>  - compatible: should be "fsl,imx8qxp-sc-rtc";
>=20
> +Thermal bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible : Must be "fsl,imx8qxp-sc-thermal";
> +- tsens-num : Total number of thermal sensors supported;
> +- #thermal-sensor-cells : Should be 1. See
> +			  Documentation/devicetree/bindings/thermal/thermal.txt
> +			  for a description.
> +- imx,sensor-resource-id : This property should be defined in each therm=
al
> zone
> +			   of thermal-zones node, it passes each thermal zone's
> +			   resource id for thermal driver to get temperature via
> +			   SCU IPC.

This is missing in the example?

BTW, is this SCU function likely platform dependent?
If not, you probably could add a fallback compatible such as "fsl,scu-rtc"

Regards
Dong Aisheng

> +
>  Example (imx8qxp):
>  -------------
>  lsio_mu1: mailbox@5d1c0000 {
> @@ -168,6 +182,12 @@ firmware {
>  		rtc: rtc {
>  			compatible =3D "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible =3D "fsl,imx8qxp-sc-thermal";
> +			tsens-num =3D <1>;
> +			#thermal-sensor-cells =3D <1>;
> +		};
>  	};
>  };
>=20
> --
> 2.7.4

