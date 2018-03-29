Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeC2HRx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:17:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34880 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeC2HRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:17:52 -0400
X-Google-Smtp-Source: AIpwx487uc9FebdiPxP7vFKZqq7m1eFR1ZSWj/XSibqDr4vG95L015c26kRw7B6AiYZWxQ0v+pBrMQ==
Date: Thu, 29 Mar 2018 09:17:48 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: daniel.vetter@intel.com, jgross@suse.com, konrad.wilk@oracle.com,
        airlied@linux.ie,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 2/2] drm/xen-front: Add support for Xen PV display
 frontend
Message-ID: <20180329071748.GG3881@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        daniel.vetter@intel.com, jgross@suse.com, konrad.wilk@oracle.com,
        airlied@linux.ie,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
References: <1522219661-26827-1-git-send-email-andr2000@gmail.com>
 <1522219661-26827-3-git-send-email-andr2000@gmail.com>
 <20180328074251.GE14155@phenom.ffwll.local>
 <32481355-27f6-695b-c6c1-8113ea268a33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32481355-27f6-695b-c6c1-8113ea268a33@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 01:29:46PM +0300, Oleksandr Andrushchenko wrote:
> Hi, Daniel!
> 
> I just noticed I have missed one change in the patch:
> the below must be static.
> 
> On 03/28/2018 10:42 AM, Daniel Vetter wrote:
> > +enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
> > +		const struct drm_display_mode *mode)
> > +{
> > +	struct xen_drm_front_drm_pipeline *pipeline =
> > +			container_of(crtc,
> Could you please amend the patch in attachment
> when merging, so I don't resend?

Merging is up to you, as soon as you have your commit rights.
-Daniel

> 
> Thank you in advance,
> Oleksandr

> From 3a82d76bd3d954056b760e5d1d09e2f96a2786ef Mon Sep 17 00:00:00 2001
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Date: Wed, 28 Mar 2018 13:24:04 +0300
> Subject: [PATCH] drm/xen-front: Make display_mode_valid static
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/gpu/drm/xen/xen_drm_front_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
> index 545049dfaf0a..bd676be5a0db 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
> @@ -273,7 +273,7 @@ static void display_update(struct drm_simple_display_pipe *pipe,
>  	drm_dev_exit(idx);
>  }
>  
> -enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
> +static enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
>  		const struct drm_display_mode *mode)
>  {
>  	struct xen_drm_front_drm_pipeline *pipeline =
> -- 
> 2.7.4
> 

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
