Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E716CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41E02089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0Zan9aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfAHC1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:27:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37678 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfAHC1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:27:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so2502554wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 18:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SX90UBekJzYVENNVAPAaUTEPQCERodGyNvZx1/BDC+U=;
        b=E0Zan9ajdLXT4vUEP5eubEmai085wD7gRQzUudGKCTlnrL6ssC1r7HVWYfcW1c2FP6
         efH2TJem9QkYs5UOth9n1hhD3rBwqyq6As9qi21ulMJgwG3RyLdGnxJzg2tUUFyd98m7
         biLl9dHvnlDLCUmofCdW4SL+8qX3Om/GOQHnfrXVeCNTSGt8PuZByviwo0XUb3eKimIO
         AAOYt+RO/GPDVzOwqeZA5Rh0HHxBjCoQ/U3WZE1Vzud9SZeEII7nJhcvMhWKbGqgAAfo
         WRSKIUZ09G5GkkG85xaglEVTcNuq7QkNzWzjIx/Y1HOkrur28huZxvH/I7d+m3h94DH2
         EAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SX90UBekJzYVENNVAPAaUTEPQCERodGyNvZx1/BDC+U=;
        b=KLUs9psMxRbdNBeQ8c6HK1mGRbmYmyYxFP7hJl/92MwYpFbBbkuB39ztNPV2Gv9/4w
         utmnP0eiwscy9qDVyvVDJp0wbjy/KpzEDWsdn6X0X20RZR6Ea9cl8lX9BrJYSTtNgjTU
         N/mLZsEwbkpb8HJrBYRK7K2hMy9dxO73RHh6Zxb6Hws6ewWcaSMq8esY2WrnuaOfcqBD
         dDm7HNEtD16m6uVdYNjbKqwD3A84VbwVcbHPNJT3nfpj4soVKhfL0GxCS1t11YzhJPE5
         E3sAyEtsIGXwQaYsCi00jSaSTYmfWvTUymzF2+S4TXFxY10rYuA9o5MWsRn5r0OivIvT
         1mzw==
X-Gm-Message-State: AJcUukdq8KUSKeRS3jfHGMzfKQZIQcJS+GafOQzrtGbXOlLs3IkUN2AB
        zgYNnsyEr0xs1w1cLnWKPdA=
X-Google-Smtp-Source: ALg8bN5bvAMzfCeNRLYJ6IImz9KRqG/r/ZIMIIe05o1ciWqTCFxOzjDIyMnmBSegAHTYFYpo/MNdXQ==
X-Received: by 2002:adf:d243:: with SMTP id o3mr55778954wri.66.1546914421791;
        Mon, 07 Jan 2019 18:27:01 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v6sm42832544wro.57.2019.01.07.18.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 18:27:01 -0800 (PST)
Date:   Mon, 7 Jan 2019 19:26:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] kasan: fix kasan_check_read/write definitions
Message-ID: <20190108022659.GA13470@flashbox>
References: <20181211133453.2835077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211133453.2835077-1-arnd@arndb.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:34:35PM +0100, Arnd Bergmann wrote:
> Building little-endian allmodconfig kernels on arm64 started failing
> with the generated atomic.h implementation, since we now try to call
> kasan helpers from the EFI stub:
> 
> aarch64-linux-gnu-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: in function `atomic_set':
> include/generated/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'
> 
> I suspect that we get similar problems in other files that explicitly
> disable KASAN for some reason but call atomic_t based helper functions.
> 
> We can fix this by checking the predefined __SANITIZE_ADDRESS__ macro
> that the compiler sets instead of checking CONFIG_KASAN, but this in turn
> requires a small hack in mm/kasan/common.c so we do see the extern
> declaration there instead of the inline function.
> 
> Fixes: b1864b828644 ("locking/atomics: build atomic headers as required")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/kasan-checks.h | 2 +-
>  mm/kasan/common.c            | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index d314150658a4..a61dc075e2ce 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_KASAN_CHECKS_H
>  #define _LINUX_KASAN_CHECKS_H
>  
> -#ifdef CONFIG_KASAN
> +#if defined(__SANITIZE_ADDRESS__) || defined(__KASAN_INTERNAL)
>  void kasan_check_read(const volatile void *p, unsigned int size);
>  void kasan_check_write(const volatile void *p, unsigned int size);
>  #else
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 03d5d1374ca7..51a7932c33a3 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -14,6 +14,8 @@
>   *
>   */
>  
> +#define __KASAN_INTERNAL
> +
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> -- 
> 2.20.0
> 

Hi all,

Was there any other movement on this patch? I am noticing this fail as
well and I have applied this patch in the meantime; it would be nice for
it to be merged so I could drop it from my stack.

Thanks,
Nathan
