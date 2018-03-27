Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeC0PvI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:51:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32964 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeC0PvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:51:06 -0400
X-Google-Smtp-Source: AG47ELvjnPOx7V9fKsq51zKzVKbX28VIE5e8P3VRhlP6DQmRSI7YOi76pdaFTvk/Y1CvFo1KbOmG1A==
Date: Tue, 27 Mar 2018 17:51:02 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Philippe Cornu <philippe.cornu@st.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>
Subject: Re: [PATCH] drm: clarify adjusted_mode for a bridge connected to a
 crtc
Message-ID: <20180327155102.GW14155@phenom.ffwll.local>
Mail-Followup-To: Philippe Cornu <philippe.cornu@st.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>
References: <20180226121605.12050-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226121605.12050-1-philippe.cornu@st.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 01:16:04PM +0100, Philippe Cornu wrote:
> This patch clarifies the adjusted_mode documentation
> for a bridge directly connected to a crtc.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> This patch is linked to the discussion https://lkml.org/lkml/2018/1/25/367

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Aside, and kinda why I noticed this patch to begin with: You have drm-misc
commit rights, but you seem to not use that. And with 18 patches in the
4.17 cycle you're the top contributor who's not pushing his own patches.

What's the hold-up? Tools don't work, or something else? I really think
regular contributors should just push their own stuff themselves (after
appropriate review ofc).
-Daniel

> 
>  include/drm/drm_bridge.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 3270fec46979..b5f3c070467c 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -177,7 +177,8 @@ struct drm_bridge_funcs {
>  	 * pipeline has been called already. If the bridge is the first element
>  	 * then this would be &drm_encoder_helper_funcs.mode_set. The display
>  	 * pipe (i.e.  clocks and timing signals) is off when this function is
> -	 * called.
> +	 * called. If the bridge is connected to the crtc, the adjusted_mode
> +	 * parameter is the one defined in &drm_crtc_state.adjusted_mode.
>  	 */
>  	void (*mode_set)(struct drm_bridge *bridge,
>  			 struct drm_display_mode *mode,
> -- 
> 2.15.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
