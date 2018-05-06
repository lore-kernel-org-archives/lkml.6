Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeEFFTJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 01:19:09 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:36340 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeEFFTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 01:19:07 -0400
Date: Sun, 6 May 2018 13:18:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] rhashtable: fix race in nested_table_alloc()
Message-ID: <20180506051859.w7evarps5jdcplz6@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble>
 <152540605432.18473.11813271279255176724.stgit@noble>
 <20180505092907.2qa3scf6bzvubmtt@gondor.apana.org.au>
 <871sepepuj.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sepepuj.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 07:48:20AM +1000, NeilBrown wrote:
>
> The spinlock protects 2 or more buckets.  The nested table contains at
> least 512 buckets, maybe more.
> It is quite possible for two insertions into 2 different buckets to both
> get their spinlock and both try to instantiate the same nested table.

I think you missed the fact that when we use nested tables the spin
lock table is limited to just a single page and hence corresponds
to the first level in the nested table.  Therefore it's always safe.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
