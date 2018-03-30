Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeC3RlH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:41:07 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:51532 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeC3RlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:41:01 -0400
Date: Sat, 31 Mar 2018 01:40:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: Re: [PATCH v2 0/9] crypto: inside-secure - hmac(sha256/sha224)
 support
Message-ID: <20180330174050.GD28120@gondor.apana.org.au>
References: <20180319082121.32103-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319082121.32103-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 09:21:12AM +0100, Antoine Tenart wrote:
> Hi Herbert,
> 
> This series brings hmac(sha256) and hmac(sha224) support to the Inside
> Secure cryptographic engine driver.
> 
> The first 7 patches are fixes and reworks needed for the hmac(sha256)
> and hmac(224) support to land in. Then 2 patches adds the 2 new
> algorithms.
> 
> This has been tested with boot tests, tcrypt and IPsec traffic. This
> series is a preparation series for more algorithms support (so that
> the series are smaller and easier to review).
> 
> Thanks,
> Antoine
> 
> Since v1:
>   - Fixed a kbuild reported compilation issue.
>   - Added missing commit messages in the last 2 patches.
>   - Removed 3 patches from the series that already were applied in
>     the cryptodev tree.
> 
> Antoine Tenart (9):
>   crypto: inside-secure - move the digest to the request context
>   crypto: inside-secure - fix typo s/allways/always/ in a define
>   crypto: inside-secure - fix a typo in a register name
>   crypto: inside-secure - improve the send error path
>   crypto: inside-secure - do not access buffers mapped to the device
>   crypto: inside-secure - improve the skcipher token
>   crypto: inside-secure - the context ipad/opad should use the state sz
>   crypto: inside-secure - hmac(sha256) support
>   crypto: inside-secure - hmac(sha224) support
> 
>  drivers/crypto/inside-secure/safexcel.c        |   8 +-
>  drivers/crypto/inside-secure/safexcel.h        |   6 +-
>  drivers/crypto/inside-secure/safexcel_cipher.c |   3 +-
>  drivers/crypto/inside-secure/safexcel_hash.c   | 189 +++++++++++++++++++++----
>  4 files changed, 170 insertions(+), 36 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
