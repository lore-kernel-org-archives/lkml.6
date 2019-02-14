Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F0FC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05072222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mp6llOya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437034AbfBNRxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:53:03 -0500
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:39054
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730972AbfBNRxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPIQWCdpjiY8sn4XCPMghSnPNqQP5OkjG9YAiF8YD0Q=;
 b=Mp6llOyaxcZGw5GE3RgdNoUOKp4xmiPI2MnFLchojQBTbBQIu3y+jgICR9m7VWvJcTa+q+kzS/RnXsSHNiz1isIdNJMknIoCOry5AGSr+LK3VvldaeXjNuGE+Rx6zNpM24VxquNs9VzuXA1mHdbS7HYi355aVFwv4+q2rmLtKUY=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB3955.eurprd04.prod.outlook.com (52.134.90.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 14 Feb 2019 17:52:58 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 17:52:58 +0000
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
Thread-Index: AQHUw88PEadq5tNj9UipD3QjqB4ZgKXfcmUAgAAYfACAAAJTgIAAAb8AgAAFq4A=
Date:   Thu, 14 Feb 2019 17:52:58 +0000
Message-ID: <20190214175257.id7yrrxxwev42p2p@fsr-ub1664-175>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-6-git-send-email-abel.vesa@nxp.com>
 <1550159428.2546.40.camel@pengutronix.de>
 <20190214171806.kufhw7ouguxt5jhq@fsr-ub1664-175>
 <1550165185.2546.48.camel@pengutronix.de>
 <1550165560.2546.50.camel@pengutronix.de>
In-Reply-To: <1550165560.2546.50.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fc86bbb-d30d-4547-2def-08d692a5413b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3955;
x-ms-traffictypediagnostic: AM0PR04MB3955:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB3955;23:1rUxzyHZkHNA9BRUaoWI5Goo/OiQJtB1IVoWYJ7?=
 =?iso-8859-1?Q?QMIW9BzSbSIgJK1J7Xb1vH8R+dsQmu0jrW/oYVP+2HQmeU+mTThQFc4ifF?=
 =?iso-8859-1?Q?ELYLm0bZBRsPiLOz0MNzPpUC8NZO7fDB57+/1Bm1kE2yNMtPI3polHzHMX?=
 =?iso-8859-1?Q?pgOXKuOXzayq4VKuRXUY1hELKW0QAResi/SHHlNQCGBJALDRN6iMX5zE2U?=
 =?iso-8859-1?Q?6LA37VJwjv9RIMfnmgPIopKW/USe/n6M6naq7tFXjs6OgI09EC//aRHO7N?=
 =?iso-8859-1?Q?ZQhoOALeqQUcvT8r5z/nrvobfP+Q07TUHNP2/M8gqlBPGoo3j81YHU1eUY?=
 =?iso-8859-1?Q?CMIVmA3cMUaPQ0I3kg9jziNoRde69tnwCl9sZwx+Kf5/K3fzMtFOAivlzy?=
 =?iso-8859-1?Q?mD24yvpHVSPpRc5lV7ee5nBhyq0VZn7F7m1C7HV29/s3qu0WCkdnRFssYv?=
 =?iso-8859-1?Q?o9PQDfxdabfbvO7H2vtfsFRnpCx81vE/oupkJk5h+ymM3e2eJpKPR+T6Yj?=
 =?iso-8859-1?Q?cqrXydV6YcZwSXAojGmorelUWpdKj1n5VLcTtngD+lG3Xa6i882n42Kfoc?=
 =?iso-8859-1?Q?BUlSwpRI1ewiFDUdgoOYaKKsT4EyMciGU7vJ6M3P+ZZQyn/xQAFgsYG3Gx?=
 =?iso-8859-1?Q?1IRKciunaWD13FX9eqmHZ/c+p9r3a31IstzOHJbrllXOpEDDrwlpysT0+l?=
 =?iso-8859-1?Q?HwY+rWulIa1kfDo62k0a1LWUKORTaoqaN3JjnLcU4h8gFA9uIgR/BOL/DZ?=
 =?iso-8859-1?Q?Vox+SZJEbcDOcy2yLCsvptQ4VFNgsHodHqkWRcdSm/78RsdJBwD3t8WzKq?=
 =?iso-8859-1?Q?XxzrrLlF7OMSwFpZ+NQGnFMozTdFvvO8jdJcc6IwuR4nNHyLFAppZ4R3Ad?=
 =?iso-8859-1?Q?utrhOG4D9M3zAhE7ib/qUBxXXebqtWp2k4ribmUu2wb5F8s+RoZdiRArZY?=
 =?iso-8859-1?Q?x0jKcO53TLQTbtdLlVJchZkMY41qZFs+SB+EUguJPKYfzsZTPt3Iq983Gz?=
 =?iso-8859-1?Q?p19gudkEXbDxnlhvKKRtYRzsodJZDRbUrXO3/aPsvnEzFwIxvGE2OfClB6?=
 =?iso-8859-1?Q?FYI9VG/iKBp7jEtJ7F4Q7orbuM2bGeF1ws7ZuVjrtuFkNBk31zwFaGypZd?=
 =?iso-8859-1?Q?Jc4AlmOQgvklAQyOAIyD+gJ8J+iZuARkeWsM/YHLfPaEXvAfh2bzW+jZas?=
 =?iso-8859-1?Q?9oBgmL/HuS0dwuhwaTPpmuYpBIMspIYkfxH0XUl8Mget6r5dWEMgfT+ZR7?=
 =?iso-8859-1?Q?Vv+fMVbTEZM6fzgOB7We0MVDeDD1iKB7aG8VO+OhDywIsX4OgdR3qsdUPx?=
 =?iso-8859-1?Q?+vWterZbAcPLKm848X7J2XJ7SGi+d/ZtaGDE6ybuIzNN+5cQv52M+paGvv?=
 =?iso-8859-1?Q?dC9ab2uahSlqTY1BeRaxjb5NZuI4hGvnGShBVJxpoh4SxkjQYsWbCFDvbu?=
 =?iso-8859-1?Q?9kTYhXpTwQaArTHsqx+Cq5HVZ4bx1PopEG/?=
x-microsoft-antispam-prvs: <AM0PR04MB3955CBB479A359FC630DA340F6670@AM0PR04MB3955.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(189003)(199004)(86362001)(53936002)(6116002)(53546011)(71200400001)(3846002)(7416002)(25786009)(44832011)(6506007)(99286004)(229853002)(9686003)(71190400001)(966005)(6512007)(478600001)(186003)(6306002)(6916009)(26005)(2906002)(11346002)(486006)(476003)(446003)(102836004)(6486002)(93886005)(316002)(76176011)(97736004)(6436002)(54906003)(33896004)(106356001)(66066001)(4326008)(305945005)(81166006)(105586002)(6246003)(8936002)(1076003)(7736002)(14454004)(45080400002)(81156014)(256004)(8676002)(68736007)(33716001)(32563001)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3955;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4EqQu78D8gWcSMkL3nVCER5TsxmE8R1XNmNY7b6zMRrAFu81vS8qUqqTaA7lw/FgzoQOg9cmx9xCql0ub8QW1U/TIE/PpMf3gMeNLeDOg8N43wR5Pb0iKr/TTMZH34VGXRwNpJ6JSTqRlctxWOJSAjawDCeCqBC6t4LcaXYgBYRae8KAsbxGsrewbII8KZtcxstzdFd0oDdd8Ir8zFgndsPOJiDpy4X981fWN+df9YUVRdXJaNiY8Bie+tkgkYqqxcYi9QBgDhtC8lEgCIfbE6V7xkB61ReWNQIDR4XetXkUXTK7afQH55M8BKA++DUKh6Ll5XEh15uJoQnKYBHwpS+OKdNPn94TO5cR+ZNPh16NMV/u0MGhTrz6MHJPTly3EKBgKAyk1P/l8A6zlsnNZqTS0EdFm9Y7+R17Qk1eWZ8=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0286DB934C7C1F44A433C8B3FBC7A900@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc86bbb-d30d-4547-2def-08d692a5413b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 17:52:58.0379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3955
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-14 18:32:40, Lucas Stach wrote:
> Am Donnerstag, den 14.02.2019, 18:26 +0100 schrieb Lucas Stach:
> > Am Donnerstag, den 14.02.2019, 17:18 +0000 schrieb Abel Vesa:
> > > On 19-02-14 16:50:28, Lucas Stach wrote:
> > > > Hi Abel
> > > >=20
> > > > Am Mittwoch, den 13.02.2019, 19:05 +0000 schrieb Abel Vesa:
> > > > > Add the opp table containing only non over drive opps.
> > > > > Also add the cpu-supply nodes for the A53 cores in the EVK
> > > > > board.
> > > > >=20
> > > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > > > ---
> > > > > =A0arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 17
> > > > > +++++++++++++++++
> > > > > =A0arch/arm64/boot/dts/freescale/imx8mq.dtsi=A0=A0=A0=A0| 23
> > > > > +++++++++++++++++++++++
> > > > > =A02 files changed, 40 insertions(+)
> > > > >=20
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > > > b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > > > index 54737bf..114359e 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > > > > @@ -31,6 +31,23 @@
> > > > > =A0		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > > > > =A0		enable-active-high;
> > > > > =A0	};
> > > > > +
> > > > > +};
> > > > > +
> > > > > +&A53_0 {
> > > > > +	cpu-supply =3D <&sw1a_reg>;
> > > > > +};
> > > > > +
> > > > > +&A53_1 {
> > > > > +	cpu-supply =3D <&sw1a_reg>;
> > > > > +};
> > > > > +
> > > > > +&A53_2 {
> > > > > +	cpu-supply =3D <&sw1a_reg>;
> > > > > +};
> > > > > +
> > > > > +&A53_3 {
> > > > > +	cpu-supply =3D <&sw1a_reg>;
> > > > > =A0};
> > > >=20
> > > > This should be a separate patch.
> > > >=20
> > >=20
> > > OK, will send as separate patches in the next version.
> > >=20
> > > > And AFAICS this is wrong, sw1a on the MX8M-EVK is the GPU supply,
> > > > the
> > > > CPU is supplied by a dedicated switcher that is controlled via a
> > > > GPIO.
> > > >=20
> > >=20
> > > Hmm, I think you're right. At least this is what the following
> > > document says.
> > >=20
> > > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
www.mouser.com%2Fds%2F2%2F302%2FIMX8MDQLQEVKHUG-1280333.pdf&amp;data=3D02%7=
C01%7Cabel.vesa%40nxp.com%7Cf7666164aff84f6f975d08d692a26c2a%7C686ea1d3bc2b=
4c6fa92cd99c5c301635%7C0%7C1%7C636857623628438873&amp;sdata=3DEJJdfD8ewEXVQ=
STf2FqjEeUqGJd%2BwW94OQag428lszY%3D&amp;reserved=3D0
> > >=20
> > > So I guess this means there will not be any cpu-supply properties.=A0
> >=20
> > There is a variable voltage CPU supply, but you need to model it as a
> > gpio-regulator in the DT, it's not part of the PMIC provided rails.
>=20
> In the schematics it's the line called PWM_LED (actually it's just
> GPIO1_IO13) that controls the voltage. This changes the feedback of the
> DCDC switcher, so it can toggle between 0.9V and 1.0V.
>=20

Thanks, will look into it tomorrow when I get back at the office.

> Regards,
> Lucas=
