Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C7C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E682083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PS2Ro/ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfBEIGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:06:11 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40734 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfBEIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:06:11 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1585qLj028589
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 17:05:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1585qLj028589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549353952;
        bh=0U/AwC97Hr0RotLn0Geit0MXZBqts4ezxbvG21foJb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PS2Ro/ot2wTQBwAfBvE7IgiHlKqu0rsPEe/R/xOhcs6AS6sWvkYP6Bu8w1Iz4I1kp
         vrvxjOqyffAyMl7o6olFeF57bDeJ/lgd31UFpnzl13k7Wv/QzSMbIEz/oXdkys27Kr
         k+GcGtxOwOGClISOgeZXxclWTjpLRjpFtdzV4p7SQE61oA/iMA33fMJIa3pU4xeS4R
         2cvxzLGHPViKcUhXytff8WDFZtYtnrqMAx9pVLYjc2DajnHkzomnyLZzdj4J2luSht
         wACiXFrI3tJXXU/qe1PXhblMT9VGpvEXkZPp/nKVnF+HIUd4ISWXHWx0y0+vS8fDjE
         4u8pCtXlWGfqA==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id n10so1576755vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 00:05:52 -0800 (PST)
X-Gm-Message-State: AHQUAuYmNsL9F6o9pHsmTDSZTT5PMsnwfM+nb0W4bA3q0g8cX7A3sEd/
        4xkOetTQYZitwrWyzKfZvZt7/LVXhk8rr7KzYw0=
X-Google-Smtp-Source: AHgI3IbYVyZdFzXLY04yE0SOJeNUItosJTOIdieDQA0+zqc4mTLrNgo+Xhxa2+9hp9vwQa62sJZM+sHpirswbhgF2/k=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr1487374vsm.181.1549353951305;
 Tue, 05 Feb 2019 00:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Feb 2019 17:05:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqHgLTJU1tBU+oU+1CrWBrDpnui=dQCrNpzW4N2R-Omw@mail.gmail.com>
Message-ID: <CAK7LNAQqHgLTJU1tBU+oU+1CrWBrDpnui=dQCrNpzW4N2R-Omw@mail.gmail.com>
Subject: Re: [PATCH] build_bug.h: add wrapper for _Static_assert
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 4:24 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> BUILD_BUG_ON() is a little annoying, since it cannot be used outside
> function scope. So one cannot put assertions about the sizeof() a
> struct next to the struct definition, but has to hide that in some
> more or less arbitrary function.
>
> Since gcc 4.6 (which is now also the required minimum), there is
> support for the C11 _Static_assert in all C modes, including gnu89. So
> add a simple wrapper for that.
>
> _Static_assert() requires a message argument, which is usually quite
> redundant (and I believe that bug got fixed at least in newer C++
> standards), but we can easily work around that with a little macro
> magic, making it optional.
>
> For example, adding
>
>   static_assert(sizeof(struct printf_spec) == 8);
>
> in vsprintf.c and modifying that struct to violate it, one gets
>
> ./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct printf_spec) == 8"
>  #define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")
>
> godbolt.org suggests that _Static_assert() has been support by clang
> since at least 3.0.0.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/build_bug.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
> index faeec7433aab..4bf9ba847b44 100644
> --- a/include/linux/build_bug.h
> +++ b/include/linux/build_bug.h
> @@ -58,4 +58,23 @@
>   */
>  #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>
> +/**
> + * static_assert - check integer constant expression at build time
> + *
> + * static_assert() is a wrapper for the C11 _Static_assert, with a
> + * little macro magic to make the message optional (defaulting to the
> + * stringification of the tested expression).
> + *
> + * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
> + * scope, but requires the expression to be an integer constant
> + * expression (i.e., it is not enough that __builtin_constant_p() is
> + * true for expr).
> + *
> + * Also note that BUILD_BUG_ON() fails the build if the condition is
> + * true, while static_assert() fails the build if the expression is
> + * false.
> + */
> +#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> +#define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")

What is the "" "" for?


Bikeshed:

There might be room for argument about
where this macro should go.

Another possible place is <linux/compiler.h>
where compiletime_assert() is defined.


Thanks.



-- 
Best Regards
Masahiro Yamada
