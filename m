Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FE022360
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FE022360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeKOLxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:53:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbeKOLxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:53:39 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAF1hf09069247
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 20:47:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nrx8rac4b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 20:47:53 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 15 Nov 2018 01:47:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 15 Nov 2018 01:47:46 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAF1ljrc47841324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 01:47:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9757A52057;
        Thu, 15 Nov 2018 01:47:45 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.206])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 5BFFF52050;
        Thu, 15 Nov 2018 01:47:42 +0000 (GMT)
Date:   Wed, 14 Nov 2018 17:47:38 -0800
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        vbabka@suse.cz, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: Create the new vm_fault_t type
References: <20181106120544.GA3783@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106120544.GA3783@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18111501-0028-0000-0000-0000031A169F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111501-0029-0000-0000-000023D68429
Message-Id: <20181115014737.GA2353@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_20:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 05:36:42PM +0530, Souptick Joarder wrote:
> Page fault handlers are supposed to return VM_FAULT codes,
> but some drivers/file systems mistakenly return error
> numbers. Now that all drivers/file systems have been converted
> to use the vm_fault_t return type, change the type definition
> to no longer be compatible with 'int'. By making it an unsigned
> int, the function prototype becomes incompatible with a function
> which returns int. Sparse will detect any attempts to return a
> value which is not a VM_FAULT code.
> 
> VM_FAULT_SET_HINDEX and VM_FAULT_GET_HINDEX values are changed
> to avoid conflict with other VM_FAULT codes.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

For the docs part
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v2: Updated the change log and corrected the document part.
>     name added to the enum that kernel-doc able to parse it.
> 
> v3: Corrected the documentation.
> 
>  include/linux/mm.h       | 46 ------------------------------
>  include/linux/mm_types.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 47 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fcf9cc9..511a3ce 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1267,52 +1267,6 @@ static inline void clear_page_pfmemalloc(struct page *page)
>  }
>  
>  /*
> - * Different kinds of faults, as returned by handle_mm_fault().
> - * Used to decide whether a process gets delivered SIGBUS or
> - * just gets major/minor fault counters bumped up.
> - */
> -
> -#define VM_FAULT_OOM	0x0001
> -#define VM_FAULT_SIGBUS	0x0002
> -#define VM_FAULT_MAJOR	0x0004
> -#define VM_FAULT_WRITE	0x0008	/* Special case for get_user_pages */
> -#define VM_FAULT_HWPOISON 0x0010	/* Hit poisoned small page */
> -#define VM_FAULT_HWPOISON_LARGE 0x0020  /* Hit poisoned large page. Index encoded in upper bits */
> -#define VM_FAULT_SIGSEGV 0x0040
> -
> -#define VM_FAULT_NOPAGE	0x0100	/* ->fault installed the pte, not return page */
> -#define VM_FAULT_LOCKED	0x0200	/* ->fault locked the returned page */
> -#define VM_FAULT_RETRY	0x0400	/* ->fault blocked, must retry */
> -#define VM_FAULT_FALLBACK 0x0800	/* huge page fault failed, fall back to small */
> -#define VM_FAULT_DONE_COW   0x1000	/* ->fault has fully handled COW */
> -#define VM_FAULT_NEEDDSYNC  0x2000	/* ->fault did not modify page tables
> -					 * and needs fsync() to complete (for
> -					 * synchronous page faults in DAX) */
> -
> -#define VM_FAULT_ERROR	(VM_FAULT_OOM | VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV | \
> -			 VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE | \
> -			 VM_FAULT_FALLBACK)
> -
> -#define VM_FAULT_RESULT_TRACE \
> -	{ VM_FAULT_OOM,			"OOM" }, \
> -	{ VM_FAULT_SIGBUS,		"SIGBUS" }, \
> -	{ VM_FAULT_MAJOR,		"MAJOR" }, \
> -	{ VM_FAULT_WRITE,		"WRITE" }, \
> -	{ VM_FAULT_HWPOISON,		"HWPOISON" }, \
> -	{ VM_FAULT_HWPOISON_LARGE,	"HWPOISON_LARGE" }, \
> -	{ VM_FAULT_SIGSEGV,		"SIGSEGV" }, \
> -	{ VM_FAULT_NOPAGE,		"NOPAGE" }, \
> -	{ VM_FAULT_LOCKED,		"LOCKED" }, \
> -	{ VM_FAULT_RETRY,		"RETRY" }, \
> -	{ VM_FAULT_FALLBACK,		"FALLBACK" }, \
> -	{ VM_FAULT_DONE_COW,		"DONE_COW" }, \
> -	{ VM_FAULT_NEEDDSYNC,		"NEEDDSYNC" }
> -
> -/* Encode hstate index for a hwpoisoned large page */
> -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
> -
> -/*
>   * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
>   */
>  extern void pagefault_out_of_memory(void);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ed8f62..cb25016 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -22,7 +22,6 @@
>  #endif
>  #define AT_VECTOR_SIZE (2*(AT_VECTOR_SIZE_ARCH + AT_VECTOR_SIZE_BASE + 1))
>  
> -typedef int vm_fault_t;
>  
>  struct address_space;
>  struct mem_cgroup;
> @@ -609,6 +608,78 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
>  
>  struct vm_fault;
>  
> +/**
> + * typedef vm_fault_t - Return type for page fault handlers.
> + *
> + * Page fault handlers return a bitmask of %VM_FAULT values.
> + */
> +typedef __bitwise unsigned int vm_fault_t;
> +
> +/**
> + * enum vm_fault_reason - Page fault handlers return a bitmask of
> + * these values to tell the core VM what happened when handling the
> + * fault. Used to decide whether a process gets delivered SIGBUS or
> + * just gets major/minor fault counters bumped up.
> + *
> + * @VM_FAULT_OOM:		Out Of Memory
> + * @VM_FAULT_SIGBUS:		Bad access
> + * @VM_FAULT_MAJOR:		Page read from storage
> + * @VM_FAULT_WRITE:		Special case for get_user_pages
> + * @VM_FAULT_HWPOISON:		Hit poisoned small page
> + * @VM_FAULT_HWPOISON_LARGE:	Hit poisoned large page. Index encoded
> + *				in upper bits
> + * @VM_FAULT_SIGSEGV:		segmentation fault
> + * @VM_FAULT_NOPAGE:		->fault installed the pte, not return page
> + * @VM_FAULT_LOCKED:		->fault locked the returned page
> + * @VM_FAULT_RETRY:		->fault blocked, must retry
> + * @VM_FAULT_FALLBACK:		huge page fault failed, fall back to small
> + * @VM_FAULT_DONE_COW:		->fault has fully handled COW
> + * @VM_FAULT_NEEDDSYNC:		->fault did not modify page tables and needs
> + *				fsync() to complete (for synchronous page faults
> + *				in DAX)
> + * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
> + *
> + */
> +enum vm_fault_reason {
> +	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
> +	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
> +	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
> +	VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,
> +	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
> +	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
> +	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
> +	VM_FAULT_NOPAGE         = (__force vm_fault_t)0x000100,
> +	VM_FAULT_LOCKED         = (__force vm_fault_t)0x000200,
> +	VM_FAULT_RETRY          = (__force vm_fault_t)0x000400,
> +	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
> +	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
> +	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
> +	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
> +};
> +
> +/* Encode hstate index for a hwpoisoned large page */
> +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
> +
> +#define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |	\
> +			VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |	\
> +			VM_FAULT_HWPOISON_LARGE | VM_FAULT_FALLBACK)
> +
> +#define VM_FAULT_RESULT_TRACE \
> +	{ VM_FAULT_OOM,                 "OOM" },	\
> +	{ VM_FAULT_SIGBUS,              "SIGBUS" },	\
> +	{ VM_FAULT_MAJOR,               "MAJOR" },	\
> +	{ VM_FAULT_WRITE,               "WRITE" },	\
> +	{ VM_FAULT_HWPOISON,            "HWPOISON" },	\
> +	{ VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },	\
> +	{ VM_FAULT_SIGSEGV,             "SIGSEGV" },	\
> +	{ VM_FAULT_NOPAGE,              "NOPAGE" },	\
> +	{ VM_FAULT_LOCKED,              "LOCKED" },	\
> +	{ VM_FAULT_RETRY,               "RETRY" },	\
> +	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
> +	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
> +	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
> +
>  struct vm_special_mapping {
>  	const char *name;	/* The name, e.g. "[vdso]". */
>  
> -- 
> 1.9.1
> 

-- 
Sincerely yours,
Mike.

