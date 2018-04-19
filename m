Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeDSDWp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:22:45 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:44976 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeDSDWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:22:43 -0400
Date: Thu, 19 Apr 2018 11:22:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] rhashtable: remove incorrect comment on r{hl,
 hash}table_walk_enter()
Message-ID: <20180419032237.yjvjuh6n7n6tggtr@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble>
 <152403402192.16895.9740762152906281009.stgit2@noble>
 <20180418142854.wacgjdycxvfjh77s@gondor.apana.org.au>
 <87efjcqg2r.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efjcqg2r.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 08:56:28AM +1000, NeilBrown wrote:
>
> I don't want to do that - I just want the documentation to be correct
> (or at least, not be blatantly incorrect).  The function does not sleep,
> and is safe to call with spin locks held.
> Do we need to spell out when it can be called?  If so, maybe:
> 
>    This function may be called from any process context, including
>    non-preemptable context, but cannot be called from interrupts.

Just to make it perfectly clear, how about "cannot be called from
softirq or hardirq context"? Previously the not able to sleep part
completely ruled out any ambiguity but the new wording could confuse
people into thinking that this can be called from softirq context
where it would be unsafe if mixed with process context usage.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
