Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65164208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65164208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeGaFkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:40:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727097AbeGaFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:39:59 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6V3xxAd058257
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:01:46 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kjgb583ce-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:01:46 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Tue, 31 Jul 2018 05:01:44 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Jul 2018 05:01:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6V41c6c38863028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Jul 2018 04:01:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB549A405D;
        Tue, 31 Jul 2018 07:01:49 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF44DA4055;
        Tue, 31 Jul 2018 07:01:45 +0100 (BST)
Received: from [9.202.14.95] (unknown [9.202.14.95])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jul 2018 07:01:45 +0100 (BST)
Subject: Re: [RFC 1/4] virtio: Define virtio_direct_dma_ops structure
To:     Christoph Hellwig <hch@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-2-khandual@linux.vnet.ibm.com>
 <20180730092419.GA26245@infradead.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        mst@redhat.com, linuxram@us.ibm.com, haren@linux.vnet.ibm.com,
        paulus@samba.org, srikar@linux.vnet.ibm.com
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Tue, 31 Jul 2018 09:31:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180730092419.GA26245@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18073104-4275-0000-0000-000002A10B27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073104-4276-0000-0000-000037A91999
Message-Id: <fd5738a9-163c-f1ab-c646-12b6367eeded@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 02:54 PM, Christoph Hellwig wrote:
>> +/*
>> + * Virtio direct mapping DMA API operations structure
>> + *
>> + * This defines DMA API structure for all virtio devices which would not
>> + * either bring in their own DMA OPS from architecture or they would not
>> + * like to use architecture specific IOMMU based DMA OPS because QEMU
>> + * expects GPA instead of an IOVA in absence of VIRTIO_F_IOMMU_PLATFORM.
>> + */
>> +dma_addr_t virtio_direct_map_page(struct device *dev, struct page *page,
>> +			    unsigned long offset, size_t size,
>> +			    enum dma_data_direction dir,
>> +			    unsigned long attrs)
> 
> All these functions should probably be marked static.

Sure.

> 
>> +void virtio_direct_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>> +			size_t size, enum dma_data_direction dir,
>> +			unsigned long attrs)
>> +{
>> +}
> 
> No need to implement no-op callbacks in struct dma_map_ops.

Okay.

> 
>> +
>> +int virtio_direct_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>> +{
>> +	return 0;
>> +}
> 
> Including this one.
> 
>> +void *virtio_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>> +		gfp_t gfp, unsigned long attrs)
>> +{
>> +	void *queue = alloc_pages_exact(PAGE_ALIGN(size), gfp);
>> +
>> +	if (queue) {
>> +		phys_addr_t phys_addr = virt_to_phys(queue);
>> +		*dma_handle = (dma_addr_t)phys_addr;
>> +
>> +		if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
>> +			free_pages_exact(queue, PAGE_ALIGN(size));
>> +			return NULL;
>> +		}
>> +	}
>> +	return queue;
> 
> queue is a very odd name in a generic memory allocator.

Will change it to addr.

> 
>> +void virtio_direct_free(struct device *dev, size_t size, void *vaddr,
>> +		dma_addr_t dma_addr, unsigned long attrs)
>> +{
>> +	free_pages_exact(vaddr, PAGE_ALIGN(size));
>> +}
>> +
>> +const struct dma_map_ops virtio_direct_dma_ops = {
>> +	.alloc			= virtio_direct_alloc,
>> +	.free			= virtio_direct_free,
>> +	.map_page		= virtio_direct_map_page,
>> +	.unmap_page		= virtio_direct_unmap_page,
>> +	.mapping_error		= virtio_direct_mapping_error,
>> +};
> 
> This is missing a dma_map_sg implementation.  In general this is
> mandatory for dma_ops.  So either you implement it or explain in
> a common why you think you can skip it.

Hmm. IIUC virtio core never used dma_map_sg(). Am I missing something
here ? The only reference to dma_map_sg() is inside a comment.

$git grep dma_map_sg drivers/virtio/
drivers/virtio/virtio_ring.c:    * We can't use dma_map_sg, because we don't use scatterlists in

> 
>> +EXPORT_SYMBOL(virtio_direct_dma_ops);
> 
> EXPORT_SYMBOL_GPL like all virtio symbols, please.

I am planning to drop EXPORT_SYMBOL from virtio_direct_dma_ops structure.

