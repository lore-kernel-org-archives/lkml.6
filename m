Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3D02064D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZPmvnirL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3D02064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbeGKTWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:22:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47082 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKTWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:22:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BJDScR185432;
        Wed, 11 Jul 2018 19:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=zqLRvYE66r3QoZew+uk+WDgGC6rYgSWxEHYjreDeyI0=;
 b=ZPmvnirLeEFCmq7HeR3GL1WIWsJuUMw5ojYFVMg6lOit2WRujdgRZIdbxIZtSL41ubin
 xnIP40QpSRxp7Pv/HMFzJiVyeS5kYLNGE5ill+okyEJWByjwA1SWsMqNG7VcOmVhnT6c
 klIcHhYlCHQYgEiDSgbCYGC1CeFdDqnpRqUGadUZc1tR8JI1dv/VQjJB+VhKX7h5pF77
 MNt0+awatqcvP4nP4i/ZI/3tW9EmG8vynCrWNFOG2RIHKHPikOotK4huNY7gbzBYL5hG
 30RRlrt4/oWoTTEeSE4F9c+prur9XKkbvFIl3vZnrIIPiefuCzakSNAgz5enJIgXJyEU Hg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k2p7dyk7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 19:16:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6BJGITn029874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 19:16:18 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6BJGHdj023573;
        Wed, 11 Jul 2018 19:16:17 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 12:16:17 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 190506A00C2; Wed, 11 Jul 2018 15:16:11 -0400 (EDT)
Date:   Wed, 11 Jul 2018 15:16:11 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] swiotlb: Clean up reporting
Message-ID: <20180711191610.GC29513@char.US.ORACLE.com>
References: <20180710232222.GA32002@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710232222.GA32002@beast>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:22:22PM -0700, Kees Cook wrote:
> This removes needless use of '%p', and refactors the printk calls to
> use pr_*() helpers instead.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Christoph, volunteered to pick this patch up in his tree. Thank you!
> ---
>  kernel/dma/swiotlb.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 904541055792..4f8a6dbf0b60 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -17,6 +17,8 @@
>   * 08/12/11 beckyb	Add highmem support
>   */
>  
> +#define pr_fmt(fmt) "software IO TLB: " fmt
> +
>  #include <linux/cache.h>
>  #include <linux/dma-direct.h>
>  #include <linux/mm.h>
> @@ -162,20 +164,16 @@ static bool no_iotlb_memory;
>  void swiotlb_print_info(void)
>  {
>  	unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> -	unsigned char *vstart, *vend;
>  
>  	if (no_iotlb_memory) {
> -		pr_warn("software IO TLB: No low mem\n");
> +		pr_warn("No low mem\n");
>  		return;
>  	}
>  
> -	vstart = phys_to_virt(io_tlb_start);
> -	vend = phys_to_virt(io_tlb_end);
> -
> -	printk(KERN_INFO "software IO TLB [mem %#010llx-%#010llx] (%luMB) mapped at [%p-%p]\n",
> +	pr_info("mapped [mem %#010llx-%#010llx] (%luMB)\n",
>  	       (unsigned long long)io_tlb_start,
>  	       (unsigned long long)io_tlb_end,
> -	       bytes >> 20, vstart, vend - 1);
> +	       bytes >> 20);
>  }
>  
>  /*
> @@ -275,7 +273,7 @@ swiotlb_init(int verbose)
>  	if (io_tlb_start)
>  		memblock_free_early(io_tlb_start,
>  				    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
> -	pr_warn("Cannot allocate SWIOTLB buffer");
> +	pr_warn("Cannot allocate buffer");
>  	no_iotlb_memory = true;
>  }
>  
> @@ -317,8 +315,8 @@ swiotlb_late_init_with_default_size(size_t default_size)
>  		return -ENOMEM;
>  	}
>  	if (order != get_order(bytes)) {
> -		printk(KERN_WARNING "Warning: only able to allocate %ld MB "
> -		       "for software IO TLB\n", (PAGE_SIZE << order) >> 20);
> +		pr_warn("only able to allocate %ld MB\n",
> +			(PAGE_SIZE << order) >> 20);
>  		io_tlb_nslabs = SLABS_PER_PAGE << order;
>  	}
>  	rc = swiotlb_late_init_with_tbl(vstart, io_tlb_nslabs);
> -- 
> 2.17.1
> 
> 
> -- 
> Kees Cook
> Pixel Security
