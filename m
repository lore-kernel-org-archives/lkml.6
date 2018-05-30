Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbeE3Oko (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:40:44 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45031 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeE3Okm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:40:42 -0400
X-Google-Smtp-Source: ADUXVKLQCaHe/pXUmQ8aw4A26tGz8AVdvckrEDxRCK1CRAX/b0JmiBsw1DbfvVbuijg5MX3WiViQUg==
Date: Wed, 30 May 2018 10:40:40 -0400
From: Sean Paul <seanpaul@chromium.org>
To: Lowry Li <lowry.li@arm.com>
Cc: liviu.dudau@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, daniel.vetter@intel.com,
        jani.nikula@linux.intel.com, seanpaul@chromium.org, airlied@linux.ie,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, brian.starkey@arm.com,
        malidp@foss.arm.com, nd@arm.com
Subject: Re: [PATCH v2 0/2] drm/blend: Add per-plane pixel blend mode property
Message-ID: <20180530144040.GM3373@art_vandelay>
References: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527679434-13228-1-git-send-email-lowry.li@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 07:23:52PM +0800, Lowry Li wrote:
> Hi,
> 
> This serie aims at adding the support for pixel blend modes represent the
> alpha blending equation selection in the driver. It also introduces to use
> it in the malidp driver.
> 
> Let me know what you think,

Hi Lowry,
Thank you for doing this work. I know this is something that is missing for
proper Android support, so it's most welcome.

Do you have userspace patches using this property?

Sean


> Lowry
> 
> Changes for v2:
>  - Moves the blending equation into the DOC comment
>  - Refines the comments of drm_plane_create_blend_mode_property to not
>    enumerate the #defines, but instead the string values
>  - Uses fg.* instead of pixel.* and plane_alpha instead of plane.alpha
>  - Introduces to use it in the malidp driver, which depends on the plane
>    alpha patch
> 
> Changes from v1:
>  - v1 is just the core changes to request for commments
>  - Adds a pixel_blend_mode to drm_plane_state and a blend_mode_property to
>    drm_plane, and related support functions
>  - Defines three blend modes in drm_blend.h
>  - Rebased on current drm-next
> 
> Lowry Li (2):
>   drm/blend: Add per-plane pixel blend mode property
>   drm/mali-dp: Implement plane alpha and pixel blend on malidp
> 
>  drivers/gpu/drm/arm/malidp_planes.c |  76 ++++++++++++++-----------
>  drivers/gpu/drm/drm_atomic.c        |   4 ++
>  drivers/gpu/drm/drm_atomic_helper.c |   1 +
>  drivers/gpu/drm/drm_blend.c         | 110 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_blend.h             |   6 ++
>  include/drm/drm_plane.h             |   6 ++
>  6 files changed, 171 insertions(+), 32 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
