Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD15C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B8920652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="N9i6oRkp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E5Y0Z7dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B8920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeFUAPI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:15:08 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44933 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932552AbeFUAPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:15:07 -0400
Received: by mail-yb0-f193.google.com with SMTP id w74-v6so525837ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 17:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MPEb6HaVG+FCnZtxTALeJjvKiOS6SVXuhO4vjhjOumw=;
        b=N9i6oRkpO/Jt63soS/kemWoXBSPilX9Una637S3fTnQUuXxNHnybubuh9DbnAmZxoh
         NhaVgS4p6P02OaB7Th51fBXu98BXPmCOi19Eegi9zfMAQ/sxUFnE7f8sPdXAaNNefSV+
         TYSRbEYfTAxmWhDB0Ra0aDdJTGB2VqEtRfJ3GcURVAUtqOjSPYy+tHc+Rf0LJ/vM5WFC
         ug7rm6VNcq/2GVJyUNwghj9fZ80WgZvCslP5mPqeAua25q/adWg5B42k3Fs4FIEWsvU8
         H0bSh7BnipzYWBfRNNfUe7R+bs/sE8oaJqFgHabNK0pigA+YsjtlAtNBlADqM8v/8GWg
         HPug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MPEb6HaVG+FCnZtxTALeJjvKiOS6SVXuhO4vjhjOumw=;
        b=E5Y0Z7dBpsQkTgwDPCqvMc6SobIqZLn7t+p04vlCJhccoy7jIzTq8F3JPPJFGuHlgI
         xGlRylRJWJOsvUIeUaBHUCXQNDb6X35MO+0iJELDeqjR4bqNY+UZhnxcoQq+PCE5G2Ua
         3DDcD53gGkx5Am3Ldprj3zKr93GKH7rL4n3As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MPEb6HaVG+FCnZtxTALeJjvKiOS6SVXuhO4vjhjOumw=;
        b=ufbftGExlxVO0HQrp8vcznIMOj70DWZQ99J8JyU5p4y0BlW7jMWYVjzbe1qmrj1Pbm
         CVXJjVr0a/Ycwe3DEj/H/oICrKhE7Xayr+tzCPCRARQCnKoZ7YG4BQQ4ggIiEnqODEdF
         Akqha8aNoGKS2nTsScPwpC2N/bZKPg8qzmLL6aMIRzzWU4dwW5FYC2KFuu/kDFUYHe11
         k+9HcAjfTlgtdLSZIiqDYzhqG4sE6RkMoMbfSKixMVr6BFxkxeTYa4zM6ST0s7f4yJcX
         chNaQrPatzywYSSmmLN99P4P8w5D1kYEtL/kEt5WK8GGC7NyaFZDPyAH3lypYGs/oF9B
         VQCQ==
X-Gm-Message-State: APt69E2iXUvkJIdOUTyB9aOqrelKYv2Q8uvmTXxvpi1EM1Q2hd+sFktt
        KN4lYgvf6SNt9Cif/Wc2YdjirILGU4bcc6+xXWkEig==
X-Google-Smtp-Source: ADUXVKLHmDnpQK/Vo/VHZLTjadW5peKzMRR4lSfFmJ4l0oMm2Cakvr2Kont7C+rCq9L5/mEKimOhsvBhkyzkuuo0hiA=
X-Received: by 2002:a25:f81e:: with SMTP id u30-v6mr9675674ybd.343.1529540106255;
 Wed, 20 Jun 2018 17:15:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 17:15:05
 -0700 (PDT)
In-Reply-To: <20180620235721.GF111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-10-keescook@chromium.org>
 <20180620235721.GF111712@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 17:15:05 -0700
X-Google-Sender-Auth: 8qHeARa-UcDUYGQH-J82OWex_bQ
Message-ID: <CAGXu5jJJXM3pCE7y3akkmh_0RzLaO5g39hueZNKPoE4E9yaJfQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] crypto: shash: Remove VLA usage in unaligned hashing
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com, linux-crypto <linux-crypto@vger.kernel.org>,
        Lars Persson <larper@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 4:57 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 12:04:06PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this uses
>> the newly defined max alignment to perform unaligned hashing to avoid
>> VLAs, and drops the helper function while adding sanity checks on the
>> resulting buffer sizes.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  crypto/shash.c | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/crypto/shash.c b/crypto/shash.c
>> index ab6902c6dae7..1bb58209330a 100644
>> --- a/crypto/shash.c
>> +++ b/crypto/shash.c
>> @@ -73,13 +73,6 @@ int crypto_shash_setkey(struct crypto_shash *tfm, const u8 *key,
>>  }
>>  EXPORT_SYMBOL_GPL(crypto_shash_setkey);
>>
>> -static inline unsigned int shash_align_buffer_size(unsigned len,
>> -                                                unsigned long mask)
>> -{
>> -     typedef u8 __aligned_largest u8_aligned;
>> -     return len + (mask & ~(__alignof__(u8_aligned) - 1));
>> -}
>> -
>>  static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
>>                                 unsigned int len)
>>  {
>> @@ -88,11 +81,14 @@ static int shash_update_unaligned(struct shash_desc *desc, const u8 *data,
>>       unsigned long alignmask = crypto_shash_alignmask(tfm);
>>       unsigned int unaligned_len = alignmask + 1 -
>>                                    ((unsigned long)data & alignmask);
>> -     u8 ubuf[shash_align_buffer_size(unaligned_len, alignmask)]
>> -             __aligned_largest;
>> +     u8 ubuf[CRYPTO_ALG_MAX_ALIGNMASK]
>> +             __aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);
>>       u8 *buf = PTR_ALIGN(&ubuf[0], alignmask + 1);
>>       int err;
>
> Are you sure that __attribute__((aligned(64))) works correctly on stack
> variables on all architectures?
>
> And if it is expected to work, then why is the buffer still aligned by hand on
> the very next line?

I really don't know -- the existing code was doing both the __align
bit and the manual alignment, so I was trying to simplify it while
removing the VLA. I'm totally open to suggestions here.

BTW, these are also the only users of __aligned_largest() in the
kernel, and the only use of unsized __attribute__((aligned))

-Kees

-- 
Kees Cook
Pixel Security
