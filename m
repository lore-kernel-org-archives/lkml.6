Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16FBC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6231B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvtjQlyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfBZGVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:21:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37150 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfBZGVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:21:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so5719961pfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZC0yZ2p1o7PK0cgDcV+7uVagcrLRoIilQ0DOICYuriA=;
        b=UvtjQlyBI8sGvZ+mtUypgYWfiM98aNOpcvsZ8mtinlWzpV/NlGaoXWyn/WjvxAfA59
         zAdDo0sD97UFxswOh43IvwfhYQP7qjifbFevHav7hjl2P87uTmlzYq5IhoAgEkb6VY39
         dCWy6S5SW0aQviJWTfnukBXNmPr4fdfAY7NkghkxKNoRM5jVvvR160FhAglpE2Yv68BF
         fWZ4JdnaGo/0YqSZ580IGTSzTe8ohUF0SBvfMTnRTwNdYoBruo5CtHXbefzYckQ7spAP
         71St2dWIfiR99SCOdKu2K3GtaacTrAC/DefyOE8C8wh3LT86GGN2quiQcug5cJfphyD9
         AxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZC0yZ2p1o7PK0cgDcV+7uVagcrLRoIilQ0DOICYuriA=;
        b=Ek+vWryrPlguV0weSEe+0mZug9FnTy7SpdyzFWn6ZwspyD31yzRQ1NnUMvjmSRp2DI
         iozfwfe5h/Z+48OxH4VVlvRx/axtirjPJDdensUgpPw93Y5itHRsV5nKxbdewj0SfCMJ
         dqJtk4wb6Gj15FugjGYTWrZrEg5f/bc1OgdvO2AEvpdFmLh1mJZ1jFZdby4OLvRMurGn
         aoQwbujPlULzO0vp+L5E8D760GV8mDAW3DJhivXCgIkKoz+S49YdRPS0eExaxt3q6VCw
         y56hQtQCgzx3n4FVFYNgOKvEmDQ2CkajBkyg3kd9M1U3cBEAHqjU0xorzZBEF80v7xp3
         szvA==
X-Gm-Message-State: AHQUAuYBrdOkrrAC80VbyNkb0Bi3UvzBrg2ZY4M2B1JaJYCsAlwOoZiO
        k/LE0Dfk1RHfr3MLck5lb2bW+g==
X-Google-Smtp-Source: AHgI3IZhbJhlwudXVxVukpMgxn+FsTefaDGt47Wq8ZxiVq90yeWCKdR/Yp4JOJS211sGlFN/LNUTrw==
X-Received: by 2002:a63:e206:: with SMTP id q6mr2648856pgh.87.1551162072022;
        Mon, 25 Feb 2019 22:21:12 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b26sm14893340pfo.33.2019.02.25.22.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 22:21:10 -0800 (PST)
Date:   Mon, 25 Feb 2019 22:21:10 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
cc:     Mike Kravetz <mike.kravetz@oracle.com>, mhocko@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
        linux-mm@kvack.org, n-horiguchi@ah.jp.nec.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
In-Reply-To: <5C74A2DA.1030304@huawei.com>
Message-ID: <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com> <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com> <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com> <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com> <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com> <5C74A2DA.1030304@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019, Jing Xiangfeng wrote:

> On 2019/2/26 3:17, David Rientjes wrote:
> > On Mon, 25 Feb 2019, Mike Kravetz wrote:
> > 
> >> Ok, what about just moving the calculation/check inside the lock as in the
> >> untested patch below?
> >>
> >> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >> ---
> >>  mm/hugetlb.c | 34 ++++++++++++++++++++++++++--------
> >>  1 file changed, 26 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 1c5219193b9e..5afa77dc7bc8 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -2274,7 +2274,7 @@ static int adjust_pool_surplus(struct hstate *h,
> >> nodemask_t *nodes_allowed,
> >>  }
> >>
> >>  #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
> >> -static int set_max_huge_pages(struct hstate *h, unsigned long count,
> >> +static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
> >>  						nodemask_t *nodes_allowed)
> >>  {
> >>  	unsigned long min_count, ret;
> >> @@ -2289,6 +2289,23 @@ static int set_max_huge_pages(struct hstate *h, unsigned
> >> long count,
> >>  		goto decrease_pool;
> >>  	}
> >>
> >> +	spin_lock(&hugetlb_lock);
> >> +
> >> +	/*
> >> +	 * Check for a node specific request.  Adjust global count, but
> >> +	 * restrict alloc/free to the specified node.
> >> +	 */
> >> +	if (nid != NUMA_NO_NODE) {
> >> +		unsigned long old_count = count;
> >> +		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> >> +		/*
> >> +		 * If user specified count causes overflow, set to
> >> +		 * largest possible value.
> >> +		 */
> >> +		if (count < old_count)
> >> +			count = ULONG_MAX;
> >> +	}
> >> +
> >>  	/*
> >>  	 * Increase the pool size
> >>  	 * First take pages out of surplus state.  Then make up the
> >> @@ -2300,7 +2317,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned
> >> long count,
> >>  	 * pool might be one hugepage larger than it needs to be, but
> >>  	 * within all the constraints specified by the sysctls.
> >>  	 */
> >> -	spin_lock(&hugetlb_lock);
> >>  	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
> >>  		if (!adjust_pool_surplus(h, nodes_allowed, -1))
> >>  			break;
> >> @@ -2421,16 +2437,18 @@ static ssize_t __nr_hugepages_store_common(bool
> >> obey_mempolicy,
> >>  			nodes_allowed = &node_states[N_MEMORY];
> >>  		}
> >>  	} else if (nodes_allowed) {
> >> +		/* Node specific request */
> >> +		init_nodemask_of_node(nodes_allowed, nid);
> >> +	} else {
> >>  		/*
> >> -		 * per node hstate attribute: adjust count to global,
> >> -		 * but restrict alloc/free to the specified node.
> >> +		 * Node specific request, but we could not allocate
> >> +		 * node mask.  Pass in ALL nodes, and clear nid.
> >>  		 */
> >> -		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> >> -		init_nodemask_of_node(nodes_allowed, nid);
> >> -	} else
> >> +		nid = NUMA_NO_NODE;
> >>  		nodes_allowed = &node_states[N_MEMORY];
> >> +	}
> >>
> >> -	err = set_max_huge_pages(h, count, nodes_allowed);
> >> +	err = set_max_huge_pages(h, count, nid, nodes_allowed);
> >>  	if (err)
> >>  		goto out;
> >>
> > 
> > Looks good; Jing, could you test that this fixes your case?
> 
> Yes, I have tested this patch, it can also fix my case.

Great!

Reported-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
Tested-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
Acked-by: David Rientjes <rientjes@google.com>
