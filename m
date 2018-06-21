Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5E4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C5220874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rgrVTdwH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cYtc1x6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C5220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbeFUAEM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:04:12 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46927 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932978AbeFUAEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:04:10 -0400
Received: by mail-yb0-f193.google.com with SMTP id s14-v6so516585ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 17:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tuugBuej1vu5FSZtTuwfIlKGF1cza+lV5o8S4RQt9ZA=;
        b=rgrVTdwHNBaqzd9UdcmXUmOcrFTgfsaqCDBdz9iesASZx8RZ2L7RVNlldirCJLnNm7
         cvxes6U6bnVZ8C55zmBaiL/QoMYhLFB90ZsAQzQWogzzfQ2p4UE8kl8BY8BEYEasHqPb
         qSt2FjMVwFZ+zp89fGqosfS1gp5c0U1le1jCW2Nz1VqL3X7qx3hjKtUp+mH0HG/isF94
         nZm9EG31En6l5dTu7yBdaAbnbj2lLAgPaJSX15N5K0E7VEMKfSKQosy/P2tyzVcyIBcz
         QAQ8U4k4M68If4ibqye14++czsBHTdLQb4t8+L0hfAX4XglZESW5BVz6gihCyDNjt7XG
         Ixjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tuugBuej1vu5FSZtTuwfIlKGF1cza+lV5o8S4RQt9ZA=;
        b=cYtc1x6JySM/S1qhEYXitsDOp3sxIfrbBctR2EdxK5eT756R40bI235+KtKSgqDsTb
         T8inKSyQIpIh9Hzh/fhdFhNvsEB8SyidShp3DJaSlhz//2YGf9bCoYd7k84iCLx9Dwbk
         IOcAekk4QgQxHoKC/vCMxMhk7qQjbDPKfR2F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tuugBuej1vu5FSZtTuwfIlKGF1cza+lV5o8S4RQt9ZA=;
        b=XaCkDnDpFntqU9vpGN9wO/bgTgkeYEBVmRoUUOoss1Fo5YQpJaP3tZzl/jt6Gre3WL
         PYqeZvrUAGY2x89YAU104JS/kT3BJ+mnO08d4+EeKxbUnb6yFm+hbh/mPLYMqExfqg5u
         BYrEH5yX/PqI4GMCOkQWURMD85cgS+GtDxFDqeAIcEICZx67Fap25g5QAduFIW8ZD5zJ
         Dq1KiJeHeeWookEYeTMk2oBvmyfFVCGdOTjAIZN3WujdeFbdyD/4sr8uZ6ld7zvK1Ju+
         rj3YElK560PcA3DNmVqfj+XoMCHv6NOTMylI6LZ6LzHeVdjyEkUipOGf4q9qxQdRXXx7
         otJA==
X-Gm-Message-State: APt69E3CnYApdSO5AVBYtw8P7EH7krPIRVa3CDMoaDTtw3uipT4GBZPt
        RV5OB/G487P8xjtWsG1IHjvnf9GKFKhXnhrlkBEw1g==
X-Google-Smtp-Source: ADUXVKLGfRUtQRb04o9jSbCJupZfw5wmwKG4uc3nDO7f/N77QiZZO6CKivl5PiqqWb4P783fdYKbdQLm8+3AYE2fRSA=
X-Received: by 2002:a25:ce8b:: with SMTP id x133-v6mr6018341ybe.118.1529539449226;
 Wed, 20 Jun 2018 17:04:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 17:04:08
 -0700 (PDT)
In-Reply-To: <20180620234031.GC111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-6-keescook@chromium.org>
 <20180620234031.GC111712@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 17:04:08 -0700
X-Google-Sender-Auth: Mt7gAamJipypjh5u_mzrsi5kAZs
Message-ID: <CAGXu5j++uGCnAOiQd=JM139B6g7oUGTquhgniX-Fwsj8qofU9w@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 05/11] crypto alg: Introduce max blocksize and alignmask
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

On Wed, Jun 20, 2018 at 4:40 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Wed, Jun 20, 2018 at 12:04:02PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> exposes the existing upper bound on crypto block sizes for VLA removal,
>> and introduces a new check for alignmask (current maximum in the kernel
>> is 63 from manual inspection of all cra_alignmask settings).
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  crypto/algapi.c        | 5 ++++-
>>  include/linux/crypto.h | 4 ++++
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/crypto/algapi.c b/crypto/algapi.c
>> index c0755cf4f53f..760a412b059c 100644
>> --- a/crypto/algapi.c
>> +++ b/crypto/algapi.c
>> @@ -57,7 +57,10 @@ static int crypto_check_alg(struct crypto_alg *alg)
>>       if (alg->cra_alignmask & (alg->cra_alignmask + 1))
>>               return -EINVAL;
>>
>> -     if (alg->cra_blocksize > PAGE_SIZE / 8)
>> +     if (alg->cra_blocksize > CRYPTO_ALG_MAX_BLOCKSIZE)
>> +             return -EINVAL;
>> +
>> +     if (alg->cra_alignmask > CRYPTO_ALG_MAX_ALIGNMASK)
>>               return -EINVAL;
>>
>>       if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
>> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
>> index 6eb06101089f..e76ffcbd5aa6 100644
>> --- a/include/linux/crypto.h
>> +++ b/include/linux/crypto.h
>> @@ -134,6 +134,10 @@
>>   */
>>  #define CRYPTO_MAX_ALG_NAME          128
>>
>> +/* Maximum values for registered algorithms. */
>> +#define CRYPTO_ALG_MAX_BLOCKSIZE    (PAGE_SIZE / 8)
>> +#define CRYPTO_ALG_MAX_ALIGNMASK    63
>> +
>
> How do these differ from MAX_CIPHER_BLOCKSIZE and MAX_CIPHER_ALIGNMASK, and why
> are they declared in different places?

This is what I get for staring at crypto code for so long. I entirely
missed these checks... even though they're 8 line away:

        if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
                               CRYPTO_ALG_TYPE_CIPHER) {
                if (alg->cra_alignmask > MAX_CIPHER_ALIGNMASK)
                        return -EINVAL;

                if (alg->cra_blocksize > MAX_CIPHER_BLOCKSIZE)
                        return -EINVAL;
        }

However, this is only checking CRYPTO_ALG_TYPE_CIPHER, and
cra_blocksize can be used for all kinds of things.

include/crypto/algapi.h:#define MAX_CIPHER_ALIGNMASK            15
...
drivers/crypto/mxs-dcp.c:                       .cra_flags
 = CRYPTO_ALG_ASYNC,
drivers/crypto/mxs-dcp.c:                       .cra_alignmask          = 63,

Is this one broken? It has no CRYPTO_ALG_TYPE_... ?

For my CRYPTO_ALG_MAX_BLOCKSIZE, there is:

crypto/xcbc.c:  u8 key1[CRYPTO_ALG_MAX_BLOCKSIZE];
drivers/crypto/qat/qat_common/qat_algs.c:       char
ipad[CRYPTO_ALG_MAX_BLOCKSIZE];
drivers/crypto/qat/qat_common/qat_algs.c:       char
opad[CRYPTO_ALG_MAX_BLOCKSIZE];

It looks like both xcbc and qat are used with shash, so that needs a
separate max blocksize.

For my CRYPTO_ALG_MAX_ALIGNMASK, there is:

crypto/shash.c: u8 ubuf[CRYPTO_ALG_MAX_ALIGNMASK]
crypto/shash.c:         __aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);
crypto/shash.c:         __aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);

which is also shash.

How should I rename these and best apply the registration-time sanity checks?

-Kees

-- 
Kees Cook
Pixel Security
