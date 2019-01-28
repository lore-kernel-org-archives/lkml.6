Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A807C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619E621738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfA1Ljs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:39:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:56363 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1Ljs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 06:39:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 03:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; 
   d="scan'208";a="141978751"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jan 2019 03:39:41 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v6 2/5] drm/i915: prepare for drmP.h removal from drm_modeset_helper.h
In-Reply-To: <20190126122527.11647-3-sam@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190126122527.11647-1-sam@ravnborg.org> <20190126122527.11647-3-sam@ravnborg.org>
Date:   Mon, 28 Jan 2019 13:41:20 +0200
Message-ID: <8736pd102n.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2019, Sam Ravnborg <sam@ravnborg.org> wrote:
> The use of drmP.h is discouraged and removal of it from
> drm_modeset_helper.h caused i915 to fail to build.
>
> This patch introduce the necessary fixes to prepare for the
> drmP.h removal from drm_modeset_helper.h.
>
> In the files touched the lists of include files was grouped
> and sorted.
>
> Build tested on x86 and arm allmodconfig / allyesconfig.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: intel-gfx@lists.freedesktop.org

Not going to second-guess the compiler, looks good to me,

Acked-by: Jani Nikula <jani.nikula@intel.com>

and good to merge via whichever tree you see fit.


> ---
>  drivers/gpu/drm/i915/i915_drv.c           |  4 +++-
>  drivers/gpu/drm/i915/intel_atomic.c       |  2 ++
>  drivers/gpu/drm/i915/intel_atomic_plane.c |  2 ++
>  drivers/gpu/drm/i915/intel_display.c      | 29 ++++++++++++++++-------------
>  drivers/gpu/drm/i915/intel_pm.c           |  7 +++++--
>  5 files changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 9883921013b1..8c8f36a91e7e 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -41,8 +41,10 @@
>  #include <linux/vt.h>
>  #include <acpi/video.h>
>  
> -#include <drm/drm_probe_helper.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_ioctl.h>
> +#include <drm/drm_irq.h>
> +#include <drm/drm_probe_helper.h>
>  #include <drm/i915_drm.h>
>  
>  #include "i915_drv.h"
> diff --git a/drivers/gpu/drm/i915/intel_atomic.c b/drivers/gpu/drm/i915/intel_atomic.c
> index d8dbc9980281..f415ed239184 100644
> --- a/drivers/gpu/drm/i915/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/intel_atomic.c
> @@ -31,7 +31,9 @@
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_plane_helper.h>
> +
>  #include "intel_drv.h"
>  
>  /**
> diff --git a/drivers/gpu/drm/i915/intel_atomic_plane.c b/drivers/gpu/drm/i915/intel_atomic_plane.c
> index 683a75dad4fb..79139d496c78 100644
> --- a/drivers/gpu/drm/i915/intel_atomic_plane.c
> +++ b/drivers/gpu/drm/i915/intel_atomic_plane.c
> @@ -32,7 +32,9 @@
>   */
>  
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_plane_helper.h>
> +
>  #include "intel_drv.h"
>  
>  struct intel_plane *intel_plane_alloc(void)
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index 15d758cd0c1b..e0f40be07131 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -24,29 +24,32 @@
>   *	Eric Anholt <eric@anholt.net>
>   */
>  
> -#include <linux/module.h>
> -#include <linux/input.h>
>  #include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/intel-iommu.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/reservation.h>
>  #include <linux/slab.h>
>  #include <linux/vgaarb.h>
> -#include <drm/drm_edid.h>
> -#include "intel_drv.h"
> -#include "intel_frontbuffer.h"
> -#include <drm/i915_drm.h>
> -#include "i915_drv.h"
> -#include "i915_gem_clflush.h"
> -#include "intel_dsi.h"
> -#include "i915_trace.h"
> +
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_dp_helper.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_rect.h>
> -#include <drm/drm_atomic_uapi.h>
> -#include <linux/intel-iommu.h>
> -#include <linux/reservation.h>
> +#include <drm/i915_drm.h>
> +
> +#include "i915_drv.h"
> +#include "i915_gem_clflush.h"
> +#include "i915_trace.h"
> +#include "intel_drv.h"
> +#include "intel_dsi.h"
> +#include "intel_frontbuffer.h"
>  
>  /* Primary plane formats for gen <= 3 */
>  static const uint32_t i8xx_primary_formats[] = {
> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> index 83b01cde8113..48c755dc895b 100644
> --- a/drivers/gpu/drm/i915/intel_pm.c
> +++ b/drivers/gpu/drm/i915/intel_pm.c
> @@ -26,13 +26,16 @@
>   */
>  
>  #include <linux/cpufreq.h>
> +#include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_plane_helper.h>
> +
>  #include "i915_drv.h"
>  #include "intel_drv.h"
>  #include "../../../platform/x86/intel_ips.h"
> -#include <linux/module.h>
> -#include <drm/drm_atomic_helper.h>
>  
>  /**
>   * DOC: RC6

-- 
Jani Nikula, Intel Open Source Graphics Center
