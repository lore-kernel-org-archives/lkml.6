Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEDHSz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 03:18:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48835 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeEDHSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 03:18:53 -0400
Date: Fri, 4 May 2018 09:18:41 +0200
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
Message-ID: <20180504071841.GG3324@kwain>
References: <20180502095725.31935-1-antoine.tenart@bootlin.com>
 <20180502095725.31935-2-antoine.tenart@bootlin.com>
 <02ad9eb93c494314a85db69886cf787a@AcuMS.aculab.com>
 <20180503122330.GB3324@kwain>
 <20180503230006.oq6vycplwsomfprw@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180503230006.oq6vycplwsomfprw@gondor.apana.org.au>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Fri, May 04, 2018 at 07:00:06AM +0800, Herbert Xu wrote:
> On Thu, May 03, 2018 at 02:23:30PM +0200, 'Antoine Tenart' wrote:
> >
> > I was expecting this question :) The thing is this define looks *a lot*
> > like the ones defined in other places in the crypto framework, such as
> > SKCIPHER_REQUEST_ON_STACK and AHASH_REQUEST_ON_STACK. Those haven't been
> > tackled down so far by the whole VLA removal so the idea was that the
> > same solution will apply to the 3 of them (and then I'm not really
> > adding a new one).
> 
> Those constructs only exist for reasons of backwards compatibility.
> 
> There is no such reason for AEAD.  So why do you need this?

In this driver we need to perform in certain cases an invalidation,
which is done thanks to invalidation requests. To do this we create
dummy requests, using SKCIPHER_REQUEST_ON_STACK and
AHASH_REQUEST_ON_STACK for ciphers and hashes. So when adding the AEAD
algs support, in patch 8/10, AEAD_REQUEST_ON_STACK is used for the same
reason.

Should we allocate this in a different way?

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
