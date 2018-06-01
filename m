Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeFAQ3M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:29:12 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:58060 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeFAQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:29:10 -0400
Date: Sat, 2 Jun 2018 00:28:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] rhashtable: simplify nested_table_alloc() and
 rht_bucket_nested_insert()
Message-ID: <20180601162859.g3xwnpri3scprgfj@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824950.30340.10831876745236207066.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152782824950.30340.10831876745236207066.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:44:09PM +1000, NeilBrown wrote:
> Now that we don't use the hash value or shift in nested_table_alloc()
> there is room for simplification.
> We only need to pass a "is this a leaf" flag to nested_table_alloc(),
> and don't need to track as much information in
> rht_bucket_nested_insert().
> 
> Note there is another minor cleanup in nested_table_alloc() here.
> The number of elements in a page of "union nested_tables" is most naturally
> 
>   PAGE_SIZE / sizeof(ntbl[0])
> 
> The previous code had
> 
>   PAGE_SIZE / sizeof(ntbl[0].bucket)
> 
> which happens to be the correct value only because the bucket uses all
> the space in the union.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
