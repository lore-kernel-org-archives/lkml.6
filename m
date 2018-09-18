Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBFFECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A290120652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A290120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeIROy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:54:29 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:42126 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbeIROy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:54:28 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g2CDE-0004Hs-K6; Tue, 18 Sep 2018 17:22:28 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g2CD5-0004Z5-JH; Tue, 18 Sep 2018 17:22:19 +0800
Date:   Tue, 18 Sep 2018 17:22:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH][RFC] crypto: skcipher: Remove VLA usage
Message-ID: <20180918092219.kwqb37g6td2xs54f@gondor.apana.org.au>
References: <20180913182328.GA9812@beast>
 <CAGXu5jJdqs4Rf=RvRtzQavT0oAtEEWppmjJRFRhLL4iQfCkVnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJdqs4Rf=RvRtzQavT0oAtEEWppmjJRFRhLL4iQfCkVnQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:30:36PM -0700, Kees Cook wrote:
> On Thu, Sep 13, 2018 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
> > RFC follow-up to https://lkml.kernel.org/r/CAGXu5j+bpLK=EQ9LHkO8V=sdaQwt==6fbGhgn2Vi1E9_WxSGRQ@mail.gmail.com
> >
> > The core API changes:
> >
> >         struct crypto_sync_skcipher
> >         crypto_alloc_sync_skcipher()
> >         crypto_free_sync_skcipher()
> >         crypto_sync_skcipher_setkey()
> >         skcipher_request_set_sync_tfm()
> >         SKCIPHER_REQUEST_ON_STACK type check
> >
> > and a single user's refactoring as an example:
> >
> >         drivers/crypto/ccp/ccp-crypto.h
> >         drivers/crypto/ccp/ccp-crypto-aes-xts.c
> >
> > Does this look correct? If so, I can continue and do the other 60
> > instances of SKCIPHER_REQUEST_ON_STACK().
> 
> Herbert, how does this look? Should I do the other 60 instances? I'd
> really like to get this finished up. :)

Hi Kees:

Yes I like this.  This looks a lot simpler than I thought it would
be.

Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
