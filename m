Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EA9222E6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfBQI21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:28:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfBQI21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 03:28:27 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1H8IUNi057359
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 03:28:25 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qq0dgdmyr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 03:28:25 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 17 Feb 2019 08:28:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 17 Feb 2019 08:28:20 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1H8SJpa22282338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 17 Feb 2019 08:28:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB7E42042;
        Sun, 17 Feb 2019 08:28:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04F0042041;
        Sun, 17 Feb 2019 08:28:19 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 17 Feb 2019 08:28:18 +0000 (GMT)
Date:   Sun, 17 Feb 2019 10:28:17 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-mm@kvack.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: simplify reduce_memory() function
References: <1549963956-28269-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549963956-28269-1-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021708-0008-0000-0000-000002C160E7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021708-0009-0000-0000-0000222D8BC1
Message-Id: <20190217082816.GB1176@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902170066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on this?

On Tue, Feb 12, 2019 at 11:32:36AM +0200, Mike Rapoport wrote:
> The reduce_memory() function clampls the available memory to a limit
> defined by the "mem=" command line parameter. It takes into account the
> amount of already reserved memory and excludes it from the limit
> calculations.
> 
> Rather than traverse memblocks and remove them by hand, use
> memblock_reserved_size() to account the reserved memory and
> memblock_enforce_memory_limit() to clamp the available memory.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/sparc/mm/init_64.c | 42 ++----------------------------------------
>  1 file changed, 2 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index b4221d3..478b818 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2261,19 +2261,6 @@ static unsigned long last_valid_pfn;
>  static void sun4u_pgprot_init(void);
>  static void sun4v_pgprot_init(void);
>  
> -static phys_addr_t __init available_memory(void)
> -{
> -	phys_addr_t available = 0ULL;
> -	phys_addr_t pa_start, pa_end;
> -	u64 i;
> -
> -	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &pa_start,
> -				&pa_end, NULL)
> -		available = available + (pa_end  - pa_start);
> -
> -	return available;
> -}
> -
>  #define _PAGE_CACHE_4U	(_PAGE_CP_4U | _PAGE_CV_4U)
>  #define _PAGE_CACHE_4V	(_PAGE_CP_4V | _PAGE_CV_4V)
>  #define __DIRTY_BITS_4U	 (_PAGE_MODIFIED_4U | _PAGE_WRITE_4U | _PAGE_W_4U)
> @@ -2287,33 +2274,8 @@ static phys_addr_t __init available_memory(void)
>   */
>  static void __init reduce_memory(phys_addr_t limit_ram)
>  {
> -	phys_addr_t avail_ram = available_memory();
> -	phys_addr_t pa_start, pa_end;
> -	u64 i;
> -
> -	if (limit_ram >= avail_ram)
> -		return;
> -
> -	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &pa_start,
> -				&pa_end, NULL) {
> -		phys_addr_t region_size = pa_end - pa_start;
> -		phys_addr_t clip_start = pa_start;
> -
> -		avail_ram = avail_ram - region_size;
> -		/* Are we consuming too much? */
> -		if (avail_ram < limit_ram) {
> -			phys_addr_t give_back = limit_ram - avail_ram;
> -
> -			region_size = region_size - give_back;
> -			clip_start = clip_start + give_back;
> -		}
> -
> -		memblock_remove(clip_start, region_size);
> -
> -		if (avail_ram <= limit_ram)
> -			break;
> -		i = 0UL;
> -	}
> +	limit_ram += memblock_reserved_size();
> +	memblock_enforce_memory_limit(limit_ram);
>  }
>  
>  void __init paging_init(void)
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

