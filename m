Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F7C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263552054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5fWmRei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263552054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeJXPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:49:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44355 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeJXPtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:49:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id m18-v6so3129315lfl.11;
        Wed, 24 Oct 2018 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=QxwiTSQR+ox0BOPzFWdIcEABe5SMSx2kQvg2R69Zhcw=;
        b=W5fWmReiSdiAaR4sxq7TL04aB04e//ynKJ+IEOFOkNbgNz6RUT+olqEsTRIVPYUkls
         dBG+Gm0t9OWGoKhesAvARt0DKH3gmH4DPj1rwFWIPPlc2AIbfIIvs384FcF7iJMxXscD
         1XgZJ9MMT2QqNCmSYixsoxxHZFePBMXq/mYCZIeGU8Fl8UweIOH9lePOSJP1oJr4A2Su
         7VVOohYpzVRK2Nr7ZqUNFZ/eu6Sez9Em3iBpFS30TONS0VaMspEYy6/oohj+/T8qzZa6
         sCi9xjX3svXHcONHNlLorfj4scwwLNFizIhAELCKwjoxX2XUPRoibNfrOZAgHEM4+2hQ
         CMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=QxwiTSQR+ox0BOPzFWdIcEABe5SMSx2kQvg2R69Zhcw=;
        b=fYyIewjug9hsFf1Ynuej2Vcbt6gvoNLfbf/Vtvzw+3EzBqgNQeRB7G/X6uJC2IdK1c
         cZEA41zWPIOF5kOinpdPf0/Rg8mnH/Q+5S8fMD4j6Dm7HK6jriR7kYM1dmWS+9WUQU2m
         zHs0gdplXqCKr2H2cdcbH0kN8H0duDcJ6hTpKEyp94VeH/2yAQ514WmsCD2o8fQ7a09R
         pTOLihTaulfBAYM1X38nYZKSXR/AeRsuqHSYMj5X28l6OTI6E1eFIxgM93CSmLvkl/N7
         CG8BYjzgexywx8j10fZAyQDhJKXlGGtxHpWyr64GoTHP1SmMpOyZ1H8O6LuL618WCJpm
         TV7w==
X-Gm-Message-State: AGRZ1gJHvesGrM4UdqNqI+iIU+sRYigErYaOViYNbO3RHGfxLNkyJUr9
        GgNe/zjQ4LkeXzg5t3+Jw71JFjgnwXvyCB7+A5k=
X-Google-Smtp-Source: AJdET5dO8NR+QAiebwLgbD1cfKH7jY91Xl/cSwe7RJpH16IidSlagyMCE/DTcLRA+TJFiWyo7CPUbiZVHScfb9OxfGU=
X-Received: by 2002:a19:d78c:: with SMTP id q12mr2298780lfi.27.1540365732785;
 Wed, 24 Oct 2018 00:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181013010348.6740-1-natechancellor@gmail.com> <20181023175309.GA3384@flashbox>
In-Reply-To: <20181023175309.GA3384@flashbox>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 24 Oct 2018 09:22:01 +0200
Message-ID: <CA+icZUXsS53RANWBNWw7_HcRRGyzVW1EepBU-K1pumrue6bYtg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
To:     natechancellor@gmail.com
Cc:     ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 7:53 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Oct 12, 2018 at 06:03:49PM -0700, Nathan Chancellor wrote:
> > When building the kernel with Clang, some disabled warnings appear
> > because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
> > this list so that the build is clean again.
> >
> > -Wpointer-sign was disabled for the whole kernel before the beginning
> > of git history.
> >
> > -Waddress-of-packed-member was disabled for the whole kernel in
> > commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
> > warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
> > Disable the address-of-packed-member compiler warning").
> >
> > -Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
> > LLVMLinux: Add Kbuild support for building kernel with Clang") and for
> > x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
> > warnings about GNU extensions").
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/112
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > Nick expressed concern that this Makefile is overwriting KBUILD_CFLAGS
> > and suggested potentially rewriting the x86 portion of this Makefile to
> > behave like the arm/arm64 one where problematic flags are filtered out.
> > While that comes to fruition, it would be nice for this folder to behave
> > like the rest of the kernel when it comes to this warnings so that the
> > build is cleaner, thus this patch.
> >
> >  drivers/firmware/efi/libstub/Makefile | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index c51627660dbb..d9845099635e 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)              := -march=i386
> >  cflags-$(CONFIG_X86_64)              := -mcmodel=small
> >  cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
> >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
> > -                                -mno-mmx -mno-sse -fshort-wchar
> > +                                -mno-mmx -mno-sse -fshort-wchar \
> > +                                -Wno-pointer-sign \
> > +                                $(call cc-disable-warning, address-of-packed-member) \
> > +                                $(call cc-disable-warning, gnu)
> >
> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> >  # disable the stackleak plugin
> > --
> > 2.19.1
> >
>
> + Sedat for review/testing.

Thanks Nathan.

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
[ Reported-by: Sedat Dilek <sedat.dilek@gmail.com> ]
[ See duplicate "arch/x86/include/asm/processor.h: Warning
-Waddress-of-packed-member "
<https://github.com/ClangBuiltLinux/linux/issues/234> ]

Regards,
- Sedat -
