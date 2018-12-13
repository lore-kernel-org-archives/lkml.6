Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F5EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E35B2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H9gkCVBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E35B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeLMOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:51:56 -0500
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:10144
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbeLMOvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3bpidpfm1GPgwoA8rWevjOY0c/bVh44u5vYh0PGlAc=;
 b=H9gkCVBuuWYTltanmE0CZ18JTmeQdsmN07FGULNLTiZdjEGA+r+dtlWQEqAlogn4D25pgxsLqrglD9sE6lV6SUMSaTBnDZxi2rMCmOcJVJd+zp4LwpXtOGwlG4q8EpJq66CisFbENMiWLss5CJxZwYFZZAd9DMThH7rIR85KVCs=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3899.eurprd04.prod.outlook.com (52.134.71.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 14:51:51 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 14:51:51 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
CC:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
Thread-Topic: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
Thread-Index: AQHUkuY6nb3Z7jYWIkKip6q0zf3chKV8vGGAgAAEk4A=
Date:   Thu, 13 Dec 2018 14:51:50 +0000
Message-ID: <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
 <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
 <1544711727.3137.32.camel@pengutronix.de>
In-Reply-To: <1544711727.3137.32.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3899;6:IiU0jFYv/9p74PNskFYABTnBetsixAE/01AhI5qV3BpyEV/30xYEaZWB4RKpbxyAK7WNOm9AMEwv+GmCDR7iasZ5eVqPSezKR4Tnl3bAEskNqHyaMogKtj5oy8lnwKMfAe4NjXBqVKSyb4lfX65Nv71xFqQfLuGrUVLIMTLR0tnkWIu1MGbZnzQBcz820K2ajn642tJLmSNDZrDrp1/zd1Kzf6jzS6cqiTKx+6ao9zPQsCkByBCNkYsTnyJxczN53nVaiqleq7hstEGMYPRCzMJFzWtQpFHrMm2ryJd8qhs2tx01jQS+k1V7ZaZzPW8ba6N1nsSEnLAxsFWZa1/plM9gi0FjS0DDGE1lyuDN1fd7Wz4UgVyEQRmWX0G19ZjIzCvjAsfrQh8hyonbv3Kfn/Gya5l2Y0Lwti/iaQYo2nP/fyy7ah9GgG4xKgWrMupAEufCmwrVvmf8jfB9BepLhA==;5:nU3PZnaQT9Cxkr/dFOwsEsq/ufswQ0c4kjGaM/rrbV53vV2+08LAk2hZeZP7TQ8p+gzIBzq3X3iDhr7dXs7h91J56dVOusx6XdYAt9aHoES63u1GitbWKlTm9MswYICasYvJ1yVt3eQ1xXNtKaEP7CpsK+TFWJCTkpQNONXW4vE=;7:LOXKkNyeP2siLCZBcnIrKMBsdAy9KDDfjXmXG9//utJ38OF6BqpSfYwH2FdwppKmFWBYbGWO3S4ZRk9kRb6yoy3AhPc/nwSBdcRjhygTURkCVb/31j63+AUCnbq9pSPCs5YVMSnqXHmfKL/QnXmpnA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7b53fc92-94c6-468a-c5b9-08d6610a83f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3899;
x-ms-traffictypediagnostic: DB3PR0402MB3899:
x-microsoft-antispam-prvs: <DB3PR0402MB3899FA70EA1078005A0B1C8FF6A00@DB3PR0402MB3899.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3899;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3899;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(7736002)(478600001)(305945005)(229853002)(6436002)(25786009)(6486002)(256004)(1076002)(53546011)(3846002)(6116002)(6506007)(26005)(71190400001)(97736004)(102836004)(68736007)(5660300001)(71200400001)(6916009)(186003)(66066001)(76176011)(54906003)(7416002)(2906002)(33896004)(105586002)(575784001)(99286004)(6512007)(106356001)(14454004)(81166006)(486006)(8936002)(81156014)(446003)(316002)(476003)(8676002)(11346002)(4326008)(9686003)(44832011)(6246003)(33716001)(53936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3899;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LAsq0eIOcJHfU9ft6pbK3JklOsDZqa+Kcl8HKh4akxkYZuVC1m7LW0w+O1zeLOwxTzFFtXwkh0Q6HOIXx3kXoRi1sbCMS9Hunkj15N6aSCIGdVy7fziCBhqmLWxmOGs3ipLDlSYMPgP6M9a8byoAGKQPrqRjIbvwYobpFPIpK9ry/sM1XQr79f5bQ/dxvTzkLFHkRqcGr3/wLqEpaKeAY9PjSDPpjWzIGc6qQTCvvCcdzRGFIfp3w25bvWEWm4sYTKd1yAlFfz3nF8iysx18v1tpzejnKUVUTYezmPFffLZ//mTN6RbrepPoCikM3xqV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <082F7D1FEA76734388BB953E3B4BA78D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b53fc92-94c6-468a-c5b9-08d6610a83f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 14:51:50.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-12-13 15:35:27, Lucas Stach wrote:
> Am Donnerstag, den 13.12.2018, 13:17 +0000 schrieb Abel Vesa:
> > To keep aligned with arm64, remove the unnecessary SOC_IMX8MQ and use
> > ARCH_MXC instead.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> > =A0arch/arm64/Kconfig.platforms=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 8 ---=
-----
> > =A0arch/arm64/boot/dts/freescale/Makefile | 2 +-
> > =A0drivers/clk/imx/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0| 3 ++-
> > =A0drivers/phy/freescale/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 2 +-
> > =A0drivers/pinctrl/freescale/Kconfig=A0=A0=A0=A0=A0=A0| 2 +-
> > =A0drivers/soc/imx/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0| 2 +-
> > =A06 files changed, 6 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/arch/arm64/Kconfig.platforms
> > b/arch/arm64/Kconfig.platforms
> > index 7e1545a..318dbb9 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -148,14 +148,6 @@ config ARCH_MXC
> > =A0	=A0=A0This enables support for the ARMv8 based SoCs in the
> > =A0	=A0=A0NXP i.MX family.
> > =A0
> > -config SOC_IMX8MQ
> > -	bool "i.MX8MQ support"
> > -	depends on ARCH_MXC
> > -	select ARM64_ERRATUM_843419
> > -	select ARM64_ERRATUM_845719
> > -	help
> > -	=A0=A0This enables support for the i.MX8MQ SoC.
> > -
>=20
> NACK on this one. Having a single place where stuff that is absolutely
> critical for proper SoC operation can be selected is very useful and
> avoids hard to debug issues due to slightly wrong configs in the long
> run.

As mentioned in the cover letter, please ignore this patch set entirely.
The ARCH_MXC is actually used on arm32 too, so it won't work.

I'm working on a patchset that will add the Kconfig into=20
drivers/clk/imx/ and in it will add CLK_IMX8MQ. That will
fix the clock dependency since the CLK_IMX8MQ will depend on
ARCH_MXC and ARM64. I believe the CLK_IMX8QXP will follow
the same pattern.

As for the SOC_IMX8MQ, all the other vendors have one single
config for all the arm64 platforms. TBH, to control every SoC
independently it's a little bit of an overkill.

But maybe I'm the only one who thinks so.

>=20
> Regards,
> Lucas
>=20
> > =A0config ARCH_QCOM
> > =A0	bool "Qualcomm Platforms"
> > =A0	select GPIOLIB
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index 0001361..f9be242 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -19,4 +19,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-
> > rdb.dtb
> > =A0dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-qds.dtb
> > =A0dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
> > =A0
> > -dtb-$(CONFIG_SOC_IMX8MQ) +=3D imx8mq-evk.dtb
> > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-evk.dtb
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > index 5c0b11e..62a1882 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
> > =A0obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
> > =A0obj-$(CONFIG_SOC_IMX7D)=A0=A0+=3D clk-imx7d.o
> > =A0obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
> > -obj-$(CONFIG_SOC_IMX8MQ) +=3D clk-imx8mq.o
> > =A0obj-$(CONFIG_SOC_VF610)=A0=A0+=3D clk-vf610.o
> > +
> > +obj-$(CONFIG_ARCH_MXC) +=3D clk-imx8mq.o
> > diff --git a/drivers/phy/freescale/Kconfig
> > b/drivers/phy/freescale/Kconfig
> > index f050bd4..923c0ef 100644
> > --- a/drivers/phy/freescale/Kconfig
> > +++ b/drivers/phy/freescale/Kconfig
> > @@ -2,4 +2,4 @@ config PHY_FSL_IMX8MQ_USB
> > =A0	tristate "Freescale i.MX8M USB3 PHY"
> > =A0	depends on OF && HAS_IOMEM
> > =A0	select GENERIC_PHY
> > -	default SOC_IMX8MQ
> > +	default ARCH_MXC
> > diff --git a/drivers/pinctrl/freescale/Kconfig
> > b/drivers/pinctrl/freescale/Kconfig
> > index 2d6db43..9874a16 100644
> > --- a/drivers/pinctrl/freescale/Kconfig
> > +++ b/drivers/pinctrl/freescale/Kconfig
> > @@ -123,7 +123,7 @@ config PINCTRL_IMX7ULP
> > =A0
> > =A0config PINCTRL_IMX8MQ
> > =A0	bool "IMX8MQ pinctrl driver"
> > -	depends on SOC_IMX8MQ
> > +	depends on ARCH_MXC
> > =A0	select PINCTRL_IMX
> > =A0	help
> > =A0	=A0=A0Say Y here to enable the imx8mq pinctrl driver
> > diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> > index 2112d18..7ffbb6b 100644
> > --- a/drivers/soc/imx/Kconfig
> > +++ b/drivers/soc/imx/Kconfig
> > @@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
> > =A0
> > =A0config IMX_GPCV2_PM_DOMAINS
> > =A0	bool "i.MX GPCv2 PM domains"
> > -	depends on SOC_IMX7D || SOC_IMX8MQ || (COMPILE_TEST && OF)
> > +	depends on SOC_IMX7D || ARCH_MXC || (COMPILE_TEST && OF)
> > =A0	depends on PM
> > =A0	select PM_GENERIC_DOMAINS
> > =A0	default y if SOC_IMX7D=
