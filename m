Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67150C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E292208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E292208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755413AbeFNQJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:09:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21353 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755069AbeFNQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:09:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5EG8v24079429
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:09:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jkrxy9327-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:08:58 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Thu, 14 Jun 2018 17:07:02 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Jun 2018 17:06:59 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5EG6xjX27656418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jun 2018 16:06:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 110B911C054;
        Thu, 14 Jun 2018 16:57:32 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82D8411C050;
        Thu, 14 Jun 2018 16:57:30 +0100 (BST)
Received: from [9.164.160.4] (unknown [9.164.160.4])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jun 2018 16:57:30 +0100 (BST)
Subject: Re: [PATCH] misc: ocxl: Change return type for fault handler
To:     Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org,
        fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com
References: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Thu, 14 Jun 2018 18:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18061416-4275-0000-0000-0000028DC763
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061416-4276-0000-0000-00003794F772
Message-Id: <5c6942da-c847-c53a-a571-4ec96f2a993d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806140176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/06/2018 à 22:29, Souptick Joarder a écrit :
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> There is an existing bug when vm_insert_pfn() can return
> ENOMEM which was ignored and VM_FAULT_NOPAGE returned as
> default. The new inline vmf_insert_pfn() has removed
> this inefficiency by returning correct vm_fault_ type.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---

Thanks!

Tested and
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/misc/ocxl/context.c | 22 +++++++++++-----------
>   drivers/misc/ocxl/sysfs.c   |  5 ++---
>   2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
> index 909e880..98daf91 100644
> --- a/drivers/misc/ocxl/context.c
> +++ b/drivers/misc/ocxl/context.c
> @@ -83,7 +83,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
>   	return rc;
>   }
> 
> -static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
> +static vm_fault_t map_afu_irq(struct vm_area_struct *vma, unsigned long address,
>   		u64 offset, struct ocxl_context *ctx)
>   {
>   	u64 trigger_addr;
> @@ -92,15 +92,15 @@ static int map_afu_irq(struct vm_area_struct *vma, unsigned long address,
>   	if (!trigger_addr)
>   		return VM_FAULT_SIGBUS;
> 
> -	vm_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
> -	return VM_FAULT_NOPAGE;
> +	return vmf_insert_pfn(vma, address, trigger_addr >> PAGE_SHIFT);
>   }
> 
> -static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
> +static vm_fault_t map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
>   		u64 offset, struct ocxl_context *ctx)
>   {
>   	u64 pp_mmio_addr;
>   	int pasid_off;
> +	vm_fault_t ret;
> 
>   	if (offset >= ctx->afu->config.pp_mmio_stride)
>   		return VM_FAULT_SIGBUS;
> @@ -118,27 +118,27 @@ static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
>   		pasid_off * ctx->afu->config.pp_mmio_stride +
>   		offset;
> 
> -	vm_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
> +	ret = vmf_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
>   	mutex_unlock(&ctx->status_mutex);
> -	return VM_FAULT_NOPAGE;
> +	return ret;
>   }
> 
> -static int ocxl_mmap_fault(struct vm_fault *vmf)
> +static vm_fault_t ocxl_mmap_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct ocxl_context *ctx = vma->vm_file->private_data;
>   	u64 offset;
> -	int rc;
> +	vm_fault_t ret;
> 
>   	offset = vmf->pgoff << PAGE_SHIFT;
>   	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
>   		ctx->pasid, vmf->address, offset);
> 
>   	if (offset < ctx->afu->irq_base_offset)
> -		rc = map_pp_mmio(vma, vmf->address, offset, ctx);
> +		ret = map_pp_mmio(vma, vmf->address, offset, ctx);
>   	else
> -		rc = map_afu_irq(vma, vmf->address, offset, ctx);
> -	return rc;
> +		ret = map_afu_irq(vma, vmf->address, offset, ctx);
> +	return ret;
>   }
> 
>   static const struct vm_operations_struct ocxl_vmops = {
> diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
> index d9753a1..0ab1fd1 100644
> --- a/drivers/misc/ocxl/sysfs.c
> +++ b/drivers/misc/ocxl/sysfs.c
> @@ -64,7 +64,7 @@ static ssize_t global_mmio_read(struct file *filp, struct kobject *kobj,
>   	return count;
>   }
> 
> -static int global_mmio_fault(struct vm_fault *vmf)
> +static vm_fault_t global_mmio_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct ocxl_afu *afu = vma->vm_private_data;
> @@ -75,8 +75,7 @@ static int global_mmio_fault(struct vm_fault *vmf)
> 
>   	offset = vmf->pgoff;
>   	offset += (afu->global_mmio_start >> PAGE_SHIFT);
> -	vm_insert_pfn(vma, vmf->address, offset);
> -	return VM_FAULT_NOPAGE;
> +	return vmf_insert_pfn(vma, vmf->address, offset);
>   }
> 
>   static const struct vm_operations_struct global_mmio_vmops = {
> 

