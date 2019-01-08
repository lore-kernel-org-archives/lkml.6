Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C1FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B16120827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Nuy5sVBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfAHNkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:40:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40715 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfAHNkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:40:25 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so5960644ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 05:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4onoqCSToNVGrYjRWjlDOAhpaH6n03TQ3sEGHq0EMec=;
        b=Nuy5sVBSyc4JaqS5aRPib2VRu1CBkdw3BDoSWeG0/OdptcMrmvqXA7wBSoTu3qH9vz
         a2RErxagtdEyK0i98dyAM2oPQxpV+esCs4XKD643GHD9cfVrobTU8Z5sHnSweejmoTGR
         O3IQ60dk4rQdJI6kQTUiANRrGn0Pr/p7rXpwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4onoqCSToNVGrYjRWjlDOAhpaH6n03TQ3sEGHq0EMec=;
        b=X1Ns8ZuQpWEuTr3CaigSkrLjMyWqzDjmYO7NinqqU05wOXtfIvyu/Enaq0pcZ74M+4
         RwTz7w2BHEXTifsvR8J9/cX60y9FhtTZTMjSyY5Ly9xRTJzqANIfmWtDPkFE2X1zG6EF
         prPJjq/oFOC0wjOUUSqoy7nQetbNSRgqNOD3XDRAt2dEOEJF/WTZk9qzGYVtz+y2fPSU
         L3jl5V/qngNjNbNCFq/bGNjZjDPP9O9SOZoZOrNe0XyQ2JQt/kLZJP9wr+fY4I+6llbk
         zfEEsFu9fXPbziFSZbrYkd4lqbpbk17KSqE+oW07ZcEfvxsQndT/JkT4PCZ8g/MCAScY
         uy3w==
X-Gm-Message-State: AJcUuke9RsCdmLzXGEQyiQpNSjNHRlF1eh/GPM82t3q98y/dPNpbVuGb
        3ytx0u7AaZP0OO2kTySQ+9r+GrOqNqwc8Vr/cOuhcA==
X-Google-Smtp-Source: ALg8bN42nU0XSQ+Qy7OKjQPHSyEV193sJF2hbZlOMPDgJ3pZ34fhFwYzkuIyDDvn1x8Nktq3Dkf6OBUlKFKV6d1Icoc=
X-Received: by 2002:a24:6115:: with SMTP id s21mr1375166itc.62.1546954823416;
 Tue, 08 Jan 2019 05:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20190102084917.4049-1-frank-w@public-files.de> <20190107103640.GH21184@phenom.ffwll.local>
In-Reply-To: <20190107103640.GH21184@phenom.ffwll.local>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 8 Jan 2019 14:40:12 +0100
Message-ID: <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alexander Ryabchenko <d3adme4t@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 11:36 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jan 02, 2019 at 09:49:17AM +0100, Frank Wunderlich wrote:
> > From: CK Hu <ck.hu@mediatek.com>
> >
> > This patch adds Framebuffer-Driver for Mediatek
> >
> > currently tested on mt7623, maybe works on other platforms
> > MTK-FBDev written by CK Hu and ported from 4.4
> >
> > based on patchset drm/hdmi for 7623 v5 (except last part included in 4.20)
> >   https://patchwork.kernel.org/project/linux-mediatek/list/?series=25989
> >
> > depends on
> >   dts-patch (resend of 5/5, parts 1-4 already in 4.20):
> >     "arm: dts: mt7623: add display subsystem related device nodes"
> >     https://patchwork.kernel.org/patch/10588951/
> >   2 bugfix-patches from bibby hsieh
> >     fix-boot-up-for-720-and-480-but-1080
> >     using-different-round-rate-for-mt7623
> >   1 Patch from Ryder Lee
> >     http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/52
> >
> > full working tree here for reference:
> > https://github.com/frank-w/BPI-R2-4.14/commits/4.20-hdmiv5
> >
> > Signed-off-by: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: Alexander Ryabchenko <d3adme4t@gmail.com>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > Tested-by: Frank Wunderlich <frank-w@public-files.de>
>
> Would be good to use the new generic fbdev emulation code here, for even
> less code. Or at least know why this isn't possible to use for mtk (and
> maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> needed anymore.

Back on the mailing list, no private replies please:

For examples please grep for drm_fbdev_generic_setup(). There's also a
still in-flight series from Gerd Hoffmann to convert over bochs. That,
plus all the kerneldoc linked from there should get you started.
-Daniel


> -Daniel
> > ---
> >  drivers/gpu/drm/mediatek/Makefile        |   1 +
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c   |   6 +
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h   |   4 +
> >  drivers/gpu/drm/mediatek/mtk_drm_fb.c    |  13 ++
> >  drivers/gpu/drm/mediatek/mtk_drm_fb.h    |   3 +
> >  drivers/gpu/drm/mediatek/mtk_drm_fbdev.c | 178 +++++++++++++++++++++++
> >  drivers/gpu/drm/mediatek/mtk_drm_fbdev.h |  25 ++++
> >  7 files changed, 230 insertions(+)
> >  create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
> >  create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
> >
> > diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
> > index 82ae49c64221..d71e57dea77a 100644
> > --- a/drivers/gpu/drm/mediatek/Makefile
> > +++ b/drivers/gpu/drm/mediatek/Makefile
> > @@ -14,6 +14,7 @@ mediatek-drm-y := mtk_disp_color.o \
> >                 mtk_mipi_tx.o \
> >                 mtk_dpi.o
> >
> > +mediatek-drm-$(CONFIG_DRM_FBDEV_EMULATION) += mtk_drm_fbdev.o
> >  obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
> >
> >  mediatek-drm-hdmi-objs := mtk_cec.o \
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index 7800822b4db1..51f1ec3412d3 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -32,6 +32,7 @@
> >  #include "mtk_drm_ddp_comp.h"
> >  #include "mtk_drm_drv.h"
> >  #include "mtk_drm_fb.h"
> > +#include "mtk_drm_fbdev.h"
> >  #include "mtk_drm_gem.h"
> >
> >  #define DRIVER_NAME "mediatek"
> > @@ -299,6 +300,10 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >       drm_kms_helper_poll_init(drm);
> >       drm_mode_config_reset(drm);
> >
> > +     ret = mtk_fbdev_init(drm);
> > +     if (ret)
> > +             goto err_component_unbind;
> > +
> >       return 0;
> >
> >  err_component_unbind:
> > @@ -311,6 +316,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >
> >  static void mtk_drm_kms_deinit(struct drm_device *drm)
> >  {
> > +     mtk_fbdev_fini(drm);
> >       drm_kms_helper_poll_fini(drm);
> >
> >       component_unbind_all(drm->dev, drm);
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > index 256a3ff2e66e..56129a21fb2b 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > @@ -14,6 +14,7 @@
> >  #ifndef MTK_DRM_DRV_H
> >  #define MTK_DRM_DRV_H
> >
> > +#include <drm/drm_fb_helper.h>
> >  #include <linux/io.h>
> >  #include "mtk_drm_ddp_comp.h"
> >
> > @@ -43,6 +44,7 @@ struct mtk_drm_private {
> >       struct drm_device *drm;
> >       struct device *dma_dev;
> >
> > +     struct drm_crtc *crtc[MAX_CRTC];
> >       unsigned int num_pipes;
> >
> >       struct device_node *mutex_node;
> > @@ -59,6 +61,8 @@ struct mtk_drm_private {
> >       } commit;
> >
> >       struct drm_atomic_state *suspend_state;
> > +     struct drm_fb_helper fb_helper;
> > +     struct drm_gem_object *fbdev_bo;
> >  };
> >
> >  extern struct platform_driver mtk_ddp_driver;
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.c b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> > index be5f6f1daf55..7533aa4733d2 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.c
> > @@ -56,6 +56,19 @@ static struct drm_framebuffer *mtk_drm_framebuffer_init(struct drm_device *dev,
> >       return fb;
> >  }
> >
> > +struct drm_framebuffer *mtk_drm_framebuffer_create(struct drm_device *dev,
> > +                                     const struct drm_mode_fb_cmd2 *mode,
> > +                                     struct drm_gem_object *obj)
> > +{
> > +     struct drm_framebuffer *mtk_fb;
> > +
> > +     mtk_fb = mtk_drm_framebuffer_init(dev, mode, obj);
> > +     if (IS_ERR(mtk_fb))
> > +             return ERR_CAST(mtk_fb);
> > +
> > +     return mtk_fb;
> > +}
> > +
> >  /*
> >   * Wait for any exclusive fence in fb's gem object's reservation object.
> >   *
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fb.h b/drivers/gpu/drm/mediatek/mtk_drm_fb.h
> > index 7f976b196a15..e49e015380d0 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_fb.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_fb.h
> > @@ -18,5 +18,8 @@ int mtk_fb_wait(struct drm_framebuffer *fb);
> >  struct drm_framebuffer *mtk_drm_mode_fb_create(struct drm_device *dev,
> >                                              struct drm_file *file,
> >                                              const struct drm_mode_fb_cmd2 *cmd);
> > +struct drm_framebuffer *mtk_drm_framebuffer_create(struct drm_device *dev,
> > +             const struct drm_mode_fb_cmd2 *mode,
> > +             struct drm_gem_object *obj);
> >
> >  #endif /* MTK_DRM_FB_H */
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
> > new file mode 100644
> > index 000000000000..9670f50d1247
> > --- /dev/null
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: CK Hu <ck.hu@mediatek.com>
> > + */
> > +
> > +#include <drm/drmP.h>
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_fb_helper.h>
> > +#include <drm/drm_gem.h>
> > +
> > +#include "mtk_drm_drv.h"
> > +#include "mtk_drm_fb.h"
> > +#include "mtk_drm_gem.h"
> > +#include "mtk_drm_fbdev.h"
> > +
> > +#define to_drm_private(x) \
> > +             container_of(x, struct mtk_drm_private, fb_helper)
> > +
> > +static int mtk_drm_fbdev_mmap(struct fb_info *info, struct vm_area_struct *vma)
> > +{
> > +     struct drm_fb_helper *helper = info->par;
> > +     struct mtk_drm_private *private = to_drm_private(helper);
> > +
> > +     return mtk_drm_gem_mmap_buf(private->fbdev_bo, vma);
> > +}
> > +
> > +static struct fb_ops mtk_fbdev_ops = {
> > +     .owner = THIS_MODULE,
> > +     DRM_FB_HELPER_DEFAULT_OPS,
> > +     .fb_fillrect = drm_fb_helper_cfb_fillrect,
> > +     .fb_copyarea = drm_fb_helper_cfb_copyarea,
> > +     .fb_imageblit = drm_fb_helper_cfb_imageblit,
> > +     .fb_check_var = drm_fb_helper_check_var,
> > +     .fb_set_par = drm_fb_helper_set_par,
> > +     .fb_blank = drm_fb_helper_blank,
> > +     .fb_pan_display = drm_fb_helper_pan_display,
> > +     .fb_setcmap = drm_fb_helper_setcmap,
> > +     .fb_mmap = mtk_drm_fbdev_mmap,
> > +};
> > +
> > +static int mtk_fbdev_probe(struct drm_fb_helper *helper,
> > +                        struct drm_fb_helper_surface_size *sizes)
> > +{
> > +     struct drm_device *dev = helper->dev;
> > +     struct mtk_drm_private *private = to_drm_private(helper);
> > +     struct drm_mode_fb_cmd2 mode = { 0 };
> > +     struct mtk_drm_gem_obj *mtk_gem;
> > +     struct fb_info *info;
> > +     struct drm_framebuffer *fb;
> > +     unsigned int bytes_per_pixel;
> > +     unsigned long offset;
> > +     size_t size;
> > +     int err = 0;
> > +
> > +     bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
> > +
> > +     mode.width = sizes->surface_width;
> > +     mode.height = sizes->surface_height;
> > +     mode.pitches[0] = sizes->surface_width * bytes_per_pixel;
> > +     mode.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
> > +                                                   sizes->surface_depth);
> > +
> > +     size = mode.pitches[0] * mode.height;
> > +
> > +     mtk_gem = mtk_drm_gem_create(dev, size, true);
> > +     if (IS_ERR(mtk_gem))
> > +             return PTR_ERR(mtk_gem);
> > +
> > +     private->fbdev_bo = &mtk_gem->base;
> > +
> > +     info = drm_fb_helper_alloc_fbi(helper);
> > +     if (IS_ERR(info)) {
> > +             DRM_DEV_ERROR(dev->dev,
> > +                     "failed to allocate framebuffer info, %d\n",
> > +                     err);
> > +             err = PTR_ERR(info);
> > +             goto out;
> > +     }
> > +
> > +     fb = mtk_drm_framebuffer_create(dev, &mode, private->fbdev_bo);
> > +     if (IS_ERR(fb)) {
> > +             DRM_DEV_ERROR(dev->dev,
> > +                     "failed to allocate DRM framebuffer, %d\n",
> > +                     err);
> > +             err = PTR_ERR(fb);
> > +             goto out;
> > +     }
> > +     helper->fb = fb;
> > +
> > +     info->par = helper;
> > +     info->flags = FBINFO_FLAG_DEFAULT;
> > +     info->fbops = &mtk_fbdev_ops;
> > +
> > +     drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
> > +     drm_fb_helper_fill_var(info, helper, sizes->fb_width, sizes->fb_height);
> > +
> > +     offset = info->var.xoffset * bytes_per_pixel;
> > +     offset += info->var.yoffset * fb->pitches[0];
> > +
> > +     dev->mode_config.fb_base = 0;
> > +     info->screen_base = mtk_gem->kvaddr + offset;
> > +     info->screen_size = size;
> > +     info->fix.smem_len = size;
> > +
> > +     DRM_DEBUG_KMS("FB [%ux%u]-%u offset=%lu size=%zd\n",
> > +                   fb->width, fb->height, fb->format->depth, offset, size);
> > +
> > +     info->skip_vt_switch = true;
> > +
> > +     return 0;
> > +
> > +out:
> > +
> > +
> > +     mtk_drm_gem_free_object(&mtk_gem->base);
> > +     return err;
> > +}
> > +
> > +static const struct drm_fb_helper_funcs mtk_drm_fb_helper_funcs = {
> > +     .fb_probe = mtk_fbdev_probe,
> > +};
> > +
> > +int mtk_fbdev_init(struct drm_device *dev)
> > +{
> > +     struct mtk_drm_private *priv = dev->dev_private;
> > +     struct drm_fb_helper *helper = &priv->fb_helper;
> > +     int ret;
> > +
> > +     if (!dev->mode_config.num_crtc || !dev->mode_config.num_connector)
> > +             return -EINVAL;
> > +
> > +     drm_fb_helper_prepare(dev, helper, &mtk_drm_fb_helper_funcs);
> > +
> > +     ret = drm_fb_helper_init(dev, helper, dev->mode_config.num_connector);
> > +     if (ret < 0) {
> > +             DRM_DEV_ERROR(dev->dev,
> > +                     "failed to initialize DRM FB helper, %d\n",
> > +                     ret);
> > +//           goto fini;
> > +             return ret;
> > +     }
> > +
> > +     ret = drm_fb_helper_single_add_all_connectors(helper);
> > +     if (ret < 0) {
> > +             DRM_DEV_ERROR(dev->dev, "failed to add connectors, %d\n", ret);
> > +             goto fini;
> > +     }
> > +
> > +     ret = drm_fb_helper_initial_config(helper, 32);
> > +     if (ret < 0) {
> > +             DRM_DEV_ERROR(dev->dev,
> > +                     "failed to set initial configuration, %d\n",
> > +                     ret);
> > +             goto fini;
> > +     }
> > +
> > +     return 0;
> > +
> > +fini:
> > +     drm_fb_helper_fini(helper);
> > +     return ret;
> > +}
> > +
> > +void mtk_fbdev_fini(struct drm_device *dev)
> > +{
> > +     struct mtk_drm_private *priv = dev->dev_private;
> > +     struct drm_fb_helper *helper = &priv->fb_helper;
> > +
> > +     drm_fb_helper_unregister_fbi(helper);
> > +
> > +     if (helper->fb) {
> > +             drm_framebuffer_unregister_private(helper->fb);
> > +             drm_framebuffer_remove(helper->fb);
> > +     }
> > +
> > +     drm_fb_helper_fini(helper);
> > +}
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
> > new file mode 100644
> > index 000000000000..45717b642dc5
> > --- /dev/null
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + * Author: CK Hu <ck.hu@mediatek.com>
> > + */
> > +
> > +#ifndef MTK_DRM_FBDEV_H
> > +#define MTK_DRM_FBDEV_H
> > +
> > +#ifdef CONFIG_DRM_FBDEV_EMULATION
> > +int mtk_fbdev_init(struct drm_device *dev);
> > +void mtk_fbdev_fini(struct drm_device *dev);
> > +#else
> > +int mtk_fbdev_init(struct drm_device *dev)
> > +{
> > +     return 0;
> > +}
> > +
> > +void mtk_fbdev_fini(struct drm_device *dev)
> > +{
> > +
> > +}
> > +#endif /* CONFIG_DRM_FBDEV_EMULATION */
> > +
> > +#endif /* MTK_DRM_FBDEV_H */
> > --
> > 2.17.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
