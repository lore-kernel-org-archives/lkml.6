Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938946AbeBUR7w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:59:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44464 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933620AbeBUR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:59:49 -0500
Subject: Re: [PATCH 5/6] mm, hugetlb: further simplify hugetlb allocation API
To: Michal Hocko <mhocko@kernel.org>, Dan Rue <dan.rue@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180103093213.26329-1-mhocko@kernel.org>
 <20180103093213.26329-6-mhocko@kernel.org>
 <20180221042457.uolmhlmv5je5dqx7@xps> <20180221095526.GB2231@dhcp22.suse.cz>
 <20180221100107.GC2231@dhcp22.suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <840f8c4f-0994-fa7d-0b8d-ad2c8d77c67d@oracle.com>
Date: Wed, 21 Feb 2018 09:59:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221100107.GC2231@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8811 signatures=668676
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=977
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 02:01 AM, Michal Hocko wrote:
> On Wed 21-02-18 10:55:26, Michal Hocko wrote:
> Hmm, I guess I can see it. Does the following help?
> ---
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7c204e3d132b..a963f2034dfc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1583,7 +1583,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  		page = NULL;
>  	} else {
>  		h->surplus_huge_pages++;
> -		h->nr_huge_pages_node[page_to_nid(page)]++;
> +		h->surplus_huge_pages_node[page_to_nid(page)]++;
>  	}
>  
>  out_unlock:

I thought we had this corrected in a previous version of the patch.
My apologies for not looking more closely at this version.

FWIW,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
