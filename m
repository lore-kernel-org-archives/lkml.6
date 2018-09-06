Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6797C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CFE204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2IjubcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CFE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeIFTZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:25:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45015 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbeIFTZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:25:20 -0400
Received: by mail-io0-f195.google.com with SMTP id 75-v6so9019862iou.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dYHrLIXYEvwJh6k/dzs4C6FHlu/62s6QvnnmfaTNGec=;
        b=F2IjubcUuNW3/SY/azM0ImDA0aSiEv4qpIh3ogQtvmObZL3BkkPFFTatjnlDgAlHDI
         LN4Ivt7y+WcEYdhrA/uTrmJa2pW7NRFlG1rNSnpXTX+J1YnJzhBQmahNedBc38hbS60x
         y16wYszPcPEt4hWYvo48O8UpMHG5AzyGRmre8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dYHrLIXYEvwJh6k/dzs4C6FHlu/62s6QvnnmfaTNGec=;
        b=Sd1rWrdHY+edBi31n36oajw8fEsMPFrRJtJUpxqgjkrWn7CUSpnf62Gz82iHSxPlQc
         NWqYG0DzDpZq2TLBdLBKj8xhPTWMcdEpPu+ru0dk0jBrh4MNaaNNrK+i9qqQ+NM6VOyw
         HR0jFkbzI068xcRFmEnKmH8fSQSMYJWLBMrqPovegc5tTGr/cU4ZYysFm+h3hXAzgbnX
         QczG2GsvzaLuRA9ZN9cNA3eoNXn9X7UKD+YsgqQCVOuVzcr4y+o6HWNDwVERWoWsEbkG
         y2+yqdUk80RBhxUHF6sMrucUuP8nGGtd0qKPQJre5To4E2rj3mSPLgJeVj4B8krdhrSJ
         /9bg==
X-Gm-Message-State: APzg51B7lcDiQYw7FfHXvJVL4EJYNsoW5vMES0ZacoE0QyugasKxYWdD
        OxkWNr4qUHc3ouEEDUTPHtnmgFNk1vRHq28Rmiy2JA==
X-Google-Smtp-Source: ANB0VdbDyhjxrw8BYlQDuzT10HZZOqk9BcyMCxgZSdrL67Eoj0ZKOBXyMkhwtYA/ZOyxGzGff8IQNDd4UB26RW6WZVU=
X-Received: by 2002:a6b:ba86:: with SMTP id k128-v6mr2136154iof.170.1536245366680;
 Thu, 06 Sep 2018 07:49:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 07:49:25 -0700 (PDT)
In-Reply-To: <20180906131149.ge2db74nxffs2tbz@gondor.apana.org.au>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
 <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
 <CAOtvUMfu4-DWD4n4c5itjArAYWhGaBnPBEnkh6cbCubG-k9cCA@mail.gmail.com>
 <CAKv+Gu8bKcPksgoryaVjoD9G5KeCYrqWOCgVhqrBqGw5dCzXag@mail.gmail.com>
 <CAKv+Gu-QkCE0pY4+5anEZ0eWv-FTH1QJtOQfPcTVLcvNf7XNiA@mail.gmail.com>
 <20180906085100.xcqqftgqg4sizkec@gondor.apana.org.au> <CAKv+Gu_0ehX9sLCtUYR00D4iQw+ytwmsLKmG6dgq9EnLjidKFw@mail.gmail.com>
 <20180906131149.ge2db74nxffs2tbz@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Sep 2018 16:49:25 +0200
Message-ID: <CAKv+Gu9tSFg9ekEagfn4sPbK-NLYHmmEtij=iMm7szGGQD9B1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
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

On 6 September 2018 at 15:11, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Sep 06, 2018 at 11:29:41AM +0200, Ard Biesheuvel wrote:
>>
>> Perhaps not, but it is not enforced atm.
>>
>> In any case, limiting the reqsize is going to break things, so that
>> needs to occur based on the sync/async nature of the algo. That also
>> means we'll corrupt the stack if we ever end up using
>> SKCIPHER_REQUEST_ON_STACK() with an async algo whose reqsize is
>> greater than the sync reqsize limit, so I do think some additional
>> sanity check is appropriate.
>
> I'd prefer compile-time based checks.  Perhaps we can introduce
> a wrapper around crypto_skcipher, say crypto_skcipher_sync which
> could then be used by SKCIPHER_REQUEST_ON_STACK to ensure that
> only sync algorithms can use this construct.
>

That would require lots of changes in the callers, including ones that
already take care to use sync algos only.

How about we do something like the below instead?

diff --git a/include/crypto/skcipher.h b/include/crypto/skcipher.h
index 2f327f090c3e..ace707d59cd9 100644
--- a/include/crypto/skcipher.h
+++ b/include/crypto/skcipher.h
@@ -19,6 +19,7 @@

 /**
  *     struct skcipher_request - Symmetric key cipher request
+ *     @__onstack: 1 if the request was allocated by SKCIPHER_REQUEST_ON_STACK
  *     @cryptlen: Number of bytes to encrypt or decrypt
  *     @iv: Initialisation Vector
  *     @src: Source SG list
@@ -27,6 +28,7 @@
  *     @__ctx: Start of private context data
  */
 struct skcipher_request {
+       unsigned char __onstack;
        unsigned int cryptlen;

        u8 *iv;
@@ -141,7 +143,7 @@ struct skcipher_alg {

 #define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
        char __##name##_desc[sizeof(struct skcipher_request) + \
-               crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
+               crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR = { 1 }; \
        struct skcipher_request *name = (void *)__##name##_desc

 /**
@@ -437,6 +439,10 @@ static inline int crypto_skcipher_encrypt(struct
skcipher_request *req)
 {
        struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);

+       if (req->__onstack &&
+           (crypto_skcipher_alg(tfm)->base.cra_flags & CRYPTO_ALG_ASYNC))
+               return -EINVAL;
+
        if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
                return -ENOKEY;

@@ -458,6 +464,10 @@ static inline int crypto_skcipher_decrypt(struct
skcipher_request *req)
 {
        struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);

+       if (req->__onstack &&
+           (crypto_skcipher_alg(tfm)->base.cra_flags & CRYPTO_ALG_ASYNC))
+               return -EINVAL;
+
        if (crypto_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
                return -ENOKEY;
