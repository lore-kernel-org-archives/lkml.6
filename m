Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDRO3E (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:29:04 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:44100 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752899AbeDRO3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:29:02 -0400
Date: Wed, 18 Apr 2018 22:28:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] rhashtable: remove incorrect comment on r{hl,
 hash}table_walk_enter()
Message-ID: <20180418142854.wacgjdycxvfjh77s@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble>
 <152403402192.16895.9740762152906281009.stgit2@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152403402192.16895.9740762152906281009.stgit2@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 04:47:01PM +1000, NeilBrown wrote:
> Neither rhashtable_walk_enter() or rhltable_walk_enter() sleep, so
> remove the comments which suggest that they do.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  include/linux/rhashtable.h |    3 ---
>  lib/rhashtable.c           |    3 ---
>  2 files changed, 6 deletions(-)
> 
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index 87d443a5b11d..b01d88e196c2 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -1268,9 +1268,6 @@ static inline int rhashtable_walk_init(struct rhashtable *ht,
>   * For a completely stable walk you should construct your own data
>   * structure outside the hash table.
>   *
> - * This function may sleep so you must not call it from interrupt
> - * context or with spin locks held.

It does a naked spin lock so even though we removed the memory
allocation you still mustn't call it from interrupt context.

Why do you need to do that anyway?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
