Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1886AC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04D220865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 15:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX22j/lT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04D220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIIUHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 16:07:09 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37358 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeIIUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 16:07:09 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so21443945qtl.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iMVhczgmug9IhaQExwQJOrMwSU7YnXobCdbaxyQ4reg=;
        b=RX22j/lTKExcINjEe6ZBczMcDGm4Wk5YdobDej6LB6uaDJ6IL2rndX5mV7tR+drZO1
         550mKih1hlYnR0ZHYCjvd/p3EVj/lLlIKrehp+Wu/EHSKfM/66obYjVu7i5RlfmwFPs3
         293JtQ8N1ywds0/kJv/RT4n7n94J7gGtqdjnkxe0shd1KPSbS7h/YXsxhUOa+Wlt7faK
         n8cYi3tp0OY2qddu26WDCY3wPf32z3HYNaOPGJmgD25Gopuum2e8Tt9PkeFl9aZPSKFy
         QuPfvqEdKGwfNKOr2rRTsdPzJG36Jw2WjINgVKMFDDmX3kAuVEt+9LYsBsBZBdji+MuS
         6i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iMVhczgmug9IhaQExwQJOrMwSU7YnXobCdbaxyQ4reg=;
        b=oFyU1b1iWdmDk+f1YMB2+bf3aaFQ64dM6QwCwar3mGRE/YYXwvV167Qt/QbzpyEcx2
         e3a4hX22x402ORKJNR+D5/IYWkffba63/fWFUK5XIjlSVsbiDhg8vDkWSz1KlETwKD6x
         Ivw11oYsF3jYWfzsC8lLj4cXTYpJ6baAnKzflR7j0zgxg0zqVVcgghyWFcjxXfH+FlRu
         5MXmx2ClTkxufmoUcXeg2UVBa3rhw5a4mN6dGq/+2RBB6NiKfYjeHHEl6hvUcya/8YDi
         9WL+J1T7K/Tti/3wreI2jH1JcZTRCe3RGxeckeRVJOW5b7IvF2LKy6naFhDbjKSQI5gf
         O3Jw==
X-Gm-Message-State: APzg51BQ03zAhEul/6d5Hr1Jz3PVwH0WT7N1hWOdtiUXqp5na7lkfEC2
        2H5C9mK6pEHIYd8zNlgDTDi/+0XJ1KQXIBCbuJs=
X-Google-Smtp-Source: ANB0Vdbaw615gP4Qowz3sNjFt7e/OsZFTDq6Hl6Ftuks/E4ijkcVECWMCMaElxDz2PLk0rccgi3X9jZS0x1zLlgcFhg=
X-Received: by 2002:ac8:304a:: with SMTP id g10-v6mr13087625qte.136.1536506229104;
 Sun, 09 Sep 2018 08:17:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 08:16:48 -0700 (PDT)
In-Reply-To: <20180907222109.163802-1-ndesaulniers@google.com>
References: <20180907222109.163802-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Sep 2018 17:16:48 +0200
Message-ID: <CANiq72=ToRYw2ujJapSndmO1YNy4xjOHcV136MLrstiLPO=ZAg@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: add version detection to asm_volatile_goto
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Sat, Sep 8, 2018 at 12:21 AM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> The comment above asm_volatile_goto mentions working around a GCC bug,
> and links to a bug report that claims this has been fixed in newer
> versions of GCC.  Testing shows that this was resolved in GCC 4.8.2.
> asm_volatile_goto should also be defined for other compilers that
> support asm goto.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/linux/compiler-gcc.h   | 7 ++++++-
>  include/linux/compiler_types.h | 4 ++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 763bbad1e258..149f411b4366 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -171,7 +171,7 @@
>  #endif
>
>  /*
> - * GCC 'asm goto' miscompiles certain code sequences:
> + * GCC < 4.8.2 'asm goto' miscompiles certain code sequences:
>   *

Nice catch. Indeed, it seems broken since 4.5.3 and fixed in every
version after 4.8.1 (at least the ones in godbolt).

Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

By the way, arch/arm64/include/asm/jump_label.h is the only place in
the kernel using "asm goto" directly (e.g. the arm64 one isn't). Even
if old gcc doesn't trigger the bug in that case, we should use the
same everywhere for consistency, unless there is a special reason not
to (not documented). I will send a patch.

Cheers,
Miguel
