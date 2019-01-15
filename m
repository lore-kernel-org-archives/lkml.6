Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F24C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C4D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YoskICuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfAOOtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:49:50 -0500
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:4655
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728619AbfAOOtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS1fbPEplmOiVKd/QJ7ESZqFxlKZtvNdrorAhL6nAQE=;
 b=YoskICuRY/o6BIb2mUP4DsxF+pcMc0CGZDRFjuNEpStaqXa3pVom0fEdnG5CE1mKVuB9bC5xvhrlu8uYr0NAGfNqgAr3TVouV6j+MHPgZMZixoTuyRElG/flIjCjDbDcCfBMQFy7bTplgAnPCc8m5poB2wmD5tVfHkwK1Fl8XHw=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB4226.eurprd08.prod.outlook.com (20.179.32.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 14:49:43 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::39a3:457f:3d5e:84ff]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::39a3:457f:3d5e:84ff%3]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 14:49:43 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "seanpaul@google.com" <seanpaul@google.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] [RFC] drm_hwcomposer: Add support for Arm Framebuffer
 Compression (AFBC) modifiers.
Thread-Topic: [PATCH] [RFC] drm_hwcomposer: Add support for Arm Framebuffer
 Compression (AFBC) modifiers.
Thread-Index: AQHUrB3LrXJMP7k9bUyTQbg+n7XNXqWwPRCAgAAFLoCAAAPpgIAADZ8AgAAAoYCAABZ2gA==
Date:   Tue, 15 Jan 2019 14:49:43 +0000
Message-ID: <20190115144942.GA16738@arm.com>
References: <1547479696-14376-1-git-send-email-ayan.halder@arm.com>
 <20190115120547.GL10517@phenom.ffwll.local>
 <20190115122418.GS20661@e110455-lin.cambridge.arm.com>
 <CAKMK7uHW=PafGQdcT7HykwSRMtVJ_zufdgBk2O6pVxSxk9CCyg@mail.gmail.com>
 <20190115132703.GT20661@e110455-lin.cambridge.arm.com>
 <CAKMK7uGz2Y+wc6dydmEfzB0trwmCV51uv495o7H0V4kCBwXDhg@mail.gmail.com>
In-Reply-To: <CAKMK7uGz2Y+wc6dydmEfzB0trwmCV51uv495o7H0V4kCBwXDhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::25) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB4226;6:PJoGmj7W00dPs5LKEnNKG7AdBjV3zFPztc1F6M/kQLksYH5P4HB7D2o5UVIMacfE8jfILUK5pG3G2FUgNxu8qN9Zo5E5qImjEAUL9mwfpNk/GaV8MlISkwr8pmRZ073xGE4vTDwEl7NkVeQ2ntkFziEtYoaKxEMbqGt6hi/yt2bZdSjFtPRHvw7LIDMmH50SdOoGKoIPjl6lU1ADlevKendJTZls5DmeSeHH7Tn2iXhOnubhy+ctNNjOG8zyyzVVbYvwHTAfJDYFFDNDfGRRkAdlhy2jaRgREFFx9EFfZ7fDNa7a1kEzU9n3UhXMFKO+069IVFXPys5UHAriQCzwpybuwd9hBtMd2Fx2q6xdkd7Mk7HO2RRzGzeI3DrrUq1zreeEUybZzh8R5clKDW0znDcvVeaSxS79lEYrRb+BPVjJAxziw/lXCZrkgsUyipmF3dPmYd3qydsyjIK4GoiqdA==;5:Yjx1gw5soKzN3JKUjfhV+Q6l7vCWNt4AND6BanpE9tD4e/hG+Ptrp6yMmtCDeTGG0CPql7MUbUxQU9JGxtna2EG2GacjsyipL7JMQtndzlp2jVC5TLH9H8ziSuk1Q6dxAUCwkBHBEFNI9JJNi/4BhYA6KEKxR5uURf6TUO7UbGC0I6K4gDiabzEVlO0nDqiAc1HsDbJvzf0BHZU7zqeSfQ==;7:yP12a+4j5spbQ4jASsS6swqSdqVIZIB2dxofehMrBrBXx59U047I4bznO2IqxIilaw24R/j3v5nA3Svzd4faamtdq2s5wwlV5rIx6+iTaWtYtRsgcPDw+TBtr9U8iOog4a4SjZHQScAYiRIGjDO6sQ==
x-ms-office365-filtering-correlation-id: 9a50bd0a-1771-4534-75e8-08d67af8af82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB4226;
x-ms-traffictypediagnostic: AM0PR08MB4226:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB4226D411D8C634B3C70438E6E4810@AM0PR08MB4226.eurprd08.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(7736002)(478600001)(966005)(72206003)(71200400001)(71190400001)(587094005)(81156014)(52116002)(97736004)(26005)(316002)(54906003)(6486002)(105586002)(14454004)(8676002)(68736007)(1076003)(186003)(33656002)(6916009)(44832011)(66066001)(86362001)(19627235002)(256004)(305945005)(14444005)(8936002)(6512007)(2906002)(476003)(6306002)(53936002)(486006)(53386004)(81166006)(36756003)(3846002)(4326008)(93886005)(99286004)(6246003)(53546011)(6506007)(386003)(5660300001)(229853002)(446003)(102836004)(6436002)(76176011)(25786009)(2616005)(106356001)(11346002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4226;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zqKk/invXyiVSFd7tWEtzyNAIdXnwNTGmSHcntq+zxHqP4tTrk9/rapC5hE5qlIZKSMc3awKDrTowLz93/ne8E3+/IRYAFz7JdtGXFaf6sfUo3Z4iHS/8w4uQ4i/EXDg6PYhYknQtMc6Kn6WsUyjkhY87AgC1VroGhNGwEy4pHt56ZVTKl5Mbp526l3hZUEK9AmfhQynCROcyCFhWM/qPnmpJ4EA9+wZPYg+zMPribDOZUyEqo7X6fVd3E9wGTKjQm5mEFq0tWpxP1xrHx/yynSu6dH0k8jD9iUUYsZqfGRiWIpkaydjVB9RAP3eOJPZgkhbAZn1sP1MedxVyQkhfWf16UyR68gl+UZq6ghV3JBZmL06CgaqxePRcgE/rlx9iVFnXUHWCIVxsxCZkcLchDGsJpCSEpKLesSN2PvbEO4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53C4E8592B91D9498EC904259EBA28D3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a50bd0a-1771-4534-75e8-08d67af8af82
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 14:49:43.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 02:29:19PM +0100, Daniel Vetter wrote:
> On Tue, Jan 15, 2019 at 2:27 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> >
> > On Tue, Jan 15, 2019 at 01:38:19PM +0100, Daniel Vetter wrote:
> > > On Tue, Jan 15, 2019 at 1:24 PM Liviu Dudau <Liviu.Dudau@arm.com> wro=
te:
> > > >
> > > > On Tue, Jan 15, 2019 at 01:05:47PM +0100, Daniel Vetter wrote:
> > > > > On Mon, Jan 14, 2019 at 03:28:27PM +0000, Ayan Halder wrote:
> > > > > > One needs to translate the Gralloc buffer flags for AFBC (eg
> > > > > > MALI_GRALLOC_INTFMT_AFBC_BASIC) to the corresponding linux kern=
el drm modifiers.
> > > > > > This gets passed to libdrm via drmModeAddFB2WithModifiers.
> > > > > >
> > > > > > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > > > > >
> > > > > > /-- Note for reviewer
> > > > > > I was able to get this working for Android P on Juno with Mali =
DP650 and Mali
> > > > > > T860 gpu(with some additional hacks). I have not yet validated =
this hikey960.
> > > > > >
> > > > > > I have used the following components:-
> > > > > > 1. Gralloc (from https://android.googlesource.com/device/linaro=
/hikey/+/master/gralloc960)
> > > > > >   - Built with MALI_MMSS=3D1
> > > > > > 2. Libdrm (from git://anongit.freedesktop.org/mesa/drm)
> > > > > >   - You would need drm_fourcc.h and gralloc_handle.h
> > > > > > --/
> > > > >
> > > > > I thought drm_hwcomposer has switched over to gitlab merge reques=
ts?
> > > > > README at least says so:
> > > > >
> > > > > https://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer
> > > >
> > > > So are we to send pull requests for RFCs as well?
> > >
> > > Hm, not sure you should stuff RFC material into your linux-next
> > > branches. I thought that's only for patches which by all intents are
> > > ready for the next merge window, i.e. reviewed&tested and all that.
> > > Not for in-flight stuff still under discussion.
> >
> > I think you're confusing the documentation patch with the drm_hwcompose=
r one (this one).
>=20
> Indeed. And yes everything even RFC. Gitlab even has some special
> support for work in progress, just start your pull request summary
> with WIP.
> -Daniel
>
Thanks, I have created a merge request now. I wasnot sure initially
how the review process worked for gitlab projects.=20
> >
> > Best regards,
> > Liviu
> >
> > > -Daniel
> > >
> > >
> > > > Best regards,
> > > > Liviu
> > > >
> > > > >
> > > > > Cheers, Daniel
> > > > >
> > > > > > ---
> > > > > >  platformdrmgeneric.cpp | 42 ++++++++++++++++++++++++++++++++++=
++++++++
> > > > > >  platformdrmgeneric.h   |  2 ++
> > > > > >  platformhisi.cpp       | 14 ++++++++++++--
> > > > > >  3 files changed, 56 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/platformdrmgeneric.cpp b/platformdrmgeneric.cpp
> > > > > > index 503c04a..a520224 100644
> > > > > > --- a/platformdrmgeneric.cpp
> > > > > > +++ b/platformdrmgeneric.cpp
> > > > > > @@ -18,6 +18,7 @@
> > > > > >
> > > > > >  #include "platformdrmgeneric.h"
> > > > > >  #include "drmdevice.h"
> > > > > > +#include "mali_gralloc_formats.h"
> > > > > >  #include "platform.h"
> > > > > >
> > > > > >  #include <drm/drm_fourcc.h>
> > > > > > @@ -83,6 +84,31 @@ uint32_t DrmGenericImporter::ConvertHalForma=
tToDrm(uint32_t hal_format) {
> > > > > >    }
> > > > > >  }
> > > > > >
> > > > > > +uint64_t DrmGenericImporter::ConvertGrallocFormatToDrmModifier=
s(uint64_t flags,
> > > > > > +                                                              =
  bool is_rgb) {
> > > > > > +  uint64_t features =3D 0;
> > > > > > +
> > > > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_BASIC)
> > > > > > +    features |=3D AFBC_FORMAT_MOD_BLOCK_SIZE_16x16;
> > > > > > +
> > > > > > +  if (is_rgb)
> > > > > > +    features |=3D AFBC_FORMAT_MOD_YTR;
> > > > > > +
> > > > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_SPLITBLK)
> > > > > > +    features |=3D (AFBC_FORMAT_MOD_SPLIT | AFBC_FORMAT_MOD_SPA=
RSE);
> > > > > > +
> > > > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_WIDEBLK)
> > > > > > +    features |=3D AFBC_FORMAT_MOD_BLOCK_SIZE_32x8;
> > > > > > +
> > > > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_TILED_HEADERS)
> > > > > > +    features |=3D AFBC_FORMAT_MOD_TILED;
> > > > > > +
> > > > > > +  if (features)
> > > > > > +    return DRM_FORMAT_MOD_ARM_AFBC(features);
> > > > > > +  else
> > > > > > +    return 0;
> > > > > > +}
> > > > > > +
> > > > > >  uint32_t DrmGenericImporter::DrmFormatToBitsPerPixel(uint32_t =
drm_format) {
> > > > > >    switch (drm_format) {
> > > > > >      case DRM_FORMAT_ARGB8888:
> > > > > > @@ -101,6 +127,22 @@ uint32_t DrmGenericImporter::DrmFormatToBi=
tsPerPixel(uint32_t drm_format) {
> > > > > >    }
> > > > > >  }
> > > > > >
> > > > > > +bool DrmGenericImporter::IsDrmFormatRgb(uint32_t drm_format) {
> > > > > > +  switch (drm_format) {
> > > > > > +    case DRM_FORMAT_ARGB8888:
> > > > > > +    case DRM_FORMAT_XBGR8888:
> > > > > > +    case DRM_FORMAT_ABGR8888:
> > > > > > +    case DRM_FORMAT_BGR888:
> > > > > > +    case DRM_FORMAT_BGR565:
> > > > > > +      return true;
> > > > > > +    case DRM_FORMAT_YVU420:
> > > > > > +      return false;
> > > > > > +    default:
> > > > > > +      ALOGE("Unsupported format %u assuming rgb?", drm_format)=
;
> > > > > > +      return true;
> > > > > > +  }
> > > > > > +}
> > > > > > +
> > > > > >  int DrmGenericImporter::ImportBuffer(buffer_handle_t handle, h=
wc_drm_bo_t *bo) {
> > > > > >    gralloc_handle_t *gr_handle =3D gralloc_handle(handle);
> > > > > >    if (!gr_handle)
> > > > > > diff --git a/platformdrmgeneric.h b/platformdrmgeneric.h
> > > > > > index 233ba55..43cb618 100644
> > > > > > --- a/platformdrmgeneric.h
> > > > > > +++ b/platformdrmgeneric.h
> > > > > > @@ -36,6 +36,8 @@ class DrmGenericImporter : public Importer {
> > > > > >    bool CanImportBuffer(buffer_handle_t handle) override;
> > > > > >
> > > > > >    uint32_t ConvertHalFormatToDrm(uint32_t hal_format);
> > > > > > +  uint64_t ConvertGrallocFormatToDrmModifiers(uint64_t flags, =
bool is_rgb);
> > > > > > +  bool IsDrmFormatRgb(uint32_t drm_format);
> > > > > >    uint32_t DrmFormatToBitsPerPixel(uint32_t drm_format);
> > > > > >
> > > > > >   private:
> > > > > > diff --git a/platformhisi.cpp b/platformhisi.cpp
> > > > > > index 76fe1e7..1cb7e2c 100644
> > > > > > --- a/platformhisi.cpp
> > > > > > +++ b/platformhisi.cpp
> > > > > > @@ -71,6 +71,9 @@ int HisiImporter::Init() {
> > > > > >  }
> > > > > >
> > > > > >  int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm=
_bo_t *bo) {
> > > > > > +  bool is_rgb;
> > > > > > +  uint64_t modifiers[4] =3D {0};
> > > > > > +
> > > > > >    memset(bo, 0, sizeof(hwc_drm_bo_t));
> > > > > >
> > > > > >    private_handle_t const *hnd =3D reinterpret_cast<private_han=
dle_t const *>(
> > > > > > @@ -94,6 +97,10 @@ int HisiImporter::ImportBuffer(buffer_handle=
_t handle, hwc_drm_bo_t *bo) {
> > > > > >    if (fmt < 0)
> > > > > >      return fmt;
> > > > > >
> > > > > > +  is_rgb =3D IsDrmFormatRgb(fmt);
> > > > > > +  modifiers[0] =3D ConvertGrallocFormatToDrmModifiers(hnd->int=
ernal_format,
> > > > > > +                                                    is_rgb);
> > > > > > +
> > > > > >    bo->width =3D hnd->width;
> > > > > >    bo->height =3D hnd->height;
> > > > > >    bo->hal_format =3D hnd->req_format;
> > > > > > @@ -129,8 +136,11 @@ int HisiImporter::ImportBuffer(buffer_hand=
le_t handle, hwc_drm_bo_t *bo) {
> > > > > >        break;
> > > > > >    }
> > > > > >
> > > > > > -  ret =3D drmModeAddFB2(drm_->fd(), bo->width, bo->height, bo-=
>format,
> > > > > > -                      bo->gem_handles, bo->pitches, bo->offset=
s, &bo->fb_id, 0);
> > > > > > +  ret =3D drmModeAddFB2WithModifiers(drm_->fd(), bo->width, bo=
->height,
> > > > > > +                                   bo->format, bo->gem_handles=
, bo->pitches,
> > > > > > +                                   bo->offsets, modifiers, &bo=
->fb_id,
> > > > > > +                                   modifiers[0] ? DRM_MODE_FB_=
MODIFIERS : 0);
> > > > > > +
> > > > > >    if (ret) {
> > > > > >      ALOGE("could not create drm fb %d", ret);
> > > > > >      return ret;
> > > > > > --
> > > > > > 2.7.4
> > > > > >
> > > > > > _______________________________________________
> > > > > > dri-devel mailing list
> > > > > > dri-devel@lists.freedesktop.org
> > > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
> > > >
> > > > --
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > | I would like to |
> > > > | fix the world,  |
> > > > | but they're not |
> > > > | giving me the   |
> > > >  \ source code!  /
> > > >   ---------------
> > > >     ??\_(???)_/??
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >
> > --
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ??\_(???)_/??
>=20
>=20
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
