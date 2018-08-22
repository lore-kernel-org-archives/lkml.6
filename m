Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB90C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E77214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ZNArH2jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E77214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeHVQEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:04:36 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37215 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeHVQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:04:36 -0400
Received: by mail-yw1-f65.google.com with SMTP id x83-v6so579163ywd.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e48L7P09vAuIlbGQ5fxExXR3H4nU6s8eKGv6vdkaz7Q=;
        b=ZNArH2jyQ6X2Xo75M/cDjgRjyGzjGtYrh8xymPfSmimEPP+74uY3WM5NlTH6k6cjyK
         najAQXhnb7+MabAsJ1303MCKHI4NYRKU+RGDxd5nUjxgyOIgYuPb1kzeglApOehz0YW6
         ufQ0US1AC32rtIUCtvt3VmAOzvGSJUZB+hJyWluHo8cIMGAFeWdO+wUC0m8f+YBDpQQn
         zK+8lVUFuPQU5jdJKTwjtrcHO1XxOc3C1QdTvHzxa4m4qxMJ5+9zNhObb4g4h9QTclqU
         7Ml2dJR2k82gV49yXx3M3nw7B7VdQIgbK0ndTNYxgw8ME9Dfni/HQVhDcL/LD9TG51Qn
         5YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e48L7P09vAuIlbGQ5fxExXR3H4nU6s8eKGv6vdkaz7Q=;
        b=EW8m0Qos2LOeabwNy6LJtjOCg5/s/bTASoVJDYbW3LTz3+WJLxltu/aZrqsD5f3sPk
         8Kdq/AX3S+gxatfR4XCGicWozShDYlSpTHRWu19v4IIpHrM/P0Gy7SQY7BQuDdj7ZsG0
         GwfQTEFzYsHu5U3OKKlfdDFQmp93ehxQHWOm/LNZOpHp2DxmGJ5OM2FX5a0GPLXSa2HC
         9HzxprGDfIYmpHAv7E4lL1BdTcvOSyq9A/QSFd0iPZYZVXVzV0x+9ALfOsRjxpqCbiV+
         B1k4e+BrBTGcKqKbZl8LU9E+s+MDto5eW/cuYSYhTLI02hxyAch4l1TGPEh2wj02Pgt1
         LrBg==
X-Gm-Message-State: AOUpUlFh5afjue/G7P4Q1R8v0aQzLw7wPEUlCuAoAjVsWmWRsz535yvG
        s7w3kxIkVZIBtaUoFeyhtgecFw==
X-Google-Smtp-Source: AA+uWPzpuQ9z/wRthzN0VAhrejcGMBy1veeWE/uu4yPnYR1l+dPweoQiKQISFkraqT260iTS47CGxQ==
X-Received: by 2002:a81:b244:: with SMTP id q65-v6mr29108704ywh.450.1534941590227;
        Wed, 22 Aug 2018 05:39:50 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id p126-v6sm655042ywf.22.2018.08.22.05.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 05:39:49 -0700 (PDT)
Date:   Wed, 22 Aug 2018 08:39:49 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lowry Li <lowry.li@arm.com>
Cc:     liviu.dudau@arm.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        emil.l.velikov@gmail.com, seanpaul@chromium.org,
        malidp@foss.arm.com, daniel.vetter@intel.com, nd@arm.com
Subject: Re: [PATCH v4 1/2] drm: Add per-plane pixel blend mode property
Message-ID: <20180822123949.GU164269@art_vandelay>
References: <1534314933-23182-1-git-send-email-lowry.li@arm.com>
 <1534314933-23182-2-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534314933-23182-2-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:35:32PM +0800, Lowry Li wrote:
> Pixel blend modes represent the alpha blending equation
> selection, describing how the pixels from the current
> plane are composited with the background.
> 
> Adds a pixel_blend_mode to drm_plane_state and a
> blend_mode_property to drm_plane, and related support
> functions.
> 
> Defines three blend modes in drm_blend.h.
> 
> Changes since v1:
>  - Moves the blending equation into the DOC comment
>  - Refines the comments of drm_plane_create_blend_mode_property to not
>    enumerate the #defines, but instead the string values
>  - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
> Changes since v2:
>  - Refines the comments of drm_plane_create_blend_mode_property:
>       1) Puts the descriptions (after the ":") on a new line
>       2) Adds explaining why @supported_modes need PREMUL as default
> Changes since v3:
>  - Refines drm_plane_create_blend_mode_property(). drm_property_add_enum()
>    can calculate the index itself just fine, so no point in having the
>    caller pass it in.
>  - Since the current DRM assumption is that alpha is premultiplied
>    as default, define DRM_MODE_BLEND_PREMULTI as 0 will be better.
>  - Refines some comments.
> 
> Signed-off-by: Lowry Li <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/drm_atomic.c        |   4 ++
>  drivers/gpu/drm/drm_atomic_helper.c |   1 +
>  drivers/gpu/drm/drm_blend.c         | 126 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_blend.h             |   6 ++
>  include/drm/drm_plane.h             |   2 +
>  5 files changed, 139 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 3eb061e..d0478ab 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -895,6 +895,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		state->src_h = val;
>  	} else if (property == plane->alpha_property) {
>  		state->alpha = val;
> +	} else if (property == plane->blend_mode_property) {
> +		state->pixel_blend_mode = val;
>  	} else if (property == plane->rotation_property) {
>  		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK)) {
>  			DRM_DEBUG_ATOMIC("[PLANE:%d:%s] bad rotation bitmask: 0x%llx\n",
> @@ -968,6 +970,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		*val = state->src_h;
>  	} else if (property == plane->alpha_property) {
>  		*val = state->alpha;
> +	} else if (property == plane->blend_mode_property) {
> +		*val = state->pixel_blend_mode;
>  	} else if (property == plane->rotation_property) {
>  		*val = state->rotation;
>  	} else if (property == plane->zpos_property) {
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 6dd5036..563af09 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3569,6 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
>  	/* Reset the alpha value to fully opaque if it matters */
>  	if (plane->alpha_property)
>  		state->alpha = plane->alpha_property->values[1];
> +	plane->state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;

Shouldn't this be state->pixel_blend_mode instead of
plane->state->pixel_blend_mode?

>  
>  	plane->state = state;
>  }

/snip

-- 
Sean Paul, Software Engineer, Google / Chromium OS
