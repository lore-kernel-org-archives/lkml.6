Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeEEJna (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:43:30 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35454 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEEJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:43:29 -0400
Date: Sat, 5 May 2018 17:43:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH 7/8] rhashtable: add rhashtable_walk_prev()
Message-ID: <20180505094324.wwjtl76oofgrtpg4@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605441.18473.4087381584733882012.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540605441.18473.4087381584733882012.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
> rhashtable_walk_prev() returns the object returned by
> the previous rhashtable_walk_next(), providing it is still in the
> table (or was during this grace period).
> This works even if rhashtable_walk_stop() and rhashtable_talk_start()
> have been called since the last rhashtable_walk_next().
> 
> If there have been no calls to rhashtable_walk_next(), or if the
> object is gone from the table, then NULL is returned.
> 
> This can usefully be used in a seq_file ->start() function.
> If the pos is the same as was returned by the last ->next() call,
> then rhashtable_walk_prev() can be used to re-establish the
> current location in the table.  If it returns NULL, then
> rhashtable_walk_next() should be used.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I will ack this if Tom is OK with replacing peek with it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
