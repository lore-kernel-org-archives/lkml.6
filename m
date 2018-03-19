Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeCSIVx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:21:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:50957 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbeCSIVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:21:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="scan'208";a="25155646"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Matthias Kaehlcke <mka@chromium.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] drm/i915: Disable some extra clang warnings
In-Reply-To: <20180317003151.252750-1-mka@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180317003151.252750-1-mka@chromium.org>
Date: Mon, 19 Mar 2018 10:21:34 +0200
Message-ID: <87vads1nn5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018, Matthias Kaehlcke <mka@chromium.org> wrote:
> Commit 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
> warnings to full") enabled extra warnings for i915 to spot possible
> bugs in new code, and then disabled a subset of these warnings to keep
> the current code building without warnings (with gcc). Enabling the
> extra warnings also enabled some additional clang-only warnings, as a
> result building i915 with clang currently is extremely noisy. For now
> also disable the clang warnings sign-compare, sometimes-uninitialized,
> unneeded-internal-declaration and initializer-overrides. If desired
> they can be re-enabled after the code has been fixed.
>
> Fixes: 39bf4de89ff7 ("drm/i915: Add -Wall -Wextra to our build, set
> warnings to full")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Thanks for the patch, I think it's the right thing to do. I'm afraid it
doesn't apply to current code, however. Please rebase on top of drm-tip
branch of [1].

> ---
>  drivers/gpu/drm/i915/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 091aef281963..ad05796a96ba 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -17,6 +17,10 @@ subdir-ccflags-y += $(call cc-disable-warning, unused-parameter)
>  subdir-ccflags-y += $(call cc-disable-warning, type-limits)
>  subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
>  subdir-ccflags-y += $(call cc-disable-warning, implicit-fallthrough)

While at it, please add a comment here noting that the below disables
are for Clang.

Thanks,
Jani.

[1] https://bugs.freedesktop.org/enter_bug.cgi?product=DRI&component=DRM/Intel


> +subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
> +subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
> +subdir-ccflags-y += $(call cc-disable-warning, unneeded-internal-declaration)
> +subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
>  subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
>  
>  # Fine grained warnings disable

-- 
Jani Nikula, Intel Open Source Technology Center
