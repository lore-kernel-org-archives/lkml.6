Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCZIiA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:38:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56307 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeCZIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:37:59 -0400
X-Google-Smtp-Source: AG47ELt5VcMLmX+kpMjmJKSCI182jyVFgqdXVQmBjnW37lVXtZxxmbY92/UfRDrdeM6HmljUFu1fMw==
Date: Mon, 26 Mar 2018 10:37:55 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: linux-kernel@vger.kernel.org, airlied@linux.ie, gustavo@padovan.org,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        bskeggs@redhat.com, nouveau@lists.freedesktop.org,
        daniel.vetter@intel.com
Subject: Re: [Nouveau] [PATCH v2 1/2] gpu: drm/lease:: Use
 list_{next/prev}_entry instead of list_entry
Message-ID: <20180326083755.GT14155@phenom.ffwll.local>
Mail-Followup-To: Arushi Singhal <arushisinghal19971997@gmail.com>,
        linux-kernel@vger.kernel.org, airlied@linux.ie, gustavo@padovan.org,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        bskeggs@redhat.com, nouveau@lists.freedesktop.org,
        daniel.vetter@intel.com
References: <1522000893-5331-1-git-send-email-arushisinghal19971997@gmail.com>
 <1522000893-5331-2-git-send-email-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522000893-5331-2-git-send-email-arushisinghal19971997@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 11:31:32PM +0530, Arushi Singhal wrote:
> It's better to use list_entry instead of list_{next/prev}_entry
> as it makes the code more clear to read.
> This patch replace list_entry with list_{next/prev}_entry.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>

Applied to drm-misc-next, thanks for your patch. I'll leave the other one
to nouveau folks.
-Daniel

> ---
>  drivers/gpu/drm/drm_lease.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index 1402c0e..4dcfb5f 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -340,7 +340,7 @@ static void _drm_lease_revoke(struct drm_master *top)
>  				break;
>  
>  			/* Over */
> -			master = list_entry(master->lessee_list.next, struct drm_master, lessee_list);
> +			master = list_next_entry(master, lessee_list);
>  		}
>  	}
>  }
> -- 
> 2.7.4
> 
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
