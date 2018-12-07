Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26814C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E419A20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E419A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLGGSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:18:46 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:49018 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeLGGSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:18:45 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gV9TD-0004mh-Hj; Fri, 07 Dec 2018 14:18:39 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gV9TD-00006B-Do; Fri, 07 Dec 2018 14:18:39 +0800
Date:   Fri, 7 Dec 2018 14:18:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, ebiggers@kernel.org, nhorman@tuxdriver.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] crypto: crypto_user_stat: misc enhancement
Message-ID: <20181207061839.k3wuvqflkxpx2int@gondor.apana.org.au>
References: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:42:15PM +0000, Corentin Labbe wrote:
> Hello
> 
> This patchset fixes all reported problem by Eric biggers.
> 
> Regards
> 
> Changes since v4:
> - Inlined functions when !CRYPTO_STATS
> 
> Changes since v3:
> - Added a crypto_stats_init as asked vy Neil Horman
> - Fixed some checkpatch complaints
> 
> Changes since v2:
> - moved all crypto_stats functions from header to algapi.c for using
>   crypto_alg_get/put
> 
> Changes since v1:
> - Better locking of crypto_alg via crypto_alg_get/crypto_alg_put
> - remove all intermediate variables in crypto/crypto_user_stat.c
> - splited all internal stats variables into different structures
> 
> Corentin Labbe (11):
>   crypto: crypto_user_stat: made crypto_user_stat optional
>   crypto: CRYPTO_STATS should depend on CRYPTO_USER
>   crypto: crypto_user_stat: convert all stats from u32 to u64
>   crypto: crypto_user_stat: split user space crypto stat structures
>   crypto: tool: getstat: convert user space example to the new
>     crypto_user_stat uapi
>   crypto: crypto_user_stat: fix use_after_free of struct xxx_request
>   crypto: crypto_user_stat: Fix invalid stat reporting
>   crypto: crypto_user_stat: remove intermediate variable
>   crypto: crypto_user_stat: Split stats in multiple structures
>   crypto: crypto_user_stat: rename err_cnt parameter
>   crypto: crypto_user_stat: Add crypto_stats_init
> 
>  crypto/Kconfig                       |   1 +
>  crypto/Makefile                      |   3 +-
>  crypto/ahash.c                       |  17 +-
>  crypto/algapi.c                      | 247 ++++++++++++++++++++++-
>  crypto/crypto_user_stat.c            | 160 +++++----------
>  crypto/rng.c                         |   4 +-
>  include/crypto/acompress.h           |  38 +---
>  include/crypto/aead.h                |  38 +---
>  include/crypto/akcipher.h            |  74 ++-----
>  include/crypto/hash.h                |  32 +--
>  include/crypto/internal/cryptouser.h |  17 ++
>  include/crypto/kpp.h                 |  48 +----
>  include/crypto/rng.h                 |  27 +--
>  include/crypto/skcipher.h            |  36 +---
>  include/linux/crypto.h               | 290 ++++++++++++++++++---------
>  include/uapi/linux/cryptouser.h      | 102 ++++++----
>  tools/crypto/getstat.c               |  72 +++----
>  17 files changed, 676 insertions(+), 530 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
