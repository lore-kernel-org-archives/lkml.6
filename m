Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC355C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F426253F3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jN+/BBRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F426253F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeFYDOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:14:47 -0400
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:39067
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752196AbeFYDOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al5n2tCFNXjI0JDjuC6zDzr1hU0XbYwKLo7tk8NF1kU=;
 b=jN+/BBRvIv73oOCtw5yPvCY+3uJn6FOZAG0w8/AIRsRc+YUUbXcvM/8VROG+vv0KAQMM0KbxKRauXpImhDbJblG5l82sc/CIaqNPHSTTrAKBEuhOF18igRtDRe4EaS35hiIY3GmRX4wTgcJgTomqqu4+cceTlCYhsTDH3mQ5JgQ=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1460.eurprd04.prod.outlook.com (10.163.186.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Mon, 25 Jun 2018 03:14:40 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%6]) with mapi id 15.20.0884.023; Mon, 25 Jun 2018
 03:14:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
        "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
Thread-Topic: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
Thread-Index: AQHT+tzgLZjjf86PoEejdUN6Da1LsqRwb2EQ
Date:   Mon, 25 Jun 2018 03:14:39 +0000
Message-ID: <AM3PR04MB1315D8B57E1A5D47BECBDCD3F54A0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527990245-13619-1-git-send-email-Anson.Huang@nxp.com>
 <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1527990245-13619-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1460;7:FOnqGkBXHD9iI9Y+CdqTcUFq6kb117tPdKMViqKJ/N0Kw2NC//EDKAf6uGyf7J7q4aN1jddvE8b6bsi54kzJnKAueArXA9bQmA6OH33HPum6LIZLz+9w9oLNJzUisfUgiDui21GXP1V5z1CxowCqppi8O9ilwfdGFIxssPvyyuheOvAok9FngxBMlbzNGI36fBs3pef+Fqh5zfPv6tMX9FJOrXn3LI1AHTQiPRuSOEbxeBIqlNJAAvrfgn7elCFs
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 15853d5b-5a2d-4250-d241-08d5da49ca18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1460;
x-ms-traffictypediagnostic: AM3PR04MB1460:
x-microsoft-antispam-prvs: <AM3PR04MB1460B17CD668E3D51F445B5EF54A0@AM3PR04MB1460.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1460;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1460;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(39380400002)(13464003)(199004)(189003)(2201001)(2900100001)(11346002)(106356001)(6506007)(229853002)(53546011)(102836004)(446003)(186003)(53936002)(4326008)(478600001)(68736007)(44832011)(55016002)(9686003)(5250100002)(486006)(2501003)(105586002)(86362001)(3846002)(110136005)(6436002)(74316002)(99286004)(8936002)(5660300001)(33656002)(7416002)(316002)(7736002)(305945005)(54906003)(97736004)(3660700001)(66066001)(25786009)(26005)(14454004)(6246003)(476003)(8676002)(76176011)(81166006)(7696005)(81156014)(6116002)(2906002)(3280700002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1460;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qaJKl0xmW9KTepH3OtD/grZ/ithdmhGMJTfXHW6ZAYOTaEPvJhbtUJq4ijgYjTf5jMbUJQpAbORpjlEZZq+xK0b70P0B5fF965n/GJmW98g0V6pQ1y6ufHE1sfrqya2rswxQtjOJkEq3Pos73eZwztC14G6D1XkE/fHsc7cjT8XEBirhYTCaxeVaVhc36FFSJgr4/dUvLDzoSIpW7vbAVaJ/zFvCHgYpqogJG2Qy1atKhjWvKJQyWBExyDwKWglSFtlRIla2cLnR1MmJJPLSv54azz4KMi8nVre+d3bupANVDwshYfrtERe3kRF2nCZmr8bGrukupgS0zczS7ZIjNRnkEaXmf7SWXeitlMjVeYY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15853d5b-5a2d-4250-d241-08d5da49ca18
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 03:14:40.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Sunday, June 3, 2018 9:44 AM
> To: shawnguo@kernel.org; kernel@pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> mturquette@baylibre.com; sboyd@kernel.org;
> michael@amarulasolutions.com; matteo.lisi@engicam.com
> Cc: dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.or=
g;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-clk@vger.kernel.org
> Subject: [PATCH V2 2/2] ARM: dts: imx6ul: add GPIO clocks
>=20
> i.MX6UL has GPIO clock gates in CCM CCGR, add clock property for GPIO dri=
ver
> to make sure all GPIO banks work as expected.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> 	no changes since V1.
>  arch/arm/boot/dts/imx6ul.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dts=
i
> index 1241972..405e068 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -437,6 +437,7 @@
>  				reg =3D <0x0209c000 0x4000>;
>  				interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&clks IMX6UL_CLK_GPIO1>;
>  				gpio-controller;
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
> @@ -450,6 +451,7 @@
>  				reg =3D <0x020a0000 0x4000>;
>  				interrupts =3D <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&clks IMX6UL_CLK_GPIO2>;
>  				gpio-controller;
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
> @@ -462,6 +464,7 @@
>  				reg =3D <0x020a4000 0x4000>;
>  				interrupts =3D <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&clks IMX6UL_CLK_GPIO3>;
>  				gpio-controller;
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
> @@ -474,6 +477,7 @@
>  				reg =3D <0x020a8000 0x4000>;
>  				interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&clks IMX6UL_CLK_GPIO4>;
>  				gpio-controller;
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
> @@ -486,6 +490,7 @@
>  				reg =3D <0x020ac000 0x4000>;
>  				interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&clks IMX6UL_CLK_GPIO5>;
>  				gpio-controller;
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
> --
> 2.7.4

