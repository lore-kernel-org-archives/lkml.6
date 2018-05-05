Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeEEGTJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 02:19:09 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35134 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeEEGTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 02:19:08 -0400
Date: Sat, 5 May 2018 14:18:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "'Antoine Tenart'" <antoine.tenart@bootlin.com>
Cc: David Laight <David.Laight@aculab.com>,
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
Message-ID: <20180505061855.trmz34gsjfyi5xop@gondor.apana.org.au>
References: <20180502095725.31935-1-antoine.tenart@bootlin.com>
 <20180502095725.31935-2-antoine.tenart@bootlin.com>
 <02ad9eb93c494314a85db69886cf787a@AcuMS.aculab.com>
 <20180503122330.GB3324@kwain>
 <20180503230006.oq6vycplwsomfprw@gondor.apana.org.au>
 <20180504071841.GG3324@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504071841.GG3324@kwain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 09:18:41AM +0200, 'Antoine Tenart' wrote:
>
> In this driver we need to perform in certain cases an invalidation,
> which is done thanks to invalidation requests. To do this we create
> dummy requests, using SKCIPHER_REQUEST_ON_STACK and
> AHASH_REQUEST_ON_STACK for ciphers and hashes. So when adding the AEAD
> algs support, in patch 8/10, AEAD_REQUEST_ON_STACK is used for the same
> reason.
> 
> Should we allocate this in a different way?

These are not uses intended for the ON_STACK macros.  They were
only ever meant for existing users of the synchonous crypto API.

I would suggest either allocating a new request on the spot or if
that is not convenient, pre-allocating it in the cra_init function.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
