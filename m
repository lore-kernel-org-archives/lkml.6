Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A83C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105F820833
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="phh7bcg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105F820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbeI1V3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:29:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53832 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbeI1V3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:29:17 -0400
Received: from avalon.localnet (nat-242.udc.es [193.144.61.242])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E7268B8E;
        Fri, 28 Sep 2018 17:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538147103;
        bh=h2jaMYyEUnLoDyclcPQNJrUbzymHcVfiFZYlzgUIpqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phh7bcg7jRG9qB7Y2xPi9SzlKUn3N0dXyXIwoMQPDCUbX8ro2vlgNF5RO7VpVABbe
         1toVONQnasuuaTwxE2tTOogIs1g0wvcyDKVvDv3S2YcOAWITzoA+dlZZ1rjeEAvzo4
         d0ICl0GvpdSFKwSQJfj9xx3mb6Owwa/zIzdLZ9dU=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] drm/rcar-du: Convert drm_atomic_helper_suspend/resume()
Date:   Fri, 28 Sep 2018 18:05:18 +0300
Message-ID: <1672691.6TUgGLsHUb@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAFqt6zZno+Q6NY6iOXr8utE3W56+Pd5KboqdOKZjj7Z_jBZDuw@mail.gmail.com>
References: <20180918163903.GA11172@jordon-HP-15-Notebook-PC> <CAFqt6zZno+Q6NY6iOXr8utE3W56+Pd5KboqdOKZjj7Z_jBZDuw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

Thank you for the patch.

On Thursday, 27 September 2018 09:34:18 EEST Souptick Joarder wrote:
> On Tue, Sep 18, 2018 at 10:05 PM Souptick Joarder wrote:
> > convert drm_atomic_helper_suspend/resume() to use
> > drm_mode_config_helper_suspend/resume().
> > 
> > remove suspend_state field from the rcar_du_device
> > structure as it is no more required.
> > 
> > With this conversion, also drm_fbdev_cma_set_suspend_unlocked()
> > will left with no consumer. So this function can be removed.
> > 
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> 
> Laurent, any comment on this patch ??

Sorry for the delay, and thanks for pinging me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Should I apply this to my tree or do you plan to merge it through drm-misc as 
it touches drm_fb_cma_helper.c ?

> > ---
> > 
> >  drivers/gpu/drm/drm_fb_cma_helper.c   | 18 ------------------
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 21 ++-------------------
> >  drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 -
> >  include/drm/drm_fb_cma_helper.h       |  2 --
> >  4 files changed, 2 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c
> > b/drivers/gpu/drm/drm_fb_cma_helper.c index 47e0e2f..96efc88 100644
> > --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> > @@ -224,21 +224,3 @@ void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma
> > *fbdev_cma)> 
> >                 drm_fb_helper_hotplug_event(&fbdev_cma->fb_helper);
> >  
> >  }
> >  EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
> > 
> > -
> > -/**
> > - * drm_fbdev_cma_set_suspend_unlocked - wrapper around
> > - *                                     
> > drm_fb_helper_set_suspend_unlocked
> > - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> > - * @state: desired state, zero to resume, non-zero to suspend
> > - *
> > - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> > - * fb_set_suspend implemented by fbdev core.
> > - */
> > -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
> > -                                       bool state)
> > -{
> > -       if (fbdev_cma)
> > -               drm_fb_helper_set_suspend_unlocked(&fbdev_cma->fb_helper,
> > -                                                  state);
> > -}
> > -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend_unlocked);
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 02aee6c..288220f 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > @@ -357,32 +357,15 @@ static void rcar_du_lastclose(struct drm_device
> > *dev)
> > 
> >  static int rcar_du_pm_suspend(struct device *dev)
> >  {
> >  
> >         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> > 
> > -       struct drm_atomic_state *state;
> > 
> > -       drm_kms_helper_poll_disable(rcdu->ddev);
> > -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, true);
> > -
> > -       state = drm_atomic_helper_suspend(rcdu->ddev);
> > -       if (IS_ERR(state)) {
> > -               drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> > -               drm_kms_helper_poll_enable(rcdu->ddev);
> > -               return PTR_ERR(state);
> > -       }
> > -
> > -       rcdu->suspend_state = state;
> > -
> > -       return 0;
> > +       return drm_mode_config_helper_suspend(rcdu->ddev);
> > 
> >  }
> >  
> >  static int rcar_du_pm_resume(struct device *dev)
> >  {
> >  
> >         struct rcar_du_device *rcdu = dev_get_drvdata(dev);
> > 
> > -       drm_atomic_helper_resume(rcdu->ddev, rcdu->suspend_state);
> > -       drm_fbdev_cma_set_suspend_unlocked(rcdu->fbdev, false);
> > -       drm_kms_helper_poll_enable(rcdu->ddev);
> > -
> > -       return 0;
> > +       return drm_mode_config_helper_resume(rcdu->ddev);
> > 
> >  }
> >  #endif
> > 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > b/drivers/gpu/drm/rcar-du/rcar_du_drv.h index b3a25e8..ff25c8d 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> > @@ -78,7 +78,6 @@ struct rcar_du_device {
> > 
> >         struct drm_device *ddev;
> >         struct drm_fbdev_cma *fbdev;
> > 
> > -       struct drm_atomic_state *suspend_state;
> > 
> >         struct rcar_du_crtc crtcs[RCAR_DU_MAX_CRTCS];
> >         unsigned int num_crtcs;
> > 
> > diff --git a/include/drm/drm_fb_cma_helper.h
> > b/include/drm/drm_fb_cma_helper.h index 4a65f0d..8dbbe1e 100644
> > --- a/include/drm/drm_fb_cma_helper.h
> > +++ b/include/drm/drm_fb_cma_helper.h
> > @@ -26,8 +26,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct
> > drm_device *dev,> 
> >  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
> >  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
> > 
> > -void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
> > -                                       bool state);
> > 
> >  struct drm_gem_cma_object *drm_fb_cma_get_gem_obj(struct drm_framebuffer
> >  *fb,
> >         unsigned int plane);

-- 
Regards,

Laurent Pinchart



