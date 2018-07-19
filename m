Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD2BECDFBD
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C7A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jf2PHG9R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iv0i68fU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C7A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeGSFU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:20:58 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46089 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeGSFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:20:58 -0400
Received: by mail-yb0-f193.google.com with SMTP id c3-v6so2765261ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bXEgyHTH6uod0tFsk5+OEAwOiCXfxwcaDdmD+0i18XI=;
        b=jf2PHG9RnoWn+MzFtjD8wcZrOW83dwQmW2SlofeDp5r7hbKjIAtPGLaFN3ZC5nrgFK
         QzXY4ef+YRfVyvbZpV2gwoBAZb8zXJWAGsobThBgLyjW1cDa6bPWId3/mpNPBWOXw5h9
         /uPvjeOCoMjp0LMlV02h7Ww4Lfb6YaYcdxGzmndVSbkhNg0N+9Hnufumlfp4KrQ6+abm
         riQyMJ4R/R8InJS/ta8a7SFu1YVWW+OVSDm28kWAyYs6MBTRr86yuIP4/PIR4UDiigOZ
         4u3i7rgDP46NkfPSNlk7acQG+6FKZJOgs6Ifk12ORbKLN/Wedfev/WT6Py4UEu19ioSp
         M3yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bXEgyHTH6uod0tFsk5+OEAwOiCXfxwcaDdmD+0i18XI=;
        b=iv0i68fUbqOSU0hwQPNRqDHlX852MwT/CiOOco3H10tg0g0COpRw2CaOQGCt9lkOnG
         WmntiYKg8Y5sWXi8tIQitm4WCajPrlWDzfLNJC1M6LAXm+P5UmH2PcoGV11ihYG8eBVl
         uK6hwwLHYCCZq7uqYM340J0qrRKuYEJNpg7Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bXEgyHTH6uod0tFsk5+OEAwOiCXfxwcaDdmD+0i18XI=;
        b=akq+C17FYqk0NH0/5Jn7BSmMHxU5e9fu15iqjxuVm8d0Ehp6blcmntH+JXSn37b8fZ
         JNxcaglwCMSBrwKlmdBboDrB8bV/pNB427HdDwPv9686MCNJNJRrnFGMuP8rVGWn1jqj
         WpRc2gvtk7Hfgi16wPOEesI9FV9mL4SqU4zvoG1hF/usfbUI/KylwX+4y/5ugiX9vKwU
         yZZXC3QnXbppryMkvMkJsW7I3oM3bYMaXKrbjqsTb6kHG1Tpk5AICTWyx3EdFeeqVGeI
         OcojNNebDfh/+HxwJDapuv+aOOvhjm8TDURsHfpOqXVZ+X/zlmWCFzxFP1Fg5H+RdldD
         l/Gg==
X-Gm-Message-State: AOUpUlHqtz5M6axXBxJ86mB4faLVVBScr9rgFoL4AxvVJbB1Km0hkMLk
        n+s9ZkWrSGFYMm+5sBx40dgGJaq7pIiD1E1RPQZqHw==
X-Google-Smtp-Source: AAOMgpehnixLogNw78oXLMj08jN5JJze1OjMa+uYxi93tFOmS6aQF5gl/Occu9yMLQQWSIXKTjyW0jfddgbwhBFvZjY=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr4891671ybj.112.1531975187629;
 Wed, 18 Jul 2018 21:39:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 21:39:46
 -0700 (PDT)
In-Reply-To: <20180716172205.GB77258@google.com>
References: <20180716035657.GA32180@beast> <20180716172205.GB77258@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 18 Jul 2018 21:39:46 -0700
X-Google-Sender-Auth: kevPxNfh9Nd3xf64Hr44p58Tfu4
Message-ID: <CAGXu5jJL8B+eBwm5j7M=p9zd+n559M+yFC9RoDyV8cjmvT6JhQ@mail.gmail.com>
Subject: Re: [PATCH] x86/power/64: Remove VLA usage
To:     Eric Biggers <ebiggers@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:22 AM, Eric Biggers <ebiggers@google.com> wrote:
> On Sun, Jul 15, 2018 at 08:56:57PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> removes the discouraged use of AHASH_REQUEST_ON_STACK by switching to
>> shash directly and allocating the descriptor in heap memory (which should
>> be fine: the tfm has already been allocated there too).
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/x86/power/hibernate_64.c | 35 +++++++++++++++++++----------------
>>  1 file changed, 19 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
>> index 67ccf64c8bd8..0ed01bb935a6 100644
>> --- a/arch/x86/power/hibernate_64.c
>> +++ b/arch/x86/power/hibernate_64.c
>> @@ -233,28 +233,31 @@ struct restore_data_record {
>>   */
>>  static int get_e820_md5(struct e820_table *table, void *buf)
>>  {
>> -     struct scatterlist sg;
>> -     struct crypto_ahash *tfm;
>> +     struct crypto_shash *tfm;
>> +     struct shash_desc *desc;
>>       int size;
>>       int ret = 0;
>>
>> -     tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
>> +     tfm = crypto_alloc_shash("md5", 0, 0);
>>       if (IS_ERR(tfm))
>>               return -ENOMEM;
>>
>> -     {
>> -             AHASH_REQUEST_ON_STACK(req, tfm);
>> -             size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry) * table->nr_entries;
>> -             ahash_request_set_tfm(req, tfm);
>> -             sg_init_one(&sg, (u8 *)table, size);
>> -             ahash_request_set_callback(req, 0, NULL, NULL);
>> -             ahash_request_set_crypt(req, &sg, buf, size);
>> -
>> -             if (crypto_ahash_digest(req))
>> -                     ret = -EINVAL;
>> -             ahash_request_zero(req);
>> -     }
>> -     crypto_free_ahash(tfm);
>> +     desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
>> +                    GFP_KERNEL);
>> +     if (!desc)
>> +             return -ENOMEM;
>
> Need crypto_free_shash(tfm) if the kmalloc() here fails.

Ah thanks! Fixed now for the next version.

-Kees

-- 
Kees Cook
Pixel Security
