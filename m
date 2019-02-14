Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468ACC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096E6222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zmosh46x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbfBNRSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:18:13 -0500
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:13568
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726160AbfBNRSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMoE6g7ZSe5j9iSFXU39Nf/NW33w+ZydDAAtUVN/whY=;
 b=Zmosh46x+UWVGB99q3isf1Fucy5InNDknwdgAyC94kZ6jsqV4zHIUGJJ2+UcJZitIMlbedKePX0DsJW8b4GNmsirqz5sDoU5DBKpfKxBhCt+KM9kjMFA+ZSsiWEZOv/E7PXNTBHQyl59/HlmNky7Ldui5IHFvX+wp2JUXiYITxc=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4833.eurprd04.prod.outlook.com (20.176.215.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 17:18:07 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 17:18:07 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
Thread-Topic: [RFC 5/5] arm64: dts: imx8mq: Add the opp table and the
 cpu-supply nodes
Thread-Index: AQHUw88PEadq5tNj9UipD3QjqB4ZgKXfcmUAgAAYfAA=
Date:   Thu, 14 Feb 2019 17:18:07 +0000
Message-ID: <20190214171806.kufhw7ouguxt5jhq@fsr-ub1664-175>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
 <1550159428.2546.40.camel@pengutronix.de>
In-Reply-To: <1550159428.2546.40.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f57d5699-ce87-4ce9-1d5c-08d692a062ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4833;
x-ms-traffictypediagnostic: AM0PR04MB4833:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4833;23:QSqPiYb0TNS/oz4rRID9bKHAG6H08Desq2HmExk?=
 =?iso-8859-1?Q?9gHZ/f/wwda1wznrHsSh3NGt5xxh2oybgybuRmZcZHWr1yw0i6vlJitsFR?=
 =?iso-8859-1?Q?8ysVc2hY3cd9lPmu7hUv+e23fXwblFZpUvisYjPZuMXkGL+FIPLdhwf5JI?=
 =?iso-8859-1?Q?HL5xkwCjt+uxH0x4xmAThyPfT81K4njy6WJ0vD7Na4Cb+vC3JOmWYUY64L?=
 =?iso-8859-1?Q?AwBBKnA7Ph2OQHelMaHRSUlrfmBte6Xnsh5p2o/A1xuXcmP7+uDoCxM+0Y?=
 =?iso-8859-1?Q?jtBszX0O+Xd5hfo51mZCp6RVfRo2iN/L1u83bS6iQwE6hDTKBGYUBy8vRa?=
 =?iso-8859-1?Q?arDoXM3HnYt8FNIeVE3o7lt/20eL4sMEexyR+muKMB/mE0T7+lWtNvtDfs?=
 =?iso-8859-1?Q?xIG/bQxpAcxJJE73d20t/MbQgzL8FTC8FESTRlZDLwE8J2OQySo2MayaSi?=
 =?iso-8859-1?Q?SZ59Pfq+J03+39PgKyCSf0ovitfJ13TSKbXmvE2QoKSqtpaAOGQ+F5H7h3?=
 =?iso-8859-1?Q?fdWFVrPwBFgkbrZBDLfWqqPhWoAGt8hcd7yHX/qP96fAi0SRfMf1buo7x0?=
 =?iso-8859-1?Q?4E2v/aAPuse+qPbD1Buex/5PFyU7pgQev/kcUPvZTvxqgVn6kqIEDO/WFl?=
 =?iso-8859-1?Q?H5nXAL5ABzJUutrU0hwXVpuIXCbcbsqe6ZjoY25i1RbOF1sXGLY8Wm37Ss?=
 =?iso-8859-1?Q?yVLKY67AZEvlXCOhry+GUdNg/98+QasgY5TMdMjdCcgXs7v2Oyz8CB0RZf?=
 =?iso-8859-1?Q?3CeTTXSML5MFMkAQeOjuHAF079XIuPlprD6mjhcAbEHQLR6UFRF6W0MOrH?=
 =?iso-8859-1?Q?/EKysqzMFYajkykxlCUdQ6+sFJ3lICwp6FfbRcf5/pLT1nqMgp4LO0+XYX?=
 =?iso-8859-1?Q?itgBO6gY++K75yr0nx7idIQN8RxJ9lGRHCSgGPK8I/w5WzYL+X1ieOkLYS?=
 =?iso-8859-1?Q?q4aCdURLqsQcxfMLI1oDiW6GuNnE7OyROdoSPg0uV+3ou+U0nQrVPzHvA4?=
 =?iso-8859-1?Q?E7RgYhulnXn9MLFU9mg3aiyo9FYEojG0MEKChD1Z8ed0FTzq08PVZIWiEZ?=
 =?iso-8859-1?Q?HnCtoME5H32xJeXWpVcTxEOGaCNfVEvUUu896I4so/JJ1tNKGqYXthRMiZ?=
 =?iso-8859-1?Q?FCh4qv4A+gr4sSs4yyfzJzfupSeZZ07BAFDmTOqTwhFg/c9IrjdUafazSo?=
 =?iso-8859-1?Q?7yxuKDUp/bqHd0KmHxrKqqvwP9ct3J9eHmztkQQamw5UkNyhi7nPuXGMEj?=
 =?iso-8859-1?Q?w/AQZHlZLmBBDAURFc9ykL2M76e8kTihyvuzthK27M3IsVyglxFdtbjcyt?=
 =?iso-8859-1?Q?Cm04Db+6mJOggtJl5hvoGXwz3S3CAW18sWl5xnNEMRLQuz7SBUFyTnc56P?=
 =?iso-8859-1?Q?hdCWplV4/TQ4lIDDxdntQbNe7V+YXW25iy8hf0tRt0g5M4mqXzo1CmSkiN?=
 =?iso-8859-1?Q?XbDceToBwj1s+4=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB48337108969E1D8044F7A1C0F6670@AM0PR04MB4833.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(6436002)(4326008)(53936002)(25786009)(71190400001)(6306002)(33716001)(68736007)(6512007)(478600001)(9686003)(71200400001)(6246003)(2906002)(14454004)(66066001)(106356001)(105586002)(966005)(6486002)(1076003)(229853002)(14444005)(99286004)(8936002)(97736004)(8676002)(33896004)(7416002)(76176011)(81156014)(6916009)(81166006)(186003)(11346002)(446003)(486006)(6346003)(44832011)(476003)(26005)(6506007)(7736002)(54906003)(305945005)(316002)(102836004)(256004)(86362001)(6116002)(53546011)(3846002)(32563001)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4833;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pLcMExRfcIA1dxLtX8qSn/oFvzHxQug2V9YUvRDxa8zGBaywB1iW1tjPoo3h21eh4N46FtPKlWK2g9yVdbwa+oU+VTh53Pf1S2347HPhkmLD+G0ObPBr55WeDYzu4L1wGE1hIaKChkyOzr9c0kuHwVKs6/kt3g0gQmX3dcngZx+Io+z0qN055R+KZoshAUyuM+LaoobN58abXoLw8pwspflpMMlHxZTWJr9JfnPTN/BoWwBRR5VgJDNImGTKWXs3jlDbhSiMuBOKDNFi16t87TlkLqXc9qyFmkUONUC1XMHHuDkRBYiuQCvs+IhD22VdrZkMlDv1W8rQzg9h4MqYa/oeTsRjwxngcpSftH4t3b/3VYFwq77p9DOhCA1pLljsJAMzBDXsLlmsJgneN7xh5/Ee4ve29tNNv0y4vUwcSIA=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C59E0F6826FFEB43AD5E013C932B78C0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57d5699-ce87-4ce9-1d5c-08d692a062ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 17:18:07.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-14 16:50:28, Lucas Stach wrote:
> Hi Abel
>=20
> Am Mittwoch, den 13.02.2019, 19:05 +0000 schrieb Abel Vesa:
> > Add the opp table containing only non over drive opps.
> > Also add the cpu-supply nodes for the A53 cores in the EVK board.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> > =A0arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17 +++++++++++++++++
> > =A0arch/arm64/boot/dts/freescale/imx8mq.dtsi=A0=A0=A0=A0| 23 ++++++++++=
+++++++++++++
> > =A02 files changed, 40 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > index 54737bf..114359e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > @@ -31,6 +31,23 @@
> > =A0		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > =A0		enable-active-high;
> > =A0	};
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
> > =A0};
>=20
> This should be a separate patch.
>=20

OK, will send as separate patches in the next version.

> And AFAICS this is wrong, sw1a on the MX8M-EVK is the GPU supply, the
> CPU is supplied by a dedicated switcher that is controlled via a GPIO.
>=20

Hmm, I think you're right. At least this is what the following document say=
s.

https://www.mouser.com/ds/2/302/IMX8MDQLQEVKHUG-1280333.pdf

So I guess this means there will not be any cpu-supply properties.=20

Thanks,
Abel

> Regards,
> Lucas
>=20
> > =A0&fec1 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 1a89062..89b2d5f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -91,6 +91,7 @@
> > =A0			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> > =A0			enable-method =3D "psci";
> > =A0			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> > =A0		};
> > =A0
> > =A0		A53_1: cpu@1 {
> > @@ -101,6 +102,7 @@
> > =A0			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> > =A0			enable-method =3D "psci";
> > =A0			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> > =A0		};
> > =A0
> > =A0		A53_2: cpu@2 {
> > @@ -111,6 +113,7 @@
> > =A0			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> > =A0			enable-method =3D "psci";
> > =A0			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> > =A0		};
> > =A0
> > =A0		A53_3: cpu@3 {
> > @@ -121,6 +124,7 @@
> > =A0			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> > =A0			enable-method =3D "psci";
> > =A0			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> > =A0		};
> > =A0
> > =A0		A53_L2: l2-cache0 {
> > @@ -666,6 +670,25 @@
> > =A0			status =3D "disabled";
> > =A0		};
> > =A0
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
> > +				clock-latency-ns =3D <150000>;
> > +				opp-suspend;
> > +			};
> > +		};
> > +
> > =A0		gic: interrupt-controller@38800000 {
> > =A0			compatible =3D "arm,gic-v3";
> > =A0			reg =3D <0x38800000 0x10000>,	/* GIC
> > Dist */=
