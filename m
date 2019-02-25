Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27702C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F8B20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfBYP6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:58:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727688AbfBYP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:58:49 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PFwbmx011495
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:58:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qvj8jcft1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:58:48 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Feb 2019 15:58:46 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 15:58:41 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PFwfi132637032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 15:58:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2DE542045;
        Mon, 25 Feb 2019 15:58:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DF2C4204C;
        Mon, 25 Feb 2019 15:58:39 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.26])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Feb 2019 15:58:38 +0000 (GMT)
Date:   Mon, 25 Feb 2019 17:58:37 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 10/26] userfaultfd: wp: add UFFDIO_COPY_MODE_WP
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-11-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022515-0028-0000-0000-0000034CCDF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022515-0029-0000-0000-0000240B1DE9
Message-Id: <20190225155836.GD24917@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:16AM +0800, Peter Xu wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> This allows UFFDIO_COPY to map pages wrprotected.
                                       write protected please :)
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Except for two additional nits below

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  fs/userfaultfd.c                 |  5 +++--
>  include/linux/userfaultfd_k.h    |  2 +-
>  include/uapi/linux/userfaultfd.h | 11 +++++-----
>  mm/userfaultfd.c                 | 36 ++++++++++++++++++++++----------
>  4 files changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index b397bc3b954d..3092885c9d2c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1683,11 +1683,12 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>  	ret = -EINVAL;
>  	if (uffdio_copy.src + uffdio_copy.len <= uffdio_copy.src)
>  		goto out;
> -	if (uffdio_copy.mode & ~UFFDIO_COPY_MODE_DONTWAKE)
> +	if (uffdio_copy.mode & ~(UFFDIO_COPY_MODE_DONTWAKE|UFFDIO_COPY_MODE_WP))
>  		goto out;
>  	if (mmget_not_zero(ctx->mm)) {
>  		ret = mcopy_atomic(ctx->mm, uffdio_copy.dst, uffdio_copy.src,
> -				   uffdio_copy.len, &ctx->mmap_changing);
> +				   uffdio_copy.len, &ctx->mmap_changing,
> +				   uffdio_copy.mode);
>  		mmput(ctx->mm);
>  	} else {
>  		return -ESRCH;
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index c6590c58ce28..765ce884cec0 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -34,7 +34,7 @@ extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
> 
>  extern ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
>  			    unsigned long src_start, unsigned long len,
> -			    bool *mmap_changing);
> +			    bool *mmap_changing, __u64 mode);
>  extern ssize_t mfill_zeropage(struct mm_struct *dst_mm,
>  			      unsigned long dst_start,
>  			      unsigned long len,
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 48f1a7c2f1f0..297cb044c03f 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -203,13 +203,14 @@ struct uffdio_copy {
>  	__u64 dst;
>  	__u64 src;
>  	__u64 len;
> +#define UFFDIO_COPY_MODE_DONTWAKE		((__u64)1<<0)
>  	/*
> -	 * There will be a wrprotection flag later that allows to map
> -	 * pages wrprotected on the fly. And such a flag will be
> -	 * available if the wrprotection ioctl are implemented for the
> -	 * range according to the uffdio_register.ioctls.
> +	 * UFFDIO_COPY_MODE_WP will map the page wrprotected on the
> +	 * fly. UFFDIO_COPY_MODE_WP is available only if the
> +	 * wrprotection ioctl are implemented for the range according

                             ^ is

> +	 * to the uffdio_register.ioctls.
>  	 */
> -#define UFFDIO_COPY_MODE_DONTWAKE		((__u64)1<<0)
> +#define UFFDIO_COPY_MODE_WP			((__u64)1<<1)
>  	__u64 mode;
> 
>  	/*
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index d59b5a73dfb3..73a208c5c1e7 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -25,7 +25,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			    struct vm_area_struct *dst_vma,
>  			    unsigned long dst_addr,
>  			    unsigned long src_addr,
> -			    struct page **pagep)
> +			    struct page **pagep,
> +			    bool wp_copy)
>  {
>  	struct mem_cgroup *memcg;
>  	pte_t _dst_pte, *dst_pte;
> @@ -71,9 +72,9 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (mem_cgroup_try_charge(page, dst_mm, GFP_KERNEL, &memcg, false))
>  		goto out_release;
> 
> -	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
> -	if (dst_vma->vm_flags & VM_WRITE)
> -		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
> +	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
> +	if (dst_vma->vm_flags & VM_WRITE && !wp_copy)
> +		_dst_pte = pte_mkwrite(_dst_pte);
> 
>  	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
>  	if (dst_vma->vm_file) {
> @@ -399,7 +400,8 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  						unsigned long dst_addr,
>  						unsigned long src_addr,
>  						struct page **page,
> -						bool zeropage)
> +						bool zeropage,
> +						bool wp_copy)
>  {
>  	ssize_t err;
> 
> @@ -416,11 +418,13 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  	if (!(dst_vma->vm_flags & VM_SHARED)) {
>  		if (!zeropage)
>  			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
> -					       dst_addr, src_addr, page);
> +					       dst_addr, src_addr, page,
> +					       wp_copy);
>  		else
>  			err = mfill_zeropage_pte(dst_mm, dst_pmd,
>  						 dst_vma, dst_addr);
>  	} else {
> +		VM_WARN_ON(wp_copy); /* WP only available for anon */
>  		if (!zeropage)
>  			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
>  						     dst_vma, dst_addr,
> @@ -438,7 +442,8 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  					      unsigned long src_start,
>  					      unsigned long len,
>  					      bool zeropage,
> -					      bool *mmap_changing)
> +					      bool *mmap_changing,
> +					      __u64 mode)
>  {
>  	struct vm_area_struct *dst_vma;
>  	ssize_t err;
> @@ -446,6 +451,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  	unsigned long src_addr, dst_addr;
>  	long copied;
>  	struct page *page;
> +	bool wp_copy;
> 
>  	/*>  	 * Sanitize the command parameters:
> @@ -502,6 +508,14 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  	    dst_vma->vm_flags & VM_SHARED))
>  		goto out_unlock;
> 
> +	/*
> +	 * validate 'mode' now that we know the dst_vma: don't allow
> +	 * a wrprotect copy if the userfaultfd didn't register as WP.
> +	 */
> +	wp_copy = mode & UFFDIO_COPY_MODE_WP;
> +	if (wp_copy && !(dst_vma->vm_flags & VM_UFFD_WP))
> +		goto out_unlock;
> +
>  	/*
>  	 * If this is a HUGETLB vma, pass off to appropriate routine
>  	 */

I think for hugetlb we should return an error if wp_copy==true.
It might be worth adding wp_copy parameter to __mcopy_atomic_hugetlb() in
advance and return the error from there, in a hope it will also support
UFFD_WP some day :)

> @@ -557,7 +571,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  		BUG_ON(pmd_trans_huge(*dst_pmd));
> 
>  		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> -				       src_addr, &page, zeropage);
> +				       src_addr, &page, zeropage, wp_copy);
>  		cond_resched();
> 
>  		if (unlikely(err == -ENOENT)) {
> @@ -604,14 +618,14 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
> 
>  ssize_t mcopy_atomic(struct mm_struct *dst_mm, unsigned long dst_start,
>  		     unsigned long src_start, unsigned long len,
> -		     bool *mmap_changing)
> +		     bool *mmap_changing, __u64 mode)
>  {
>  	return __mcopy_atomic(dst_mm, dst_start, src_start, len, false,
> -			      mmap_changing);
> +			      mmap_changing, mode);
>  }
> 
>  ssize_t mfill_zeropage(struct mm_struct *dst_mm, unsigned long start,
>  		       unsigned long len, bool *mmap_changing)
>  {
> -	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing);
> +	return __mcopy_atomic(dst_mm, start, 0, len, true, mmap_changing, 0);
>  }
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

