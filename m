Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D9C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3D12174E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+2BJRF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3D12174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeHUCBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:01:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45128 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:01:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so7798006pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GJL91cuhhsld7JKfmdoK4UQDVqSSroKG3EaMH1ULjY=;
        b=g+2BJRF5Vwlwhtmngf64CIW5NwNs8NPdLeMg7LvI3IptnVCkvtWDhH1PWwGaJAYrqh
         t2aOMPnKxQlwo2Zralo1vRyVQ37czAuaqGa9t2wltivYVrGy9Y9A3w1bsIDVsGr40SL6
         hEpgfu1ooQk/ze9D02grcQHeCJWd32XqFx1OlTaogPqWrroJ+cmfwheeYgoJ7C5Lr4Wb
         ADuQooQ83C/Dqcoi7Y7c7BDY9OWAkVPsXDXaK14vhaq+Qk6RO+D1D5fyNgR+bIy1CGjZ
         uYXnwP0C2auvuurBbbkcCnhaq45dSXjpnTcAUBRrHf22psKndDcej5lBejHN8eWEkRef
         91ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GJL91cuhhsld7JKfmdoK4UQDVqSSroKG3EaMH1ULjY=;
        b=I9gJLjgqfWWPsjTWJGamMI6A9orkOM71Mr8hcaIcTR6czVzegCf37nJ5ahY0q/xlbW
         ohyMTuULKsagBmSurTV7+NxoEJ5We3GJmrX5WhOlqX8wiM3cazcwzCb9ovcgkaPnsOnV
         fZzf2KJIgLwpQCaz9FRUqaowEGoK4IGNrIp+K7jMjUHNR49Hh/uV0RyAKblZoe0+Z/JL
         AZpyLN3UvAjglUidW3S3BKPdHqQ4S5wVxyL7F72UG33Or4ZOooCgc+6wSJruI5QMlCh2
         ciTqrjS+BVTcK1p0/8Mjy8TGlGK1ckOFpXbT/KUFWvWa1s34lf3QLY/2d8DlH3PD18nU
         JykA==
X-Gm-Message-State: AOUpUlGNfwMCGC7YHQ+MXPFbzlha9HnPu50ccx6pqASCvTMjB5ihdPLy
        Bijz7FLrTQoBQJ/Ca8Y5PZ6pQK5GXTjsf++kU/FZUw==
X-Google-Smtp-Source: AA+uWPwyQZI2S7r/5pjTR3QOj1S3sGvtX1d+TbP5Om9QEfra0Hh1A3MBDzvpv3UJzHN0ojOitIBDDLGuogQvyLKrON0=
X-Received: by 2002:a17:902:d70d:: with SMTP id w13-v6mr47514189ply.229.1534805023781;
 Mon, 20 Aug 2018 15:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180820224032.53194-1-ndesaulniers@google.com>
In-Reply-To: <20180820224032.53194-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 20 Aug 2018 15:43:32 -0700
Message-ID: <CAKwvOdm9ZabUHY0w0mT52nZQNZqfhk1EyQHXo27uO816TyU0eg@mail.gmail.com>
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

On Mon, Aug 20, 2018 at 3:41 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
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
>  AES_ENDPROC(aes_ctr_encrypt)
>         .ltorg
>
> --
> 2.18.0.865.gffc8e1a3cd6-goog
>

I can't spell. s/convience/convenience/g

-- 
Thanks,
~Nick Desaulniers
