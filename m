Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967487AbeEYRXu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:23:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33832 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753754AbeEYRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:23:49 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] drm/rcar-du: fix merge conflict for state->alpha
Date: Fri, 25 May 2018 20:23:45 +0300
Message-ID: <2645574.AKFHv1VX8C@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180525155030.3667352-4-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de> <20180525155030.3667352-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Friday, 25 May 2018 18:50:11 EEST Arnd Bergmann wrote:
> The "alpha" struct member was removed in one commit but another user
> added in another, leading to a build failure:
> 
> drivers/gpu/drm/rcar-du/rcar_du_vsp.c: In function
> 'rcar_du_vsp_plane_atomic_duplicate_state':
> drivers/gpu/drm/rcar-du/rcar_du_vsp.c:325:6: error: 'struct
> rcar_du_vsp_plane_state' has no member named 'alpha' copy->alpha =
> to_rcar_vsp_plane_state(plane->state)->alpha;
> 
> This fixes up the merge by using the correct member.
> 
> Fixes: 75a07f399cd4 ("drm: rcar-du: Zero-out sg_tables when duplicating
> plane state") Fixes: 301a9b8d5456 ("drm/rcar-du: Convert to the new generic
> alpha property") Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have posted the same fix a week ago, see https://patchwork.freedesktop.org/
patch/msgid/20180515174752.28954-1-laurent.pinchart+renesas@ideasonboard.com. 
The patch is in Dave's master branch in commit 
315852b422972e6ebb1dfddaadada09e46a2681a.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c index 4a98470626d5..d9232e749b6d
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> @@ -322,7 +322,7 @@ rcar_du_vsp_plane_atomic_duplicate_state(struct
> drm_plane *plane) return NULL;
> 
>  	__drm_atomic_helper_plane_duplicate_state(plane, &copy->state);
> -	copy->alpha = to_rcar_vsp_plane_state(plane->state)->alpha;
> +	copy->state.alpha = plane->state->alpha;
> 
>  	return &copy->state;
>  }

-- 
Regards,

Laurent Pinchart
