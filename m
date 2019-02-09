Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85CA20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzuGmrrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfBIKoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 05:44:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40270 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIKoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 05:44:22 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so15416886ita.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 02:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0dpvtJ7/qEb3l3RkpI4dGKSw3NkP3w0C4upGTOHmio=;
        b=TzuGmrrjRUO+HY6aPxntPtkG3ZJdYA/0UpVLmKfg2ON0ztMVMYht1B1tCaZ1jBF4Ug
         kM59Yrx4vNbF6vct6zfckF+XqOTNFjlA8UfU/eiovLW3Ys3q8kel3IP6DwnmIx5mSjD+
         Ao8Ku24KJcCgDwSbGJdFp+JSuv4wps6/ULMUuUG3rE9P9zOjNYLPZfT1tiSSzMm06yAi
         m2wrT8ijBBsYxNn4HD0k8UeEsXnDqKAljVr8Ss00Az0p+gXO3uaOP7bD/lD/3azohcgx
         EQZkOOzezTg5AVMYzQFcOFOaE7oZsxLyATGAl7bELfxoq5fyBggE+hm/W4muw5Z7FysJ
         d5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0dpvtJ7/qEb3l3RkpI4dGKSw3NkP3w0C4upGTOHmio=;
        b=DmH/FfKAlbDWhKinvv+fbW2wj2DQrTy1RWjytk6llKsSTwZpQJmXkop6MYKTuVIMNN
         UjSgN8M/uxXs1srTvTIga3TTR1Un5EWpzGK8lToEqe7RxqVq2z7XLncIbVjlWGzXRStP
         KzvqZXcrsoSNx4YLzEOgGpeckpNjzJi0n4B9k84vX9m9EMQMkXFI9Tf0Ma6jS39LDB0J
         uONeCMLclkx0ecr9vzdpy2N6DLWbDovUH9NgHkpErgaIqlkTlaVxAU59YGqvcDJtxgW/
         mCzbAMMn875cCofhuTOdPjacEmZ2PwRalrVv73JpSWi2GtDnFpF1RKoFOwTzLj0KkhkV
         WwGg==
X-Gm-Message-State: AHQUAuad2A5foYovgu2/YN+JL14zDfxbR08Otc241FUhfvaq11aKWccq
        bvINno4cPAYSnEk0itJh+a6tN5k4Rmw9VYgODJN2kA==
X-Google-Smtp-Source: AHgI3IYmnayMpCmZ/aVZKKnEwOqzz6YQ01k1GVEp3czXJYUcld9X/86EEdDwJBitHH7sJF4yINI+CyCYVF538LXe9NU=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr1619174itk.71.1549709061226;
 Sat, 09 Feb 2019 02:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 9 Feb 2019 11:44:09 +0100
Message-ID: <CAKv+Gu83rXGH5hVdHXM=65zQkc5FtG86xMccT7WByUFy9BmXkQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Clean the new GCC 9 -Wmissing-attributes warnings
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <james.morris@microsoft.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Borislav Petkov <bp@suse.de>, Matt Mullins <mmullins@fb.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        WANG Chao <chao.wang@ucloud.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2019 at 01:09, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> The upcoming GCC 9 release extends the -Wmissing-attributes warnings
> (enabled by -Wall) to C and aliases: it warns when particular function
> attributes are missing in the aliases but not in their target, e.g.:
>
>     void __cold f(void) {}

Apologies if I missed any discussions on this topic, but I would argue
that 'cold' is not an attribute that has to be applied to the function
pointer as well as each of its targets, since it basically decides the
placement in the binary, and it doesn't affect the nature of the code
being referenced.

Permitting a function pointer to point to 'cold' functions only if it
is annotated as 'cold' itself makes no sense whatsoever, and there
could be valid cases where a function pointer may point at either cold
or non-cold functions.

For other attributes, the situation is clearly different, e.g., a
__pure function pointer to a non-pure function is obviously a bug,
since the compiler could make assumptions based on the function
pointer type that do not hold for the function it points to at
runtime.

I don't see how the 'cold' attribute could have any such effect, so I
wonder if it isn't simply a bug that we have to report to GCC?



>     void __alias("f") g(void);
>
> diagnoses:
>
>     warning: 'g' specifies less restrictive attribute than
>     its target 'f': 'cold' [-Wmissing-attributes]
>
> These patch series clean these new warnings. Most of them are caused
> by the module_init/exit macros.
>
> The first patch has been in -next for a long time already, and an alternative
> solution (only __cold) for module.h as well. However, since we decided
> to go with the new __copy attribute, I will leave the series for a few days
> again and send the PR for -rc7.
>
> Link: https://lore.kernel.org/lkml/20190125104353.2791-1-labbott@redhat.com/
>
> Miguel Ojeda (3):
>   lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases as __pure
>   Compiler Attributes: add support for __copy (gcc >= 9)
>   include/linux/module.h: copy __init/__exit attrs to
>     init/cleanup_module
>
>  include/linux/compiler_attributes.h | 14 ++++++++++++++
>  include/linux/module.h              |  4 ++--
>  lib/crc32.c                         |  4 ++--
>  3 files changed, 18 insertions(+), 4 deletions(-)
>
> --
> 2.17.1
>
