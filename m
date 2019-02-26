Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F6BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9C62147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5ASO6gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfBZHTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:19:18 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36783 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBZHTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:19:18 -0500
Received: by mail-it1-f196.google.com with SMTP id v83so2630492itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 23:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCBZlZLPWeHLZ5F3g2a87xSjmvBhiV4yB8X31OqkpwU=;
        b=u5ASO6glvVBsZL+CvTpLfi8IWW6luXmt2UOqNFZ4IQImZdRL9BHKAM1YcuW7UHYp2w
         tW+/YnzH+ZUJB9//aU1LOc0iKPCE+cG0qw9ifA5IsGsXpebraCaaAP4xk6CEw8mEBCWb
         sxc9uP8bJ3MG3pwwalTQadSzRmSxLS3QAcuYZhEUCB6nW1Dj7YjwUxQ7BiWDL4+GDCOK
         bRdtdciJrHV1seCSq1bDDMN2DVU2RZCZ452rEr7abbdV9jy1jI4/PIUYGxZ18kJrFEce
         Cgp5e1ylu+xjmfxwA9ZFl3YIlOFft4peDt4osdGDt0H3THJrVZF+dbu5FpAug3+t6tp6
         Hfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCBZlZLPWeHLZ5F3g2a87xSjmvBhiV4yB8X31OqkpwU=;
        b=bHD5M0DLDhlsim1otYwV1DTAiwDUM/bI7QpWXsZqsHW/BybLsw+eo2WRQgeLSJXZSw
         MyzAedgurSldzT/c1qecWZ4YHB9NfjYn3NQyAyA9CohrpDwhKGZ0GvAFIKCTn+3Siou5
         NThRyH/xIal8W8gTBVVGm6Z4fUdtJofMoZDvgIn+0tAaj6EWOdEONu6PCwbWCkliyPaL
         vPRmbLPg3WUYQb6FVXaqTuEGVbU9JGvmOyWD30oYDwpg4NIuglMO1nwxOuS8SW8WbJ/V
         64BYvXZAoXb8JcgG78G7TikGc7bA9HIoqaTGffe0zkau40IKC0723U4LHQTCcQ8ewuZl
         TuzQ==
X-Gm-Message-State: AHQUAuYuUhsITbS42G3NTh9gmvH++9V6ME9yPziOdUWjnI62qlAqY42R
        HL714F3xaZA54/48fcdVPSr++WJdymBXizk4Sw7iLSdj0Es=
X-Google-Smtp-Source: AHgI3IYxI2rFSkFoQOtQNcr8IzscYtnYVIsusaEeCBs54o5c2TQeimLKI7oOr8D1A4op50Kay1dVwvWBDBwgnSr3+uI=
X-Received: by 2002:a05:6638:2a1:: with SMTP id d1mr3150266jaq.2.1551165557148;
 Mon, 25 Feb 2019 23:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20190226040345.202047-1-ndesaulniers@google.com>
In-Reply-To: <20190226040345.202047-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 26 Feb 2019 08:19:05 +0100
Message-ID: <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 at 05:03, <ndesaulniers@google.com> wrote:
>
> Clang warns: vector initializers are not compatible with NEON intrinsics
> in big endian mode [-Wnonportable-vector-initialization]
>
> While this is usually the case, it's not an issue for this case since
> we're initializing the uint8x16_t (16x uint8_t's) with the same value.
>
> Instead, use vdupq_n_u8 which both compilers lower into a single movi
> instruction: https://godbolt.org/z/vBrgzt
>
> This avoids the static storage for a constant value.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/214
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Much better, thanks,

Did you double check that the intrinsic exists on 32-bit ARM as well?
I assume it does, but please make sure if you haven't yet.

If so,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  lib/raid6/neon.uc            | 5 ++---
>  lib/raid6/recov_neon_inner.c | 7 ++-----
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/lib/raid6/neon.uc b/lib/raid6/neon.uc
> index d5242f544551..b7c68030da4f 100644
> --- a/lib/raid6/neon.uc
> +++ b/lib/raid6/neon.uc
> @@ -28,7 +28,6 @@
>
>  typedef uint8x16_t unative_t;
>
> -#define NBYTES(x) ((unative_t){x,x,x,x, x,x,x,x, x,x,x,x, x,x,x,x})
>  #define NSIZE  sizeof(unative_t)
>
>  /*
> @@ -61,7 +60,7 @@ void raid6_neon$#_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>         int d, z, z0;
>
>         register unative_t wd$$, wq$$, wp$$, w1$$, w2$$;
> -       const unative_t x1d = NBYTES(0x1d);
> +       const unative_t x1d = vdupq_n_u8(0x1d);
>
>         z0 = disks - 3;         /* Highest data disk */
>         p = dptr[z0+1];         /* XOR parity */
> @@ -92,7 +91,7 @@ void raid6_neon$#_xor_syndrome_real(int disks, int start, int stop,
>         int d, z, z0;
>
>         register unative_t wd$$, wq$$, wp$$, w1$$, w2$$;
> -       const unative_t x1d = NBYTES(0x1d);
> +       const unative_t x1d = vdupq_n_u8(0x1d);
>
>         z0 = stop;              /* P/Q right side optimization */
>         p = dptr[disks-2];      /* XOR parity */
> diff --git a/lib/raid6/recov_neon_inner.c b/lib/raid6/recov_neon_inner.c
> index 8cd20c9f834a..7d00c31a6547 100644
> --- a/lib/raid6/recov_neon_inner.c
> +++ b/lib/raid6/recov_neon_inner.c
> @@ -10,11 +10,6 @@
>
>  #include <arm_neon.h>
>
> -static const uint8x16_t x0f = {
> -       0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f,
> -       0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f,
> -};
> -
>  #ifdef CONFIG_ARM
>  /*
>   * AArch32 does not provide this intrinsic natively because it does not
> @@ -41,6 +36,7 @@ void __raid6_2data_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dp,
>         uint8x16_t pm1 = vld1q_u8(pbmul + 16);
>         uint8x16_t qm0 = vld1q_u8(qmul);
>         uint8x16_t qm1 = vld1q_u8(qmul + 16);
> +       uint8x16_t x0f = vdupq_n_u8(0x0f);
>
>         /*
>          * while ( bytes-- ) {
> @@ -87,6 +83,7 @@ void __raid6_datap_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dq,
>  {
>         uint8x16_t qm0 = vld1q_u8(qmul);
>         uint8x16_t qm1 = vld1q_u8(qmul + 16);
> +       uint8x16_t x0f = vdupq_n_u8(0x0f);
>
>         /*
>          * while (bytes--) {
> --
> 2.21.0.rc2.261.ga7da99ff1b-goog
>
