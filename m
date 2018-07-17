Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B694ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BAE20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nEuJUL5P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+ONVPxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BAE20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbeGQUmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:42:05 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44783 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbeGQUmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:42:05 -0400
Received: by mail-yw0-f193.google.com with SMTP id k18-v6so856127ywm.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X6lBtrCenNy5Dza3t5CsfoNuyhb8zfp/3gAtHtGNTdg=;
        b=nEuJUL5PnA7FE3/SJ/EStfcNrdnqj8tibArIiL7pXa2AIStwrqqJLAHLkwoyOjB4cC
         x7395gyM0CxrLxc97YAqYbOAzcAPJeAoc98ZEta1mP0Jhy1vkBrZaXVhoGUSxOsOL6yv
         ory6DB3OSMqp+qM2SzGy7elcCMBYvAD0B1SrQ5H5+d8uX4Eb0lOO731tTS4gIK6ccCMo
         M6L6VcIgkFeaPyLTbjmEXszRVl2iccBI78zROBGKZ+G5oL6LBj5j7JjfhmsreXFWwqxU
         jpHvDdYoYC8z7YLGk4sroFHLFe5DKizv/pzISkzwtis4j23KpObIK5A0WBhrVvPpPBNj
         tk3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X6lBtrCenNy5Dza3t5CsfoNuyhb8zfp/3gAtHtGNTdg=;
        b=N+ONVPxRbJHbuAtz5TgQ/IkDDRkwiN33SDm+/s+UHDufl4sAaniZphQ/JtAcnRueJp
         Xqh1AHL722WhHAyuuY2u9/0zOtriZZ5OFEDfL6TpG9OifmgmeYgQibYeYuutkOXiRgQR
         gRvqe2RRBDpUQI7jU8EybtjzCGD3XRyCX7fVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=X6lBtrCenNy5Dza3t5CsfoNuyhb8zfp/3gAtHtGNTdg=;
        b=VMl+JvnHqlOk5Gp7PI9VfHpdAHaEDv5up0BK0ijV+ABHfbSrUwNtM0DUFvkHewr9tc
         imNKXUsxKnSV+CtJHUm/7QdtiI3eATQzJnEpQe+JER3a9Yr5wRIQiT/I/pMOpN+0+FX2
         fpWwlJbeRAGCI2TG6S2FwpzmHGSCMMqnRBdxn5mhTDcxipdR5WL1fLrw5mFBLSQ1v2Ih
         B460v06mxPsq5KFNa1To1BQAhipqTcKBO5pttU1NlL14sDl5IkwX4UQEYgM5wDmV1K6A
         x7aI/QWnJV4VjW4plVy/0kdjqFabMuXG7dIKwCvkTXR/Rqi7W2SylJ5ag4vRxLUF+wMi
         rDTw==
X-Gm-Message-State: AOUpUlFmz4WD7To9x1ZFCnk1J6vEAmISKFLD+rzgkdvmfVjUWy0/YXai
        iW3I4C+ilUHmEb+uy1d3AYC47qw6TJYQEkkOWZRgMQ==
X-Google-Smtp-Source: AAOMgpeLfANoUOz2lJyua63U9w5itWYNb7o8KE0h0gvvjQsk5X0T4ADvf7ng/vcVAjHUJZOcNgG2WP2ZtCdHDr7P3Bw=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr1596783ywn.88.1531858070714;
 Tue, 17 Jul 2018 13:07:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:07:50
 -0700 (PDT)
In-Reply-To: <20180717163936.GB75957@gmail.com>
References: <20180717042150.37761-1-keescook@chromium.org> <20180717042150.37761-6-keescook@chromium.org>
 <20180717163936.GB75957@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 17 Jul 2018 13:07:50 -0700
X-Google-Sender-Auth: VJdsoLPqumtapTCOIENYSKGJN84
Message-ID: <CAGXu5jKKD4hzeFEdvY5QdahEr4POd9ZM_B_5Z_iU-Qmx3AYSfQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v5 05/11] crypto: ahash: Remove VLA usage
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>, qat-linux@intel.com,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 9:39 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Mon, Jul 16, 2018 at 09:21:44PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> introduces max size macros for ahash, as already done for shash, and
>> adjust the crypto user to max state size.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  crypto/ahash.c        | 4 ++--
>>  crypto/algif_hash.c   | 2 +-
>>  include/crypto/hash.h | 3 +++
>>  3 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/crypto/ahash.c b/crypto/ahash.c
>> index a64c143165b1..6435bdbe42fd 100644
>> --- a/crypto/ahash.c
>> +++ b/crypto/ahash.c
>> @@ -550,8 +550,8 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
>>  {
>>       struct crypto_alg *base = &alg->halg.base;
>>
>> -     if (alg->halg.digestsize > PAGE_SIZE / 8 ||
>> -         alg->halg.statesize > PAGE_SIZE / 8 ||
>> +     if (alg->halg.digestsize > AHASH_MAX_DIGESTSIZE ||
>> +         alg->halg.statesize > AHASH_MAX_STATESIZE ||
>>           alg->halg.statesize == 0)
>>               return -EINVAL;
>>
>> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
>> index bfcf595fd8f9..8974ee8ebead 100644
>> --- a/crypto/algif_hash.c
>> +++ b/crypto/algif_hash.c
>> @@ -239,7 +239,7 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
>>       struct alg_sock *ask = alg_sk(sk);
>>       struct hash_ctx *ctx = ask->private;
>>       struct ahash_request *req = &ctx->req;
>> -     char state[crypto_ahash_statesize(crypto_ahash_reqtfm(req)) ? : 1];
>> +     char state[AHASH_MAX_STATESIZE];
>>       struct sock *sk2;
>>       struct alg_sock *ask2;
>>       struct hash_ctx *ctx2;
>> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
>> index ae14cc0e0cdb..4fcd0e2368cd 100644
>> --- a/include/crypto/hash.h
>> +++ b/include/crypto/hash.h
>> @@ -64,6 +64,9 @@ struct ahash_request {
>>       void *__ctx[] CRYPTO_MINALIGN_ATTR;
>>  };
>>
>> +#define AHASH_MAX_DIGESTSIZE 512
>> +#define AHASH_MAX_STATESIZE  512
>> +
>
> Why is AHASH_MAX_DIGESTSIZE (512) so much larger than SHASH_MAX_DIGESTSIZE (64)?
> I would have expected them to be the same.

This was a direct replacement of the PAGE_SIZE / 8 original limit.
This this didn't trip any frame size warnings, it seemed like we
didn't need to do the more narrow limitations done elsewhere.

I am, of course, happy to do a manual review and find a lower
alternative if that's desired.

-Kees

-- 
Kees Cook
Pixel Security
