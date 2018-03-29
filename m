Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeC2Mfz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:35:55 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:49850 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeC2Mfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:35:54 -0400
Date: Thu, 29 Mar 2018 20:35:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
Message-ID: <20180329123544.GA22551@gondor.apana.org.au>
References: <20180329120612.6104-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329120612.6104-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 02:06:10PM +0200, Andreas Gruenbacher wrote:
> Here's a second version of the patch (now a patch set) to eliminate
> rhashtable_walk_peek in gfs2.
> 
> The first patch introduces lockref_put_not_zero, the inverse of
> lockref_get_not_zero.
> 
> The second patch eliminates rhashtable_walk_peek in gfs2.  In
> gfs2_glock_iter_next, the new lockref function from patch one is used to
> drop a lockref count as long as the count doesn't drop to zero.  This is
> almost always the case; if there is a risk of dropping the last
> reference, we must defer that to a work queue because dropping the last
> reference may sleep.

In light of Neil's latest patch, do we still need this?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
