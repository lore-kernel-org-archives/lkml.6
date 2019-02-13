Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DAAC4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705D22075D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rF8uBA9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfBMNtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:49:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37782 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfBMNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:49:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so1166705pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K4Ix0st5h7mGiozd1GPE9akHFG04DKktEj6nww1TJFA=;
        b=rF8uBA9a4sCHBR2JlOHVWUlyIWFf+Bs+R2rGV/VHUNEmijV6eF3pPxV7+ymnGw8I9d
         hWXZhMk/liTccHVhHr3VCvopF3VR5MLkh8RVMyOAEBqfD2jCvQAzW3Q0WhKrgsQ6ufBu
         LjVywHneGzH35DMgGbt5UCffgPIKKFsmrRqDdKxH/WMwMGGDVL7AgzeB1h/kmxGo04fu
         PttOuiABWLIJBcSeOGTId0YqGX5qOD0DEgkJNfty0C8ZKQ0bfVNUByfFRO2T1RMHa+eD
         V/rHnEOe/CEM/qr25w+fGpaal3iTRLh2lOwOhRPTOgKLXFkWJqtlT5u3mDyPs3kh7EOx
         xCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K4Ix0st5h7mGiozd1GPE9akHFG04DKktEj6nww1TJFA=;
        b=dU05bZw3zdaPLJ/6aD4SmrL90sxJBix4rCfOvA5daq0mmM3SktSudhSLZSjgtDwBqK
         jTRl+jqKD4GN2OAbg2c9fb7SFtbnGENJOp5U78QGKGLUCo6tjJM0T5vwofENHyJ2GycZ
         aRRsO3la2gV7i4cGSbGMF/aDc/niaTtiMzjqeuc7wIVIgZz9i8/BPQ2w6j0pJTVkptnw
         Cb6wrzkxAK/6QDgvDvqEv56vEkPMLXoX9NiKgNotaEUFFSVf9YPWNoYufZTYDFlpySb/
         zxAAmmC7BKsu8/huvb8ZBwc4q4fRU/MNQdCi+GFo/AeLIgkG7sD+0LhDYC0CJuYLkoDa
         K2ew==
X-Gm-Message-State: AHQUAuaSN24nzzzNOjfHTBo3eLvmvtk59ru2D0XWQPG4yJbMczNZ2h5s
        Lvn5jzg1HjqDiK3CvS9LdsKJiQ==
X-Google-Smtp-Source: AHgI3IZWpI9dwHhwZ4kcUXFXEiE7NTvTbTAdGqZWXyXpDvFIC7NF4DL2dXD52D5iKMiucnGeKJL6pw==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr591625pgp.46.1550065743599;
        Wed, 13 Feb 2019 05:49:03 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id z4sm12394367pgu.10.2019.02.13.05.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 05:49:02 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 70A863002B2; Wed, 13 Feb 2019 16:48:59 +0300 (+03)
Date:   Wed, 13 Feb 2019 16:48:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LSF/MM TOPIC] Non standard size THP
Message-ID: <20190213134859.54tnrkzauj2mftn4@kshutemo-mobl1>
References: <dcb0b2cf-ba5c-e6ef-0b05-c6006227b6a9@arm.com>
 <20190212083331.dtch7xubjxlmz5tf@kshutemo-mobl1>
 <282f6d89-bcc2-2622-1205-7c43ba85c37e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282f6d89-bcc2-2622-1205-7c43ba85c37e@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 06:20:03PM +0530, Anshuman Khandual wrote:
> 
> 
> On 02/12/2019 02:03 PM, Kirill A. Shutemov wrote:
> > On Fri, Feb 08, 2019 at 07:43:57AM +0530, Anshuman Khandual wrote:
> >> Hello,
> >>
> >> THP is currently supported for
> >>
> >> - PMD level pages (anon and file)
> >> - PUD level pages (file - DAX file system)
> >>
> >> THP is a single entry mapping at standard page table levels (either PMD or PUD)
> >>
> >> But architectures like ARM64 supports non-standard page table level huge pages
> >> with contiguous bits.
> >>
> >> - These are created as multiple entries at either PTE or PMD level
> >> - These multiple entries carry pages which are physically contiguous
> >> - A special PTE bit (PTE_CONT) is set indicating single entry to be contiguous
> >>
> >> These multiple contiguous entries create a huge page size which is different
> >> than standard PMD/PUD level but they provide benefits of huge memory like
> >> less number of faults, bigger TLB coverage, less TLB miss etc.
> >>
> >> Currently they are used as HugeTLB pages because
> >>
> >> 	- HugeTLB page sizes is carried in the VMA
> >> 	- Page table walker can operate on multiple PTE or PMD entries given its size in VMA
> >> 	- Irrespective of HugeTLB page size its operated with set_huge_pte_at() at any level
> >> 	- set_huge_pte_at() is arch specific which knows how to encode multiple consecutive entries
> >> 	
> >> But not as THP huge pages because
> >>
> >> 	- THP size is not encoded any where like VMA
> >> 	- Page table walker expects it to be either at PUD (HPAGE_PUD_SIZE) or at PMD (HPAGE_PMD_SIZE)
> >> 	- Page table operates directly with set_pmd_at() or set_pud_at()
> >> 	- Direct faulted or promoted huge pages is verified with [pmd|pud]_trans_huge()
> >>
> >> How non-standard huge pages can be supported for THP
> >>
> >> 	- THP starts recognizing non standard huge page (exported by arch) like HPAGE_CONT_(PMD|PTE)_SIZE
> >> 	- THP starts operating for either on HPAGE_PMD_SIZE or HPAGE_CONT_PMD_SIZE or HPAGE_CONT_PTE_SIZE
> >> 	- set_pmd_at() only recognizes HPAGE_PMD_SIZE hence replace set_pmd_at() with set_huge_pmd_at()
> >> 	- set_huge_pmd_at() could differentiate between HPAGE_PMD_SIZE or HPAGE_CONT_PMD_SIZE
> >> 	- In case for HPAGE_CONT_PTE_SIZE extend page table walker till PTE level
> >> 	- Use set_huge_pte_at() which can operate on multiple contiguous PTE bits
> > 
> > You only listed trivial things. All tricky stuff is what make THP
> > transparent.
> 
> Agreed. I was trying to draw an analogy from HugeTLB with respect to page
> table creation and it's walking. Huge page collapse and split on such non
> standard huge pages will involve taking care of much details.
> 
> > 
> > To consider it seriously we need to understand what it means for
> > split_huge_p?d()/split_huge_page()? How khugepaged will deal with this?
> 
> Absolutely. Can these operate on non standard probably multi entry based
> huge pages ? How to handle atomicity etc.

We need to handle split for them to provide transparency.

> > In particular, I'm worry to expose (to user or CPU) page table state in
> > the middle of conversion (huge->small or small->huge). Handling this on
> > page table level provides a level atomicity that you will not have.
> 
> I understand it might require a software based lock instead of standard HW
> atomicity constructs which will make it slow but is that even possible ?

I'm not yet sure if it is possible. I don't yet wrap my head around the
idea yet.

> > Honestly, I'm very skeptical about the idea. It took a lot of time to
> > stabilize THP for singe page size, equal to PMD page table, but this looks
> > like a new can of worms. :P
> 
> I understand your concern here but HW providing some more TLB sizes beyond
> standard page table level (PMD/PUD/PGD) based huge pages can help achieve
> performance improvement when the buddy is already fragmented enough not to
> provide higher order pages. PUD THP file mapping is already supported for
> DAX and PUD THP anon mapping might be supported in near future (it is not
> much challenging other than allocating HPAGE_PUD_SIZE huge page at runtime
> will be much difficult).

That's a bold claim. I would like to look at code. :)

Supporting more than one THP page size at the same time brings a lot more
questions, besides allocation path (although I'm sure compaction will be
happy about this).

For instance, what page size you'll allocate for a given fault
address?

How do you deal with pre-allocated page tables? Deposit 513 page tables
for a given PUD THP page might be fun. :P

> Around PMD sizes like HPAGE_CONT_PMD_SIZE or
> HPAGE_CONT_PTE_SIZE really have better chances as future non-PMD level anon
> mapping than a PUD size anon mapping support in THP.
> 
> > 
> > It *might* be possible to support it for DAX, but beyond that...
> >
> 
> Did not get that. Why would you think that this is possible or appropriate
> only for DAX file mapping but not for anon mapping ?

DAX THP is inherently simpler: no struct pages -- less state to track and
no need in split_huge_page(), split_huge_p?d() can be handled by dropping
entities in question and re-faulting them as smaller entires. No problem
with compation...

-- 
 Kirill A. Shutemov
