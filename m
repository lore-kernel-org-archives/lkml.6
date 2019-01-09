Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C152070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xJtXWmLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfAIDx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:53:26 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:60288
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbfAIDx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2mlLPwplS6Za1fttgvaEbXYtx6wdXdDky0ZjcDKjWc=;
 b=xJtXWmLYOO/m4MkJlKjbx+mSgaAW/afYegeyaFEJx9YQHGLL07sELmFShhjaTUPspk846fVnbn1Gdi1Tp6f17ifHBdzkNsPRZkwqM5MMrRgUmWYAxsgzAaBDaZiW+xVF1OS7Q6hbIO5XqqKuDLNuATebNZwDJen0NzQYae15rNA=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2835.eurprd04.prod.outlook.com (10.175.41.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 9 Jan 2019 03:52:39 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 03:52:39 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: RE: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking code
Thread-Topic: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking code
Thread-Index: AQHUpxgE3SCqMwWaSU2qZS5l4UGPMKWljneAgADAQGA=
Date:   Wed, 9 Jan 2019 03:52:39 +0000
Message-ID: <AM5PR0402MB286565A969652495746F5D62F18B0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190108060426.11581-3-ran.wang_1@nxp.com>
 <Pine.LNX.4.44L0.1901081120580.1355-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901081120580.1355-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [223.104.3.158]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2835;6:z8LO7MvW2H72UITVIU+6BeaxL7Dgt7VWrB6PxHBTuoRUU5djJb8nTYrnNP0NZmHF2S38cYb9HBEgS/NmpwPyB/SwevMm6uGldLwtnivnwuaL30OwcbP6A5BSoDv0thACXnT9/kxkovKDnDZ514xN1I4IyxYl1G8IQHlUOa/AJC40/ZwFHJ4R2Oc9Vl2MmhCgnPDZ+pKtaySz8daALOWx48YHrjRaQmj8o7S+T6LbfvY91b6EbbMpSQ+XOO0BlpTENEP52VRlnuV8y0w4p3nI9jlEHTvMaa2Og4EGulsQFSp8Q9mv7PggYgcEuiqNocCgAcbcI4/IVDJZPkzGxG0MaTpuMIyfcuhGAJgCx5by8Vb0USItvSV3TjVgfpLmwIbL+irld79A22wMp5c8GldYVCoAaazYCwfppgs+mc0zZuKyGTWeiUT5Zt0uaQ3PpbowJyowEBZeFZ3g86cJyR1DDg==;5:BF2Jzhx0NACNaVDRy28Dw0DQi+hwGlbjTKOk6MjwI4C9v1Ol1rDRN1blN1gtNu87V5uU1SvAoqGzL2P8DrZRfRmnn7LtRO5Q2HsgBGbyYdHdhFs8WRhiYaS1Kb7+VC09Ld7LRtr4h0pwGBEGKqYnw3PlLJn6Wzm+fT21GmPNhMvueXTSmpoCfx1S3LdhW4lj7cgI1Uko2ZL9g8B00mXKSA==;7:kWMRUX3z7xKx0ETnYdiE810L0zHRYJy7gy0AGrwishklcO/rhmXJbNbijunUA0yVUk+0NSF6iu1ZjfUFRXDdf5lvgea7YpxeD07w1Ygh/DDm64kuggZJ2m4ehf6JwS99IFn9sXIeDNyr61iaw+R8pQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1494711c-a0e8-4734-54f1-08d675e5e657
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2835;
x-ms-traffictypediagnostic: AM5PR0402MB2835:
x-microsoft-antispam-prvs: <AM5PR0402MB2835280B13601D1190AD625BF18B0@AM5PR0402MB2835.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2835;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2835;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(13464003)(189003)(25786009)(9686003)(4326008)(86362001)(2171002)(71190400001)(6246003)(26005)(71200400001)(316002)(14454004)(68736007)(53936002)(81156014)(81166006)(7736002)(97736004)(478600001)(446003)(305945005)(8676002)(54906003)(3846002)(186003)(6116002)(6506007)(11346002)(5660300001)(8936002)(106356001)(476003)(486006)(76176011)(6436002)(66066001)(14444005)(256004)(7696005)(33656002)(53546011)(74316002)(2906002)(105586002)(55016002)(99286004)(102836004)(229853002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2835;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1ZPfBJm6Xj092dfKpcN/VG2OQmVbGXIrKs/AnkJS1ew5Fpzh6FNYWYSeoQXX9lbb0eHW/JlXSmAy5Zx82e933qswek5MVF3b2Ykvk+koldr7CU9zD+p6cJbJ2ktBcRj0aIM4Mfhf7sR/Vm3RUNf9T87l12FI33m4oVGYOieiwTCtYbUG+jv/wBkth6wJGd9pZxnea2dtnj4BMNUpA4OdXpO9A4s9G/Xdju5N21I2pGKoOuw9QcvuMa/QUKbLnSQ8p2cFQgXYRC3CF3Q4cZ7NllI5Rzfi3XinC7AvUeknIOaKhyqK/ZYwIkEiXnqnGr9i
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1494711c-a0e8-4734-54f1-08d675e5e657
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 03:52:39.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Wednesday, January 09, 2019 00:22
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org; Yinbo Zhu
> <yinbo.zhu@nxp.com>
> Subject: Re: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking co=
de
>=20
> On Tue, 8 Jan 2019, Ran Wang wrote:
>=20
> > From: yinbo.zhu <yinbo.zhu@nxp.com>
> >
> > Remove USB errata checking code from driver. Applicability of erratum
> > is retrieved by reading corresponding property in device tree.
> > This property is written during device tree fixup.
> >
> > Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> > Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> > Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/usb/host/ehci-fsl.c      |    7 +------
> >  drivers/usb/host/fsl-mph-dr-of.c |    6 ++++++
> >  include/linux/fsl_devices.h      |    7 ++++---
> >  3 files changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> > index 59ebe1b..2aa408a 100644
> > --- a/drivers/usb/host/ehci-fsl.c
> > +++ b/drivers/usb/host/ehci-fsl.c
> > @@ -304,14 +304,9 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehc=
i)
> >  			return -EINVAL;
> >
> >  	if (pdata->operating_mode =3D=3D FSL_USB2_MPH_HOST) {
> > -		unsigned int chip, rev, svr;
> > -
> > -		svr =3D mfspr(SPRN_SVR);
> > -		chip =3D svr >> 16;
> > -		rev =3D (svr >> 4) & 0xf;
> >
> >  		/* Deal with USB Erratum #14 on MPC834x Rev 1.0 & 1.1
> chips */
> > -		if ((rev =3D=3D 1) && (chip >=3D 0x8050) && (chip <=3D 0x8055))
> > +		if (pdata->has_fsl_erratum_14 =3D=3D 1)
> >  			ehci->has_fsl_port_bug =3D 1;
> >
> >  		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED) diff --
> git
> > a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
> > index 677f9d5..4f8b8a0 100644
> > --- a/drivers/usb/host/fsl-mph-dr-of.c
> > +++ b/drivers/usb/host/fsl-mph-dr-of.c
> > @@ -225,6 +225,12 @@ static int fsl_usb2_mph_dr_of_probe(struct
> platform_device *ofdev)
> >  	pdata->has_fsl_erratum_a005697 =3D
> >  		of_property_read_bool(np, "fsl,usb_erratum-a005697");
> >
> > +	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
> > +		pdata->has_fsl_erratum_14 =3D 1;
> > +	else
> > +		pdata->has_fsl_erratum_14 =3D 0;
> > +
> > +
> >  	/*
> >  	 * Determine whether phy_clk_valid needs to be checked
> >  	 * by reading property in device tree diff --git
> > a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h index
> > 60cef82..7aa51bc 100644
> > --- a/include/linux/fsl_devices.h
> > +++ b/include/linux/fsl_devices.h
> > @@ -98,10 +98,11 @@ struct fsl_usb2_platform_data {
> >
> >  	unsigned	suspended:1;
> >  	unsigned	already_suspended:1;
> > -	unsigned        has_fsl_erratum_a007792:1;
> > -	unsigned        has_fsl_erratum_a005275:1;
> > +	unsigned    has_fsl_erratum_a007792:1;
> > +	unsigned    has_fsl_erratum_14:1;
> > +	unsigned    has_fsl_erratum_a005275:1;
> >  	unsigned	has_fsl_erratum_a005697:1;
> > -	unsigned        check_phy_clk_valid:1;
> > +	unsigned    check_phy_clk_valid:1;
>=20
> You are using spaces here instead of tabs, which alters the alignment.
> Don't do that.

Yes, will fix it in next version.

Regards,
Ran

> Alan Stern
>=20
> >
> >  	/* register save area for suspend/resume */
> >  	u32		pm_command;

