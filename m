Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD14C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ED320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eE3BRqKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfBYTRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:17:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38479 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:17:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so4928056pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hUkZS3RN5nGm+9djQiBmGffJnFbcZdls1iUZK4YyJo8=;
        b=eE3BRqKI/JwJqMizD82Jl4ElWBMD5woz1Yu6j5SuMPFmYPPUWNOBLjMT7FdYTMDaXL
         tDQq5/NEzuFr/h6zFkrYK9tVmzGkXPrQmRsk+eUbKsz2kmWVyeAJAefuHtB55lfhyZ3x
         TTtsIdEiIiAgmVoAw39No7jdWQF0uAhO8HNys3fQ08xK5948nf0l3SNNq0sEWhDW0shS
         YpoAotlkRoa7XZLU6HrFkNRZvv0KHpYg4tkMm1RuUziMuPVgu8vtLgucOHyPXr4s3plj
         EcbEP0rRaTl/cZwApk/lButnXP9o7n0jRuOvCt7SHRgduIAXCsplvUp0IMitn64R8PC2
         sWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hUkZS3RN5nGm+9djQiBmGffJnFbcZdls1iUZK4YyJo8=;
        b=IjZ4qA3s4eQZ+MrwTxsDOM2iJiH7xg/QXRnLxHr1RNkhYJuNWF/1iLs4ym9L0ehChn
         FlMio/DOEFRcF+OIBa/rlrJ8NeO50vyNW2xwIQX9vQVAup88X08OT0FNFiMErKJaFKp2
         vkdcb5ryJCqk/U0ZXF9GDi/ZK3aVbjlgM/TFqAWf6KMw4pvnPoC2Xcoy1gGUpWSj5u2i
         TOmW705vpKBjQedxh4ANctfIso9p8yLPuivC7ldrrl7pCHaluufIoOUer1fNKcGeyZHW
         86hRnoTAmni1NcRdqjCE4TPRxCDJR0fKEHxDwFs+/6ZfaiiKuT7/D4AcPsaxbORkHJu9
         78bw==
X-Gm-Message-State: AHQUAuYwJ0dNbpxVvTjyFeknHAxISontrvoC854nxz79vpZ4QSHPVPXZ
        cIUEO+u0qbVazs6NySNcFLNWnA==
X-Google-Smtp-Source: AHgI3Ia8ne5XrNgg+aplWvFyN0xHFDzMTxc8Xw54IB0TI0soJBIDrNUwyxPUyAOSzqrjAjvzY9WcVQ==
X-Received: by 2002:a63:788a:: with SMTP id t132mr20819792pgc.0.1551122236139;
        Mon, 25 Feb 2019 11:17:16 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i13sm9791483pfo.106.2019.02.25.11.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 11:17:15 -0800 (PST)
Date:   Mon, 25 Feb 2019 11:17:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Kravetz <mike.kravetz@oracle.com>
cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>, mhocko@kernel.org,
        akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        n-horiguchi@ah.jp.nec.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
In-Reply-To: <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
Message-ID: <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com> <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com> <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com> <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019, Mike Kravetz wrote:

> Ok, what about just moving the calculation/check inside the lock as in the
> untested patch below?
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1c5219193b9e..5afa77dc7bc8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2274,7 +2274,7 @@ static int adjust_pool_surplus(struct hstate *h,
> nodemask_t *nodes_allowed,
>  }
> 
>  #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
> -static int set_max_huge_pages(struct hstate *h, unsigned long count,
> +static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  						nodemask_t *nodes_allowed)
>  {
>  	unsigned long min_count, ret;
> @@ -2289,6 +2289,23 @@ static int set_max_huge_pages(struct hstate *h, unsigned
> long count,
>  		goto decrease_pool;
>  	}
> 
> +	spin_lock(&hugetlb_lock);
> +
> +	/*
> +	 * Check for a node specific request.  Adjust global count, but
> +	 * restrict alloc/free to the specified node.
> +	 */
> +	if (nid != NUMA_NO_NODE) {
> +		unsigned long old_count = count;
> +		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> +		/*
> +		 * If user specified count causes overflow, set to
> +		 * largest possible value.
> +		 */
> +		if (count < old_count)
> +			count = ULONG_MAX;
> +	}
> +
>  	/*
>  	 * Increase the pool size
>  	 * First take pages out of surplus state.  Then make up the
> @@ -2300,7 +2317,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned
> long count,
>  	 * pool might be one hugepage larger than it needs to be, but
>  	 * within all the constraints specified by the sysctls.
>  	 */
> -	spin_lock(&hugetlb_lock);
>  	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
>  		if (!adjust_pool_surplus(h, nodes_allowed, -1))
>  			break;
> @@ -2421,16 +2437,18 @@ static ssize_t __nr_hugepages_store_common(bool
> obey_mempolicy,
>  			nodes_allowed = &node_states[N_MEMORY];
>  		}
>  	} else if (nodes_allowed) {
> +		/* Node specific request */
> +		init_nodemask_of_node(nodes_allowed, nid);
> +	} else {
>  		/*
> -		 * per node hstate attribute: adjust count to global,
> -		 * but restrict alloc/free to the specified node.
> +		 * Node specific request, but we could not allocate
> +		 * node mask.  Pass in ALL nodes, and clear nid.
>  		 */
> -		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> -		init_nodemask_of_node(nodes_allowed, nid);
> -	} else
> +		nid = NUMA_NO_NODE;
>  		nodes_allowed = &node_states[N_MEMORY];
> +	}
> 
> -	err = set_max_huge_pages(h, count, nodes_allowed);
> +	err = set_max_huge_pages(h, count, nid, nodes_allowed);
>  	if (err)
>  		goto out;
> 

Looks good; Jing, could you test that this fixes your case?
