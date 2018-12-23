Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29E2218E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393129AbeLWEBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:01:21 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:38938 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbeLWEBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:01:20 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gaux4-0008HX-Tp; Sun, 23 Dec 2018 12:01:18 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gaux4-0004nI-QP; Sun, 23 Dec 2018 12:01:18 +0800
Date:   Sun, 23 Dec 2018 12:01:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] crypto: ux500 - Use proper enum in cryp_set_dma_transfer
Message-ID: <20181223040118.qzk4flxswf5xvckp@gondor.apana.org.au>
References: <20181210234929.5729-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210234929.5729-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:49:29PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/crypto/ux500/cryp/cryp_core.c:559:5: warning: implicit
> conversion from enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
>                                 direction, DMA_CTRL_ACK);
>                                 ^~~~~~~~~
> drivers/crypto/ux500/cryp/cryp_core.c:583:5: warning: implicit
> conversion from enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
>                                 direction,
>                                 ^~~~~~~~~
> 2 warnings generated.
> 
> dmaengine_prep_slave_sg expects an enum from dma_transfer_direction.
> Because we know the value of the dma_data_direction enum from the
> switch statement, we can just use the proper value from
> dma_transfer_direction so there is no more conversion.
> 
> DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
> DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/crypto/ux500/cryp/cryp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
