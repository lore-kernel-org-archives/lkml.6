Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeBZRGL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:06:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50720 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeBZRGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:06:08 -0500
Subject: Re: Fwd: Re: Kernel panic with 4.16-rc1 (and 4.16-rc2) running
 selftest
To: Matthew Wilcox <willy@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: Chris Mi <chrism@mellanox.com>
References: <7995f335-ccac-bfdc-bb37-46d0f887c647@oracle.com>
 <b926a569-c05e-dd49-a25d-555e88e9ff8e@infradead.org>
 <CAM_iQpUveA5T6-y7bguaPUok-LphJrLYxw6kNgaMorsxm4z9NA@mail.gmail.com>
 <CAM_iQpWSRe0t1Dr=7o+1ejULV=F+_Wx1v7yyw=NRBUTYttMxog@mail.gmail.com>
 <96bf4941-17c0-0796-292c-b66087f5f52e@infradead.org>
 <CAFhKne9Dyx1uvRz_9rvCq7mewAbLA5T77P21oBQfOR7JzP_1aQ@mail.gmail.com>
 <20180224011528.GA15231@bombadil.infradead.org>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <a32f69ae-5b88-7c87-5359-ba16bb490c03@oracle.com>
Date: Mon, 26 Feb 2018 10:05:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180224011528.GA15231@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=773
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 06:15 PM, Matthew Wilcox wrote:
> On Fri, Feb 23, 2018 Randy Dunlap wrote:
>> [add Matthew Wilcox; hopefully he can look/see]
> 
> Thanks, Randy.  I don't understand why nobody else thought to cc the
> author of the patch that it was bisected to ...

Sorry, Willy. That was my fault. I should have cc'd you to begin with.

> 
> Please try this patch.  It fixes ffe00000, but there may be more things
> tested that it may not work for.
> 

This patch fixes the problem. I do not see kernel panics with this patch 
any more.

--
Khalid

> Chris Mi, what happened to that set of testcases you promised to write
> for me?
> 
> diff --git a/lib/idr.c b/lib/idr.c
> index c98d77fcf393..10d9b8d47c33 100644
> --- a/lib/idr.c
> +++ b/lib/idr.c
> @@ -36,8 +36,8 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
>   {
>   	struct radix_tree_iter iter;
>   	void __rcu **slot;
> -	int base = idr->idr_base;
> -	int id = *nextid;
> +	unsigned int base = idr->idr_base;
> +	unsigned int id = *nextid;
>   
>   	if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
>   		return -EINVAL;
> 
