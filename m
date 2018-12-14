Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83564C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B64C20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="O57vI2FL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeLNOXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:23:12 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:46048
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730106AbeLNOXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNPaCLjuqwWfvJ3NzVlYH67P2wEyLhDLF2D0/YPX14I=;
 b=O57vI2FLQO9InGGCPe2h6i/PF5yHOHffDbBL3bxJoqqBHR3WZL4dvbkK3C6BA4ug51M55bAXi/xTSigOA+dtwZUfCA9Hpo+wPjIwTv1zs2fP4ojgQL8NuIitGC+krA3cJRrR6J3AZgo4dRcFZdOn7eoWkcDVIuq6+hLr+jU4kXs=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3619.eurprd08.prod.outlook.com (20.177.111.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 14:23:00 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::f1f9:6693:ed35:d489]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::f1f9:6693:ed35:d489%4]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 14:23:00 +0000
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
Subject: Re: [RFC AFBC 07/12] drm/arm/malidp: Define the constraints on each
 supported drm_fourcc format for the AFBC modifiers.
Thread-Topic: [RFC AFBC 07/12] drm/arm/malidp: Define the constraints on each
 supported drm_fourcc format for the AFBC modifiers.
Thread-Index: AQHUivvOJrCqCbxuBEiiM4l9ViXVPKVu3V6AgA99sYA=
Date:   Fri, 14 Dec 2018 14:23:00 +0000
Message-ID: <20181214142259.GD19564@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-8-git-send-email-ayan.halder@arm.com>
 <20181204174912.GO988@e110455-lin.cambridge.arm.com>
In-Reply-To: <20181204174912.GO988@e110455-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0314.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::14) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3619;6:8c5pF8jWPK3QSYJvWGsQ6JtFEaDtcwrNaOhcxwWIjV1i0Ry5dz0mOHafxfOkCYR5ydkvyXB9W+lc8VghwrJCqg+bMoMPuZZLtJoCY0azF9+6HHszgagJYFj8F/DUTcrNw3+o7DPVJUOqBYCAc/IKAbyMJz0yllU2oeWTJUoWUUp0e1A9a6x9nrarGyX4dlA/BSYtj+yzH7xsO3ngWqOWPRZJA2G32LYGAwqhSOfkG67WD1WEo7BpwloC0b0a6nC+SceN29aEJYbDbVdhptC+6a1JChAlYQQTgy1cVgmGUmcs+Tu017XPwKPUl2vIixeQKopqlwHB/Opj79+Hy+X+ZeoF+XcDbjyQWEYwxXD1eQpeAOT7fNnyBODht5kT21KDx0RCrUtsz4BnzmqXKvFpRum7J3i0TrIOVRZ0Tsgmq1OaFHOgf/AlHjCCEsJzNFhk0jbFAtLmXi2bSV7P/iwtmw==;5:cuWW4SQf/5weOO74tmKatKc2Cip3ndzhNvtlKbBkf/GxDEMG2bbgU8U/lZe4ozEqN86PAHKyDK075RCmqwaiU+57N36jn1z+vOX0ABNFq0lKmf95awSGOBn3gs87ztsC81QO3g6Whs6jL1ypGt92FCy+PQCuklImh2UUGAHc09I=;7:Rrm4LN/w2FiowPFLquToGdag2JD5uaik0Bg7DuR0gpmqNS6+oSXAd3sPJBwPZ5dtem/XqiaOR957PJivM5oft7427Tyvao0IBHZbw6uZ7Sm0Ad32MXN5ScyhadlDspCVE8vKSeZvsh8aseLpuV6EZw==
x-ms-office365-filtering-correlation-id: 401dc92a-af63-42d6-245f-08d661cfa6a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3619;
x-ms-traffictypediagnostic: AM0PR08MB3619:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB36191DFF6EEBC4BA7F6978EDE4A10@AM0PR08MB3619.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3619;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3619;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39850400004)(346002)(136003)(189003)(199004)(486006)(217873002)(478600001)(11346002)(14444005)(256004)(6306002)(6512007)(86362001)(575784001)(33656002)(476003)(68736007)(2616005)(105586002)(97736004)(6486002)(36756003)(386003)(44832011)(52116002)(6506007)(76176011)(446003)(106356001)(102836004)(7736002)(26005)(99286004)(66066001)(71200400001)(71190400001)(3846002)(6116002)(7416002)(54906003)(37006003)(5660300001)(186003)(8676002)(305945005)(1076002)(81166006)(25786009)(316002)(53936002)(6246003)(2906002)(81156014)(8936002)(6636002)(6436002)(53946003)(4326008)(6862004)(4744004)(229853002)(72206003)(14454004)(966005)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3619;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q4q1IFOjXwzLo8blWLqZBEK7j06BsAgmlyjduTTd6gyzTKqQ4B25pTNgcigP1MQDPlz8MvjEhj0Ax+7vg4wBJ7ceitPqoowsUHU2LBZH/bzXpdrQOdi1JGDlZxly9UYG84p5NpCc6lBQzPGtZTtEqxHD8lQwrlyrLCuBYoBt27GR6uOsYLuVmkjpvAjMifaC+J3XTnkIE1IY4ptbJ1107cNlKL6JAaWw4CoZrria9oP1qd++Z5mFu8kL71oxQLRv+t7EiOl5DnGJW1e7X7ZT5Jjoe2xXZ8iqWbLEq9pK+OwRzVAehMiDh7Zmg81Nr0A2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A485C71CB4BB546B626E56FE0E04B02@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401dc92a-af63-42d6-245f-08d661cfa6a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 14:23:00.3550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:49:12PM +0000, Liviu Dudau wrote:
> On Mon, Dec 03, 2018 at 11:32:01AM +0000, Ayan Halder wrote:
> > The constraints are as follows (for Mali-DP 500, 550, 650) :-
> >=20
> > 1. AFBC is not supported for the formats defined in malidp_hw_format_is=
_linear_only()
> >=20
> > 2. Some of the formats are supported only with AFBC modifiers. Thus we =
have
> > introduced a new function 'malidp_hw_format_is_afbc_only()' which verif=
ies the same.
> >=20
> > 3. AFBC_FORMAT_MOD_YTR needs to be provided for any RGB format.
> >=20
> > 4. Formats <=3D 16bpp cannot support AFBC_FORMAT_MOD_SPLIT.
> >=20
> > 5. CBR should not be set for non-subsampled formats.
> >=20
> > 6. SMART layer does not support framebuffer with AFBC modifiers.
> > Return -EINVAL for such a scenario.
> >=20
> > 7. AFBC_FORMAT_MOD_YTR is not supported for any YUV formats.
> >=20
> > 8. Formats which are subsampled cannot support AFBC_FORMAT_MOD_SPLIT. H=
owever in
> > DP550, YUV_420_10BIT is supported with AFBC_FORMAT_MOD_SPLIT. This feat=
ure has
> > been identified with MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT.
> >=20
> > 9. In DP550 and DP650, for YUYV, the hardware supports different format=
-ids to
> > be used with and without AFBC modifier. We have used the feature
> > 'MALIDP_DEVICE_AFBC_YUYV_USE_422_P2' to identify this characteristic.
> >=20
> > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > ---
> >  drivers/gpu/drm/arm/malidp_drv.c    |  23 +------
> >  drivers/gpu/drm/arm/malidp_drv.h    |   6 ++
> >  drivers/gpu/drm/arm/malidp_hw.c     |  71 +++++++++++++++++++--
> >  drivers/gpu/drm/arm/malidp_hw.h     |   5 +-
> >  drivers/gpu/drm/arm/malidp_mw.c     |   2 +-
> >  drivers/gpu/drm/arm/malidp_planes.c | 124 ++++++++++++++++++++++++++++=
+++++++-
> >  6 files changed, 199 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/mal=
idp_drv.c
> > index b8db92f..2f0b553 100644
> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > @@ -264,29 +264,8 @@ static bool
> >  malidp_verify_afbc_framebuffer_caps(struct drm_device *dev,
> >  				    const struct drm_mode_fb_cmd2 *mode_cmd)
> >  {
> > -	const struct drm_format_info *info;
> > -
> > -	if ((mode_cmd->modifier[0] >> 56) !=3D DRM_FORMAT_MOD_VENDOR_ARM) {
> > -		DRM_DEBUG_KMS("Unknown modifier (not Arm)\n");
> > +	if (malidp_format_mod_supported(dev, mode_cmd->pixel_format, mode_cmd=
->modifier[0]) =3D=3D false)
> >  		return false;
> > -	}
> > -
> > -	if (mode_cmd->modifier[0] &
> > -	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> > -		DRM_DEBUG_KMS("Unsupported modifiers\n");
> > -		return false;
> > -	}
> > -
> > -	info =3D drm_get_format_info(dev, mode_cmd);
> > -	if (!info) {
> > -		DRM_DEBUG_KMS("Unable to get the format information\n");
> > -		return false;
> > -	}
> > -
> > -	if (info->num_planes !=3D 1) {
> > -		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
> > -		return false;
> > -	}
> > =20
> >  	if (mode_cmd->offsets[0] !=3D 0) {
> >  		DRM_DEBUG_KMS("AFBC buffers' plane offset should be 0\n");
> > diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/mal=
idp_drv.h
> > index b76c86f..019a682 100644
> > --- a/drivers/gpu/drm/arm/malidp_drv.h
> > +++ b/drivers/gpu/drm/arm/malidp_drv.h
> > @@ -90,6 +90,12 @@ struct malidp_crtc_state {
> >  int malidp_de_planes_init(struct drm_device *drm);
> >  int malidp_crtc_init(struct drm_device *drm);
> > =20
> > +bool malidp_hw_format_is_linear_only(u32 format);
> > +bool malidp_hw_format_is_afbc_only(u32 format);
> > +
> > +bool malidp_format_mod_supported(struct drm_device *drm,
> > +				 u32 format, u64 modifier);
> > +
> >  #ifdef CONFIG_DEBUG_FS
> >  void malidp_error(struct malidp_drm *malidp,
> >  		  struct malidp_error_stats *error_stats, u32 status,
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/mali=
dp_hw.c
> > index 25ac5890..4a774be 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > @@ -60,6 +60,8 @@ static const struct malidp_format_id malidp500_de_for=
mats[] =3D {
> >  #define MALIDP_ID(__group, __format) \
> >  	((((__group) & 0x7) << 3) | ((__format) & 0x7))
> > =20
> > +#define AFBC_YUV_422_FORMAT_ID	MALIDP_ID(5, 1)
> > +
> >  #define MALIDP_COMMON_FORMATS \
> >  	/*    fourcc,   layers supporting the format,      internal id   */ \
> >  	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_M=
EMWRITE, MALIDP_ID(0, 0) }, \
> > @@ -887,7 +889,10 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DE=
VICES] =3D {
> >  			.se_base =3D MALIDP550_SE_BASE,
> >  			.dc_base =3D MALIDP550_DC_BASE,
> >  			.out_depth_base =3D MALIDP550_DE_OUTPUT_DEPTH,
> > -			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPO=
RT_SPLIT | AFBC_SUPPORT_SPLIT_WITH_YUV_420_10,
> > +			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ |
> > +				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
> > +				    MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT |
>=20
> Please roll some of these changes into patch 5/12.
>=20
> > +				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
> >  			.n_layers =3D ARRAY_SIZE(malidp550_layers),
> >  			.layers =3D malidp550_layers,
> >  			.de_irq_map =3D {
> > @@ -933,7 +938,9 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEV=
ICES] =3D {
> >  			.se_base =3D MALIDP550_SE_BASE,
> >  			.dc_base =3D MALIDP550_DC_BASE,
> >  			.out_depth_base =3D MALIDP550_DE_OUTPUT_DEPTH,
> > -			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPO=
RT_SPLIT,
> > +			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ |
> > +				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
> > +				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
> >  			.n_layers =3D ARRAY_SIZE(malidp650_layers),
> >  			.layers =3D malidp650_layers,
> >  			.de_irq_map =3D {
> > @@ -982,19 +989,73 @@ const struct malidp_hw malidp_device[MALIDP_MAX_D=
EVICES] =3D {
> >  };
> > =20
> >  u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
> > -			   u8 layer_id, u32 format)
> > +			   u8 layer_id, u32 format, bool has_modifier)
> >  {
> >  	unsigned int i;
> > =20
> >  	for (i =3D 0; i < map->n_pixel_formats; i++) {
> >  		if (((map->pixel_formats[i].layer & layer_id) =3D=3D layer_id) &&
> > -		    (map->pixel_formats[i].format =3D=3D format))
> > -			return map->pixel_formats[i].id;
> > +		    (map->pixel_formats[i].format =3D=3D format)) {
> > +
> > +			/*
> > +			 * In some DP550 and DP650, DRM_FORMAT_YUYV + AFBC modifier
> > +			 * is supported by a different h/w format id than
> > +			 * DRM_FORMAT_YUYV (only).
> > +			 */
> > +			if (format =3D=3D DRM_FORMAT_YUYV &&
> > +			    (has_modifier) &&
> > +			    (map->features & MALIDP_DEVICE_AFBC_YUYV_USE_422_P2))
> > +				return AFBC_YUV_422_FORMAT_ID;
> > +			else
> > +				return map->pixel_formats[i].id;
> > +		}
> >  	}
> > =20
> >  	return MALIDP_INVALID_FORMAT_ID;
> >  }
> > =20
> > +bool malidp_hw_format_is_linear_only(u32 format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_ARGB2101010:
> > +	case DRM_FORMAT_RGBA1010102:
> > +	case DRM_FORMAT_BGRA1010102:
> > +	case DRM_FORMAT_ARGB8888:
> > +	case DRM_FORMAT_RGBA8888:
> > +	case DRM_FORMAT_BGRA8888:
> > +	case DRM_FORMAT_XBGR8888:
> > +	case DRM_FORMAT_XRGB8888:
> > +	case DRM_FORMAT_RGBX8888:
> > +	case DRM_FORMAT_BGRX8888:
> > +	case DRM_FORMAT_RGB888:
> > +	case DRM_FORMAT_RGB565:
> > +	case DRM_FORMAT_ARGB1555:
> > +	case DRM_FORMAT_RGBA5551:
> > +	case DRM_FORMAT_BGRA5551:
> > +	case DRM_FORMAT_UYVY:
> > +	case DRM_FORMAT_XYUV8888:
> > +	case DRM_FORMAT_XVYU2101010:
> > +	case DRM_FORMAT_X0L2:
> > +	case DRM_FORMAT_X0L0:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> > +bool malidp_hw_format_is_afbc_only(u32 format)
> > +{
> > +	switch (format) {
> > +	case DRM_FORMAT_VUY888:
> > +	case DRM_FORMAT_VUY101010:
> > +	case DRM_FORMAT_YUV420_8BIT:
> > +	case DRM_FORMAT_YUV420_10BIT:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >  static void malidp_hw_clear_irq(struct malidp_hw_device *hwdev, u8 blo=
ck, u32 irq)
> >  {
> >  	u32 base =3D malidp_get_block_base(hwdev, block);
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/mali=
dp_hw.h
> > index 27b907f..52188f0 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.h
> > +++ b/drivers/gpu/drm/arm/malidp_hw.h
> > @@ -97,7 +97,8 @@ struct malidp_se_config {
> >  /* regmap features */
> >  #define MALIDP_REGMAP_HAS_CLEARIRQ				BIT(0)
> >  #define MALIDP_DEVICE_AFBC_SUPPORT_SPLIT			BIT(1)
> > -#define AFBC_SUPPORT_SPLIT_WITH_YUV_420_10			BIT(2)
> > +#define MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT		BIT(2)
> > +#define MALIDP_DEVICE_AFBC_YUYV_USE_422_P2			BIT(3)
> > =20
> >  struct malidp_hw_regmap {
> >  	/* address offset of the DE register bank */
> > @@ -323,7 +324,7 @@ int malidp_se_irq_init(struct drm_device *drm, int =
irq);
> >  void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
> > =20
> >  u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
> > -			   u8 layer_id, u32 format);
> > +			   u8 layer_id, u32 format, bool has_modifier);
> > =20
> >  static inline u8 malidp_hw_get_pitch_align(struct malidp_hw_device *hw=
dev, bool rotated)
> >  {
> > diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/mali=
dp_mw.c
> > index 91472e5..0484744 100644
> > --- a/drivers/gpu/drm/arm/malidp_mw.c
> > +++ b/drivers/gpu/drm/arm/malidp_mw.c
> > @@ -143,7 +143,7 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *=
encoder,
> > =20
> >  	mw_state->format =3D
> >  		malidp_hw_get_format_id(&malidp->dev->hw->map, SE_MEMWRITE,
> > -					fb->format->format);
> > +					fb->format->format, !!fb->modifier);
> >  	if (mw_state->format =3D=3D MALIDP_INVALID_FORMAT_ID) {
> >  		struct drm_format_name_buf format_name;
> > =20
> > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/=
malidp_planes.c
> > index cd60f73..0765cee 100644
> > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > @@ -52,6 +52,8 @@
> >  #define MALIDP550_LS_ENABLE		0x01c
> >  #define MALIDP550_LS_R1_IN_SIZE		0x020
> > =20
> > +#define MODIFIERS_COUNT_MAX		15
> > +
> >  /*
> >   * This 4-entry look-up-table is used to determine the full 8-bit alph=
a value
> >   * for formats with 1- or 2-bit alpha channels.
> > @@ -145,6 +147,117 @@ static void malidp_plane_atomic_print_state(struc=
t drm_printer *p,
> >  	drm_printf(p, "\tmmu_prefetch_pgsize=3D%d\n", ms->mmu_prefetch_pgsize=
);
> >  }
> > =20
> > +bool malidp_format_mod_supported(struct drm_device *drm,
> > +				 u32 format, u64 modifier)
> > +{
> > +	const struct drm_format_info *info;
> > +	const u64 *modifiers;
> > +	struct malidp_drm *malidp =3D drm->dev_private;
> > +	const struct malidp_hw_regmap *map =3D &malidp->dev->hw->map;
> > +
> > +	if (WARN_ON(modifier =3D=3D DRM_FORMAT_MOD_INVALID))
> > +		return false;
> > +
> > +	/* Some pixel formats are supported without any modifier */
> > +	if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR) {
> > +		/* However these pixel formats need to be supported with
>=20
> Nitpick: multi-line comment style is to start with a line that contains
> only the marker for the start of the comment.
Agreed
>=20
> > +		 * modifiers only
> > +		 */
> > +		return !malidp_hw_format_is_afbc_only(format);
> > +	}
> > +
> > +	if ((modifier >> 56) !=3D DRM_FORMAT_MOD_VENDOR_ARM) {
> > +		DRM_ERROR("Unknown modifier (not Arm)\n");
> > +		return false;
> > +	}
> > +
> > +	if (modifier &
> > +	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> > +		DRM_DEBUG_KMS("Unsupported modifiers\n");
> > +		return false;
> > +	}
> > +
> > +	modifiers =3D malidp_format_modifiers;
>=20
> Actually, looking again at patch 5/12 it looks to me like you could roll
> it into this patch completely.
>
Agreed, I will merge patch 5/12 "Defining a common list of AFBC
modifiers" with the current patch ("adding constraints for each format
and modifier").

> > +	while (*modifiers !=3D DRM_FORMAT_MOD_INVALID) {
> > +		if (*modifiers =3D=3D modifier) {
> > +			/* SPLIT buffers must use SPARSE layout */
> > +			if (WARN_ON_ONCE((modifier & AFBC_SPLIT) && !(modifier & AFBC_SPARS=
E)))
> > +				return false;
> > +
> > +			/* CBR only applies to YUV formats, where YTR should be always 0 */
> > +			if (WARN_ON_ONCE((modifier & AFBC_CBR) && (modifier & AFBC_YTR)))
> > +				return false;
>=20
> You can take these checks outside the while() loop as they test if the
> modifier passed as a parameter is valid, which you should check before
> running through the array. If you do that, then the loop through the
> malidp_format_modifiers is a simple "if found, break out of loop" and
> then the next check will return false if you iterated over the entire
> list.
>=20
Agreed
> > +
> > +			break;
> > +		}
> > +
> > +		modifiers++;
> > +	}
> > +
> > +	/* return false, if the modifier was not found */
> > +	if (*modifiers =3D=3D DRM_FORMAT_MOD_INVALID) {
> > +		DRM_DEBUG_KMS("Unsupported modifier\n");
> > +		return false;
> > +	}
> > +
> > +	info =3D drm_format_info(format);
> > +
> > +	if (info->num_planes !=3D 1) {
> > +		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
> > +		return false;
> > +	}
> > +
> > +	if (malidp_hw_format_is_linear_only(format) =3D=3D true) {
> > +		DRM_DEBUG_KMS("Given format (0x%x) is supported is linear mode only\=
n", format);
> > +		return false;
> > +	}
> > +
> > +	/*
> > +	 * RGB formats need to provide YTR modifier and YUV formats should no=
t
> > +	 * provide YTR modifier.
> > +	 */
> > +	if (!(info->is_yuv) !=3D !!(modifier & AFBC_FORMAT_MOD_YTR)) {
> > +		DRM_DEBUG_KMS("AFBC_FORMAT_MOD_YTR is %s for %s formats\n",
> > +			      info->is_yuv ? "disallowed" : "mandatory",
> > +			      info->is_yuv ? "YUV" : "RGB");
> > +		return false;
> > +	}
> > +
> > +	if (modifier & AFBC_SPLIT) {
> > +		if (!info->is_yuv) {
> > +			if (drm_format_plane_cpp(format, 0) <=3D 2) {
> > +				DRM_DEBUG_KMS("RGB formats <=3D 16bpp are not supported with SPLIT=
\n");
> > +				return false;
> > +			}
> > +		}
> > +
> > +		if ((drm_format_horz_chroma_subsampling(format) !=3D 1) ||
> > +		    (drm_format_vert_chroma_subsampling(format) !=3D 1)) {
> > +			if (!(format =3D=3D DRM_FORMAT_YUV420_10BIT &&
> > +			     (map->features & MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT))=
) {
> > +				DRM_DEBUG_KMS("Formats which are sub-sampled should never be split=
\n");
> > +				return false;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (modifier & AFBC_CBR) {
> > +		if ((drm_format_horz_chroma_subsampling(format) =3D=3D 1) ||
> > +		    (drm_format_vert_chroma_subsampling(format) =3D=3D 1)) {
> > +			DRM_DEBUG_KMS("Formats which are not sub-sampled should not have CB=
R set\n");
> > +			return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static bool malidp_format_mod_supported_per_plane(struct drm_plane *pl=
ane,
> > +						  u32 format, u64 modifier)
> > +{
> > +	return malidp_format_mod_supported(plane->dev, format, modifier);
> > +}
> > +
> >  static const struct drm_plane_funcs malidp_de_plane_funcs =3D {
> >  	.update_plane =3D drm_atomic_helper_update_plane,
> >  	.disable_plane =3D drm_atomic_helper_disable_plane,
> > @@ -153,6 +266,7 @@ static const struct drm_plane_funcs malidp_de_plane=
_funcs =3D {
> >  	.atomic_duplicate_state =3D malidp_duplicate_plane_state,
> >  	.atomic_destroy_state =3D malidp_destroy_plane_state,
> >  	.atomic_print_state =3D malidp_plane_atomic_print_state,
> > +	.format_mod_supported =3D malidp_format_mod_supported_per_plane,
> >  };
> > =20
> >  static int malidp_se_check_scaling(struct malidp_plane *mp,
> > @@ -406,8 +520,8 @@ static int malidp_de_plane_check(struct drm_plane *=
plane,
> >  	fb =3D state->fb;
> > =20
> >  	ms->format =3D malidp_hw_get_format_id(&mp->hwdev->hw->map,
> > -					     mp->layer->id,
> > -					     fb->format->format);
> > +					     mp->layer->id, fb->format->format,
> > +					     !!fb->modifier);
> >  	if (ms->format =3D=3D MALIDP_INVALID_FORMAT_ID)
> >  		return -EINVAL;
> > =20
> > @@ -469,6 +583,12 @@ static int malidp_de_plane_check(struct drm_plane =
*plane,
> >  			return -EINVAL;
> >  	}
> > =20
> > +	/* SMART layer does not support AFBC */
> > +	if (mp->layer->id =3D=3D DE_SMART && fb->modifier) {
> > +		DRM_ERROR("AFBC framebuffer not supported in SMART layer");
> > +		return -EINVAL;
> > +	}
> > +
> >  	ms->rotmem_size =3D 0;
> >  	if (state->rotation & MALIDP_ROTATED_MASK) {
> >  		int val;
> > --=20
> > 2.7.4
> >=20
>=20
> Best regards,
> Liviu
>=20
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
