Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA2220868
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA2220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxdriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441140AbeKXExq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:53:46 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:54451 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388768AbeKXExq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:53:46 -0500
Received: from cpe-2606-a000-111b-453b-215-ff-fecc-4872.dyn6.twc.com ([2606:a000:111b:453b:215:ff:fecc:4872] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gPzz2-0004eH-UZ; Thu, 22 Nov 2018 20:10:22 -0500
Date:   Fri, 23 Nov 2018 13:07:36 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] crypto: crypto_user_stat: misc enhancement
Message-ID: <20181123180736.GA6851@neilslaptop.think-freely.org>
References: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:02:10PM +0000, Corentin Labbe wrote:
> Hello
> 
> This patchset fixes all reported problem by Eric biggers.
> 
> Regards
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
>  crypto/algapi.c                      | 300 ++++++++++++++++++++++++++-
>  crypto/crypto_user_stat.c            | 160 +++++---------
>  crypto/rng.c                         |   4 +-
>  include/crypto/acompress.h           |  38 +---
>  include/crypto/aead.h                |  38 +---
>  include/crypto/akcipher.h            |  74 ++-----
>  include/crypto/hash.h                |  32 +--
>  include/crypto/internal/cryptouser.h |  17 ++
>  include/crypto/kpp.h                 |  48 +----
>  include/crypto/rng.h                 |  27 +--
>  include/crypto/skcipher.h            |  36 +---
>  include/linux/crypto.h               | 246 +++++++++++++---------
>  include/uapi/linux/cryptouser.h      | 102 +++++----
>  tools/crypto/getstat.c               |  72 +++----
>  17 files changed, 685 insertions(+), 530 deletions(-)
> 
> -- 
> 2.18.1
> 
> 
Thanks, I think this looks good.

Acked-by: Neil Horman <nhorman@tuxdriver.com>

