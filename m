Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B89C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8175E20685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0EyG8wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8175E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbeKFXl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:41:59 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54625 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeKFXl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:41:59 -0500
Received: by mail-it1-f194.google.com with SMTP id d6so17983602itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eAuZtr7Nm9j7EryK3beWgeSlnxQRvOWJrQsSqEEj/+A=;
        b=j0EyG8wisyeDK+WRT4GE+zcYkxN5RPFxVTZXfkLFW9YuDXojXU5SAF73ttcoln+AY8
         4oekRj8Unn2loMzwxVzCzb4mZ8geOopk1gx0nsTDPfnpPQlIAJsPfodzSeO5Jp0QwAPK
         BsYqYbxPXfpmRi1HwB7WxG7DmtPNoibmbZKh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eAuZtr7Nm9j7EryK3beWgeSlnxQRvOWJrQsSqEEj/+A=;
        b=bR04wfyTYzr/aFqHwNSFjJXgUoGTcExQp1vScXKkymL/EKphWp0MZJgUsoxt2RUPGK
         dY5BbApOXnACZebl5WJhw9hPzUzwXl46DjBuo7W8rJyAXSTDg6QCetBvfYpycex/pEno
         yK1/DcxhK1GJfKxiR6WDaur1h4NLiSbDGWs3cS7xT6HDTt/WD9y2JeeqPHDvFE2WtV5v
         7mUaojBXPztxlWVlRXKkwus+b0UCSEtVZeojsENN9+UjhQIuMFScpiR4+jYYkTerdNMi
         o58Dzyc5QuNvBEX3eBE222QS5w/tWs/xWDcVdoDa8P0QUR4FS6cz9B7GKEPw3WZ3OlGZ
         zoBw==
X-Gm-Message-State: AGRZ1gJIgcVF5qXt/6dEXoxNJDfW/68FacizcupHx0K48Q4PHD+bGFcT
        XNWkTzYYeDrvMqufyJqVPDqh9468S1rx5VuzAgh9kA==
X-Google-Smtp-Source: AJdET5e4cp1QOGHviBo2k20mPDLTen375hgI+fxTFHSQriscr4iV5AzDTHeLZpqSf9B8KOXCVL6WNiLpgiC8p03EuHw=
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr241117ita.71.1541513792562;
 Tue, 06 Nov 2018 06:16:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 06:16:31 -0800 (PST)
In-Reply-To: <CA+icZUUK_B-_Brdr7LpiexEHJTytquhKN+4uidc+GmyMkJN8Og@mail.gmail.com>
References: <20181013010348.6740-1-natechancellor@gmail.com>
 <20181023175309.GA3384@flashbox> <CA+icZUXsS53RANWBNWw7_HcRRGyzVW1EepBU-K1pumrue6bYtg@mail.gmail.com>
 <CAKv+Gu8eJxLcNkvSzzKf0P+gjhtGRdLQW9J+gcDRhhGCi-pHJg@mail.gmail.com> <CA+icZUUK_B-_Brdr7LpiexEHJTytquhKN+4uidc+GmyMkJN8Og@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 6 Nov 2018 15:16:31 +0100
Message-ID: <CAKv+Gu_JdioRGRM5DiinK9a+2koK-NZLa858OAdap9PGe8vCtA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
To:     sedat.dilek@gmail.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 November 2018 at 14:15, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Mon, Nov 5, 2018 at 1:52 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>> On 24 October 2018 at 09:22, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> > On Tue, Oct 23, 2018 at 7:53 PM Nathan Chancellor
>> > <natechancellor@gmail.com> wrote:
>> >>
>> >> On Fri, Oct 12, 2018 at 06:03:49PM -0700, Nathan Chancellor wrote:
>> >> > When building the kernel with Clang, some disabled warnings appear
>> >> > because this Makefile overrides KBUILD_CFLAGS for x86{,_64}. Add them to
>> >> > this list so that the build is clean again.
>> >> >
>> >> > -Wpointer-sign was disabled for the whole kernel before the beginning
>> >> > of git history.
>> >> >
>> >> > -Waddress-of-packed-member was disabled for the whole kernel in
>> >> > commit bfb38988c51e ("kbuild: clang: Disable 'address-of-packed-member'
>> >> > warning") and for x86/boot/compressed in commit 20c6c1890455 ("x86/boot:
>> >> > Disable the address-of-packed-member compiler warning").
>> >> >
>> >> > -Wgnu was disabled for the whole kernel in commit 61163efae020 ("kbuild:
>> >> > LLVMLinux: Add Kbuild support for building kernel with Clang") and for
>> >> > x86/boot/compressed in commit 6c3b56b19730 ("x86/boot: Disable Clang
>> >> > warnings about GNU extensions").
>> >> >
>> >> > Link: https://github.com/ClangBuiltLinux/linux/issues/112
>> >> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> >> > ---
>> >> >
>> >> > Nick expressed concern that this Makefile is overwriting KBUILD_CFLAGS
>> >> > and suggested potentially rewriting the x86 portion of this Makefile to
>> >> > behave like the arm/arm64 one where problematic flags are filtered out.
>> >> > While that comes to fruition, it would be nice for this folder to behave
>> >> > like the rest of the kernel when it comes to this warnings so that the
>> >> > build is cleaner, thus this patch.
>> >> >
>> >> >  drivers/firmware/efi/libstub/Makefile | 5 ++++-
>> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> >> > index c51627660dbb..d9845099635e 100644
>> >> > --- a/drivers/firmware/efi/libstub/Makefile
>> >> > +++ b/drivers/firmware/efi/libstub/Makefile
>> >> > @@ -9,7 +9,10 @@ cflags-$(CONFIG_X86_32)              := -march=i386
>> >> >  cflags-$(CONFIG_X86_64)              := -mcmodel=small
>> >> >  cflags-$(CONFIG_X86)         += -m$(BITS) -D__KERNEL__ -O2 \
>> >> >                                  -fPIC -fno-strict-aliasing -mno-red-zone \
>> >> > -                                -mno-mmx -mno-sse -fshort-wchar
>> >> > +                                -mno-mmx -mno-sse -fshort-wchar \
>> >> > +                                -Wno-pointer-sign \
>> >> > +                                $(call cc-disable-warning, address-of-packed-member) \
>> >> > +                                $(call cc-disable-warning, gnu)
>> >> >
>> >> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>> >> >  # disable the stackleak plugin
>> >> > --
>> >> > 2.19.1
>> >> >
>> >>
>> >> + Sedat for review/testing.
>> >
>> > Thanks Nathan.
>> >
>> > Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
>> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
>> > [ Reported-by: Sedat Dilek <sedat.dilek@gmail.com> ]
>> > [ See duplicate "arch/x86/include/asm/processor.h: Warning
>> > -Waddress-of-packed-member "
>> > <https://github.com/ClangBuiltLinux/linux/issues/234> ]
>> >
>>
>> Queued in efi/next
>>
>
> Thanks Ard.
> This means efi-for-4.21 / efi-for-5.0?
>

Yes
