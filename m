Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CB5C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A832168B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A832168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=padovan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeHHDfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:35:14 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45156 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeHHDfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:35:14 -0400
Received: by mail-qk0-f193.google.com with SMTP id c192-v6so383638qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 18:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OUdsaqYWIN/st6Agj7vr4jFT2WYIwvglQIeskWxgBZk=;
        b=KAdhytYVluWWUmhq7SGG7F97kWzqXylp1yKCjfA0/dsEdjyDDSBK9URzHGsj7nI8h5
         MVDVCP4qcVaZ7yFe+SEu/ZmICTMZCQFuxxz0CS/6pg2D5ZgB8qbdO60d3LgQkLbTDY4k
         5XsT1uSoj8c3ggRol2X7O/HV/7lvT5me/8ratjPyf3WcfJ46yYIO3BNvBo6SbjJ2B1mH
         ChGWDX89TwWAto8pFEuZl1ymKFkntUHqcUGiv25EWD+FJ3egcUB2Pb1EYSGaJFz2AvvW
         Q7e5ffE4I7Tf9MlLFwfUNkneUqdg8wju6CuxPbUi/KyZX2YKD5KLk/9kZsvBAaz7QFMB
         OvSQ==
X-Gm-Message-State: AOUpUlGnesIaGQScEnoEcFtx/Kh0CsdvtUdJqyLqKYIRuqisS+avJpfL
        mIZSIBKPL0qRKhm5hzo6j74=
X-Google-Smtp-Source: AA+uWPxlilcjGS3JuDnbWqV6opLCtZnGLi17Vzq4qSzldOdGuLLDaMrTEe0Ww5jyazUW5QixpmCOBQ==
X-Received: by 2002:a37:af42:: with SMTP id y63-v6mr721423qke.87.1533691087167;
        Tue, 07 Aug 2018 18:18:07 -0700 (PDT)
Received: from juma ([2804:14c:138:2c75:3bc0:2ecb:a7ce:e38c])
        by smtp.gmail.com with ESMTPSA id t127-v6sm1755032qkd.1.2018.08.07.18.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 18:18:06 -0700 (PDT)
Date:   Tue, 7 Aug 2018 22:17:58 -0300
From:   Gustavo Padovan <gustavo@padovan.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        alexandros.frantzis@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH] drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
Message-ID: <20180808011758.GA6042@juma>
References: <20180806160102.11877-1-enric.balletbo@collabora.com>
 <20180807164039.GB3008@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807164039.GB3008@phenom.ffwll.local>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 06:40:39PM +0200, Daniel Vetter wrote:
> On Mon, Aug 06, 2018 at 06:01:02PM +0200, Enric Balletbo i Serra wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.com>
> > 
> > This flag tells core to jump ahead the queued update if the conditions
> > in drm_atomic_async_check() are met. That means we are only able to do an
> > async update if no modeset is pending and update for the same plane is
> > not queued.
> > 
> > It uses the already in place infrastructure for async updates.
> > 
> > It is useful for cursor updates and async PageFlips over the atomic
> > ioctl, otherwise in some cases updates may be delayed to the point the
> > user will notice it. Note that for now it's only enabled for cursor
> > planes.
> > 
> > DRM_MODE_ATOMIC_AMEND should be passed to the Atomic IOCTL to use this
> > feature.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Hi,
> > 
> > This is an attempt to introduce the new ATOMIC_AMEND flag for atomic
> > operations, see the commit message for a more detailed description.
> > 
> > This was tested using a small program that exercises the uAPI for easy
> > sanity testing. The program created by Alexandros can be found here
> > [2]. To test, just build the program and use the --atomic flag to use the
> > cursor plane in normal (blocking mode), and --atomic-async to use the cursor
> > plane with the ATOMIC_AMEND flag. E.g.
> > 
> >   drm_cursor --atomic
> > 
> > or
> > 
> >   drm_cursor --atomic-async
> 
> Would be really lovely to bake these into igt-based regression tests. i915
> doesn't yet have async update support, but I hope we'll eventually gain
> that, and then our CI could make sure this keeps working.
> 
> > The test worked on a Samsung Chromebook Plus on top of mainline plus
> > the patch to update cursors asynchronously through atomic for the
> > drm/rockchip driver.
> > 
> > Alexandros also did a proof-of-concept to use this flag and draw cursors
> > using atomic if possible on ozone [1].
> > 
> > Best regards,
> >  Enric
> > 
> > [1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
> > [2] https://gitlab.collabora.com/alf/drm-cursor
> > 
> > 
> > Changes in v1:
> > - Only enable it if userspace requests it.
> > - Only allow async update for cursor type planes.
> > - Rename ASYNC_UPDATE for ATOMIC_AMEND.
> > 
> >  drivers/gpu/drm/drm_atomic.c        |  5 +++++
> >  drivers/gpu/drm/drm_atomic_helper.c | 10 +++++++++-
> >  include/uapi/drm/drm_mode.h         |  4 +++-
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > index 895741e9cd7d..7b3e4aa2874d 100644
> > --- a/drivers/gpu/drm/drm_atomic.c
> > +++ b/drivers/gpu/drm/drm_atomic.c
> > @@ -2338,6 +2338,10 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
> >  			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
> >  		return -EINVAL;
> >  
> > +	if ((arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET) &&
> > +			(arg->flags & DRM_MODE_ATOMIC_AMEND))
> > +		return -EINVAL;
> > +
> >  	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
> >  
> >  	state = drm_atomic_state_alloc(dev);
> > @@ -2346,6 +2350,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
> >  
> >  	state->acquire_ctx = &ctx;
> >  	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
> > +	state->async_update = !!(arg->flags & DRM_MODE_ATOMIC_AMEND);
> >  
> >  retry:
> >  	plane_mask = 0;
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 81e32199d3ef..59495f61c583 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -902,7 +902,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	if (state->legacy_cursor_update)
> > +	if (state->async_update || state->legacy_cursor_update)
> 
> Hm, it would be really cool if we could rip out the legacy_cursor_update
> hack and also use async_update in the cursor compat helpers. At least if
> available.

That would be nice indeed!

> 
> >  		state->async_update = !drm_atomic_helper_async_check(dev, state);
> >  
> >  	return ret;
> > @@ -1539,6 +1539,14 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
> >  	if (new_plane_state->fence)
> >  		return -EINVAL;
> >  
> > +	/* Only allow async update for cursor type planes. */
> > +	if (plane->type != DRM_PLANE_TYPE_CURSOR)
> > +		return -EINVAL;
> 
> Why limit to cursor planes? The async_update hooks are per-plane.

Two reason that I can think of, we should have mentioned this on the
commit message:
- we have no real user space use case for anything other than cursor
- Ville wants to go down the road of fences per-plane for this, we'd
  want to signal the replaced planes, but not the whole crtc. That is
  of course a optimization on top.

> 
> > +
> > +	/* Don't do an async update if there isn't a pending commit. */
> > +	if (!old_plane_state->commit)
> > +		return -EINVAL;
> 
> Hm, why this? Won't this break legacy cursor updates now for drivers which
> implement this using async_update?

To clarify what this does is do a normal commit if there isn't any
pending commit to amend.

> 
> If userspace wants to avoid this, they can do so by properly tracking
> their non-AMEND updates and making sure they've waited until those all
> completed.
> 
> Also, how is userspace supposed to figure out async_update exists/works?
> Usual approach is a getparam.

Good point. We kinda missed that.

> 
> Another semantics questions: Should this fail if we fall back to a
> non-async update? I think that would be best, since userspace can the
> decide on its own whether it wants to fall back to a normal commit or do
> something else. And the cursor compat code could do the same, i.e. try
> first with AMEND, then a normal commit?

The fallback on this version of the patchset was my suggestion, we had a
test failing, not sure which anymore, if we did not fallback. Maybe the
test we wrote was wrong! Ugh! Let me revisit this with Enric, fail
instead of silent fallback seems indeed the best approach! 

Gustavo

> 
> Cheers, Daniel
> 
> > +
> >  	/*
> >  	 * Don't do an async update if there is an outstanding commit modifying
> >  	 * the plane.  This prevents our async update's changes from getting
> > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > index 4b3a1bb58e68..6dae18428123 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -724,13 +724,15 @@ struct drm_mode_destroy_dumb {
> >  #define DRM_MODE_ATOMIC_TEST_ONLY 0x0100
> >  #define DRM_MODE_ATOMIC_NONBLOCK  0x0200
> >  #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
> > +#define DRM_MODE_ATOMIC_AMEND 0x0800
> >  
> >  #define DRM_MODE_ATOMIC_FLAGS (\
> >  		DRM_MODE_PAGE_FLIP_EVENT |\
> >  		DRM_MODE_PAGE_FLIP_ASYNC |\
> >  		DRM_MODE_ATOMIC_TEST_ONLY |\
> >  		DRM_MODE_ATOMIC_NONBLOCK |\
> > -		DRM_MODE_ATOMIC_ALLOW_MODESET)
> > +		DRM_MODE_ATOMIC_ALLOW_MODESET |\
> > +		DRM_MODE_ATOMIC_AMEND)
> >  
> >  struct drm_mode_atomic {
> >  	__u32 flags;
> > -- 
> > 2.18.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
