Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeC0Py2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:54:28 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45706 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeC0PyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:54:19 -0400
Date: Tue, 27 Mar 2018 23:54:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Miller <davem@davemloft.net>
Cc: neilb@suse.com, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rhashtable: allow a walk of the hash table without
 missing objects.
Message-ID: <20180327155404.GC14001@gondor.apana.org.au>
References: <152210688405.11435.13010923693146415942.stgit@noble>
 <152210718430.11435.5761213978298714527.stgit@noble>
 <20180327.114941.997071660018188736.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327.114941.997071660018188736.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:49:41AM -0400, David Miller wrote:
>
> Merely having an elevated reference count does not explicitly prevent
> the object from being removed from the hash table.
> 
> This invariant might hold for the particular user of the rhashtable
> instance, but it is not always the case.

I think having a new interface like this should work as if the
user knows that the element has not been removed from the hash
table then it should be safe to continue from it.

Of course people may misuse it but even using the current interface
correctly may result in lost objects due to concurrent removals.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
