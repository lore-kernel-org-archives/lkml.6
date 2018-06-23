Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CFAC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D7024CB3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5N2zOZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D7024CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeFWRaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 13:30:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42855 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeFWRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 13:30:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id k20-v6so1445681ljk.9;
        Sat, 23 Jun 2018 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ytnvNFnQdZ7piY+8IgyTs84JBtK5dSilFiaGizyAWM=;
        b=K5N2zOZLVdu791Y7tCa5EXmGYI3yM99EYoLW0dAkbwd5Pch9oXczMadNvjCFowyXls
         XFeVZYahwoOdV0KZAlf6y7eh3P25PDq0m6TqS9jslLPNVlQqy7ZjQGc3o8rMlaVbFdjM
         4W3LdnM0jSgT9ymwhZc9F/Xb57pVAidS7qkvxHtKd4y2p7VW0y/ERDyXwpSOxREv1OGi
         bq3gPAP12c6VWN/CUduqivnPcpVMpxGjb/poisN3zqp7O57MZozP8F741gNkv6UwYQOW
         svCImBcZBwoOL6lb4LJ5OAEZ3bDFkAkNzce33l/6RoaAd5AILrrfCUylvTDnfnbPvcD3
         d+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ytnvNFnQdZ7piY+8IgyTs84JBtK5dSilFiaGizyAWM=;
        b=ZHryQcrjoC4Hq1P1RSAwteQ74aMnKfhv5qK6n+eOIrhlZV2LFwMLb1Fr3GEDJLqi9D
         svO8RgmBhIG/Q//tuLQNZG8tcBE0KNpfHrPDpa186OE4H8sOK9xKljrkyj8L2W+Taaex
         sOZJpHRGCcJgn+ot8imthfiAxjUy44X1mpvJnhP+Kg87cV87X28vyIZaeUgUvzUXNt6n
         H8qvguk0Iqs9Ej41Bwnbq81pj+c6KUGXaglIjjMRA6urzs4uYmImtzPXtwuexcsw3MP+
         uePiNco4KDEebLsr6oC+q89v1+BdD3gaCHvVO9PeVW2ZPeBIUqips22P2vT993iuS0Ps
         5W0A==
X-Gm-Message-State: APt69E3iAbFUsVGdKasSVDFzRIP3XSfzA1yKONUblKUOCY96DYHSyOyt
        eS1rnbyV8+CUtEsJFc/enrQwF4OBZMJujIq8zIE=
X-Google-Smtp-Source: ADUXVKJnjk8kq+rsKLJkARFuHx/+0x81/utvhuEzMKpwGN6U3siIi+wX5aAqlv4S+SKZEb1D/i74wDHLOiDJ9NLrraA=
X-Received: by 2002:a2e:905a:: with SMTP id n26-v6mr3718493ljg.33.1529775042408;
 Sat, 23 Jun 2018 10:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180507213755.GA32406@avx2> <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
 <1529235613.4572.7.camel@gmx.de> <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de> <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic> <1529289279.31745.3.camel@gmx.de> <20180623103622.GA2760@zn.tnic>
In-Reply-To: <20180623103622.GA2760@zn.tnic>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= 
        <omosnacek+linux-crypto@gmail.com>
Date:   Sat, 23 Jun 2018 19:30:30 +0200
Message-ID: <CAAUqJDvKG6T3y=Cf8B7cThmkgvjZxWYbDqVV=EA4GS5TfjBCeQ@mail.gmail.com>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
To:     bp@alien8.de
Cc:     linux-crypto@vger.kernel.org, efault@gmx.de, adobriyan@gmail.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org,
        peterz@infradead.org, brgerst@gmail.com, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so 23. 6. 2018 o 12:36 Borislav Petkov <bp@alien8.de> nap=C3=ADsal(a):
>
> Lemme send a proper patch now...
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Sun, 17 Jun 2018 13:57:42 +0200
> Subject: [PATCH] x86/crypto: Add missing RETs
>
> Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithms
> otherwise they run into INT3 padding due to
>
>   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
>
> leading to spurious debug exceptions.
>
> Mike Galbraith <efault@gmx.de> took care of all the remaining callsites.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Oh, thanks for fixing that!

Acked-by: Ondrej Mosnacek <omosnacek@gmail.com>

Cheers,
Ondrej

> ---
>  arch/x86/crypto/aegis128-aesni-asm.S  | 1 +
>  arch/x86/crypto/aegis128l-aesni-asm.S | 1 +
>  arch/x86/crypto/aegis256-aesni-asm.S  | 1 +
>  arch/x86/crypto/morus1280-avx2-asm.S  | 1 +
>  arch/x86/crypto/morus1280-sse2-asm.S  | 1 +
>  arch/x86/crypto/morus640-sse2-asm.S   | 1 +
>  6 files changed, 6 insertions(+)
>
> diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis=
128-aesni-asm.S
> index 9254e0b6cc06..717bf0776421 100644
> --- a/arch/x86/crypto/aegis128-aesni-asm.S
> +++ b/arch/x86/crypto/aegis128-aesni-asm.S
> @@ -535,6 +535,7 @@ ENTRY(crypto_aegis128_aesni_enc_tail)
>         movdqu STATE3, 0x40(STATEP)
>
>         FRAME_END
> +       ret
>  ENDPROC(crypto_aegis128_aesni_enc_tail)
>
>  .macro decrypt_block a s0 s1 s2 s3 s4 i
> diff --git a/arch/x86/crypto/aegis128l-aesni-asm.S b/arch/x86/crypto/aegi=
s128l-aesni-asm.S
> index 9263c344f2c7..4eda2b8db9e1 100644
> --- a/arch/x86/crypto/aegis128l-aesni-asm.S
> +++ b/arch/x86/crypto/aegis128l-aesni-asm.S
> @@ -645,6 +645,7 @@ ENTRY(crypto_aegis128l_aesni_enc_tail)
>         state_store0
>
>         FRAME_END
> +       ret
>  ENDPROC(crypto_aegis128l_aesni_enc_tail)
>
>  /*
> diff --git a/arch/x86/crypto/aegis256-aesni-asm.S b/arch/x86/crypto/aegis=
256-aesni-asm.S
> index 1d977d515bf9..32aae8397268 100644
> --- a/arch/x86/crypto/aegis256-aesni-asm.S
> +++ b/arch/x86/crypto/aegis256-aesni-asm.S
> @@ -543,6 +543,7 @@ ENTRY(crypto_aegis256_aesni_enc_tail)
>         state_store0
>
>         FRAME_END
> +       ret
>  ENDPROC(crypto_aegis256_aesni_enc_tail)
>
>  /*
> diff --git a/arch/x86/crypto/morus1280-avx2-asm.S b/arch/x86/crypto/morus=
1280-avx2-asm.S
> index 37d422e77931..07653d4582a6 100644
> --- a/arch/x86/crypto/morus1280-avx2-asm.S
> +++ b/arch/x86/crypto/morus1280-avx2-asm.S
> @@ -453,6 +453,7 @@ ENTRY(crypto_morus1280_avx2_enc_tail)
>         vmovdqu STATE4, (4 * 32)(%rdi)
>
>         FRAME_END
> +       ret
>  ENDPROC(crypto_morus1280_avx2_enc_tail)
>
>  /*
> diff --git a/arch/x86/crypto/morus1280-sse2-asm.S b/arch/x86/crypto/morus=
1280-sse2-asm.S
> index 1fe637c7be9d..bd1aa1b60869 100644
> --- a/arch/x86/crypto/morus1280-sse2-asm.S
> +++ b/arch/x86/crypto/morus1280-sse2-asm.S
> @@ -652,6 +652,7 @@ ENTRY(crypto_morus1280_sse2_enc_tail)
>         movdqu STATE4_HI, (9 * 16)(%rdi)
>
>         FRAME_END
> +       ret
>  ENDPROC(crypto_morus1280_sse2_enc_tail)
>
>  /*
> diff --git a/arch/x86/crypto/morus640-sse2-asm.S b/arch/x86/crypto/morus6=
40-sse2-asm.S
> index 71c72a0a0862..efa02816d921 100644
> --- a/arch/x86/crypto/morus640-sse2-asm.S
> +++ b/arch/x86/crypto/morus640-sse2-asm.S
> @@ -437,6 +437,7 @@ ENTRY(crypto_morus640_sse2_enc_tail)
>         movdqu STATE4, (4 * 16)(%rdi)
>
>         FRAME_END
> +       ret
>  ENDPROC(crypto_morus640_sse2_enc_tail)
>
>  /*
> --
> 2.17.0.582.gccdcbd54c
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
