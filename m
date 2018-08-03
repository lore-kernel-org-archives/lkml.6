Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095EFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D3920841
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="VcsdiQwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D3920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeHCPkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:40:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40352 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbeHCPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:40:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so6513153wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cfg4xVdQDI8FPO0I8Lzj1V50g+B0pJtjRGqctpfKnqs=;
        b=VcsdiQwk2cyowURzirghiBjJW9SuyNzOmpm4ccZWJlNoprgxsovOyPPKVIuM2oQZoc
         su1+41gXSMiBRIJektLH6m8qtLwqzjWEBULBQrY1gnIhIZfrRn9P/xcdkpSe5UN53gEC
         LLh++6GJ2GzU4hPSQiDCLA90UIuHMtV35KR0ahMYiQHeyAfPy6jpAVdZH2H0aHUU/Zrz
         UyAclGwBCoGVkiD+2Tey2Jn7hnHFEOfys0MDCo2emlQmQNtOYC98y1/CwICx0KKZXHVx
         hDg/RxuXYyshaPGNqrOV3mvrp4ou5dA55SDy0vN/oKuz/dtsGA3vOY/bDyxR6fpfJ46V
         B5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cfg4xVdQDI8FPO0I8Lzj1V50g+B0pJtjRGqctpfKnqs=;
        b=MruRizxYdLSqEOujlhZWCyV0wW7HOUvgWZbhg3tmNCtoJhiw8OYosr1la+XUtUenQH
         Sd+cP1PwPNnGXp8yb06FMgP77WEKei/kC+tcIWVy77o95R+9zty3wm8dR1UNjAVldWSp
         Ad43RxPP8QJwZidS2dmMuv9VDRqHAAJhqxXayMvp2HmDV2/c0notqQ29cEMdiSeGbnKx
         Rsl8il3MeAYDotfWtvdifwpXt8Ul4oUMQ5UnfLpgsBQVVQa7wicbY4wVKQMImMxwRlrn
         v6VS2ZYjLq692i8Oyd2C3yc5TDNeXdANeep8w4Y8HikdlWUPmrTXxDjlrmD2Tw9OOB79
         PGtw==
X-Gm-Message-State: AOUpUlHDjR1AtrTFJmCkDahGwF6/aalfgjgET3wJ0mYBzUc40dKMp08b
        qNwwi9SIgJS2Ay7uLj2GaDgiCg==
X-Google-Smtp-Source: AAOMgpcvz0MHB2df6SMaSwEzxNb5Mo3ijsix56clg9voSWu+0kNU5Zsa2KL8Qct5a0s3UThUOVZkdw==
X-Received: by 2002:a1c:1748:: with SMTP id 69-v6mr4907704wmx.75.1533303851327;
        Fri, 03 Aug 2018 06:44:11 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id a84-v6sm5225997wmh.27.2018.08.03.06.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 06:44:10 -0700 (PDT)
Date:   Fri, 3 Aug 2018 15:44:09 +0200
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 12/18] drbd: Convert from ahash to shash
Message-ID: <20180803134357.GB28982@soda.linbit>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180724164936.37477-1-keescook@chromium.org>
 <20180724164936.37477-13-keescook@chromium.org>
 <CAGXu5jJB6V0r8LXOGL6+sO0NVZ0HK3VCthML=T3gLEwMABhSDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJB6V0r8LXOGL6+sO0NVZ0HK3VCthML=T3gLEwMABhSDQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:43:19PM -0700, Kees Cook wrote:
> On Tue, Jul 24, 2018 at 9:49 AM, Kees Cook <keescook@chromium.org> wrote:
> > In preparing to remove all stack VLA usage from the kernel[1], this
> > removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
> > the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
> > to direct shash. By removing a layer of indirection this both improves
> > performance and reduces stack usage. The stack allocation will be made
> > a fixed size in a later patch to the crypto subsystem.
> 
> Philipp or Lars, what do you think of this? Can this go via your tree
> or maybe via Jens?
> 
> I'd love an Ack or Review.

I'm sorry, summer time and all, limited online time ;-)

I'm happy for this to go in via Jens, or any other way.

Being not that fluent in the crypto stuff,
I will just "believe" most of it.

I still think I found something, comments below:

> > diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
> > index 1476cb3439f4..62dd3700dd84 100644
> > --- a/drivers/block/drbd/drbd_worker.c
> > +++ b/drivers/block/drbd/drbd_worker.c
> > @@ -295,60 +295,54 @@ void drbd_request_endio(struct bio *bio)
> >                 complete_master_bio(device, &m);
> >  }
> >
> > -void drbd_csum_ee(struct crypto_ahash *tfm, struct drbd_peer_request *peer_req, void *digest)
> > +void drbd_csum_ee(struct crypto_shash *tfm, struct drbd_peer_request *peer_req, void *digest)
> >  {
> > -       AHASH_REQUEST_ON_STACK(req, tfm);
> > -       struct scatterlist sg;
> > +       SHASH_DESC_ON_STACK(desc, tfm);
> >         struct page *page = peer_req->pages;
> >         struct page *tmp;
> >         unsigned len;
> >
> > -       ahash_request_set_tfm(req, tfm);
> > -       ahash_request_set_callback(req, 0, NULL, NULL);
> > +       desc->tfm = tfm;
> > +       desc->flags = 0;
> >
> > -       sg_init_table(&sg, 1);
> > -       crypto_ahash_init(req);
> > +       crypto_shash_init(desc);
> >
> >         while ((tmp = page_chain_next(page))) {
> >                 /* all but the last page will be fully used */
> > -               sg_set_page(&sg, page, PAGE_SIZE, 0);
> > -               ahash_request_set_crypt(req, &sg, NULL, sg.length);
> > -               crypto_ahash_update(req);
> > +               crypto_shash_update(desc, page_to_virt(page), PAGE_SIZE);

These pages may be "highmem", so page_to_virt() seem not appropriate.
I think the crypto_ahash_update() thingy did an implicit kmap() for us
in the crypto_hash_walk()?
Maybe it is good enough to add a kmap() here,
and a kunmap() on the next line?


> >                 page = tmp;
> >         }
> >         /* and now the last, possibly only partially used page */
> >         len = peer_req->i.size & (PAGE_SIZE - 1);
> > -       sg_set_page(&sg, page, len ?: PAGE_SIZE, 0);
> > -       ahash_request_set_crypt(req, &sg, digest, sg.length);
> > -       crypto_ahash_finup(req);
> > -       ahash_request_zero(req);
> > +       crypto_shash_update(desc, page_to_virt(page), len ?: PAGE_SIZE);

Same here ...

> > +
> > +       crypto_shash_final(desc, digest);
> > +       shash_desc_zero(desc);
> >  }
> >
> > -void drbd_csum_bio(struct crypto_ahash *tfm, struct bio *bio, void *digest)
> > +void drbd_csum_bio(struct crypto_shash *tfm, struct bio *bio, void *digest)
> >  {
> > -       AHASH_REQUEST_ON_STACK(req, tfm);
> > -       struct scatterlist sg;
> > +       SHASH_DESC_ON_STACK(desc, tfm);
> >         struct bio_vec bvec;
> >         struct bvec_iter iter;
> >
> > -       ahash_request_set_tfm(req, tfm);
> > -       ahash_request_set_callback(req, 0, NULL, NULL);
> > +       desc->tfm = tfm;
> > +       desc->flags = 0;
> >
> > -       sg_init_table(&sg, 1);
> > -       crypto_ahash_init(req);
> > +       crypto_shash_init(desc);
> >
> >         bio_for_each_segment(bvec, bio, iter) {
> > -               sg_set_page(&sg, bvec.bv_page, bvec.bv_len, bvec.bv_offset);
> > -               ahash_request_set_crypt(req, &sg, NULL, sg.length);
> > -               crypto_ahash_update(req);
> > +               crypto_shash_update(desc, (u8 *)page_to_virt(bvec.bv_page) +
> > +                                         bvec.bv_offset,
> > +                                   bvec.bv_len);


... and here.


> > +
> >                 /* REQ_OP_WRITE_SAME has only one segment,
> >                  * checksum the payload only once. */
> >                 if (bio_op(bio) == REQ_OP_WRITE_SAME)
> >                         break;
> >         }
> > -       ahash_request_set_crypt(req, NULL, digest, 0);
> > -       crypto_ahash_final(req);
> > -       ahash_request_zero(req);
> > +       crypto_shash_final(desc, digest);
> > +       shash_desc_zero(desc);
> >  }
> >
> >  /* MAYBE merge common code with w_e_end_ov_req */

Thanks,

    Lars

