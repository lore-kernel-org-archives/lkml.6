Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965856AbeE2SPT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:15:19 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:45696 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965607AbeE2SPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:15:17 -0400
Date: Wed, 30 May 2018 02:15:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/6] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180529181510.ttlmndxk36rmkwcy@gondor.apana.org.au>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <20180524211135.27760-3-dave@stgolabs.net>
 <20180528100237.needq2u5e3v2n642@gondor.apana.org.au>
 <20180529164231.yoj57nqhghtmy54v@linux-n805>
 <20180529180345.jwu2bzax764gtof5@gondor.apana.org.au>
 <20180529175513.s7iju6rkoya3hvsf@linux-n805>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529175513.s7iju6rkoya3hvsf@linux-n805>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:55:13AM -0700, Davidlohr Bueso wrote:
> On Wed, 30 May 2018, Herbert Xu wrote:
> 
> > On Tue, May 29, 2018 at 09:42:31AM -0700, Davidlohr Bueso wrote:
> > > 
> > > For the sake of simplicity, Linus suggested directly using HASH_MIN_SIZE
> > > such that we have a single fallback.
> > 
> > Where did he suggest that?
> 
> https://lkml.org/lkml/2018/5/24/1265

Well I think we should respect min_size.  rhashtable users may
fail at insertion time if the table is too small.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
