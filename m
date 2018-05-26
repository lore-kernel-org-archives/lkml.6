Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032157AbeEZQ1F (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 12:27:05 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:39714 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031950AbeEZQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 12:27:04 -0400
Date: Sun, 27 May 2018 00:27:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: Re: [PATCH] crypto: inside-secure - do not use memset on MMIO
Message-ID: <20180526162701.ql2ryktszw2u6ic4@gondor.apana.org.au>
References: <20180517132214.23528-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517132214.23528-1-antoine.tenart@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 03:22:14PM +0200, Antoine Tenart wrote:
> This patch fixes the Inside Secure driver which uses a memtset() call to
> set an MMIO area from the cryptographic engine to 0. This is wrong as
> memset() isn't guaranteed to work on MMIO for many reasons. This led to
> kernel paging request panics in certain cases. Use memset_io() instead.
> 
> Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
> Reported-by: Ofer Heifetz <oferh@marvell.com>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
