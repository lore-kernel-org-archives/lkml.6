Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730EBC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251FF2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BYXn4QrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251FF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeJEUf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:35:58 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39485 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJEUf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:35:58 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d2f8a01b;
        Fri, 5 Oct 2018 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=0Kq5AE3q2nUGsIwGUcZBMZ664cM=; b=BYXn4Qr
        Ab754itrzm2wYeUg9qCn9cZjunZdHOgUUZnT0iGSYsB2aWqJ+hc1Arr/CMcKUxpw
        Qn11N/vGsJyZAAa7d952BE5JztA4SFpZdUNGD5X1/4vs30IP9/upKJpgQ41htlkC
        4qUQKXDtNxH8QvSLldw3k0gMuXhuCKmH1QkKJNoUuu8DZivWlB98R4AyTniwnRB2
        SOLJ/9WeMO+q0BMFLz96zfwEhM9Ff3ZwEGFhQkuMz352he7J588yuBUgJ/U29iU5
        RRWdnpcL829/SPjhN5kOvoVHpZ57BLtALwUWolNRrQ3r6ijiifQya5NDIaycu1BZ
        QXVSpsZ9Fahjncg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 25245c3f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 5 Oct 2018 13:36:46 +0000 (UTC)
Date:   Fri, 5 Oct 2018 15:37:06 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto
 routines
Message-ID: <20181005133705.GA4588@zx2c4.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Oct 5, 2018 at 10:13 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> At the moment, the Zinc library [1] is being proposed as a solution for that,
> and while it does address the usability problems, it does a lot more than
> that, and what we end up with is a lot less flexible than what we have now.
>
> Currently, arch specific implementations (based on SIMD or optimized
> assembler) live in arch/*/crypto, where each sub-community is in charge
> of its own specialized versions of the various primitives (although still
> under the purview of the crypto maintainer). Any proposal to change this
> model should be judged on its own merit, and not blindly accepted as the
> fallout of cleaning up some library code.
>
> Also, Zinc removes the possibility to plug different versions of a routine,
> and instead, keeps all versions in the same module. Currently, the kernel's
> module support permits user land to take charge of the policies that decide
> which version to use in which context (by loading or blacklisting modules).

I think this explanation misunderstands many of the design goals of Zinc and
also points to why going your direction instead is a bad idea that will cause
even more problems down the road.

Zinc does several important things:

- Introduces direct C function calls throughout, as a central way of being
  implemented and as a central way of being used by consumers of the
  API. This has various obvious benefits for the consumers of the API,
  but it also has big benefits for the developers of the library as
  well. Namely, it keeps the relationship between different parts
  extremely clear and direct. It's an explicit choice for simplicity.
  And by being the simpler and more direct solution, it also gives gcc
  an important opportunity to optimize and inline.

- Reorganizes crypto routines so that they're grouped together by
  primitive. This again leads to a much simpler design and layout,
  making it more obvious what's happening, and making things generally
  cleaner. It is not only useful and clearer for developers, but it
  also makes contributors and auditors more easily aware of what
  implementations are available.

- Has higher standards for code and implementations that are introduced.
  Zinc prefers code that has been formally verified, that has been in
  widespread usage and has received many eyeballs and fuzzing hours,
  that has been fuzzed extensively, that is simple in design, that comes
  from well-known high-quality authors -- in roughly but not precisely
  that order of preference. That's a bit different from the current
  practices of the existing crypto API.

- Has a simpler mechanism that is just as effective for choosing
  available implementations. This is, again, more obvious and direct
  than the present crypto API's module approach, leads to smaller code
  size, and has the potential of being just as flexible with the
  inevitable desire for nobs, adjustable from userspace, from
  kernelspace, or from elsewhere.

- Is designed to promote collaboration with the larger cryptography
  community and with academia, which will yield better implementations
  and for assurance.

- Can easily be extracted to userspace libraries (perhaps a future
  libzinc could be easily based on it), which makes testing and fuzzing
  using tools like libfuzzer and afl more accessible.

- Has faster implementations than the current crypto API.

- Has, again, a very strong focus on being simple and minimal, as
  opposed to bloated and complicated, so that it's actually possible to
  understand and audit the library.

Therefore, I think this patch goes in exactly the wrong direction. I
mean, if you want to introduce dynamic patching as a means for making
the crypto API's dynamic dispatch stuff not as slow in a post-spectre
world, sure, go for it; that may very well be a good idea. But
presenting it as an alternative to Zinc very widely misses the point and
serves to prolong a series of bad design choices, which are now able to
be rectified by putting energy into Zinc instead.

Jason
