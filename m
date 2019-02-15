Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69425C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B24A2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZjMq5vG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391674AbfBOI4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:56:33 -0500
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:27058
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391613AbfBOI4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMOEGBw7O0D9xfSutby/ZNX1caM3bYSbeQRh4MNCKHc=;
 b=ZjMq5vG+BPMrX+169BO7hCsIRepwKgrTkrPQLMdDUKskwRqQyQUlooeDmd6UqhDrCZzs0D8bnx8ZitwGFXtA0PTpBT23tg9ESsoYXvpOHhS6aYDDiWBihb9G8LbXCw9zZpq0rOM6FxvS9abC4V0fmmuQNZdQFxIJI3ENkXUtypg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6305.eurprd04.prod.outlook.com (20.179.35.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 08:56:26 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 08:56:25 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Angus Ainslie <angus@akkea.ca>
CC:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel-owner@vger.kernel.org" 
        <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
  cpu-supply nodes
Thread-Topic: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
  cpu-supply nodes
Thread-Index: AQHUxMkkpnPnEnH9UEK8Pa2IFDhbGKXgjxUA
Date:   Fri, 15 Feb 2019 08:56:25 +0000
Message-ID: <20190215085624.dtc5uyxch72l2q6g@fsr-ub1664-175>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
 <76b2c0e4a61d022f7f798990af4dfd8b@www.akkea.ca>
In-Reply-To: <76b2c0e4a61d022f7f798990af4dfd8b@www.akkea.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c605fca-1e19-4231-e381-08d693237781
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6305;
x-ms-traffictypediagnostic: AM0PR04MB6305:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB6305;23:2k+0cjWy0bFzZLGevibW/rsBbWJe9Gy+KHI1q4wa8?=
 =?us-ascii?Q?Q+x18TpD1AHPqBgpZpwfQ9PG+7Tb3I/xOBL3fngLu3LMMqzg1DDnb6GSr2j3?=
 =?us-ascii?Q?IwET5kQPvMsnNlimOHor29abfWuMcO58z0DCeuizP9Zm7oswaxBvM+qosPL9?=
 =?us-ascii?Q?hX7IqqFKZ2+Bbn/z3onyqrugULqT7mnp7GlDJEb6zRzwKzzLQsnYaDS+I7mD?=
 =?us-ascii?Q?kJWRaJKY5MI6FN/S08jooQDMlFxzHITQgdccLreoRZxwWOCVbYp3a3cqJCa0?=
 =?us-ascii?Q?bFckY9xwNduSrqD4unyrcf6vaJPpBD8gcLtCMvFf8K8zRfVyFko1kss3bYRH?=
 =?us-ascii?Q?r+W/4ytO2vTOqFFIt/jYHOytBhHzKByBstxKw4xUQBkniJkRh6fQilX8+gFR?=
 =?us-ascii?Q?apLy+iiULfUsk/deXqhT1HEqTXLq2/rLbO0v+oWhsCKcbvzKOhUp/93+dCnN?=
 =?us-ascii?Q?8t53E/2aAGwg/AFbYwpkKKakj4zO1MEhz12F6XomR9AmR+Us1smYsNneHMYU?=
 =?us-ascii?Q?UCzYUTRysUTDNAn+NVHIywvlaxfXq+7QMyfQU+EAbc0VS9SyfRb/9upiPHZn?=
 =?us-ascii?Q?5pRwKMwj/rqFqVVM+/7qR2ZydANAbgisPhL1QQa7kML2g77ZXtkMIdPB2G2I?=
 =?us-ascii?Q?yoXEiu3NlmmEna2KykGm9CUm0v+bhYCISr/NjiTRTsim2aod1/9Lmpt35JXS?=
 =?us-ascii?Q?q+fQGoF8T0z9WlHQGNhljq15JPv2B7EyRwKkXsCR8hIjPQhMo7SZzmWmvjbY?=
 =?us-ascii?Q?XRCInaJAfsXUM6+kYM+Y4NRJy/4ETtaX/q3LbosIkjm4zQ9j7/TvthYWOVhG?=
 =?us-ascii?Q?1DeMZ803H2QDbZiJuyGnnE+iQPjG92rR48WL2KabFmkLCQMlcDvoo2KSTOcq?=
 =?us-ascii?Q?Mw/9xVezyl0gYIlzImemL1H39KYinEblCLnlE8k9E0Fj8BFvhsWupLQz0x1m?=
 =?us-ascii?Q?VGU2I5ugShrrarzKWvvVYCE8JhZKO1x4waUbLPsRi2aiMKXBiSzWrIkjxKuH?=
 =?us-ascii?Q?MqxsgQgY9U2Jjm2tBdGTN68CD4pqFFeM8HgRaW+NCEJwjok37KzfcBCzre4Q?=
 =?us-ascii?Q?X+kwLRhys2FXoPsKA9MLfv0AOgnMIVAJt6gWeF7erQ8NDhvzGs5dEifNoe2c?=
 =?us-ascii?Q?/JUw6nSQTIzqrR2Um2+Qbb/qzB8dkjrtj/UXrOofk2nYsnkKMAf/KK5+L/iB?=
 =?us-ascii?Q?ftlXK0/19BN9K54TqoTpb32IutBg5pIBsA3O3rcGrAO6yR4d65d6StU8tZCr?=
 =?us-ascii?Q?uLpw/gkK8sGDj3Dyo9RXjyt2bN6K0vnOeyVo4xerT4kmHyfVkOM4wd9cZ/tY?=
 =?us-ascii?Q?9B95r4rb77RD/PaEdCf8a5zfBtwBZCV5qFj8ilpXnWw?=
x-microsoft-antispam-prvs: <AM0PR04MB6305ADDE74DCA0D037123B52F6600@AM0PR04MB6305.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(14454004)(229853002)(6116002)(305945005)(6916009)(2906002)(7736002)(105586002)(99286004)(25786009)(3846002)(106356001)(97736004)(6246003)(966005)(81166006)(68736007)(8936002)(478600001)(66066001)(53936002)(81156014)(476003)(6436002)(6486002)(26005)(6306002)(9686003)(6512007)(14444005)(86362001)(316002)(256004)(486006)(8676002)(186003)(33896004)(33716001)(11346002)(71190400001)(71200400001)(102836004)(7416002)(1076003)(446003)(6506007)(53546011)(76176011)(54906003)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6305;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fsA4Dmj6tqdCXzWPwDqtaBpD/Iop9Xm0jZbCEfod179QbWFOcI++2iYVphE5Az1xoTKQlGMvLq6Xg2dGn3wYZWh/UzLZeqVEv2J/GkEFFh/tF7RevCJmvtnoj3/RSrsgOcCHwKENa16MLOxV3TYAegEH8/I18sS5kAftjU/nRmUv2Le0f5bxXFPPiU/sc8Cr54a1AkkUPsTjoAgfC2dTKdku5Ax0QdhRUI/7dEiVigD8/hX53gjQJYpQkYpHYvl6la5c0eT7sASg0uho2EcLEGWAgg19YEt4GmpVLoaPzx8kkSglTnk4SSmvgmsxrFjnuUBgoo773UjTx6PiIxXPoM2GAQt3DLq2UpxQZKDOAdkQfxb9tHlY1w7suMhvJaPaLysMguUt4HQmJrSVfp3Ju23GLAVs2q/iprw/H5PMSxw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2998E0C023992748802F4B623D2C5B93@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c605fca-1e19-4231-e381-08d693237781
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 08:56:25.6822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-14 16:55:22, Angus Ainslie wrote:
> On 2019-02-13 11:05, Abel Vesa wrote:
> > Add the opp table containing only non over drive opps.
> > Also add the cpu-supply nodes for the A53 cores in the EVK board.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 23
> > +++++++++++++++++++++++
> >  2 files changed, 40 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > index 54737bf..114359e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > @@ -31,6 +31,23 @@
> >  		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> >  		enable-active-high;
> >  	};
> > +
> > +};
> > +
> > +&A53_0 {
> > +	cpu-supply =3D <&sw1a_reg>;
> > +};
> > +
> > +&A53_1 {
> > +	cpu-supply =3D <&sw1a_reg>;
> > +};
> > +
> > +&A53_2 {
> > +	cpu-supply =3D <&sw1a_reg>;
> > +};
> > +
> > +&A53_3 {
> > +	cpu-supply =3D <&sw1a_reg>;
> >  };
> >=20
> >  &fec1 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 1a89062..89b2d5f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -91,6 +91,7 @@
> >  			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method =3D "psci";
> >  			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> >  		};
> >=20
> >  		A53_1: cpu@1 {
> > @@ -101,6 +102,7 @@
> >  			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method =3D "psci";
> >  			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> >  		};
> >=20
> >  		A53_2: cpu@2 {
> > @@ -111,6 +113,7 @@
> >  			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method =3D "psci";
> >  			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> >  		};
> >=20
> >  		A53_3: cpu@3 {
> > @@ -121,6 +124,7 @@
> >  			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method =3D "psci";
> >  			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> >  		};
> >=20
> >  		A53_L2: l2-cache0 {
> > @@ -666,6 +670,25 @@
> >  			status =3D "disabled";
> >  		};
> >=20
> > +
> > +		a53_0_opp_table: opp-table {
> > +			compatible =3D "operating-points-v2";
> > +			opp-shared;
> > +
> > +			opp-800000000 {
> > +				opp-hz =3D /bits/ 64 <800000000>;
> > +				opp-microvolt =3D <900000>;
> > +				clock-latency-ns =3D <150000>;
> > +			};
> > +
> > +			opp-1000000000 {
> > +				opp-hz =3D /bits/ 64 <1000000000>;
> > +				opp-microvolt =3D <900000>;
>=20
> Shouldn't this be
>=20
> opp-microvolt =3D <1000000>;
>=20

Hmm, I looked into some older datasheet which said the maximum non
overdrive is 1GHz.

But the latest one I could find:

https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQIEC.pdf

says it's 0.8GHz.=20

So I'll fix it in the next version.

Thanks.

> > +				clock-latency-ns =3D <150000>;
> > +				opp-suspend;
> > +			};
> > +		};
> > +
> >  		gic: interrupt-controller@38800000 {
> >  			compatible =3D "arm,gic-v3";
> >  			reg =3D <0x38800000 0x10000>,	/* GIC Dist */
> =
