Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AA65DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293122086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293122086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934196AbeFMG0B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:26:01 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:53470 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933469AbeFMG0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:26:00 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fSzEC-0001Qd-HM; Wed, 13 Jun 2018 14:25:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fSzE8-0007I6-5n; Wed, 13 Jun 2018 14:25:52 +0800
Date:   Wed, 13 Jun 2018 14:25:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] rhashtable: remove nulls_base and related code.
Message-ID: <20180613062552.2lxhx555xgocuuyc@gondor.apana.org.au>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824939.30340.13120991612931450792.stgit@noble>
 <87vaavmhuk.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vaavmhuk.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:49:07PM +1000, NeilBrown wrote:
> On Fri, Jun 01 2018, NeilBrown wrote:
> 
> > This "feature" is unused, undocumented, and untested and so
> > doesn't really belong.  Next patch will introduce support
> > to detect when a search gets diverted down a different chain,
> > which the common purpose of nulls markers.
> >
> > This patch actually fixes a bug too.  The table resizing allows a
> > table to grow to 2^31 buckets, but the hash is truncated to 27 bits -
> > any growth beyond 2^27 is wasteful an ineffective.
> >
> > This patch results in NULLS_MARKER(0) being used for all chains,
> > and leaves the use of rht_is_a_null() to test for it.
> >
> > Signed-off-by: NeilBrown <neilb@suse.com>
> 
> Hi Herbert,
>  You've acked a few patches that depends on this one, but not this
>  patch itself.  If you could ack this one, I could submit a collection
>  of patches for inclusion (after the merge window closes I guess)
>  and then have fewer outstanding.
>  This assumes you are in-principle happy with the alternative approach I
>  took to handling list-nulls.  I got the impression that it was only
>  some small details holding that back.

You can add my ack to this patch:

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
