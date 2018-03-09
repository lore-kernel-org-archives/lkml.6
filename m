Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeCIPSL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:18:11 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:60910 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932068AbeCIPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:18:09 -0500
Date: Fri, 9 Mar 2018 23:17:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
        Horia Geanta <horia.geanta@nxp.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  1/2] crypto: talitos - don't persistently map
 req_ctx->hw_context and req_ctx->buf
Message-ID: <20180309151751.GC13567@gondor.apana.org.au>
References: <7c934f0788d60bd82fb1cb51d712c9ab1ea7fcb4.1519660621.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c934f0788d60bd82fb1cb51d712c9ab1ea7fcb4.1519660621.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 05:40:04PM +0100, Christophe Leroy wrote:
> Commit 49f9783b0cea ("crypto: talitos - do hw_context DMA mapping
> outside the requests") introduced a persistent dma mapping of
> req_ctx->hw_context
> Commit 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash
> on SEC1") introduced a persistent dma mapping of req_ctx->buf
> 
> As there is no destructor for req_ctx (the request context), the
> associated dma handlers where set in ctx (the tfm context). This is
> wrong as several hash operations can run with the same ctx.
> 
> This patch removes this persistent mapping.
> 
> Reported-by: Horia Geanta <horia.geanta@nxp.com>
> Fixes: 49f9783b0cea ("crypto: talitos - do hw_context DMA mapping outside the requests")
> Fixes: 37b5e8897eb5 ("crypto: talitos - chain in buffered data for ahash on SEC1")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
