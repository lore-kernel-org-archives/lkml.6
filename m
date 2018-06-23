Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D564C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 06:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FFB24B4B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 06:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/zPpqPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FFB24B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeFWGqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 02:46:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40177 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeFWGqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 02:46:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so4464188plo.7;
        Fri, 22 Jun 2018 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ErCszpsvfyCg67s0VV5WFnPK1kQktA5tdKlJyHtUUnc=;
        b=U/zPpqPQ7rArvMt2HO9nALSBvIBkE5peSiYydYk5ElHRK3oQrJuu7bz73EajtvM3rM
         DIqWXGjuk2XR2hNJyFRs69yZTwJRBAWTqF+QQDEx4+nkB4RpAw2pI2O62sFdEG5QxSLQ
         RUDgsshVtxM/ylhgUScKbiRyg6sVMgtVx4rfj9jPXNrrGvhupjcFIX/wTb6C6S55RWkF
         xmcurIEUbC5c6nbjrmqUY+Z61mssZU7lvYBj53NLdHhNFRtfPRYuajKsgQlqe3doK2Cj
         WeCnm8aHWV7Fyz4pnBO8IWtaif/FAIR94HigZWDQVMXcNLoX/t7OozT0pfPMGs9UNc3z
         BTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ErCszpsvfyCg67s0VV5WFnPK1kQktA5tdKlJyHtUUnc=;
        b=WE8oVvsVgX/wdWPbgcmL0Y4YHmb93eoie0KQ4GA2vl7vXVLbAkPfUdYA/osIIJtzMJ
         11LJRrn+cuzucfRq0xL1GLjWr1XBXADIWwIeRxdO1S8+GTV0yr7Gobo6ZA5Kmgi6Suzz
         ObBzKPCP2nqW7Vn5Dfd0ewJKPdLj4/+Roe2CS6vFvmjZq1zKMVqm4SGDXaliI/tRG3bc
         jvL3kB0M4X230ZjIr7T+ALX2IrdSaq6Xd4GEQD9slpcY8P/JBZaK39WgRH2MLkt4ChBJ
         ZmdbbPe83BUpbQQAJMwqReyeRiOC6vPCjU7roGrT8OOYmsLdBCcKzl9nCWRtBWDXDypJ
         f0/Q==
X-Gm-Message-State: APt69E0VYsIfE93ld39NlgCOtV51SyS9GWp2usC2VpwF2GmPjUtGow19
        b9QGg5fjZD5ixU3iYB8Simg=
X-Google-Smtp-Source: ADUXVKIscJujv4EKJHyt/rTmP5e6PRtM6BUIfTb3zPpI3G4hmwyYaLUI8qDECMVfYW+7/RTdmDavEg==
X-Received: by 2002:a17:902:3381:: with SMTP id b1-v6mr4549754plc.248.1529736410243;
        Fri, 22 Jun 2018 23:46:50 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id e68-v6sm17163793pfl.65.2018.06.22.23.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 23:46:49 -0700 (PDT)
Date:   Sat, 23 Jun 2018 15:46:48 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: Re: [RFC PATCH 1/2] crypto: Fix -Wstringop-truncation warnings
Message-ID: <20180623064648.GH24595@lianli.shorne-pla.net>
References: <20180623020753.27266-1-shorne@gmail.com>
 <20180623020753.27266-2-shorne@gmail.com>
 <20180623024149.GB880@sol.localdomain>
 <20180623025256.GG24595@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623025256.GG24595@lianli.shorne-pla.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 11:52:56AM +0900, Stafford Horne wrote:
> On Fri, Jun 22, 2018 at 07:41:49PM -0700, Eric Biggers wrote:
> > On Sat, Jun 23, 2018 at 11:07:52AM +0900, Stafford Horne wrote:
> > > As of GCC 9.0.0 the build is reporting warnings like:
> > > 
[...]
> > >  	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
> > >  	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
> > > -		sizeof(rblkcipher.geniv));
> > > +		sizeof(rblkcipher.geniv) - 1);
> > >  
> > >  	rblkcipher.blocksize = alg->cra_blocksize;
> > >  	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;
> > 
> > Your "fix" introduces an information disclosure bug, as it results in
> > uninitialized memory being copied to userspace.  This same broken patch was sent
> > by someone else too.
> > 
> > Maybe it would be best to just memset() the crypto_report_* structs to 0 after
> > declaration and then replace the strncpy()'s with strscpy()'s, even if just to
> > stop people from sending broken "fixes".  Do you want to do that?
> 
> Right, I didnt realize that we were using strncpy to also init the whole buffer.
> 
> I will do as suggest, and respin.

Hi Eric,

I thought about this a bit, doing memset() and strscpy() seemed fine, but the
below also would work, be a bit faster and stop gcc form complaining.  What do
you think?

@@ -512,6 +512,7 @@ static int crypto_blkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
        strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
        strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
                sizeof(rblkcipher.geniv));
+       rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';

        rblkcipher.blocksize = alg->cra_blocksize;
        rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;

Let me know what you think.

-Stafford
