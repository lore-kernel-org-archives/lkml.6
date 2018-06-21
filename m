Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83438C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327F120875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="m89V8WRb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYx/hmpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327F120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeFUAKH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:10:07 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44834 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932552AbeFUAKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:10:05 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so495329ywm.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rTCv3g3UtGvlJAde7ejfrhgmUJJ/4xCMXvOZxzmjTFA=;
        b=m89V8WRbu0tiWzQU1OFfH5z7J1d2BOgsAlaN+DzYq63tWLqW+gy9cLzi5qCU7KDRke
         JVZyYO+WQSThH8BI7QQwWVeBcntc5K7QekLqp6I8UwO5TbLiiVScfz1tNmiiEc/k8T3x
         Ty9MCrYv+7nrsI/OLX10MgN1hW6R1LLKCRRXim3Ql6TogMcokud006rwUuL5FCm2MlRJ
         RdU4RgF0sz0adjSWSToRkgbtjgJIeHWjy0HDEHoUQ7vEtwhgquEHFjHT/kisgIEUF4nl
         f5tuke814NS26NJtPv136mf0fAzVNz2agCSCW4GORlQIQJzwadpb48Vs1jH4kJZ8wWjc
         LJQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rTCv3g3UtGvlJAde7ejfrhgmUJJ/4xCMXvOZxzmjTFA=;
        b=BYx/hmpWbiG3ZIT8DU3NNQkh87ibNRyHhvkCo6NmXnXsyulYC4tKySFrom5R6h2xJG
         8TTmnuT7tNcOiU6cE7MWdUnNYT3OmbTz+dMlSIUEwtIGqJMYB9DXu+J9qNMg3tfga2xu
         0dCy5NMG5vqVm/OUxKUsSr8gyZ2s6N6cWqeUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rTCv3g3UtGvlJAde7ejfrhgmUJJ/4xCMXvOZxzmjTFA=;
        b=n3Og/FaKuHZc738UjkMW5FH/tl29lWyyt/gpnO/c5qJQeQevDBgwiSh/ZEcHz7R89e
         AN+FFB1FdroU+32yHOFa7RPCuSW6ZkfsDXX6sZy+6MK/hsUYtyTZbVa+4SyAC7Rqx/7+
         yk7AOuErq5ZGm0sHVJfkZ2Zp44jljX0WJrj06ndv3yeL5CsgII9CbAXvUjFWwOyr86Jd
         bhryJn6V04Y6ICWO8cw25XjtbvxI48ZzMIRD6eQeKHqgWadtARgCNDJPGeVOfDL8J5RA
         ZELOwsOLNQzdyEUHzTsVs7MRQByK4k8Myk5VtRziiJ//2cJfH12EZNfxHEA4BgD7gxCx
         84Bw==
X-Gm-Message-State: APt69E3VShuSdq8L1HClreXgEqSBAgjvMqLbDAfzgGIzvTryXvNgi9ra
        Gi5pdRXe52pCSN3CF3xKvgOub2aTTYiOGRexfnjQtQ==
X-Google-Smtp-Source: ADUXVKKYD6BbsCyCwa2WAN1rVIxn5cySCoQCjRQnVL8ZFFEuNGI5pT4NvUMG5WmCPskrBJAoiTMGpflDV4Lf+xCJbZ8=
X-Received: by 2002:a81:2506:: with SMTP id l6-v6mr25848ywl.88.1529539805063;
 Wed, 20 Jun 2018 17:10:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 17:10:04
 -0700 (PDT)
In-Reply-To: <20180620234623.GE111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-8-keescook@chromium.org>
 <20180620234623.GE111712@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 17:10:04 -0700
X-Google-Sender-Auth: zNfS-8q1KEZSjlycZeH-0vf8m0c
Message-ID: <CAGXu5jJ30eGUoik5+fWgdSHcO7NrAi87LXWWA5=RX6zwK0ueVg@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 07/11] crypto: xcbc: Remove VLA usage
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

On Wed, Jun 20, 2018 at 4:46 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 12:04:04PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this uses
>> the maximum blocksize and adds a sanity check.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  crypto/xcbc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/crypto/xcbc.c b/crypto/xcbc.c
>> index 25c75af50d3f..016481b1f3ba 100644
>> --- a/crypto/xcbc.c
>> +++ b/crypto/xcbc.c
>> @@ -65,7 +65,10 @@ static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
>>       int bs = crypto_shash_blocksize(parent);
>>       u8 *consts = PTR_ALIGN(&ctx->ctx[0], alignmask + 1);
>>       int err = 0;
>> -     u8 key1[bs];
>> +     u8 key1[CRYPTO_ALG_MAX_BLOCKSIZE];
>> +
>> +     if (WARN_ON(bs > sizeof(key1)))
>> +             return -EINVAL;
>
> Similarly, why not MAX_CIPHER_BLOCKSIZE?
>
> Also, xcbc_create() only allows a 16-byte block size, and you made the API
> enforce the maximum for algorithms anyway.  So I think the extra check here
> isn't very worthwhile.

Is the "parent" argument in crypto_xcbc_digest_setkey() always going
to be the "alg" from xcbc_create()? I couldn't convince myself that
was true. If it is, then yes, this VLA can trivially made to be 16,
but it seemed like they were separate instances...

-Kees

-- 
Kees Cook
Pixel Security
