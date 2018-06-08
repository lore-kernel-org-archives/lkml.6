Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xYFwE5owGlseSAAAmS7hNA
	; Fri, 08 Jun 2018 07:30:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2FFC7607E4; Fri,  8 Jun 2018 07:30:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEI8kLy1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5D96560590;
	Fri,  8 Jun 2018 07:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D96560590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeFHHab (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:30:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33264 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeFHHa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:30:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so5997563wma.0;
        Fri, 08 Jun 2018 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2kfzHyGOH+ld9l1uj9YNyXvMaqWEiD7CGNrcFYXCXZ4=;
        b=VEI8kLy1QmcZaEfV6nsXVmcFnAxl/UwPwzxv/bqxnpimHSG3WtjItAvJXGah+NkYXu
         uhe8QhNZjbFdTIXGq0NihEpo31a5pdLcLMlwAnIbBvZUqoPn0C5AaDrXxN1WH4QIRBTD
         gzUeLrjdtP/ISdUwjnrBt4C9y3G9J4BngrW8Pgr/49b8SVkdAO/okb26PKtB56QOAx1J
         2c8FCGHaRdOlBLT40sSSnKjr1hrvvtDURY1MUJUJx8YXj1iZd5WyXVkZxDWAQl1mdKJn
         Y3WvUJWB10INOseL7RiVuyn2pFfBYPk+qBc5mBU+ryh5SNQqkeq3rI3bhUhSIV5nfH6B
         gS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2kfzHyGOH+ld9l1uj9YNyXvMaqWEiD7CGNrcFYXCXZ4=;
        b=aqost61KjKcO7x5XrA94HL83u2Br3wb8lmU7wue7Z7be5cibC7vHfP7UjFMSoVpLnQ
         HbamIXstCHr7ZwSjOGdPoFiMANcdP/91wqk0sft7k8N+ZAH36lueNaVQyZQ5J4yu38eN
         XtXkmtlDUjANwLh7MQGpfLbWXICHDaoQcA+/NB9oI80F60sV+8hKROJ3od2V2ofMIZcI
         B9sTOikPbgmZeQIXE2YDFIAvIcsJAmIk9Xf7UaaTqIZNZs9zqMGH84mOUuqwm6wYRXDy
         D2Hmh63OryLrCIYseeQf15NeWQ46CtzMXgQYdAx6Rj36s+hbZHmJqLkdDFT2OUWQmPd7
         xt5A==
X-Gm-Message-State: APt69E259wYSB0MjeIVFM41cONqEOyd1GF0WHBko2njsKDYWJJ0eTdpS
        jngLua8nYrWFwbY5GOeqqLiD8yyRhX57h0HPS9p+rQ==
X-Google-Smtp-Source: ADUXVKLcu0hGsHrxTgx0ZIa+ZWd8J795Wx7YBJM083OskIa5RcOaMTXM6rXeHGVix7+JckjEyCJx3MlrVslVOZ5FUws=
X-Received: by 2002:a50:d490:: with SMTP id s16-v6mr6074287edi.127.1528443027775;
 Fri, 08 Jun 2018 00:30:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:a762:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 00:30:27 -0700 (PDT)
In-Reply-To: <CAOtvUMcJfJDjnMoithRQ4ife09VC+G-w+__jV-JLwh7M=s7JNQ@mail.gmail.com>
References: <1528361927-4172-1-git-send-email-gilad@benyossef.com> <CAOtvUMcJfJDjnMoithRQ4ife09VC+G-w+__jV-JLwh7M=s7JNQ@mail.gmail.com>
From: Harsh Jain <harshjain.prof@gmail.com>
Date: Fri, 8 Jun 2018 13:00:27 +0530
Message-ID: <CAFXBA==p=UzjAuRDfp6q=Cy6Ym9HuBrV-qqjvxb7X8RA0kOrJA@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: fix iv copying for small buffers
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, hadar.gat@arm.com,
        Ofir Drang <ofir.drang@arm.com>, stable@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 2:32 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> Hi,
>
> On Thu, Jun 7, 2018 at 11:58 AM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>> We are copying our last cipher block into the request for use as IV as
>> required by the Crypto API but we failed to handle correctly the case the
>> buffer we are working on is smaller than a block. Fix it by calculating
>> how much we need to copy based on buffer size.
>>
>
> I'd be really happy to get a review on this patch - not so much what
> it is doing but
> rather the rational behind it - how is a tfm provider supposed to
> handle copying the
> last block of ciphertext into the request structure if the ciphertext
> size is less than a
> block?
>
> I opted for simply copying whatever ciphertext was available and
> zeroing the rest
> but frankly I'm not sure this is the right thing.

Hi Gilad,

Requirement to copy IV back is different for various mode. You can
check software template(cbc, ctr,...)  for reference. Basic idea is
Update IV such that user can use the same context to continue
encryption.

e.g   CBC  mode uses last encrypted block as IV for current block.
That why we have to copy last 16 byte to req->info

        Note : For in-place decryption we save the last block(IV for
next) in local buffer to avoid  getting written by Plaintext.

for ctr  mode: driver should increment counter(last 4 bytes of IV)
based to no of block( 1 block implies 1 counter increment) processed


You can use following  kcapi command to compare the results with sw
crypto. "-s"  switch will use the same context for "-d" No. of
iterations

./kcapi -x 1 -e -s  -d 4 -c "cbc(aes)" -k
8d7dd9b0170ce0b5f2f8e1aa768e01e91da8bfc67fd486d081b28254c99eb423 -i
7fbc02ebf5b93322329df9bfccb635af -p 48981da18e4bb9ef7e2e3162d16b1910

>
> Any feedback is apreciated.
>
> Thanks!
> Gilad
>
>
>> CC: stable@vger.kernel.org
>> Fixes: 63ee04c8b491 ("crypto: ccree - add skcipher support")
>> Reported by: Hadar Gat <hadar.gat@arm.com>
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>> ---
>>  drivers/crypto/ccree/cc_cipher.c | 30 ++++++++++++++++++++++++------
>>  1 file changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
>> index d2810c1..a07547f 100644
>> --- a/drivers/crypto/ccree/cc_cipher.c
>> +++ b/drivers/crypto/ccree/cc_cipher.c
>> @@ -616,9 +616,18 @@ static void cc_cipher_complete(struct device *dev, void *cc_req, int err)
>>                 memcpy(req->iv, req_ctx->backup_info, ivsize);
>>                 kzfree(req_ctx->backup_info);
>>         } else if (!err) {
>> -               scatterwalk_map_and_copy(req->iv, req->dst,
>> -                                        (req->cryptlen - ivsize),
>> -                                        ivsize, 0);
>> +               unsigned int len;
>> +
>> +               if (req->cryptlen > ivsize) {
>> +                       len = req->cryptlen - ivsize;
>> +               } else {
>> +                       memset(req->iv, 0, ivsize);
>> +                       len = 0;
>> +                       ivsize = req->cryptlen;
>> +
>> +               }
>> +
>> +               scatterwalk_map_and_copy(req->iv, req->dst, len, ivsize, 0);

Copy of last block is required for CBC mode only and CBC input buffer
is always in multiple of 16(Block size).
Above change not required for CBC and will not work with mode like ctr.
>>         }
>>
>>         skcipher_request_complete(req, err);
>> @@ -755,17 +764,26 @@ static int cc_cipher_decrypt(struct skcipher_request *req)
>>         struct cipher_req_ctx *req_ctx = skcipher_request_ctx(req);
>>         unsigned int ivsize = crypto_skcipher_ivsize(sk_tfm);
>>         gfp_t flags = cc_gfp_flags(&req->base);
>> +       unsigned int len;
>>
>>         /*
>>          * Allocate and save the last IV sized bytes of the source, which will
>>          * be lost in case of in-place decryption and might be needed for CTS.
>>          */
>> -       req_ctx->backup_info = kmalloc(ivsize, flags);
>> +       req_ctx->backup_info = kzalloc(ivsize, flags);
>>         if (!req_ctx->backup_info)
>>                 return -ENOMEM;
>>
>> -       scatterwalk_map_and_copy(req_ctx->backup_info, req->src,
>> -                                (req->cryptlen - ivsize), ivsize, 0);
>> +
>> +       if (req->cryptlen > ivsize) {
>> +               len = req->cryptlen - ivsize;
>> +       } else {
>> +               len = 0;
>> +               ivsize = req->cryptlen;
>> +       }
>> +
>> +       scatterwalk_map_and_copy(req_ctx->backup_info, req->src, len, ivsize,
>> +                                0);
>>         req_ctx->is_giv = false;
>>
>>         return cc_cipher_process(req, DRV_CRYPTO_DIRECTION_DECRYPT);
>> --
>> 2.7.4
>>
>
>
>
> --
> Gilad Ben-Yossef
> Chief Coffee Drinker
>
> "If you take a class in large-scale robotics, can you end up in a
> situation where the homework eats your dog?"
>  -- Jean-Baptiste Queru
