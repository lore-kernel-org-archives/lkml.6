Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbeBVNqk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:46:40 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:56838 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932414AbeBVNqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:46:39 -0500
Date: Thu, 22 Feb 2018 21:46:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 16/18] crypto: talitos - do hw_context DMA mapping
 outside the requests
Message-ID: <20180222134624.GD28447@gondor.apana.org.au>
References: <2338eb8d-a26a-9722-d667-5a9785b32977@c-s.fr>
 <VI1PR0402MB3342D90D574C8829701882BE98C90@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <630c313c-5eca-224d-a5ac-fb3f2783573a@c-s.fr>
 <VI1PR0402MB334256E1706A4E1AED09F4A598C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <d5809df9-fc17-03da-b7f4-038d973dbd1f@c-s.fr>
 <VI1PR0402MB334299B37F17771BFA9AFDDA98C80@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <20180220103436.GA20571@gondor.apana.org.au>
 <VI1PR0402MB3342B99A1BEA5622F29F79EF98CF0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
 <20180222114741.GA27631@gondor.apana.org.au>
 <AM0PR0402MB3329F899D4777EE356BBE2B698CD0@AM0PR0402MB3329.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR0402MB3329F899D4777EE356BBE2B698CD0@AM0PR0402MB3329.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:29:28PM +0000, Horia Geantă wrote:
>
> IIUC this means that there is no room for improvement.
> This patch needs to be reverted, to restore previous behaviour when the
> hw_context was mapped / unmapped for every request.

In general we should avoid trying to do batching in drivers.  Such
optimisations should instead be done at a higher level.  For example,
for disk encryption we want to do the aggregation at the block layer
rather than the crypto API because that has innate knowledge of the
data layout which we can only guess.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
