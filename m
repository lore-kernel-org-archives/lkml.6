Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF97C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8372087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IE2PkBb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8372087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeILXaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:30:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43635 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeILXaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:30:21 -0400
Received: by mail-io1-f67.google.com with SMTP id y10-v6so990865ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yXagAwz9OXVwf8OLa0QMx8bn7g+AHYF3HAHmvVSJz0w=;
        b=IE2PkBb7J4GIuU39S2Eol2RXr6jxrArRZBNPI0JKdBNpmbIyS+MfSSQHlDEKt6FGf2
         ecG8+YPAPFqXsPcyxFRBTigoKFIP2o7U1nXk7XZlXpdcethh19t+Ac/jA3dJPd9yf6fm
         PdVBmnT3PVjeP8EforyHyl8AK2msEnwI65Q+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yXagAwz9OXVwf8OLa0QMx8bn7g+AHYF3HAHmvVSJz0w=;
        b=Z/TqytGM33Raq5CtUl+lM/Jn6ScsBrjFe4eMxjEzvn7d/8pGOMAkyIibOvEY9m86Al
         yLiysFZEiVs0A9K4YfPerPx9OA2zoaCn0+N69I5+xYEDTHw5R9nen4VbXiYNBPrGWi7Y
         U/GYqdo4hqlvJx+2dGYRoycDiDk2m5Ud8hfUxr5VIQrwMShKiqCuXEHt/CG76FUhYgcr
         uEqd11sysa1XwPbJm4/MSwQleWIscyZXd0ceG2F+wJRsBDz6trxv+Uj2B4qJeCZhSTHM
         1ddSfyFlCTuw/pdhtnZ+J7nu4n7bYcZ7zrMxOQp3M4DlESeKd6AFbKn5QgzSqEssAoYL
         nWiw==
X-Gm-Message-State: APzg51DVsNZqCbEN6bmh3AZfA/P2up7/HQZxCIcwMjflJA5YAyq9GGkJ
        3GdR5w/DvZtitmOdcm0pAPNBZpVk2DnF3ih5AX/fTw==
X-Google-Smtp-Source: ANB0VdYuAcP9glj9GqsHRg6fqGpaPfjG+/9uVnDruOBkndrgio53vzbQDTkGKPLi7cClgyFs9cErFJED/3Q8nNRuw40=
X-Received: by 2002:a6b:3a0b:: with SMTP id h11-v6mr2953062ioa.278.1536776676304;
 Wed, 12 Sep 2018 11:24:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bf05:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 11:24:35
 -0700 (PDT)
X-Originating-IP: [2a02:168:569e:0:3106:d637:d723:e855]
In-Reply-To: <20180912152704.GF936@e110455-lin.cambridge.arm.com>
References: <20180823152343.6474-1-brian.starkey@arm.com> <20180823152343.6474-2-brian.starkey@arm.com>
 <20180831081730.GM21634@phenom.ffwll.local> <20180907124535.GA3461@DESKTOP-E1NTVVP.localdomain>
 <20180907192626.GA7176@phenom.ffwll.local> <20180910085003.GA36@DESKTOP-E1NTVVP.localdomain>
 <20180910195325.GC19774@phenom.ffwll.local> <20180912152704.GF936@e110455-lin.cambridge.arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 12 Sep 2018 20:24:35 +0200
X-Google-Sender-Auth: 3_7568geInDjOXAMDbXZnArzXQI
Message-ID: <CAKMK7uGzPFzvgQ-4HHGUkumARjfVdYRSPiwfrAxzQWbVR27NcQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] drm/fourcc: Add 'bpp' field for formats with
 non-integer bytes-per-pixel
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Stone <daniel@fooishbar.org>,
        Dave Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Ayan Kumar Halder <ayan.halder@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 5:27 PM, Liviu Dudau <liviu.dudau@arm.com> wrote:
> On Mon, Sep 10, 2018 at 09:53:25PM +0200, Daniel Vetter wrote:
>> On Mon, Sep 10, 2018 at 09:50:03AM +0100, Brian Starkey wrote:
>> > Hi,
>> >
>> > On Fri, Sep 07, 2018 at 09:28:44PM +0200, Daniel Vetter wrote:
>> > > On Fri, Sep 07, 2018 at 01:45:36PM +0100, Brian Starkey wrote:
>> > > > Hi Daniel,
>> > > >
>> > > > On Fri, Aug 31, 2018 at 10:17:30AM +0200, Daniel Vetter wrote:
>> > > > > On Thu, Aug 23, 2018 at 04:23:41PM +0100, Brian Starkey wrote:
>> > > > > > Some formats have a non-integer number of bytes per pixel, whi=
ch can't
>> > > > > > be handled with the existing 'cpp' field in drm_format_info. T=
o handle
>> > > > > > these formats, add a 'bpp' field, which is only used if cpp[0]=
 =3D=3D 0.
>> > > > > >
>> > > > > > This updates all the users of format->cpp in the core DRM code=
,
>> > > > > > converting them to use a new function to get the bits-per-pixe=
l for any
>> > > > > > format.
>> > > > > >
>> > > > > > It's assumed that drivers will use the 'bpp' field when they a=
dd support
>> > > > > > for pixel formats with non-integer bytes-per-pixel.
>> > > > > >
>> > > > > > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
>> > > > >
>> > > > > I assume you still require that stuff is eventually aligned to b=
ytes? In
>> > > > > that case, can we subsume this into the tile work Alex is doing?=
 It's
>> > > > > essentially just another special case of having storage-size uni=
ts
>> > > > > measured in bytes which span more than 1x1 pixel. And I kinda do=
n't want a
>> > > > > metric pile of special cases here in the format code, because th=
at just
>> > > > > means every driver handles a different subset, with different bu=
gs.
>> > > > > -Daniel
>> > > >
>> > > > Sorry for the delay, been struggling to free some cycles to think
>> > > > about this.
>> > > >
>> > > > I'm not sure how to pull this in with the tiling stuff. In the AFB=
C
>> > > > case then our AFBC superblocks are always nice round numbers (256
>> > > > pixels), and so it does end up being a multiple of bytes.
>> > > >
>> > > > However, AFBC supports different superblock sizes, so picking just=
 one
>> > > > doesn't really work out, and putting AFBC in the core format table
>> > > > which reflects AFBC doesn't seem good.
>> > > >
>> > > > We could make something up (e.g. call these formats "tiled" with 2=
x4
>> > > > tiles, which guarantees a multiple of 8), but it would be an
>> > > > arbitrarily-selected lie, which often seems to spell trouble. If w=
e
>> > > > did do that, would you re-define cpp as "bytes-per-tile"? Otherwis=
e
>> > > > we still need to add a new field anyway.
>> > > >
>> > > > What's the pile of special cases you're worried about? The helper =
I've
>> > > > added here means that drivers which need to care can use one API a=
nd
>> > > > not implement their own bugs.
>> > >
>> > > I'm confused ... the new bits-per-pixel stuff you're adding here is =
for
>> > > yuv formats, not afbc. I'm just suggesting we have only 1 way of
>> > > describing such formats that need more descriptive power than cpp, w=
hether
>> > > they have some kind of pixel-groups or small tiles.
>> >
>> > Well, not really. The three formats which have non-integer cpp are:
>> > DRM_FORMAT_VUY101010, DRM_FORMAT_YUV420_8BIT and
>> > DRM_FORMAT_YUV420_10BIT. These formats are only valid with non-linear
>> > modifiers (no linear encoding is defined). Mali only supports them
>> > with AFBC.
>> >
>> > The formats themselves have no notion of tiling or grouping - the
>> > modifier adds that. I'm not aware of any non-AFBC uses of these
>> > formats, so I don't want to "make up" a small-tile layout restriction
>> > for them.
>>
>> Ah, I missed that.
>>
>> > > For very special stuff like afbc you need to validate in the driver
>> > > anyway, too complicated. So I have no idea why you bring this up her=
e?
>> >
>> > Sure, we can just let drivers provide their own format_info's for
>> > these, if that's what you prefer. The core format checking code can
>> > error out if it ever encounters them.
>>
>> It's format_info we're talking about. What I mean is that you just set a=
ll
>> these to 0 and let the format_info code ignore it. And then having a
>> bespoke drm_format_check_afbc helper function or similar, which checks a=
ll
>> the layout restrictions of afbc.
>>
>> I still maintain that bpp and tile_size are equavalent, and we really
>> don't need both. Both are defacto a form of numerator/denumerator. If yo=
u
>> don't like that you have to introduce "fake" tiles for afbc, then we can
>> rename tile_size to numerator and tile_h/w to denumerator_h/w. Doesn't
>> change one bit of the math. bpp simply hardcodes a denumerator of 8, and=
 I
>> don't see why we need that special case. Except if you love to write
>> redundant self tests for all the math :-)
>
> My $.02 worth of thoughts:
>
> I get the fact that Daniel doesn't like us to add 3 new variables into
> format_info (bpp, tile_w, tile_h) and that adding a "bits_per_unit"
> variable should be able to take care of linear (where unit =3D 1 pixel)
> and tiled (where unit =3D tile_w * tile_h pixels) formats. And I also see
> Daniel's option 2 below, where he says it is reasonable to check AFBC
> without using format_info.
>
> However, the problem we are trying to solve is 2 fold: we are trying to
> calculate the size of the framebuffer (and the "bits_per_unit" or
> Brian's bpp is useful for that), but we also try to validate the sizes
> passed by userspace based on the drm_fourcc.h+modifier info. In that
> case, the driver still needs to store somewhere the tile_w/tile_h for
> that given format in order to check that the stride is a whole multiple
> of tile sizes, so we thought that putting it in format_info is not
> entirely pointless, because others might use those variables in order to
> do their driver specific validation, without creating new structures.
>
> Did I capture the discussion correctly? If so, can we agree that it is
> not just the framebuffer size calculation that matters and that tiled
> formats validation requires a tile_w/tile_h info, therefore Alex's
> patches and Brian's need to be discussed separately (so that we can
> bikeshed on whether format_info is the right place or not)?

I dont think this captures the gist of what I have in mind. I've laid
out the math in another reply. What I don't want is to add bpp and
tile_size/h/w, because that's redundant, and you can express any bpp
value in terms of tile_size/w. We should probably also throw out cpp,
but that's a bit more involved (well, just need a wrapper to compute
cpp and then a cocci script and done).
-Daniel

> Best regards,
> Liviu
>
>>
>> So two options that I think are reasonable:
>> - one common numerator/denumerator. I don't care how you call that
>>   bikeshed.
>> - don't check afbc using format_info, have your own helper that does tha=
t
>>   using custom code.
>>
>> Cheers, Daniel
>>
>> > Cheers,
>> > -Brian
>> >
>> > > -Daniel
>> > >
>> > > >
>> > > > Cheers,
>> > > > -Brian
>> > > >
>> > > > >
>> > > > > > ---
>> > > > > >  drivers/gpu/drm/drm_fb_cma_helper.c          |  6 +++-
>> > > > > >  drivers/gpu/drm/drm_fb_helper.c              |  8 +++--
>> > > > > >  drivers/gpu/drm/drm_fourcc.c                 | 50 +++++++++++=
+++++++++++++++++
>> > > > > >  drivers/gpu/drm/drm_framebuffer.c            |  8 ++---
>> > > > > >  drivers/gpu/drm/drm_gem_framebuffer_helper.c |  3 +-
>> > > > > >  include/drm/drm_fourcc.h                     |  4 +++
>> > > > > >  6 files changed, 70 insertions(+), 9 deletions(-)
>> > > > > >
>> > > > > > diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu=
/drm/drm_fb_cma_helper.c
>> > > > > > index 186d00adfb5f..e279d70d3e60 100644
>> > > > > > --- a/drivers/gpu/drm/drm_fb_cma_helper.c
>> > > > > > +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
>> > > > > > @@ -118,13 +118,17 @@ dma_addr_t drm_fb_cma_get_gem_addr(struc=
t drm_framebuffer *fb,
>> > > > > >  {
>> > > > > >     struct drm_gem_cma_object *obj;
>> > > > > >     dma_addr_t paddr;
>> > > > > > +   u8 bpp =3D drm_format_info_plane_bpp(fb->format, plane);
>> > > > > > +
>> > > > > > +   /* This can't work for non-integer bytes-per-pixel */
>> > > > > > +   WARN_ON(bpp % 8);
>> > > > > >
>> > > > > >     obj =3D drm_fb_cma_get_gem_obj(fb, plane);
>> > > > > >     if (!obj)
>> > > > > >             return 0;
>> > > > > >
>> > > > > >     paddr =3D obj->paddr + fb->offsets[plane];
>> > > > > > -   paddr +=3D fb->format->cpp[plane] * (state->src_x >> 16);
>> > > > > > +   paddr +=3D (bpp / 8) * (state->src_x >> 16);
>> > > > > >     paddr +=3D fb->pitches[plane] * (state->src_y >> 16);
>> > > > > >
>> > > > > >     return paddr;
>> > > > > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm=
/drm_fb_helper.c
>> > > > > > index 0646b108030b..ab369f250af4 100644
>> > > > > > --- a/drivers/gpu/drm/drm_fb_helper.c
>> > > > > > +++ b/drivers/gpu/drm/drm_fb_helper.c
>> > > > > > @@ -1572,6 +1572,7 @@ int drm_fb_helper_check_var(struct fb_va=
r_screeninfo *var,
>> > > > > >     struct drm_fb_helper *fb_helper =3D info->par;
>> > > > > >     struct drm_framebuffer *fb =3D fb_helper->fb;
>> > > > > >     int depth;
>> > > > > > +   u8 bpp =3D drm_format_info_plane_bpp(fb->format, 0);
>> > > > > >
>> > > > > >     if (var->pixclock !=3D 0 || in_dbg_master())
>> > > > > >             return -EINVAL;
>> > > > > > @@ -1580,14 +1581,14 @@ int drm_fb_helper_check_var(struct fb_=
var_screeninfo *var,
>> > > > > >      * Changes struct fb_var_screeninfo are currently not push=
ed back
>> > > > > >      * to KMS, hence fail if different settings are requested.
>> > > > > >      */
>> > > > > > -   if (var->bits_per_pixel !=3D fb->format->cpp[0] * 8 ||
>> > > > > > +   if (var->bits_per_pixel !=3D bpp ||
>> > > > > >         var->xres > fb->width || var->yres > fb->height ||
>> > > > > >         var->xres_virtual > fb->width || var->yres_virtual > f=
b->height) {
>> > > > > >             DRM_DEBUG("fb requested width/height/bpp can't fit=
 in current fb "
>> > > > > >                       "request %dx%d-%d (virtual %dx%d) > %dx%=
d-%d\n",
>> > > > > >                       var->xres, var->yres, var->bits_per_pixe=
l,
>> > > > > >                       var->xres_virtual, var->yres_virtual,
>> > > > > > -                     fb->width, fb->height, fb->format->cpp[0=
] * 8);
>> > > > > > +                     fb->width, fb->height, bpp);
>> > > > > >             return -EINVAL;
>> > > > > >     }
>> > > > > >
>> > > > > > @@ -1949,11 +1950,12 @@ void drm_fb_helper_fill_var(struct fb_=
info *info, struct drm_fb_helper *fb_helpe
>> > > > > >                         uint32_t fb_width, uint32_t fb_height)
>> > > > > >  {
>> > > > > >     struct drm_framebuffer *fb =3D fb_helper->fb;
>> > > > > > +   u8 bpp =3D drm_format_info_plane_bpp(fb->format, 0);
>> > > > > >
>> > > > > >     info->pseudo_palette =3D fb_helper->pseudo_palette;
>> > > > > >     info->var.xres_virtual =3D fb->width;
>> > > > > >     info->var.yres_virtual =3D fb->height;
>> > > > > > -   info->var.bits_per_pixel =3D fb->format->cpp[0] * 8;
>> > > > > > +   info->var.bits_per_pixel =3D bpp;
>> > > > > >     info->var.accel_flags =3D FB_ACCELF_TEXT;
>> > > > > >     info->var.xoffset =3D 0;
>> > > > > >     info->var.yoffset =3D 0;
>> > > > > > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/dr=
m_fourcc.c
>> > > > > > index 3b42c25bd58d..bb28919c32f3 100644
>> > > > > > --- a/drivers/gpu/drm/drm_fourcc.c
>> > > > > > +++ b/drivers/gpu/drm/drm_fourcc.c
>> > > > > > @@ -272,10 +272,60 @@ int drm_format_plane_cpp(uint32_t format=
, int plane)
>> > > > > >     if (!info || plane >=3D info->num_planes)
>> > > > > >             return 0;
>> > > > > >
>> > > > > > +   /*
>> > > > > > +    * Not valid for formats with non-integer cpp,
>> > > > > > +    * use drm_format{_info}_plane_bpp instead
>> > > > > > +    */
>> > > > > > +   WARN_ON(!info->cpp[0]);
>> > > > > > +
>> > > > > >     return info->cpp[plane];
>> > > > > >  }
>> > > > > >  EXPORT_SYMBOL(drm_format_plane_cpp);
>> > > > > >
>> > > > > > +/**
>> > > > > > + * drm_format_plane_bpp - determine the bits per pixel value
>> > > > > > + * @format: pixel format (DRM_FORMAT_*)
>> > > > > > + * @plane: plane index
>> > > > > > + *
>> > > > > > + * Returns:
>> > > > > > + * The bits per pixel value for the specified plane.
>> > > > > > + */
>> > > > > > +int drm_format_plane_bpp(uint32_t format, int plane)
>> > > > > > +{
>> > > > > > +   const struct drm_format_info *info;
>> > > > > > +
>> > > > > > +   info =3D drm_format_info(format);
>> > > > > > +   if (!info)
>> > > > > > +           return 0;
>> > > > > > +
>> > > > > > +   return drm_format_info_plane_bpp(info, plane);
>> > > > > > +}
>> > > > > > +EXPORT_SYMBOL(drm_format_plane_bpp);
>> > > > > > +
>> > > > > > +/**
>> > > > > > + * drm_format_info_plane_bpp - determine the bits per pixel v=
alue
>> > > > > > + *
>> > > > > > + * Convenience function which handles formats with both integ=
er
>> > > > > > + * and non-integer bytes-per-pixel.
>> > > > > > + *
>> > > > > > + * @format: pixel format info structure
>> > > > > > + * @plane: plane index
>> > > > > > + *
>> > > > > > + * Returns:
>> > > > > > + * The bits per pixel value for the specified plane.
>> > > > > > + */
>> > > > > > +int drm_format_info_plane_bpp(const struct drm_format_info *i=
nfo, int plane)
>> > > > > > +{
>> > > > > > +   if (plane >=3D info->num_planes)
>> > > > > > +           return 0;
>> > > > > > +
>> > > > > > +   if (info->cpp[0])
>> > > > > > +           return info->cpp[plane] * 8;
>> > > > > > +
>> > > > > > +   return info->bpp[plane];
>> > > > > > +}
>> > > > > > +EXPORT_SYMBOL(drm_format_info_plane_bpp);
>> > > > > > +
>> > > > > >  /**
>> > > > > >   * drm_format_horz_chroma_subsampling - get the horizontal ch=
roma subsampling factor
>> > > > > >   * @format: pixel format (DRM_FORMAT_*)
>> > > > > > diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/d=
rm/drm_framebuffer.c
>> > > > > > index 8c4d32adcc17..7e00360ff70d 100644
>> > > > > > --- a/drivers/gpu/drm/drm_framebuffer.c
>> > > > > > +++ b/drivers/gpu/drm/drm_framebuffer.c
>> > > > > > @@ -185,20 +185,20 @@ static int framebuffer_check(struct drm_=
device *dev,
>> > > > > >     for (i =3D 0; i < info->num_planes; i++) {
>> > > > > >             unsigned int width =3D fb_plane_width(r->width, in=
fo, i);
>> > > > > >             unsigned int height =3D fb_plane_height(r->height,=
 info, i);
>> > > > > > -           unsigned int cpp =3D info->cpp[i];
>> > > > > > +           unsigned int bpp =3D drm_format_info_plane_bpp(inf=
o, i);
>> > > > > >
>> > > > > >             if (!r->handles[i]) {
>> > > > > >                     DRM_DEBUG_KMS("no buffer object handle for=
 plane %d\n", i);
>> > > > > >                     return -EINVAL;
>> > > > > >             }
>> > > > > >
>> > > > > > -           if ((uint64_t) width * cpp > UINT_MAX)
>> > > > > > +           if ((uint64_t) DIV_ROUND_UP(width * bpp, 8) > UINT=
_MAX)
>> > > > > >                     return -ERANGE;
>> > > > > >
>> > > > > >             if ((uint64_t) height * r->pitches[i] + r->offsets=
[i] > UINT_MAX)
>> > > > > >                     return -ERANGE;
>> > > > > >
>> > > > > > -           if (r->pitches[i] < width * cpp) {
>> > > > > > +           if ((uint64_t) r->pitches[i] * 8 < (uint64_t) widt=
h * bpp) {
>> > > > > >                     DRM_DEBUG_KMS("bad pitch %u for plane %d\n=
", r->pitches[i], i);
>> > > > > >                     return -EINVAL;
>> > > > > >             }
>> > > > > > @@ -476,7 +476,7 @@ int drm_mode_getfb(struct drm_device *dev,
>> > > > > >     r->height =3D fb->height;
>> > > > > >     r->width =3D fb->width;
>> > > > > >     r->depth =3D fb->format->depth;
>> > > > > > -   r->bpp =3D fb->format->cpp[0] * 8;
>> > > > > > +   r->bpp =3D drm_format_info_plane_bpp(fb->format, 0);
>> > > > > >     r->pitch =3D fb->pitches[0];
>> > > > > >
>> > > > > >     /* GET_FB() is an unprivileged ioctl so we must not return=
 a
>> > > > > > diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/dr=
ivers/gpu/drm/drm_gem_framebuffer_helper.c
>> > > > > > index acfbc0641a06..dfe224ccaeba 100644
>> > > > > > --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
>> > > > > > +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
>> > > > > > @@ -161,6 +161,7 @@ drm_gem_fb_create_with_funcs(struct drm_de=
vice *dev, struct drm_file *file,
>> > > > > >             unsigned int width =3D mode_cmd->width / (i ? info=
->hsub : 1);
>> > > > > >             unsigned int height =3D mode_cmd->height / (i ? in=
fo->vsub : 1);
>> > > > > >             unsigned int min_size;
>> > > > > > +           u8 bpp =3D drm_format_info_plane_bpp(fb->format, i=
);
>> > > > > >
>> > > > > >             objs[i] =3D drm_gem_object_lookup(file, mode_cmd->=
handles[i]);
>> > > > > >             if (!objs[i]) {
>> > > > > > @@ -170,7 +171,7 @@ drm_gem_fb_create_with_funcs(struct drm_de=
vice *dev, struct drm_file *file,
>> > > > > >             }
>> > > > > >
>> > > > > >             min_size =3D (height - 1) * mode_cmd->pitches[i]
>> > > > > > -                    + width * info->cpp[i]
>> > > > > > +                    + DIV_ROUND_UP(width * bpp, 8)
>> > > > > >                      + mode_cmd->offsets[i];
>> > > > > >
>> > > > > >             if (objs[i]->size < min_size) {
>> > > > > > diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc=
.h
>> > > > > > index 3e86408dac9f..d4af4dab1623 100644
>> > > > > > --- a/include/drm/drm_fourcc.h
>> > > > > > +++ b/include/drm/drm_fourcc.h
>> > > > > > @@ -36,6 +36,7 @@ struct drm_mode_fb_cmd2;
>> > > > > >   * use in new code and set to 0 for new formats.
>> > > > > >   * @num_planes: Number of color planes (1 to 3)
>> > > > > >   * @cpp: Number of bytes per pixel (per plane)
>> > > > > > + * @bpp: Number of bits per pixel (per plane), only valid if =
cpp[0] =3D=3D 0.
>> > > > > >   * @hsub: Horizontal chroma subsampling factor
>> > > > > >   * @vsub: Vertical chroma subsampling factor
>> > > > > >   * @has_alpha: Does the format embeds an alpha component?
>> > > > > > @@ -45,6 +46,7 @@ struct drm_format_info {
>> > > > > >     u8 depth;
>> > > > > >     u8 num_planes;
>> > > > > >     u8 cpp[3];
>> > > > > > +   u8 bpp[3];
>> > > > > >     u8 hsub;
>> > > > > >     u8 vsub;
>> > > > > >     bool has_alpha;
>> > > > > > @@ -66,6 +68,8 @@ drm_get_format_info(struct drm_device *dev,
>> > > > > >  uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t dep=
th);
>> > > > > >  int drm_format_num_planes(uint32_t format);
>> > > > > >  int drm_format_plane_cpp(uint32_t format, int plane);
>> > > > > > +int drm_format_plane_bpp(uint32_t format, int plane);
>> > > > > > +int drm_format_info_plane_bpp(const struct drm_format_info *f=
ormat, int plane);
>> > > > > >  int drm_format_horz_chroma_subsampling(uint32_t format);
>> > > > > >  int drm_format_vert_chroma_subsampling(uint32_t format);
>> > > > > >  int drm_format_plane_width(int width, uint32_t format, int pl=
ane);
>> > > > > > --
>> > > > > > 2.16.1
>> > > > > >
>> > > > >
>> > > > > --
>> > > > > Daniel Vetter
>> > > > > Software Engineer, Intel Corporation
>> > > > > http://blog.ffwll.ch
>> > >
>> > > --
>> > > Daniel Vetter
>> > > Software Engineer, Intel Corporation
>> > > http://blog.ffwll.ch
>> > _______________________________________________
>> > dri-devel mailing list
>> > dri-devel@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
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
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
