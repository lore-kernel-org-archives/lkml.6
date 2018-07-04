Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B1BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FAC2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FAC2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeGDNZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:25:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752816AbeGDNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:25:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64DNX4v086298
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 09:25:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0xh0sr1a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:25:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 14:25:17 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 14:25:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64DPDhU36765862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 13:25:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5928152054;
        Wed,  4 Jul 2018 16:25:38 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C93315204E;
        Wed,  4 Jul 2018 16:25:37 +0100 (BST)
Date:   Wed, 4 Jul 2018 16:25:11 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        linux-c6x <linux-c6x-dev@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] c6x: switch to NO_BOOTMEM
References: <1530101360-5768-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530101360-5768-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18070413-0016-0000-0000-000001E35064
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070413-0017-0000-0000-00003237B674
Message-Id: <20180704132510.GI4352@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on this?

On Wed, Jun 27, 2018 at 03:09:20PM +0300, Mike Rapoport wrote:
> The c6x is already using memblock and does most of early memory
> reservations with it, so it was only a matter of removing the bootmem
> initialization and handover of the memory from memblock to bootmem.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  arch/c6x/Kconfig        |  1 +
>  arch/c6x/kernel/setup.c | 26 +-------------------------
>  2 files changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
> index bf59855628ac..054c7c963180 100644
> --- a/arch/c6x/Kconfig
> +++ b/arch/c6x/Kconfig
> @@ -14,6 +14,7 @@ config C6X
>  	select GENERIC_IRQ_SHOW
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_MEMBLOCK
> +	select NO_BOOTMEM
>  	select SPARSE_IRQ
>  	select IRQ_DOMAIN
>  	select OF
> diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
> index 786e36e2f61d..cc74cb9d349b 100644
> --- a/arch/c6x/kernel/setup.c
> +++ b/arch/c6x/kernel/setup.c
> @@ -296,7 +296,6 @@ notrace void __init machine_init(unsigned long dt_ptr)
> 
>  void __init setup_arch(char **cmdline_p)
>  {
> -	int bootmap_size;
>  	struct memblock_region *reg;
> 
>  	printk(KERN_INFO "Initializing kernel\n");
> @@ -353,16 +352,6 @@ void __init setup_arch(char **cmdline_p)
>  	init_mm.end_data   = memory_start;
>  	init_mm.brk        = memory_start;
> 
> -	/*
> -	 * Give all the memory to the bootmap allocator,  tell it to put the
> -	 * boot mem_map at the start of memory
> -	 */
> -	bootmap_size = init_bootmem_node(NODE_DATA(0),
> -					 memory_start >> PAGE_SHIFT,
> -					 PAGE_OFFSET >> PAGE_SHIFT,
> -					 memory_end >> PAGE_SHIFT);
> -	memblock_reserve(memory_start, bootmap_size);
> -
>  	unflatten_device_tree();
> 
>  	c6x_cache_init();
> @@ -397,22 +386,9 @@ void __init setup_arch(char **cmdline_p)
>  	/* Initialize the coherent memory allocator */
>  	coherent_mem_init(dma_start, dma_size);
> 
> -	/*
> -	 * Free all memory as a starting point.
> -	 */
> -	free_bootmem(PAGE_OFFSET, memory_end - PAGE_OFFSET);
> -
> -	/*
> -	 * Then reserve memory which is already being used.
> -	 */
> -	for_each_memblock(reserved, reg) {
> -		pr_debug("reserved - 0x%08x-0x%08x\n",
> -			 (u32) reg->base, (u32) reg->size);
> -		reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
> -	}
> -
>  	max_low_pfn = PFN_DOWN(memory_end);
>  	min_low_pfn = PFN_UP(memory_start);
> +	max_pfn = max_low_pfn;
>  	max_mapnr = max_low_pfn - min_low_pfn;
> 
>  	/* Get kmalloc into gear */
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

