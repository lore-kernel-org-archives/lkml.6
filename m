Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C2C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5762E21907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JjZXKHNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfBHAtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:49:07 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36783 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBHAtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:49:07 -0500
Received: by mail-ua1-f67.google.com with SMTP id j3so609581uap.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DD5JBf4nQGLuF+lzKGNDCm3/IOXRWF6Ob4gNHEyfeT4=;
        b=JjZXKHNpa52Tbs9SaCnsfTi+CUsMvGzGRibm5R+Lb/kMDnE1a6i4LZy+nDriJRyiTD
         SkuklW7jel8E667O3Dab3U50NNZ4wbYbeKzImDZu4tm/VX9Psi/Zul4wxqFmbhvS0QWS
         hSdQ775gec1fs9A9gqO1iWavg+IfvSquQcIuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DD5JBf4nQGLuF+lzKGNDCm3/IOXRWF6Ob4gNHEyfeT4=;
        b=K8LBM33HcY/TDn7wDstmcXrPIQ5y1qbss6s/psaYTh0TJYoCMfOJCxVKayChk6cZJe
         /3OZ9PNBz6EOZLOLOD3hzdC7Hv8ONdSJkDBb7v8Km3g4tmdaJkK9z1aJ8tntnjNlbdlN
         n9RXrS3rl6021a3syVm6AM8yda4KT82WDwbVE8Dj+SVV7d2Vwls0zZX+6ZsxjuPrjoBM
         DsYx5sqJlMXBWN7sAA5uhOsO/9rxrjDA24FMBOSo4p2zh7gqFLxJy5f7a9XuptW9hYYE
         11QlS3G5RQ61Z9puP/p+0WOdf5I/TPkXAQDmrYd8mADhoD7ja7M7SPFWALTWbBfplAot
         6NPA==
X-Gm-Message-State: AHQUAub0BY/0qh+wrlJZqfpTK0XPXZ7xcVakrTFABQ6orOw+URdVErkq
        T0js3BEVFdPRv1Dk7QjJWOb7o4OtjdRyfg==
X-Google-Smtp-Source: AHgI3IZ03SmmUASHIkk1yhKtqPUl+CNXFuggdvqstJVT1byFYju8PscwaeCjaeOX74CNu2XvnAgYdw==
X-Received: by 2002:ab0:484b:: with SMTP id c11mr7054444uad.54.1549586945559;
        Thu, 07 Feb 2019 16:49:05 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id e67sm668950vsd.32.2019.02.07.16.49.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 16:49:04 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id w12so606173uaq.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:49:04 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr3662134uac.122.1549586943793;
 Thu, 07 Feb 2019 16:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20190207220155.81351-1-ndesaulniers@google.com>
In-Reply-To: <20190207220155.81351-1-ndesaulniers@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 8 Feb 2019 00:48:52 +0000
X-Gmail-Original-Message-ID: <CAGXu5jKTZaDFDO95UF87kXZ4uODZ6JbZR7wMdVyYkC+JN1gtmQ@mail.gmail.com>
Message-ID: <CAGXu5jKTZaDFDO95UF87kXZ4uODZ6JbZR7wMdVyYkC+JN1gtmQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] init/Kconfig: add config support for detecting linker
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 10:02 PM <ndesaulniers@google.com> wrote:
>
> Similar to how we differentiate between CONFIG_CC_IS_GCC and
> CONFIG_CC_IS_CLANG, add CONFIG_LD_IS_BFD, CONFIG_LD_IS_GOLD, and
> CONFIG_LD_IS_LLD.
>
> This simiplifies patches to Makefiles that need to do different things
> for different linkers.
>
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  init/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index c9386a365eea..b6046dcf7794 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -26,6 +26,15 @@ config CLANG_VERSION
>  config CC_HAS_ASM_GOTO
>         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
>
> +config LD_IS_BFD
> +       def_bool $(success,$(LD) --version | head -n 1 | grep -q 'GNU ld')
> +
> +config LD_IS_GOLD
> +       def_bool $(success,$(LD) --version | head -n 1 | grep -q 'GNU gold')
> +
> +config LD_IS_LLD
> +       def_bool $(success,$(LD) --version | head -n 1 | grep -q 'LLD')
> +
>  config CONSTRUCTORS
>         bool
>         depends on !UML
> --
> 2.20.1.791.gb4d0f1c61a-goog
>


-- 
Kees Cook
