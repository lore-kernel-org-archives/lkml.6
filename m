Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95558C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E2F2250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E2F2250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeKMKRG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:17:06 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:54770 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:17:06 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wAD0LFna022909
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Nov 2018 09:21:15 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD0LFZi026277;
        Tue, 13 Nov 2018 09:21:15 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAD0HOW3019102;
        Tue, 13 Nov 2018 09:21:15 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5445276; Tue, 13 Nov 2018 09:17:31 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Tue,
 13 Nov 2018 09:17:31 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Laurent Dufour" <ldufour@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v1 03/11] mm: move definition of
 num_poisoned_pages_inc/dec to include/linux/mm.h
Thread-Topic: [RFC][PATCH v1 03/11] mm: move definition of
 num_poisoned_pages_inc/dec to include/linux/mm.h
Thread-Index: AQHUd/gajhnZa81piESI4VuDt6NxF6VGpxaAgAWeoQA=
Date:   Tue, 13 Nov 2018 00:17:31 +0000
Message-ID: <20181113001730.GB5945@hori1.linux.bs1.fc.nec.co.jp>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1541746035-13408-4-git-send-email-n-horiguchi@ah.jp.nec.com>
 <e4c4ae14-0d55-0738-9257-2c1232acef33@arm.com>
In-Reply-To: <e4c4ae14-0d55-0738-9257-2c1232acef33@arm.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <3EC1247046210940A7F9D6109DB99B08@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 03:58:27PM +0530, Anshuman Khandual wrote:
> 
> 
> On 11/09/2018 12:17 PM, Naoya Horiguchi wrote:
> > num_poisoned_pages_inc/dec had better be visible to some file like
> > mm/sparse.c and mm/page_alloc.c (for a subsequent patch). So let's
> > move it to include/linux/mm.h.
> > 
> > Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> > ---
> >  include/linux/mm.h      | 13 ++++++++++++-
> >  include/linux/swapops.h | 16 ----------------
> >  mm/sparse.c             |  2 +-
> >  3 files changed, 13 insertions(+), 18 deletions(-)
> > 
> > diff --git v4.19-mmotm-2018-10-30-16-08/include/linux/mm.h v4.19-mmotm-2018-10-30-16-08_patched/include/linux/mm.h
> > index 59df394..22623ba 100644
> > --- v4.19-mmotm-2018-10-30-16-08/include/linux/mm.h
> > +++ v4.19-mmotm-2018-10-30-16-08_patched/include/linux/mm.h
> > @@ -2741,7 +2741,7 @@ extern void shake_page(struct page *p, int access);
> >  extern atomic_long_t num_poisoned_pages __read_mostly;
> >  extern int soft_offline_page(struct page *page, int flags);
> >  
> > -
> > +#ifdef CONFIG_MEMORY_FAILURE
> >  /*
> >   * Error handlers for various types of pages.
> >   */
> > @@ -2777,6 +2777,17 @@ enum mf_action_page_type {
> >  	MF_MSG_UNKNOWN,
> >  };
> >  
> > +static inline void num_poisoned_pages_inc(void)
> > +{
> > +	atomic_long_inc(&num_poisoned_pages);
> > +}
> > +
> > +static inline void num_poisoned_pages_dec(void)
> > +{
> > +	atomic_long_dec(&num_poisoned_pages);
> > +}
> > +#endif
> > +
> >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> >  extern void clear_huge_page(struct page *page,
> >  			    unsigned long addr_hint,
> > diff --git v4.19-mmotm-2018-10-30-16-08/include/linux/swapops.h v4.19-mmotm-2018-10-30-16-08_patched/include/linux/swapops.h
> > index 4d96166..88137e9 100644
> > --- v4.19-mmotm-2018-10-30-16-08/include/linux/swapops.h
> > +++ v4.19-mmotm-2018-10-30-16-08_patched/include/linux/swapops.h
> > @@ -320,8 +320,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
> >  
> >  #ifdef CONFIG_MEMORY_FAILURE
> >  
> > -extern atomic_long_t num_poisoned_pages __read_mostly;
> > -
> >  /*
> >   * Support for hardware poisoned pages
> >   */
> > @@ -336,16 +334,6 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
> >  	return swp_type(entry) == SWP_HWPOISON;
> >  }
> >  
> > -static inline void num_poisoned_pages_inc(void)
> > -{
> > -	atomic_long_inc(&num_poisoned_pages);
> > -}
> > -
> > -static inline void num_poisoned_pages_dec(void)
> > -{
> > -	atomic_long_dec(&num_poisoned_pages);
> > -}
> > -
> >  #else
> >  
> >  static inline swp_entry_t make_hwpoison_entry(struct page *page)
> > @@ -357,10 +345,6 @@ static inline int is_hwpoison_entry(swp_entry_t swp)
> >  {
> >  	return 0;
> >  }
> > -
> > -static inline void num_poisoned_pages_inc(void)
> > -{
> > -}
> 
> I hope this was a stray definition and redundant which does not prevent
> build in absence of CONFIG_MEMORY_FAILURE.

You're right :)

> >  #endif
> >  
> >  #if defined(CONFIG_MEMORY_FAILURE) || defined(CONFIG_MIGRATION)
> > diff --git v4.19-mmotm-2018-10-30-16-08/mm/sparse.c v4.19-mmotm-2018-10-30-16-08_patched/mm/sparse.c
> > index 33307fc..7ada2e5 100644
> > --- v4.19-mmotm-2018-10-30-16-08/mm/sparse.c
> > +++ v4.19-mmotm-2018-10-30-16-08_patched/mm/sparse.c
> > @@ -726,7 +726,7 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
> >  
> >  	for (i = 0; i < nr_pages; i++) {
> >  		if (PageHWPoison(&memmap[i])) {
> > -			atomic_long_sub(1, &num_poisoned_pages);
> > +			num_poisoned_pages_dec();
> >  			ClearPageHWPoison(&memmap[i]);
> >  		}
> >  	}
> > 
> 
> Otherwise looks good.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks!
Naoya Horiguchi
