Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC9C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69CA21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLGX5agY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfAXIut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:50:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33858 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfAXIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:50:48 -0500
Received: by mail-io1-f68.google.com with SMTP id b16so4075843ior.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 00:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeBjmcEQcLSRm+PBEl/b4/noK4xPD3Qj1B0PIa4vfWw=;
        b=aLGX5agYRusyXEk6oDb8v/KMpTJhNpQXOZdc02EHn46194vIu0rsW+SkgjXxmulSFN
         zfnsy5PgHHF4EhpMYtSCRFuDkwmGvJ9Nlt1Zl6Y6qDVFx6K91ilKvxxA1GlI2Bt/oJJ4
         Ojo7PIN4Hc6v7bAqwjqNe2FONEyo3G5JNAN9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeBjmcEQcLSRm+PBEl/b4/noK4xPD3Qj1B0PIa4vfWw=;
        b=HHbVjJcpllDOYJYQOnMAdKDm6jWNic3TFtbBhiIUGfSnIzbfj2UTQP+1jlHbA1rhNO
         CsdvsYE78UH/ZI/fyk3hrXsEa4MRJoTWJoKuifPJfBvkdDC+71Xwe1IiGgHRvOR71gcx
         GSIm3mMEzDYwNaJmzNGiEe7lSDx0g/yEVAscM4Ow0XC3HbojWXBUzpmSaD9W47ND7Dev
         +XY3/hPgkFpBxQQ2HmHkyjXqI5eq7aEOCNJSvUeGjsXAOxUoKlVDHzgume28ghhqPVBg
         f/Dip547q7KuQwArwDB9L9R4fPdDkHJy+7lpYaAnfyeZYAzk5P4Olv7hCnGR4jAN/iQH
         gLbg==
X-Gm-Message-State: AHQUAubJhf735V3ZCiLTxBuHBitgjzjgJ4ZvqDeTOTU9dOkICdlAVa9R
        NxyHzTfuA3HyQ9dxqB8ZayDlrFQ784hI+r0pEWcupYYnky4=
X-Google-Smtp-Source: ALg8bN53u6JaGzEOl5DIGobjtWg+aJbxpqgzkNvXJs4ZEwGbUsUCbrkSg7CHAcxBwQ8gTKri6utx7aCaMf8xP5Ipzfg=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr3303666ion.173.1548319847341;
 Thu, 24 Jan 2019 00:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20190123224926.250525-1-ebiggers@kernel.org> <20190124084818.GA650@sol.localdomain>
In-Reply-To: <20190124084818.GA650@sol.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 24 Jan 2019 09:50:35 +0100
Message-ID: <CAKv+Gu9zridWAYO3cR_KAAbupWfLd+FAMmcgAMuYE5Lgxoek-w@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 00/15] crypto: improved skcipher, aead, and hash tests
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 09:48, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jan 23, 2019 at 02:49:11PM -0800, Eric Biggers wrote:
> > Hello,
> >
> > Crypto algorithms must produce the same output for the same input
> > regardless of data layout, i.e. how the src and dst scatterlists are
> > divided into chunks and how each chunk is aligned.  Request flags such
> > as CRYPTO_TFM_REQ_MAY_SLEEP must not affect the result either.
> >
> > However, testing of this currently has many gaps.  For example,
> > individual algorithms are responsible for providing their own chunked
> > test vectors.  But many don't bother to do this or test only one or two
> > cases, providing poor test coverage.  Also, other things such as
> > misaligned IVs and CRYPTO_TFM_REQ_MAY_SLEEP are never tested at all.
> >
> > Test code is also duplicated between the chunked and non-chunked cases,
> > making it difficult to make other improvements.
> >
> > To improve the situation, this patch series basically moves the chunk
> > descriptions into the testmgr itself so that they are shared by all
> > algorithms.  However, it's done in an extensible way via a new struct
> > 'testvec_config', which describes not just the scaled chunk lengths but
> > also all other aspects of the crypto operation besides the data itself
> > such as the buffer alignments, the request flags, whether the operation
> > is in-place or not, the IV alignment, and for hash algorithms when to do
> > each update() and when to use finup() vs. final() vs. digest().
> >
> > Then, this patch series makes skcipher, aead, and hash algorithms be
> > tested against a list of default testvec_configs, replacing the current
> > test code.  This improves overall test coverage, without reducing test
> > performance too much.  Note that the test vectors themselves are not
> > changed, except for removing the chunk lists.
> >
> > This series also adds randomized fuzz tests, enabled by a new kconfig
> > option intended for developer use only, where skcipher, aead, and hash
> > algorithms are tested against many randomly generated testvec_configs.
> > This provides much more comprehensive test coverage.
> >
> > These improved tests have already found many bugs.  Patches 1-7 fix the
> > bugs found so far (*).  However, I've only tested implementations that I
> > can easily test.  There will be more bugs found, especially in
> > hardware-specific drivers.  Anyone reading this can help by applying
> > these patches on your system (especially if it's non-x86 and/or has
> > crypto accelerators), enabling CONFIG_CRYPTO_MANAGER_EXTRA_TESTS, and
> > reporting or fixing any test failures.
>
> On an arm64 system with the crypto extensions, crct10dif-arm64-ce and ccm-aes-ce
> are failing too:
>
> [    1.632623] alg: hash: crct10dif-arm64-ce test failed (wrong result) on test vector 0, cfg="init+update+update+final two even splits"
> [   15.377921] alg: aead: ccm-aes-ce decryption failed with err -74 on test vector 11, cfg="uneven misaligned splits, may sleep"
>
> Ard, I'll fix these when I have time but feel free to get to them first.
>

Hi Eric,

Thanks for yet another round of cleanup

I'll look into these, but I'd like to clarify one thing first.

IIUC, you are trying to deal with the case where a single scatterlist
element describes a range that strides two pages, and I wonder if that
is a valid use of scatterlists in the first place.

Herbert?
