Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BC3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA536214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bq/9zoFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA536214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeHUPnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:43:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33504 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeHUPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:43:05 -0400
Received: by mail-it0-f65.google.com with SMTP id d16-v6so10861696itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fkhXxHUhodoXhwqE64f386JdNbrWP2oInE5rJVsE0u8=;
        b=Bq/9zoFyvz1+jhSSpBG6pYtlWLAeuuaQKaIxTa0NI6yGlJQpl79yzhKTKBQxgflxd6
         QQOMQjLyoZ8cTDhCJYshOiaPFOIF8pWCdkrhH0seJWIg/rdnGJfXLMk1yoicaphORShS
         rLXwuyF5e+eIWC8lVHxjPvjUmyJaw2Xb5n8mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fkhXxHUhodoXhwqE64f386JdNbrWP2oInE5rJVsE0u8=;
        b=PaRUSTeVKuzML8Y4X1jX4lkZFFderkTGaBdf2gKmLYnURK+h0frSq5fBBaqOhRYW53
         ILovPty4NhnIHy62DLESpxOwX5Ze8klIMd5W93lIXlhjzgOQjCtiH/SxrfH5+Zg5TU7W
         ySry+mU38nsBm9nsf3zTIwzzODFc20bxO84bfVoy2PieNyqkmR2tYNnLTknsxWQ1pDWd
         9OzHPc13hRgxUfXekHrGw5x/VUh6D/j2iA/9Rga+aZpNdsahBYO7cPJyLjddQ+6/JU6E
         ANmOt5EVlXg00T54njJZKSEV22q7v6kbF7u9JgFhDbrwukMJMbsyDWuxH8v23IsNuPMQ
         xsWw==
X-Gm-Message-State: AOUpUlGnRdMWj6DuUxnoe2FRQhWAE22RtUFKBdAKfiyH3YLXVg6VUAqS
        nU9g0uTDz3oAjri79xCrtsvqBwYwikbkdjZQvcCH+8HCAWg=
X-Google-Smtp-Source: AA+uWPzZ3HHsKCKsWW8OYipYLqlV/Lilou7CMFueh0GDA2askPdn9hbSwaJ/DGWBIWo4TSwFn9T3Tb9OkTdqYxWTRrw=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr37327969ita.148.1534854188815;
 Tue, 21 Aug 2018 05:23:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 05:23:08
 -0700 (PDT)
In-Reply-To: <20180820224032.53194-1-ndesaulniers@google.com>
References: <20180820224032.53194-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 21 Aug 2018 14:23:08 +0200
Message-ID: <CAKv+Gu-xAmadr96vwStOxdeqi=rCEBrn8V6GofexBhpmA=JiuA@mail.gmail.com>
Subject: Re: [PATCH] arm64/crypto: remove non-standard notation
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 21 August 2018 at 00:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
> It seems that:
> ldr q8, =0x30000000200000001
>
> is a GNU as convience notation for:
> ldr q8, .Lconstant
> .Lconstant
> .word 0x00000001
> .word 0x00000002
> .word 0x00000003
> .word 0x00000000
>
> based on this comment in binutils' source [0]. I've asked for this
> non-standard convience notation to be added to other assemblers [1], but
> until then, we can remove it and get equivalent disassembly:
>

What do you mean by 'non-standard convenience notation'? Which asm
'standard' does Clang actually claim to implement?

This 'GCC/binutils is broken and we are reluctant to subvert Clang'
attitude is getting a bit old tbh. In the future, could you please
mention clang explicitly in the patch subject so it is obvious what
the purpose of the patch is? I think we should accommodate Clang in
Linux, but the attitude has got to go.


> before:
> 00000000000009d4 <neon_aes_ctr_encrypt>:
> ...
>      a48:       9c000ac8        ldr     q8, ba0 <neon_aes_ctr_encrypt+0x1cc>
> ...
>      ba0:       00000001        .word   0x00000001
>      ba4:       00000002        .word   0x00000002
>      ba8:       00000003        .word   0x00000003
>      bac:       00000000        .word   0x00000000
>
> after:
>
> 00000000000009d4 <neon_aes_ctr_encrypt>:
> ...
>      a48:       9c000aa8        ldr     q8, b9c <neon_aes_ctr_encrypt+0x1c8>
> ...
>      b9c:       00000001        .word   0x00000001
>      ba0:       00000002        .word   0x00000002
>      ba4:       00000003        .word   0x00000003
>      ba8:       00000000        .word   0x00000000
>
> [0] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=gas/testsuite/gas/aarch64/programmer-friendly.s;h=6254c6476efdc848648b05068be0574e7addc85d;hb=HEAD#l11
> [1] https://bugs.llvm.org/show_bug.cgi?id=38642
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm64/crypto/aes-modes.S | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
> index 483a7130cf0e..9288c5b0eca2 100644
> --- a/arch/arm64/crypto/aes-modes.S
> +++ b/arch/arm64/crypto/aes-modes.S
> @@ -232,7 +232,7 @@ AES_ENTRY(aes_ctr_encrypt)
>         bmi             .Lctr1x
>         cmn             w6, #4                  /* 32 bit overflow? */
>         bcs             .Lctr1x
> -       ldr             q8, =0x30000000200000001        /* addends 1,2,3[,0] */
> +       ldr             q8, .Laddends /* addends 1,2,3[,0] */
>         dup             v7.4s, w6
>         mov             v0.16b, v4.16b
>         add             v7.4s, v7.4s, v8.4s
> @@ -295,6 +295,12 @@ AES_ENTRY(aes_ctr_encrypt)
>         rev             x7, x7
>         ins             v4.d[0], x7
>         b               .Lctrcarrydone
> +
> +.Laddends:
> +       .word   0x00000001
> +       .word   0x00000002
> +       .word   0x00000003
> +       .word   0x00000000

As Will points out, this breaks BE builds.

>  AES_ENDPROC(aes_ctr_encrypt)
>         .ltorg

You can drop this .ltorg if you get rid of all =xxx instances.

Actually, though, I would prefer it if we could use some clever short
sequence of movi+add instructions, and get rid of the literal
altogether. Or otherwise, please use something like

ldr_l q8, .Laddends, <temp register>

instead, and move the literal into the .rodata section (and use .octa
so you don't break BE)
