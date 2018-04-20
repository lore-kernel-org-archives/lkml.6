Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeDTQwe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:52:34 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34410 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753067AbeDTQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:52:31 -0400
Date: Sat, 21 Apr 2018 00:52:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jan Glauber <jglauber@cavium.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mahipal Challa <mchalla@cavium.com>,
        Balakrishna Bhamidipati <bbhamidipati@cavium.com>
Subject: Re: [PATCH] crypto: testmgr: Allow different compression results
Message-ID: <20180420165227.wb2hsckedgkauxz4@gondor.apana.org.au>
References: <20180411182832.27761-1-jglauber@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411182832.27761-1-jglauber@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 08:28:32PM +0200, Jan Glauber wrote:
> From: Mahipal Challa <mchalla@cavium.com>
> 
> The following error is triggered by the ThunderX ZIP driver
> if the testmanager is enabled:
> 
> [  199.069437] ThunderX-ZIP 0000:03:00.0: Found ZIP device 0 177d:a01a on Node 0
> [  199.073573] alg: comp: Compression test 1 failed for deflate-generic: output len = 37
> 
> The reason for this error is the verification of the compression
> results. Verifying the compression result only works if all
> algorithm parameters are identical, in this case to the software
> implementation.
> 
> Different compression engines like the ThunderX ZIP coprocessor
> might yield different compression results by tuning the
> algorithm parameters. In our case the compressed result is
> shorter than the test vector.
> 
> We should not forbid different compression results but only
> check that compression -> decompression yields the same
> result. This is done already in the acomp test. Do something
> similar for test_comp().
> 
> Signed-off-by: Mahipal Challa <mchalla@cavium.com>
> Signed-off-by: Balakrishna Bhamidipati <bbhamidipati@cavium.com>
> [jglauber@cavium.com: removed unrelated printk changes, rewrote commit msg,
>  fixed whitespace and unneeded initialization]
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
