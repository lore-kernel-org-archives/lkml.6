Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbeDTIOx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:14:53 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44619 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbeDTIOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:14:50 -0400
X-Google-Smtp-Source: AIpwx49fVPFxJ6wiqpiVlpr0kv9RCYpmaBVBpddOa9j7MRagOtkMCzn62xQVWW/r8y3vifdyaWzLfQ==
Date: Fri, 20 Apr 2018 10:14:46 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 4/4] qxl: drop dummy functions
Message-ID: <20180420081446.GP31310@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
References: <20180420071904.24276-1-kraxel@redhat.com>
 <20180420071904.24276-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420071904.24276-5-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 09:19:04AM +0200, Gerd Hoffmann wrote:
> These days drm core checks function pointers everywhere before calling
> them.  So we can drop a bunch of dummy functions now.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 50 ---------------------------------------
>  1 file changed, 50 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 06ee00b486..af6e52af5f 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -456,13 +456,6 @@ qxl_framebuffer_init(struct drm_device *dev,
>  	return 0;
>  }
>  
> -static bool qxl_crtc_mode_fixup(struct drm_crtc *crtc,
> -				  const struct drm_display_mode *mode,
> -				  struct drm_display_mode *adjusted_mode)
> -{
> -	return true;
> -}
> -
>  static void qxl_crtc_atomic_enable(struct drm_crtc *crtc,
>  				   struct drm_crtc_state *old_state)
>  {
> @@ -476,7 +469,6 @@ static void qxl_crtc_atomic_disable(struct drm_crtc *crtc,
>  }
>  
>  static const struct drm_crtc_helper_funcs qxl_crtc_helper_funcs = {
> -	.mode_fixup = qxl_crtc_mode_fixup,
>  	.atomic_flush = qxl_crtc_atomic_flush,
>  	.atomic_enable = qxl_crtc_atomic_enable,
>  	.atomic_disable = qxl_crtc_atomic_disable,
> @@ -620,12 +612,6 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
>  	}
>  }
>  
> -static int qxl_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_plane_state *state)
> -{
> -	return 0;
> -}
> -
>  static void qxl_cursor_atomic_update(struct drm_plane *plane,
>  				     struct drm_plane_state *old_state)
>  {
> @@ -831,7 +817,6 @@ static const uint32_t qxl_cursor_plane_formats[] = {
>  };
>  
>  static const struct drm_plane_helper_funcs qxl_cursor_helper_funcs = {
> -	.atomic_check = qxl_plane_atomic_check,
>  	.atomic_update = qxl_cursor_atomic_update,
>  	.atomic_disable = qxl_cursor_atomic_disable,
>  	.prepare_fb = qxl_plane_prepare_fb,
> @@ -956,28 +941,6 @@ static int qdev_crtc_init(struct drm_device *dev, int crtc_id)
>  	return r;
>  }
>  
> -static void qxl_enc_dpms(struct drm_encoder *encoder, int mode)
> -{
> -	DRM_DEBUG("\n");
> -}
> -
> -static void qxl_enc_prepare(struct drm_encoder *encoder)
> -{
> -	DRM_DEBUG("\n");
> -}
> -
> -static void qxl_enc_commit(struct drm_encoder *encoder)
> -{
> -	DRM_DEBUG("\n");
> -}
> -
> -static void qxl_enc_mode_set(struct drm_encoder *encoder,
> -				struct drm_display_mode *mode,
> -				struct drm_display_mode *adjusted_mode)
> -{
> -	DRM_DEBUG("\n");
> -}
> -
>  static int qxl_conn_get_modes(struct drm_connector *connector)
>  {
>  	unsigned pwidth = 1024;
> @@ -1023,10 +986,6 @@ static struct drm_encoder *qxl_best_encoder(struct drm_connector *connector)
>  
>  
>  static const struct drm_encoder_helper_funcs qxl_enc_helper_funcs = {

Hm, I thought even the vtable itself is optional? We do have tons of if
(!funcs) checks all over the place at least.


> -	.dpms = qxl_enc_dpms,
> -	.prepare = qxl_enc_prepare,
> -	.mode_set = qxl_enc_mode_set,
> -	.commit = qxl_enc_commit,
>  };
>  
>  static const struct drm_connector_helper_funcs qxl_connector_helper_funcs = {
> @@ -1059,14 +1018,6 @@ static enum drm_connector_status qxl_conn_detect(
>  			 : connector_status_disconnected;
>  }
>  
> -static int qxl_conn_set_property(struct drm_connector *connector,
> -				   struct drm_property *property,
> -				   uint64_t value)
> -{
> -	DRM_DEBUG("\n");
> -	return 0;
> -}
> -
>  static void qxl_conn_destroy(struct drm_connector *connector)
>  {
>  	struct qxl_output *qxl_output =
> @@ -1081,7 +1032,6 @@ static const struct drm_connector_funcs qxl_connector_funcs = {
>  	.dpms = drm_helper_connector_dpms,
>  	.detect = qxl_conn_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.set_property = qxl_conn_set_property,

This is a legacy callback anyway. I kinda wonder whether we should have a
bunch of WARN_ON checks for this, so that atomic drivers don't have these
hanging around anymore.

Anyway, patch looks pretty.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>  	.destroy = qxl_conn_destroy,
>  	.reset = drm_atomic_helper_connector_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
