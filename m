Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeE3O3a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:29:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:55722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeE3O3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:29:17 -0400
Date: Wed, 30 May 2018 07:29:06 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/6] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180530142906.fdib4dw2ik6smduu@linux-r8p5>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <20180524211135.27760-3-dave@stgolabs.net>
 <20180528094956.zaxusqqju3wtbdcz@gondor.apana.org.au>
 <20180529170338.7brp2m2k4gfqwf64@linux-n805>
 <20180529180428.l6yt6ae4oxbgrja6@gondor.apana.org.au>
 <20180529175927.iyea653hpgnow6p2@linux-n805>
 <20180529182746.t4b7tsnfma7dupom@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180529182746.t4b7tsnfma7dupom@gondor.apana.org.au>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Herbert Xu wrote:

>On Tue, May 29, 2018 at 10:59:27AM -0700, Davidlohr Bueso wrote:
>That's exactly what you need to explain in the patch or the commit
>message.  In fact you still haven't explained it fully.  Why do we
>need a second attempt without the GFP_NOFAIL? How does it help the
>allocator?

It helps in that we have two fastpath attempts before going in to
__alloc_pages_slowpath() and looping in __GFP_NOFAIL. But yeah, I
see your point. We can just apply KISS and avoid the extra alloc.
That actually makes more sense to me now than ignoring min_size
based on simplicity.

Thanks for the review.

Thanks,
Davidlohr
