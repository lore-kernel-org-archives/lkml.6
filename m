Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966343AbeE2S2D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:28:03 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45806 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965960AbeE2S2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:28:00 -0400
Date: Wed, 30 May 2018 02:27:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/6] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180529182746.t4b7tsnfma7dupom@gondor.apana.org.au>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <20180524211135.27760-3-dave@stgolabs.net>
 <20180528094956.zaxusqqju3wtbdcz@gondor.apana.org.au>
 <20180529170338.7brp2m2k4gfqwf64@linux-n805>
 <20180529180428.l6yt6ae4oxbgrja6@gondor.apana.org.au>
 <20180529175927.iyea653hpgnow6p2@linux-n805>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529175927.iyea653hpgnow6p2@linux-n805>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:59:27AM -0700, Davidlohr Bueso wrote:
> On Wed, 30 May 2018, Herbert Xu wrote:
> 
> > It doesn't explain it at all.  In fact I don't see why we neeed
> > three attempts, just do the GFP_NOFAIL as the second and final step.
> 
> Second attempt is reduced size only as we don't want to GFP_NOFAIL
> if we can avoid it helping the allocator. We go from an arbitrary
> allocation to the smallest possible allocation, if all that fails
> ok lets use GFP_NOFAIL. I don't know how this is not clear...

That's exactly what you need to explain in the patch or the commit
message.  In fact you still haven't explained it fully.  Why do we
need a second attempt without the GFP_NOFAIL? How does it help the
allocator?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
