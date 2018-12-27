Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F62C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C925320882
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeL0Ob4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:31:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48454 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbeL0Obz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 09:31:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81351A78;
        Thu, 27 Dec 2018 06:31:53 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 243D73F5AF;
        Thu, 27 Dec 2018 06:31:53 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 6A46E680369; Thu, 27 Dec 2018 14:31:51 +0000 (GMT)
Date:   Thu, 27 Dec 2018 14:31:51 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 7/9] drm/komeda: Attach komeda_dev to DRM-KMS
Message-ID: <20181227143151.GM22341@e110455-lin.cambridge.arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-8-james.qian.wang@arm.com>
 <20181224123213.GI22341@e110455-lin.cambridge.arm.com>
 <20181227070853.GC26908@james-ThinkStation-P300>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181227070853.GC26908@james-ThinkStation-P300>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 07:09:07AM +0000, james qian wang (Arm Technology China) wrote:
> On Mon, Dec 24, 2018 at 08:32:14PM +0800, Liviu Dudau wrote:
> > On Fri, Dec 21, 2018 at 10:00:33AM +0000, james qian wang (Arm Technology China) wrote:
> > > Add komeda_kms abstracton to attach komeda_dev to DRM-KMS
> > >   CRTC: according to the komeda_pipeline
> > >   PLANE: according to komeda_layer (layer input pipeline)
> > >   PRIVATE_OBJS: komeda_pipeline/component all will be treat as private_objs
> > > 
> > > komeda_kms is for connecting DRM-KMS and komeda_dev, like reporting the
> > > kms object properties according to the komeda_dev, and pass/convert KMS's
> > > requirement to komeda_dev.
> > > 
> > > Changes in v3:
> > > - Fixed style problem found by checkpatch.pl --strict.
> > > 
> > > Changes in v2:
> > > - Unified abbreviation of "pipeline" to "pipe".
> > > 
> > > Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> > > ---
> > >  drivers/gpu/drm/arm/display/komeda/Makefile   |   6 +-
> > >  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 106 +++++++++++
> > >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  19 +-
> > >  .../gpu/drm/arm/display/komeda/komeda_kms.c   | 169 ++++++++++++++++++
> > >  .../gpu/drm/arm/display/komeda/komeda_kms.h   | 113 ++++++++++++
> > >  .../drm/arm/display/komeda/komeda_pipeline.h  |   3 +
> > >  .../gpu/drm/arm/display/komeda/komeda_plane.c | 109 +++++++++++
> > >  .../arm/display/komeda/komeda_private_obj.c   |  88 +++++++++
> > >  8 files changed, 608 insertions(+), 5 deletions(-)
> > >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > >  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > > 
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
> > > index 25beae900ed2..1b875e5dc0f6 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> > > +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> > > @@ -9,7 +9,11 @@ komeda-y := \
> > >  	komeda_dev.o \
> > >  	komeda_format_caps.o \
> > >  	komeda_pipeline.o \
> > > -	komeda_framebuffer.o
> > > +	komeda_framebuffer.o \
> > > +	komeda_kms.o \
> > > +	komeda_crtc.o \
> > > +	komeda_plane.o \
> > > +	komeda_private_obj.o
> > >  
> > >  komeda-y += \
> > >  	d71/d71_dev.o
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > new file mode 100644
> > > index 000000000000..5bb5a55f6b31
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> > > @@ -0,0 +1,106 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> > > + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > > + *
> > > + */
> > > +#include <linux/clk.h>
> > > +#include <linux/spinlock.h>
> > > +#include <drm/drm_atomic.h>
> > > +#include <drm/drm_atomic_helper.h>
> > > +#include <drm/drm_plane_helper.h>
> > > +#include <drm/drm_crtc_helper.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include "komeda_dev.h"
> > > +#include "komeda_kms.h"
> > > +
> > > +struct drm_crtc_helper_funcs komeda_crtc_helper_funcs = {
> > > +};
> > > +
> > > +static const struct drm_crtc_funcs komeda_crtc_funcs = {
> > > +};
> > > +
> > > +int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms,
> > > +			   struct komeda_dev *mdev)
> > > +{
> > > +	struct komeda_crtc *crtc;
> > > +	struct komeda_pipeline *master;
> > > +	char str[16];
> > > +	int i;
> > > +
> > > +	kms->n_crtcs = 0;
> > > +
> > > +	for (i = 0; i < mdev->n_pipelines; i++) {
> > > +		crtc = &kms->crtcs[kms->n_crtcs];
> > > +		master = mdev->pipelines[i];
> > > +
> > > +		crtc->master = master;
> > > +		crtc->slave  = NULL;
> > > +
> > > +		if (crtc->slave)
> > > +			sprintf(str, "pipe-%d", crtc->slave->id);
> > > +		else
> > > +			sprintf(str, "None");
> > > +
> > > +		DRM_INFO("crtc%d: master(pipe-%d) slave(%s) output: %s.\n",
> > > +			 kms->n_crtcs, master->id, str,
> > > +			 master->of_output_dev ?
> > > +			 master->of_output_dev->full_name : "None");
> > > +
> > > +		kms->n_crtcs++;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static struct drm_plane *
> > > +get_crtc_primary(struct komeda_kms_dev *kms, struct komeda_crtc *crtc)
> > > +{
> > > +	struct komeda_plane *kplane;
> > > +	struct drm_plane *plane;
> > > +
> > > +	drm_for_each_plane(plane, &kms->base) {
> > > +		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
> > > +			continue;
> > > +
> > > +		kplane = to_kplane(plane);
> > > +		/* only master can be primary */
> > > +		if (kplane->layer->base.pipeline == crtc->master)
> > > +			return plane;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +static int komeda_crtc_add(struct komeda_kms_dev *kms,
> > > +			   struct komeda_crtc *kcrtc)
> > > +{
> > > +	struct drm_crtc *crtc = &kcrtc->base;
> > > +	int err;
> > > +
> > > +	err = drm_crtc_init_with_planes(&kms->base, crtc,
> > > +					get_crtc_primary(kms, kcrtc), NULL,
> > > +					&komeda_crtc_funcs, NULL);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	drm_crtc_helper_add(crtc, &komeda_crtc_helper_funcs);
> > > +	drm_crtc_vblank_reset(crtc);
> > > +
> > > +	crtc->port = kcrtc->master->of_output_port;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int komeda_kms_add_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *mdev)
> > > +{
> > > +	int i, err;
> > > +
> > > +	for (i = 0; i < kms->n_crtcs; i++) {
> > > +		err = komeda_crtc_add(kms, &kms->crtcs[i]);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > index a2657b3d09d7..4b8ce717a71c 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > @@ -13,18 +13,21 @@
> > >  
> > >  struct komeda_drv {
> > >  	struct komeda_dev *mdev;
> > > +	struct komeda_kms_dev *kms;
> > >  };
> > >  
> > >  static void komeda_unbind(struct device *dev)
> > >  {
> > >  	struct komeda_drv *mdrv = dev_get_drvdata(dev);
> > >  
> > > -	dev_set_drvdata(dev, NULL);
> > > -
> > 
> > I would argue that you're fixing a bug here that was introduced in an
> > earlier patch, and that you should fix that patch rather than this
> > change.
> 
> Sorry, you're right, will fix it the next version.
> 
> > >  	if (!mdrv)
> > >  		return;
> > >  
> > > +	komeda_kms_detach(mdrv->kms);
> > > +
> > >  	komeda_dev_destroy(mdrv->mdev);
> > > +
> > > +	dev_set_drvdata(dev, NULL);
> > >  	kfree(mdrv);
> > >  }
> > >  
> > > @@ -33,7 +36,7 @@ static int komeda_bind(struct device *dev)
> > >  	struct komeda_drv *mdrv;
> > >  	int err;
> > >  
> > > -	mdrv = kzalloc(sizeof(*mdrv), GFP_KERNEL);
> > > +	mdrv = devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
> > >  	if (!mdrv)
> > >  		return -ENOMEM;
> > >  
> > > @@ -45,10 +48,18 @@ static int komeda_bind(struct device *dev)
> > >  
> > >  	dev_set_drvdata(dev, mdrv);
> > >  
> > > +	mdrv->kms = komeda_kms_attach(mdrv->mdev);
> > > +	if (IS_ERR(mdrv->kms)) {
> > > +		err = PTR_ERR(mdrv->kms);
> > 
> > does mdrv->kms needs to be set to NULL here?

Ping on this one.

> > 
> > > +		goto destroy_mdev;
> > > +	}
> > > +
> > >  	return 0;
> > >  
> > > +destroy_mdev:
> > > +	komeda_dev_destroy(mdrv->mdev);
> > >  free_mdrv:
> > > -	kfree(mdrv);
> > > +	devm_kfree(dev, mdrv);
> > >  	return err;
> > >  }
> > >  
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > new file mode 100644
> > > index 000000000000..fd48360ca524
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> > > @@ -0,0 +1,169 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> > > + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > > + *
> > > + */
> > > +#include <linux/component.h>
> > > +#include <drm/drm_atomic.h>
> > > +#include <drm/drm_atomic_helper.h>
> > > +#include <drm/drm_gem_framebuffer_helper.h>
> > > +#include <drm/drm_gem_cma_helper.h>
> > > +#include <drm/drm_fb_helper.h>
> > > +#include <linux/interrupt.h>
> > > +#include "komeda_dev.h"
> > > +#include "komeda_kms.h"
> > > +#include "komeda_framebuffer.h"
> > > +
> > > +DEFINE_DRM_GEM_CMA_FOPS(komeda_cma_fops);
> > > +
> > > +static int komeda_gem_cma_dumb_create(struct drm_file *file,
> > > +				      struct drm_device *dev,
> > > +				      struct drm_mode_create_dumb *args)
> > > +{
> > > +	u32 alignment = 16; /* TODO get alignment from dev */
> > > +
> > > +	args->pitch = ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8),
> > > +			    alignment);
> > > +
> > > +	return drm_gem_cma_dumb_create_internal(file, dev, args);
> > > +}
> > > +
> > > +static struct drm_driver komeda_kms_driver = {
> > > +	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
> > > +			   DRIVER_PRIME,
> > > +	.lastclose			= drm_fb_helper_lastclose,
> > > +	.gem_free_object_unlocked	= drm_gem_cma_free_object,
> > > +	.gem_vm_ops			= &drm_gem_cma_vm_ops,
> > > +	.dumb_create			= komeda_gem_cma_dumb_create,
> > > +	.prime_handle_to_fd		= drm_gem_prime_handle_to_fd,
> > > +	.prime_fd_to_handle		= drm_gem_prime_fd_to_handle,
> > > +	.gem_prime_export		= drm_gem_prime_export,
> > > +	.gem_prime_import		= drm_gem_prime_import,
> > > +	.gem_prime_get_sg_table		= drm_gem_cma_prime_get_sg_table,
> > > +	.gem_prime_import_sg_table	= drm_gem_cma_prime_import_sg_table,
> > > +	.gem_prime_vmap			= drm_gem_cma_prime_vmap,
> > > +	.gem_prime_vunmap		= drm_gem_cma_prime_vunmap,
> > > +	.gem_prime_mmap			= drm_gem_cma_prime_mmap,
> > > +	.fops = &komeda_cma_fops,
> > > +	.name = "komeda",
> > > +	.desc = "ARM Mali Komeda Display Processor driver",
> > > +	.date = "20181101",
> > > +	.major = 0,
> > > +	.minor = 1,
> > > +};
> > > +
> > > +static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
> > > +{
> > > +	struct drm_device *dev = old_state->dev;
> > > +
> > > +	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> > > +
> > > +	drm_atomic_helper_commit_planes(dev, old_state, 0);
> > > +
> > > +	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> > 
> > Mainline has also introduced the drm_atomic_helper_fake_vblank(old_state) call
> > to help with writebacks on CRTCs that might be otherwise disabled. Do we need
> > to have it here too?
> 
> we don't need it, since D71 HW still sends flip interrupt even on oneshot
> writeback mode.

Yeah, but does it do it when the CRTC is disabled? Given that the
writeback could take a while, and it is something that gets started
during one atomic commit but finishes at some later time without
blocking the next commit, you could have one atomic commit asking for a
writeback and then another commit disabling the CRTC before the
writeback has finished. In that case you still need to fake the vblank
event when the writeback is done, otherwise userspace will hung waiting
forever for the fence to be signalled.


Best regards,
Liviu



> 
> > > +
> > > +	drm_atomic_helper_wait_for_flip_done(dev, old_state);
> > > +
> > > +	drm_atomic_helper_commit_hw_done(old_state);
> > > +
> > > +	drm_atomic_helper_cleanup_planes(dev, old_state);
> > > +}
> > > +
> > > +static const struct drm_mode_config_helper_funcs komeda_mode_config_helpers = {
> > > +	.atomic_commit_tail = komeda_kms_commit_tail,
> > > +};
> > > +
> > > +static const struct drm_mode_config_funcs komeda_mode_config_funcs = {
> > > +	.fb_create		= komeda_fb_create,
> > > +	.atomic_check		= NULL,/*komeda_kms_check*/
> > 
> > I would argue that you should at least use drm_atomic_helper_check here,
> > rather than set it to NULL, even if later you will replace it with a
> > komeda function.
> 
> OK.
> 
> > 
> > > +	.atomic_commit		= drm_atomic_helper_commit,
> > > +};
> > > +
> > > +static void komeda_kms_mode_config_init(struct komeda_kms_dev *kms,
> > > +					struct komeda_dev *mdev)
> > > +{
> > > +	struct drm_mode_config *config = &kms->base.mode_config;
> > > +
> > > +	drm_mode_config_init(&kms->base);
> > > +
> > > +	komeda_kms_setup_crtcs(kms, mdev);
> > > +
> > > +	/* Get value from dev */
> > > +	config->min_width	= 0;
> > > +	config->min_height	= 0;
> > > +	config->max_width	= 4096;
> > > +	config->max_height	= 4096;
> > > +	config->allow_fb_modifiers = true;
> > > +
> > > +	config->funcs = &komeda_mode_config_funcs;
> > > +	config->helper_private = &komeda_mode_config_helpers;
> > > +}
> > > +
> > > +struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev)
> > > +{
> > > +	struct komeda_kms_dev *kms = kzalloc(sizeof(*kms), GFP_KERNEL);
> > > +	struct drm_device *drm;
> > > +	int err;
> > > +
> > > +	if (!kms)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	drm = &kms->base;
> > > +	err = drm_dev_init(drm, &komeda_kms_driver, mdev->dev);
> > > +	if (err)
> > > +		goto free_kms;
> > > +
> > > +	drm->dev_private = mdev;
> > > +
> > > +	komeda_kms_mode_config_init(kms, mdev);
> > > +
> > > +	err = komeda_kms_add_private_objs(kms, mdev);
> > > +	if (err)
> > > +		goto cleanup_mode_config;
> > > +
> > > +	err = komeda_kms_add_planes(kms, mdev);
> > > +	if (err)
> > > +		goto cleanup_mode_config;
> > > +
> > > +	err = drm_vblank_init(drm, kms->n_crtcs);
> > > +	if (err)
> > > +		goto cleanup_mode_config;
> > > +
> > > +	err = komeda_kms_add_crtcs(kms, mdev);
> > > +	if (err)
> > > +		goto cleanup_mode_config;
> > > +
> > > +	err = component_bind_all(mdev->dev, kms);
> > > +	if (err)
> > > +		goto cleanup_mode_config;
> > > +
> > > +	drm_mode_config_reset(drm);
> > > +
> > > +	err = drm_dev_register(drm, 0);
> > > +	if (err)
> > > +		goto uninstall_irq;
> > > +
> > > +	return kms;
> > > +
> > > +uninstall_irq:
> > > +	drm_irq_uninstall(drm);
> > > +cleanup_mode_config:
> > > +	drm_mode_config_cleanup(drm);
> > > +free_kms:
> > > +	kfree(kms);
> > > +	return ERR_PTR(err);
> > > +}
> > > +
> > > +void komeda_kms_detach(struct komeda_kms_dev *kms)
> > > +{
> > > +	struct drm_device *drm = &kms->base;
> > > +	struct komeda_dev *mdev = drm->dev_private;
> > > +
> > > +	drm_dev_unregister(drm);
> > > +	component_unbind_all(mdev->dev, drm);
> > > +	komeda_kms_cleanup_private_objs(mdev);
> > > +	drm_mode_config_cleanup(drm);
> > > +	drm->dev_private = NULL;
> > > +	drm_dev_put(drm);
> > > +}
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > new file mode 100644
> > > index 000000000000..f13666004a42
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> > > @@ -0,0 +1,113 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> > > + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > > + *
> > > + */
> > > +#ifndef _KOMEDA_KMS_H_
> > > +#define _KOMEDA_KMS_H_
> > > +
> > > +#include <drm/drm_atomic.h>
> > > +#include <drm/drm_atomic_helper.h>
> > > +#include <drm/drm_crtc_helper.h>
> > > +#include <drm/drm_writeback.h>
> > > +
> > > +/** struct komeda_plane - komeda instance of drm_plane */
> > > +struct komeda_plane {
> > > +	/** @base: &drm_plane */
> > > +	struct drm_plane base;
> > > +	/**
> > > +	 * @layer:
> > > +	 *
> > > +	 * represents available layer input pipelines for this plane.
> > > +	 *
> > > +	 * NOTE:
> > > +	 * the layer is not for a specific Layer, but indicate a group of
> > > +	 * Layers with same capabilities.
> > > +	 */
> > > +	struct komeda_layer *layer;
> > > +};
> > > +
> > > +/**
> > > + * struct komeda_plane_state
> > > + *
> > > + * The plane_state can be split into two data flow (left/right) and handled
> > > + * by two layers &komeda_plane.layer and &komeda_plane.layer.right
> > > + */
> > > +struct komeda_plane_state {
> > > +	/** @base: &drm_plane_state */
> > > +	struct drm_plane_state base;
> > > +
> > > +	/* private properties */
> > > +};
> > > +
> > > +/**
> > > + * struct komeda_wb_connector
> > > + */
> > > +struct komeda_wb_connector {
> > > +	/** @base: &drm_writeback_connector */
> > > +	struct drm_writeback_connector base;
> > > +
> > > +	/** @wb_layer: represents associated writeback pipeline of komeda */
> > > +	struct komeda_layer *wb_layer;
> > > +};
> > > +
> > > +/**
> > > + * struct komeda_crtc
> > > + */
> > > +struct komeda_crtc {
> > > +	/** @base: &drm_crtc */
> > > +	struct drm_crtc base;
> > > +	/** @master: only master has display output */
> > > +	struct komeda_pipeline *master;
> > > +	/**
> > > +	 * @slave: optional
> > > +	 *
> > > +	 * Doesn't have its own display output, the handled data flow will
> > > +	 * merge into the master.
> > > +	 */
> > > +	struct komeda_pipeline *slave;
> > > +};
> > > +
> > > +/** struct komeda_crtc_state */
> > > +struct komeda_crtc_state {
> > > +	/** @base: &drm_crtc_state */
> > > +	struct drm_crtc_state base;
> > > +
> > > +	/* private properties */
> > > +
> > > +	/* computed state which are used by validate/check */
> > > +	u32 affected_pipes;
> > > +	u32 active_pipes;
> > > +};
> > > +
> > > +/** struct komeda_kms_dev - for gather KMS related things */
> > > +struct komeda_kms_dev {
> > > +	/** @base: &drm_device */
> > > +	struct drm_device base;
> > > +
> > > +	/** @n_crtcs: valid numbers of crtcs in &komeda_kms_dev.crtcs */
> > > +	int n_crtcs;
> > > +	/** @crtcs: crtcs list */
> > > +	struct komeda_crtc crtcs[KOMEDA_MAX_PIPELINES];
> > > +};
> > > +
> > > +#define to_kplane(p)	container_of(p, struct komeda_plane, base)
> > > +#define to_kplane_st(p)	container_of(p, struct komeda_plane_state, base)
> > > +#define to_kconn(p)	container_of(p, struct komeda_wb_connector, base)
> > > +#define to_kcrtc(p)	container_of(p, struct komeda_crtc, base)
> > > +#define to_kcrtc_st(p)	container_of(p, struct komeda_crtc_state, base)
> > > +#define to_kdev(p)	container_of(p, struct komeda_kms_dev, base)
> > > +
> > > +int komeda_kms_setup_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *mdev);
> > > +
> > > +int komeda_kms_add_crtcs(struct komeda_kms_dev *kms, struct komeda_dev *mdev);
> > > +int komeda_kms_add_planes(struct komeda_kms_dev *kms, struct komeda_dev *mdev);
> > > +int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
> > > +				struct komeda_dev *mdev);
> > > +void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev);
> > > +
> > > +struct komeda_kms_dev *komeda_kms_attach(struct komeda_dev *mdev);
> > > +void komeda_kms_detach(struct komeda_kms_dev *kms);
> > > +
> > > +#endif /*_KOMEDA_KMS_H_*/
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > index 2d68ffeae25d..114129d96851 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> > > @@ -333,6 +333,9 @@ struct komeda_pipeline_state {
> > >  #define to_improc_st(c)	container_of(c, struct komeda_improc_state, base)
> > >  #define to_ctrlr_st(c)	container_of(c, struct komeda_timing_ctrlr_state, base)
> > >  
> > > +#define priv_to_comp_st(o) container_of(o, struct komeda_component_state, obj)
> > > +#define priv_to_pipe_st(o)  container_of(o, struct komeda_pipeline_state, obj)
> > > +
> > >  /* pipeline APIs */
> > >  struct komeda_pipeline *
> > >  komeda_pipeline_add(struct komeda_dev *mdev, size_t size,
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > > new file mode 100644
> > > index 000000000000..0a4953a9a909
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> > > @@ -0,0 +1,109 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> > > + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > > + *
> > > + */
> > > +#include <drm/drm_atomic.h>
> > > +#include <drm/drm_atomic_helper.h>
> > > +#include <drm/drm_plane_helper.h>
> > > +#include "komeda_dev.h"
> > > +#include "komeda_kms.h"
> > > +
> > > +static const struct drm_plane_helper_funcs komeda_plane_helper_funcs = {
> > > +};
> > > +
> > > +static void komeda_plane_destroy(struct drm_plane *plane)
> > > +{
> > > +	drm_plane_cleanup(plane);
> > > +
> > > +	kfree(to_kplane(plane));
> > > +}
> > > +
> > > +static const struct drm_plane_funcs komeda_plane_funcs = {
> > > +};
> > > +
> > > +/* for komeda, which is pipeline can be share between crtcs */
> > > +static u32 get_possible_crtcs(struct komeda_kms_dev *kms,
> > > +			      struct komeda_pipeline *pipe)
> > > +{
> > > +	struct komeda_crtc *crtc;
> > > +	u32 possible_crtcs = 0;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < kms->n_crtcs; i++) {
> > > +		crtc = &kms->crtcs[i];
> > > +
> > > +		if ((pipe == crtc->master) || (pipe == crtc->slave))
> > > +			possible_crtcs |= BIT(i);
> > > +	}
> > > +
> > > +	return possible_crtcs;
> > > +}
> > > +
> > > +/* use Layer0 as primary */
> > > +static u32 get_plane_type(struct komeda_kms_dev *kms,
> > > +			  struct komeda_component *c)
> > > +{
> > > +	bool is_primary = (c->id == KOMEDA_COMPONENT_LAYER0);
> > > +
> > > +	return is_primary ? DRM_PLANE_TYPE_PRIMARY : DRM_PLANE_TYPE_OVERLAY;
> > > +}
> > > +
> > > +static int komeda_plane_add(struct komeda_kms_dev *kms,
> > > +			    struct komeda_layer *layer)
> > > +{
> > > +	struct komeda_dev *mdev = kms->base.dev_private;
> > > +	struct komeda_component *c = &layer->base;
> > > +	struct komeda_plane *kplane;
> > > +	struct drm_plane *plane;
> > > +	u32 *formats, n_formats = 0;
> > > +	int err;
> > > +
> > > +	kplane = kzalloc(sizeof(*kplane), GFP_KERNEL);
> > > +	if (!kplane)
> > > +		return -ENOMEM;
> > > +
> > > +	plane = &kplane->base;
> > > +	kplane->layer = layer;
> > > +
> > > +	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
> > > +					       layer->layer_type, &n_formats);
> > > +
> > > +	err = drm_universal_plane_init(&kms->base, plane,
> > > +			get_possible_crtcs(kms, c->pipeline),
> > > +			&komeda_plane_funcs,
> > > +			formats, n_formats, NULL,
> > > +			get_plane_type(kms, c),
> > > +			"%s", c->name);
> > > +
> > > +	komeda_put_fourcc_list(formats);
> > > +
> > > +	if (err)
> > > +		goto cleanup;
> > > +
> > > +	drm_plane_helper_add(plane, &komeda_plane_helper_funcs);
> > > +
> > > +	return 0;
> > > +cleanup:
> > > +	komeda_plane_destroy(plane);
> > > +	return err;
> > > +}
> > > +
> > > +int komeda_kms_add_planes(struct komeda_kms_dev *kms, struct komeda_dev *mdev)
> > > +{
> > > +	struct komeda_pipeline *pipe;
> > > +	int i, j, err;
> > > +
> > > +	for (i = 0; i < mdev->n_pipelines; i++) {
> > > +		pipe = mdev->pipelines[i];
> > > +
> > > +		for (j = 0; j < pipe->n_layers; j++) {
> > > +			err = komeda_plane_add(kms, pipe->layers[j]);
> > > +			if (err)
> > > +				return err;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > > new file mode 100644
> > > index 000000000000..9edfd6ab0c12
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> > > @@ -0,0 +1,88 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> > > + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> > > + *
> > > + */
> > > +#include "komeda_dev.h"
> > > +#include "komeda_kms.h"
> > > +
> > > +static struct drm_private_state *
> > > +komeda_pipeline_atomic_duplicate_state(struct drm_private_obj *obj)
> > > +{
> > > +	struct komeda_pipeline_state *st;
> > > +
> > > +	st = kmemdup(obj->state, sizeof(*st), GFP_KERNEL);
> > > +	if (!st)
> > > +		return NULL;
> > > +
> > > +	st->active_comps = 0;
> > > +
> > > +	__drm_atomic_helper_private_obj_duplicate_state(obj, &st->obj);
> > > +
> > > +	return &st->obj;
> > > +}
> > > +
> > > +static void
> > > +komeda_pipeline_atomic_destroy_state(struct drm_private_obj *obj,
> > > +				     struct drm_private_state *state)
> > > +{
> > > +	kfree(priv_to_pipe_st(state));
> > > +}
> > > +
> > > +static const struct drm_private_state_funcs komeda_pipeline_obj_funcs = {
> > > +	.atomic_duplicate_state	= komeda_pipeline_atomic_duplicate_state,
> > > +	.atomic_destroy_state	= komeda_pipeline_atomic_destroy_state,
> > > +};
> > > +
> > > +static int komeda_pipeline_obj_add(struct komeda_kms_dev *kms,
> > > +				   struct komeda_pipeline *pipe)
> > > +{
> > > +	struct komeda_pipeline_state *st;
> > > +
> > > +	st = kzalloc(sizeof(*st), GFP_KERNEL);
> > > +	if (!st)
> > > +		return -ENOMEM;
> > > +
> > > +	st->pipe = pipe;
> > > +	drm_atomic_private_obj_init(&pipe->obj, &st->obj,
> > > +				    &komeda_pipeline_obj_funcs);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int komeda_kms_add_private_objs(struct komeda_kms_dev *kms,
> > > +				struct komeda_dev *mdev)
> > > +{
> > > +	struct komeda_pipeline *pipe;
> > > +	int i, err;
> > > +
> > > +	for (i = 0; i < mdev->n_pipelines; i++) {
> > > +		pipe = mdev->pipelines[i];
> > > +
> > > +		err = komeda_pipeline_obj_add(kms, pipe);
> > > +		if (err)
> > > +			return err;
> > > +
> > > +		/* Add component */
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void komeda_kms_cleanup_private_objs(struct komeda_dev *mdev)
> > > +{
> > > +	struct komeda_pipeline *pipe;
> > > +	struct komeda_component *c;
> > > +	int i, id;
> > > +
> > > +	for (i = 0; i < mdev->n_pipelines; i++) {
> > > +		pipe = mdev->pipelines[i];
> > > +		dp_for_each_set_bit(id, pipe->avail_comps) {
> > > +			c = komeda_pipeline_get_component(pipe, id);
> > > +
> > > +			drm_atomic_private_obj_fini(&c->obj);
> > > +		}
> > > +		drm_atomic_private_obj_fini(&pipe->obj);
> > > +	}
> > > +}
> > > -- 
> > > 2.17.1
> > > 
> > 
> > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > 
> > Best regards,
> > Liviu
> > 
> > 
> > -- 
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ¯\_(ツ)_/¯

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
