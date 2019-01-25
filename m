Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D44EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7A02184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cgsgy0JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfAYKOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:14:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36577 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfAYKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:14:22 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so7319405ioh.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybYySaWp3VheozYVb6z2iodDGYG/Wy4EhVxSQUTx5n0=;
        b=Cgsgy0JVanMD+xP7DzrHcvdgl/FdFTNd+Gk4DKVZj27Wyi7R6YKyJs5DiZXvez7CP0
         t7RkpOgdHTvpfEzWRlBTe2ti1kcu+6Hg3tAJLhRRtcCPcwgNF4kRb1JYBUqaj3ndrVc6
         2BIK+CqvREISZiNmOb7Q95Fbo9n/sfPx79hMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybYySaWp3VheozYVb6z2iodDGYG/Wy4EhVxSQUTx5n0=;
        b=DxIlu9y+fpipiRWRut3dSOmnfZsc+cyWiRifJjIzhAA74PBqYhCmf9PNOpnPsE0HdG
         UsxMJngkTfQuQW+nnuEfc+hEsspleSOYI5uQ1092PphvK7tBhBK1aXr75BpPw66AWP+F
         fhA1XzaJ8ICWJ+LFpuCN0yDCOwAxHRwICZsWMEdOyVyd9ZS1o3lY5Qp2zh20ruugsBkv
         /v7booLbUwnVJryibiCPZHmsN9FQvdF4rKpRUvuMZx/43aLLFrHXpeIf0jWlsQmBivl+
         rgDEWdGlE7ccRL7Jqo0pDkKafTcJzEhVTcVq41YWGJzDcbyyQJm/aBxr4Z3KmR8KlG2A
         SLBA==
X-Gm-Message-State: AHQUAua+raGnRjL7gPKXtkQcdHw+aitmfdGj6Qp/anIvSXr4eJTDC9F2
        oyAXBN/me+uxBbPm6lFOdMPmHT/MI7bqlzfMsFmxPA==
X-Google-Smtp-Source: ALg8bN40e5csdb5ObhITF5I6xhc+q/Tof9H1rEqEgRPgYzM8TZhbAOKQ43z3DXojhwx3+PsxB8am9m5CteaFgWenvs0=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr6135241ion.173.1548411261601;
 Fri, 25 Jan 2019 02:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20190124154420.GA11471@gmail.com>
In-Reply-To: <20190124154420.GA11471@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 25 Jan 2019 11:14:10 +0100
Message-ID: <CAKv+Gu9VqsYyihueavFg3FCbESf1rLHnQkX+=U0L+W6BzE4V+A@mail.gmail.com>
Subject: Re: [PATCH] lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases
 as __pure
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 16:44, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> The upcoming GCC 9 release extends the -Wmissing-attributes warnings
> (enabled by -Wall) to C and aliases: it warns when particular function
> attributes are missing in the aliases but not in their target.
>
> In particular, it triggers here because crc32_le_base/__crc32c_le_base
> aren't __pure while their target crc32_le/__crc32c_le are.
>
> These aliases are used by architectures as a fallback in accelerated
> versions of CRC32. See commit 9784d82db3eb ("lib/crc32: make core crc32()
> routines weak so they can be overridden").
>
> Therefore, being fallbacks, it is likely that even if the aliases
> were called from C, there wouldn't be any optimizations possible.
> Currently, the only user is arm64, which calls this from asm.
>
> Still, marking the aliases as __pure makes sense and is a good idea
> for documentation purposes and possible future optimizations,
> which also silences the warning.
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
> I am picking this up through the compiler-attributes tree
> and putting it into -next along with the other cleanup
> for -Wmissing-attributes (unless some other maintainer wants it).
>
>  lib/crc32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/crc32.c b/lib/crc32.c
> index 45b1d67a1767..4a20455d1f61 100644
> --- a/lib/crc32.c
> +++ b/lib/crc32.c
> @@ -206,8 +206,8 @@ u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
>  EXPORT_SYMBOL(crc32_le);
>  EXPORT_SYMBOL(__crc32c_le);
>
> -u32 crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
> -u32 __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
> +u32 __pure crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
> +u32 __pure __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
>
>  /*
>   * This multiplies the polynomials x and y modulo the given modulus.
> --
> 2.17.1
>
