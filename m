Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEERRu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 13:17:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55562 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbeEERRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 13:17:47 -0400
Date: Sat, 5 May 2018 19:17:34 +0200
From: "'Antoine Tenart'" <antoine.tenart@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "'Antoine Tenart'" <antoine.tenart@bootlin.com>,
        David Laight <David.Laight@aculab.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        "oferh@marvell.com" <oferh@marvell.com>,
        "igall@marvell.com" <igall@marvell.com>
Subject: Re: [PATCH 01/10] crypto: aead - allow to allocate AEAD requests on
 the stack
Message-ID: <20180505171734.GA2655@kwain>
References: <20180502095725.31935-1-antoine.tenart@bootlin.com>
 <20180502095725.31935-2-antoine.tenart@bootlin.com>
 <02ad9eb93c494314a85db69886cf787a@AcuMS.aculab.com>
 <20180503122330.GB3324@kwain>
 <20180503230006.oq6vycplwsomfprw@gondor.apana.org.au>
 <20180504071841.GG3324@kwain>
 <20180505061855.trmz34gsjfyi5xop@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180505061855.trmz34gsjfyi5xop@gondor.apana.org.au>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Sat, May 05, 2018 at 02:18:55PM +0800, Herbert Xu wrote:
> On Fri, May 04, 2018 at 09:18:41AM +0200, 'Antoine Tenart' wrote:
> >
> > In this driver we need to perform in certain cases an invalidation,
> > which is done thanks to invalidation requests. To do this we create
> > dummy requests, using SKCIPHER_REQUEST_ON_STACK and
> > AHASH_REQUEST_ON_STACK for ciphers and hashes. So when adding the AEAD
> > algs support, in patch 8/10, AEAD_REQUEST_ON_STACK is used for the same
> > reason.
> > 
> > Should we allocate this in a different way?
> 
> These are not uses intended for the ON_STACK macros.  They were
> only ever meant for existing users of the synchonous crypto API.

OK, I see.

> I would suggest either allocating a new request on the spot or if
> that is not convenient, pre-allocating it in the cra_init function.

Or we could have similar macros in the driver: we wouldn't have VLAs
since it would be driver specific.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
