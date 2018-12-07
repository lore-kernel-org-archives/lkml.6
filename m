Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF819C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF5520892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="adUNlLfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF5520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGFrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 00:47:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37000 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeLGFru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 00:47:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB75i5Io124195;
        Fri, 7 Dec 2018 05:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=7RnvdztJ0LTHE17BZ2j4mcJ5SmruJSg7Jxjb9U8Uq10=;
 b=adUNlLfFHJ/Jhg0dK4duAiMnlwUASwD39pC5rBTbNEPuVHTM59K4zCMX1PXLovlGqw49
 t67r5wMx0PLyTt0vd8RPLCv42D5W98zkz0hT3fgTpakm460dKW7VmZJ7B7ldqm0djGs3
 xSR5i/UvJLQYl2AqA1pXhh3Byrh2rw4f+EPgrFMphUIBmtj4/ztPOj3KioQmTmLz6pI8
 AcIKf0iFYk6+Hm1yEZYc17VCqbEpmldZ4ytE3OjMPfGyJ0Vmsu9Ygs5IG639yyWIlLT/
 DmV6fF+ukLMwP742hIx9F0x7Iv/b2krsWQM7nEzkLoeGbqirJqb0y71hLTWdhxvJMLJA Hw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqubxk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 05:47:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB75ldwJ010596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 05:47:39 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB75lcVd009988;
        Fri, 7 Dec 2018 05:47:38 GMT
Received: from [10.182.71.9] (/10.182.71.9)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 21:47:38 -0800
Subject: Re: [PATCH RFC 1/1] swiotlb: add debugfs to track swiotlb buffer
 usage
To:     Joe Jin <joe.jin@oracle.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1544068785-20399-1-git-send-email-dongli.zhang@oracle.com>
 <da16ecce-4e25-d246-3e0d-389e8e9e413e@oracle.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <28a9f44a-d1bf-fb34-5a57-cfdb7bb23163@oracle.com>
Date:   Fri, 7 Dec 2018 13:49:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <da16ecce-4e25-d246-3e0d-389e8e9e413e@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/07/2018 12:12 AM, Joe Jin wrote:
> Hi Dongli,
> 
> Maybe move d_swiotlb_usage declare into swiotlb_create_debugfs():

I assume the call of swiotlb_tbl_map_single() might be frequent in some
situations, e.g., when 'swiotlb=force'.

That's why I declare the d_swiotlb_usage out of any functions and use "if
(unlikely(!d_swiotlb_usage))".

I think "if (unlikely(!d_swiotlb_usage))" incur less performance overhead than
calling swiotlb_create_debugfs() every time to confirm if debugfs is created. I
would declare d_swiotlb_usage statically inside swiotlb_create_debugfs() if the
performance overhead is acceptable (it is trivial indeed).


That is the reason I tag the patch with RFC because I am not sure if the
on-demand creation of debugfs is fine with maintainers/reviewers. If swiotlb
pages are never allocated, we would not be able to see the debugfs entry.

I would prefer to limit the modification within swiotlb and to not taint any
other files.

The drawback is there is no place to create or delete the debugfs entry because
swiotlb buffer could be initialized and uninitialized at very early stage.

> 
> void swiotlb_create_debugfs(void)
> {
> #ifdef CONFIG_DEBUG_FS
> 	static struct dentry *d_swiotlb_usage = NULL;
> 
> 	if (d_swiotlb_usage)
> 		return;
> 
> 	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
> 
> 	if (!d_swiotlb_usage)
> 		return;
> 
> 	debugfs_create_file("usage", 0600, d_swiotlb_usage,
> 			    NULL, &swiotlb_usage_fops);
> #endif
> }
> 
> And for io_tlb_used, possible add a check at the begin of swiotlb_tbl_map_single(),
> if there were not any free slots or not enough slots, return fail directly?

This would optimize the slots allocation path. I will follow this in next
version after I got more suggestions and confirmations from maintainers.


Thank you very much!

Dongli Zhang

> 
> Thanks,
> Joe
> On 12/5/18 7:59 PM, Dongli Zhang wrote:
>> The device driver will not be able to do dma operations once swiotlb buffer
>> is full, either because the driver is using so many IO TLB blocks inflight,
>> or because there is memory leak issue in device driver. To export the
>> swiotlb buffer usage via debugfs would help the user estimate the size of
>> swiotlb buffer to pre-allocate or analyze device driver memory leak issue.
>>
>> As the swiotlb can be initialized at very early stage when debugfs cannot
>> register successfully, this patch creates the debugfs entry on demand.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  kernel/dma/swiotlb.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 045930e..d3c8aa4 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -35,6 +35,9 @@
>>  #include <linux/scatterlist.h>
>>  #include <linux/mem_encrypt.h>
>>  #include <linux/set_memory.h>
>> +#ifdef CONFIG_DEBUG_FS
>> +#include <linux/debugfs.h>
>> +#endif
>>  
>>  #include <asm/io.h>
>>  #include <asm/dma.h>
>> @@ -73,6 +76,13 @@ static phys_addr_t io_tlb_start, io_tlb_end;
>>   */
>>  static unsigned long io_tlb_nslabs;
>>  
>> +#ifdef CONFIG_DEBUG_FS
>> +/*
>> + * The number of used IO TLB block
>> + */
>> +static unsigned long io_tlb_used;
>> +#endif
>> +
>>  /*
>>   * This is a free list describing the number of free entries available from
>>   * each index
>> @@ -100,6 +110,41 @@ static DEFINE_SPINLOCK(io_tlb_lock);
>>  
>>  static int late_alloc;
>>  
>> +#ifdef CONFIG_DEBUG_FS
>> +
>> +static struct dentry *d_swiotlb_usage;
>> +
>> +static int swiotlb_usage_show(struct seq_file *m, void *v)
>> +{
>> +	seq_printf(m, "%lu\n%lu\n", io_tlb_used, io_tlb_nslabs);
>> +	return 0;
>> +}
>> +
>> +static int swiotlb_usage_open(struct inode *inode, struct file *filp)
>> +{
>> +	return single_open(filp, swiotlb_usage_show, NULL);
>> +}
>> +
>> +static const struct file_operations swiotlb_usage_fops = {
>> +	.open           = swiotlb_usage_open,
>> +	.read           = seq_read,
>> +	.llseek         = seq_lseek,
>> +	.release        = single_release,
>> +};
>> +
>> +void swiotlb_create_debugfs(void)
>> +{
>> +	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
>> +
>> +	if (!d_swiotlb_usage)
>> +		return;
>> +
>> +	debugfs_create_file("usage", 0600, d_swiotlb_usage,
>> +			    NULL, &swiotlb_usage_fops);
>> +}
>> +
>> +#endif
>> +
>>  static int __init
>>  setup_io_tlb_npages(char *str)
>>  {
>> @@ -449,6 +494,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>  		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
>>  			     sme_active() ? "SME" : "SEV");
>>  
>> +#ifdef CONFIG_DEBUG_FS
>> +	if (unlikely(!d_swiotlb_usage))
>> +		swiotlb_create_debugfs();
>> +#endif
>> +
>>  	mask = dma_get_seg_boundary(hwdev);
>>  
>>  	tbl_dma_addr &= mask;
>> @@ -528,6 +578,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>>  	return SWIOTLB_MAP_ERROR;
>>  found:
>> +#ifdef CONFIG_DEBUG_FS
>> +	io_tlb_used += nslots;
>> +#endif
>>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>>  
>>  	/*
>> @@ -588,6 +641,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>>  		 */
>>  		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
>>  			io_tlb_list[i] = ++count;
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +		io_tlb_used -= nslots;
>> +#endif
>>  	}
>>  	spin_unlock_irqrestore(&io_tlb_lock, flags);
>>  }
>>
> 
> 
