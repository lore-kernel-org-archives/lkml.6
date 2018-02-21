Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932551AbeBUSyc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:54:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:46020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932270AbeBUSy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:54:26 -0500
Date: Wed, 21 Feb 2018 19:54:25 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Dan Rue <dan.rue@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mm, hugetlb: further simplify hugetlb allocation API
Message-ID: <20180221185425.GK2231@dhcp22.suse.cz>
References: <20180103093213.26329-1-mhocko@kernel.org>
 <20180103093213.26329-6-mhocko@kernel.org>
 <20180221042457.uolmhlmv5je5dqx7@xps>
 <20180221095526.GB2231@dhcp22.suse.cz>
 <20180221100107.GC2231@dhcp22.suse.cz>
 <840f8c4f-0994-fa7d-0b8d-ad2c8d77c67d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840f8c4f-0994-fa7d-0b8d-ad2c8d77c67d@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-02-18 09:59:40, Mike Kravetz wrote:
> On 02/21/2018 02:01 AM, Michal Hocko wrote:
> > On Wed 21-02-18 10:55:26, Michal Hocko wrote:
> > Hmm, I guess I can see it. Does the following help?
> > ---
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 7c204e3d132b..a963f2034dfc 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1583,7 +1583,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
> >  		page = NULL;
> >  	} else {
> >  		h->surplus_huge_pages++;
> > -		h->nr_huge_pages_node[page_to_nid(page)]++;
> > +		h->surplus_huge_pages_node[page_to_nid(page)]++;
> >  	}
> >  
> >  out_unlock:
> 
> I thought we had this corrected in a previous version of the patch.
> My apologies for not looking more closely at this version.

I must have screwed up when rebasing. I remember I was splitting this
patch...

> FWIW,
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
