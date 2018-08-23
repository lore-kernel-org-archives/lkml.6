Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30280C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D554E208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="EwzSpXLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D554E208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeHWLtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:49:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33157 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeHWLts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:49:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so2336830pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 01:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jmo0+uf6Nq5OQ3x30/PXzdsoF2UdQTxUC0+1PBESmhM=;
        b=EwzSpXLCjvurEVf53wHGIELJlRMLxokVIzlANondKQ882F7W8qupStUhUzZd3hb+cV
         2wvbg6gnxyB+6t/akASos73k6cFyEr+9jVkSbkvsXh4f8qiknqXkLC2Gqgzhh61nlYZt
         Z/+JPw4IV/tLjUI3TAaoPAIjkc73bTFc8Pbri3hXXyfcWTooqEvqTk6h9b5qJBwTsyer
         4/i6g8U8/Grg587W0wQc2pwMWJQORDqb7NSYvQi5NPXvhiG+BPyTj4fpz9M7c7UUkZn5
         Jb2SuTtc9maggEGYxN8Y9iCwJf/OhlL34ij50Imad+9RHfhT+ANff8ZueG0R7MMk8jET
         iQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jmo0+uf6Nq5OQ3x30/PXzdsoF2UdQTxUC0+1PBESmhM=;
        b=b4og20LEpKlasrzCq65TtWvRfGoiUZq8BE4UGlk34bvVNKu5HjTEx0TrFu7YDa8ZFi
         cLA6LrfE7opHoU013hQStBvtfqWHvhOEBzpct7ATw9wwh14QuafhHYMxJQP+EL1HROhm
         pWS0rsrtrga+AmzqXW+beiFmfc14w0Q0aInL1GpaS5HM2ecRutVwooMuX+Nu2Gv16PM7
         R+Fg3+dEF3aMpaVozNbjAMHHTlYDoWoydyPjdUeVO5HANlgQQjZaAyNDjoepakZibtZE
         zwhnvLBiMthtG8sZQOr/grKQjeZqAyfheqYcyxPyujwa2r+aWUq+DQYR+TKxkPV90hvX
         pcsA==
X-Gm-Message-State: AOUpUlHOQULxfMgFRN3tEpBJz2U0Yw+TaVS22cznNxK8N5VmsA7dDREO
        nnXe3OjjMxj53fKM9RPQcbHPFQ==
X-Google-Smtp-Source: AA+uWPzkKXPCE1+IsL393eRrDc45XNwJGHnxAVoSTeNUphXIIsKuWlFex6076NaV+Z/2FKgGJ8/mOw==
X-Received: by 2002:a62:4083:: with SMTP id f3-v6mr61885359pfd.229.1535012478988;
        Thu, 23 Aug 2018 01:21:18 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id p26-v6sm6616514pfi.183.2018.08.23.01.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 01:21:17 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id DBAB43000BE; Thu, 23 Aug 2018 11:21:12 +0300 (+03)
Date:   Thu, 23 Aug 2018 11:21:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180823082112.xln7rinqcwt54teg@kshutemo-mobl1>
References: <20180821205902.21223-2-mike.kravetz@oracle.com>
 <201808220831.eM0je51n%fengguang.wu@intel.com>
 <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
 <20180822122848.GL29735@dhcp22.suse.cz>
 <4a95a24f-534f-0938-f358-2a410817a412@oracle.com>
 <20180823073035.GT29735@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823073035.GT29735@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:30:35AM +0200, Michal Hocko wrote:
> On Wed 22-08-18 09:48:16, Mike Kravetz wrote:
> > On 08/22/2018 05:28 AM, Michal Hocko wrote:
> > > On Tue 21-08-18 18:10:42, Mike Kravetz wrote:
> > > [...]
> > >> diff --git a/mm/rmap.c b/mm/rmap.c
> > >> index eb477809a5c0..8cf853a4b093 100644
> > >> --- a/mm/rmap.c
> > >> +++ b/mm/rmap.c
> > >> @@ -1362,11 +1362,21 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > >>  	}
> > >>  
> > >>  	/*
> > >> -	 * We have to assume the worse case ie pmd for invalidation. Note that
> > >> -	 * the page can not be free in this function as call of try_to_unmap()
> > >> -	 * must hold a reference on the page.
> > >> +	 * For THP, we have to assume the worse case ie pmd for invalidation.
> > >> +	 * For hugetlb, it could be much worse if we need to do pud
> > >> +	 * invalidation in the case of pmd sharing.
> > >> +	 *
> > >> +	 * Note that the page can not be free in this function as call of
> > >> +	 * try_to_unmap() must hold a reference on the page.
> > >>  	 */
> > >>  	end = min(vma->vm_end, start + (PAGE_SIZE << compound_order(page)));
> > >> +	if (PageHuge(page)) {
> > >> +		/*
> > >> +		 * If sharing is possible, start and end will be adjusted
> > >> +		 * accordingly.
> > >> +		 */
> > >> +		(void)huge_pmd_sharing_possible(vma, &start, &end);
> > >> +	}
> > >>  	mmu_notifier_invalidate_range_start(vma->vm_mm, start, end);
> > > 
> > > I do not get this part. Why don't we simply unconditionally invalidate
> > > the whole huge page range?
> > 
> > In this routine, we are only unmapping a single page.  The existing code
> > is limiting the invalidate range to that page size: 4K or 2M.  With shared
> > PMDs, we have the possibility of unmapping a PUD_SIZE area: 1G.  I don't
> > think we want to unconditionally invalidate 1G.  Is that what you are asking?
> 
> But we know that huge_pmd_unshare unmapped a shared pte so we know when
> to flush 2MB or 1GB. I really do not like how huge_pmd_sharing_possible
> a) duplicates some checks and b) it updates start/stop out of line.

My reading on this is that mmu_notifier_invalidate_range_start() has to be
called from sleepable context on the full range that *can* be invalidated
before following mmu_notifier_invalidate_range_end().

In this case huge_pmd_unshare() may unmap aligned PUD_SIZE around the PMD
page that effectively enlarge range that has to be covered by
mmu_notifier_invalidate_range_start(). We cannot yet know if there's any
shared page tables in the range, so we need to go with worst case
scenario.

I don't see conceptually better solution than what is proposed.

-- 
 Kirill A. Shutemov
