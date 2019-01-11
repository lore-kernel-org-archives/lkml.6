Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB42C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE55E2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfAKJtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:49:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:13279 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727653AbfAKJtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:49:40 -0500
X-UUID: a5fae8d2157944f0b6d67639d31bc053-20190111
X-UUID: a5fae8d2157944f0b6d67639d31bc053-20190111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1995934108; Fri, 11 Jan 2019 17:49:17 +0800
Received: from MTKMBS06N1.mediatek.inc (172.21.101.129) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 11 Jan 2019 17:49:15 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 11 Jan 2019 17:49:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 17:49:15 +0800
Message-ID: <1547200155.4209.4.camel@mtksdaap41>
Subject: Re: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
From:   CK Hu <ck.hu@mediatek.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Airlie <airlied@linux.ie>,
        "Alexander Ryabchenko" <d3adme4t@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 11 Jan 2019 17:49:15 +0800
In-Reply-To: <20190111092042.GP21184@phenom.ffwll.local>
References: <20190102084917.4049-1-frank-w@public-files.de>
         <20190107103640.GH21184@phenom.ffwll.local>
         <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
         <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
         <20190110200225.GN21184@phenom.ffwll.local>
         <1547176809.12054.11.camel@mtksdaap41>
         <20190111092042.GP21184@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-TM-SNTS-SMTP: 1E9CEC6242F5E7F54DE869B4E28463F81E5E5EEC0BA690C7FEB2B04EB288977C2000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel:

On Fri, 2019-01-11 at 10:20 +0100, Daniel Vetter wrote:
> On Fri, Jan 11, 2019 at 11:20:09AM +0800, CK Hu wrote:
> > Hi, Daniel:
> > 
> > On Thu, 2019-01-10 at 21:02 +0100, Daniel Vetter wrote:
> > > On Thu, Jan 10, 2019 at 08:01:37PM +0100, Frank Wunderlich wrote:
> > > > Hi Daniel,
> > > > 
> > > > > > Would be good to use the new generic fbdev emulation code here, for even
> > > > > > less code. Or at least know why this isn't possible to use for mtk (and
> > > > > > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > > > > > needed anymore.
> > > > > 
> > > > > Back on the mailing list, no private replies please:
> > > > 
> > > > i don't wanted to spam all people with dumb questions ;)
> > > 
> > > There's no dumb questions, only insufficient documentation :-)
> > > 
> > > > > For examples please grep for drm_fbdev_generic_setup(). There's also a
> > > > > still in-flight series from Gerd Hoffmann to convert over bochs. That,
> > > > > plus all the kerneldoc linked from there should get you started.
> > > > > -Daniel
> > > > 
> > > > this is one of google best founds if i search for drm_fbdev_generic_setup:
> > > > 
> > > > https://lkml.org/lkml/2018/12/19/305
> > > > 
> > > > not very helpful...
> > > > 
> > > > so i tried kernel-doc
> > > > 
> > > > https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup
> > > > 
> > > > which is nice function-reference but i've found no generic workflow
> > > > 
> > > > as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
> > > > Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?
> > > > 
> > > > i personally make my first steps as spare-time kernel-developer :)
> > > 
> > > There's a ton of in-kernel users of that function already, I meant you can
> > > use those to serve as examples ... If those + the kerneldoc aren't
> > > good enough, then we need to improve them.
> > > -Daniel
> > 
> > I've tried with drm_fbdev_generic_setup() and it works fine with simple
> > modification. The patch is
> > 
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -16,6 +16,7 @@
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_fb_helper.h>
> >  #include <drm/drm_gem.h>
> >  #include <drm/drm_gem_cma_helper.h>
> >  #include <drm/drm_of.h>
> > @@ -379,6 +380,7 @@ static void mtk_drm_kms_deinit(struct drm_device
> > *drm)
> >         .gem_prime_get_sg_table = mtk_gem_prime_get_sg_table,
> >         .gem_prime_import_sg_table = mtk_gem_prime_import_sg_table,
> >         .gem_prime_mmap = mtk_drm_gem_mmap_buf,
> > +       .gem_prime_vmap = mtk_drm_gem_prime_vmap,
> >         .ioctls = mtk_ioctls,
> >         .num_ioctls = ARRAY_SIZE(mtk_ioctls),
> >         .fops = &mtk_drm_fops,
> > @@ -416,6 +418,8 @@ static int mtk_drm_bind(struct device *dev)
> >         if (ret < 0)
> >                 goto err_deinit;
> > 
> > +       drm_fbdev_generic_setup(drm, 32);
> > +
> >         return 0;
> > 
> > 
> > But I implement .gem_prime_vmap with a workaround,
> > 
> > 
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
> > @@ -280,3 +280,8 @@ int mtk_gem_create_ioctl(struct drm_device *dev,
> > void *data,
> >         mtk_drm_gem_free_object(&mtk_gem->base);
> >         return ret;
> >  }
> > +
> > +void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
> > +{
> > +       return (void *)1;
> > +}
> > 
> > Current drm_fb_helper depends on drm_client to create fbdev. When
> > drm_client create drm_client_buffer, it need to vmap to get kernel
> > vaddr. But I think for fbdev, the vaddr is useless. Do you agree that I
> > temporarily implement .gem_prime_vmap in such way?
> 
> The vmap is used by fbcon, without that fbdev won't really work I think.
> So I'm rather confused on what you tested ...
> 
> Adding Noralf, he's the expert here.
> -Daniel

I test with fb_test [1], it is a user space program just open /dev/fb0
and mmap it to user space. I does not turn on fbcon so everything looks
well. If support fbcon is essential, I would implement vmap correctly.
If it's not essential, I think I could return 0 when
CONFIG_FRAMBUFFER_CONSOLE is defined.

Regards,
CK

[1]
https://android.googlesource.com/platform/system/extras/+/master/tests/framebuffer/fb_test.c


