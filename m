Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6E220656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZFEqp8GX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfAON3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:29:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39491 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAON3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:29:32 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so2024475iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HbH/HSzCh+wO1CR1BL7abX5BL1gZnkvMr1Jxw3jF/Ug=;
        b=ZFEqp8GXNgVrS9pn8GfY03GrbVqyaD5iEEmrxxC7ZsS9PHwUVPf8m/nxfgbloRC/PR
         4gFOn0es6/mThMd69N0J9EBO+jPt7YXpJmNYlfmSYZFTmNEGaOOJbogo4azK66ul3bHX
         PpnNMRWy4uVTyAS41/YGGSrbuW7YQKPZgtygU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HbH/HSzCh+wO1CR1BL7abX5BL1gZnkvMr1Jxw3jF/Ug=;
        b=Y9LYbmWkq0gzQDrMyhdOgbln2Pe7e+gDK0D/v33RKncVcYpmeJIfWePTzXRlGCDeWV
         xXFm4w5C/RCx7CMpQpaAxZD7NFuDBPG+j/UWZslBNFfz+P6nDzmpWYY6umLhatvSJ2vY
         MMuAXGdcdZVU9SgLfMUAyEsa2eVQAnwTnDxUdIbgQiXBLMY5HoYFrjYoi5BvkC/1eiAq
         7lK2hXfO3pDCEc2TRzldGZMrCBWmbp1MXJABdeA+TAHvfx1oDalFvBWL5H+jz23Lh0Lq
         S3ZiEa1jDvZ4BvHNTU1n419IdovuZybEIJj5WwVjmbVrkGfkfHwkO+Sdi+Izc3rY3VBQ
         Tshg==
X-Gm-Message-State: AJcUukeWhMz3b5QqCBcymBX9SYClJcsC/NKkBNrla7V33s00xTma1bE+
        w/eCJK9ngiAfxqG3nrl7yLl6/ucWocZ8TDaVFWspTw==
X-Google-Smtp-Source: ALg8bN70TNNzpcps1G2gmkHACrU5IBdlGCHZyDirJOwFxzhToGDO7Iib47vw2vBkwE2jzcY2KlQUkJgQPLYhKASy0WY=
X-Received: by 2002:a5d:959a:: with SMTP id a26mr1966093ioo.278.1547558971393;
 Tue, 15 Jan 2019 05:29:31 -0800 (PST)
MIME-Version: 1.0
References: <1547479696-14376-1-git-send-email-ayan.halder@arm.com>
 <20190115120547.GL10517@phenom.ffwll.local> <20190115122418.GS20661@e110455-lin.cambridge.arm.com>
 <CAKMK7uHW=PafGQdcT7HykwSRMtVJ_zufdgBk2O6pVxSxk9CCyg@mail.gmail.com> <20190115132703.GT20661@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190115132703.GT20661@e110455-lin.cambridge.arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 15 Jan 2019 14:29:19 +0100
Message-ID: <CAKMK7uGz2Y+wc6dydmEfzB0trwmCV51uv495o7H0V4kCBwXDhg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] drm_hwcomposer: Add support for Arm Framebuffer
 Compression (AFBC) modifiers.
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Ayan Halder <Ayan.Halder@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "seanpaul@google.com" <seanpaul@google.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 2:27 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> On Tue, Jan 15, 2019 at 01:38:19PM +0100, Daniel Vetter wrote:
> > On Tue, Jan 15, 2019 at 1:24 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote=
:
> > >
> > > On Tue, Jan 15, 2019 at 01:05:47PM +0100, Daniel Vetter wrote:
> > > > On Mon, Jan 14, 2019 at 03:28:27PM +0000, Ayan Halder wrote:
> > > > > One needs to translate the Gralloc buffer flags for AFBC (eg
> > > > > MALI_GRALLOC_INTFMT_AFBC_BASIC) to the corresponding linux kernel=
 drm modifiers.
> > > > > This gets passed to libdrm via drmModeAddFB2WithModifiers.
> > > > >
> > > > > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > > > >
> > > > > /-- Note for reviewer
> > > > > I was able to get this working for Android P on Juno with Mali DP=
650 and Mali
> > > > > T860 gpu(with some additional hacks). I have not yet validated th=
is hikey960.
> > > > >
> > > > > I have used the following components:-
> > > > > 1. Gralloc (from https://android.googlesource.com/device/linaro/h=
ikey/+/master/gralloc960)
> > > > >   - Built with MALI_MMSS=3D1
> > > > > 2. Libdrm (from git://anongit.freedesktop.org/mesa/drm)
> > > > >   - You would need drm_fourcc.h and gralloc_handle.h
> > > > > --/
> > > >
> > > > I thought drm_hwcomposer has switched over to gitlab merge requests=
?
> > > > README at least says so:
> > > >
> > > > https://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer
> > >
> > > So are we to send pull requests for RFCs as well?
> >
> > Hm, not sure you should stuff RFC material into your linux-next
> > branches. I thought that's only for patches which by all intents are
> > ready for the next merge window, i.e. reviewed&tested and all that.
> > Not for in-flight stuff still under discussion.
>
> I think you're confusing the documentation patch with the drm_hwcomposer =
one (this one).

Indeed. And yes everything even RFC. Gitlab even has some special
support for work in progress, just start your pull request summary
with WIP.
-Daniel

>
> Best regards,
> Liviu
>
> > -Daniel
> >
> >
> > > Best regards,
> > > Liviu
> > >
> > > >
> > > > Cheers, Daniel
> > > >
> > > > > ---
> > > > >  platformdrmgeneric.cpp | 42 ++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  platformdrmgeneric.h   |  2 ++
> > > > >  platformhisi.cpp       | 14 ++++++++++++--
> > > > >  3 files changed, 56 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/platformdrmgeneric.cpp b/platformdrmgeneric.cpp
> > > > > index 503c04a..a520224 100644
> > > > > --- a/platformdrmgeneric.cpp
> > > > > +++ b/platformdrmgeneric.cpp
> > > > > @@ -18,6 +18,7 @@
> > > > >
> > > > >  #include "platformdrmgeneric.h"
> > > > >  #include "drmdevice.h"
> > > > > +#include "mali_gralloc_formats.h"
> > > > >  #include "platform.h"
> > > > >
> > > > >  #include <drm/drm_fourcc.h>
> > > > > @@ -83,6 +84,31 @@ uint32_t DrmGenericImporter::ConvertHalFormatT=
oDrm(uint32_t hal_format) {
> > > > >    }
> > > > >  }
> > > > >
> > > > > +uint64_t DrmGenericImporter::ConvertGrallocFormatToDrmModifiers(=
uint64_t flags,
> > > > > +                                                                =
bool is_rgb) {
> > > > > +  uint64_t features =3D 0;
> > > > > +
> > > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_BASIC)
> > > > > +    features |=3D AFBC_FORMAT_MOD_BLOCK_SIZE_16x16;
> > > > > +
> > > > > +  if (is_rgb)
> > > > > +    features |=3D AFBC_FORMAT_MOD_YTR;
> > > > > +
> > > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_SPLITBLK)
> > > > > +    features |=3D (AFBC_FORMAT_MOD_SPLIT | AFBC_FORMAT_MOD_SPARS=
E);
> > > > > +
> > > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_WIDEBLK)
> > > > > +    features |=3D AFBC_FORMAT_MOD_BLOCK_SIZE_32x8;
> > > > > +
> > > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_TILED_HEADERS)
> > > > > +    features |=3D AFBC_FORMAT_MOD_TILED;
> > > > > +
> > > > > +  if (features)
> > > > > +    return DRM_FORMAT_MOD_ARM_AFBC(features);
> > > > > +  else
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >  uint32_t DrmGenericImporter::DrmFormatToBitsPerPixel(uint32_t dr=
m_format) {
> > > > >    switch (drm_format) {
> > > > >      case DRM_FORMAT_ARGB8888:
> > > > > @@ -101,6 +127,22 @@ uint32_t DrmGenericImporter::DrmFormatToBits=
PerPixel(uint32_t drm_format) {
> > > > >    }
> > > > >  }
> > > > >
> > > > > +bool DrmGenericImporter::IsDrmFormatRgb(uint32_t drm_format) {
> > > > > +  switch (drm_format) {
> > > > > +    case DRM_FORMAT_ARGB8888:
> > > > > +    case DRM_FORMAT_XBGR8888:
> > > > > +    case DRM_FORMAT_ABGR8888:
> > > > > +    case DRM_FORMAT_BGR888:
> > > > > +    case DRM_FORMAT_BGR565:
> > > > > +      return true;
> > > > > +    case DRM_FORMAT_YVU420:
> > > > > +      return false;
> > > > > +    default:
> > > > > +      ALOGE("Unsupported format %u assuming rgb?", drm_format);
> > > > > +      return true;
> > > > > +  }
> > > > > +}
> > > > > +
> > > > >  int DrmGenericImporter::ImportBuffer(buffer_handle_t handle, hwc=
_drm_bo_t *bo) {
> > > > >    gralloc_handle_t *gr_handle =3D gralloc_handle(handle);
> > > > >    if (!gr_handle)
> > > > > diff --git a/platformdrmgeneric.h b/platformdrmgeneric.h
> > > > > index 233ba55..43cb618 100644
> > > > > --- a/platformdrmgeneric.h
> > > > > +++ b/platformdrmgeneric.h
> > > > > @@ -36,6 +36,8 @@ class DrmGenericImporter : public Importer {
> > > > >    bool CanImportBuffer(buffer_handle_t handle) override;
> > > > >
> > > > >    uint32_t ConvertHalFormatToDrm(uint32_t hal_format);
> > > > > +  uint64_t ConvertGrallocFormatToDrmModifiers(uint64_t flags, bo=
ol is_rgb);
> > > > > +  bool IsDrmFormatRgb(uint32_t drm_format);
> > > > >    uint32_t DrmFormatToBitsPerPixel(uint32_t drm_format);
> > > > >
> > > > >   private:
> > > > > diff --git a/platformhisi.cpp b/platformhisi.cpp
> > > > > index 76fe1e7..1cb7e2c 100644
> > > > > --- a/platformhisi.cpp
> > > > > +++ b/platformhisi.cpp
> > > > > @@ -71,6 +71,9 @@ int HisiImporter::Init() {
> > > > >  }
> > > > >
> > > > >  int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_b=
o_t *bo) {
> > > > > +  bool is_rgb;
> > > > > +  uint64_t modifiers[4] =3D {0};
> > > > > +
> > > > >    memset(bo, 0, sizeof(hwc_drm_bo_t));
> > > > >
> > > > >    private_handle_t const *hnd =3D reinterpret_cast<private_handl=
e_t const *>(
> > > > > @@ -94,6 +97,10 @@ int HisiImporter::ImportBuffer(buffer_handle_t=
 handle, hwc_drm_bo_t *bo) {
> > > > >    if (fmt < 0)
> > > > >      return fmt;
> > > > >
> > > > > +  is_rgb =3D IsDrmFormatRgb(fmt);
> > > > > +  modifiers[0] =3D ConvertGrallocFormatToDrmModifiers(hnd->inter=
nal_format,
> > > > > +                                                    is_rgb);
> > > > > +
> > > > >    bo->width =3D hnd->width;
> > > > >    bo->height =3D hnd->height;
> > > > >    bo->hal_format =3D hnd->req_format;
> > > > > @@ -129,8 +136,11 @@ int HisiImporter::ImportBuffer(buffer_handle=
_t handle, hwc_drm_bo_t *bo) {
> > > > >        break;
> > > > >    }
> > > > >
> > > > > -  ret =3D drmModeAddFB2(drm_->fd(), bo->width, bo->height, bo->f=
ormat,
> > > > > -                      bo->gem_handles, bo->pitches, bo->offsets,=
 &bo->fb_id, 0);
> > > > > +  ret =3D drmModeAddFB2WithModifiers(drm_->fd(), bo->width, bo->=
height,
> > > > > +                                   bo->format, bo->gem_handles, =
bo->pitches,
> > > > > +                                   bo->offsets, modifiers, &bo->=
fb_id,
> > > > > +                                   modifiers[0] ? DRM_MODE_FB_MO=
DIFIERS : 0);
> > > > > +
> > > > >    if (ret) {
> > > > >      ALOGE("could not create drm fb %d", ret);
> > > > >      return ret;
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> > >
> > > --
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > | I would like to |
> > > | fix the world,  |
> > > | but they're not |
> > > | giving me the   |
> > >  \ source code!  /
> > >   ---------------
> > >     =C2=AF\_(=E3=83=84)_/=C2=AF
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
