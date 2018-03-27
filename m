Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeC0KHX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:07:23 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45230 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0KHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:07:22 -0400
Date: Tue, 27 Mar 2018 18:07:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] SHASH_DESC_ON_STACK macro
Message-ID: <20180327100709.GA12961@gondor.apana.org.au>
References: <f662fa16-2cbb-a484-4efb-68bb3b39a792@embeddedor.com>
 <bda66faa-f52d-215d-f21b-763593b30f91@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda66faa-f52d-215d-f21b-763593b30f91@embeddedor.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 02:09:46PM -0500, Gustavo A. R. Silva wrote:
> 
> Hi Herbert,
> 
> There is an ongoing effort to remove all VLAs from the code base [1] and
> while working on that I came across the following macro at
> include/crypto/hash.h:154:
> 
> #define SHASH_DESC_ON_STACK(shash, ctx)                           \
>         char __##shash##_desc[sizeof(struct shash_desc) +         \
>                 crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
>         struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
> 
> 
> Currently, this macro is being used in 46 different places.
> 
> I wonder how big can tfm->descsize can get?

descsize is capped at PAGE_SIZE / 8.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
