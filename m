Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966991AbeEYP7p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:59:45 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:34406 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966464AbeEYP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:59:43 -0400
Date: Fri, 25 May 2018 15:59:42 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Vlastimil Babka <vbabka@suse.cz>
cc: linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 4/5] mm: rename and change semantics of
 nr_indirectly_reclaimable_bytes
In-Reply-To: <20180524110011.1940-5-vbabka@suse.cz>
Message-ID: <010001639806f32c-c18e739a-feac-4c6d-bce0-61c410579310-000000@email.amazonses.com>
References: <20180524110011.1940-1-vbabka@suse.cz> <20180524110011.1940-5-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.25-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, Vlastimil Babka wrote:

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 32699b2dc52a..4343948f33e5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -180,7 +180,7 @@ enum node_stat_item {
>  	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
>  	NR_DIRTIED,		/* page dirtyings since bootup */
>  	NR_WRITTEN,		/* page writings since bootup */
> -	NR_INDIRECTLY_RECLAIMABLE_BYTES, /* measured in bytes */
> +	NR_RECLAIMABLE,         /* all reclaimable pages, including slab */
>  	NR_VM_NODE_STAT_ITEMS

We already have NR_SLAB_RECLAIMABLE and NR_RECLAIMABLE now counts what
NR_SLAB_RECLAIMABLE counts plus something else. THis means updating
two counters in parallel.

Could keep the existing counter and just account
for those non slab things you mentioned? Avoid counting twice and may
provide unique insides into those non slab reclaimable objects. I'd like
to see this.
