Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364AA20890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfZzgd8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364AA20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeGaBDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:03:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40255 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeGaBDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:03:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id y9-v6so1088979wma.5;
        Mon, 30 Jul 2018 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RdwfxZoOiZm5xJTAx5mQSBLpC9cIYskrgL/mGIAANKg=;
        b=EfZzgd8C76UyuUqup6UXWIx4Ilj69Lyzo5mxytJU+IyJhUUDlU2sjee+kTGsbWtBxi
         ptClYRlCe7zkmvg0ZjGngWes2uSkuapF+PcwQWh0rmPp1kB4zMqEcuEOfXkOmHcYKaB/
         Q5+sKkW0lP9Q9BkBIt/o//IEH8j+NCvHaMYnzxYpgPxjtgVOt461mVzvkDVKhaIlyrQy
         MQKfBDduffQw/ZYmY9d5Ph1qpiHPRLrjwPmLYm6j3A1ovR1h5yxwzZcZrEgeC+40Z7HQ
         h+kFUF1aF2GvEbqY1e0EAhqIUwSkvaXN9k2P5axHQnpB4n1uRN1Uj6thSjRf8g/2TbEf
         IYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RdwfxZoOiZm5xJTAx5mQSBLpC9cIYskrgL/mGIAANKg=;
        b=TuPfbss5sgMXT+2SPFrYKKZM0j79hMgVO5no2C4yl/QjTCV1UnrsTk05CG5xcqbclN
         cuBYjmceJ+1iYwVrqGECGvsM4f3OIe81pusvQr9BZ9DyMbEjGXmImQLKOJow8RlXBOmU
         6uXmDS7r5DufPBylKvTx1Wb0OOKtoFUQkyDKeh5tThv5zYtglK8cuLnnClrQwjZ6FREe
         NllihSzaXlBh1F34X/qt+CBfGDzDaNwAlSh27z8e7/dD7MX55NdI6doL2w8jrryqonN1
         blQq55agZYeJf0Pe7EN1lrZb+cVC95mIac0fQDcqJ7g6X+1GgYMtEApWmudLzzSCqwo3
         VLHw==
X-Gm-Message-State: AOUpUlHEsANyjQL2rFONCtEQIHNNyNa9eOWPCKHjbF5O9s527CnDJw13
        ArRlPh3pjfytdlL1kDyln3A=
X-Google-Smtp-Source: AAOMgpczMpIcv0wFCazcXY0JD15iXe1JaIkyAypAxsKSyc7atP1jD+I+MpVpeSx4CFVqoNYUkFTQXg==
X-Received: by 2002:a1c:5e08:: with SMTP id s8-v6mr758406wmb.88.1532993157575;
        Mon, 30 Jul 2018 16:25:57 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g18-v6sm604207wmh.21.2018.07.30.16.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:25:56 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:25:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, paul.burton@mips.com,
        christophe.leroy@c-s.fr, shorne@gmail.com,
        yamada.masahiro@socionext.com, keescook@chromium.org,
        mingo@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        rdunlap@infradead.org, bp@suse.de, neilb@suse.com,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dwmw@amazon.co.uk, sandipan@linux.vnet.ibm.com,
        linux@rasmusvillemoes.dk, paullawrence@google.com,
        andreyknvl@google.com, will.deacon@arm.com, ghackmann@android.com,
        stable@vger.kernel.org, ghackmann@google.com, mka@chromium.org,
        jpoimboe@redhat.com, wvw@google.com, avagin@openvz.org
Subject: Re: [PATCH v2 1/2] compiler-clang.h: Add CLANG_VERSION and __diag
 macros
Message-ID: <20180730232554.GA16996@flashbox>
References: <20180730213412.242849-1-ndesaulniers@google.com>
 <20180730213412.242849-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730213412.242849-2-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:34:11PM -0700, Nick Desaulniers wrote:
> These are needed for doing proper version checks, though feature
> detection via __has_attribute,  __has_builtin, and __has_feature should
> be preferred, see:
> https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros
> 
> Also adds __diag support, for generating compiler version specific
> _Pragma()'s.
> 
> __diag support based on commit 8793bb7f4a9d ("kbuild: add macro for
> controlling warnings to linux/compiler.h")
> 
> Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Tested-and-reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  include/linux/compiler-clang.h | 19 +++++++++++++++++++
>  include/linux/compiler_types.h |  4 ++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 7087446c24c8..9442e07a361e 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -7,6 +7,10 @@
>   * for Clang compiler
>   */
>  
> +#define CLANG_VERSION (__clang_major__ * 10000	\
> +		       + __clang_minor__ * 100	\
> +		       + __clang_patchlevel__)
> +

I know this was done to be consistent with GCC_VERSION but certain
toolchains may set the patch level to the SVN revision (at least that's
what it appears to be) like AOSP's clang-4053586, which would make
CLANG_VERSION 350080. For this particular warning, it doesn't matter
since Clang has supported it since 2011 and Clang 5.0 isn't supported
in this tree anyways but maybe relying on just __clang_major__ below
is more ideal.

Other than that, patch functions just as it should.

>  #ifdef uninitialized_var
>  #undef uninitialized_var
>  #define uninitialized_var(x) x = *(&(x))
> @@ -46,3 +50,18 @@
>      __has_builtin(__builtin_sub_overflow)
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> +
> +#define __diag_str1(s) #s
> +#define __diag_str(s) __diag_str1(s)
> +#define __diag(s) _Pragma(__diag_str(clang diagnostic s))
> +#define __diag_CLANG_ignore ignored
> +#define __diag_CLANG_warn warning
> +#define __diag_CLANG_error error
> +#define __diag_CLANG(version, severity, s) \
> +	__diag_CLANG_ ## version(__diag_CLANG_ ## severity s)
> +
> +#if CLANG_VERSION >= 70000
> +#define __diag_CLANG_7(s) __diag(s)
> +#else
> +#define __diag_CLANG_7(s)
> +#endif
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index a8ba6b04152c..a04e6bd63476 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -279,6 +279,10 @@ struct ftrace_likely_data {
>  #define __diag_GCC(version, severity, string)
>  #endif
>  
> +#ifndef __diag_CLANG
> +#define __diag_CLANG(version, severity, string)
> +#endif
> +
>  #define __diag_push()	__diag(push)
>  #define __diag_pop()	__diag(pop)
>  
> -- 
> 2.18.0.345.g5c9ce644c3-goog
> 
