Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeBLSsJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:48:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:38209 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753960AbeBLSsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:48:06 -0500
Date: Mon, 12 Feb 2018 19:47:59 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hartley <james.hartley@mips.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 1/1] mm: page_alloc: skip over regions of invalid pfns
 on UMA
Message-ID: <20180212184759.GI3443@dhcp22.suse.cz>
References: <20180124143545.31963-1-erosca@de.adit-jv.com>
 <20180124143545.31963-2-erosca@de.adit-jv.com>
 <20180129184746.GK21609@dhcp22.suse.cz>
 <20180203122422.GA11832@vmlxhi-102.adit-jv.com>
 <20180212150314.GG3443@dhcp22.suse.cz>
 <20180212161640.GA30811@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212161640.GA30811@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-02-18 17:16:40, Eugeniu Rosca wrote:
> Hi Michal,
> 
> On Mon, Feb 12, 2018 at 04:03:14PM +0100, Michal Hocko wrote:
> > On Sat 03-02-18 13:24:22, Eugeniu Rosca wrote:
> > [...]
> > > That said, I really hope this won't be the last comment in the thread
> > > and appropriate suggestions will come on how to go forward.
> > 
> > Just to make sure we are on the same page. I was suggesting the
> > following. The patch is slightly larger just because I move
> > memblock_next_valid_pfn around which I find better than sprinkling
> > ifdefs around. Please note I haven't tried to compile test this.
> 
> I got your point. So, I was wrong. You are not preferring v2 of this
> patch, but suggest a new variant of it. For the record, I've also
> build/boot-tested your variant with no issues. The reason I did not
> make it my favorite is to allow reviewers to concentrate on what's
> actually the essence of this change, i.e. relaxing the dependency of
> memblock_next_valid_pfn() from HAVE_MEMBLOCK_NODE_MAP (which requires/
> depends on NUMA) to HAVE_MEMBLOCK (which doesn't).

Yes, and that makes perfect sense.

> As I've said in some previous reply, I am open minded about which
> variant is selected by MM people, since, from my point of view, all of
> them do the same thing with variable degree of code readability.

Agreed. I just wanted to reduce to necessity to define
memblock_next_valid_pfn for !CONFIG_HAVE_MEMBLOCK. IS_ENABLED check also
nicely hides the ifdefery. I also prefer to have more compact ifdef
blocks rather than smaller ones split by other functions.

> For me it's not a problem to submit a new patch. I guess that a
> prerequisite for this is to reach some agreement on what people think is
> the best option, which I feel didn't occur yet.

I do not have a _strong_ preference here as well. So I will leave the
decision to you.

In any case feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

-- 
Michal Hocko
SUSE Labs
