Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A5C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 21:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E5320C0E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 21:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gOxW+0mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E5320C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeHTAgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 20:36:46 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44932 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeHTAgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 20:36:45 -0400
Received: by mail-yb0-f195.google.com with SMTP id l16-v6so3877806ybk.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=74gS9sQkdTaSrlE0o4D0kXe5m8bw3kv0T5SXinvLgkI=;
        b=gOxW+0mMtBymSc/tVATMxb97tRbiNhMtoPcmbH/P6BabR18xkyY8eiawvr1CIDzy+I
         HGzBYVJR+2o4iRpa64QyI55xz9F4mIrV6JPP/XrssMpS1qcfj803iRPR9Fu8EmclBVLx
         4iKD91R7wFVPK0Feh+hMORCrp8SHz+iuxhnMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=74gS9sQkdTaSrlE0o4D0kXe5m8bw3kv0T5SXinvLgkI=;
        b=Zzz57hWAHE39h7zPPZLMPtdK81oaVxmYf8SReHi7ChCVIq5+CnMY5JpISy/6GVlaZR
         sg5Zc0+fSrVnvXcqUh4RBe3e4fw5O9zC1YRkZ9Bo6p6TD9LwWaT9Vw2Z/mWFwK++ENRS
         qi7GqW6M4m3A2zhBlbFSWa6i5TjGRB8MXs0fPUg9AY0mJn52q+EmCZo0A6u/ggkCLOhk
         YSWpuxY0Jtd1/D5qNE/V8llKt2HUCi016pX3U5sEt0Y4//lNqq8iFXi89tEXCRFID5Z1
         MK14du6QXUbdZX8SSC0qaxr0djGMz8knEerxJ17V7g3XuZL9Xq39WJ0NZuoGa3Roa3BM
         +o3g==
X-Gm-Message-State: AOUpUlEMzst7hlt7anEYdvmbaIUA4pr3M8xLVuqthiPm9KSeg3G55EEg
        wEu7QUMB9iMMMYLOQpX93uzOwnmpkj0=
X-Google-Smtp-Source: AA+uWPwftL6fBWRav9kHz05lxPukJpIMrdIeA8+CDYpenb/wSWvenSa4LlbL0KMdmMo/jWs2/YUPZw==
X-Received: by 2002:a25:2b49:: with SMTP id r70-v6mr21748090ybr.231.1534713832516;
        Sun, 19 Aug 2018 14:23:52 -0700 (PDT)
Received: from mail-yb0-f178.google.com (mail-yb0-f178.google.com. [209.85.213.178])
        by smtp.gmail.com with ESMTPSA id d6-v6sm3648397ywa.85.2018.08.19.14.23.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 14:23:50 -0700 (PDT)
Received: by mail-yb0-f178.google.com with SMTP id o17-v6so3876778yba.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 14:23:50 -0700 (PDT)
X-Received: by 2002:a25:1345:: with SMTP id 66-v6mr11180285ybt.171.1534713830093;
 Sun, 19 Aug 2018 14:23:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:aa31:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 14:23:49
 -0700 (PDT)
In-Reply-To: <4cdd4ab9ddd16f1fb168266643264595782fd890.camel@perches.com>
References: <20180814170904.GA12768@roeck-us.net> <4cdd4ab9ddd16f1fb168266643264595782fd890.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 19 Aug 2018 14:23:49 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLHtT2WfYNDmnkxcZWp6yb7GmDjVscK-9umhPU+0ARRRw@mail.gmail.com>
Message-ID: <CAGXu5jLHtT2WfYNDmnkxcZWp6yb7GmDjVscK-9umhPU+0ARRRw@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     Joe Perches <joe@perches.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 10:48 AM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-08-14 at 10:09 -0700, Guenter Roeck wrote:
>> Hi,
>>
>> Since commit c1a2f7f0c0645 ("mm: Allocate the mm_cpumask
>> (mm->cpu_bitmap[]) dynamically based on nr_cpu_ids"), building
>> the Linux kernel with gcc version 4.5 and older fails as follows.
>>
>> In file included from ./include/linux/mm.h:17:0,
>>                  from ./include/linux/pid_namespace.h:7,
>>                from ./include/linux/ptrace.h:10,
>>                from arch/openrisc/kernel/asm-offsets.c:32:
>> ./include/linux/mm_types.h:497:16: error: flexible array member in otherwise empty struct
>>
>> This is just an example with gcc 4.5.1 for or32. I have seen the problem
>> with gcc 4.4 (for unicore32) as well.
>>
>> Does that mean that gcc 4.5 and older are now officially no longer
>> supported for compiling the kernel ?
>>
>> If so, would it make sense to update include/linux/compiler-gcc.h
>> accordingly ?
>
> And Documentation/process/changes.rst which shows a
> minimum version required of gcc as 3.2, etc...
>
> With cleaning up now unnecessary version tests in
> compiler-gcc.h, something like:

I rejoice at raising the minimum gcc to version 4.6! :)

> ---
>  Documentation/process/changes.rst |  2 +-
>  include/linux/compiler-gcc.h      | 86 ++++++++-------------------------------
>  2 files changed, 19 insertions(+), 69 deletions(-)

These look good, thanks:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 7a92a06f90de..61f918b10a0c 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -29,7 +29,7 @@ you probably needn't concern yourself with isdn4k-utils.
>  ====================== ===============  ========================================
>          Program        Minimal version       Command to check the version
>  ====================== ===============  ========================================
> -GNU C                  3.2              gcc --version
> +GNU C                  4.6              gcc --version
>  GNU make               3.81             make --version
>  binutils               2.20             ld -v
>  flex                   2.5.35           flex --version
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 573f5a7d42d4..020e4b9eee5c 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -10,6 +10,10 @@
>                      + __GNUC_MINOR__ * 100     \
>                      + __GNUC_PATCHLEVEL__)
>
> +#if GCC_VERSION < 40600
> +# error Sorry, your compiler is too old - please upgrade it.
> +#endif
> +
>  /* Optimization barrier */
>
>  /* The "volatile" is due to gcc bugs */
> @@ -58,6 +62,12 @@
>  #define OPTIMIZER_HIDE_VAR(var)                                                \
>         __asm__ ("" : "=r" (var) : "0" (var))
>
> +/*
> + * A trick to suppress uninitialized variable warning without generating any
> + * code
> + */
> +#define uninitialized_var(x) x = x
> +
>  #ifdef __CHECKER__
>  #define __must_be_array(a)     0
>  #else
> @@ -91,7 +101,7 @@
>   * A lot of inline functions can cause havoc with function tracing.
>   */
>  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||               \
> -    !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
> +    !defined(CONFIG_OPTIMIZE_INLINING)
>  #define inline \
>         inline __attribute__((always_inline, unused)) notrace __gnu_inline
>  #else
> @@ -148,47 +158,13 @@
>  #define __always_unused                __attribute__((unused))
>  #define __mode(x)               __attribute__((mode(x)))
>
> -/* gcc version specific checks */
> -
> -#if GCC_VERSION < 30200
> -# error Sorry, your compiler is too old - please upgrade it.
> -#endif
> -
> -#if GCC_VERSION < 30300
> -# define __used                        __attribute__((__unused__))
> -#else
> -# define __used                        __attribute__((__used__))
> -#endif
> -
> -#ifdef CONFIG_GCOV_KERNEL
> -# if GCC_VERSION < 30400
> -#   error "GCOV profiling support for gcc versions below 3.4 not included"
> -# endif /* __GNUC_MINOR__ */
> -#endif /* CONFIG_GCOV_KERNEL */
> -
> -#if GCC_VERSION >= 30400
>  #define __must_check           __attribute__((warn_unused_result))
>  #define __malloc               __attribute__((__malloc__))
> -#endif
> -
> -#if GCC_VERSION >= 40000
> -
> -/* GCC 4.1.[01] miscompiles __weak */
> -#ifdef __KERNEL__
> -# if GCC_VERSION >= 40100 &&  GCC_VERSION <= 40101
> -#  error Your version of gcc miscompiles the __weak directive
> -# endif
> -#endif
>
>  #define __used                 __attribute__((__used__))
>  #define __compiler_offsetof(a, b)                                      \
>         __builtin_offsetof(a, b)
>
> -#if GCC_VERSION >= 40100
> -# define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
> -#endif
> -
> -#if GCC_VERSION >= 40300
>  /* Mark functions as cold. gcc will assume any path leading to a call
>   * to them will be unlikely.  This means a lot of manual unlikely()s
>   * are unnecessary now for any paths leading to the usual suspects
> @@ -207,24 +183,19 @@
>
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>
> -#ifndef __CHECKER__
> -# define __compiletime_warning(message) __attribute__((warning(message)))
> -# define __compiletime_error(message) __attribute__((error(message)))
> -#endif /* __CHECKER__ */
> -#endif /* GCC_VERSION >= 40300 */
> -
> -#if GCC_VERSION >= 40400
>  #define __optimize(level)      __attribute__((__optimize__(level)))
>  #define __nostackprotector     __optimize("no-stack-protector")
> -#endif /* GCC_VERSION >= 40400 */
>
> -#if GCC_VERSION >= 40500
> +#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>
>  #ifndef __CHECKER__
> +#define __compiletime_warning(message) __attribute__((warning(message)))
> +#define __compiletime_error(message) __attribute__((error(message)))
> +
>  #ifdef LATENT_ENTROPY_PLUGIN
>  #define __latent_entropy __attribute__((latent_entropy))
>  #endif
> -#endif
> +#endif /* __CHECKER__ */
>
>  /*
>   * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
> @@ -262,10 +233,6 @@
>  #define randomized_struct_fields_end   } __randomize_layout;
>  #endif
>
> -#endif /* GCC_VERSION >= 40500 */
> -
> -#if GCC_VERSION >= 40600
> -
>  /*
>   * When used with Link Time Optimization, gcc can optimize away C functions or
>   * variables which are referenced only from assembly code.  __visible tells the
> @@ -274,8 +241,7 @@
>   */
>  #define __visible      __attribute__((externally_visible))
>
> -#endif /* GCC_VERSION >= 40600 */
> -
> +/* gcc version specific checks */
>
>  #if GCC_VERSION >= 40900 && !defined(__CHECKER__)
>  /*
> @@ -309,10 +275,8 @@
>   * folding in __builtin_bswap*() (yet), so don't set these for it.
>   */
>  #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
> -#if GCC_VERSION >= 40400
>  #define __HAVE_BUILTIN_BSWAP32__
>  #define __HAVE_BUILTIN_BSWAP64__
> -#endif
>  #if GCC_VERSION >= 40800
>  #define __HAVE_BUILTIN_BSWAP16__
>  #endif
> @@ -341,10 +305,9 @@
>   * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
>   */
>  #define __designated_init __attribute__((designated_init))
> +#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
>
> -#endif /* gcc version >= 40000 specific checks */
> -
>  #if !defined(__noclone)
>  #define __noclone      /* not needed */
>  #endif
> @@ -353,16 +316,6 @@
>  #define __no_sanitize_address
>  #endif
>
> -/*
> - * A trick to suppress uninitialized variable warning without generating any
> - * code
> - */
> -#define uninitialized_var(x) x = x
> -
> -#if GCC_VERSION >= 50100
> -#define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
> -#endif
> -
>  /*
>   * Turn individual warnings and errors on and off locally, depending
>   * on version.
> @@ -375,12 +328,9 @@
>  #define __diag_GCC_warn                warning
>  #define __diag_GCC_error       error
>
> -/* Compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
> -#if GCC_VERSION >= 40600
>  #define __diag_str1(s)         #s
>  #define __diag_str(s)          __diag_str1(s)
>  #define __diag(s)              _Pragma(__diag_str(GCC diagnostic s))
> -#endif
>
>  #if GCC_VERSION >= 80000
>  #define __diag_GCC_8(s)                __diag(s)
>
>
>



-- 
Kees Cook
Pixel Security
