Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeA3JoA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:44:00 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50710 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeA3Jn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:43:57 -0500
X-Google-Smtp-Source: AH8x227eEJhV0kUxr4/QM+yTxlLPaCDDFwJCYucdZbTXkfAHJnEGWzB8fAYqH8XSrQTzbCth8T0QCQ==
Date: Tue, 30 Jan 2018 10:43:53 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/edid: use false for boolean value
Message-ID: <20180130094353.GH25930@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180123164607.GA25071@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123164607.GA25071@embeddedgus>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2018 at 10:46:07AM -0600, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks for your patch.

> ---
>  drivers/gpu/drm/drm_edid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index ddd5379..45a80d7 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2767,7 +2767,7 @@ do_detailed_mode(struct detailed_timing *timing, void *c)
>  
>  		drm_mode_probed_add(closure->connector, newmode);
>  		closure->modes++;
> -		closure->preferred = 0;
> +		closure->preferred = false;

There's also

		.preferred = 1,

in add_detailed_modes. Please fix that one up too for consistency, then
I'll merge your patch.

Cheers, Daniel

>  	}
>  }
>  
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
