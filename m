Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E1EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39DD2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 09:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rqFThdpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39DD2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeI1PaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:30:21 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:52320
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728451AbeI1PaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pytrm+R0bxzrAgyfvw/vspr2HRwwfT6oM5a67SmJ3/c=;
 b=rqFThdpIzGNZDbQZ6Gos3IhdgPZez01BwPgRiSTrgwyAPGoeQmaZBenCmeZDRFoHqb+ZiwCtQx2GeQUE0oB2uFujygUMq0QWnOcZsvlieRlM8aUj+P+OSbtAiQyZZpG9Rp1pFhGR/eRj36hl+IeLwk2YNC7NvOtVqHnaAlO1dYM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3722.eurprd04.prod.outlook.com (52.134.70.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Fri, 28 Sep 2018 09:07:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071%2]) with mapi id 15.20.1164.024; Fri, 28 Sep 2018
 09:07:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
Thread-Topic: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
Thread-Index: AQHUT99hqKA94jiq2UeCjLqYvoWJiKUFb08AgAAEyxA=
Date:   Fri, 28 Sep 2018 09:07:28 +0000
Message-ID: <DB3PR0402MB3916515873BCC9673AE9E05AF5EC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
 <1537337088-28819-2-git-send-email-Anson.Huang@nxp.com>
 <20180928084452.GH26692@dragon>
In-Reply-To: <20180928084452.GH26692@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3722;6:rvUlIrKg5pCdpE6FyMyYTU6Sth5DV3J29EdLq/cL5+O/MJKhFr4MwlL9N9EcBW1eLuSPHGhUgSHHo+vraBCiSZI2yQHqn5d31O2bGTT8TLh6f8/YhLLgCajUZJqP41THGveJFO/75p7r8pNe0twZHfHWq5iaMwdM5D6PVeo1vug0QNOlIVD7Vc1Ia4MrB1tavFsaJzd1YcOTBKB1j3KsqghVH6bnResyafmIiDiLgTC86AsdCALRqM5YvL+q/6vyEBdA0WCeV5pHvon1uwoIHLON2j9CKHBH2zHvgRsmbccdi2vYV4GxZNe1lqApTUeNYFuayijs43NjA3H15b5ZGwZO9LW+IuC0gqRFWo262lxtM8uy/Dg6XJ3OHoUXLTnr4kQ+03xQBjUVw7uNS9R0k0AjVwKizy3pf9T0ghH+rhQIjmu3ASDnJfXHlASLncejhyqOVEWnFYcJNJJbbc+X1A==;5:8bh3Klm7MzACNmuzkJlIRPMwWjBtr7CcO27daob27HDtotARBokd4J9oI0POoamphe67FDSVBrymA7QcMdJxcBaY+9mKybmoAv7Trykbw4ZVhJ/In4mo6OBeozRIo6Nj2Z3uOMVXJBAvV1kxfoisVtc1KI4nT207b/4nXAgpsQc=;7:VaoqASpvzhXWzFnaamMB0b2pKjBKYKtaL/PAwYXalipah8rfDeGOQ6THpb6vwVtc+bWSnOa5v73iexgGcWKbXY2iMvnx0CkZd68tiyOHE7exH3zkaEb1df7kne2foZt675xblBgvwohaTpYGXJwmdVPuQw/G5pola77LNJXxhRd58u2CSp3vXBtKxYI32cel6Icd0OJQD+0vO3OuXFuJB0i9TD+fernkh/0vspygiglckU0mrkWnG4OcY9SQnttm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b1d22ad3-49d1-432e-6514-08d62521d0bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3722;
x-ms-traffictypediagnostic: DB3PR0402MB3722:
x-microsoft-antispam-prvs: <DB3PR0402MB3722A5248966792F1CE363E1F5EC0@DB3PR0402MB3722.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DB3PR0402MB3722;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3722;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(13464003)(199004)(189003)(97736004)(105586002)(446003)(256004)(14444005)(2900100001)(7416002)(6506007)(53546011)(76176011)(86362001)(2906002)(11346002)(316002)(575784001)(44832011)(5250100002)(34290500001)(106356001)(486006)(476003)(7736002)(5660300001)(53936002)(74316002)(186003)(478600001)(55016002)(26005)(6916009)(81156014)(6246003)(71200400001)(71190400001)(14454004)(33656002)(305945005)(9686003)(102836004)(68736007)(229853002)(6116002)(3846002)(6436002)(66066001)(4326008)(25786009)(8676002)(54906003)(81166006)(7696005)(99286004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3722;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FEHkIZE7SD48KuJQPSZaeOzam5uqNF7DYMQ4rHKsuBbo12llprI74YMBK9ihHn6UxTh5zWnKZgVS4hyeoc/Hhe3PWA3nlGw+fr4/XIPCAZd3Nwzo0zXQGcTVpzPr5hHdoH/Ca7qks3P9qfbZIJMmUGXD7+Ol6Xb2cOuKPDzKgIasFRRqzuWRCm+HhYLxPXh6HMBN6Js0Y4AQzl2C9F0B2sP+qwBsfBKov6z4FRWQuYnmdyKb4vBawpO+LXHhFWL+B9n5VsRq9j5Y7RGQJPsDWM7wdZlD241lJDlS5roxIntUBtV3gAU7y+w14g0pnuRyu8sIkH6mJdVh5n5aKjF2vBXIvuokjTwL7NhFFfVEhJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d22ad3-49d1-432e-6514-08d62521d0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 09:07:28.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Friday, September 28, 2018 4:45 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: robh+dt@kernel.org; mark.rutland@arm.com; s.hauer@pengutronix.de;
> kernel@pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> linux@armlinux.org.uk; mturquette@baylibre.com; sboyd@kernel.org; Jacky
> Bai <ping.bai@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org; dl-linux=
-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
>=20
> On Wed, Sep 19, 2018 at 02:04:45PM +0800, Anson Huang wrote:
> > The i.MX 6ULZ processor is a high-performance, ultra cost-efficient
> > consumer Linux processor featuring an advanced implementation of a
> > single Arm(r) Cortex(r)-A7 core, which operates at speeds up to 900 MHz=
.
> >
> > This patch adds basic MSL support for i.MX6ULZ, the i.MX6ULZ has same
> > soc_id as i.MX6ULL, and SRC_SBMR2 bit[6] is to differentiate i.MX6ULZ
> > from i.MX6ULL, 1'b1 means i.MX6ULZ and 1'b0 means i.MX6ULL.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/mach-imx/anatop.c      | 20 ++++++++++++++++++++
> >  arch/arm/mach-imx/cpu.c         |  3 +++
> >  arch/arm/mach-imx/mach-imx6ul.c |  1 +
> >  arch/arm/mach-imx/mxc.h         |  7 +++++++
> >  arch/arm/mach-imx/pm-imx6.c     |  4 ++--
> >  5 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c
> > index 61f3d94..45d618a 100644
> > --- a/arch/arm/mach-imx/anatop.c
> > +++ b/arch/arm/mach-imx/anatop.c
> > @@ -31,6 +31,8 @@
> >  #define ANADIG_DIGPROG_IMX6SL	0x280
> >  #define ANADIG_DIGPROG_IMX7D	0x800
> >
> > +#define SRC_SBMR2		0x1c
> > +
> >  #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
> >  #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
> >  #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
> > @@ -148,6 +150,24 @@ void __init imx_init_revision_from_anatop(void)
> >  		major_part =3D (digprog >> 8) & 0xf;
> >  		minor_part =3D digprog & 0xf;
> >  		revision =3D ((major_part + 1) << 4) | minor_part;
> > +
> > +		if ((digprog >> 16) =3D=3D MXC_CPU_IMX6ULL) {
> > +			void __iomem *src_base;
> > +			u32 sbmr2;
> > +
> > +			np =3D of_find_compatible_node(NULL, NULL,
> > +						     "fsl,imx6ul-src");
> > +			src_base =3D of_iomap(np, 0);
> > +			WARN_ON(!src_base);
> > +			sbmr2 =3D readl_relaxed(src_base + SRC_SBMR2);
> > +			iounmap(src_base);
> > +
> > +			/* src_sbmr2 bit 6 is to identify if it is i.MX6ULZ */
> > +			if (sbmr2 & (1 << 6)) {
> > +				digprog &=3D ~(0xff << 16);
> > +				digprog |=3D (MXC_CPU_IMX6ULZ << 16);
> > +			}
> > +		}
> >  	}
> >
> >  	mxc_set_cpu_type(digprog >> 16 & 0xff); diff --git
> > a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c index
> > c6b1bf9..c73593e 100644
> > --- a/arch/arm/mach-imx/cpu.c
> > +++ b/arch/arm/mach-imx/cpu.c
> > @@ -136,6 +136,9 @@ struct device * __init imx_soc_device_init(void)
> >  	case MXC_CPU_IMX6ULL:
> >  		soc_id =3D "i.MX6ULL";
> >  		break;
> > +	case MXC_CPU_IMX6ULZ:
> > +		soc_id =3D "i.MX6ULZ";
> > +		break;
> >  	case MXC_CPU_IMX6SLL:
> >  		soc_id =3D "i.MX6SLL";
> >  		break;
> > diff --git a/arch/arm/mach-imx/mach-imx6ul.c
> > b/arch/arm/mach-imx/mach-imx6ul.c index 6cb8a22..4ffe3c8 100644
> > --- a/arch/arm/mach-imx/mach-imx6ul.c
> > +++ b/arch/arm/mach-imx/mach-imx6ul.c
> > @@ -90,6 +90,7 @@ static void __init imx6ul_init_late(void)  static
> > const char * const imx6ul_dt_compat[] __initconst =3D {
> >  	"fsl,imx6ul",
> >  	"fsl,imx6ull",
> > +	"fsl,imx6ulz",
>=20
> Can we have "fsl,imx6ull" on the DT compatible, so that we can save the
> changes on kernel side, like this and the clock driver update (patch #2)?
>=20
>   compatible =3D "fsl,imx6ull", "fsl,imx6ulz";
>=20
> I'm not sure if there is any problem with this approach.  But you can thi=
nk
> about it.
>=20
> Shawn
=20
Using this approach will save the changes in clk-imx6ul.c and mach-imx6ul.c=
,
but other changes will be still needed, since it is defined as a new SoC ot=
her
than a i.MX6ULL with different fuse settings. I can do the changes you sugg=
ested
to save those 2 files changes if you prefer this way, but current implement=
ation
should also make sense if think about it from a new SoC perspective? What d=
o
you prefer?

Thanks.

Anson.

>=20
> >  	NULL,
> >  };
> >
> > diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h index
> > 026e2ca..b130a53 100644
> > --- a/arch/arm/mach-imx/mxc.h
> > +++ b/arch/arm/mach-imx/mxc.h
> > @@ -40,6 +40,8 @@
> >  #define MXC_CPU_IMX6Q		0x63
> >  #define MXC_CPU_IMX6UL		0x64
> >  #define MXC_CPU_IMX6ULL		0x65
> > +/* virtual cpu id for i.mx6ulz */
> > +#define MXC_CPU_IMX6ULZ		0x6b
> >  #define MXC_CPU_IMX6SLL		0x67
> >  #define MXC_CPU_IMX7D		0x72
> >
> > @@ -80,6 +82,11 @@ static inline bool cpu_is_imx6ull(void)
> >  	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6ULL;  }
> >
> > +static inline bool cpu_is_imx6ulz(void) {
> > +	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6ULZ; }
> > +
> >  static inline bool cpu_is_imx6sll(void)  {
> >  	return __mxc_cpu_type =3D=3D MXC_CPU_IMX6SLL; diff --git
> > a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c index
> > 529f4b5..87f45b9 100644
> > --- a/arch/arm/mach-imx/pm-imx6.c
> > +++ b/arch/arm/mach-imx/pm-imx6.c
> > @@ -313,7 +313,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
> >  		if (cpu_is_imx6sl())
> >  			val |=3D BM_CLPCR_BYPASS_PMIC_READY;
> >  		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
> > -		    cpu_is_imx6ull() || cpu_is_imx6sll())
> > +		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
> >  			val |=3D BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
> >  		else
> >  			val |=3D BM_CLPCR_BYP_MMDC_CH1_LPM_HS; @@ -331,7
> +331,7 @@ int
> > imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
> >  		if (cpu_is_imx6sl() || cpu_is_imx6sx())
> >  			val |=3D BM_CLPCR_BYPASS_PMIC_READY;
> >  		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
> > -		    cpu_is_imx6ull() || cpu_is_imx6sll())
> > +		    cpu_is_imx6ull() || cpu_is_imx6sll() || cpu_is_imx6ulz())
> >  			val |=3D BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
> >  		else
> >  			val |=3D BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
> > --
> > 2.7.4
> >
