Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF480ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7031521526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7031521526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJQPZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:25:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbeJQPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:25:21 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9H7UdGw103496
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 03:30:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n5vb9u903-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 03:30:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 17 Oct 2018 08:30:56 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Oct 2018 08:30:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9H7Un9Q7864630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Oct 2018 07:30:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89406A4059;
        Wed, 17 Oct 2018 07:30:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B75CA405D;
        Wed, 17 Oct 2018 07:30:48 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.72])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 17 Oct 2018 07:30:48 +0000 (GMT)
Date:   Wed, 17 Oct 2018 10:30:46 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Pavel Tatashin <pasha.tatashin@gmail.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, davem@davemloft.net,
        yi.z.zhang@linux.intel.com, khalid.aziz@oracle.com,
        rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [mm PATCH v3 1/6] mm: Use mm_zero_struct_page from SPARC on all
 64b architectures
References: <20181015202456.2171.88406.stgit@localhost.localdomain>
 <20181015202656.2171.92963.stgit@localhost.localdomain>
 <57c559f6-4858-7a52-7fbb-979caa08f240@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c559f6-4858-7a52-7fbb-979caa08f240@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18101707-0028-0000-0000-000003088D78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101707-0029-0000-0000-000023C39E46
Message-Id: <20181017073045.GA20004@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:01:11PM -0400, Pavel Tatashin wrote:
> 
> 
> On 10/15/18 4:26 PM, Alexander Duyck wrote:
> > This change makes it so that we use the same approach that was already in
> > use on Sparc on all the archtectures that support a 64b long.
> > 
> > This is mostly motivated by the fact that 8 to 10 store/move instructions
> > are likely always going to be faster than having to call into a function
> > that is not specialized for handling page init.
> > 
> > An added advantage to doing it this way is that the compiler can get away
> > with combining writes in the __init_single_page call. As a result the
> > memset call will be reduced to only about 4 write operations, or at least
> > that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
> > count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
> > my system.
> > 
> > One change I had to make to the function was to reduce the minimum page
> > size to 56 to support some powerpc64 configurations.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> 
> I have tested on Broadcom's Stingray cpu with 48G RAM:
> __init_single_page() takes 19.30ns / 64-byte struct page
> Wit the change it takes 17.33ns / 64-byte struct page
 
I gave it a run on an OpenPower (S812LC 8348-21C) with Power8 processor and
with 128G of RAM. My results for 64-byte struct page were:

before: 4.6788ns
after: 4.5882ns

My two cents :)

> Please add this data and also the data from Intel to the description.
> 
> Thank you,
> Pavel
> 
> > ---
> >  arch/sparc/include/asm/pgtable_64.h |   30 ------------------------------
> >  include/linux/mm.h                  |   34 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 30 deletions(-)
> > 
> > diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> > index 1393a8ac596b..22500c3be7a9 100644
> > --- a/arch/sparc/include/asm/pgtable_64.h
> > +++ b/arch/sparc/include/asm/pgtable_64.h
> > @@ -231,36 +231,6 @@
> >  extern struct page *mem_map_zero;
> >  #define ZERO_PAGE(vaddr)	(mem_map_zero)
> >  
> > -/* This macro must be updated when the size of struct page grows above 80
> > - * or reduces below 64.
> > - * The idea that compiler optimizes out switch() statement, and only
> > - * leaves clrx instructions
> > - */
> > -#define	mm_zero_struct_page(pp) do {					\
> > -	unsigned long *_pp = (void *)(pp);				\
> > -									\
> > -	 /* Check that struct page is either 64, 72, or 80 bytes */	\
> > -	BUILD_BUG_ON(sizeof(struct page) & 7);				\
> > -	BUILD_BUG_ON(sizeof(struct page) < 64);				\
> > -	BUILD_BUG_ON(sizeof(struct page) > 80);				\
> > -									\
> > -	switch (sizeof(struct page)) {					\
> > -	case 80:							\
> > -		_pp[9] = 0;	/* fallthrough */			\
> > -	case 72:							\
> > -		_pp[8] = 0;	/* fallthrough */			\
> > -	default:							\
> > -		_pp[7] = 0;						\
> > -		_pp[6] = 0;						\
> > -		_pp[5] = 0;						\
> > -		_pp[4] = 0;						\
> > -		_pp[3] = 0;						\
> > -		_pp[2] = 0;						\
> > -		_pp[1] = 0;						\
> > -		_pp[0] = 0;						\
> > -	}								\
> > -} while (0)
> > -
> >  /* PFNs are real physical page numbers.  However, mem_map only begins to record
> >   * per-page information starting at pfn_base.  This is to handle systems where
> >   * the first physical page in the machine is at some huge physical address,
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index bb0de406f8e7..ec6e57a0c14e 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -102,8 +102,42 @@ static inline void set_max_mapnr(unsigned long limit) { }
> >   * zeroing by defining this macro in <asm/pgtable.h>.
> >   */
> 
> The comment above becomes outdated. Please change, we use optimized
> mm_zero_struct_page on every 64-bit platform.
> 
> >  #ifndef mm_zero_struct_page
> > +#if BITS_PER_LONG == 64
> > +/* This function must be updated when the size of struct page grows above 80
> > + * or reduces below 64. The idea that compiler optimizes out switch()
> > + * statement, and only leaves move/store instructions
> > + */
> > +#define	mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
> > +static inline void __mm_zero_struct_page(struct page *page)
> > +{
> > +	unsigned long *_pp = (void *)page;
> > +
> > +	 /* Check that struct page is either 56, 64, 72, or 80 bytes */
> > +	BUILD_BUG_ON(sizeof(struct page) & 7);
> > +	BUILD_BUG_ON(sizeof(struct page) < 56);
> > +	BUILD_BUG_ON(sizeof(struct page) > 80);
> > +
> > +	switch (sizeof(struct page)) {
> > +	case 80:
> > +		_pp[9] = 0;	/* fallthrough */
> > +	case 72:
> > +		_pp[8] = 0;	/* fallthrough */
> > +	default:
> > +		_pp[7] = 0;	/* fallthrough */
> > +	case 56:
> > +		_pp[6] = 0;
> > +		_pp[5] = 0;
> > +		_pp[4] = 0;
> > +		_pp[3] = 0;
> > +		_pp[2] = 0;
> > +		_pp[1] = 0;
> > +		_pp[0] = 0;
> > +	}
> > +}
> > +#else
> >  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
> >  #endif
> > +#endif
> >  
> >  /*
> >   * Default maximum number of active map areas, this limits the number of vmas
> > 
> 

-- 
Sincerely yours,
Mike.

