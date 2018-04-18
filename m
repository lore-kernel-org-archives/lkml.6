Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeDROfK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:35:10 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:44144 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeDROfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:35:08 -0400
Date: Wed, 18 Apr 2018 22:35:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] rhashtable: add rhashtable_walk_prev()
Message-ID: <20180418143501.kzvknyvgnjo7v75k@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble>
 <152403402206.16895.14563720960374849428.stgit2@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152403402206.16895.14563720960374849428.stgit2@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 04:47:02PM +1000, NeilBrown wrote:
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

Can you explain the need for this function and its difference
from the existing rhashtable_walk_peek?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
