Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E374EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AFD20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCOxYHJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AFD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbeLALcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:32:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43425 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLALcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:32:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so3570724pfk.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IK8pBXwWXw/gPWwnM7bo5e6EnorLixIBnHwfVaDQ64U=;
        b=rCOxYHJ2j97elgHUTYybQgmmCE/GHwWFetapG+BkHlJIgH3qPWfqcQNCeYKOnKODnk
         1L1SlT/NPk2ZktF+2LdCkV8JAJvT4KwgzBSNxUR94c6+OrBGmfiBO/q+wHut5pO8iAtq
         6jQ3x28NpKPpMxf5EpCMwQd7dT70elryNcrYDoDDpJueURNjHjGNpHjGKWBXrdGD0kSn
         ojtVi7g4T5o5iQUqT30m96kzRxji67VEQvL8ksUcxw20qMnKWwsyiiuC5VUUxrMF8Nt3
         CugJBfnfMD7KeZHqdSuNpJF7O6iHTJ0GKzS7PG8eJgK1l3MO+X37sLRNeGEUSosW1+eR
         ZKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IK8pBXwWXw/gPWwnM7bo5e6EnorLixIBnHwfVaDQ64U=;
        b=LVADjLrU6xI0bnDYIJJ3R9G/IO4BZ2daGrt6z14aGJzpb68VfW+pWW6rclUOftRCOq
         9/YTUqMDD9pn0Op0MLdVo4BFCnWXgbFDB6hC0SJORoQ34dm4NU+zGa/8vKk5b6aHp5Rp
         DlEApCF4nu293I+biFzH1I/6ERRQedHaylF4qzjqV5nAbE60bYry2IaEzeImeAkfxTLt
         wA4AqckmpDgDgDEvyJwCOo8j1N0hMTsOBTrgLx6W5gGoVpNA4IgHTKdLFRkQZe/IQQar
         FFU47HLdVEWOfV1AToYZMdzlt0TUoT+4GxRu+N/nyS0wEPVR0D0MLDmNxJpBYzOdqzkf
         79UQ==
X-Gm-Message-State: AA+aEWaKrsjSWfienrCjCZTePcHGXsezaBL486Sdn9t3JdgTB7JmqBmN
        LE37WFmuhmTrjQi7OnPleCKGZNJsfQervMm1HvC09WgS9gw=
X-Google-Smtp-Source: AFSGD/UA+AdbqsU7LsK7R+vtC5fB8PpaZR/8l6R5h5wqbpwOk22Er4MwHYDTfPVErm8s4hqL3PDX0dXMKRAlzEJGoYs=
X-Received: by 2002:a63:e156:: with SMTP id h22mr5330813pgk.255.1543623653481;
 Fri, 30 Nov 2018 16:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20181130113558.15198-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181130113558.15198-1-ard.biesheuvel@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Nov 2018 16:20:42 -0800
Message-ID: <CAKwvOdnZKatfVa=dDSBbkrhfJPhsaD_FxVt4YYAvHMQOUimPeg@mail.gmail.com>
Subject: Re: [PATCH] arm64: drop linker script hack to hide __efistub_ symbols
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 3:36 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> Commit 1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_
> symbols") updated the kallsyms code to filter out symbols with
> the __efistub_ prefix explicitly, so we no longer require the
> hack in our linker script to emit them as absolute symbols.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Tested linking with bfd and booting in qemu.  Thanks Ard!  lld still
has some further bugs for us to work out, but this should help
simplify things for us.

> ---
>  arch/arm64/kernel/image.h | 46 +++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index a820ed07fb80..8da289dc843a 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -75,16 +75,6 @@
>
>  __efistub_stext_offset = stext - _text;
>
> -/*
> - * Prevent the symbol aliases below from being emitted into the kallsyms
> - * table, by forcing them to be absolute symbols (which are conveniently
> - * ignored by scripts/kallsyms) rather than section relative symbols.
> - * The distinction is only relevant for partial linking, and only for symbols
> - * that are defined within a section declaration (which is not the case for
> - * the definitions below) so the resulting values will be identical.
> - */
> -#define KALLSYMS_HIDE(sym)     ABSOLUTE(sym)
> -
>  /*
>   * The EFI stub has its own symbol namespace prefixed by __efistub_, to
>   * isolate it from the kernel proper. The following symbols are legally
> @@ -94,28 +84,28 @@ __efistub_stext_offset = stext - _text;
>   * linked at. The routines below are all implemented in assembler in a
>   * position independent manner
>   */
> -__efistub_memcmp               = KALLSYMS_HIDE(__pi_memcmp);
> -__efistub_memchr               = KALLSYMS_HIDE(__pi_memchr);
> -__efistub_memcpy               = KALLSYMS_HIDE(__pi_memcpy);
> -__efistub_memmove              = KALLSYMS_HIDE(__pi_memmove);
> -__efistub_memset               = KALLSYMS_HIDE(__pi_memset);
> -__efistub_strlen               = KALLSYMS_HIDE(__pi_strlen);
> -__efistub_strnlen              = KALLSYMS_HIDE(__pi_strnlen);
> -__efistub_strcmp               = KALLSYMS_HIDE(__pi_strcmp);
> -__efistub_strncmp              = KALLSYMS_HIDE(__pi_strncmp);
> -__efistub_strrchr              = KALLSYMS_HIDE(__pi_strrchr);
> -__efistub___flush_dcache_area  = KALLSYMS_HIDE(__pi___flush_dcache_area);
> +__efistub_memcmp               = __pi_memcmp;
> +__efistub_memchr               = __pi_memchr;
> +__efistub_memcpy               = __pi_memcpy;
> +__efistub_memmove              = __pi_memmove;
> +__efistub_memset               = __pi_memset;
> +__efistub_strlen               = __pi_strlen;
> +__efistub_strnlen              = __pi_strnlen;
> +__efistub_strcmp               = __pi_strcmp;
> +__efistub_strncmp              = __pi_strncmp;
> +__efistub_strrchr              = __pi_strrchr;
> +__efistub___flush_dcache_area  = __pi___flush_dcache_area;
>
>  #ifdef CONFIG_KASAN
> -__efistub___memcpy             = KALLSYMS_HIDE(__pi_memcpy);
> -__efistub___memmove            = KALLSYMS_HIDE(__pi_memmove);
> -__efistub___memset             = KALLSYMS_HIDE(__pi_memset);
> +__efistub___memcpy             = __pi_memcpy;
> +__efistub___memmove            = __pi_memmove;
> +__efistub___memset             = __pi_memset;
>  #endif
>
> -__efistub__text                        = KALLSYMS_HIDE(_text);
> -__efistub__end                 = KALLSYMS_HIDE(_end);
> -__efistub__edata               = KALLSYMS_HIDE(_edata);
> -__efistub_screen_info          = KALLSYMS_HIDE(screen_info);
> +__efistub__text                        = _text;
> +__efistub__end                 = _end;
> +__efistub__edata               = _edata;
> +__efistub_screen_info          = screen_info;
>
>  #endif
>
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
