Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8EAD2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E66208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E66208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbeFLEji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:39:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752832AbeFLEjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:39:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C4cudM070151
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 00:39:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jj3cf86dm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 00:39:36 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Tue, 12 Jun 2018 05:39:34 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 05:39:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C4dUDq14352400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 04:39:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 219EAAE057;
        Tue, 12 Jun 2018 05:28:22 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80015AE04D;
        Tue, 12 Jun 2018 05:28:21 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 05:28:21 +0100 (BST)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 33CD1A0123;
        Tue, 12 Jun 2018 14:39:28 +1000 (AEST)
Subject: Re: [PATCH] misc: ocxl: Change return type for fault handler
To:     Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org,
        fbarrat@linux.vnet.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     brajeswar.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
References: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Tue, 12 Jun 2018 14:39:27 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611202904.GA25538@jordon-HP-15-Notebook-PC>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 18061204-4275-0000-0000-0000028CB356
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061204-4276-0000-0000-00003793D58E
Message-Id: <86dcb0d4-0539-13e3-1eb2-8e2482e8c07b@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/18 06:29, Souptick Joarder wrote:
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

Looks okay to me

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

