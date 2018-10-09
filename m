Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA2C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4332085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ol3fiJnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4332085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeJJESq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:18:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40795 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeJJESq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:18:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id s5-v6so1459302pfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUFbe82C/k6S3DVjMlr3VrKKaUcbXfLekMWSnkDrvYg=;
        b=ol3fiJnCiaBwiP16Pm78h7Z/J46/+URdUUJLJQOc95PeUeBafEV7cnQilGymDLxkQf
         0TSBEHOEErZiDAYK5w6ktGnoX+ReAM5osbAVT/ByB5+RC2+jrzODonv2bpVychTWEnc0
         bNt9MD/cZ4eJGw4QI5zhiVxmvfF6X07QB5KoVhfmibfW7bWcMidfMZdKZmhC7uA8kyx8
         vGqFzPkEdHGfivnGzYjaTR+XjioEvP0fRMYQUHiHl54Ha8fdjPNEP7PSVyONEFnV2RCf
         +Yz5FQavU/jbvNiCUJwauxmUoJYsoYVJBpaaCpUAkr0kcmK876GVS46dw8PVbDwwhLZV
         Km6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUFbe82C/k6S3DVjMlr3VrKKaUcbXfLekMWSnkDrvYg=;
        b=LUhsJZB6WhMbop51BIYJ6ySHAH8Ea1dufg5PE7EbPCGnw7GIgKkUueCf399PfIqOg1
         U5N4yhmu0LH9pktXvQR/zvtd9oIxXQf1EmHVNJl4GzTqSlkapzWSMc+RteGlWxotXFfJ
         XZP33WsyGA7g2NVeQbdFqCLPhWdejWvVFL1+Qf3bbLofHTK3NkPwfC1LDycEm4HOT9YJ
         HcjrykMxpmy5rHxp2dRzBLHOGXXAB8f0p18lsIj/U7t6o/MJO/n4Z/0suZJWO3dDW4/V
         oXZK1woPJuyDNfNUwtIGkW++Fq341tOLgtbCfE6S3Q4vvWDI/ymU0PDwU/lXhZ0G7wY6
         /tOA==
X-Gm-Message-State: ABuFfoijJKhnk4/UIoug9+c1G/vpVox2qqTi1grGJUeQQ4YZ7/orP3mS
        QwUtEbx5xApeutBlGa9cC0Op0/1YxSbkU0LrRlx2HA==
X-Google-Smtp-Source: ACcGV60T43+UVmW0t53O3HVguHp2jioYWqKiMR9iyNAU/uLFKcJZsC1ai+nbXeg1g6jmI4wEchj43ecU58aIuVhkRAI=
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr31825392pfd.32.1539118797873;
 Tue, 09 Oct 2018 13:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181009171401.14980-1-natechancellor@gmail.com>
In-Reply-To: <20181009171401.14980-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Oct 2018 13:59:46 -0700
Message-ID: <CAKwvOdm-oiVvuX_QDjQ1QcO3+=XowHEnHgj3PyQ4hY=thrJGNA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Convert _print_param to a macro
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 10:14 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building the kernel with Clang with defconfig and CONFIG_64BIT
> disabled, vmlinux fails to link because of the BUILD_BUG in
> _print_param.
>
> ld: drivers/gpu/drm/i915/i915_params.o: in function `i915_params_dump':
> i915_params.c:(.text+0x56): undefined reference to
> `__compiletime_assert_191'
>
> This function is semantically invalid unless the code is first inlined
> then constant folded, which doesn't work for Clang because semantic
> analysis happens before optimization/inlining. Converting this function
> to a macro avoids this problem and allows Clang to properly remove the
> BUILD_BUG during optimization.

Thanks Nathan for the patch.  To provide more context, Clang does
semantic analysis before optimization, where as GCC does these
together (IIUC).  So the above link error is from the naked
BUILD_BUG().  Clang can't evaluate the __builtin_strcmp's statically
until inlining has occurred, but that optimization happens after
semantic analysis.  To do the inlining before semantic analysis, we
MUST leverage the preprocessor, which runs before the compiler starts
doing semantic analysis.  I suspect this code is not valid for GCC
unless optimizations are enabled (the kernel only does compile with
optimizations turned on).  This change allows us to build this
translation unit with Clang.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>
(Note: this is the change I suggested, so not sure whether Acked-by or
Reviewed-by is more appropriate).

>
> The output of 'objdump -D' is identically before and after this change
> for GCC regardless of if CONFIG_64BIT is set and allows Clang to link
> the kernel successfully with or without CONFIG_64BIT set.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/191
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/i915/i915_params.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
> index 295e981e4a39..a0f20b9b6f2d 100644
> --- a/drivers/gpu/drm/i915/i915_params.c
> +++ b/drivers/gpu/drm/i915/i915_params.c
> @@ -174,22 +174,19 @@ i915_param_named(enable_dpcd_backlight, bool, 0600,
>  i915_param_named(enable_gvt, bool, 0400,
>         "Enable support for Intel GVT-g graphics virtualization host support(default:false)");
>
> -static __always_inline void _print_param(struct drm_printer *p,
> -                                        const char *name,
> -                                        const char *type,
> -                                        const void *x)
> -{
> -       if (!__builtin_strcmp(type, "bool"))
> -               drm_printf(p, "i915.%s=%s\n", name, yesno(*(const bool *)x));
> -       else if (!__builtin_strcmp(type, "int"))
> -               drm_printf(p, "i915.%s=%d\n", name, *(const int *)x);
> -       else if (!__builtin_strcmp(type, "unsigned int"))
> -               drm_printf(p, "i915.%s=%u\n", name, *(const unsigned int *)x);
> -       else if (!__builtin_strcmp(type, "char *"))
> -               drm_printf(p, "i915.%s=%s\n", name, *(const char **)x);
> -       else
> -               BUILD_BUG();
> -}
> +#define _print_param(p, name, type, x)                                        \
> +do {                                                                          \
> +       if (!__builtin_strcmp(type, "bool"))                                   \
> +               drm_printf(p, "i915.%s=%s\n", name, yesno(*(const bool *)x));  \
> +       else if (!__builtin_strcmp(type, "int"))                               \
> +               drm_printf(p, "i915.%s=%d\n", name, *(const int *)x);          \
> +       else if (!__builtin_strcmp(type, "unsigned int"))                      \
> +               drm_printf(p, "i915.%s=%u\n", name, *(const unsigned int *)x); \
> +       else if (!__builtin_strcmp(type, "char *"))                            \
> +               drm_printf(p, "i915.%s=%s\n", name, *(const char **)x);        \
> +       else                                                                   \
> +               BUILD_BUG();                                                   \
> +} while (0)
>
>  /**
>   * i915_params_dump - dump i915 modparams
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
