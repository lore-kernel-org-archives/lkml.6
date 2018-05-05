Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeEEJMP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 05:12:15 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35366 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeEEJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 05:12:13 -0400
Date: Sat, 5 May 2018 17:12:08 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] rhashtable: remove nulls_base and related code.
Message-ID: <20180505091208.tnsxi6hdpjn456yz@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605427.18473.12277050439942480863.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152540605427.18473.12277050439942480863.stgit@noble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
> This "feature" is unused, undocumented, and untested and so
> doesn't really belong.  If a use for the nulls marker
> is found, all this code would need to be reviewed to
> ensure it works as required.  It would be just as easy to
> just add the code if/when it is needed instead.
> 
> This patch actually fixes a bug too.  The table resizing allows a
> table to grow to 2^31 buckets, but the hash is truncated to 27 bits -
> any growth beyond 2^27 is wasteful an ineffective.
> 
> This patch result in NULLS_MARKER(0) being used for all chains,
> and leave the use of rht_is_a_null() to test for it.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I disagree.  This is a fundamental requirement for the use of
rhashtable in certain networking systems such as TCP/UDP.  So
we know that there will be a use for this.

As to the bug fix, please separate it out of the patch and resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
