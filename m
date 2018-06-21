Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FB2C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCF520875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct5O4bE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCF520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbeFUAcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:32:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45615 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFUAce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:32:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id c23-v6so650460plz.12;
        Wed, 20 Jun 2018 17:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WvNoawx1CFWSP21l+HpEFte/tn9EAJUIDuk3zx2XpGU=;
        b=ct5O4bE+ZLe3igMSe+c7fa8wP32YmLnnaakXN+EkkcL0pGTlFQG6j7MBtkqt4zDFs4
         o3q/V9H6GNcpmgXxhvkjThIrVpX3UUwRyT/qRUk9KoJsXPelqLZaGHNVcnpIOknA6vbz
         F27neCy4bnL43OCKF3T1DwabDS/yYmIUI6liQx+LCgiZ1HGwrbMudw2gXnEy9tgGaZQE
         8p5dXAZBk6WbpsHa5jpsfY8N8I3C3pF6RM1BfcAkqJOLSg88+K+OMQmnRJ0cHQY3Fp4x
         fmq8vLPtd0wt3yDUOkt2yfgAAUP3LI6jXE0NzSQ1W9bHL7QsMcd5zag4ZSN9o3jEugg/
         htWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WvNoawx1CFWSP21l+HpEFte/tn9EAJUIDuk3zx2XpGU=;
        b=iwNrEITagrYprqJiJ8v4/AJ8wI+DLzWpe3xt6lKoy/9Qs7/7QbU6fU77Ml3rnLnGE5
         Y3llzc1Ay7+fGBG3LzER/YfNA1LCQeC/yUc9h38pRFc2pHoN5a+E5AmmpmaaQ1u/BxmK
         IRErE5PhdUrj7cOcR3t5sypl8H5yFUzIVo/rcK3hzPgOllQVnZJIfWTsGbDUa9FZnZVM
         IfVsAHABLj5ovayIlU4rBkgYrOM8720KWPFKB9HCot3aT35jWE8FVGLHsOQp3YafmEr0
         AyV6L8Z5aoE2aAw/WEz2neEgEi9U2mIAWF6MU3URfTvvJud1QTQS5LkVhtFTnlfApiNJ
         7lzA==
X-Gm-Message-State: APt69E1EczDQXXm+5R9n/E8D7BK/cRZqXhQsdMR107MRgIsG/MLAWmZW
        /lr0PKq6tsx3tP8azBqXUPU=
X-Google-Smtp-Source: ADUXVKL78sVrNL7/XKHYiBqo76bEwBJOVoi6to6Ow9sPa4TiCM6W8PtVW0fa23XCH3Mth9ZtCtVs3w==
X-Received: by 2002:a17:902:b48f:: with SMTP id y15-v6mr26135920plr.261.1529541153836;
        Wed, 20 Jun 2018 17:32:33 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id c67-v6sm6423662pfj.173.2018.06.20.17.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 17:32:33 -0700 (PDT)
Date:   Wed, 20 Jun 2018 17:32:31 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Kees Cook <keescook@chromium.org>
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
Subject: Re: [dm-devel] [PATCH 05/11] crypto alg: Introduce max blocksize and
 alignmask
Message-ID: <20180621003231.GH111712@gmail.com>
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-6-keescook@chromium.org>
 <20180620234031.GC111712@gmail.com>
 <CAGXu5j++uGCnAOiQd=JM139B6g7oUGTquhgniX-Fwsj8qofU9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j++uGCnAOiQd=JM139B6g7oUGTquhgniX-Fwsj8qofU9w@mail.gmail.com>
User-Agent: Mutt/1.10+28 (db52f11e) (2018-06-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 05:04:08PM -0700, Kees Cook wrote:
> On Wed, Jun 20, 2018 at 4:40 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > On Wed, Jun 20, 2018 at 12:04:02PM -0700, Kees Cook wrote:
> >> In the quest to remove all stack VLA usage from the kernel[1], this
> >> exposes the existing upper bound on crypto block sizes for VLA removal,
> >> and introduces a new check for alignmask (current maximum in the kernel
> >> is 63 from manual inspection of all cra_alignmask settings).
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >>  crypto/algapi.c        | 5 ++++-
> >>  include/linux/crypto.h | 4 ++++
> >>  2 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/crypto/algapi.c b/crypto/algapi.c
> >> index c0755cf4f53f..760a412b059c 100644
> >> --- a/crypto/algapi.c
> >> +++ b/crypto/algapi.c
> >> @@ -57,7 +57,10 @@ static int crypto_check_alg(struct crypto_alg *alg)
> >>       if (alg->cra_alignmask & (alg->cra_alignmask + 1))
> >>               return -EINVAL;
> >>
> >> -     if (alg->cra_blocksize > PAGE_SIZE / 8)
> >> +     if (alg->cra_blocksize > CRYPTO_ALG_MAX_BLOCKSIZE)
> >> +             return -EINVAL;
> >> +
> >> +     if (alg->cra_alignmask > CRYPTO_ALG_MAX_ALIGNMASK)
> >>               return -EINVAL;
> >>
> >>       if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
> >> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> >> index 6eb06101089f..e76ffcbd5aa6 100644
> >> --- a/include/linux/crypto.h
> >> +++ b/include/linux/crypto.h
> >> @@ -134,6 +134,10 @@
> >>   */
> >>  #define CRYPTO_MAX_ALG_NAME          128
> >>
> >> +/* Maximum values for registered algorithms. */
> >> +#define CRYPTO_ALG_MAX_BLOCKSIZE    (PAGE_SIZE / 8)
> >> +#define CRYPTO_ALG_MAX_ALIGNMASK    63
> >> +
> >
> > How do these differ from MAX_CIPHER_BLOCKSIZE and MAX_CIPHER_ALIGNMASK, and why
> > are they declared in different places?
> 
> This is what I get for staring at crypto code for so long. I entirely
> missed these checks... even though they're 8 line away:
> 
>         if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
>                                CRYPTO_ALG_TYPE_CIPHER) {
>                 if (alg->cra_alignmask > MAX_CIPHER_ALIGNMASK)
>                         return -EINVAL;
> 
>                 if (alg->cra_blocksize > MAX_CIPHER_BLOCKSIZE)
>                         return -EINVAL;
>         }
> 
> However, this is only checking CRYPTO_ALG_TYPE_CIPHER, and
> cra_blocksize can be used for all kinds of things.
> 

It's overloaded for different purposes, depending on the type of algorithm.
It's poorly documented, but the uses I see are:

(1) Block size for "ciphers", i.e. what the rest of the world calls "block ciphers".
(2) Minimum input size for "skciphers" -- usually either 1 or the block size of
    the underlying block cipher, in the case that the skcipher is something like
    "cbc(aes)", where a block cipher is wrapped in a mode of operation.
(3) Block size for hash functions that use an internal compression function,
    e.g. SHA-1 has a block size of 64 bytes.

I'm not sure it makes sense to have a single limit for all these uses.  All the
block ciphers supported by Linux have a block size of 16 bytes or less, while
hash functions usually have larger "block sizes".

> include/crypto/algapi.h:#define MAX_CIPHER_ALIGNMASK            15
> ...
> drivers/crypto/mxs-dcp.c:                       .cra_flags
>  = CRYPTO_ALG_ASYNC,
> drivers/crypto/mxs-dcp.c:                       .cra_alignmask          = 63,
> 
> Is this one broken? It has no CRYPTO_ALG_TYPE_... ?
> 
> For my CRYPTO_ALG_MAX_BLOCKSIZE, there is:
> 
> crypto/xcbc.c:  u8 key1[CRYPTO_ALG_MAX_BLOCKSIZE];
> drivers/crypto/qat/qat_common/qat_algs.c:       char
> ipad[CRYPTO_ALG_MAX_BLOCKSIZE];
> drivers/crypto/qat/qat_common/qat_algs.c:       char
> opad[CRYPTO_ALG_MAX_BLOCKSIZE];
> 
> It looks like both xcbc and qat are used with shash, so that needs a
> separate max blocksize.

Actually, xcbc is a 'shash' template (CRYPTO_ALG_TYPE_SHASH) that wraps a block
cipher (CRYPTO_ALG_TYPE_CIPHER) and sets its own cra_blocksize to the block
cipher's block size.  So the same block size can be gotten from either
'crypto_shash_blocksize(parent)' or 'crypto_cipher_blocksize(ctx->child)'.
It can only be 16 bytes, currently, since xcbc_create() only allows
instantiating the template if that's the block size.

But in the case of qat_alg_do_precomputes(), yes it appears to need the hash
block size.

> 
> For my CRYPTO_ALG_MAX_ALIGNMASK, there is:
> 
> crypto/shash.c: u8 ubuf[CRYPTO_ALG_MAX_ALIGNMASK]
> crypto/shash.c:         __aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);
> crypto/shash.c:         __aligned(CRYPTO_ALG_MAX_ALIGNMASK + 1);
> 
> which is also shash.
> 
> How should I rename these and best apply the registration-time sanity checks?

I'm not sure, but it may make sense to enforce a smaller limit for algorithm
types like CRYPTO_ALG_TYPE_CIPHER and maybe even CRYPTO_ALG_TYPE_SHASH that
can't be implemented in a hardware driver, as their APIs are not asynchronous
and don't operate on scatterlists.  Only hardware drivers can need very large
alignmasks like 64 bytes, I believe.

Eric
