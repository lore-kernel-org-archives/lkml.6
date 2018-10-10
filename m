Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA72C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659D12087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKl6uUtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659D12087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeJKEFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:05:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40458 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJKEFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:05:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so3053198pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zouda5K5q/s7cngJMUA04fccxr43MQZEUh9/l7s4a00=;
        b=AKl6uUtLglAH+svEK0vsxHVGQwO42vIF8ISeh/hwocuzCAmPisG0Iy0FsbaeCcosww
         nCf7v5q3JvHdJ/uo/6Q7DkUmMvRt0qyqYXlJPoAoXNEAyslyvlk2q68zV0Lb70a4uArp
         7HLspR/q5BOOP7pfxiCw57dXZGiffgWgZfP/mWo+4XIq4LCC3kfvtHE3NFJPPjxS46kI
         OrWcxT4S1VEsiIiDUIJ52blTOpXtPOHBVY+tIYp94li4ViKpNwMVJuJfXmbJ4o7S7Mft
         uCtxhu4+5Gl2ZpV34qHnp7R3nGRiOWunWiu8ELdyO9M6M2iDYocAXO55XGI9mLoqIUa9
         P8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zouda5K5q/s7cngJMUA04fccxr43MQZEUh9/l7s4a00=;
        b=Mgop1IP0UiJ+xYOeadPfd0Ul9tIpBuQgAX17XyIUENQHqkxJWE8DJmJCEzRKZKXXlE
         jE57o/0RNMBEUBVwKB1x8DsJT1fdlKsMOKmY+LRxXFfUX+sjGXkY+Mb7OtrwxjSEB5Ne
         TJf8Fct/XI1JVfhyAkFmnqtiStx8IGAOBxVyzKPlP6E5r7hVlsKBGfuqZ7UL9G0aa8WJ
         a23LIxdNh1xMR+7A/DQIBgK0xwgG0dNJlq25XyEK5/DXU+5T6WCafLjqDKQFcKJXDhYR
         eae/oNe0oEDqK0Sw38O5rsIgZ1GL3F8+j1Uo++UG+BGolbqCLbgKEFVgodm9BoIBMI2W
         v6kA==
X-Gm-Message-State: ABuFfohkhQprQlePiqnbPr+hJHETGWUaCzMGOc41liiNQ0bj8wh+PJqp
        HDD+9RZArh0ni7qXwwAY6V/Sp94c+Me8x2Lu7hghhRqD+58=
X-Google-Smtp-Source: ACcGV60CpUAKV/Apmp5B5Z7kyDBsXDxEHHy3PjRBUbqXdDpksnvkAVNWnz0/JLYA6mFoAeLiBqHtNgVXSxJ+kN/dzyk=
X-Received: by 2002:a62:4b09:: with SMTP id y9-v6mr36169795pfa.93.1539204109045;
 Wed, 10 Oct 2018 13:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181009171401.14980-1-natechancellor@gmail.com>
 <CAKwvOdm-oiVvuX_QDjQ1QcO3+=XowHEnHgj3PyQ4hY=thrJGNA@mail.gmail.com>
 <87woqqm2mz.fsf@intel.com> <op.zqoq8ui3xaggs7@mwajdecz-mobl1.ger.corp.intel.com>
In-Reply-To: <op.zqoq8ui3xaggs7@mwajdecz-mobl1.ger.corp.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Oct 2018 13:41:37 -0700
Message-ID: <CAKwvOdmkp_xOyAikmQRVJN6E4_OUDZHm20u9=Ai6Mw9G5yxGxg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Convert _print_param to a macro
To:     michal.wajdeczko@intel.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        jani.nikula@linux.intel.com, intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 1:30 PM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> On Wed, 10 Oct 2018 14:01:40 +0200, Jani Nikula
> <jani.nikula@linux.intel.com> wrote:
>
> > On Tue, 09 Oct 2018, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >> On Tue, Oct 9, 2018 at 10:14 AM Nathan Chancellor
> >> <natechancellor@gmail.com> wrote:
> >>>
> >>> When building the kernel with Clang with defconfig and CONFIG_64BIT
> >>> disabled, vmlinux fails to link because of the BUILD_BUG in
> >>> _print_param.
> >>>
> >>> ld: drivers/gpu/drm/i915/i915_params.o: in function `i915_params_dump':
> >>> i915_params.c:(.text+0x56): undefined reference to
> >>> `__compiletime_assert_191'
> >>>
> >>> This function is semantically invalid unless the code is first inlined
> >>> then constant folded, which doesn't work for Clang because semantic
> >>> analysis happens before optimization/inlining. Converting this function
> >>> to a macro avoids this problem and allows Clang to properly remove the
> >>> BUILD_BUG during optimization.
> >>
> >> Thanks Nathan for the patch.  To provide more context, Clang does
> >> semantic analysis before optimization, where as GCC does these
> >> together (IIUC).  So the above link error is from the naked
> >> BUILD_BUG().  Clang can't evaluate the __builtin_strcmp's statically
> >> until inlining has occurred, but that optimization happens after
> >> semantic analysis.  To do the inlining before semantic analysis, we
> >> MUST leverage the preprocessor, which runs before the compiler starts
> >> doing semantic analysis.  I suspect this code is not valid for GCC
> >> unless optimizations are enabled (the kernel only does compile with
> >> optimizations turned on).  This change allows us to build this
> >> translation unit with Clang.
> >>
> >> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> >> (Note: this is the change I suggested, so not sure whether Acked-by or
> >> Reviewed-by is more appropriate).
> >
> > *Sad trombone*
> >
> > I'd rather see us converting more macros to static inlines than the
> > other way round.
> >
> > I'll let others chime in if they have any better ideas, otherwise I'll
> > apply this one.
>
> Option 1: Just drop BUILD_BUG() from _print_param() function.

I was also thinking of this.

>
> Option 2: Use aliases instead of real types in param() macros.

Will that affect other users of I915_PARAMS_FOR_EACH than _print_param?

Either way, thanks for the help towards resolving this! We appreciate it!

>
> Aliases can be same as in linux/moduleparam.h (charp|int|uint|bool)
> We can convert aliases back to real types but it will also allow
> to construct proper names for dedicated functions - see [1]
>
> Michal
>
> [1] https://patchwork.freedesktop.org/patch/255928/
>
>
> >
> > BR,
> > Jani.
> >
> >>
> >>>
> >>> The output of 'objdump -D' is identically before and after this change
> >>> for GCC regardless of if CONFIG_64BIT is set and allows Clang to link
> >>> the kernel successfully with or without CONFIG_64BIT set.
> >>>
> >>> Link: https://github.com/ClangBuiltLinux/linux/issues/191
> >>> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> >>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >>> ---
> >>>  drivers/gpu/drm/i915/i915_params.c | 29 +++++++++++++----------------
> >>>  1 file changed, 13 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/i915/i915_params.c
> >>> b/drivers/gpu/drm/i915/i915_params.c
> >>> index 295e981e4a39..a0f20b9b6f2d 100644
> >>> --- a/drivers/gpu/drm/i915/i915_params.c
> >>> +++ b/drivers/gpu/drm/i915/i915_params.c
> >>> @@ -174,22 +174,19 @@ i915_param_named(enable_dpcd_backlight, bool,
> >>> 0600,
> >>>  i915_param_named(enable_gvt, bool, 0400,
> >>>         "Enable support for Intel GVT-g graphics virtualization host
> >>> support(default:false)");
> >>>
> >>> -static __always_inline void _print_param(struct drm_printer *p,
> >>> -                                        const char *name,
> >>> -                                        const char *type,
> >>> -                                        const void *x)
> >>> -{
> >>> -       if (!__builtin_strcmp(type, "bool"))
> >>> -               drm_printf(p, "i915.%s=%s\n", name, yesno(*(const bool
> >>> *)x));
> >>> -       else if (!__builtin_strcmp(type, "int"))
> >>> -               drm_printf(p, "i915.%s=%d\n", name, *(const int *)x);
> >>> -       else if (!__builtin_strcmp(type, "unsigned int"))
> >>> -               drm_printf(p, "i915.%s=%u\n", name, *(const unsigned
> >>> int *)x);
> >>> -       else if (!__builtin_strcmp(type, "char *"))
> >>> -               drm_printf(p, "i915.%s=%s\n", name, *(const char **)x);
> >>> -       else
> >>> -               BUILD_BUG();
> >>> -}
> >>> +#define _print_param(p, name, type,
> >>> x)                                        \
> >>> +do
> >>> {
> >>> \
> >>> +       if (!__builtin_strcmp(type,
> >>> "bool"))                                   \
> >>> +               drm_printf(p, "i915.%s=%s\n", name, yesno(*(const bool
> >>> *)x));  \
> >>> +       else if (!__builtin_strcmp(type,
> >>> "int"))                               \
> >>> +               drm_printf(p, "i915.%s=%d\n", name, *(const int
> >>> *)x);          \
> >>> +       else if (!__builtin_strcmp(type, "unsigned
> >>> int"))                      \
> >>> +               drm_printf(p, "i915.%s=%u\n", name, *(const unsigned
> >>> int *)x); \
> >>> +       else if (!__builtin_strcmp(type, "char
> >>> *"))                            \
> >>> +               drm_printf(p, "i915.%s=%s\n", name, *(const char
> >>> **)x);        \
> >>> +
> >>> else
> >>> \
> >>> +
> >>> BUILD_BUG();                                                   \
> >>> +} while (0)
> >>>
> >>>  /**
> >>>   * i915_params_dump - dump i915 modparams
> >>> --
> >>> 2.19.0
> >>>



-- 
Thanks,
~Nick Desaulniers
