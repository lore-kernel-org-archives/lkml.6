Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0622082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 06:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0622082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeKBP4E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:56:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727546AbeKBP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:56:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA26nSe7064730
        for <linux-kernel@vger.kernel.org>; Fri, 2 Nov 2018 02:49:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ngfwckgkd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 02:49:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 2 Nov 2018 06:49:54 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 2 Nov 2018 06:49:51 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA26noCF1376644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 06:49:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BCC942042;
        Fri,  2 Nov 2018 06:49:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCB9C42045;
        Fri,  2 Nov 2018 06:49:49 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.4.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Nov 2018 06:49:49 +0000 (GMT)
Date:   Fri, 2 Nov 2018 07:49:47 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Li Wang <liwang@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: s390: runtime warning about pgtables_bytes
In-Reply-To: <20181031195754.ypyhlvfab2ddx6sa@redhat.com>
References: <CAEemH2eExK_jwOPZDFBZkwABucpZqh+=s+qpN-tFfMzxwo7cZA@mail.gmail.com>
        <20181011150211.7d8c07ac@mschwideX1>
        <20181012170833.2a05f308@mschwideX1>
        <20181031195754.ypyhlvfab2ddx6sa@redhat.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18110206-0008-0000-0000-0000028A0389
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110206-0009-0000-0000-000021F42D84
Message-Id: <20181102074947.39d4244a@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 15:57:54 -0400
Joe Lawrence <joe.lawrence@redhat.com> wrote:

> On Fri, Oct 12, 2018 at 05:08:33PM +0200, Martin Schwidefsky wrote:
> > On Thu, 11 Oct 2018 15:02:11 +0200
> > Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >   
> > > On Thu, 11 Oct 2018 18:04:12 +0800
> > > Li Wang <liwang@redhat.com> wrote:
> > >   
> > > > When running s390 system with LTP/cve-2017-17052.c[1], the following BUG is
> > > > came out repeatedly.
> > > > I remember this warning start from kernel-4.16.0 and now it still exist in
> > > > kernel-4.19-rc7.
> > > > Can anyone take a look?
> > > > 
> > > > [ 2678.991496] BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > > [ 2679.001543] BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > > [ 2679.002453] BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > > [ 2679.003256] BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > > [ 2679.013689] BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > > [ 2679.024647] BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > > [ 2679.064408] BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > > [ 2679.133963] BUG: non-zero pgtables_bytes on freeing mm: 16384
> > > > 
> > > > [1]:
> > > > https://github.com/linux-test-project/ltp/blob/master/testcases/cve/cve-2017-17052.c    
> > >  
> > > Confirmed, I see this bug with cvs-2017-17052 on my LPAR as well.
> > > I'll look into it.  
> >  
> > Ok, I think I understand the problem now. This is the patch I am testing
> > right now. It seems to fix the issue, but I had to change common mm
> > code for it.
> > --  
> > >From 9e3bc2e96930206ef1ece377e45224c51aca1799 Mon Sep 17 00:00:00 2001  
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Date: Fri, 12 Oct 2018 16:32:29 +0200
> > Subject: [RFC][PATCH] s390/mm: fix mis-accounting of pgtable_bytes
> > 
> > In case a fork or a clone system fails in copy_process and the error
> > handling does the mmput() at the bad_fork_cleanup_mm label, the following
> > warning messages will appear on the console:
> > 
> > BUG: non-zero pgtables_bytes on freeing mm: 16384
> > 
> > The reason for that is the tricks we play with mm_inc_nr_puds() and
> > mm_inc_nr_pmds() in init_new_context().
> > 
> > A normal 64-bit process has 3 levels of page table, the p4d level and
> > the pud level are folded. On process termination the free_pud_range()
> > function in mm/memory.c will subtract 16KB from pgtable_bytes with a
> > mm_dec_nr_puds() call, but there actually is not really a pud table.
> > The s390 version of pud_free_tlb() recognized this an does nothing,
> > the region-3 table will be freed with the pgd_free() call later on.
> > But the mm_dec_nr_puds() is done unconditionally, to counter act this
> > the init_new_context() function has an extra mm_inc_nr_puds() call.
> > 
> > Now with a failed fork or clone the free_pgtables() function is not
> > called, there is no mm_dec_nr_puds() but the mm_inc_nr_puds() has
> > been done which leads to the incorrect pgtable_bytes of 16384.
> > Nothing is broken by this, but the warning is annoying.
> > 
> > To get rid of the warning drop the mm_inc_nr_pmds() & mm_inc_nr_puds()
> > calls from init_new_context(), introduce the mm_pmd_folded(),
> > pmd_pud_folded() and pmd_p4d_folded() helper, and add if-statements
> > to the functions mm_[inc|dec]_nr_[pmds|puds].
> > 
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > ---
> >  arch/s390/include/asm/mmu_context.h |  5 -----
> >  arch/s390/include/asm/pgalloc.h     |  6 ++---
> >  arch/s390/include/asm/pgtable.h     | 18 +++++++++++++++
> >  arch/s390/include/asm/tlb.h         |  6 ++---
> >  include/linux/mm.h                  | 44 ++++++++++++++++++++++++++++++++-----
> >  5 files changed, 62 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
> > index dbd689d556ce..ccbb53e22024 100644
> > --- a/arch/s390/include/asm/mmu_context.h
> > +++ b/arch/s390/include/asm/mmu_context.h
> > @@ -46,8 +46,6 @@ static inline int init_new_context(struct task_struct *tsk,
> >  		mm->context.asce_limit = STACK_TOP_MAX;
> >  		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
> >  				   _ASCE_USER_BITS | _ASCE_TYPE_REGION3;
> > -		/* pgd_alloc() did not account this pud */
> > -		mm_inc_nr_puds(mm);
> >  		break;
> >  	case -PAGE_SIZE:
> >  		/* forked 5-level task, set new asce with new_mm->pgd */
> > @@ -63,9 +61,6 @@ static inline int init_new_context(struct task_struct *tsk,
> >  		/* forked 2-level compat task, set new asce with new mm->pgd */
> >  		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
> >  				   _ASCE_USER_BITS | _ASCE_TYPE_SEGMENT;
> > -		/* pgd_alloc() did not account this pmd */
> > -		mm_inc_nr_pmds(mm);
> > -		mm_inc_nr_puds(mm);
> >  	}
> >  	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
> >  	return 0;
> > diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> > index f0f9bcf94c03..5ee733720a57 100644
> > --- a/arch/s390/include/asm/pgalloc.h
> > +++ b/arch/s390/include/asm/pgalloc.h
> > @@ -36,11 +36,11 @@ static inline void crst_table_init(unsigned long *crst, unsigned long entry)
> >  
> >  static inline unsigned long pgd_entry_type(struct mm_struct *mm)
> >  {
> > -	if (mm->context.asce_limit <= _REGION3_SIZE)
> > +	if (mm_pmd_folded(mm))
> >  		return _SEGMENT_ENTRY_EMPTY;
> > -	if (mm->context.asce_limit <= _REGION2_SIZE)
> > +	if (mm_pud_folded(mm))
> >  		return _REGION3_ENTRY_EMPTY;
> > -	if (mm->context.asce_limit <= _REGION1_SIZE)
> > +	if (mm_p4d_folded(mm))
> >  		return _REGION2_ENTRY_EMPTY;
> >  	return _REGION1_ENTRY_EMPTY;
> >  }
> > diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> > index 411d435e7a7d..063732414dfb 100644
> > --- a/arch/s390/include/asm/pgtable.h
> > +++ b/arch/s390/include/asm/pgtable.h
> > @@ -493,6 +493,24 @@ static inline int is_module_addr(void *addr)
> >  				   _REGION_ENTRY_PROTECT | \
> >  				   _REGION_ENTRY_NOEXEC)
> >  
> > +static inline bool mm_p4d_folded(struct mm_struct *mm)
> > +{
> > +	return mm->context.asce_limit <= _REGION1_SIZE;
> > +}
> > +#define mm_p4d_folded(mm) mm_p4d_folded(mm)
> > +
> > +static inline bool mm_pud_folded(struct mm_struct *mm)
> > +{
> > +	return mm->context.asce_limit <= _REGION2_SIZE;
> > +}
> > +#define mm_pud_folded(mm) mm_pud_folded(mm)
> > +
> > +static inline bool mm_pmd_folded(struct mm_struct *mm)
> > +{
> > +	return mm->context.asce_limit <= _REGION3_SIZE;
> > +}
> > +#define mm_pmd_folded(mm) mm_pmd_folded(mm)
> > +
> >  static inline int mm_has_pgste(struct mm_struct *mm)
> >  {
> >  #ifdef CONFIG_PGSTE
> > diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> > index 457b7ba0fbb6..b31c779cf581 100644
> > --- a/arch/s390/include/asm/tlb.h
> > +++ b/arch/s390/include/asm/tlb.h
> > @@ -136,7 +136,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> >  static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
> >  				unsigned long address)
> >  {
> > -	if (tlb->mm->context.asce_limit <= _REGION3_SIZE)
> > +	if (mm_pmd_folded(tlb->mm))
> >  		return;
> >  	pgtable_pmd_page_dtor(virt_to_page(pmd));
> >  	tlb_remove_table(tlb, pmd);
> > @@ -152,7 +152,7 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
> >  static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
> >  				unsigned long address)
> >  {
> > -	if (tlb->mm->context.asce_limit <= _REGION1_SIZE)
> > +	if (mm_p4d_folded(tlb->mm))
> >  		return;
> >  	tlb_remove_table(tlb, p4d);
> >  }
> > @@ -167,7 +167,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
> >  static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
> >  				unsigned long address)
> >  {
> > -	if (tlb->mm->context.asce_limit <= _REGION2_SIZE)
> > +	if (mm_pud_folded(tlb->mm))
> >  		return;
> >  	tlb_remove_table(tlb, pud);
> >  }
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0416a7204be3..1e4a045f19ec 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -105,6 +105,34 @@ extern int mmap_rnd_compat_bits __read_mostly;
> >  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
> >  #endif
> >  
> > +/*
> > + * On some architectures it depends on the mm if the p4d/pud or pmd
> > + * layer of the page table hierarchy is folded or not.
> > + */
> > +#ifndef mm_p4d_folded
> > +#define mm_p4d_folded(mm) mm_p4d_folded(mm)
> > +static inline bool mm_p4d_folded(struct mm_struct *mm)
> > +{
> > +	return __is_defined(__PAGETABLE_P4D_FOLDED);
> > +}
> > +#endif
> > +
> > +#ifndef mm_pud_folded
> > +#define mm_pud_folded(mm) mm_pud_folded(mm)
> > +static inline bool mm_pud_folded(struct mm_struct *mm)
> > +{
> > +	return __is_defined(__PAGETABLE_PUD_FOLDED);
> > +}
> > +#endif
> > +
> > +#ifndef mm_pmd_folded
> > +#define mm_pmd_folded(mm) mm_pmd_folded(mm)
> > +static inline bool mm_pmd_folded(struct mm_struct *mm)
> > +{
> > +	return __is_defined(__PAGETABLE_PMD_FOLDED);
> > +}
> > +#endif
> > +
> >  /*
> >   * Default maximum number of active map areas, this limits the number of vmas
> >   * per mm struct. Users can overwrite this number by sysctl but there is a
> > @@ -1710,7 +1738,7 @@ static inline int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
> >  int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address);
> >  #endif
> >  
> > -#if defined(__PAGETABLE_PUD_FOLDED) || !defined(CONFIG_MMU)
> > +#if !defined(CONFIG_MMU)
> >  static inline int __pud_alloc(struct mm_struct *mm, p4d_t *p4d,
> >  						unsigned long address)
> >  {
> > @@ -1724,16 +1752,18 @@ int __pud_alloc(struct mm_struct *mm, p4d_t *p4d, unsigned long address);
> >  
> >  static inline void mm_inc_nr_puds(struct mm_struct *mm)
> >  {
> > -	atomic_long_add(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
> > +	if (!mm_pud_folded(mm))
> > +		atomic_long_add(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
> >  }
> >  
> >  static inline void mm_dec_nr_puds(struct mm_struct *mm)
> >  {
> > -	atomic_long_sub(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
> > +	if (!mm_pud_folded(mm))
> > +		atomic_long_sub(PTRS_PER_PUD * sizeof(pud_t), &mm->pgtables_bytes);
> >  }
> >  #endif
> >  
> > -#if defined(__PAGETABLE_PMD_FOLDED) || !defined(CONFIG_MMU)
> > +#if !defined(CONFIG_MMU)
> >  static inline int __pmd_alloc(struct mm_struct *mm, pud_t *pud,
> >  						unsigned long address)
> >  {
> > @@ -1748,12 +1778,14 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address);
> >  
> >  static inline void mm_inc_nr_pmds(struct mm_struct *mm)
> >  {
> > -	atomic_long_add(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
> > +	if (!mm_pmd_folded(mm))
> > +		atomic_long_add(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
> >  }
> >  
> >  static inline void mm_dec_nr_pmds(struct mm_struct *mm)
> >  {
> > -	atomic_long_sub(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
> > +	if (!mm_pmd_folded(mm))
> > +		atomic_long_sub(PTRS_PER_PMD * sizeof(pmd_t), &mm->pgtables_bytes);
> >  }
> >  #endif
> >  
> > -- 
> > 2.16.4
> > 
> > 
> > --   
> 
> Hi Martin,
> 
> We've seen these "non-zero pgtable byte" complaints as well and I found
> this thread + test patch.  Looks good after applying and running the LTP
> cve-2017-17052 test over here.
> 
> Did this need further testing and/or review?  I didn't see it in the
> kernel/git/s390/linux.git tree so I thought I would ask.
> 
> Thanks,
> 
> -- Joe

I have sent a v3 of these patches and got some Acked-by from Kirill.
Waited for a few days and as there are no more comments, I will now
add them to the linux-s390 tree.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

