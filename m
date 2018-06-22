Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71020C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24448244A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24448244A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933814AbeFVPWO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:22:14 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38354 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933508AbeFVPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:22:12 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fWNt4-00081i-S9; Fri, 22 Jun 2018 23:22:10 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fWNt4-0003Wy-MU; Fri, 22 Jun 2018 23:22:10 +0800
Date:   Fri, 22 Jun 2018 23:22:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: Re: [PATCH 00/10] crypto: inside-secure - sha512/384 support
Message-ID: <20180622152210.a733zyzzt7qtzq3j@gondor.apana.org.au>
References: <20180529121352.19490-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529121352.19490-1-antoine.tenart@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 02:13:42PM +0200, Antoine Tenart wrote:
> Hello Herbert,
> 
> This series adds support for the SHA512 and SHA384 algorithms in the
> Inside Secure SafeXcel driver. Variants of those two algorithms are also
> added as well (hmac, and AEAD).
> 
> Before doing so a few patches rework the driver to prepare for the new
> algorithms additions.
> 
> Thanks!
> Antoine
> 
> Antoine Tenart (10):
>   crypto: inside-secure - use the error handler for invalidation
>     requests
>   crypto: inside-secure - improve the counter computation
>   crypto: sha512_generic - add a sha512 0-length pre-computed hash
>   crypto: inside-secure - sha512 support
>   crypto: inside-secure - hmac(sha512) support
>   crypto: inside-secure - authenc(hmac(sha512),cbc(aes)) support
>   crypto: sha512_generic - add a sha384 0-length pre-computed hash
>   crypto: inside-secure - sha384 support
>   crypto: inside-secure - hmac(sha384) support
>   crypto: inside-secure - authenc(hmac(sha384),cbc(aes)) support
> 
>  crypto/sha512_generic.c                       |  22 +
>  drivers/crypto/inside-secure/safexcel.c       |   6 +
>  drivers/crypto/inside-secure/safexcel.h       |  23 +-
>  .../crypto/inside-secure/safexcel_cipher.c    |  89 +++-
>  drivers/crypto/inside-secure/safexcel_hash.c  | 381 ++++++++++++++++--
>  include/crypto/sha.h                          |   4 +
>  6 files changed, 469 insertions(+), 56 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
