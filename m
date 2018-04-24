Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeDXTxZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:53:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:27472 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeDXTxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:53:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="36127019"
Message-ID: <1524601089.24461.28.camel@dk-H97M-D3H>
Subject: Re: [Intel-gfx] [PATCH v8 01/10] drm/atomic: Print debug message on
 atomic check failure
From: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Reply-To: dhinakaran.pandiyan@intel.com
To: Lyude Paul <lyude@redhat.com>
Cc: intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date: Tue, 24 Apr 2018 13:18:09 -0700
In-Reply-To: <20180411234302.2896-2-lyude@redhat.com>
References: <20180411234302.2896-1-lyude@redhat.com>
         <20180411234302.2896-2-lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On Wed, 2018-04-11 at 19:42 -0400, Lyude Paul wrote:
> Does what it says on the label, it's a little confusing debugging atomic
> check failures otherwise.
> 
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7d25c42f22db..972a7e9634ab 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1705,8 +1705,11 @@ int drm_atomic_check_only(struct drm_atomic_state *state)
>  	if (config->funcs->atomic_check)
>  		ret = config->funcs->atomic_check(state->dev, state);
>  
> -	if (ret)
> +	if (ret) {
> +		DRM_DEBUG_ATOMIC("atomic driver check for %p failed: %d\n",
> +				 state, ret);
>  		return ret;
> +	}
>  

nit: Would have slightly looked better if the 'ret' check was moved
inside the branch for funcs->atomic_check.

Reviewed-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>



>  	if (!state->allow_modeset) {
>  		for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
