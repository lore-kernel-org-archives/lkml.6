Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCE9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E03206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MzCrrfRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbeLNONI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:13:08 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:18944
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729981AbeLNONI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQAsCdEeWya4efGJdpQW9f7PTeGUNgKDLBpUGoBZ96E=;
 b=MzCrrfRMG54mexpJQM3PuMhGGxs05k6LejSoSEvi8IB1Ce8VxRgMSu5b5E6fsGxkpT/0VfOT0j7jBulbOOVCrviR/PBq8urBIwhQqH74ZxW9FBmJW/bKNEcWLC0wQyVh3Q/OU+QAfClF4S3+FIgXNtvqM6bZ47RZQ8NB8EyHD3M=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3217.eurprd08.prod.outlook.com (52.134.94.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Fri, 14 Dec 2018 14:12:23 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::f1f9:6693:ed35:d489]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::f1f9:6693:ed35:d489%4]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 14:12:23 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "corbet@lwn.net" <corbet@lwn.net>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        nd <nd@arm.com>, "sean@poorly.run" <sean@poorly.run>
Subject: Re: [RFC AFBC 06/12] drm/arm/malidp:- Added support for new YUV
 formats for DP500, DP550 and DP650
Thread-Topic: [RFC AFBC 06/12] drm/arm/malidp:- Added support for new YUV
 formats for DP500, DP550 and DP650
Thread-Index: AQHUivvODNv595J0pU+YPcE059kyEKVuzv+AgA+JGQA=
Date:   Fri, 14 Dec 2018 14:12:23 +0000
Message-ID: <20181214141222.GC19564@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-7-git-send-email-ayan.halder@arm.com>
 <20181204165746.GN988@e110455-lin.cambridge.arm.com>
In-Reply-To: <20181204165746.GN988@e110455-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::29) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3217;6:uaJXo2+KJzDkk53vPNu4Um3OfB4Z362Rjc4Z4ZKA0zi1Zy0Vhr8ZALFfc9RhDLH8c+zrU1tVYGzF4TjcI+12HAjd11dZkmanV9qHV8uDdtUJERL6xh0cHaVu/WvLD4bO5dLgq7eFAFQGRzhyhHNZ2Wpd75hg3QComISYCeXJZijp/j1HovM5ne6j7VjLAYJal+SqFlZ+z0zDZ79FX53m54FAs7tQ8FGNFXSWX+y0+v3f8IR46Y00ZFChHElZjTLkQ7IZD2LaSxos1znDtmz8U2nw7zL8GUl/0F71LuyT4U7n7cyGBaeW/WTvnAaVcL0WQWqpFW5JY2T4uVO03I7rIzh4OJNNKOGjTthKm0fb1WqzemkJoCZjj8wz4VM678MjzBStV+vxaqM2cuaZypcy8hkiPBDq2lT0QlyYXorNHOCZpNzFQ2ETT//kf5CtDEVySzPR8/yxzVD4aYkxmpevGw==;5:lJyXsfEENmm/QsjNnClJrmq5YVmf7yULZIpTizRPYDjznb7V/u5I0ZezmqihP8qI2SSi5FNyYY6lW6vHOWjGB2LP6ySQfs1WDtkteUEyzdYKQoGrdrq28N1V/qrP1iSK9M/fjW2dR3UKOtM8m9RzbtHeazc2/aez81uvPEv/arY=;7:FEo67FiK8CloJzzwRRXpChdgO2TX2pgLJRcJzWuDhY2JWaELuu4hnGlRyqk9L3L/PWafjyLHJzIFXcSKeca46uAAi8iVmtIPU58TDGP61IQV2N5OunNkqQmx7SzzmkG8fddnbqVLpvOHu7CEPBWTAQ==
x-ms-office365-filtering-correlation-id: f88e2af3-38e0-4c1c-6652-08d661ce2ad2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3217;
x-ms-traffictypediagnostic: AM0PR08MB3217:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3217E979E904C02CA2C58AA8E4A10@AM0PR08MB3217.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3217;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(189003)(71200400001)(6116002)(6246003)(6486002)(71190400001)(66066001)(68736007)(446003)(105586002)(478600001)(229853002)(53936002)(4326008)(76176011)(6862004)(81156014)(6436002)(476003)(97736004)(8676002)(2616005)(6636002)(256004)(11346002)(25786009)(33656002)(72206003)(486006)(14444005)(7736002)(217873002)(14454004)(8936002)(81166006)(2906002)(316002)(54906003)(36756003)(575784001)(44832011)(966005)(86362001)(6512007)(6306002)(106356001)(99286004)(7416002)(26005)(186003)(5660300001)(386003)(6506007)(305945005)(37006003)(1076002)(52116002)(102836004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3217;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iQS+TTEk5E9Wnc4YrwUY+XsFAX4WZatBxjn5QORN4pkzjyAKv0QHJKJ4cZxnd/xnpTaFhWGTHvH5jNWl+FHBTVhiXmN8QtKlkqB5gK2x0FQ+EcraUUS3UkG84sCVbYdsqEwCaUWUmCWFvnWmT0ZoTVuDKFgh24mD4W4Cr1LYftyBVZ+xZekWKn1XGAqPZMuEhEoNZTaoheITDlS75hU0+0NFJ9lMjxBKV+u/oTb9a8VD63kW6IjwbQAVsDImQvR23nr3Ju03xrs+FAEFQLW7mUdEMKbP+v6vR1x/+6HMlWYtAbh9AhDlCf+wKu7+3pfE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38B393AF784A9848BC01696DFDB772F3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88e2af3-38e0-4c1c-6652-08d661ce2ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 14:12:23.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:57:46PM +0000, Liviu Dudau wrote:

Hi Liviu,
> On Mon, Dec 03, 2018 at 11:32:00AM +0000, Ayan Halder wrote:
> > We have added some new formats to be supported on DP500/DP550/DP650.
>=20
> Make a bit more descriptive commit message here, please!
>
I will keep the following commit message :-

""We have added support for some AFBC only pixel formats like :-
DRM_FORMAT_YUV420_8BIT (single plane YUV 420 8 bit format)
DRM_FORMAT_VUY888 (single plane YUV 444 8 bit format)
DRM_FORMAT_VUY101010 (single plane YUV 444 10 bit format)
DRM_FORMAT_YUV420_10BIT (single plane YUV 420 10 bit format)

Generally, these formats are supported by our hardware using the same hw-id=
s as
the equivalent multi plane pixel formats.

Also we have added support for XYUV 444 8 and 10 bit formats.""

Let me know if this looks fine.

Thanks,
Ayan Kumar halder
> >=20
> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> >=20
> > Depends on :- https://patchwork.kernel.org/patch/10460063/
>=20
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>=20
> Best regards,
> Liviu
>=20
> > ---
> >  drivers/gpu/drm/arm/malidp_hw.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/mali=
dp_hw.c
> > index 55d379b..25ac5890 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > @@ -49,6 +49,12 @@ static const struct malidp_format_id malidp500_de_fo=
rmats[] =3D {
> >  	{ DRM_FORMAT_YUYV, DE_VIDEO1, 13 },
> >  	{ DRM_FORMAT_NV12, DE_VIDEO1 | SE_MEMWRITE, 14 },
> >  	{ DRM_FORMAT_YUV420, DE_VIDEO1, 15 },
> > +	{ DRM_FORMAT_XYUV8888, DE_VIDEO1, 16 },
> > +	/* These are supported with AFBC only */
> > +	{ DRM_FORMAT_YUV420_8BIT, DE_VIDEO1, 14 },
> > +	{ DRM_FORMAT_VUY888, DE_VIDEO1, 16 },
> > +	{ DRM_FORMAT_VUY101010, DE_VIDEO1, 17 },
> > +	{ DRM_FORMAT_YUV420_10BIT, DE_VIDEO1, 18 }
> >  };
> > =20
> >  #define MALIDP_ID(__group, __format) \
> > @@ -74,11 +80,25 @@ static const struct malidp_format_id malidp500_de_f=
ormats[] =3D {
> >  	{ DRM_FORMAT_ABGR1555, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_I=
D(4, 1) }, \
> >  	{ DRM_FORMAT_RGB565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(=
4, 2) }, \
> >  	{ DRM_FORMAT_BGR565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(=
4, 3) }, \
> > +	/* This is only supported with linear modifier */	\
> > +	{ DRM_FORMAT_XYUV8888, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 0) },\
> > +	/* This is only supported with AFBC modifier */		\
> > +	{ DRM_FORMAT_VUY888, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 0) }, \
> >  	{ DRM_FORMAT_YUYV, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 2) },	\
> > +	/* This is only supported with linear modifier */ \
> >  	{ DRM_FORMAT_UYVY, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 3) },	\
> >  	{ DRM_FORMAT_NV12, DE_VIDEO1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(5, =
6) },	\
> > +	/* This is only supported with AFBC modifier */ \
> > +	{ DRM_FORMAT_YUV420_8BIT, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 6) }, \
> >  	{ DRM_FORMAT_YUV420, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 7) }, \
> > -	{ DRM_FORMAT_X0L2, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 6)}
> > +	/* This is only supported with linear modifier */ \
> > +	{ DRM_FORMAT_XVYU2101010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 0)}, \
> > +	/* This is only supported with AFBC modifier */ \
> > +	{ DRM_FORMAT_VUY101010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 0)}, \
> > +	{ DRM_FORMAT_X0L2, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 6)}, \
> > +	/* This is only supported with AFBC modifier */ \
> > +	{ DRM_FORMAT_YUV420_10BIT, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 7)}, \
> > +	{ DRM_FORMAT_P010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 7)}
> > =20
> >  static const struct malidp_format_id malidp550_de_formats[] =3D {
> >  	MALIDP_COMMON_FORMATS,
> > --=20
> > 2.7.4
> >=20
>=20
> --=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ??\_(???)_/??
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
