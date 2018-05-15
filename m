Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeEODhc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 23:37:32 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45518 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeEODhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 23:37:31 -0400
Date: Tue, 15 May 2018 11:37:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Miller <davem@davemloft.net>
Cc: dave@stgolabs.net, akpm@linux-foundation.org, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dbueso@suse.de
Subject: Re: [PATCH] lib/rhashtable: reorder some inititalization sequences
Message-ID: <20180515033719.t2jphtfjofc5v7ag@gondor.apana.org.au>
References: <20180514151332.31352-1-dave@stgolabs.net>
 <20180514.225213.1789810083198383905.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514.225213.1789810083198383905.davem@davemloft.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:52:13PM -0400, David Miller wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> Date: Mon, 14 May 2018 08:13:32 -0700
> 
> > rhashtable_init() allocates memory at the very end of the
> > call, once everything is setup; with the exception of the
> > nelems parameter. However, unless the user is doing something
> > bogus with params for which -EINVAL is returned, memory
> > allocation is the only operation that can trigger the call
> > to fail.
> > 
> > Thus move bucket_table_alloc() up such that we fail back to
> > the caller asap, instead of doing useless checks. This is
> > safe as the the table allocation isn't using the halfly
> > setup 'ht' structure and bucket_table_alloc() call chain only
> > ends up using the ht->nulls_base member in INIT_RHT_NULLS_HEAD.
> > 
> > Also move the locking initialization down to the end.
> > 
> > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> 
> The user potentially "doing something bogus" is why the most
> expensive part of the initialization (the memory allocation)
> is done after everything else is validated.
> 
> I think it's best to keep things as-is.

I agree.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
