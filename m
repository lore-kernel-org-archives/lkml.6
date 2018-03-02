Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967949AbeCBQmc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:42:32 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:59262 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936365AbeCBQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:42:25 -0500
Date: Sat, 3 Mar 2018 00:42:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] cleanups and new HW rev support
Message-ID: <20180302164212.GE21579@gondor.apana.org.au>
References: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519051887-4668-1-git-send-email-gilad@benyossef.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 02:51:20PM +0000, Gilad Ben-Yossef wrote:
> This patch set introduces backward compatible support for the older
> CryptoCell hardware revision 710 and 630 along some minor code
> cleanups.
> 
> Gilad Ben-Yossef (4):
>   crypto: ccree: remove unused definitions
>   dt-bindings: Add DT bindings for ccree 710 and 630p
>   crypto: ccree: add support for older HW revs
>   crypto: ccree: replace memset+kfree with kzfree
> 
>  .../devicetree/bindings/crypto/arm-cryptocell.txt  |   3 +-
>  drivers/crypto/Kconfig                             |   6 +-
>  drivers/crypto/ccree/cc_aead.c                     |  34 +++--
>  drivers/crypto/ccree/cc_cipher.c                   |  25 +++-
>  drivers/crypto/ccree/cc_crypto_ctx.h               |  36 -----
>  drivers/crypto/ccree/cc_driver.c                   |  68 ++++++++--
>  drivers/crypto/ccree/cc_driver.h                   |  23 +++-
>  drivers/crypto/ccree/cc_fips.c                     |  13 +-
>  drivers/crypto/ccree/cc_hash.c                     | 149 +++++++++++----------
>  drivers/crypto/ccree/cc_hash.h                     |  12 +-
>  drivers/crypto/ccree/cc_host_regs.h                |   3 +
>  drivers/crypto/ccree/cc_hw_queue_defs.h            |   2 +-
>  drivers/crypto/ccree/cc_kernel_regs.h              |   1 +
>  drivers/crypto/ccree/cc_request_mgr.c              |   9 +-
>  drivers/crypto/ccree/cc_sram_mgr.c                 |  14 ++
>  15 files changed, 240 insertions(+), 158 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
