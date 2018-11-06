Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A78C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6532085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okfqT/e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6532085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbeKFWk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:40:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40363 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbeKFWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:40:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so11371994lji.7;
        Tue, 06 Nov 2018 05:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=XdsEsvQhFDRxPoVzl2esoGKBEeoG/KmWLReHCkpUdV4=;
        b=okfqT/e/72szxy6f+HRJfaiURk1NIQglBIhn9fedULEa69GsEqTDbwD/CwEdwGLgAb
         MHMFNBtTWTugLqiSLk+O+8xAe20nv6uVW01icNiXIsfmEVD2WmgQ/38/F4PKlgXrPiPJ
         95OQfzJXe08Olf2Ojq0qPyja6AzL5vs3WTmSNEzMvCn/yljLm8IK41GkhHECjZwzF1hx
         P41ZE8xYmOOr6qGD5a4wVKPKxQa71NpHBt5lOPXCeEpNwTNWVXLEZG+DrmZOTSD5TPJF
         TP5aTpH4nUI3LZYW56R9dx87lJoEtopM4ZcbYTvcexdtrargPeS+oYnlziW/JYMHKRq3
         jKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XdsEsvQhFDRxPoVzl2esoGKBEeoG/KmWLReHCkpUdV4=;
        b=ggjVyBBApWwuIyyGgnwMLTCgfMS4Co4OPmIu13o0rzJNZ+mh3konIZJ0az9Br7ShMk
         u7rEGFlqy/Gi+/G9zlpS8JG/JBD1ONeoV/rZM+osjaRicR7+Ja2FHiWTW7xUjWMtxH/V
         kzDBywS7HNoMWR7q8Yx0wyRmvpMuVAvuvBWr6wElYCMSaquauKHpwzd00ywm3e7R2SxQ
         X0835dHtLXnqvW5IXf93HEY0fN7uqOxDauWRvvepo9KOBRjxsndFY7jKH/uDJiv1Dp5c
         UVyZBo8a4Hwg2RfswNuT7uESOzNqludTAwy0JGRoy0pOVUU0Kkj2zOdWMKPFyKLDn1NR
         PoBg==
X-Gm-Message-State: AGRZ1gIx1zw8KTVv2JdBA/Bpiw68+LvmUSnxufb2tfOpiXr/wi+hBGEN
        bIxh6GKdGqj3JtKyany6NVoUl3Jbj3D5RdRI4aE=
X-Google-Smtp-Source: AJdET5dBJmL7S9bPRxshZ11cKrLGA/K9wjPJ7joy5yIV2972BkNGY5nUvtaEdFVRtaW+P9IVL7w/UhjWoTCsSTPgp0Q=
X-Received: by 2002:a2e:9d50:: with SMTP id y16-v6mr18657622ljj.136.1541510115541;
 Tue, 06 Nov 2018 05:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20181013010348.6740-1-natechancellor@gmail.com>
 <20181023175309.GA3384@flashbox> <CA+icZUXsS53RANWBNWw7_HcRRGyzVW1EepBU-K1pumrue6bYtg@mail.gmail.com>
 <CAKv+Gu8eJxLcNkvSzzKf0P+gjhtGRdLQW9J+gcDRhhGCi-pHJg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8eJxLcNkvSzzKf0P+gjhtGRdLQW9J+gcDRhhGCi-pHJg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 6 Nov 2018 14:15:03 +0100
Message-ID: <CA+icZUUK_B-_Brdr7LpiexEHJTytquhKN+4uidc+GmyMkJN8Og@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
To:     ard.biesheuvel@linaro.org
Cc:     natechancellor@gmail.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 1:52 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 24 October 2018 at 09:22, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > On Tue, Oct 23, 2018 at 7:53 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> >>
> >> On Fri, Oct 12, 2018 at 06:03:49PM -0700, Nathan Chancellor wrote:
> >> > When building the kernel with Clang, some disabled warnings appear
> >> > because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
> >> > this list so that the build is clean again.
> >> >
> >> > -Wpointer-sign was disabled for the whole kernel before the beginning
> >> > of git history.
> >> >
> >> > -Waddress-of-packed-member was disabled for the whole kernel in
> >> > commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
> >> > warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
> >> > Disable the address-of-packed-member compiler warning").
> >> >
> >> > -Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
> >> > LLVMLinux: Add Kbuild support for building kernel with Clang") and for
> >> > x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
> >> > warnings about GNU extensions").
> >> >
> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/112
> >> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> > ---
> >> >
> >> > Nick expressed concern that this Makefile is overwriting KBUILD_CFLAGS
> >> > and suggested potentially rewriting the x86 portion of this Makefile to
> >> > behave like the arm/arm64 one where problematic flags are filtered out.
> >> > While that comes to fruition, it would be nice for this folder to behave
> >> > like the rest of the kernel when it comes to this warnings so that the
> >> > build is cleaner, thus this patch.
> >> >
> >> >  drivers/firmware/efi/libstub/Makefile | 5 ++++-
> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> >> > index c51627660dbb..d9845099635e 100644
> >> > --- a/drivers/firmware/efi/libstub/Makefile
> >> > +++ b/drivers/firmware/efi/libstub/Makefile
> >> > @@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)              := -march=i386
> >> >  cflags-$(CONFIG_X86_64)              := -mcmodel=small
> >> >  cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
> >> >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
> >> > -                                -mno-mmx -mno-sse -fshort-wchar
> >> > +                                -mno-mmx -mno-sse -fshort-wchar \
> >> > +                                -Wno-pointer-sign \
> >> > +                                $(call cc-disable-warning, address-of-packed-member) \
> >> > +                                $(call cc-disable-warning, gnu)
> >> >
> >> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> >> >  # disable the stackleak plugin
> >> > --
> >> > 2.19.1
> >> >
> >>
> >> + Sedat for review/testing.
> >
> > Thanks Nathan.
> >
> > Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > [ Reported-by: Sedat Dilek <sedat.dilek@gmail.com> ]
> > [ See duplicate "arch/x86/include/asm/processor.h: Warning
> > -Waddress-of-packed-member "
> > <https://github.com/ClangBuiltLinux/linux/issues/234> ]
> >
>
> Queued in efi/next
>

Thanks Ard.
This means efi-for-4.21 / efi-for-5.0?

- Sedat -
