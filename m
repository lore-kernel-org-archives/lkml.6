Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeDTQyj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:54:39 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34424 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbeDTQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:54:38 -0400
Date: Sat, 21 Apr 2018 00:54:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mahipal Challa <mchalla@cavium.com>,
        Balakrishna Bhamidipati <bbhamidipati@cavium.com>
Subject: Re: [PATCH] crypto: testmgr: Allow different compression results
Message-ID: <20180420165432.etiqksfiqsiecdgz@gondor.apana.org.au>
References: <20180411182832.27761-1-jglauber@cavium.com>
 <20180419034210.nsmzuf3f6lmn7suc@gondor.apana.org.au>
 <20180419115840.GA14706@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419115840.GA14706@hc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 01:58:40PM +0200, Jan Glauber wrote:
>
> Nice idea. Would a crypto_alloc_cipher("deflate", ...) pick the generic
> implementation or how can we select it?

For our ciphers we generally use the -generic suffix in the driver
name.  The compression algorithms seem to be all over the place on
this so we should fix them all to use the -generic suffix and then
we can simply append the -generic suffix here before allocating it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
