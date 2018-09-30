Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20338C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C237D20685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RneI+949"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C237D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeI3JjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:39:19 -0400
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:35488
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727609AbeI3JjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUcfYtdT04DLBpnukqW8fHvdefMCvyOGKF7OKDCZeFw=;
 b=RneI+949FbwvAv20IarDW4GIGKy6eQPX6l1bOxLpoKDlcTvrHPLSBVoDYmnkAT+GsCbhpAlJPaUueQeykdTjTzn4TJFzzn0G3Krp1sKX1tKaljLMQwO5JS94QYAMFrqo1m38WY4J77Y/Od6g4wgbZiBReFWzmFAxYofpEjElFrM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Sun, 30 Sep 2018 03:08:05 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071%2]) with mapi id 15.20.1164.029; Sun, 30 Sep 2018
 03:08:05 +0000
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
Thread-Index: AQHUT99hqKA94jiq2UeCjLqYvoWJiKUFb08AgAAEyxCAAsE+gIAAAEhA
Date:   Sun, 30 Sep 2018 03:08:05 +0000
Message-ID: <DB3PR0402MB3916A3EAD0AB84103EBE1020F5EE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
 <1537337088-28819-2-git-send-email-Anson.Huang@nxp.com>
 <20180928084452.GH26692@dragon>
 <DB3PR0402MB3916515873BCC9673AE9E05AF5EC0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20180930030611.GJ26692@dragon>
In-Reply-To: <20180930030611.GJ26692@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3674;6:cZ1Yj2xWPMPX6rjgy+cLRP+LANTmh0Y/KJ2eyokoCjrTJZuEo9psjT1bntwqM8kWZtF6rkX15lRFvmj6ojw5LVSzHLMcA0KeuV5DhJbQgaxDJ3u+N+6YNpM7vZnImf09DW9qoKtM/ICe03OV5wabkxE6gtZaxLbyFG+zd2+wwSpIszcB86keFzyfOsKHmbauCz1V0NNx5cvmdB94P6iGfkrbF7+1DsV+6Yo3oatFCHyBgvNpcQnjloqzydc7FycsaD8+19JblWvPZqryosklkEcRGEEsEWAE/0Yp2snpCEaazdLtbXv0l0xtO0sZfE62hQAhPL6ks9bfuYEoo6Vcu4Z7jSvrRLQD/0uKgmxoGKoD7HBtLpUUWDLoWDKmmhUtyr9IHmaxRilmGUCNCql+5uIBS+BIjo40H/O6BEkiGikPJ+lpKAFv5aj9ne4KrqzYoDHAosCRTvNnJK9cWRPElg==;5:q077sNfppBrxO3L+bWrxb4CkDOMgTV2+Wqkp4UnHu9C7WvgNHv6JFafLZCJ4JvA3xS0LvaKc7FE7OXe/jYT/Rc26cnAqnlGLw9USs+zUFZep8rd6mHxjypa+1g85o83X5JhlqcDbC0rNlpD0LH1mKLZ71Z2CblYiFMJoai13ajA=;7:LQ8+MhKrPhQil+mboQTMFPPmvZDclbqnTIulNeupjkaj5/C/3HwyKu/NaveTAzoPfnq2z7Ubj7joAozEHBXVWbBFgTxD3qcI6Wco/UqxLJUJ6J03z1dvnVj56ge+5lJpGTdAsbBzyDjZVcOtoR3ieghf8IFW921sd31QELoK9VJIyGlOXj+wFKSPNdJ/dqVECrRgyjkTTV9VJD7LyhWUaAzRCvFo1agaBc2z2ma3fx88GfxhkINmKYbAS7/vnNqM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5e63c4b4-11f1-4ca9-a674-08d62681f0d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-microsoft-antispam-prvs: <DB3PR0402MB367488276CADC4617D85586FF5EE0@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:DB3PR0402MB3674;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3674;
x-forefront-prvs: 08118EFC2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(13464003)(81166006)(81156014)(316002)(186003)(8676002)(86362001)(4326008)(97736004)(6436002)(575784001)(55016002)(44832011)(14454004)(9686003)(26005)(3846002)(6116002)(229853002)(106356001)(74316002)(105586002)(34290500001)(7416002)(6916009)(68736007)(305945005)(7736002)(93886005)(71190400001)(2900100001)(71200400001)(54906003)(11346002)(256004)(14444005)(102836004)(5250100002)(446003)(8936002)(99286004)(7696005)(66066001)(76176011)(6246003)(25786009)(5660300001)(2906002)(53546011)(478600001)(6506007)(486006)(33656002)(53936002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Gker5C39oZYWMxIzY2Tpf656S9q6uviB9lqeywt3AXXdURuCckcZK08CuEiL54TCBy9ZUu0nUjiXU9QMKs201flr1aJXS5Ioasf9LLT6qu7FOla4f+DSfd7bX9UiTtUi131U+dgI7QuoZ+1pHptBVXcQMrit67UsppCAkaazZWIBXaIVX5sq70YtcyrNbl9MGuUev98skzJrjtKWtlH0E4y0HUdwh8XT6mEsgGC5jNtwg2wz3Sx1gIMbeG0BNCyUdZSuRG13sP/RJB/1h6UsA1DEaGXFk/wDYV4VXoBb0dULCcE3lcW4ccd5MWj/XeCEWVDCRTfxzOCEunqEWd0k7Z1mIBkKd5+noec14dRsVbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e63c4b4-11f1-4ca9-a674-08d62681f0d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2018 03:08:05.1686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Sunday, September 30, 2018 11:06 AM
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
> On Fri, Sep 28, 2018 at 09:07:28AM +0000, Anson Huang wrote:
> > Hi, Shawn
> >
> > Anson Huang
> > Best Regards!
> >
> >
> > > -----Original Message-----
> > > From: Shawn Guo <shawnguo@kernel.org>
> > > Sent: Friday, September 28, 2018 4:45 PM
> > > To: Anson Huang <anson.huang@nxp.com>
> > > Cc: robh+dt@kernel.org; mark.rutland@arm.com;
> > > s.hauer@pengutronix.de; kernel@pengutronix.de; Fabio Estevam
> > > <fabio.estevam@nxp.com>; linux@armlinux.org.uk;
> > > mturquette@baylibre.com; sboyd@kernel.org; Jacky Bai
> > > <ping.bai@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org;
> > > dl-linux-imx <linux-imx@nxp.com>
> > > Subject: Re: [PATCH V2 1/4] ARM: imx: add i.mx6ulz msl support
> > >
> > > On Wed, Sep 19, 2018 at 02:04:45PM +0800, Anson Huang wrote:
> > > > The i.MX 6ULZ processor is a high-performance, ultra
> > > > cost-efficient consumer Linux processor featuring an advanced
> > > > implementation of a single Arm(r) Cortex(r)-A7 core, which operates=
 at
> speeds up to 900 MHz.
> > > >
> > > > This patch adds basic MSL support for i.MX6ULZ, the i.MX6ULZ has
> > > > same soc_id as i.MX6ULL, and SRC_SBMR2 bit[6] is to differentiate
> > > > i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and 1'b0 means
> i.MX6ULL.
> > > >
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > ---
> > > >  arch/arm/mach-imx/anatop.c      | 20 ++++++++++++++++++++
> > > >  arch/arm/mach-imx/cpu.c         |  3 +++
> > > >  arch/arm/mach-imx/mach-imx6ul.c |  1 +
> > > >  arch/arm/mach-imx/mxc.h         |  7 +++++++
> > > >  arch/arm/mach-imx/pm-imx6.c     |  4 ++--
> > > >  5 files changed, 33 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-imx/anatop.c
> > > > b/arch/arm/mach-imx/anatop.c index 61f3d94..45d618a 100644
> > > > --- a/arch/arm/mach-imx/anatop.c
> > > > +++ b/arch/arm/mach-imx/anatop.c
> > > > @@ -31,6 +31,8 @@
> > > >  #define ANADIG_DIGPROG_IMX6SL	0x280
> > > >  #define ANADIG_DIGPROG_IMX7D	0x800
> > > >
> > > > +#define SRC_SBMR2		0x1c
> > > > +
> > > >  #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
> > > >  #define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
> > > >  #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
> > > > @@ -148,6 +150,24 @@ void __init imx_init_revision_from_anatop(void=
)
> > > >  		major_part =3D (digprog >> 8) & 0xf;
> > > >  		minor_part =3D digprog & 0xf;
> > > >  		revision =3D ((major_part + 1) << 4) | minor_part;
> > > > +
> > > > +		if ((digprog >> 16) =3D=3D MXC_CPU_IMX6ULL) {
> > > > +			void __iomem *src_base;
> > > > +			u32 sbmr2;
> > > > +
> > > > +			np =3D of_find_compatible_node(NULL, NULL,
> > > > +						     "fsl,imx6ul-src");
> > > > +			src_base =3D of_iomap(np, 0);
> > > > +			WARN_ON(!src_base);
> > > > +			sbmr2 =3D readl_relaxed(src_base + SRC_SBMR2);
> > > > +			iounmap(src_base);
> > > > +
> > > > +			/* src_sbmr2 bit 6 is to identify if it is i.MX6ULZ */
> > > > +			if (sbmr2 & (1 << 6)) {
> > > > +				digprog &=3D ~(0xff << 16);
> > > > +				digprog |=3D (MXC_CPU_IMX6ULZ << 16);
> > > > +			}
> > > > +		}
> > > >  	}
> > > >
> > > >  	mxc_set_cpu_type(digprog >> 16 & 0xff); diff --git
> > > > a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c index
> > > > c6b1bf9..c73593e 100644
> > > > --- a/arch/arm/mach-imx/cpu.c
> > > > +++ b/arch/arm/mach-imx/cpu.c
> > > > @@ -136,6 +136,9 @@ struct device * __init imx_soc_device_init(void=
)
> > > >  	case MXC_CPU_IMX6ULL:
> > > >  		soc_id =3D "i.MX6ULL";
> > > >  		break;
> > > > +	case MXC_CPU_IMX6ULZ:
> > > > +		soc_id =3D "i.MX6ULZ";
> > > > +		break;
> > > >  	case MXC_CPU_IMX6SLL:
> > > >  		soc_id =3D "i.MX6SLL";
> > > >  		break;
> > > > diff --git a/arch/arm/mach-imx/mach-imx6ul.c
> > > > b/arch/arm/mach-imx/mach-imx6ul.c index 6cb8a22..4ffe3c8 100644
> > > > --- a/arch/arm/mach-imx/mach-imx6ul.c
> > > > +++ b/arch/arm/mach-imx/mach-imx6ul.c
> > > > @@ -90,6 +90,7 @@ static void __init imx6ul_init_late(void)
> > > > static const char * const imx6ul_dt_compat[] __initconst =3D {
> > > >  	"fsl,imx6ul",
> > > >  	"fsl,imx6ull",
> > > > +	"fsl,imx6ulz",
> > >
> > > Can we have "fsl,imx6ull" on the DT compatible, so that we can save
> > > the changes on kernel side, like this and the clock driver update (pa=
tch #2)?
> > >
> > >   compatible =3D "fsl,imx6ull", "fsl,imx6ulz";
> > >
> > > I'm not sure if there is any problem with this approach.  But you
> > > can think about it.
> > >
> > > Shawn
> >
> > Using this approach will save the changes in clk-imx6ul.c and
> > mach-imx6ul.c, but other changes will be still needed, since it is
> > defined as a new SoC other than a i.MX6ULL with different fuse
> > settings. I can do the changes you suggested to save those 2 files
> > changes if you prefer this way, but current implementation should also
> > make sense if think about it from a new SoC perspective? What do you
> prefer?
>=20
> I agree this is a different SoC, and other changes are reasonable.  I wou=
ld just
> like to save some changes on kernel side with the help from device tree.
>=20
> Shawn
=20
OK, I will do changes to save those code on kernel and send out a V3 patch,=
 thanks.

Anson.


