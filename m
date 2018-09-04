Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFFBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956F92075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956F92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIDJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:19:47 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38784 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeIDJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:19:47 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fx3Nm-0008HY-OW; Tue, 04 Sep 2018 12:56:06 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fx3Nf-0003HF-MV; Tue, 04 Sep 2018 12:55:59 +0800
Date:   Tue, 4 Sep 2018 12:55:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Samuel Neves <samuel.c.p.neves@gmail.com>,
        Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
        Eric Biggers <ebiggers@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] crypto: remove Speck
Message-ID: <20180904045559.jfzqhwcfyq42x2cs@gondor.apana.org.au>
References: <20180807011937.GA133621@gmail.com>
 <20180807062225.6331-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807062225.6331-1-Jason@zx2c4.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:22:25AM +0200, Jason A. Donenfeld wrote:
> These are unused, undesired, and have never actually been used by
> anybody. The original authors of this code have changed their mind about
> its inclusion. While originally proposed for disk encryption on low-end
> devices, the idea was discarded [1] in favor of something else before
> that could really get going. Therefore, this patch removes Speck.
> 
> [1] https://marc.info/?l=linux-crypto-vger&m=153359499015659
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Acked-by: Eric Biggers <ebiggers@google.com>
> Cc: stable@vger.kernel.org
> ---
>  Documentation/filesystems/fscrypt.rst |  10 -
>  arch/arm/crypto/Kconfig               |   6 -
>  arch/arm/crypto/Makefile              |   2 -
>  arch/arm/crypto/speck-neon-core.S     | 434 ---------------
>  arch/arm/crypto/speck-neon-glue.c     | 288 ----------
>  arch/arm64/crypto/Kconfig             |   6 -
>  arch/arm64/crypto/Makefile            |   3 -
>  arch/arm64/crypto/speck-neon-core.S   | 352 ------------
>  arch/arm64/crypto/speck-neon-glue.c   | 282 ----------
>  arch/m68k/configs/amiga_defconfig     |   1 -
>  arch/m68k/configs/apollo_defconfig    |   1 -
>  arch/m68k/configs/atari_defconfig     |   1 -
>  arch/m68k/configs/bvme6000_defconfig  |   1 -
>  arch/m68k/configs/hp300_defconfig     |   1 -
>  arch/m68k/configs/mac_defconfig       |   1 -
>  arch/m68k/configs/multi_defconfig     |   1 -
>  arch/m68k/configs/mvme147_defconfig   |   1 -
>  arch/m68k/configs/mvme16x_defconfig   |   1 -
>  arch/m68k/configs/q40_defconfig       |   1 -
>  arch/m68k/configs/sun3_defconfig      |   1 -
>  arch/m68k/configs/sun3x_defconfig     |   1 -
>  arch/s390/defconfig                   |   1 -
>  crypto/Kconfig                        |  14 -
>  crypto/Makefile                       |   1 -
>  crypto/speck.c                        | 307 -----------
>  crypto/testmgr.c                      |  24 -
>  crypto/testmgr.h                      | 738 --------------------------
>  fs/crypto/fscrypt_private.h           |   4 -
>  fs/crypto/keyinfo.c                   |  10 -
>  include/crypto/speck.h                |  62 ---
>  include/uapi/linux/fs.h               |   4 +-
>  31 files changed, 2 insertions(+), 2558 deletions(-)
>  delete mode 100644 arch/arm/crypto/speck-neon-core.S
>  delete mode 100644 arch/arm/crypto/speck-neon-glue.c
>  delete mode 100644 arch/arm64/crypto/speck-neon-core.S
>  delete mode 100644 arch/arm64/crypto/speck-neon-glue.c
>  delete mode 100644 crypto/speck.c
>  delete mode 100644 include/crypto/speck.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
