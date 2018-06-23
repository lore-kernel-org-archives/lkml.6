Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CED6C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0B124AEE
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeyqy7S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0B124AEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934744AbeFWCxA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:53:00 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38276 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934670AbeFWCw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:52:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so4296157plo.5;
        Fri, 22 Jun 2018 19:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7eZrPgFfwxoWfZv2jnLxj6SQZarworewTlEBrtzBCrQ=;
        b=qeyqy7S08PTM1CiGMRdDbDoVFMCpa3Ap+F3rZybGBZHGuD/Ki/Rd0GczjeoFArEkia
         FJHx9UmjIaQAYMaoSav76q/QMhYpxldwHHqzHifSgyZnwO/MUjfkrlIt+AFh/cys4w9g
         tUZKnF9vXIYK2RgZq58589Bcg+RleY934XiyChnZ4sbpiIFtesqgE6Q2yU+lbPZra5Qy
         i+Jrczr13Kr6HUTHcbq/jixkr434dtbXKMZ44tNf0b3SWVfosPWMIrdJzwvU1LK6WzVB
         o+ZSFfXyGFyzaBXkEUgRP5JKJ2SwpUXwmJyjU1ezhZ0/U4W4GM25I54ZRv9scmt/sYoI
         ONPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7eZrPgFfwxoWfZv2jnLxj6SQZarworewTlEBrtzBCrQ=;
        b=B9LZc6ZBvucK1uT5i8M5QcMWSqr72KKt3triSc3woOGOnB4WaTt0uvg3BTyxowEXkl
         GIcjsNXLHsPgfJwxqfRlN2FNn7bv7FR5QG+/U5KCaYJSbMor7Kz7PKwrVjSCNpzApEQZ
         0H8DyYCsb9V5BOaOabETAqvjdgOq9QfMpoBdM50apq2ldum5KHRRmx+ylxjsngHCd4el
         4TsGk29xt1pdxLpy8TjDseJSS5gExOgDAa5Cr6v3bNypaL0unjRBTLVWoJaXLR9Ir5y4
         mueyQBhLMVNWRY/XLNCS4JrRu0JIsjDB51onTD9uFAYKyaYEZB6qoSIo9T0fySGfH9dg
         rvsg==
X-Gm-Message-State: APt69E2ugbniq8dMrQPWCh0p3EohYz55vE9htbURzPbc+5N4g6f9I84u
        076rrA6ia/qH16D1dHZ282s=
X-Google-Smtp-Source: ADUXVKK0efBNaEZ/Cho9C8BEU2EuRCCYZguhbeneXmtz86efaTlmJZ6lV1snJ5mEB2yQGyZ+GM2xLw==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4-v6mr3911378plt.19.1529722378464;
        Fri, 22 Jun 2018 19:52:58 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id c4-v6sm18427257pfe.53.2018.06.22.19.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 19:52:58 -0700 (PDT)
Date:   Sat, 23 Jun 2018 11:52:56 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: [RFC PATCH 1/2] crypto: Fix -Wstringop-truncation warnings
Message-ID: <20180623025256.GG24595@lianli.shorne-pla.net>
References: <20180623020753.27266-1-shorne@gmail.com>
 <20180623020753.27266-2-shorne@gmail.com>
 <20180623024149.GB880@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180623024149.GB880@sol.localdomain>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 07:41:49PM -0700, Eric Biggers wrote:
> On Sat, Jun 23, 2018 at 11:07:52AM +0900, Stafford Horne wrote:
> > As of GCC 9.0.0 the build is reporting warnings like:
> > 
> >     crypto/ablkcipher.c: In function ‘crypto_ablkcipher_report’:
> >     crypto/ablkcipher.c:374:2: warning: ‘strncpy’ specified bound 64 equals destination size [-Wstringop-truncation]
> >       strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
> >       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >        sizeof(rblkcipher.geniv));
> >        ~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > This means the strnycpy might create a non null terminated string.  Fix this by
> > limiting the size of the string copy to include the null terminator.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  crypto/ablkcipher.c | 4 ++--
> >  crypto/blkcipher.c  | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/crypto/ablkcipher.c b/crypto/ablkcipher.c
> > index d880a4897159..972cd7c879f6 100644
> > --- a/crypto/ablkcipher.c
> > +++ b/crypto/ablkcipher.c
> > @@ -372,7 +372,7 @@ static int crypto_ablkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
> >  	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
> > -		sizeof(rblkcipher.geniv));
> > +		sizeof(rblkcipher.geniv) - 1);
> >  
> >  	rblkcipher.blocksize = alg->cra_blocksize;
> >  	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
> > @@ -446,7 +446,7 @@ static int crypto_givcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
> >  	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
> > -		sizeof(rblkcipher.geniv));
> > +		sizeof(rblkcipher.geniv) - 1);
> >  
> >  	rblkcipher.blocksize = alg->cra_blocksize;
> >  	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
> > diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
> > index 01c0d4aa2563..f1644b5cf68c 100644
> > --- a/crypto/blkcipher.c
> > +++ b/crypto/blkcipher.c
> > @@ -511,7 +511,7 @@ static int crypto_blkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
> >  
> >  	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
> >  	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
> > -		sizeof(rblkcipher.geniv));
> > +		sizeof(rblkcipher.geniv) - 1);
> >  
> >  	rblkcipher.blocksize = alg->cra_blocksize;
> >  	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;
> 
> Your "fix" introduces an information disclosure bug, as it results in
> uninitialized memory being copied to userspace.  This same broken patch was sent
> by someone else too.
> 
> Maybe it would be best to just memset() the crypto_report_* structs to 0 after
> declaration and then replace the strncpy()'s with strscpy()'s, even if just to
> stop people from sending broken "fixes".  Do you want to do that?

Right, I didnt realize that we were using strncpy to also init the whole buffer.

I will do as suggest, and respic.

-Stafford
