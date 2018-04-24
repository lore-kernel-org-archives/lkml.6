Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbeDXPLw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:11:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:41047 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeDXPLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:11:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="49535183"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: fix intel_dvo_dev_ops::mode_valid's return type
In-Reply-To: <20180424131500.2110-1-luc.vanoostenryck@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180424131500.2110-1-luc.vanoostenryck@gmail.com>
Date: Tue, 24 Apr 2018 18:11:47 +0300
Message-ID: <87in8gvdu4.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
> All implementations of the method intel_dvo_dev_ops::mode_valid(), as
> well as the underlying struct drm_connector_helper_funcs::mode_valid()
> use 'enum drm_mode_status' for the method's return type but the
> declaration of intel_dvo_dev_ops::mode_valid() uses an 'int' for it.
>
> Fix this by using 'enum drm_mode_status' for the declaration too.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/gpu/drm/i915/dvo.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/dvo.h b/drivers/gpu/drm/i915/dvo.h
> index 5e6a3013d..b6e143ebc 100644
> --- a/drivers/gpu/drm/i915/dvo.h
> +++ b/drivers/gpu/drm/i915/dvo.h
> @@ -74,7 +74,7 @@ struct intel_dvo_dev_ops {
>  	 *
>  	 * \return MODE_OK if the mode is valid, or another MODE_* otherwise.
>  	 */
> -	int (*mode_valid)(struct intel_dvo_device *dvo,
> +	enum drm_mode_status (*mode_valid)(struct intel_dvo_device *dvo,
>  			  struct drm_display_mode *mode);

Please adjust the alignment here as well. With that,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Oh, and as far as lists go, intel-gfx is sufficient.


>  
>  	/*

-- 
Jani Nikula, Intel Open Source Technology Center
