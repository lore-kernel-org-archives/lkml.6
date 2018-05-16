Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbeEPUlo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:41:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:49256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbeEPUlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:41:44 -0400
Subject: Re: [PATCH] mm: save two stranding bit in gfp_mask
To: Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc: Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20180516202023.167627-1-shakeelb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <90167afa-ecfb-c5ef-3554-ddb7e6ac9728@suse.cz>
Date: Wed, 16 May 2018 22:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516202023.167627-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 10:20 PM, Shakeel Butt wrote:
> ___GFP_COLD and ___GFP_OTHER_NODE were removed but their bits were
> stranded. Slide existing gfp masks to make those two bits available.

Well, there are already available for hypothetical new flags. Is there
anything that benefits from a smaller __GFP_BITS_SHIFT? Otherwise no big
objection, besides the churn. Maybe move the last (well, before
NOLOCKDEP) two flags to the "holes" instead of shifting everything? That
would be closer to what compaction does...
There's also an ongoing effort to make the lowest 4 flags a number,
would that mean more free bits and churn soon?
I would also dislike having to learn new numbers for typical flag
combinations to recognize them in oom reports/alloc failures, but
somebody had the great idea to print those symbolically, so nevermind.

Vlastimil

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
