Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B0BFC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FCC2175A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YaCJd9EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FCC2175A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeIMWD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:03:27 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33045 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeIMWD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:03:27 -0400
Received: by mail-yw1-f66.google.com with SMTP id x67-v6so1449255ywg.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FY+UoFrJR9cRsu/JDk6NRVL3M6Woe/SVsqw1T88P/5Q=;
        b=YaCJd9EL3b84xwpw3Yj/a7TmxrWDfIJP4YnHpP1wGB1QMtS1KLiQYWhFonMNarOl64
         vGWAO2tTCGEwcJf+KwTUFMY65YXy0tR69ZMbPPd7EBkg/mriNA+RpUAGReSvCS7ax9Nn
         PZSJaNXQsYvMUKiSP5t1gWa/+j9dRdb2y0r0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FY+UoFrJR9cRsu/JDk6NRVL3M6Woe/SVsqw1T88P/5Q=;
        b=a2/m2mE13p4QZYHBViHrsiGpPWsuVJAu87f1LgB0XxFOmsp4TfL8HvWjHSncHzxlIN
         Ajxyls7IgpjzZd8mVjRcNdEjC7YGfFsVTEYLduST7MjpyEQElNW7vZIfFpA7wTuT8/SZ
         /OvwfaezUzDarBhfF04n8E7aehePg7CRxL1c92LOxh1D+8M1k+gm5aMAYrRZIG65csK1
         qDIN48JdAs8ZXk+tVo5ZGxticZYCmTZ/9JdSnNGvmoCekYxlBCiAUqcpIcfQr7vrLZxZ
         wLN2TAcpA7maFXtit28mD+IJW7upO7TaL5fJ5EKWqZiWGhnz1LZn2/syPSFzI6JJCNXE
         I3zQ==
X-Gm-Message-State: APzg51Axrar/9KuFH/9lDNy/dSjaleCAZ7pqwD3cT82Zyd08E3ulmF2Y
        gmMOouxB616T+v8lUTzyzxzW7Lp7ZbI=
X-Google-Smtp-Source: ANB0VdYER4R2v1B0OvfxnF6EwAtmEQuixZjXXOm8dNfQglec8RLQ8ofR4r+VR95Mf6qCe8TmhOHGPg==
X-Received: by 2002:a81:4418:: with SMTP id r24-v6mr3985686ywa.407.1536857586554;
        Thu, 13 Sep 2018 09:53:06 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id d10-v6sm4027307ywh.87.2018.09.13.09.53.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 09:53:06 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id z143-v6so1444378ywa.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:53:06 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr3858188ywg.47.1536857178403;
 Thu, 13 Sep 2018 09:46:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 09:46:17
 -0700 (PDT)
In-Reply-To: <20180911055230.iiiq2uu5gczlwjon@gondor.apana.org.au>
References: <20180906225854.40989-1-keescook@chromium.org> <20180906225854.40989-3-keescook@chromium.org>
 <20180907034242.zhm4dglzkldhvh3x@gondor.apana.org.au> <CAKv+Gu9kHpBTKjQKA3W4Q424FeY+Zq4srq2-r0MxjfCNKHT_5A@mail.gmail.com>
 <20180911055230.iiiq2uu5gczlwjon@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 09:46:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+ti_nzxeu64e-X+igNEsnXiW1rjkn7R63DMBCxBOeTNg@mail.gmail.com>
Message-ID: <CAGXu5j+ti_nzxeu64e-X+igNEsnXiW1rjkn7R63DMBCxBOeTNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] crypto: skcipher - Enforce non-ASYNC for on-stack requests
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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

On Mon, Sep 10, 2018 at 10:52 PM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> On Fri, Sep 07, 2018 at 08:56:23AM +0200, Ard Biesheuvel wrote:
>>
>> OK, so given that all SKCIPHER_REQUEST_ON_STACK occurrences are
>> updated in this series anyway, perhaps we should add
>> skcipher_[en|de]crypt_onstack() flavors that encapsulate the
>> additional check? Only question is how to enforce at compile time that
>> those are used instead of the ordinary ones when using a stack
>> allocated request. Would you mind using some macro foo here involving
>> __builtin_types_compatible_p() ?
>
> Something like a completely new type which in reality is just a
> wrapper around skcipher:
>
>         struct crypto_sync_skcipher {
>                 struct crypto_skcipher base;
>         } tfm;
>
>         tfm = crypto_alloc_sync_skcipher(...);
>
>         crypto_sync_skcipher_encrypt(...)
>         crypto_sync_skcipher_decrypt(...)
>
> These functions would just be trivial inline functions around their
> crypto_skcipher counterparts.

This means new wrappers for the other helpers too, yes? For example:

        SKCIPHER_REQUEST_ON_STACK(nreq, ctx->null);

        skcipher_request_set_tfm(nreq, ctx->null);
        skcipher_request_set_callback(nreq, req->base.flags, NULL, NULL);
        skcipher_request_set_crypt(nreq, req->src, req->dst, nbytes, NULL);

        return crypto_skcipher_encrypt(nreq);

For the above, we'd also need:

sync_skcipher_request_set_tfm()
sync_skcipher_request_set_callback()
sync_skcipher_request_set_crypt()

-Kees

-- 
Kees Cook
Pixel Security
