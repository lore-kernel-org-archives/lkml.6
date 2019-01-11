Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E7C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9EB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBV/YRnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfAKSDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:03:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35714 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbfAKSDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:03:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so7303445pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKOxKh+gphIzdfl4F3P+B7Ot+9tddg4heOzgiCkzm94=;
        b=WBV/YRnnH42qVd+qUEG8LwalGznhbAXMQuytLYRC3hpewH2LHD0nzEGfMLrnvJg4Mk
         U4tvCgWhLkJZZJj01ewayDzJP3gin5eaMakVRMn4W/guhgPakHsc/bgQ2TFyAmQKwG8P
         +O9b9d7Wx3rGv61GWQ4D0h+LW6KoR2wXZI6FXkUAHM4b0PNiFO8bDwCunQpZNQifqaMY
         JdQlBdmUANOMEqmlTsmKRNjrhk1Zbb0gvb36BPXTKPD6kwCycXjdAAK6vpdY7TEU0efj
         d+NRORjXofv1K0F/v/OlEjASRxADUVjxUw47ff0RJZSKQMkIoTovHJSRpD9zHQjZ40WQ
         uakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKOxKh+gphIzdfl4F3P+B7Ot+9tddg4heOzgiCkzm94=;
        b=TZI4rUai9aFM5mTctNEF0eDR2TbagRfQD7+C6Y7bCdXVpEyqlY3sArlxxHUBxqhc5t
         eWXgUDqxGdZjgzX9w3dSGCZ/xdHCoTFK1oJaVL+W+PaYOvi+nmwxgYzkqKgAX4T4zkBY
         igYJB6X5GeA9sneVLqTBnzAH8DGvybImzRX0CvBN3ANc3qeeqzbuKBONegHgo9AsMWiZ
         vbLqjGR1drfTOiqIHj2YVRmNELb9WQzsknEDKLEprURh2xKibRvUzSMIiTm1rWAwZ3IQ
         GjVtN74xSc59dRF6AI4pAbYF6oRKnc01rp89XwmPyQKrtEDC546nPcwmdgLcOmgHBzxu
         MSxw==
X-Gm-Message-State: AJcUukeaU0fSSReBkIEBDJONwYd+bevPGwieC4wJCme9qFpTOKN6h7Ej
        IiKgPhgPNv71txUkJeOwdgtzy0oJx/qFMGOrDMbJWQ==
X-Google-Smtp-Source: ALg8bN5UFrRRT5CYuxX8f4WDBWQnUmlLtmEwHUjFka9x5b7SElyKpDGtPFNQA5/ym9KNyR04RY9SRi8a6+u9UMcV18k=
X-Received: by 2002:a63:42c1:: with SMTP id p184mr14199113pga.202.1547229788722;
 Fri, 11 Jan 2019 10:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20190111131102.899065735@linuxfoundation.org> <20190111131110.701589602@linuxfoundation.org>
In-Reply-To: <20190111131110.701589602@linuxfoundation.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Jan 2019 10:02:57 -0800
Message-ID: <CAKwvOdmnpH=pCT7J44kL7ka0sRkhKCYGKxV7g4Ubeu80R98RwA@mail.gmail.com>
Subject: Re: [PATCH 4.14 093/105] arm64: drop linker script hack to hide
 __efistub_ symbols
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 6:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> commit dd6846d774693bfa27d7db4dae5ea67dfe373fa1 upstream.
>
> Commit 1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_
> symbols") updated the kallsyms code to filter out symbols with
> the __efistub_ prefix explicitly, so we no longer require the
> hack in our linker script to emit them as absolute symbols.

!!!
Sorry, I think we should pick 1212f7a16af4 ("scripts/kallsyms: filter
arm64's __efistub_ symbols") for 4.14 to go with this patch.

My usual gitfu to see the first tag that contained a commit `git
describe --contains "$tag" | sed 's/~.*//'` says next-20180319 which
isn't something I recognize or would have expected.  I see the changed
code in 4.19.y LTS but not 4.14.y LTS.

>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> [ND: adjusted for context]
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/arm64/kernel/image.h |   44 +++++++++++++++++---------------------------
>  1 file changed, 17 insertions(+), 27 deletions(-)
>
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -76,16 +76,6 @@
>  __efistub_stext_offset = stext - _text;
>
>  /*
> - * Prevent the symbol aliases below from being emitted into the kallsyms
> - * table, by forcing them to be absolute symbols (which are conveniently
> - * ignored by scripts/kallsyms) rather than section relative symbols.
> - * The distinction is only relevant for partial linking, and only for symbols
> - * that are defined within a section declaration (which is not the case for
> - * the definitions below) so the resulting values will be identical.
> - */
> -#define KALLSYMS_HIDE(sym)     ABSOLUTE(sym)
> -
> -/*
>   * The EFI stub has its own symbol namespace prefixed by __efistub_, to
>   * isolate it from the kernel proper. The following symbols are legally
>   * accessed by the stub, so provide some aliases to make them accessible.
> @@ -94,27 +84,27 @@ __efistub_stext_offset = stext - _text;
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
>
>


-- 
Thanks,
~Nick Desaulniers
