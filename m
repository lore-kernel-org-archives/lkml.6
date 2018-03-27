Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeC0Pvb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:51:31 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45696 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeC0Pv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:51:29 -0400
Date: Tue, 27 Mar 2018 23:51:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without
 missing objects.
Message-ID: <20180327155118.GB14001@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718430.11435.5761213978298714527.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152210718430.11435.5761213978298714527.stgit@noble>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 10:33:04AM +1100, NeilBrown wrote:
>
> -int rhashtable_walk_start_check(struct rhashtable_iter *iter)
> +int rhashtable_walk_start_continue(struct rhashtable_iter *iter, struct rhash_head *obj)
>  	__acquires(RCU)
>  {
>  	struct rhashtable *ht = iter->ht;
>  
>  	rcu_read_lock();
>  
> +	if (!obj || iter->p != obj)
> +		iter->p = NULL;

Why bother with this check at all? Couldn't we make it so that
if you call continue then you continue with the cursor otherwise
you set it to NULL as we currently do.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
