Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeD3KVh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:21:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:60090 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbeD3KVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:21:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51102190"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH 5/6] backlight: Also nuke BL_CORE_DRIVER1
In-Reply-To: <20180425174253.4616-5-daniel.vetter@ffwll.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch> <20180425174253.4616-5-daniel.vetter@ffwll.ch>
Date: Mon, 30 Apr 2018 13:24:16 +0300
Message-ID: <87d0yh9elr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> Now that the 3 drivers using this are cleaned up we can also remove
> this final bit of confusion of leaking driver internals into the
> backlight power interface.
>
> The backlight power interface itself is still a massive mess.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  include/linux/backlight.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 1db67662bfcb..7fbf0539e14a 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -84,7 +84,6 @@ struct backlight_properties {
>  
>  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
>  #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
> -#define BL_CORE_DRIVER1		(1 << 31)	/* reserved for driver specific use */

Please also remove the

	/* Upper 4 bits are reserved for driver internal use */

comment a few lines up to not give anyone ideas.

With that,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>  
>  };

-- 
Jani Nikula, Intel Open Source Technology Center
