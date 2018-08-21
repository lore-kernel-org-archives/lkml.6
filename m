Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35ECC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976C8217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GTvtM3b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976C8217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeHUUVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:21:12 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46408 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeHUUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:21:11 -0400
Received: by mail-io0-f196.google.com with SMTP id y12-v6so6232342ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=soThsR83dBv2CqgGIlTGG/TbWFg4WLYYoqNcyYGSIYc=;
        b=GTvtM3b2qeWRCv57pjJHvmO63lxMIM1bHJFJrGtyICyO9TCpf/bSM0T2pkYZFtLuWt
         1NMfanPaW+1CPJyqy2j75zFiOFcpfsIoH0nnkMHAeJE+u+xh9mq6vYTmHFYbAq4Muq0x
         6M66H3GPfX3H9lnCBi7cCWzCrTjZq9vgGMB6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=soThsR83dBv2CqgGIlTGG/TbWFg4WLYYoqNcyYGSIYc=;
        b=tnOlJ5XjrJ0LllpaYby39nJj888OgOXpgHjaLAn2+2AmRU0wVDPeUTYEKeY1ctbUlW
         5sgv1ClV/oYeIkuxd99wFDIPROPU7fimC43e2x0gdw4l7kBIxAX28aV/klgfZtlg99Kq
         NM2cM7QlKYonuuKGwOTffD1RDm6ER6dfJafrLExM4E1iBUpVhMX+miFHffAf86+d4A53
         nDNuKeyay8juwwm9szoOkNV8uB2KNrMC8bqi0MFEri1a9T8QQ7Mu7dmbAO1wR5w8MGaT
         eX6jibEfbD2Y/61WIEXhPu36EwblI2d6F3rpPSewJellLm4GAQTrHKPjJ8Q4nNR0q0bz
         n0vQ==
X-Gm-Message-State: AOUpUlHi1H9Jy8HczWa4FPliyzIPk5GNkfpkqfEIWn5BkW8/GNWZ94o2
        0YiQvc8ThWis9YnSi+u9oRYDIQfcnah7VdXoWMU3gQ==
X-Google-Smtp-Source: AA+uWPwzgYYuUZKClwg//qUTiORy4ZX8MtB43DYS8dP78W8l0NlwsJgDo81cTAspJ2F0uCLVrTHorxos8zxFmCgmhA8=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr42576095iof.173.1534870814495;
 Tue, 21 Aug 2018 10:00:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 10:00:13
 -0700 (PDT)
In-Reply-To: <CAKwvOdkZR-MWuMU=j=kKXQwA0LEj1n0uoZQyTpwOzZuz9gjmJQ@mail.gmail.com>
References: <20180820224032.53194-1-ndesaulniers@google.com>
 <CAKv+Gu-xAmadr96vwStOxdeqi=rCEBrn8V6GofexBhpmA=JiuA@mail.gmail.com> <CAKwvOdkZR-MWuMU=j=kKXQwA0LEj1n0uoZQyTpwOzZuz9gjmJQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 21 Aug 2018 19:00:13 +0200
Message-ID: <CAKv+Gu8ZZYvh9ZthRH7mvG7_j3bvT=3st-aj0kdwpNQaAcs=-w@mail.gmail.com>
Subject: Re: [PATCH] arm64/crypto: remove non-standard notation
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 August 2018 at 18:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
> On Tue, Aug 21, 2018 at 5:23 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> Hi Nick,
>>
>> On 21 August 2018 at 00:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
>> > It seems that:
>> > ldr q8, =0x30000000200000001
>> >
>> > is a GNU as convience notation for:
>> > ldr q8, .Lconstant
>> > .Lconstant
>> > .word 0x00000001
>> > .word 0x00000002
>> > .word 0x00000003
>> > .word 0x00000000
>> >
>> > based on this comment in binutils' source [0]. I've asked for this
>> > non-standard convience notation to be added to other assemblers [1], but
>> > until then, we can remove it and get equivalent disassembly:
>> >
>>
>> What do you mean by 'non-standard convenience notation'? Which asm
>> 'standard' does Clang actually claim to implement?
>
> Well, for assembly 'standard' is a bit nebulous.  But it's frustrating
> when you can't find what the `=0x...` notation means in either the ARM
> or GNU as manuals.  The source of truth happened to be a comment in
> the source [0] that explained that this was a "programmer friendly
> notation."  Sure, if you can find it.
>

Well, it is documented in the ARM manuals as the 'ldr pseudo
instruction' for 32-bit ARM, and originally, it would only emit a
literal if the value could not be loaded using a ordinary mov.

For AArch64, I don't think that occurs any longer, i.e., a ldr is
always emitted as an ldr. However, it is used widely in the ARM code
(although not as much in arch/arm64) for loading compile time
constants and even symbol addresses into general purpose registers.
The FP variant may actually be a GNU invention, but given that there
is no standard to begin with, playing the 'GNU is non-standard' card
again is just a bit annoying.

>>
>> This 'GCC/binutils is broken and we are reluctant to subvert Clang'
>> attitude is getting a bit old tbh. In the future, could you please
>> mention clang explicitly in the patch subject so it is obvious what
>> the purpose of the patch is? I think we should accommodate Clang in
>> Linux, but the attitude has got to go.
>
> 'Reluctant?' Please assume good faith; I filed the bug/noticed
> yesterday [1]. And I'm in favor of supporting the shorthand.  That's
> not my argument at all; Strawman.
>

OK, fair enough. But note that Clang already supports the syntax for GPRs.

>>
>>
>> > before:
>> > 00000000000009d4 <neon_aes_ctr_encrypt>:
>> > ...
>> >      a48:       9c000ac8        ldr     q8, ba0 <neon_aes_ctr_encrypt+0x1cc>
>> > ...
>> >      ba0:       00000001        .word   0x00000001
>> >      ba4:       00000002        .word   0x00000002
>> >      ba8:       00000003        .word   0x00000003
>> >      bac:       00000000        .word   0x00000000
>> >
>> > after:
>> >
>> > 00000000000009d4 <neon_aes_ctr_encrypt>:
>> > ...
>> >      a48:       9c000aa8        ldr     q8, b9c <neon_aes_ctr_encrypt+0x1c8>
>> > ...
>> >      b9c:       00000001        .word   0x00000001
>> >      ba0:       00000002        .word   0x00000002
>> >      ba4:       00000003        .word   0x00000003
>> >      ba8:       00000000        .word   0x00000000
>> >
>> > [0] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gas/testsuite/gas/aarch64/programmer-friendly.s;h=6254c6476efdc848648b05068be0574e7addc85d;hb=HEAD#l11
>> > [1] https://bugs.llvm.org/show_bug.cgi?id=38642
>> >
>> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> > ---
>> >  arch/arm64/crypto/aes-modes.S | 8 +++++++-
>> >  1 file changed, 7 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
>> > index 483a7130cf0e..9288c5b0eca2 100644
>> > --- a/arch/arm64/crypto/aes-modes.S
>> > +++ b/arch/arm64/crypto/aes-modes.S
>> > @@ -232,7 +232,7 @@ AES_ENTRY(aes_ctr_encrypt)
>> >         bmi             .Lctr1x
>> >         cmn             w6, #4                  /* 32 bit overflow? */
>> >         bcs             .Lctr1x
>> > -       ldr             q8, =0x30000000200000001        /* addends 1,2,3[,0] */
>> > +       ldr             q8, .Laddends /* addends 1,2,3[,0] */
>> >         dup             v7.4s, w6
>> >         mov             v0.16b, v4.16b
>> >         add             v7.4s, v7.4s, v8.4s
>> > @@ -295,6 +295,12 @@ AES_ENTRY(aes_ctr_encrypt)
>> >         rev             x7, x7
>> >         ins             v4.d[0], x7
>> >         b               .Lctrcarrydone
>> > +
>> > +.Laddends:
>> > +       .word   0x00000001
>> > +       .word   0x00000002
>> > +       .word   0x00000003
>> > +       .word   0x00000000
>>
>
>
>> As Will points out, this breaks BE builds.
>
> Looks like -EB and -EL are the flags for me to test with in GNU as
> (looks like a few different flags for this).  Is there a target triple
> ABI for BE?  I'll ask around here too, and post my findings.
>
>>
>> >  AES_ENDPROC(aes_ctr_encrypt)
>> >         .ltorg
>>
>> You can drop this .ltorg if you get rid of all =xxx instances.
>>
>> Actually, though, I would prefer it if we could use some clever short
>> sequence of movi+add instructions, and get rid of the literal
>> altogether. Or otherwise, please use something like
>>
>> ldr_l q8, .Laddends, <temp register>
>>
>> instead, and move the literal into the .rodata section (and use .octa
>> so you don't break BE)
>
> Ah, .octa, neat.  Ok, I'll take a look for v2.
>

Please check my solution first. I just sent it out.
