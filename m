Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E108FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DF12086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2jS7BMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfBUFKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:10:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38753 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfBUFKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:10:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id h58so21955160edb.5;
        Wed, 20 Feb 2019 21:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xE8W9LVF2KPosTohb44I4pOeYk2w8oyKayatVhb3LyE=;
        b=s2jS7BMF5EPyu0Pl4wOfm0WAun1ZYig7TD7WSDPoSUH1ggswHsduE06WdvpUotfD1/
         h1ei1jOS7ICJPTsk4tg+WZIoficzbrH6IPTb3pOma7Lm2bel342FB0ygz1mZZF/eHhvf
         UlwGX00MskQyLDQcZGsQMic4pLEvc/SFxjxr79RBZ3EvQFgJ3cmSud65/cVzYRT3Bqwm
         9sJQ+EGwhRlVZrbtz0oMv7muiJgpRWGOwAKEfuL6/eNppH232ltGafbWbLSIUf/dzMB8
         38Hed/NYUfa4txuScX1BPldAnRZQNZuC5bV4shKUVf3CH4+R0/ywR0k0x1U8+ZZQj5BL
         yvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xE8W9LVF2KPosTohb44I4pOeYk2w8oyKayatVhb3LyE=;
        b=MM5Z+BbcZy65ckjRDkDdiAY8kIW3qNVDNuCC4gpHf+Rl5krRO4j9R6BQxgf7D8q3i2
         9SJA+4DuFD2iY2CdIA0flxtpHUQHVfH4we+8bVHiMmfHVaXMPT8yIqQA9nCtTiR/91zZ
         s6NXMtq5VMrDtpe/o3UKU5WHNxAP2Y+ROAn09/CKYXuvlJiY+Iyh/qWXaDkNpInyzH4/
         UjfJLMnTbQ+QUi3naMwWHgWDbiu1k41IAmTogukn7Tbvy1aSdMUwGULN5OZ/U0a0u9JP
         VcOgVVfDioLvgR9W/j511CUPh7GOlB8uOolK1YHA+NeRsjt3cK/7ZZYCvQ16KF/nyUD7
         EtLg==
X-Gm-Message-State: AHQUAuatn3rHPMMuHFmk9M9FQ78pxtUvK4LnXMzVniT3fkhLJmzlagud
        SF5veEnR6GIUkch0ou9f/rs=
X-Google-Smtp-Source: AHgI3Ibu4Si1mxsGjwBKbkvS3TVYjInFAqZm4jYVY7PouWeD/etizFDFFhNTXOln26ZD1e+FSIsdzg==
X-Received: by 2002:aa7:c70c:: with SMTP id i12mr17959018edq.36.1550725805739;
        Wed, 20 Feb 2019 21:10:05 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id v15sm437819edl.40.2019.02.20.21.10.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 20 Feb 2019 21:10:04 -0800 (PST)
Date:   Wed, 20 Feb 2019 22:10:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kbuild: compute false-positive -Wmaybe-uninitialized
 cases in Kconfig
Message-ID: <20190221051002.GA31595@archlinux-ryzen>
References: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550722418-9189-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 01:13:38PM +0900, Masahiro Yamada wrote:
> Since -Wmaybe-uninitialized was introduced by GCC 4.7, we have patched
> various false positives:
> 
>  - commit e74fc973b6e5 ("Turn off -Wmaybe-uninitialized when building
>    with -Os") turned off this option for -Os.
> 
>  - commit 815eb71e7149 ("Kbuild: disable 'maybe-uninitialized' warning
>    for CONFIG_PROFILE_ALL_BRANCHES") turned off this option for
>    CONFIG_PROFILE_ALL_BRANCHES
> 
>  - commit a76bcf557ef4 ("Kbuild: enable -Wmaybe-uninitialized warning
>    for "make W=1"") turned off this option for GCC < 4.9
>    Arnd provided more explanation in https://lkml.org/lkml/2017/3/14/903
> 
> I think this looks better by shifting the logic from Makefile to Kconfig.
> 

I agree!

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> 
>  Makefile             | 10 +++-------
>  init/Kconfig         | 17 +++++++++++++++++
>  kernel/trace/Kconfig |  1 +
>  3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1bb0535..b21aa2e3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -656,17 +656,13 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
>  
>  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
> -KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
> -else
> -ifdef CONFIG_PROFILE_ALL_BRANCHES
> -KBUILD_CFLAGS	+= -O2 $(call cc-disable-warning,maybe-uninitialized,)
>  else
>  KBUILD_CFLAGS   += -O2
>  endif
> -endif
>  
> -KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
> -			$(call cc-disable-warning,maybe-uninitialized,))
> +ifdef CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED
> +KBUILD_CFLAGS   += -Wno-maybe-uninitialized
> +endif
>  
>  # Tell gcc to never replace conditional load with a non-conditional one
>  KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
> diff --git a/init/Kconfig b/init/Kconfig
> index c9386a3..1f05a88 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -26,6 +26,22 @@ config CLANG_VERSION
>  config CC_HAS_ASM_GOTO
>  	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>  
> +config CC_HAS_WARN_MAYBE_UNINITIALIZED
> +	def_bool $(cc-option,-Wmaybe-uninitialized)
> +	help
> +	  GCC >= 4.7 supports this option.
> +
> +config CC_DISABLE_WARN_MAYBE_UNINITIALIZED
> +	bool
> +	depends on CC_HAS_WARN_MAYBE_UNINITIALIZED
> +	default CC_IS_GCC && GCC_VERSION < 40900  # unreliable for GCC < 4.9
> +	help
> +	  GCC's -Wmaybe-uninitialized is not reliable by definition.
> +	  Lots of false positive warnings are produced in some cases.
> +
> +	  If this option is enabled, -Wno-maybe-uninitialzed is passed
> +	  to the compiler to suppress maybe-uninitialized warnings.
> +
>  config CONSTRUCTORS
>  	bool
>  	depends on !UML
> @@ -1113,6 +1129,7 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
>  
>  config CC_OPTIMIZE_FOR_SIZE
>  	bool "Optimize for size"
> +	imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
>  	help
>  	  Enabling this option will pass "-Os" instead of "-O2" to
>  	  your compiler resulting in a smaller kernel.
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index fa8b1fe..8bd1d6d 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -370,6 +370,7 @@ config PROFILE_ANNOTATED_BRANCHES
>  config PROFILE_ALL_BRANCHES
>  	bool "Profile all if conditionals" if !FORTIFY_SOURCE
>  	select TRACE_BRANCH_PROFILING
> +	imply CC_DISABLE_WARN_MAYBE_UNINITIALIZED  # avoid false positives
>  	help
>  	  This tracer profiles all branch conditions. Every if ()
>  	  taken in the kernel is recorded whether it hit or miss.
> -- 
> 2.7.4
> 
