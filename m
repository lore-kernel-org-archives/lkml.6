Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA5DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C8A205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTQV6tQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C8A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeIACTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:19:54 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40591 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeIACTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:19:54 -0400
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so16239188qtj.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/NoraxHa8GBeIssLf21fYSdvlpg/R0M7TFjxYJOe7dk=;
        b=JTQV6tQgxyN763Ac0GBEAKfn7hCpOQKXMSt2DvbBDJJIWHaf/4r7jn2fPus5IaWZdU
         WDmj1lX8DD/C5T5pNP/BDAkC85bUHToZpjhlVPwriP4iLyiXa6vaPlW1sAxWlXPuu0Gy
         X0qiShvaCVKpoq1oYbx/9m/mUPwv1jxJ1ZJOUcMZrEMzcnUT9c9U67x42PUTLVSEFLdH
         h8vQfFqGe4xVj5VF4Z1YL3IuVeSm9ycpDjeF7k6IgbEh0Chtt2lY24fVJBfQRgWOu0cq
         sC1gQixgrQQXp6zkNlaw3c/5Q3Zriv/sbOiBZ4QhVN8BjkIgLc1wgzXyoci+r9OoAXvJ
         9TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/NoraxHa8GBeIssLf21fYSdvlpg/R0M7TFjxYJOe7dk=;
        b=RVrUVp9oFvUbg7MAxLUgbucwd1ZQrMC8jP/brGSJsoxm/LVpQepgdvxCZl24NyYlVt
         yKfXlEbGA+hqqrNn/Ba+uyBWFZWL88QZPQmtFqXaF6T503q5Qu/5XHwWt9UK61CpQxxp
         Qxiq0aJnhMX0GBLwLCPWewe3cbA1iQlYO3P9SWS/tko41HwRn81wFmEJ4ZyiHcK40wGf
         m2q2Wu9YkTAspYHP3IoQHnzjIPECaS4PKFi3eCMASppyBiKp+LN8oX5PS9cEWstsAxls
         kk9ncfyYQN0qWhK+WTIEaccOY9RgXAKXnUVUa0zGtpuhMe4LhCdDRAaXMbflsQmXWzqn
         c1Cg==
X-Gm-Message-State: APzg51AAFmr0bPLI26NNan0XQe6U5rURq9odfx8aMIc3anuYxBv6IDlx
        MmPFweDQUCUOJ0KxDI0i7aQ1qzRMi57EsRL2oYs=
X-Google-Smtp-Source: ANB0VdbSicvfjYZ0+moSyR3nr9fusbV0az3/Kj/BXY2GRcIBWz29EPgkeirPZBqgtsO26NFoJtm+KXrjO1ZOkWhPhqg=
X-Received: by 2002:a0c:aed9:: with SMTP id n25-v6mr17240687qvd.10.1535753424748;
 Fri, 31 Aug 2018 15:10:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2291:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 15:10:04
 -0700 (PDT)
In-Reply-To: <0a8588f3-929a-608f-1fdc-e24b90e6b59b@rasmusvillemoes.dk>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-2-miguel.ojeda.sandonis@gmail.com> <0a8588f3-929a-608f-1fdc-e24b90e6b59b@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 1 Sep 2018 00:10:04 +0200
Message-ID: <CANiq72mJ+AhD0DO6xcbG5SbGmraPU48+UbWaaU5rW-p4XoO4LQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] Compiler Attributes: use the no-underscores syntax
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ramus,

On Fri, Aug 31, 2018 at 11:49 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 2018-08-31 19:05, Miguel Ojeda wrote:
>> The attribute syntax optionally allows to surround attribute names
>> with "__" in order to avoid collisions with macros of the same name
>> (see https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html).
>>
>> This homogenizes all attributes to use the syntax without underscores.
>
> At the risk of bikeshedding, why not the other way around, exactly
> because of what you write above? We have convenience macros anyway, so
> those verbose leading/trailing underscores would only be in compiler*.h,
> and some of the attribute names are common words that can appear as
> #defines. E.g. error is defined
> drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c ; if that used a
> BUILD_BUG_ON somewhere, the
>
> #define __compiletime_error(message) __attribute__((error(message)))
>
> would break.

Indeed, if we are afraid of such cases, we should go with the __name__
syntax. I was trying to go first for the "cleanest"/simplest way
first, considering no one should be defining many such macros as
"error" (and in lower case, at that). But indeed, good catch!

Grepping for those in compiler_attributes.h (which, as you point out,
are not all of them) yields:

arch/parisc/boot/compressed/misc.c:#define malloc       malloc_gzip
include/linux/decompress/mm.h:#define malloc(a) kmalloc(a, GFP_KERNEL)
lib/inflate.c:#define malloc(a) kmalloc(a, GFP_KERNEL)
include/linux/compiler_types.h:#define noinline_for_stack noinline
include/linux/raid/pq.h:#define noinline __attribute__((noinline))
tools/include/linux/compiler.h:#define noinline
arch/mips/sgi-ip27/ip27-reset.c:#define noreturn while(1);
                 /* Silence gcc.  */

Cheers,
Miguel
