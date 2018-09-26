Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482E7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A9E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICsV8uGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A9E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeIZOb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:31:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37184 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeIZOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:31:29 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so22614577iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bywhI0QRBMo8SrhPMTSwkwlpczTVhh3MZgIlE5XvC38=;
        b=ICsV8uGrvVcrGqx/te5QDU6vOgUBkWZ9A5MZY63oK36vlT7HOp2fhhnAPoLSMjKBJN
         xEE7IgB7iEMQKZpoNFtGvbffZF7SJ1yt/CviiCUolfxmTzkhsRP8EJG9YcnGgvHHgMXL
         +bw2MBTsQ2V9ma3uttl2H34OvIwz2Xl1k0b1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bywhI0QRBMo8SrhPMTSwkwlpczTVhh3MZgIlE5XvC38=;
        b=HQsP2k2ag9+anDx4sDrhqvUtf1OtiXOtNCrfAwuvIjy+KVR3+Mfnx+WuM6g2UT+CO6
         umAVTNpAZdXL/TaqfWgYXHWI0e5ackLjd9LNsBco9e0LoE3BpRRvbWP61rn0SEBUPjZ9
         vCDUUEh0M1O3DX8YyOhpewupmV00pOmARfDIYXmfQrQ8NJorh3hCfP5VYv5aEhY9pG26
         g8KwivStMwwREevsIADeZdSilLOfGjZDfd3ui06BxjApAiclIFW3S9Nrrt6Hm+g8N7WQ
         qtEjujd4be8F4Xwucc0ydBiz3IRXnvIx1HyVUCsRUQbflX88UEUVH1WRwMBEZpcMR5WJ
         LkiQ==
X-Gm-Message-State: ABuFfoiSsmlYuNZTGn7TLg34f+4BAg7GwR2/4y7N9CDiM/Sz8c/4Dkak
        I+kgtP8j0HEpyq+fzHvVjKlPIX/ZEkkj7jjL1eBwIw==
X-Google-Smtp-Source: ACcGV6275vfD4wr0l6I40Fw3304+3f3szDdzzGMcBKIKV4O7nzYJd0pY3Ya1Z3rrCwp15z4sx5TbBG8LSPHnns/yUww=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr3975273iob.170.1537949983491;
 Wed, 26 Sep 2018 01:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180919021100.3380-1-keescook@chromium.org> <20180919021100.3380-8-keescook@chromium.org>
 <CAKv+Gu8ynaVi1KCMNsjCU0ucAjFFku=ourh9Yc9Rizoc4ztvOQ@mail.gmail.com>
 <CAGXu5jLw3+nvb9opPeoCyH0MhyVK5UY7H5qeQ2b8GFTUGDGrUQ@mail.gmail.com>
 <CAKv+Gu-xKWsiegZXnsMvmMVgKTo7S2cm4wEqdaL7w9z64X7SAA@mail.gmail.com>
 <9c71afda-a668-10b3-842e-26f72e425691@kernel.dk> <CAKv+Gu_p2UgYMZ5jEUudruUOPYQEF-=VMou=xXbj_rd+-Lxktg@mail.gmail.com>
 <eaf66894-2f85-12ba-f91c-4387437cc8d9@kernel.dk>
In-Reply-To: <eaf66894-2f85-12ba-f91c-4387437cc8d9@kernel.dk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 26 Sep 2018 10:19:30 +0200
Message-ID: <CAKv+Gu8ZNVTBsQQQaFgbXLkRkwm1tKf32+Mo98gv12HhWrFbxg@mail.gmail.com>
Subject: Re: [PATCH crypto-next 07/23] block: cryptoloop: Remove VLA usage of skcipher
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-block@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 at 18:32, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/25/18 10:16 AM, Ard Biesheuvel wrote:
> > On Tue, 25 Sep 2018 at 18:03, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 9/25/18 3:25 AM, Ard Biesheuvel wrote:
> >>> On Mon, 24 Sep 2018 at 19:53, Kees Cook <keescook@chromium.org> wrote:
> >>>>
> >>>> On Mon, Sep 24, 2018 at 4:52 AM, Ard Biesheuvel
> >>>> <ard.biesheuvel@linaro.org> wrote:
> >>>>> On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
> >>>>>> @@ -119,7 +119,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
> >>>>>>         unsigned in_offs, out_offs;
> >>>>>>         int err;
> >>>>>>
> >>>>>> -       skcipher_request_set_tfm(req, tfm);
> >>>>>> +       skcipher_request_set_sync_tfm(req, tfm);
> >>>>>>         skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
> >>>>>>                                       NULL, NULL);
> >>>>>>
> >>>>>
> >>>>> Does this work?
> >>>>
> >>>> Everything is a direct wrapper for existing types and functions, so I
> >>>> wouldn't expect any functional change. I haven't been able to test
> >>>> this particular interface, though. cryptoloop is very deprecated,
> >>>> isn't it?
> >>>>
> >>>
> >>> Ah yes, I managed to confuse myself there. This looks all fine to me.
> >>>
> >>> In any case, this is another example where we may decide to fix the
> >>> code rather than retain the request allocation on the stack (but that
> >>> is Jens's call ultimately, I suppose)
> >>>
> >>> diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
> >>> index 7033a4beda66..5ed2167219ba 100644
> >>> --- a/drivers/block/cryptoloop.c
> >>> +++ b/drivers/block/cryptoloop.c
> >>> @@ -110,7 +110,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
> >>>                     int size, sector_t IV)
> >>>  {
> >>>         struct crypto_skcipher *tfm = lo->key_data;
> >>> -       SKCIPHER_REQUEST_ON_STACK(req, tfm);
> >>> +       struct skcipher_request *req;
> >>>         struct scatterlist sg_out;
> >>>         struct scatterlist sg_in;
> >>>
> >>> @@ -119,7 +119,10 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
> >>>         unsigned in_offs, out_offs;
> >>>         int err;
> >>>
> >>> -       skcipher_request_set_tfm(req, tfm);
> >>> +       req = skcipher_request_alloc(tfm, GFP_NOIO);
> >>> +       if (!req)
> >>> +               return -ENOMEM;
> >>
> >> Is this going to be reliable? ->transfer() is called when we're doing IO,
> >> and you'd normally need a mempool backed allocation to make this safe
> >> and guarantee forward progress.
> >>
> >
> > As far as I can tell, this function is only called from
> > lo_read_transfer/lo_write_transfer, both of which do an unconditional
> > alloc_page(GFP_NOIO), which is why I assumed that kmalloc(GFP_NOIO)
> > would be permissible in the same context. Are you saying this may not
> > be the case?
>
> Doesn't appear to be safe for either your case, nor the page it's
> allocating. If the allocator fails this allocation, then you'll get
> an EIO on that request. The more likely case is the allocator taking
> forever to satisfy the request, in which case you'll have very
> large latencies for IO when you are close to being out of memory.
> The preferred setup for allocating memory for IO is having a mempool
> of at least one item. If you end up blocking for memory, you'll at
> most get to wait for the existing IO that's using that memory to
> complete (per waiter, of course).
>

Ah, great. So the code is already broken to begin with.

In that case, may we have your ack for Kees's original patch, which is
effectively a no-op except for the fact that the size of the stack
buffer is no longer decided at runtime?
