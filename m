Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3663220831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WYzWRwZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3663220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389572AbeKVR0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:26:18 -0500
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:41664
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbeKVR0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyYj9tFYsjT6gcLnvY82+igwJhmHYgci66a0HiJLMmg=;
 b=WYzWRwZTgU2Ltz6mLKiVoHDBObVika0m0E/C+IoSAEqyvSReGFs+tqJ+X6jvAPQvwkDYxE5fkBAfYaoDR8nBC3LpQeSoayOwaVWcaK17RNbtiKTx+Um06HW+OVBI+Omn9t2bsoDLWwUESZHSNCcqeYcarvJqAOrdoIKT1/+y3wY=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB1599.eurprd04.prod.outlook.com (10.164.84.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Thu, 22 Nov 2018 06:48:09 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::e046:4971:4e49:7e97]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::e046:4971:4e49:7e97%3]) with mapi id 15.20.1294.048; Thu, 22 Nov 2018
 06:48:09 +0000
From:   PETER CHEN <peter.chen@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
Thread-Topic: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
Thread-Index: AQHUZrbVLPaJPX/QuECGrmt/kacFiaU5CfmAgCKGevA=
Date:   Thu, 22 Nov 2018 06:48:09 +0000
Message-ID: <VI1PR04MB5327E5CE977E59E03B1B6C4C8BDB0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
 <20181031073112.GL10386@tiger>
In-Reply-To: <20181031073112.GL10386@tiger>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1599;6:d7fQyfEYIHhdm0SlZM4lfMOPR/6wLWea/ccygR4km8WCGpMv5n7ode/vTT5WSTyMIft0dL0pWVbbgSifvWqBTwTg5r4npU4xd4eUt6nKzmgoIxl67lLmowHCbmDZ1nYystUH4ASSF6aH+y0DvEZgrlu4IN0dVvEz5XHCcYtRxTwzKxHQaT6NgyS/II8ORnTD8Ftg83MJ87sAH2bz1pWx4YQM1+CxVaC7ydj6SOZyCKyel1slN7hIgTQ9vhBW7lC58aC4RSAs69y0jF/Xha/ZCk301elXljhai+CgXVrJjMUmD3zZXrGmybdWtp2c845xvaZ8UKUrTBCnPJXVAooPpVmO5+1X5hFh8hCFTMnvvgspm+YCGy1uiqaQwOWP+ASGzN6qFvPmulqUrcwQEJWEzAKAQoRMzfN7WqkNi13++v8O2IHGBLrFM7w9M+tb6wrhk0FToDZ7vUOn37lAdOFydA==;5:bS1loFA6lZcjID+bn4/hVGfj76tOT2KDnY9Csg6w8VFNysT+gVZIDLKsPMzmzmnMGKOsxCFRQO0HgB1Mo0C8sXgoOOFc3mZvWADL3xZ5W1P3FLBqB076r83KLTIpbOB+ixnWla79NwdWVMPo6/R7EWuVlbcYJbSjydWaTM6LntM=;7:iLEO6zlUxUydbCoG8J/swYoM0PpdKadyYrwpT65jlcEWQMMMCXI/LTsaYdV3HgBT+xzP6sZ+FQHkTMVXv5/FM0WHveVHp7rAR5sPkdKuWbClTwt3+YIxGrvEVd2tv8jxOBdjgLf/4KM37AIzRDFH+Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c9294476-fae5-45e0-9b90-08d650467730
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1599;
x-ms-traffictypediagnostic: VI1PR04MB1599:
x-microsoft-antispam-prvs: <VI1PR04MB1599B4223E635E5FCC839B2F8BDB0@VI1PR04MB1599.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1599;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1599;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(55016002)(99286004)(33656002)(478600001)(68736007)(105586002)(97736004)(4326008)(3846002)(6116002)(6506007)(106356001)(14454004)(229853002)(53346004)(316002)(25786009)(76176011)(6246003)(256004)(6436002)(9686003)(71200400001)(71190400001)(66066001)(53936002)(7696005)(476003)(11346002)(486006)(186003)(5660300001)(446003)(74316002)(305945005)(7736002)(86362001)(2906002)(110136005)(8936002)(102836004)(81166006)(81156014)(26005)(2900100001)(8676002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1599;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d+KKVlY4Jhm+0F3mE1T4jFtugTP4sqJwzXNRljMDq+ruoygq7CgX9x7LpEp7ytED9nr76RNWN5xr1lvdedZD/9LrDQOjyVbT3Up/VCrgEHVNp7aMxbx/xIA6m45j7k8RP5+KR/X4zh0r7Zda4AHS8h+ct3ah3PNJ8SFkg3KRHic/ilpsW3JFLB3vm2RXM8uOsDK1JcLRBAyRznTsouX1gFseLNxfeiG5T7hmXTGiaMN86a55l7Gcckd6c8cKC8KHUVZHX6Al3D/Xkr5YRYriJrMiPWOjQbkHMXphVyqlTBaHneaepi+NMF6R+7aALqKpzq0sSnhDh3+ROG/0aksmNFuVocHHvfABic8Ej3cgFIg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9294476-fae5-45e0-9b90-08d650467730
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 06:48:09.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> On Thu, Oct 18, 2018 at 09:45:04AM +0200, Frieder Schrempf wrote:
> > Some SOCs in the i.MX6 family have a USB host controller that is only
> > capable of the HSIC interface and has no on-board PHY.
> >
> > To be able to use these controllers, we need to add "usb-nop-xceiv"
> > dummy PHYs.
> >
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> @Peter, looks good to you?
>=20
> Shawn
>=20
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 14 ++++++++++++++
> > arch/arm/boot/dts/imx6sl.dtsi  |  7 +++++++
> > arch/arm/boot/dts/imx6sx.dtsi  |  6 ++++++
> >  3 files changed, 27 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi
> > b/arch/arm/boot/dts/imx6qdl.dtsi index 61d2d26..d3404d1 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -139,6 +139,16 @@
> >  		interrupts =3D <0 94 IRQ_TYPE_LEVEL_HIGH>;
> >  	};
> >
> > +	usbphynop1: usbphynop1 {
> > +		compatible =3D "usb-nop-xceiv";
> > +		#phy-cells =3D <0>;
> > +	};
> > +

Why #phy-cells property is needed? Others are ok for me.

Peter

> > +	usbphynop2: usbphynop2 {
> > +		compatible =3D "usb-nop-xceiv";
> > +		#phy-cells =3D <0>;
> > +	};
> > +
> >  	soc {
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <1>;
> > @@ -981,6 +991,8 @@
> >  				reg =3D <0x02184400 0x200>;
> >  				interrupts =3D <0 41 IRQ_TYPE_LEVEL_HIGH>;
> >  				clocks =3D <&clks IMX6QDL_CLK_USBOH3>;
> > +				fsl,usbphy =3D <&usbphynop1>;
> > +				phy_type =3D "hsic";
> >  				fsl,usbmisc =3D <&usbmisc 2>;
> >  				dr_mode =3D "host";
> >  				ahb-burst-config =3D <0x0>;
> > @@ -994,6 +1006,8 @@
> >  				reg =3D <0x02184600 0x200>;
> >  				interrupts =3D <0 42 IRQ_TYPE_LEVEL_HIGH>;
> >  				clocks =3D <&clks IMX6QDL_CLK_USBOH3>;
> > +				fsl,usbphy =3D <&usbphynop2>;
> > +				phy_type =3D "hsic";
> >  				fsl,usbmisc =3D <&usbmisc 3>;
> >  				dr_mode =3D "host";
> >  				ahb-burst-config =3D <0x0>;
> > diff --git a/arch/arm/boot/dts/imx6sl.dtsi
> > b/arch/arm/boot/dts/imx6sl.dtsi index 7a4f5da..81edcdc 100644
> > --- a/arch/arm/boot/dts/imx6sl.dtsi
> > +++ b/arch/arm/boot/dts/imx6sl.dtsi
> > @@ -110,6 +110,11 @@
> >  		interrupts =3D <0 94 IRQ_TYPE_LEVEL_HIGH>;
> >  	};
> >
> > +	usbphynop1: usbphynop1 {
> > +		compatible =3D "usb-nop-xceiv";
> > +		#phy-cells =3D <0>;
> > +	};
> > +
> >  	soc {
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <1>;
> > @@ -815,6 +820,8 @@
> >  				reg =3D <0x02184400 0x200>;
> >  				interrupts =3D <0 40 IRQ_TYPE_LEVEL_HIGH>;
> >  				clocks =3D <&clks IMX6SL_CLK_USBOH3>;
> > +				fsl,usbphy =3D <&usbphynop1>;
> > +				phy_type =3D "hsic";
> >  				fsl,usbmisc =3D <&usbmisc 2>;
> >  				dr_mode =3D "host";
> >  				ahb-burst-config =3D <0x0>;
> > diff --git a/arch/arm/boot/dts/imx6sx.dtsi
> > b/arch/arm/boot/dts/imx6sx.dtsi index 844caa3..07ed417 100644
> > --- a/arch/arm/boot/dts/imx6sx.dtsi
> > +++ b/arch/arm/boot/dts/imx6sx.dtsi
> > @@ -159,6 +159,11 @@
> >  		interrupts =3D <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> >  	};
> >
> > +	usbphynop1: usbphynop1 {
> > +		compatible =3D "usb-nop-xceiv";
> > +		#phy-cells =3D <0>;
> > +	};
> > +
> >  	soc {
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <1>;
> > @@ -877,6 +882,7 @@
> >  				reg =3D <0x02184400 0x200>;
> >  				interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> >  				clocks =3D <&clks IMX6SX_CLK_USBOH3>;
> > +				fsl,usbphy =3D <&usbphynop1>;
> >  				fsl,usbmisc =3D <&usbmisc 2>;
> >  				phy_type =3D "hsic";
> >  				fsl,anatop =3D <&anatop>;
> > --
> > 2.7.4
> >
