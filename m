Return-Path: <fbarrat@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZqPl0tANJzDI6LNkbZj3v6v9HqCvJAJBjcQpzA9F/Y7XxFz3YrB+avztcmwoOxgABurLPGd
ARC-Seal: i=1; a=rsa-sha256; t=1526034276; cv=none;
        d=google.com; s=arc-20160816;
        b=QltYhhc/LNfhzG3cOxgT7KyT1/omSUzStvBvhLp/TI58068yNzNlMVjpQ8qa6CnAF2
         pCQc4SI7cM/+H8yLcIwz7aLJ85KlpsG3VA7mnVV9EBD1KV9E8BCw5JNLfCtBQGnJ1Aiu
         3HhNkmDiTDijH+8pVBIG7y+pFxPyfVa7WjAK5BPu7Mep1no1XnxaNZTeC4pYJOmWCO/5
         6JblpAnZtlW6SsAmIfj/g5m+au4XTPKNdHISZ3kFIbGdhwDPblU0WsFN3GoxrIy8K5uj
         GjIXRXVsjKzGGott9A6po//tY/s6q2eWFUr8wDtik+3zP8vqpBPiam22vljSzvRrfJpQ
         uuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=fwtCl12raWMZHM5sKKAQGoPc8y3RGBv+kZLiCAEgj2g=;
        b=gZIxiDVNq+xWJrv/8LAm43sgOQxOrqCPpKfj7NVRWUBGT53Rf41SPwDDo3ho+0S1EH
         h3LuJn0OYMvc3BcRrZNXnLmPLMaXeJeLHFvOEIkyH6Tw+Tv2VanmJkrf29nZUpJcD1y5
         /dFNCrx2VFOZoqgTwOJpY+t5DhW4NNdq3vBcp0M550eBRDqORe1JIMhIzKiCRZBgtfIV
         BVlEwivUFfT/o8BxxURciRm6KxTLrv0me6CMIwqVMlK/68U5rgeFwfhiIEJqhZ0EPso5
         M0NeZgQoKE6mwPO55BVQODZlWSAnWCrvOSubcZfwOHiOlnnFNz6NM7D49BJgomGWaCv4
         UWLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fbarrat@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=fbarrat@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] misc: cxl: Change return type to vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>, fbarrat@linux.vnet.ibm.com,
        andrew.donnellan@au1.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
References: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 11 May 2018 12:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417145354.GA31451@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051110-0040-0000-0000-0000043888AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051110-0041-0000-0000-0000263CD12B
Message-Id: <efed6e3d-b40b-9a96-4e7a-f5409c03c54f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598005414798688515?=
X-GMAIL-MSGID: =?utf-8?q?1600162917846102148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 17/04/2018 à 16:53, Souptick Joarder a écrit :
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Reference id -> 1c8f422059ae ("mm: change return type to
> vm_fault_t")
> 
> previously cxl_mmap_fault returns VM_FAULT_NOPAGE as
> default value irrespective of vm_insert_pfn() return
> value. This bug is fixed with new vmf_insert_pfn()
> which will return VM_FAULT_ type based on err.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---

It looks ok, and it passed some basic testing.

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred


>   drivers/misc/cxl/context.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index 7ff315a..c6ec872 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -128,11 +128,12 @@ void cxl_context_set_mapping(struct cxl_context *ctx,
>   	mutex_unlock(&ctx->mapping_lock);
>   }
> 
> -static int cxl_mmap_fault(struct vm_fault *vmf)
> +static vm_fault_t cxl_mmap_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct cxl_context *ctx = vma->vm_file->private_data;
>   	u64 area, offset;
> +	vm_fault_t ret;
> 
>   	offset = vmf->pgoff << PAGE_SHIFT;
> 
> @@ -169,11 +170,11 @@ static int cxl_mmap_fault(struct vm_fault *vmf)
>   		return VM_FAULT_SIGBUS;
>   	}
> 
> -	vm_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);
> +	ret = vmf_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);
> 
>   	mutex_unlock(&ctx->status_mutex);
> 
> -	return VM_FAULT_NOPAGE;
> +	return ret;
>   }
> 
>   static const struct vm_operations_struct cxl_mmap_vmops = {
> --
> 1.9.1
> 
