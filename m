Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968063AbeCBQpI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:45:08 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:59318 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966382AbeCBQpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:45:04 -0500
Date: Sat, 3 Mar 2018 00:44:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] crypto: ccp - return an actual key size from RSA
 max_size callback
Message-ID: <20180302164451.GJ21579@gondor.apana.org.au>
References: <51c265e4-6153-3e5e-316a-ebef059ac36a@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c265e4-6153-3e5e-316a-ebef059ac36a@maciej.szmigiero.name>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 05:03:21PM +0100, Maciej S. Szmigiero wrote:
> rsa-pkcs1pad uses a value returned from a RSA implementation max_size
> callback as a size of an input buffer passed to the RSA implementation for
> encrypt and sign operations.
> 
> CCP RSA implementation uses a hardware input buffer which size depends only
> on the current RSA key length, so it should return this key length in
> the max_size callback, too.
> This also matches what the kernel software RSA implementation does.
> 
> Previously, the value returned from this callback was always the maximum
> RSA key size the CCP hardware supports.
> This resulted in this huge buffer being passed by rsa-pkcs1pad to CCP even
> for smaller key sizes and then in a buffer overflow when ccp_run_rsa_cmd()
> tried to copy this large input buffer into a RSA key length-sized hardware
> input buffer.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Fixes: ceeec0afd684 ("crypto: ccp - Add support for RSA on the CCP")
> Cc: stable@vger.kernel.org

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
