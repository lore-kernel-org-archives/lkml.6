Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeEEJK6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:10:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35358 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeEEJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:10:57 -0400
Date: Sat, 5 May 2018 17:10:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] rhashtable: silence RCU warning in rhashtable_test.
Message-ID: <20180505091046.bd74tk75oieaasi5@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605424.18473.310003836978239224.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540605424.18473.310003836978239224.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
> print_ht in rhashtable_test calls rht_dereference() with neither
> RCU protection or the mutex.  This triggers an RCU warning.
> So take the mutex to silence the warning.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I don't think the mutex is actually needed but since we don't
have rht_dereference_raw and this is just test code:

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
