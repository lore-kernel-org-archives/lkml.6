Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EBBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629EB20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629EB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeKIT0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:26:21 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:37302 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIT0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:26:21 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gL3Mz-00020O-Vo; Fri, 09 Nov 2018 17:46:30 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gL3My-0005f9-Fn; Fri, 09 Nov 2018 17:46:28 +0800
Date:   Fri, 9 Nov 2018 17:46:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Stafford Horne <shorne@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: crypto_user reporting fixes and cleanups
Message-ID: <20181109094628.qdpiykue7eogzcx5@gondor.apana.org.au>
References: <20181103215603.16250-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181103215603.16250-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 02:55:59PM -0700, Eric Biggers wrote:
> This series fixes all the information leaks in crypto_user reporting,
> removes some redundant reporting functions, and makes some changes to
> reduce the chance of similar information leaks in the future.  Patch 2
> is based on a patch already sent by Corentin Labbe, but it was
> incomplete so I fixed it.
> 
> Corentin Labbe (1):
>   crypto: crypto_user_stat - Zeroize whole structure given to user space
> 
> Eric Biggers (3):
>   crypto: crypto_user - fix leaking uninitialized memory to userspace
>   crypto: crypto_user - remove redundant reporting functions
>   crypto: crypto_user - clean up report structure copying
> 
>  crypto/ablkcipher.c       |  32 ++++------
>  crypto/acompress.c        |  10 +---
>  crypto/aead.c             |  14 ++---
>  crypto/ahash.c            |  12 ++--
>  crypto/akcipher.c         |  11 ++--
>  crypto/blkcipher.c        |  16 ++---
>  crypto/crypto_user_base.c |  95 +++++------------------------
>  crypto/crypto_user_stat.c | 123 ++++++++++++++------------------------
>  crypto/kpp.c              |  10 +---
>  crypto/rng.c              |  12 ++--
>  crypto/scompress.c        |  11 ++--
>  crypto/shash.c            |  12 ++--
>  crypto/skcipher.c         |  15 ++---
>  13 files changed, 116 insertions(+), 257 deletions(-)

All applied.  Patches 1-2 went into crypto and 3-4 are in cryptodev.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
