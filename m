Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE45C46478
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA4214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWqdsgMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FA4214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbeIYWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:25:06 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38620 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeIYWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:25:06 -0400
Received: by mail-it1-f193.google.com with SMTP id p129-v6so16016330ite.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLVZeUAHGqgE6yT6A7P7eY4TA/lp0eYd+MYLzSjwcSA=;
        b=DWqdsgMrx3XjWYhH2dg7uLYiIuzwWzQzCqesPwRKGxOu1MT4D7z5pDG7owRAirMWi/
         cxH3Vue1CXGA/2AX6+0hvwk/TPeXyF5JjxdUukEhmiVXlXhnIv/abm8cBaBwgkfeqx58
         DdVfX9oYQHtM6WCYhqdpkGhSORKy+1WG2jLRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLVZeUAHGqgE6yT6A7P7eY4TA/lp0eYd+MYLzSjwcSA=;
        b=b5O3FREDn9471cZ9Kb1Uk4jTUF4PjVHGdb3J98syoADlku+Hi9caRthIn0/BX9lNWu
         ciJBtMei0OgRgrSRanhBp42sc+Xjw6HlOnwjRUK+FDxw3Px7CU6psYoBS7UnJ8zWnTii
         WAaxWLmhBAbk9UMLD1warZABIQKwAD5OK22v4Avh9TlfD5RdWMLfALugor+sHRTLFP+a
         lZRBVejL68fTR8nDs/fuisOhD0UbN5Ags5u0hsm3+G/OJ+VrGYpKNOyVcBivOQ9+UZWF
         68aIT7H65tCsrJMQeFgzeDhAKahdSJPoD+f6kg/rWzftszIrOtBqdcSR9aYqF43AzwnE
         55Vg==
X-Gm-Message-State: ABuFfoiSNXamNFH5Dzqjw+VO5XFtSMo/Sxt3cOT1+gTTYnmhZDrnQNWE
        MZ7xR+lTZ3N0VpP7ycU5cgBasSOJG2+o5HpdLmsVtQ==
X-Google-Smtp-Source: ACcGV60D9qFMYzjQ8EHuhmBh1eL2zGqvluaU/+WxisYAn/kYhcmk5Ho4pW/76mEMpk4gggAHoLH5lhOJknHChfSGGAw=
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr1417882ita.148.1537892212582;
 Tue, 25 Sep 2018 09:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180919021100.3380-1-keescook@chromium.org> <20180919021100.3380-8-keescook@chromium.org>
 <CAKv+Gu8ynaVi1KCMNsjCU0ucAjFFku=ourh9Yc9Rizoc4ztvOQ@mail.gmail.com>
 <CAGXu5jLw3+nvb9opPeoCyH0MhyVK5UY7H5qeQ2b8GFTUGDGrUQ@mail.gmail.com>
 <CAKv+Gu-xKWsiegZXnsMvmMVgKTo7S2cm4wEqdaL7w9z64X7SAA@mail.gmail.com> <9c71afda-a668-10b3-842e-26f72e425691@kernel.dk>
In-Reply-To: <9c71afda-a668-10b3-842e-26f72e425691@kernel.dk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Sep 2018 18:16:39 +0200
Message-ID: <CAKv+Gu_p2UgYMZ5jEUudruUOPYQEF-=VMou=xXbj_rd+-Lxktg@mail.gmail.com>
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

On Tue, 25 Sep 2018 at 18:03, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/25/18 3:25 AM, Ard Biesheuvel wrote:
> > On Mon, 24 Sep 2018 at 19:53, Kees Cook <keescook@chromium.org> wrote:
> >>
> >> On Mon, Sep 24, 2018 at 4:52 AM, Ard Biesheuvel
> >> <ard.biesheuvel@linaro.org> wrote:
> >>> On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
> >>>> @@ -119,7 +119,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
> >>>>         unsigned in_offs, out_offs;
> >>>>         int err;
> >>>>
> >>>> -       skcipher_request_set_tfm(req, tfm);
> >>>> +       skcipher_request_set_sync_tfm(req, tfm);
> >>>>         skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
> >>>>                                       NULL, NULL);
> >>>>
> >>>
> >>> Does this work?
> >>
> >> Everything is a direct wrapper for existing types and functions, so I
> >> wouldn't expect any functional change. I haven't been able to test
> >> this particular interface, though. cryptoloop is very deprecated,
> >> isn't it?
> >>
> >
> > Ah yes, I managed to confuse myself there. This looks all fine to me.
> >
> > In any case, this is another example where we may decide to fix the
> > code rather than retain the request allocation on the stack (but that
> > is Jens's call ultimately, I suppose)
> >
> > diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
> > index 7033a4beda66..5ed2167219ba 100644
> > --- a/drivers/block/cryptoloop.c
> > +++ b/drivers/block/cryptoloop.c
> > @@ -110,7 +110,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
> >                     int size, sector_t IV)
> >  {
> >         struct crypto_skcipher *tfm = lo->key_data;
> > -       SKCIPHER_REQUEST_ON_STACK(req, tfm);
> > +       struct skcipher_request *req;
> >         struct scatterlist sg_out;
> >         struct scatterlist sg_in;
> >
> > @@ -119,7 +119,10 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
> >         unsigned in_offs, out_offs;
> >         int err;
> >
> > -       skcipher_request_set_tfm(req, tfm);
> > +       req = skcipher_request_alloc(tfm, GFP_NOIO);
> > +       if (!req)
> > +               return -ENOMEM;
>
> Is this going to be reliable? ->transfer() is called when we're doing IO,
> and you'd normally need a mempool backed allocation to make this safe
> and guarantee forward progress.
>

As far as I can tell, this function is only called from
lo_read_transfer/lo_write_transfer, both of which do an unconditional
alloc_page(GFP_NOIO), which is why I assumed that kmalloc(GFP_NOIO)
would be permissible in the same context. Are you saying this may not
be the case?
