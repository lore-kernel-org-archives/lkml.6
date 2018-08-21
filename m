Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B16FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04801214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItMACsmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04801214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeHUULv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:11:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43296 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeHUULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:11:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so8768524pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebkvD4y+HkqRYPd6oy37QD+lC/Qg68gYDIGaWFOPXBI=;
        b=ItMACsmhFtAseAPRwFPHIZslfqLW2LSuhczqN55Jv0snL3W6KLAwKpXblbrkT12b6Q
         FVVHQvDEEujLkHx5NnfRDVt+6XbRowtoPSj/DfjVpsos7RdYNvPIGlnTeLIVEHyzdOPA
         xIV20AYgpLS4ry3Hhl5qnKbrsMKmv85yK9vCbkctp4Z+GpBUyAEHjxjm1OWlbXQg1ZF0
         iAgbs1Ur7scBWsbu9/6i3ctsKWslmzgpDu6OvmKhKEHR0S/aGgH+/teVCZsiXD2Y6Yjd
         qRPsSBpLGUxyKv/UuyzSmFvug9BrM+lkCdaLCfgWuKFGQm3RvmX4qg5+e3YCxqY/sUkv
         B2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebkvD4y+HkqRYPd6oy37QD+lC/Qg68gYDIGaWFOPXBI=;
        b=iwvDfAUiqiAJxFoTDpHM9wR0R4EtQQkZQ1IxTz1hnGg2bwxDWUxspGQvGwn5QJVUgI
         VzXVosfGulXnRqFZ9e9VN1gk9zc6NjQdR7NMF/+JXdpt4H7+DNQjzS+F5B5CMuVzxbw9
         nMIzOEPlZTCA9BXPHoWV3Izu9wQZEZXADlrThUPnnVGysJblanyt3006WK09t9GZyMAa
         uQ6GSMswnRidIkFVq2xhGm161ppea2LBcVnaoXGaN790zjBvwTFs6xu/ArZemu69wuZG
         PILUey6hBI4W7k+rTUdVLa9ZONo6EOTqmiMsn7k5TQIVgc0hUXfRjDKzOB136UkZA9WY
         SsEw==
X-Gm-Message-State: AOUpUlE5IFKuRCHQzbUg/kASG1Jc1XqnWPLxniAYxZWfkYP6bowc1Mw5
        R321Pikr4OE/FYH5ldgUbaUrLjhcqmNKGXnuSUHtgA==
X-Google-Smtp-Source: AA+uWPzLb4uk5P4VsbRUFhMCxY9e+rRTgiIvRfYowtd+AzdnCyJt+bUSoIKyGqnU8mKwtffRFcjJa3hFGxJBDTlAn0M=
X-Received: by 2002:a63:6243:: with SMTP id w64-v6mr20987798pgb.145.1534870256151;
 Tue, 21 Aug 2018 09:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180820224032.53194-1-ndesaulniers@google.com> <CAKv+Gu-xAmadr96vwStOxdeqi=rCEBrn8V6GofexBhpmA=JiuA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-xAmadr96vwStOxdeqi=rCEBrn8V6GofexBhpmA=JiuA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Aug 2018 09:50:44 -0700
Message-ID: <CAKwvOdkZR-MWuMU=j=kKXQwA0LEj1n0uoZQyTpwOzZuz9gjmJQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/crypto: remove non-standard notation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-crypto@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 5:23 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> Hi Nick,
>
> On 21 August 2018 at 00:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > It seems that:
> > ldr q8, =0x30000000200000001
> >
> > is a GNU as convience notation for:
> > ldr q8, .Lconstant
> > .Lconstant
> > .word 0x00000001
> > .word 0x00000002
> > .word 0x00000003
> > .word 0x00000000
> >
> > based on this comment in binutils' source [0]. I've asked for this
> > non-standard convience notation to be added to other assemblers [1], but
> > until then, we can remove it and get equivalent disassembly:
> >
>
> What do you mean by 'non-standard convenience notation'? Which asm
> 'standard' does Clang actually claim to implement?

Well, for assembly 'standard' is a bit nebulous.  But it's frustrating
when you can't find what the `=0x...` notation means in either the ARM
or GNU as manuals.  The source of truth happened to be a comment in
the source [0] that explained that this was a "programmer friendly
notation."  Sure, if you can find it.

>
> This 'GCC/binutils is broken and we are reluctant to subvert Clang'
> attitude is getting a bit old tbh. In the future, could you please
> mention clang explicitly in the patch subject so it is obvious what
> the purpose of the patch is? I think we should accommodate Clang in
> Linux, but the attitude has got to go.

'Reluctant?' Please assume good faith; I filed the bug/noticed
yesterday [1]. And I'm in favor of supporting the shorthand.  That's
not my argument at all; Strawman.

>
>
> > before:
> > 00000000000009d4 <neon_aes_ctr_encrypt>:
> > ...
> >      a48:       9c000ac8        ldr     q8, ba0 <neon_aes_ctr_encrypt+0x1cc>
> > ...
> >      ba0:       00000001        .word   0x00000001
> >      ba4:       00000002        .word   0x00000002
> >      ba8:       00000003        .word   0x00000003
> >      bac:       00000000        .word   0x00000000
> >
> > after:
> >
> > 00000000000009d4 <neon_aes_ctr_encrypt>:
> > ...
> >      a48:       9c000aa8        ldr     q8, b9c <neon_aes_ctr_encrypt+0x1c8>
> > ...
> >      b9c:       00000001        .word   0x00000001
> >      ba0:       00000002        .word   0x00000002
> >      ba4:       00000003        .word   0x00000003
> >      ba8:       00000000        .word   0x00000000
> >
> > [0] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gas/testsuite/gas/aarch64/programmer-friendly.s;h=6254c6476efdc848648b05068be0574e7addc85d;hb=HEAD#l11
> > [1] https://bugs.llvm.org/show_bug.cgi?id=38642
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/arm64/crypto/aes-modes.S | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
> > index 483a7130cf0e..9288c5b0eca2 100644
> > --- a/arch/arm64/crypto/aes-modes.S
> > +++ b/arch/arm64/crypto/aes-modes.S
> > @@ -232,7 +232,7 @@ AES_ENTRY(aes_ctr_encrypt)
> >         bmi             .Lctr1x
> >         cmn             w6, #4                  /* 32 bit overflow? */
> >         bcs             .Lctr1x
> > -       ldr             q8, =0x30000000200000001        /* addends 1,2,3[,0] */
> > +       ldr             q8, .Laddends /* addends 1,2,3[,0] */
> >         dup             v7.4s, w6
> >         mov             v0.16b, v4.16b
> >         add             v7.4s, v7.4s, v8.4s
> > @@ -295,6 +295,12 @@ AES_ENTRY(aes_ctr_encrypt)
> >         rev             x7, x7
> >         ins             v4.d[0], x7
> >         b               .Lctrcarrydone
> > +
> > +.Laddends:
> > +       .word   0x00000001
> > +       .word   0x00000002
> > +       .word   0x00000003
> > +       .word   0x00000000
>


> As Will points out, this breaks BE builds.

Looks like -EB and -EL are the flags for me to test with in GNU as
(looks like a few different flags for this).  Is there a target triple
ABI for BE?  I'll ask around here too, and post my findings.

>
> >  AES_ENDPROC(aes_ctr_encrypt)
> >         .ltorg
>
> You can drop this .ltorg if you get rid of all =xxx instances.
>
> Actually, though, I would prefer it if we could use some clever short
> sequence of movi+add instructions, and get rid of the literal
> altogether. Or otherwise, please use something like
>
> ldr_l q8, .Laddends, <temp register>
>
> instead, and move the literal into the .rodata section (and use .octa
> so you don't break BE)

Ah, .octa, neat.  Ok, I'll take a look for v2.

-- 
Thanks,
~Nick Desaulniers
