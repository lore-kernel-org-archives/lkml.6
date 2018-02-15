Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbeBOJN2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:13:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:41468 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755069AbeBOJNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:13:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,516,1511856000";
   d="scan'208";a="30944742"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] drm/i915/selftests: fix inconsistent IS_ERR and PTR_ERR
In-Reply-To: <20180214211234.GA22341@embeddedgus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180214211234.GA22341@embeddedgus>
Date: Thu, 15 Feb 2018 11:13:15 +0200
Message-ID: <87vaey4nv8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> Fix inconsistent IS_ERR and PTR_ERR in shrink_boom.
> The proper pointer to use is _explode_ instead of _purge_.
>
> This issue was detected with the help of Coccinelle.
>
> Fixes: fe215c8bc426 ("drm/i915/selftests: add missing gtt shrinker test")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

(Having some issues with fdo connections, thus not pushing.)

> ---
>  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> index d806427..89b6ca9 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
> @@ -927,7 +927,7 @@ static int shrink_boom(struct drm_i915_private *i915,
>  
>  		explode = fake_dma_object(i915, size);
>  		if (IS_ERR(explode)) {
> -			err = PTR_ERR(purge);
> +			err = PTR_ERR(explode);
>  			goto err_purge;
>  		}

-- 
Jani Nikula, Intel Open Source Technology Center
