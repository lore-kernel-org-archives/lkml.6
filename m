Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0395FECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9998420647
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js6tEsAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9998420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbeGQXrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:47:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45196 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbeGQXrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:47:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so1077072pgq.12;
        Tue, 17 Jul 2018 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QJRAvN4N6MElqlv6d187PoU1FqhmqL9vB9z1kpQaT98=;
        b=Js6tEsAPJ+Z05AZv63giOf1fDEKuKAAaRxQtUuA+3nR9KGv8NWcvB6UaNGxAEgE8l+
         KVRNFG9BMmM7iqq7U5g1jxgh6dLtDI68oWBRxotVMh0040+mPYq7C3pSu3OWbD1KY14a
         7D3l9rtaHf0q59Gv4KHKB1auFck+sopYjcOZty2wsrMKiQVu2hmpvviHZ6kXWLaOUkSt
         z7NAoHzrvJA3bvEL54SXjTCZnlpGUBReWTCxk/GIXZspLNDp4LFb8kz42P6Wzo9gKl3v
         WlKXAhE9q2meKMhGASoS8elDJ1ddsyAxF3vTNjOIuCknmztK10BaMYVMeq2sTDjGMUhQ
         CkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJRAvN4N6MElqlv6d187PoU1FqhmqL9vB9z1kpQaT98=;
        b=gDkiWC7FjVqGuBKqBjPEUQVGPEkFfSXGrNIvLF0s0xFsFCuD8T0zOB3OoV7mzc3YNr
         2XQqU/uUYEq7vdfT9UwpSmWEcNLMYoha5+xbPE9UZLCQFksYWNy7mtNLxzQrNFK/LAgt
         sVTUOi0FkbSC3OXrYRvzHPnz35ZNsMSiHSlj5JKZhMeQ1As36Tw0+xduegWqg7T7D7ji
         p9bWnXMlTY2425m0Mw8O+0ljAgETa3aw1LvBZlRw3HILJcKPio/bZasQ3c0ZI2MPAcI4
         4jT1Cq8Zz8K8bONUI0LrtAaEIqKgcyKA3vBhzPmHeGtcNReEaMZVlrnVEZzIsTLSxy3C
         JLKQ==
X-Gm-Message-State: AOUpUlHQVjS+qyJG47coSuaTN21vG+kW97YUP0eZeOth3kKA5WMk0XFl
        DGhozVSi2lqmQAtKmz5ZUUE=
X-Google-Smtp-Source: AAOMgpdhsonyt6mdjSWEGAl53zuXNqgOyYOCb5mseXcL9xCJ7P2AAWhr6QGgsafDGDaYRVHcbtueOQ==
X-Received: by 2002:a62:2983:: with SMTP id p125-v6mr2684913pfp.128.1531869132199;
        Tue, 17 Jul 2018 16:12:12 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id y27-v6sm3412190pff.181.2018.07.17.16.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 16:12:11 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:12:09 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Kees Cook <keescook@chromium.org>
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
Subject: Re: [dm-devel] [PATCH v5 05/11] crypto: ahash: Remove VLA usage
Message-ID: <20180717231209.GJ75957@gmail.com>
References: <20180717042150.37761-1-keescook@chromium.org>
 <20180717042150.37761-6-keescook@chromium.org>
 <20180717163936.GB75957@gmail.com>
 <CAGXu5jKKD4hzeFEdvY5QdahEr4POd9ZM_B_5Z_iU-Qmx3AYSfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKKD4hzeFEdvY5QdahEr4POd9ZM_B_5Z_iU-Qmx3AYSfQ@mail.gmail.com>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:07:50PM -0700, Kees Cook wrote:
> On Tue, Jul 17, 2018 at 9:39 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > On Mon, Jul 16, 2018 at 09:21:44PM -0700, Kees Cook wrote:
> >> In the quest to remove all stack VLA usage from the kernel[1], this
> >> introduces max size macros for ahash, as already done for shash, and
> >> adjust the crypto user to max state size.
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >>  crypto/ahash.c        | 4 ++--
> >>  crypto/algif_hash.c   | 2 +-
> >>  include/crypto/hash.h | 3 +++
> >>  3 files changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/crypto/ahash.c b/crypto/ahash.c
> >> index a64c143165b1..6435bdbe42fd 100644
> >> --- a/crypto/ahash.c
> >> +++ b/crypto/ahash.c
> >> @@ -550,8 +550,8 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
> >>  {
> >>       struct crypto_alg *base = &alg->halg.base;
> >>
> >> -     if (alg->halg.digestsize > PAGE_SIZE / 8 ||
> >> -         alg->halg.statesize > PAGE_SIZE / 8 ||
> >> +     if (alg->halg.digestsize > AHASH_MAX_DIGESTSIZE ||
> >> +         alg->halg.statesize > AHASH_MAX_STATESIZE ||
> >>           alg->halg.statesize == 0)
> >>               return -EINVAL;
> >>
> >> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> >> index bfcf595fd8f9..8974ee8ebead 100644
> >> --- a/crypto/algif_hash.c
> >> +++ b/crypto/algif_hash.c
> >> @@ -239,7 +239,7 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
> >>       struct alg_sock *ask = alg_sk(sk);
> >>       struct hash_ctx *ctx = ask->private;
> >>       struct ahash_request *req = &ctx->req;
> >> -     char state[crypto_ahash_statesize(crypto_ahash_reqtfm(req)) ? : 1];
> >> +     char state[AHASH_MAX_STATESIZE];
> >>       struct sock *sk2;
> >>       struct alg_sock *ask2;
> >>       struct hash_ctx *ctx2;
> >> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> >> index ae14cc0e0cdb..4fcd0e2368cd 100644
> >> --- a/include/crypto/hash.h
> >> +++ b/include/crypto/hash.h
> >> @@ -64,6 +64,9 @@ struct ahash_request {
> >>       void *__ctx[] CRYPTO_MINALIGN_ATTR;
> >>  };
> >>
> >> +#define AHASH_MAX_DIGESTSIZE 512
> >> +#define AHASH_MAX_STATESIZE  512
> >> +
> >
> > Why is AHASH_MAX_DIGESTSIZE (512) so much larger than SHASH_MAX_DIGESTSIZE (64)?
> > I would have expected them to be the same.
> 
> This was a direct replacement of the PAGE_SIZE / 8 original limit.
> This this didn't trip any frame size warnings, it seemed like we
> didn't need to do the more narrow limitations done elsewhere.
> 
> I am, of course, happy to do a manual review and find a lower
> alternative if that's desired.
> 

I just don't see why ahash algorithms would need such a huge maximum digest
size.  Don't the 'ahash' algorithms all have 'shash' equivalents too?  Is there
actually any hash algorithm, either shash or ahash, in the Linux kernel that has
a digest size greater than 64 bytes (512 bits)?  Note that for a real
cryptographic hash there isn't really any need for a digest size larger than
that, since that already gives you 256-bit collision resistance; that's why
SHA-2 and SHA-3 max out at that size.

- Eric
