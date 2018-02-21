Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeBUTFE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:05:04 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:39834 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBUTFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:05:02 -0500
X-Google-Smtp-Source: AH8x224yL2SsZjtA0VIfADqPeeW1TpyIEvWKRyT5U6ZBlP9vDZhKegFzcWZwxAabYlvyBICWcgv8Rg==
Date: Wed, 21 Feb 2018 13:05:00 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mm, hugetlb: further simplify hugetlb allocation API
Message-ID: <20180221190500.oa2osuf3kwxpizz4@xps>
References: <20180103093213.26329-1-mhocko@kernel.org>
 <20180103093213.26329-6-mhocko@kernel.org>
 <20180221042457.uolmhlmv5je5dqx7@xps>
 <20180221095526.GB2231@dhcp22.suse.cz>
 <20180221100107.GC2231@dhcp22.suse.cz>
 <20180221161914.ltssyoumwpyiwca6@xps>
 <20180221185252.GJ2231@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221185252.GJ2231@dhcp22.suse.cz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 07:52:52PM +0100, Michal Hocko wrote:
> On Wed 21-02-18 10:19:14, Dan Rue wrote:
> > On Wed, Feb 21, 2018 at 11:01:07AM +0100, Michal Hocko wrote:
> > > On Wed 21-02-18 10:55:26, Michal Hocko wrote:
> > > > On Tue 20-02-18 22:24:57, Dan Rue wrote:
> > > [...]
> > > > > I bisected the failure to this commit. The problem is seen on multiple
> > > > > architectures (tested x86-64 and arm64).
> > > > 
> > > > The patch shouldn't have introduced any functional changes IIRC. But let
> > > > me have a look
> > > 
> > > Hmm, I guess I can see it. Does the following help?
> > > ---
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 7c204e3d132b..a963f2034dfc 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1583,7 +1583,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
> > >  		page = NULL;
> > >  	} else {
> > >  		h->surplus_huge_pages++;
> > > -		h->nr_huge_pages_node[page_to_nid(page)]++;
> > > +		h->surplus_huge_pages_node[page_to_nid(page)]++;
> > >  	}
> > >  
> > >  out_unlock:
> > 
> > That did the trick. Confirmed fixed on v4.15-3389-g0c397daea1d4 and
> > v4.16-rc2 with the above patch.
> 
> Thanks a lot for re-testing! Can I assume your Tested-by?

Tested-by: Dan Rue <dan.rue@linaro.org>

> 
> -- 
> Michal Hocko
> SUSE Labs
