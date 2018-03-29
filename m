Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeC2Fkv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:40:51 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:47762 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeC2Fku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:40:50 -0400
Date: Thu, 29 Mar 2018 13:40:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rhashtable: fix insertion of in rhltable when
 duplicate found.
Message-ID: <20180329054038.GB21028@gondor.apana.org.au>
References: <152228607974.16370.14544827502467836789.stgit@noble>
 <152228634995.16370.12793320017578882447.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152228634995.16370.12793320017578882447.stgit@noble>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 12:19:09PM +1100, NeilBrown wrote:
> When rhltable_insert() finds an entry with the same key,
> it splices the new entry at the start of a list of entries with the
> same key.
> It stores the address of the new object in *pprev, but in general this
> is *not* the location where the match was found (though in a common
> case where the hash chain has one element, it will be).
> To fix this, pprev should be updated every time we find an object that
> doesn't match.
> 
> This patch changes the behaviour for non-slow insertion in that now
> insertion happens at the end of a chain rather than at the head.
> I don't think this is an important change.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Thanks.  But Paul Blakey beat you to it :)

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=d3dcf8eb615537526bd42ff27a081d46d337816e
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
