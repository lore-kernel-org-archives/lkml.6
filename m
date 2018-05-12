Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeELTpq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 15:45:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52466 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeELTpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 15:45:45 -0400
X-Google-Smtp-Source: AB8JxZojTpaTYRL4EMaVTDAbSQFrt1jeL4mwq315FnswXWe4VMVaWpRHVB4fvBKh1LVVwVSXaW35qw==
Date: Sat, 12 May 2018 21:45:41 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH] drm: Fix render node numbering regression from control
 node removal.
Message-ID: <20180512194541.GZ28661@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>
References: <20180509001425.12574-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509001425.12574-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 05:14:25PM -0700, Eric Anholt wrote:
> drm_minor_alloc() does multiplication on this enum, so the removal
> ended up moving render nodes down from 128 base to 64.  This caused
> Mesa's surfaceless backend to be unable to open the render nodes,
> since it was still looking up at 128.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 0d49f303e8a7 ("drm: remove all control node code")
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sean Paul <seanpaul@chromium.org>

Oops.

> ---
>  include/drm/drm_file.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 99ab50cbab00..69b0a8b57502 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -49,6 +49,7 @@ struct device;
>  
>  enum drm_minor_type {
>  	DRM_MINOR_PRIMARY,
> +	DRM_MINOR_CONTROL,

Maybe add a comment here why we need this? Either way:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	DRM_MINOR_RENDER,
>  };
>  
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
