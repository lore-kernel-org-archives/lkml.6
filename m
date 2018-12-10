Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528AAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1373220821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RxaNN9iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1373220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeLJRKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:10:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51872 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeLJRKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:10:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAH9Vrk056230;
        Mon, 10 Dec 2018 17:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9Qhk1Zm2iUha5mKf95eBfiEwbjgmLqYHH2B4/tm++sE=;
 b=RxaNN9iQ7h3uC8ewIqza/5iCQOmfEwQ+q51mgxqO2x4f2B6QxbgvH4EO5at/WnK6PZv4
 K8E1NgmOZ+6bes05hesYGnH/ryuP/im9lc4bgJVh1/0TCcfN8i1F4pql6c2yl3yZ207U
 /ZpyIskfyQYfc7W2gF6w4n2mUnrjgG6ECpLuKaL2pIqMoBh/I94mr/ruUK/Em397rcod
 rVnC8Pn5bUdBFQPq30KgAkXfXFLEIbQVAcSu21wfpzY3+npgjBs55XtH57D9KdhwGqkn
 o5o9UUEySsp2R44x5wyeXE1EmEpGURvX8fpByf/QfGwNYsyK4dwcpj68VZDOWB8VDdl2 qQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p85cty8t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 17:09:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBAH9uMi027585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 17:09:56 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBAH9uaE014743;
        Mon, 10 Dec 2018 17:09:56 GMT
Received: from [10.211.47.70] (/10.211.47.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 09:09:55 -0800
Subject: Re: [PATCH v2 2/2] swiotlb: checking whether swiotlb buffer is full
 with io_tlb_used
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
 <1544402278-8175-2-git-send-email-dongli.zhang@oracle.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <912321c7-5f27-bfec-b4d9-3d50efeed356@oracle.com>
Date:   Mon, 10 Dec 2018 09:09:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1544402278-8175-2-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/18 4:37 PM, Dongli Zhang wrote:
> This patch uses io_tlb_used to help check whether swiotlb buffer is full.
> io_tlb_used is no longer used for only debugfs. It is also used to help
> optimize swiotlb_tbl_map_single().
> 
> Suggested-by: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Reviewed-by: Joe Jin <joe.jin@oracle.com>

> ---
>  kernel/dma/swiotlb.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 3979c2c..9300341 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -76,12 +76,10 @@ static phys_addr_t io_tlb_start, io_tlb_end;
>   */
>  static unsigned long io_tlb_nslabs;
>  
> -#ifdef CONFIG_DEBUG_FS
>  /*
>   * The number of used IO TLB block
>   */
>  static unsigned long io_tlb_used;
> -#endif
>  
>  /*
>   * This is a free list describing the number of free entries available from
> @@ -489,6 +487,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  	 * request and allocate a buffer from that IO TLB pool.
>  	 */
>  	spin_lock_irqsave(&io_tlb_lock, flags);
> +
> +	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
> +		goto not_found;
> +
>  	index = ALIGN(io_tlb_index, stride);
>  	if (index >= io_tlb_nslabs)
>  		index = 0;
> @@ -538,9 +540,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>  	return SWIOTLB_MAP_ERROR;
>  found:
> -#ifdef CONFIG_DEBUG_FS
>  	io_tlb_used += nslots;
> -#endif
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  
>  	/*
> @@ -602,9 +602,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>  		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
>  			io_tlb_list[i] = ++count;
>  
> -#ifdef CONFIG_DEBUG_FS
>  		io_tlb_used -= nslots;
> -#endif
>  	}
>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>  }
> 


-- 
Oracle <http://www.oracle.com>
Joe Jin | Software Development Director 
ORACLE | Linux and Virtualization
500 Oracle Parkway Redwood City, CA US 94065
