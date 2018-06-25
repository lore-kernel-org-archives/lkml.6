Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CEFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DABD25A92
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L74402jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DABD25A92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbeFYNk0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:40:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40080 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755345AbeFYNkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so6465428pfe.7;
        Mon, 25 Jun 2018 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ebccYx03yS2XKmIL6Fqtm0lEKpMG2UJfyXAeajlli9c=;
        b=L74402jpSY8Jr7JzfgUL4Hx2fByoK5dZ3xxcmCNtM7XTmrZe06ZvurOU6WozOYFvuk
         fzXI6cvBQ3pDe7K4rIZpbWq0svkiJlPIXy+Lq9OH+oMXcvoD5TQJsIK90IgzkHamFD6o
         n5KgijnTfn9WCHmGRaSMqS6Xq6UWSyUwwVs0OmNmFhlWN0k26rdr/Lf6MVQObY9XBDe7
         JRx+7E+zdVJR1COLSsV7om9Qk255DiqxLjef2bAEF6hklV2/qBUvEUOgr4sLGy5mxCzs
         q6uS5Eso2azjYC7hX/IMrD1FmAIY3qx7cn4ZQ2sLxNUo23R0Kyy+XXVtphUuSU/KouWx
         UnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ebccYx03yS2XKmIL6Fqtm0lEKpMG2UJfyXAeajlli9c=;
        b=HA9He9odAGGXJ/zJvuxgILX3dzJf6RGNvcPkuK539pOhd06B4td/qChnN3XrRW67Q0
         ps/ICWqRyXnucBBJcXtcEhglUDMLLftg0/vEgOCdVfvJaMYbVbth9V9fbGYMV+c9wkEu
         BaLl/wVHV2RbV2+4S3S2aNz0xiebNCfTMBNJvPGfp9N5oe7xnsDvJkelgLOyhwCPCCb4
         xJJIxiQpUvHbkP0v2QDD9oxbNkvDLZi9OZymOKJy7d+Z841E/jGVIxHw7gVfz7eO2J2N
         nxQiJ+8pk3cQp9FtL9n338KjwJVNp3QAzsM7mpwiOFMZ0NQoLk04VRh2kRXZDwBfJkVz
         gbrQ==
X-Gm-Message-State: APt69E18io83+UZNseMI8KkuQkRVB0SAB2rErZKpqfyh+W1qYnXkWH4G
        Af0Zl96uPLzH/mYiDGZaV5c=
X-Google-Smtp-Source: ADUXVKJW4yQZxdz3/hchvfp4SUIayYH1E2FJO/u5UDWf1N9uphOh1Ffhkm7BIu3veIApHyFz1poR4A==
X-Received: by 2002:a63:7e1a:: with SMTP id z26-v6mr10800562pgc.278.1529934023759;
        Mon, 25 Jun 2018 06:40:23 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id x2-v6sm21380170pfn.11.2018.06.25.06.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 06:40:23 -0700 (PDT)
Date:   Mon, 25 Jun 2018 22:40:21 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-crypto@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/2] crypto: Fix -Wstringop-truncation warnings
Message-ID: <20180625134021.GJ24595@lianli.shorne-pla.net>
References: <20180625124538.21051-1-shorne@gmail.com>
 <20180625124538.21051-2-shorne@gmail.com>
 <2588342c-50da-a75b-3e51-32e3d931644c@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2588342c-50da-a75b-3e51-32e3d931644c@c-s.fr>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 02:59:58PM +0200, Christophe LEROY wrote:
> 
> 
> Le 25/06/2018 à 14:45, Stafford Horne a écrit :
> > As of GCC 9.0.0 the build is reporting warnings like:
> > 
> >      crypto/ablkcipher.c: In function ‘crypto_ablkcipher_report’:
> >      crypto/ablkcipher.c:374:2: warning: ‘strncpy’ specified bound 64 equals destination size [-Wstringop-truncation]
> >        strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
> >        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         sizeof(rblkcipher.geniv));
> >         ~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This means the strnycpy might create a non null terminated string.  Fix this by
> > explicitly performing '\0' termination.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: Eric Biggers <ebiggers3@gmail.com>
> > Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >   crypto/ablkcipher.c | 2 ++
> >   crypto/blkcipher.c  | 1 +
> >   2 files changed, 3 insertions(+)
> > 
> > diff --git a/crypto/ablkcipher.c b/crypto/ablkcipher.c
> > index d880a4897159..1edb5000d783 100644
> > --- a/crypto/ablkcipher.c
> > +++ b/crypto/ablkcipher.c
> > @@ -373,6 +373,7 @@ static int crypto_ablkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
> >   	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
> >   	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
> >   		sizeof(rblkcipher.geniv));
> 
> Is it worth copying something we are going to discard at the following line
> ? Shouldn't you limit the copy to      sizeof(rblkcipher.geniv) - 1   ?

Hi,

I thought about that, I just did it like this as I thought it might be easier to
read and I noticed a few other areas in the kernel that did this way.  After a
closer look I can see we have both patterns, perhaps we need a mcro/helper.

I don't mind either way, I can fix, if the crypto maintainers want to adjust the
patch that would work too.

-Stafford

> > +	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
> >   	rblkcipher.blocksize = alg->cra_blocksize;
> >   	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
> > @@ -447,6 +448,7 @@ static int crypto_givcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
> >   	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
> >   	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
> >   		sizeof(rblkcipher.geniv));
> 
> Same comment here.
> 
> Christophe
> 
> > +	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
> >   	rblkcipher.blocksize = alg->cra_blocksize;
> >   	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
> > diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
> > index 01c0d4aa2563..dd4dcab3766a 100644
> > --- a/crypto/blkcipher.c
> > +++ b/crypto/blkcipher.c
> > @@ -512,6 +512,7 @@ static int crypto_blkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
> >   	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
> >   	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
> >   		sizeof(rblkcipher.geniv));
> > +	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
> >   	rblkcipher.blocksize = alg->cra_blocksize;
> >   	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;
> > 
