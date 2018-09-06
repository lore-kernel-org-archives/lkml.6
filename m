Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC27C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E193E2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="qPbeFSR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E193E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIFJ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 05:27:34 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36237 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeIFJ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 05:27:34 -0400
Received: by mail-vk0-f65.google.com with SMTP id i2-v6so3576709vkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 21:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SkjJnsYcW/ACXPWFnlgDasIey/6IPr48+FnF2onKr24=;
        b=qPbeFSR9diJxelyfBzSCYN9AZj+idKmKBR5wXX72Mv4reB0rtp9CktKdmfpj+XWK5Z
         bjeKo2fwT8eNcf7Yoci6tDHCllZNJuua+Mx6btFUR9DaF1+r9lquAoLai5jTwIwLPgy+
         LVPyFmIG4Pq4/KPFJMWQpSOr1SeKcfB0qi2CDSjhPagoFG0GxuRaTZ1uvXWHgQt2hBNf
         XD4/RMZkUuXmLwab3TSffIU36GGL1Avld/nc5tpcHeQfCv4DnFye4x2DMPyguQdUDw5d
         EqtU7mbJk5OY/qMQ54RjamFIuuxv/zWdaLi9OM/EIgMj6DwrFjnIKP1g9crvgyGnvyQj
         WjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SkjJnsYcW/ACXPWFnlgDasIey/6IPr48+FnF2onKr24=;
        b=aX8K+SISgJUH3hrEB+Geagigr9giijxrFx+KDz9/Uaq1XkFpyHlAw8TMx806+I7v77
         y7y2dJnOoYvQ+z3D5IwkmeZ6Gb/c5ppV+rhiBPwllaNMQgOkP/rNxDBq1YtkWJsfPRpR
         ocBhGmB5watqrXfHfxQqdKK+kGXT5M1WJMTCWkEUdm9KXffoh3RdYS3y9WXtc/DtceKO
         OiVfuMHQc4prNQ1MD1Pxc7QRniGbKymGttCWaSiZmaEUsyZYrxFBZ6BgtxklsjYeaqxR
         rLSIk/5C5Zo6fXciHdvj8ua5goBxH3fJBky4qLjJZU97E98Vaf/a8ZPFK2Mzmstnr+/i
         c0wg==
X-Gm-Message-State: APzg51DmQc6Re8iy572LN2gzWSdkqg3JjmlJMuydzbxaCeEMBMvklZ/f
        DpTu+sKvvDcx5CPxpLx6BNrNzPx4J9KgJXdRklEZXA==
X-Google-Smtp-Source: ANB0Vdbgo3NdtLTOKQxPMo3FEQcl8rqtFUQRgo1VvK4pZaT9BEELUbxAdU96cmIlvOM+JyG6SomKPDzows/0Rex10B8=
X-Received: by 2002:a1f:170d:: with SMTP id 13-v6mr298057vkx.90.1536209638441;
 Wed, 05 Sep 2018 21:53:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:464:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 21:53:58 -0700 (PDT)
X-Originating-IP: [217.140.106.29]
In-Reply-To: <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com> <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 6 Sep 2018 07:53:58 +0300
Message-ID: <CAOtvUMfu4-DWD4n4c5itjArAYWhGaBnPBEnkh6cbCubG-k9cCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 1:49 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 5 September 2018 at 23:05, Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Sep 5, 2018 at 2:18 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 4 September 2018 at 20:16, Kees Cook <keescook@chromium.org> wrote:
>>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>>> caps the skcipher request size similar to other limits and adds a sani=
ty
>>>> check at registration. Looking at instrumented tcrypt output, the larg=
est
>>>> is for lrw:
>>>>
>>>>         crypt: testing lrw(aes)
>>>>         crypto_skcipher_set_reqsize: 8
>>>>         crypto_skcipher_set_reqsize: 88
>>>>         crypto_skcipher_set_reqsize: 472
>>>>
>>>
>>> Are you sure this is a representative sampling? I haven't double
>>> checked myself, but we have plenty of drivers for peripherals in
>>> drivers/crypto that implement block ciphers, and they would not turn
>>> up in tcrypt unless you are running on a platform that provides the
>>> hardware in question.
>>
>> Hrm, excellent point. Looking at this again:
>>
>> The core part of the VLA is using this in the ON_STACK macro:
>>
>> static inline unsigned int crypto_skcipher_reqsize(struct crypto_skciphe=
r *tfm)
>> {
>>         return tfm->reqsize;
>> }
>>
>> I don't find any struct crypto_skcipher .reqsize static initializers,
>> and the initial reqsize is here:
>>
>> static int crypto_init_skcipher_ops_ablkcipher(struct crypto_tfm *tfm)
>> {
>> ...
>>         skcipher->reqsize =3D crypto_ablkcipher_reqsize(ablkcipher) +
>>                             sizeof(struct ablkcipher_request);
>>
>> with updates via crypto_skcipher_set_reqsize().
>>
>> So I have to examine ablkcipher reqsize too:
>>
>> static inline unsigned int crypto_ablkcipher_reqsize(
>>         struct crypto_ablkcipher *tfm)
>> {
>>         return crypto_ablkcipher_crt(tfm)->reqsize;
>> }
>>
>> And of the crt_ablkcipher.reqsize assignments/initializers, I found:
>>
>> ablkcipher reqsize:
>> 1       struct dcp_aes_req_ctx
>> 8       struct atmel_tdes_reqctx
>> 8       struct cryptd_blkcipher_request_ctx
>> 8       struct mtk_aes_reqctx
>> 8       struct omap_des_reqctx
>> 8       struct s5p_aes_reqctx
>> 8       struct sahara_aes_reqctx
>> 8       struct stm32_cryp_reqctx
>> 8       struct stm32_cryp_reqctx
>> 16      struct ablk_ctx
>> 24      struct atmel_aes_reqctx
>> 48      struct omap_aes_reqctx
>> 48      struct omap_aes_reqctx
>> 48      struct qat_crypto_request
>> 56      struct artpec6_crypto_request_context
>> 64      struct chcr_blkcipher_req_ctx
>> 80      struct spacc_req
>> 80      struct virtio_crypto_sym_request
>> 136     struct qce_cipher_reqctx
>> 168     struct n2_request_context
>> 328     struct ccp_des3_req_ctx
>> 400     struct ccp_aes_req_ctx
>> 536     struct hifn_request_context
>> 992     struct cvm_req_ctx
>> 2456    struct iproc_reqctx_s
>>
>> The base ablkcipher wrapper is:
>> 80      struct ablkcipher_request
>>
>> And in my earlier skcipher wrapper analysis, lrw was the largest
>> skcipher wrapper:
>> 384     struct rctx
>>
>> iproc_reqctx_s is an extreme outlier, with cvm_req_ctx at a bit less tha=
n half.
>>
>> Making this a 2920 byte fixed array doesn't seem sensible at all
>> (though that's what's already possible to use with existing
>> SKCIPHER_REQUEST_ON_STACK users).
>>
>> What's the right path forward here?
>>
>
> The skcipher implementations based on crypto IP blocks are typically
> asynchronous, and I wouldn't be surprised if a fair number of
> SKCIPHER_REQUEST_ON_STACK() users are limited to synchronous
> skciphers.

According to Herbert, SKCIPHER_REQUEST_ON_STACK() may only be used
for invoking synchronous ciphers.

In fact, due to the way the crypto API is built, if you try using it
with any transformation that uses DMA
you would most probably end up trying to DMA to/from the stack which
as we all know is not a great idea.

>
> So we could formalize this and limit SKCIPHER_REQUEST_ON_STACK() to
> synchronous skciphers, which implies that the reqsize limit only has
> to apply synchronous skciphers as well. But before we can do this, we
> have to identify the remaining occurrences that allow asynchronous
> skciphers to be used, and replace them with heap allocations.

Any such occurrences are almost for sure broken already due to the DMA
issue I've mentioned.

Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
