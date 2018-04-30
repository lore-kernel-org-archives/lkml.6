Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756528AbeD3TbZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:31:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38882 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755890AbeD3TbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:31:21 -0400
X-Google-Smtp-Source: AB8JxZpRSGeLdkYk+M+tc3kYAqenAs0IgXKk4lOXStr54Zatq8zHuuVf3iLgw/H44feogbML598hjQ==
Date: Mon, 30 Apr 2018 12:31:19 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2] drm/i915: Disable some extra clang warnings
Message-ID: <20180430193119.GB133494@google.com>
References: <20180319191451.83910-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180319191451.83910-1-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 12:14:51PM -0700, Matthias Kaehlcke wrote:
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
> ---
> Changes in v2:
> - rebased on drm-tip
> - added comment indicating that disabled warnings are clang warnings
> 
>  drivers/gpu/drm/i915/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 4eee91a3a236..9717c037b582 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -18,6 +18,11 @@ subdir-ccflags-y += $(call cc-disable-warning, type-limits)
>  subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
>  subdir-ccflags-y += $(call cc-disable-warning, implicit-fallthrough)
>  subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
> +# clang warnings
> +subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
> +subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
> +subdir-ccflags-y += $(call cc-disable-warning, unneeded-internal-declaration)
> +subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
>  subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
>  
>  # Fine grained warnings disable

Ping, it seems this one swept under the radar

Thanks

Matthias
