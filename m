Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B03213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyJrIT/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B03213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJIN0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:26:25 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37869 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJIN0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:26:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id o14so434584oth.4;
        Mon, 08 Oct 2018 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=k81Q47zZbuWrkQ6Ct1x5qo+tt0ZSBhaDMK1mvTzU3HQ=;
        b=GyJrIT/5DGlq7oo1bW1Zzyj+ABTtaAv3vCcmNN4SqZUlTsFJDfANP2LlNOdexP9sWF
         8TLTrBLm5xKDjL1aCRGdcEigHT9KNrZRIFLK9rHRAr4HDaHe/rVBMIg2Reo0qT2+Nzmu
         7DpGyD9vkjls4bksI47LPZ+2ipXv64LNUIqucaEgKp9AC3zEOqoMiXD61VFpYHsLBnbw
         Ux+K1nCXbvVZYJTBdXcLSeq/JzaRRGdN9cI6om2qlAF3/0oOP3UIBnWzUciVruAjTRRt
         gR46BF6Z0PREoaNHGSZ06cCD65inxMOjZUyJtFEiCycqf98JyGhEEPhiUSmrbvYJf7d1
         NJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=k81Q47zZbuWrkQ6Ct1x5qo+tt0ZSBhaDMK1mvTzU3HQ=;
        b=LIIyOErO1Ku+TpNEojk3LIUiGd0V71Y2FHPRyCT7ayZ6uwM/jkEEk5DIj7z8PqAbOT
         m+fcgj/aTMBXaMzxKGefxwHMH4/UO9Br86lVH9uxbdxJVFKE69TGWXc2jowhjD2J+YCF
         hT1V/tE/ePwvPLtGk7jbkOdBs+HZOZSY8w7sjly9gbZsTAelm0Ie/G+f4xx65NtzfJxx
         2dNdelYcT6fWP2b3NvgFlhO/0ILgrdUFZSa1ycJMMZb62rsS30GXtgN9gUQpCTfBbNbr
         GBH83iX3tABO3yoExxX5BVmWF/xlxDJzVDowKAwL1b//XCshWGVwdUE3CbARrEl/WKBU
         Jr3w==
X-Gm-Message-State: ABuFfojKPRR/1Sg6KaFpWSrP/WiMxila8VFIGNdKKg22oWrUc20wj4jS
        z8lWYxOhNxOC3IzgDywVhR0PYWIJxGO2LcH0EiQ=
X-Google-Smtp-Source: ACcGV63O93I4bzIBitLgh7ylMhtshDZwQVZuGHtQmH/B7j6pTNt73BCkKDv/vbwHTO4us8o4nLkAMlVT/xuUgWa+MFE=
X-Received: by 2002:a9d:4d0c:: with SMTP id n12mr16617023otf.90.1539065466876;
 Mon, 08 Oct 2018 23:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181008211554.5355-1-ard.biesheuvel@linaro.org>
 <20181008211554.5355-4-ard.biesheuvel@linaro.org> <CAHmME9rDfVbGLpeV9-LDOUo1on2UB7UHd8jBKcWycf9HYkar=g@mail.gmail.com>
 <CAKv+Gu96PKVnymyJyR-9-3HGTryNT=c2kYfXwmHX-QS6DzWf5Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu96PKVnymyJyR-9-3HGTryNT=c2kYfXwmHX-QS6DzWf5Q@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 9 Oct 2018 02:10:37 -0400
Message-ID: <CAH8yC8kqsDAYyTyn3W6oThH5qRX3Qw=2SYr_eA=L03JN0NSBSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] crypto: siphash - drop _aligned variants
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 2:00 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 9 October 2018 at 06:11, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Hi Ard,
> > ...
> > As you might expect, when compiling in __siphash_unaligned and
> > __siphash_aligned on the x86 at the same time, __siphash_unaligned is
> > replaced with just "jmp __siphash_aligned", as gcc recognized that
> > indeed the same code is generated.
> >
> Yeah, I noticed something similar on arm64, although we do get a stack
> frame there.
>
> > However, on platforms where get_unaligned_* does do something
> > different, it looks to me like this patch now always calls the
> > unaligned code, even when the input data _is_ an aligned address
> > already, which is worse behaviour than before. While it would be
> > possible for the get_unaligned_* function headers to also detect this
> > and fallback to the faster version at compile time, by the time
> > get_unaligned_* is used in this patch, it's no longer in the header,
> > but rather in siphash.c, which means the compiler no longer knows that
> > the address is aligned, and so we hit the slow path. This especially
> > impacts architectures like MIPS, for example. This is why the original
> > code, prior to this patch, checks the alignment in the .h and then
> > selects which codepath afterwards. So while this patch might handle
> > the ARM use case, it seems like a regression on all other platforms.
> > See, for example, the struct passing in net/core/secure_seq.c, which
> > sends intentionally aligned and packed structs to siphash, which then
> > benefits from using the faster instructions on certain platforms.
> >
> > It seems like what you're grappling with on the ARM side of things is
> > that CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS only half means what it
> > says on some ISAs, complicating this logic. It seems like the ideal
> > thing to do, given that, would be to just not set
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on those, so that we can fall
> > back to the unaligned path always, like this patch suggests. Or if
> > that's _too_ drastic, perhaps introduce another variable like
> > CONFIG_MOSTLY_EFFICIENT_UNALIGNED_ACCESS.
> >
> Perhaps we should clarify better what
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS means.
>
> One could argue that it means there is no point in reorganizing your
> data to make it appear aligned, because the unaligned accessors are
> cheap. Instead, it is used as a license to cast unaligned pointers to
> any type (which C does not permit btw), even in the example.

I recommend avoiding this strategy. One of the libraries I help with
used a similar strategy and was constantly putting out 1-off fires
when GCC assumed, say, 4- or 8-byte alignments. Integer stuff was
fine. The problems did not surface until vectorization at -O3 when the
misaligned buffers started causing exceptions.

To be clear, there were very few problems. It might surface with GCC
4.9 on ARM in one function; and then surface again with GCC 5.1 on
x86_64 on another function; and then surface again under Cygwin for
another function with GCC 6.3.

The pattern was finally gutted in favor of the classic stuff - treat
the data unaligned an walk the buffer OR'ing in to a datatype. Or,
memcpy it into aligned datatypes. Modern compilers recognize the
pattern and it will be optimized they way you hope.

Older GCC's, like say, GCC 4.3, may not do as well. But it is the
price paid for portability and bug free code. And nowadays those old
GCC's and Clang's are getting more rare. There's no sense in doing
something quickly if you can't arrive at the correct result or you
crash at runtime.

> So in the case of siphash, that would mean always taking the unaligned
> path if CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set, or only for
> unaligned data if it is not.

Jeff
