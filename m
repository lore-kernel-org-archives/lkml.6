Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD44C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3DB2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393154AbeLWEBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:01:30 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:38952 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbeLWEBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:01:30 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gauxE-0008Hi-31; Sun, 23 Dec 2018 12:01:28 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gauxD-0004na-Ut; Sun, 23 Dec 2018 12:01:27 +0800
Date:   Sun, 23 Dec 2018 12:01:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] crypto: ux500 - Use proper enum in hash_set_dma_transfer
Message-ID: <20181223040127.hk2dy4nnfz4uinwn@gondor.apana.org.au>
References: <20181210234954.5862-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210234954.5862-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:49:54PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/crypto/ux500/hash/hash_core.c:169:4: warning: implicit
> conversion from enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum dma_transfer_direction' [-Wenum-conversion]
>                         direction, DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
>                         ^~~~~~~~~
> 1 warning generated.
> 
> dmaengine_prep_slave_sg expects an enum from dma_transfer_direction.
> We know that the only direction supported by this function is
> DMA_TO_DEVICE because of the check at the top of this function so we can
> just use the equivalent value from dma_transfer_direction.
> 
> DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/crypto/ux500/hash/hash_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
