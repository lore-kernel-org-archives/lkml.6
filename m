Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE9EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D81214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xTi9gGSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D81214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeHUKPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:15:09 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:26822 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:15:08 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7L6u8hI013239;
        Tue, 21 Aug 2018 15:56:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7L6u8hI013239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534834569;
        bh=u2Co/rLAs5I6ScSugWwFoioo6tDb7HqZnjJK+pQL2S0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=xTi9gGSnmmz9hvZUUW7QK5v+phbbvtmJt+EHviAvIRjjm1w3gSSdpmJCLjc9OxeJ6
         obD0sCZe7EwNld7OAaUuEOlSebJBiGVhHV0Dj1sr7IHHttxcfM7VRwEeFan581SmZO
         Q/pUnH+fZGu9DR8To1uIPghiTUhFEBEB9ZtAbdbuZSq6BxeArDed1Duh6mmD9lOLk6
         KNP3X2khPEsa0ei0FkZ7Hj3zc2Bk9fCRkMUgG3Vc4R3hft/DemXYuIFVDFR/XBUlXD
         gWvUP1SZ7bJjQCbrKbCTmbY6E1fIJsXHoZdhP4e9Wbu6M9gcBgczkYKCeK4QAskdwy
         fIQNjildeLHGg==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id f4-v6so11226475uao.10;
        Mon, 20 Aug 2018 23:56:08 -0700 (PDT)
X-Gm-Message-State: AOUpUlEj/7PTSad52wTn2Wj+apqdFMAEi7o87mqRHzOF1LdINsNDrBhe
        /ki0VCmxte+mJODWAHwkC4zjwwQFIfRvjiXU/Z4=
X-Google-Smtp-Source: AA+uWPwpJly7xUDFGRqZcx+D6ePRnlhsXdgN8hFchoBGyoyxOIWusHyiNQn7L2u6KuGoRtWL4FoK+ezIG96dAaHA9jk=
X-Received: by 2002:ab0:4ad7:: with SMTP id t23-v6mr31365135uae.35.1534834567669;
 Mon, 20 Aug 2018 23:56:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 23:55:27
 -0700 (PDT)
In-Reply-To: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
References: <da5620dc7a2b9d33f2a0dd7f4dc3afdab5a66f26.1534795606.git.joe@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 15:55:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAStcQoi8oodq98dSGp+Jmgb1F0mowMephUY=OD2o4=2Mg@mail.gmail.com>
Message-ID: <CAK7LNAStcQoi8oodq98dSGp+Jmgb1F0mowMephUY=OD2o4=2Mg@mail.gmail.com>
Subject: Re: [PATCH] Raise the minimum required gcc version to 4.6
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Galbraith <efault@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.



2018-08-21 5:15 GMT+09:00 Joe Perches <joe@perches.com>:
> Various architectures fail to build properly with older versions
> of the gcc compiler.
>
> An example from Guenter Roeck via this thread:
> https://lore.kernel.org/lkml/20180814170904.GA12768@roeck-us.net/
>
> ----------------------
> In file included from ./include/linux/mm.h:17:0,
>                  from ./include/linux/pid_namespace.h:7,
>                  from ./include/linux/ptrace.h:10,
>                  from arch/openrisc/kernel/asm-offsets.c:32:
> ./include/linux/mm_types.h:497:16: error: flexible array member in otherwise empty struct
>
> This is just an example with gcc 4.5.1 for or32. I have seen the problem
> with gcc 4.4 (for unicore32) as well.
> ----------------------
>
> So update the minimum required version of gcc to 4.6.
>
> Miscellanea:
>
> o Update Documentation/process/changes.rst
> o Remove and consolidate version test blocks in compiler-gcc.h
>   for versions lower than 4.6
>
> Signed-off-by: Joe Perches <joe@perches.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---


This broke Clang build.
I sent a patch.

https://lore.kernel.org/patchwork/patch/976025/

-- 
Best Regards
Masahiro Yamada
