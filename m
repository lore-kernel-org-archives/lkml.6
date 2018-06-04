Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeFDLqd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:46:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751590AbeFDLqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:46:31 -0400
Date: Mon, 4 Jun 2018 13:46:22 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, herbert@gondor.apana.org.au, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/5] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180604114622.GK19202@dhcp22.suse.cz>
References: <20180601160125.30031-1-dave@stgolabs.net>
 <20180601160125.30031-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601160125.30031-3-dave@stgolabs.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-06-18 09:01:22, Davidlohr Bueso wrote:
[...]
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 05a4b1b8b8ce..ae17da6f0c75 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -175,7 +175,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
>  	int i;
>  
>  	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
> -	if (gfp != GFP_KERNEL)
> +	if ((gfp & ~__GFP_NOFAIL) != GFP_KERNEL)
>  		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
>  	else
>  		tbl = kvzalloc(size, gfp);

Just a heads up. This is not longer needed after
http://lkml.kernel.org/r/20180601115329.27807-1-mhocko@kernel.org
is applied. Moreover it will conflict at that spot.

-- 
Michal Hocko
SUSE Labs
