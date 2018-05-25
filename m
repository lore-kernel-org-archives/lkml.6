Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbeEYDnH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:43:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:50284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753116AbeEYDnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:43:06 -0400
Date: Thu, 24 May 2018 20:26:20 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/6] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180525032620.eg6gajv4hxxrm4y2@linux-n805>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <20180524211135.27760-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180524211135.27760-3-dave@stgolabs.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, Davidlohr Bueso wrote:
> 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
>+	if (retry) {
>+		gfp |= __GFP_NOFAIL;
>+		tbl = kzalloc(size, gfp);
>+	} /* fall-through */
>+
> 	if (gfp != GFP_KERNEL)
> 		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);

This is wrong I'll fix in a v2, it should be _else_ if (gfp != GFP_KERNEL) ...
