Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3670513-1526634920-2-5567862058365380084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526634919; b=FftRfsJyr7lkakLbvNyuwuiRVRxRPVcer3iqt1uFAzbmaLxKS/
    1N2YTrW8PDagwgA7V2fSGOZ2Dn+Mdi6rof53kv/sw1FfEaomIDARdxeEidkWMpgT
    94OcMFhVmq+hbEY30nYtzHDbPLGFLvXGOIML9oy4oqvA0cHWVg8CGwLxJM4ZleWo
    NVrzsCqksBpGMWDyULyqWsDhdB+7BlBmVRGDRxgMfxM0swa9Eo1TQ4vkgs6RlWf8
    IOZfRraBJxeLqw9/7Z1+nHR7Eq7sEo8ExutRGktyUDB6IErIlO6IuODALJO7op5f
    sCZYxENVJnAInIFQRXksmUmpR/+k1RPzT5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526634919;
    bh=x/cin1GEnNAoD5HlHT8mPossccef7iU+KKEGGqYlZ0Y=; b=VEKF32QuiYiN
    sr4iAAXayaAy1R9UCD0gN1+ILTBDSk9WfVG3TYOwu03gbgsBgPQ2tjWqEnQwT67X
    WNT2oqUXibbuzbArWeZt/Wg7iaz2iTYt6oD58oXIHWAcKUQUwS5Q0hAaidX+P+jZ
    QAGY5agdhexOO4d6+ggh1VI8HLcG7wVfFIerqwYQBr5KFT09Mn3/JaifZHG7o4vw
    tVHxEtcGED8wrg+/LmStLiGkbJcPedfG/RCNQh/E0gwR/dqDmnbV/0y53/YVB+XV
    ojPCwgkdI1y5+xqt5ziw1Tj1/gaC7Gq/ni94wOuOpMZaeK7sNwWmJIsjrhG3UKCr
    xC4GvO973g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJcaRKIqTu/uVO+WEon4PTEGkMqou8tF9fGJbgizdJE4t7IvdsbC8HHd5ebGdmDKz4jS+KyAlhCAdA3gc+o5N17tMSMdpD80AWwDgTmYJIDkteNkCFKn
    M0GqxN/XQibfGoqB+0ChtWxQEAKl36mQyI6cLZ0/0d6bqNZxTJkaZ6rqsS75yJ1et3EVJLKbWF0wNNJtwvhQQBXNSnIBaCY9vSVmobEZgWiFEY8s4DkqSW7x
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=NbnTQ2_p7CGaZhF_eIwA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeERJPF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 05:15:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:45076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752948AbeERJPB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 18 May 2018 05:15:01 -0400
Subject: Re: [PATCH v2 1/4] mm: change type of free_contig_range(nr_pages) to
 unsigned long
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20180503232935.22539-1-mike.kravetz@oracle.com>
 <20180503232935.22539-2-mike.kravetz@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <87d74ce0-b135-064d-a589-64235e44c388@suse.cz>
Date: Fri, 18 May 2018 11:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503232935.22539-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/04/2018 01:29 AM, Mike Kravetz wrote:
> free_contig_range() is currently defined as:
> void free_contig_range(unsigned long pfn, unsigned nr_pages);
> change to,
> void free_contig_range(unsigned long pfn, unsigned long nr_pages);
> 
> Some callers are passing a truncated unsigned long today.  It is
> highly unlikely that these values will overflow an unsigned int.
> However, this should be changed to an unsigned long to be consistent
> with other page counts.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/gfp.h | 2 +-
>  mm/cma.c            | 2 +-
>  mm/hugetlb.c        | 2 +-
>  mm/page_alloc.c     | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 1a4582b44d32..86a0d06463ab 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -572,7 +572,7 @@ static inline bool pm_suspended_storage(void)
>  /* The below functions must be run on a range from a single zone. */
>  extern int alloc_contig_range(unsigned long start, unsigned long end,
>  			      unsigned migratetype, gfp_t gfp_mask);
> -extern void free_contig_range(unsigned long pfn, unsigned nr_pages);
> +extern void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>  #endif
>  
>  #ifdef CONFIG_CMA
> diff --git a/mm/cma.c b/mm/cma.c
> index aa40e6c7b042..f473fc2b7cbd 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -563,7 +563,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>  
>  	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
>  
> -	free_contig_range(pfn, count);
> +	free_contig_range(pfn, (unsigned long)count);

I guess this cast from uint to ulong doesn't need to be explicit? But
instead, cma_release() signature could be also changed to ulong, because
some of its callers do pass those?

>  	cma_clear_bitmap(cma, pfn, count);
>  	trace_cma_release(pfn, pages, count);
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 218679138255..c81072ce7510 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1055,7 +1055,7 @@ static void destroy_compound_gigantic_page(struct page *page,
>  
>  static void free_gigantic_page(struct page *page, unsigned int order)
>  {
> -	free_contig_range(page_to_pfn(page), 1 << order);
> +	free_contig_range(page_to_pfn(page), 1UL << order);
>  }
>  
>  static int __alloc_gigantic_page(unsigned long start_pfn,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 905db9d7962f..0fd5e8e2456e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7937,9 +7937,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	return ret;
>  }
>  
> -void free_contig_range(unsigned long pfn, unsigned nr_pages)
> +void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>  {
> -	unsigned int count = 0;
> +	unsigned long count = 0;
>  
>  	for (; nr_pages--; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
> @@ -7947,7 +7947,7 @@ void free_contig_range(unsigned long pfn, unsigned nr_pages)
>  		count += page_count(page) != 1;
>  		__free_page(page);
>  	}
> -	WARN(count != 0, "%d pages are still in use!\n", count);
> +	WARN(count != 0, "%ld pages are still in use!\n", count);

Maybe change to %lu while at it?
BTW, this warning can theoretically produce false positives, because
page users have to deal with page_count() being incremented by e.g.
parallel pfn scanners using get_page_unless_zero(). We also don't detect
refcount leaks in general. Should we remove it or change it to VM_WARN
if it's still useful for debugging?

>  }
>  #endif
>  
> 

