Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4996CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FAA20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="catV+vGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeLNNpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:45:21 -0500
Received: from mail-eopbgr150075.outbound.protection.outlook.com ([40.107.15.75]:52232
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729465AbeLNNpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgQZ9WLn1T9xRAEuQSdos1B8PzcPRYCan8OUJcnTP9A=;
 b=catV+vGL0O10+kl9iFSXFqwtXbuP11a7tei6A9hBcaLcM4aHLr6wM5NcS+W4eQp610AljiEM9OpPc3fDA6W6YZYtPVbLMVKuh/xzrQcyD80QWBU5gM0o5EVEdVuo/KZGDMYBMwDIq3HqSuqspCvqpO34NiUXif/iRrbxPAxwexk=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3618.eurprd08.prod.outlook.com (20.177.111.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Fri, 14 Dec 2018 13:45:14 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::f1f9:6693:ed35:d489]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::f1f9:6693:ed35:d489%4]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 13:45:14 +0000
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
Subject: Re: [RFC v3 AFBC 04/12] drm/arm/malidp: Set the AFBC register bits if
 the framebuffer has AFBC modifier
Thread-Topic: [RFC v3 AFBC 04/12] drm/arm/malidp: Set the AFBC register bits
 if the framebuffer has AFBC modifier
Thread-Index: AQHUivvNe+KfFyADaUyOk+ZKPgY96qVuzRGAgA+DbwA=
Date:   Fri, 14 Dec 2018 13:45:13 +0000
Message-ID: <20181214134512.GA19564@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
 <1543836703-8491-5-git-send-email-ayan.halder@arm.com>
 <20181204165051.GL988@e110455-lin.cambridge.arm.com>
In-Reply-To: <20181204165051.GL988@e110455-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:25::35) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3618;6:1lM7XMfuadoTWUCNKSELm6PuPdrDHhU+LUfRr3j0y77cCHytpXfNO6Elv57x1vv+vEevF8quCSkOgslGbh80sB4nUPZmLHbe9wIpU4RW/y4AogScpB+qxs9ylZJfYjcO1utT6r6CRRKqcHF+Iiyv2cxzT/bBIGS/nk0s9a8CG92W1XiLgCs8oooUAVdsKbWSdsr2ZnWclPLGmx2bkaRxprC+KW2Ir1MDDxxd5uUftVaYog+cZlYFwTd/2s7nsqV2y+aHKcgnJkXGBFqxPioZ7wlFWCn3XNd/WM0gLc+ONPLAyPNp4Kqwj1gKpJWpI4fG040/Ghmp3X6w0j8vBl/fCvEHd3olfjAd9QH4iI+qiJ1MHUHQ3/npyfnRPmgoxzBQZ5UHhIYR1PDO2iDa4QslrlDaiGpWAiFO8RJypDEv0Ua/3Kne3HT2Lfdtp5yYhyggPcS1i0IPHZIfdF1KacQDLA==;5:qEJtUyb7mQEIs1x++lcTJMS62WlN1duTBJitpj1HAKpIo1Zv+OEuqMwLIbUJ8h7KYqd3kjrHG0qzen7hLk6NE8hj8EPNZFSwcLjMh6GjIQ3Yliw1ppTXgFI4ypU9GsShptTS4uvEeTmLRjolqubr8SbZvyb2qoJRa1h3ssrTb+Q=;7:B6+gZoI2tPPC7MyLVBUa+ObjQ1LOdnhXEB0MOu/3DiL4vR4CJkRxDomk7MtIfxX+YJV0BUIOAuKw2prZ1Gu1UW2aAmI6IoVajL5KReOTYLROfJqev3FwMUpy+rkmsUnN2KMEnXc4NgEqWDbYJxLLEw==
x-ms-office365-filtering-correlation-id: 90f7e340-9f68-4675-d121-08d661ca5f7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3618;
x-ms-traffictypediagnostic: AM0PR08MB3618:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3618FE71A63BF8F3A25A0015E4A10@AM0PR08MB3618.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3618;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3618;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(43544003)(4744004)(52116002)(386003)(71200400001)(575784001)(1076002)(6246003)(14454004)(86362001)(71190400001)(33656002)(102836004)(99286004)(8936002)(6506007)(11346002)(6636002)(2616005)(186003)(446003)(476003)(229853002)(76176011)(68736007)(81156014)(6486002)(6436002)(26005)(8676002)(3846002)(486006)(2906002)(6116002)(44832011)(256004)(14444005)(81166006)(7736002)(105586002)(305945005)(106356001)(316002)(97736004)(54906003)(45080400002)(6512007)(6306002)(7416002)(4326008)(36756003)(72206003)(25786009)(478600001)(966005)(66066001)(5660300001)(37006003)(53936002)(6862004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3618;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jjsrJS4/TFl9RrUL36xQQnlbUgsQlRstxsxnia82GOPOWN97kRSwyA/Jld/H73tqyXfRF0Q83D4vFz7+Ik5uQXYWbnGN/xmQAKiOdLLbAcXyBUKI5/G6r63xI7t+QAZq2uhC3Qk3XhS2iozA1ZRrmSqx09A6S7k5M91raFBOcd9ExFRehIqGu2DMKcXQrL2QEZeICiDuiT9wUtNAKlgrpxj2HdCz4632GhHClQ9DP2Mpw/+qhuHc7qdliSBmTG7g5gLFVtk1dHq9rIJ4Gjjseetez+4JOGDKXTNb0Qy3/j+VO2y6Xe2YFrikMjscqANx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0EFD9F35D3EFC469EE5BAF10E6928A9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f7e340-9f68-4675-d121-08d661ca5f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 13:45:13.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3618
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:50:51PM +0000, Liviu Dudau wrote:

Hi Liviu,

Please let me know if you agree with my comments. Then I will send a
v4 patch for this.
> On Mon, Dec 03, 2018 at 11:31:58AM +0000, Ayan Halder wrote:
> > Added the AFBC decoder registers for DP500 , DP550 and DP650.
> > These registers control the processing of AFBC buffers. It controls var=
ious
> > features like AFBC decoder enable, lossless transformation and block sp=
lit
> > as well as setting of the left, right, top and bottom cropping of AFBC =
buffers
> > (in number of pixels).
> > All the layers (except DE_SMART) support framebuffers with AFBC modifie=
rs.
> > One needs to set the pixel values of the top, left, bottom and right cr=
opping
> > for the AFBC framebuffer.
> > Cropping an AFBC framebuffer is controlled by the AFBC crop registers.
> > In that case, the layer input size registers should be configured with
> > framebuffer's dimensions and not with drm_plane_state source width/heig=
ht
> > values (which is used for non AFBC framebuffer to denote cropping).
> >=20
> > Changes from v1:
> >  - Removed the "if (fb->modifier)" check from malidp_de_plane_update()
> > and added it in malidp_de_set_plane_afbc(). This will consolidate all t=
he
> > AFBC specific register configurations in a single function ie
> > malidp_de_set_plane_afbc().
> >=20
> > Changes from v2:
> >  - For AFBC framebuffer, layer input size register should be set to fra=
mebuffer's
> > width and height
> >=20
> > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > ---
> >  drivers/gpu/drm/arm/malidp_hw.c     |  25 +++++----
> >  drivers/gpu/drm/arm/malidp_hw.h     |   2 +
> >  drivers/gpu/drm/arm/malidp_planes.c | 109 ++++++++++++++++++++++++++++=
+++-----
> >  drivers/gpu/drm/arm/malidp_regs.h   |  20 +++++++
> >  4 files changed, 130 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/mali=
dp_hw.c
> > index b9bed11..87b7b12 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.c
> > +++ b/drivers/gpu/drm/arm/malidp_hw.c
> > @@ -94,11 +94,12 @@ static const struct malidp_layer malidp500_layers[]=
 =3D {
> >  	 *	yuv2rgb matrix offset, mmu control register offset, rotation_featu=
res
> >  	 */
> >  	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0, ROTATE_ANY },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0, ROTATE_ANY,
> > +		MALIDP500_DE_LV_AD_CTRL },
> >  	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY, MALIDP500_DE_LG1_AD_CTRL },
> >  	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY, MALIDP500_DE_LG2_AD_CTRL },
> >  };
> > =20
> >  static const struct malidp_layer malidp550_layers[] =3D {
> > @@ -106,13 +107,15 @@ static const struct malidp_layer malidp550_layers=
[] =3D {
> >  	 *	yuv2rgb matrix offset, mmu control register offset, rotation_featu=
res
> >  	 */
> >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY,
> > +		MALIDP550_DE_LV1_AD_CTRL },
> >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> > -		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
> > +		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY, MALIDP550_DE_LG_AD_CTRL },
> >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> > -		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
> > +		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY,
> > +		MALIDP550_DE_LV2_AD_CTRL },
> >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> > -		MALIDP550_DE_LS_R1_STRIDE, 0, 0, ROTATE_NONE },
> > +		MALIDP550_DE_LS_R1_STRIDE, 0, 0, ROTATE_NONE, 0 },
> >  };
> > =20
> >  static const struct malidp_layer malidp650_layers[] =3D {
> > @@ -122,16 +125,16 @@ static const struct malidp_layer malidp650_layers=
[] =3D {
> >  	 */
> >  	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
> >  		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
> > -		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
> > +		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY, MALIDP550_DE_LV1_AD_CTRL },
> >  	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
> >  		MALIDP_DE_LG_STRIDE, 0, MALIDP650_DE_LG_MMU_CTRL,
> > -		ROTATE_COMPRESSED },
> > +		ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
> >  	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
> >  		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
> > -		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
> > +		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY, MALIDP550_DE_LV2_AD_CTRL },
> >  	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
> >  		MALIDP550_DE_LS_R1_STRIDE, 0, MALIDP650_DE_LS_MMU_CTRL,
> > -		ROTATE_NONE },
> > +		ROTATE_NONE, 0 },
> >  };
> > =20
> >  #define SE_N_SCALING_COEFFS	96
> > diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/mali=
dp_hw.h
> > index 40155e2..651558f 100644
> > --- a/drivers/gpu/drm/arm/malidp_hw.h
> > +++ b/drivers/gpu/drm/arm/malidp_hw.h
> > @@ -70,6 +70,8 @@ struct malidp_layer {
> >  	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
> >  	u16 mmu_ctrl_offset;    /* offset to the MMU control register */
> >  	enum rotation_features rot;	/* type of rotation supported */
> > +	/* address offset for the AFBC decoder registers */
> > +	u16 afbc_decoder_offset;
> >  };
> > =20
> >  enum malidp_scaling_coeff_set {
> > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/=
malidp_planes.c
> > index c9a6d3e..cd60f73 100644
> > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > @@ -592,6 +592,80 @@ static void malidp_de_set_mmu_control(struct malid=
p_plane *mp,
> >  			mp->layer->base + mp->layer->mmu_ctrl_offset);
> >  }
> > =20
> > +static void malidp_set_plane_base_addr(struct drm_framebuffer *fb,
> > +				       struct malidp_plane *mp,
> > +				       int plane_index)
> > +{
> > +	dma_addr_t paddr;
> > +	u16 ptr;
> > +	struct drm_plane *plane =3D &mp->base;
> > +	bool afbc =3D fb->modifier ? true : false;
> > +
> > +	ptr =3D mp->layer->ptr + (plane_index << 4);
> > +
> > +	/*
> > +	 * For AFBC buffers, cropping is handled by AFBC decoder rather than
> > +	 * pointer manipulation.
> > +	 */
>=20
> I think this comment needs to go in malidp_de_plane_update, not in this f=
unction.
> This function only updates the plane's base address.
>
I will reword the comment like this if it sounds sane :-

drm_fb_cma_get_gem_addr() alters the physical base address of the framebuff=
er
as per the plane's src_x, src_y co-ordinates (ie to take care of source cro=
pping).
For AFBC, this is not needed as the cropping is handled by _AD_CROP_H
and _AD_CROP_V registers.

> > +	if (!afbc) {
> > +		paddr =3D drm_fb_cma_get_gem_addr(fb, plane->state,
> > +						plane_index);
> > +	} else {
> > +		struct drm_gem_cma_object *obj;
> > +
> > +		obj =3D drm_fb_cma_get_gem_obj(fb, plane_index);
> > +
> > +		if (WARN_ON(!obj))
> > +			return;
> > +		paddr =3D obj->paddr;
> > +	}
> > +
> > +	malidp_hw_write(mp->hwdev, lower_32_bits(paddr), ptr);
> > +	malidp_hw_write(mp->hwdev, upper_32_bits(paddr), ptr + 4);
> > +}
> > +
> > +static void malidp_de_set_plane_afbc(struct drm_plane *plane)
> > +{
> > +	struct malidp_plane *mp;
> > +	u32 src_w, src_h, val =3D 0, src_x, src_y;
> > +	struct drm_framebuffer *fb =3D plane->state->fb;
> > +
> > +	mp =3D to_malidp_plane(plane);
> > +
> > +	/* no afbc_decoder_offset means AFBC is not supported on this plane *=
/
> > +	if (!mp->layer->afbc_decoder_offset)
> > +		return;
> > +
> > +	if (!fb->modifier) {
> > +		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
> > +		return;
> > +	}
> > +
> > +	/* convert src values from Q16 fixed point to integer */
> > +	src_w =3D plane->state->src_w >> 16;
> > +	src_h =3D plane->state->src_h >> 16;
> > +	src_x =3D plane->state->src_x >> 16;
> > +	src_y =3D plane->state->src_y >> 16;
> > +
> > +	val =3D ((fb->width - (src_x + src_w)) << MALIDP_AD_CROP_RIGHT_OFFSET=
) |
> > +		   src_x;
> > +	malidp_hw_write(mp->hwdev, val,
> > +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_H);
> > +
> > +	val =3D ((fb->height - (src_y + src_h)) << MALIDP_AD_CROP_BOTTOM_OFFS=
ET) |
> > +		   src_y;
> > +	malidp_hw_write(mp->hwdev, val,
> > +			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_V);
> > +
> > +	val =3D MALIDP_AD_EN;
> > +	if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
> > +		val |=3D MALIDP_AD_BS;
> > +	if (fb->modifier & AFBC_FORMAT_MOD_YTR)
> > +		val |=3D MALIDP_AD_YTR;
> > +
> > +	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
> > +}
> > +
> >  static void malidp_de_plane_update(struct drm_plane *plane,
> >  				   struct drm_plane_state *old_state)
> >  {
> > @@ -600,30 +674,33 @@ static void malidp_de_plane_update(struct drm_pla=
ne *plane,
> >  	struct drm_plane_state *state =3D plane->state;
> >  	u16 pixel_alpha =3D state->pixel_blend_mode;
> >  	u8 plane_alpha =3D state->alpha >> 8;
> > +	bool format_has_alpha =3D state->fb->format->has_alpha;
> >  	u32 src_w, src_h, dest_w, dest_h, val;
> >  	int i;
> > +	struct drm_framebuffer *fb =3D plane->state->fb;
> > =20
> >  	mp =3D to_malidp_plane(plane);
> > =20
> > -	/* convert src values from Q16 fixed point to integer */
> > -	src_w =3D state->src_w >> 16;
> > -	src_h =3D state->src_h >> 16;
> > -	dest_w =3D state->crtc_w;
> > -	dest_h =3D state->crtc_h;
> > +	/* For AFBC framebuffer, use the framebuffer width and height for con=
figuring
> > +	 * layer input size register.
> > +	 */
> > +	if (fb->modifier) {
> > +		src_w =3D fb->width;
> > +		src_h =3D fb->height;
> > +	} else {
> > +		/* convert src values from Q16 fixed point to integer */
> > +		src_w =3D ms->base.src_w >> 16;
> > +		src_h =3D ms->base.src_h >> 16;
> > +	}
> > +	dest_w =3D ms->base.crtc_w;
> > +	dest_h =3D ms->base.crtc_h;
>=20
> These two lines above are equivalent to the last two lines you deleted. W=
hy you need this change?
>=20
Agreed, I will remove this change.
> > =20
> >  	val =3D malidp_hw_read(mp->hwdev, mp->layer->base);
> >  	val =3D (val & ~LAYER_FORMAT_MASK) | ms->format;
> >  	malidp_hw_write(mp->hwdev, val, mp->layer->base);
> > =20
> > -	for (i =3D 0; i < ms->n_planes; i++) {
> > -		/* calculate the offset for the layer's plane registers */
> > -		u16 ptr =3D mp->layer->ptr + (i << 4);
> > -		dma_addr_t fb_addr =3D drm_fb_cma_get_gem_addr(state->fb,
> > -							     state, i);
> > -
> > -		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
> > -		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
> > -	}
> > +	for (i =3D 0; i < ms->n_planes; i++)
> > +		malidp_set_plane_base_addr(fb, mp, i);
> > =20
> >  	malidp_de_set_mmu_control(mp, ms);
> > =20
> > @@ -657,6 +734,8 @@ static void malidp_de_plane_update(struct drm_plane=
 *plane,
> >  				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
> >  	}
> > =20
> > +	malidp_de_set_plane_afbc(plane);
>=20
> I feel like this function call should be done only if (fb->modifier) is
> true.
We need to call this function even is fb->modifier =3D 0. Please refer
to the following snippet in malidp_de_set_plane_afbc()

if (!fb->modifier) {
      malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
      return;
}
I will prefer to keep all the AFBC register configuration in a single
function.

Thanks,
Ayan Kumar Halder
>=20
> > +
> >  	/* first clear the rotation bits */
> >  	val =3D malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONT=
ROL);
> >  	val &=3D ~LAYER_ROT_MASK;
> > @@ -674,7 +753,7 @@ static void malidp_de_plane_update(struct drm_plane=
 *plane,
> > =20
> >  	if (state->alpha !=3D DRM_BLEND_ALPHA_OPAQUE) {
> >  		val |=3D LAYER_COMP_PLANE;
> > -	} else if (state->fb->format->has_alpha) {
> > +	} else if (format_has_alpha) {
>=20
> This change has nothing to do with AFBC, it should not be in this patch.
>=20
> >  		/* We only care about blend mode if the format has alpha */
> >  		switch (pixel_alpha) {
> >  		case DRM_MODE_BLEND_PREMULTI:
> > diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/ma=
lidp_regs.h
> > index 7ce3e14..a0dd6e1 100644
> > --- a/drivers/gpu/drm/arm/malidp_regs.h
> > +++ b/drivers/gpu/drm/arm/malidp_regs.h
> > @@ -198,10 +198,13 @@
> >  #define MALIDP500_LV_YUV2RGB		((s16)(-0xB8))
> >  #define MALIDP500_DE_LV_BASE		0x00100
> >  #define MALIDP500_DE_LV_PTR_BASE	0x00124
> > +#define MALIDP500_DE_LV_AD_CTRL		0x00400
> >  #define MALIDP500_DE_LG1_BASE		0x00200
> >  #define MALIDP500_DE_LG1_PTR_BASE	0x0021c
> > +#define MALIDP500_DE_LG1_AD_CTRL	0x0040c
> >  #define MALIDP500_DE_LG2_BASE		0x00300
> >  #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
> > +#define MALIDP500_DE_LG2_AD_CTRL	0x00418
> >  #define MALIDP500_SE_BASE		0x00c00
> >  #define MALIDP500_SE_CONTROL		0x00c0c
> >  #define MALIDP500_SE_MEMWRITE_OUT_SIZE	0x00c2c
> > @@ -228,10 +231,13 @@
> >  #define MALIDP550_LV_YUV2RGB		0x00084
> >  #define MALIDP550_DE_LV1_BASE		0x00100
> >  #define MALIDP550_DE_LV1_PTR_BASE	0x00124
> > +#define MALIDP550_DE_LV1_AD_CTRL	0x001B8
> >  #define MALIDP550_DE_LV2_BASE		0x00200
> >  #define MALIDP550_DE_LV2_PTR_BASE	0x00224
> > +#define MALIDP550_DE_LV2_AD_CTRL	0x002B8
> >  #define MALIDP550_DE_LG_BASE		0x00300
> >  #define MALIDP550_DE_LG_PTR_BASE	0x0031c
> > +#define MALIDP550_DE_LG_AD_CTRL		0x00330
> >  #define MALIDP550_DE_LS_BASE		0x00400
> >  #define MALIDP550_DE_LS_PTR_BASE	0x0042c
> >  #define MALIDP550_DE_PERF_BASE		0x00500
> > @@ -258,6 +264,20 @@
> >  #define MALIDP_MMU_CTRL_PX_PS(x)	(1 << (8 + (x)))
> >  #define MALIDP_MMU_CTRL_PP_NUM_REQ(x)	(((x) & 0x7f) << 12)
> > =20
> > +/* AFBC register offsets relative to MALIDPXXX_DE_LX_AD_CTRL */
> > +/* The following register offsets are common for DP500, DP550 and DP65=
0 */
> > +#define MALIDP_AD_CROP_H                0x4
> > +#define MALIDP_AD_CROP_V                0x8
> > +#define MALIDP_AD_END_PTR_LOW           0xc
> > +#define MALIDP_AD_END_PTR_HIGH          0x10
> > +
> > +/* AFBC decoder Registers */
> > +#define MALIDP_AD_EN                    BIT(0)
> > +#define MALIDP_AD_YTR                   BIT(4)
> > +#define MALIDP_AD_BS                    BIT(8)
> > +#define MALIDP_AD_CROP_RIGHT_OFFSET     16
> > +#define MALIDP_AD_CROP_BOTTOM_OFFSET    16
> > +
> >  /*
> >   * Starting with DP550 the register map blocks has been standardised t=
o the
> >   * following layout:
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
