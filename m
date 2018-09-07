Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C49C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75402077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgoIbdGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75402077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeIGLfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:35:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36432 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIGLfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:35:53 -0400
Received: by mail-it0-f68.google.com with SMTP id u13-v6so18684985iti.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 23:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eFS4GQqJPa1qT2Venr5kQcYubsCfFGmmbwJsG52Mp0o=;
        b=EgoIbdGXmgQv2KZfEyK9v6iErbH/FRj2T2SVQBLAjR76Xh3r2iQrnSMGMAEJpE4EnK
         YvV9jTT14fc78Lv2cvfqtkjXK/82qJR/bLwBrwHh7ynYKEoNIQxbuF0uci7NdzmN6lbc
         DSGySnDBBk66ZG4fBHSblNImOCFJlJgm311xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eFS4GQqJPa1qT2Venr5kQcYubsCfFGmmbwJsG52Mp0o=;
        b=QaF5T79SGOdDvGfAC5oqWacZGNESnRtuR0FpJCj3YQJ2INr2neswhSaku27cgeEJGL
         0LNtrNxgaCUD67OTTkLFtRmxiw/YG/a4amDbKHMh21PNEgFpjNi2lgLmp+2G1m4zzj+8
         OqODePlI2zjBe9GqCs73e7txcZfknch5w0DsWDz3N4CE6ObyxkUPelFLzPosMNz3S8+J
         9zb6ChtcUnMAABTGMvBhcsVuc5+ndlmA7mdp5teeXTQ4gYOtzlySebE4T+YdAvXoLTVP
         kE2muObJnsFDGP6T346aIkAy32dHODRqsrKncusW1ZEyZ/km72+PZmpfivvwkomN1TL9
         bBKw==
X-Gm-Message-State: APzg51Al5bcsjx2i033qwTysdoKbH5wbsEUrxZPULwvXBwzxpkphAKzG
        t+ZxYwZmqEKtw3Cj4rMJsxYtqp5HQHQllDKRq3Eojw==
X-Google-Smtp-Source: ANB0VdZMqidGLpqYV5FMM7hUHIUPQ6aBflVXXXjPPQHD3B6IfyNRtVXdTCmb7TwC8mRDaNImKpU5dPHPcY4hC76dk/Q=
X-Received: by 2002:a24:52cd:: with SMTP id d196-v6mr5565517itb.58.1536303383661;
 Thu, 06 Sep 2018 23:56:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 23:56:23 -0700 (PDT)
In-Reply-To: <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
References: <20180906225854.40989-1-keescook@chromium.org> <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Sep 2018 08:56:23 +0200
Message-ID: <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack requests
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 September 2018 at 05:42, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Sep 06, 2018 at 03:58:52PM -0700, Kees Cook wrote:
>>
>> @@ -437,6 +442,12 @@ static inline struct crypto_skcipher *crypto_skcipher_reqtfm_check(
>>  {
>>       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
>>
>> +     if (req->__onstack) {
>> +             if (WARN_ON(crypto_skcipher_alg(tfm)->base.cra_flags &
>> +                             CRYPTO_ALG_ASYNC))
>> +                     return ERR_PTR(-EINVAL);
>> +     }
>
> Sorry but I don't like imposing a run-time check on everybody when
> stack-based requests are the odd ones out.  If we're going to make
> this a run-time check (I'd much prefer a compile-time check, but I
> understand that this may involve too much churn), then please do it
> for stack-based request users only.
>

OK, so given that all SKCIPHER_REQUEST_ON_STACK occurrences are
updated in this series anyway, perhaps we should add
skcipher_[en|de]crypt_onstack() flavors that encapsulate the
additional check? Only question is how to enforce at compile time that
those are used instead of the ordinary ones when using a stack
allocated request. Would you mind using some macro foo here involving
__builtin_types_compatible_p() ?
