Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20070ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B686020825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B686020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeKIByq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:54:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeKIByq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:54:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8GE1Kg056396
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 11:18:32 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmnxf87pp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 11:18:32 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 8 Nov 2018 16:18:29 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 16:18:27 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8GIQGk36896862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 16:18:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32A07A4055;
        Thu,  8 Nov 2018 16:18:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81E24A4053;
        Thu,  8 Nov 2018 16:18:25 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.126])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Nov 2018 16:18:25 +0000 (GMT)
Date:   Thu, 8 Nov 2018 18:18:23 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, rppt@linux.vnet.ibm.com
Subject: Re: [[PATCH]] mips: Fix switch to NO_BOOTMEM for SGI-IP27/loongons3
 NUMA
References: <20181108144428.28149-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108144428.28149-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18110816-0008-0000-0000-0000028F472E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110816-0009-0000-0000-000021F98C3B
Message-Id: <20181108161823.GB15707@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:44:28PM +0100, Thomas Bogendoerfer wrote:
> Commit bcec54bf3118 ("mips: switch to NO_BOOTMEM") broke SGI-IP27
> and NUMA enabled loongson3 by doing memblock_set_current_limit()
> before max_low_pfn has been evaluated. Both platforms need to do the
> memblock_set_current_limit() in platform specific code. For
> consistency the call to memblock_set_current_limit() is moved
> to the common bootmem_init(), where max_low_pfn is calculated
> for non NUMA enabled platforms.

As far as I can tell loongsoon3 initially sets max_low_pfn in
node_mem_init(0) and then re-evaluates it in paging_init(). So it seems
that in this case the limit would be wrong for a system with more than one
node, but it would be set to some usable value.

As for SGI-IP27, the initialization of max_low_pfn as late as in
paging_init() seems to be broken because it's value is used in
arch_mem_init() and in finalize_initrd() anyway.

AFAIU, both platforms set max_low_pfn to last available pfn, so it seems we
can simply do

	max_low_pfn = PFN_PHYS(memblock_end_of_DRAM())

in the prom_meminit() function for both platforms and drop the loop
evaluating max_low_pfn in paging_init().
 
> Fixes: bcec54bf3118 ("mips: switch to NO_BOOTMEM")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  arch/mips/kernel/setup.c               | 18 +++++++++---------
>  arch/mips/loongson64/loongson-3/numa.c |  1 +
>  arch/mips/sgi-ip27/ip27-memory.c       |  1 +
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index ea09ed6a80a9..b5167b198231 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -576,6 +576,15 @@ static void __init bootmem_init(void)
>  	 * Reserve initrd memory if needed.
>  	 */
>  	finalize_initrd();
> +
> +	/*
> +	 * Prevent memblock from allocating high memory.
> +	 * This cannot be done before max_low_pfn is detected, so up
> +	 * to this point is possible to only reserve physical memory
> +	 * with memblock_reserve; memblock_alloc* can be used
> +	 * only after this point
> +	 */
> +	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
>  }
> 
>  #endif	/* CONFIG_SGI_IP27 */
> @@ -854,15 +863,6 @@ static void __init arch_mem_init(char **cmdline_p)
> 
>  	bootmem_init();
> 
> -	/*
> -	 * Prevent memblock from allocating high memory.
> -	 * This cannot be done before max_low_pfn is detected, so up
> -	 * to this point is possible to only reserve physical memory
> -	 * with memblock_reserve; memblock_alloc* can be used
> -	 * only after this point
> -	 */
> -	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
> -
>  #ifdef CONFIG_PROC_VMCORE
>  	if (setup_elfcorehdr && setup_elfcorehdr_size) {
>  		printk(KERN_INFO "kdump reserved memory at %lx-%lx\n",
> diff --git a/arch/mips/loongson64/loongson-3/numa.c b/arch/mips/loongson64/loongson-3/numa.c
> index 622761878cd1..5593a8e3cd88 100644
> --- a/arch/mips/loongson64/loongson-3/numa.c
> +++ b/arch/mips/loongson64/loongson-3/numa.c
> @@ -265,6 +265,7 @@ void __init paging_init(void)
>  	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
>  #endif
>  	zones_size[ZONE_NORMAL] = max_low_pfn;
> +	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
>  	free_area_init_nodes(zones_size);
>  }
> 
> diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> index d8b8444d6795..0d0deeae1f47 100644
> --- a/arch/mips/sgi-ip27/ip27-memory.c
> +++ b/arch/mips/sgi-ip27/ip27-memory.c
> @@ -468,6 +468,7 @@ void __init paging_init(void)
>  			max_low_pfn = end_pfn;
>  	}
>  	zones_size[ZONE_NORMAL] = max_low_pfn;
> +	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
>  	free_area_init_nodes(zones_size);
>  }
> 
> -- 
> 2.13.7
> 

-- 
Sincerely yours,
Mike.

