Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965879AbeE2SQS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:16:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:48011 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965718AbeE2SQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:16:16 -0400
Date: Tue, 29 May 2018 10:59:27 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/6] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180529175927.iyea653hpgnow6p2@linux-n805>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <20180524211135.27760-3-dave@stgolabs.net>
 <20180528094956.zaxusqqju3wtbdcz@gondor.apana.org.au>
 <20180529170338.7brp2m2k4gfqwf64@linux-n805>
 <20180529180428.l6yt6ae4oxbgrja6@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180529180428.l6yt6ae4oxbgrja6@gondor.apana.org.au>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Herbert Xu wrote:

>It doesn't explain it at all.  In fact I don't see why we neeed
>three attempts, just do the GFP_NOFAIL as the second and final step.

Second attempt is reduced size only as we don't want to GFP_NOFAIL
if we can avoid it helping the allocator. We go from an arbitrary
allocation to the smallest possible allocation, if all that fails
ok lets use GFP_NOFAIL. I don't know how this is not clear...

Thanks,
Davidlohr
