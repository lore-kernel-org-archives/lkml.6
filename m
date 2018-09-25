Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DECAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFBE2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V2wZ68Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFBE2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeIYWk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:40:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33925 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeIYWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:40:27 -0400
Received: by mail-io1-f67.google.com with SMTP id h16-v6so10663073ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zI7EwXJVRUUz9X6QFlJsqNDCtBhIk/n9ANstwAP2tZ0=;
        b=V2wZ68Xd6eKCaaj3uZ5V8P//gNxSEEqdB8Hib57ejRrO83/GdM1I7abtyLh50EyDf6
         PIhwWfjN82EL1klrscvmbtTxY0XY7cAQ8EyVDnFIsGxD5fyXELog+yMSdlQQhycULkxN
         8rz4Q31HC5gZcShtEbi53kWWCQzinvJiZrd7P9Afu45F0AqYsyA3Y14meZKlNl7gfUnO
         Iu7ffa879cktin+u5AUF9kXmcsNvF0Q4Lq7JxnkSkzFAmD79ZagihKo8bFopRSiEd+SF
         pj3+/XZBsIihRSDZqMwuTj4g09skLZsal+HIun4zLhl/uuwLOClsI4CCA03ZOwhUNU4Z
         GQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zI7EwXJVRUUz9X6QFlJsqNDCtBhIk/n9ANstwAP2tZ0=;
        b=g8ODmHH7FIJ8Eke9ChY73cSeuvX5LUHTmH9wtZmp3KaIpDHYyKRazLg2t4INpkeQIx
         uV1Eqs84D4rOKdE5uPaudm+rS4YOSLN1W/EanoX6ODyWHOrKOYCkYF0AlM/Wvutptt8r
         KkDd2caePLgo8IVDhNwaL6Fx+IRAEEEF049qhCC2d3DMGsnXS8wT1HWaffl8GoUPpfZO
         /7dAZhQ5XVOUeVKExfYSLzvty0jBLCc3GqKmGa73Vzz4Mn1g5CfKvksVNB0ik68OZSUG
         z+LrJih6nN8CHjSB3OkSYv6kw2Q07h2N+y6ZKQ/8tTobr8cJrVQpcm7QTx+edbR1fwZ1
         cRAA==
X-Gm-Message-State: ABuFfoh0WNqLXPur1iRQtXF0i2JqSLNqBvccD90uNSHD56EwzlvAO1hL
        IhjvTC88s90kLPXFChae4dRRaHVYjXU=
X-Google-Smtp-Source: ACcGV61MiFh1GgQOfhroMf2r//2EJdJm1vCykIFkMDkBZPz18UBL8r4r4ZM+1mp2FtxE8kmON9XuNA==
X-Received: by 2002:a6b:2b89:: with SMTP id r131-v6mr1658198ior.256.1537893129796;
        Tue, 25 Sep 2018 09:32:09 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s3-v6sm928064ioo.87.2018.09.25.09.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 09:32:08 -0700 (PDT)
Subject: Re: [PATCH crypto-next 07/23] block: cryptoloop: Remove VLA usage of
 skcipher
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-block@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180919021100.3380-1-keescook@chromium.org>
 <20180919021100.3380-8-keescook@chromium.org>
 <CAKv+Gu8ynaVi1KCMNsjCU0ucAjFFku=ourh9Yc9Rizoc4ztvOQ@mail.gmail.com>
 <CAGXu5jLw3+nvb9opPeoCyH0MhyVK5UY7H5qeQ2b8GFTUGDGrUQ@mail.gmail.com>
 <CAKv+Gu-xKWsiegZXnsMvmMVgKTo7S2cm4wEqdaL7w9z64X7SAA@mail.gmail.com>
 <9c71afda-a668-10b3-842e-26f72e425691@kernel.dk>
 <CAKv+Gu_p2UgYMZ5jEUudruUOPYQEF-=VMou=xXbj_rd+-Lxktg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eaf66894-2f85-12ba-f91c-4387437cc8d9@kernel.dk>
Date:   Tue, 25 Sep 2018 10:32:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_p2UgYMZ5jEUudruUOPYQEF-=VMou=xXbj_rd+-Lxktg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 10:16 AM, Ard Biesheuvel wrote:
> On Tue, 25 Sep 2018 at 18:03, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/25/18 3:25 AM, Ard Biesheuvel wrote:
>>> On Mon, 24 Sep 2018 at 19:53, Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> On Mon, Sep 24, 2018 at 4:52 AM, Ard Biesheuvel
>>>> <ard.biesheuvel@linaro.org> wrote:
>>>>> On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
>>>>>> @@ -119,7 +119,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>>>>>>         unsigned in_offs, out_offs;
>>>>>>         int err;
>>>>>>
>>>>>> -       skcipher_request_set_tfm(req, tfm);
>>>>>> +       skcipher_request_set_sync_tfm(req, tfm);
>>>>>>         skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
>>>>>>                                       NULL, NULL);
>>>>>>
>>>>>
>>>>> Does this work?
>>>>
>>>> Everything is a direct wrapper for existing types and functions, so I
>>>> wouldn't expect any functional change. I haven't been able to test
>>>> this particular interface, though. cryptoloop is very deprecated,
>>>> isn't it?
>>>>
>>>
>>> Ah yes, I managed to confuse myself there. This looks all fine to me.
>>>
>>> In any case, this is another example where we may decide to fix the
>>> code rather than retain the request allocation on the stack (but that
>>> is Jens's call ultimately, I suppose)
>>>
>>> diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
>>> index 7033a4beda66..5ed2167219ba 100644
>>> --- a/drivers/block/cryptoloop.c
>>> +++ b/drivers/block/cryptoloop.c
>>> @@ -110,7 +110,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>>>                     int size, sector_t IV)
>>>  {
>>>         struct crypto_skcipher *tfm = lo->key_data;
>>> -       SKCIPHER_REQUEST_ON_STACK(req, tfm);
>>> +       struct skcipher_request *req;
>>>         struct scatterlist sg_out;
>>>         struct scatterlist sg_in;
>>>
>>> @@ -119,7 +119,10 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>>>         unsigned in_offs, out_offs;
>>>         int err;
>>>
>>> -       skcipher_request_set_tfm(req, tfm);
>>> +       req = skcipher_request_alloc(tfm, GFP_NOIO);
>>> +       if (!req)
>>> +               return -ENOMEM;
>>
>> Is this going to be reliable? ->transfer() is called when we're doing IO,
>> and you'd normally need a mempool backed allocation to make this safe
>> and guarantee forward progress.
>>
> 
> As far as I can tell, this function is only called from
> lo_read_transfer/lo_write_transfer, both of which do an unconditional
> alloc_page(GFP_NOIO), which is why I assumed that kmalloc(GFP_NOIO)
> would be permissible in the same context. Are you saying this may not
> be the case?

Doesn't appear to be safe for either your case, nor the page it's
allocating. If the allocator fails this allocation, then you'll get
an EIO on that request. The more likely case is the allocator taking
forever to satisfy the request, in which case you'll have very
large latencies for IO when you are close to being out of memory.
The preferred setup for allocating memory for IO is having a mempool
of at least one item. If you end up blocking for memory, you'll at
most get to wait for the existing IO that's using that memory to
complete (per waiter, of course).

-- 
Jens Axboe

