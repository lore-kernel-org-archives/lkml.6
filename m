Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3967ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EDD20854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="w/YLeHsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EDD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbeGTNRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:17:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36626 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbeGTNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:17:12 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so5142989plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iIUclUsUzbWI3KLzuMabuTDozbptu5T5+tqLyy2HiP8=;
        b=w/YLeHsOS/xF5jp4HlT4Z7G6HQgsZ5hR574/xdK/YJj6SJKUy90Gd4tbr8PfXB992Q
         OrKrQ7Ldlc1c943Xbr4Iy7fuqhwKBvAJdpnZoGPW1gPoTrL1iORZeAJQIplktzFszKeH
         8tuKxYtWEgohO47sos9ICxGo/iCUNlcoBOm8Tj4bVR/xB6cM4n3pI4KIvWZM90qge0zw
         iv05hXMjwb2McOWZML8EQe5Io5MHInongDg/SHG93goIHiUB0KZvbyKo64uIxqX0jtF8
         SrZ9IdQffplo9RbPA9YPOK82dnm+8weCSGtD96BSzaB4ye9yrP5lJaP6khDkge6m+mk8
         zaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iIUclUsUzbWI3KLzuMabuTDozbptu5T5+tqLyy2HiP8=;
        b=hE8DIY7bW0+np/FL9oqRq6dS1ZVg+vfCEfFgi67sXNacFF137khBWIaudjWLnsX8SL
         xy1nQv1RTOgUeYF3gIynugv0Bl1uhrBYFvuDWUSGWwc3wxs5P4YvGCjGlHaxLc+MJBnT
         WQyrz1EEuT9UbE4wwv0TAYTEu4L2mA9b0YxpeXMMGFMhvLbR7p8yKo6+v1lb0qx99mne
         O9RqlnwjQV2NIgwch3gUXOpMVX2o2T41GtNXCdJ76HiUZSAJCKMXbi3KHcg6obFNtx0Q
         esM9tXtOi5SI00cIJ4mcqJQhpjqlUcjAWqOUuEePFaXVAM7MudL8oIgCI4ghL+bDMPRc
         f7rg==
X-Gm-Message-State: AOUpUlEHTQeqIlL9cDjmjr2gtmLfypleQ/RoM/wC9FmEStbEKNpwTGkC
        kNilZ/rfShHXD7MYP7fSgar5Vg==
X-Google-Smtp-Source: AAOMgpdu3/0Wmg/DP6qTUhf4EjuGdoAfjhjuirDW9Lkcm2w7uldmPPqQOAs1lVlzSK8U5DfYlpHbDA==
X-Received: by 2002:a17:902:d88d:: with SMTP id b13-v6mr1951204plz.314.1532089751416;
        Fri, 20 Jul 2018 05:29:11 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id p3-v6sm2694985pfo.130.2018.07.20.05.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:29:10 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5AE96300254; Fri, 20 Jul 2018 15:29:07 +0300 (+03)
Date:   Fri, 20 Jul 2018 15:29:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv5 06/19] mm/khugepaged: Handle encrypted pages
Message-ID: <20180720122907.xsxihg56ambynwk2@kshutemo-mobl1>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
 <20180717112029.42378-7-kirill.shutemov@linux.intel.com>
 <ad4c704f-fdda-7e75-60ec-3fbc8a4bb0ba@intel.com>
 <20180719085901.ebdciqkjpx6hy4xt@kshutemo-mobl1>
 <bc6074f3-dd71-8b6f-5a1f-d3770ac4990b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc6074f3-dd71-8b6f-5a1f-d3770ac4990b@intel.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 07:13:39AM -0700, Dave Hansen wrote:
> On 07/19/2018 01:59 AM, Kirill A. Shutemov wrote:
> > On Wed, Jul 18, 2018 at 04:11:57PM -0700, Dave Hansen wrote:
> >> On 07/17/2018 04:20 AM, Kirill A. Shutemov wrote:
> >>> khugepaged allocates page in advance, before we found a VMA for
> >>> collapse. We don't yet know which KeyID to use for the allocation.
> >>
> >> That's not really true.  We have the VMA and the address in the caller
> >> (khugepaged_scan_pmd()), but we drop the lock and have to revalidate the
> >> VMA.
> > 
> > For !NUMA we allocate the page in khugepaged_do_scan(), well before we
> > know VMA.
> 
> Ahh, thanks for clarifying.  That's some more very good information
> about the design and progression of your patch that belongs in the
> changelog.

Okay.

> >>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>> index 5ae34097aed1..d116f4ebb622 100644
> >>> --- a/mm/khugepaged.c
> >>> +++ b/mm/khugepaged.c
> >>> @@ -1056,6 +1056,16 @@ static void collapse_huge_page(struct mm_struct *mm,
> >>>  	 */
> >>>  	anon_vma_unlock_write(vma->anon_vma);
> >>>  
> >>> +	/*
> >>> +	 * At this point new_page is allocated as non-encrypted.
> >>> +	 * If VMA's KeyID is non-zero, we need to prepare it to be encrypted
> >>> +	 * before coping data.
> >>> +	 */
> >>> +	if (vma_keyid(vma)) {
> >>> +		prep_encrypted_page(new_page, HPAGE_PMD_ORDER,
> >>> +				vma_keyid(vma), false);
> >>> +	}
> >>
> >> I guess this isn't horribly problematic now, but if we ever keep pools
> >> of preassigned-keyids, this won't work any more.
> > 
> > I don't get this. What pools of preassigned-keyids are you talking about?
> 
> My point was that if we ever teach the allocator or something _near_ the
> allocator to keep pools of pre-zeroed and/or pre-cache-cleared pages,
> this approach will need to get changed otherwise we will double-prep pages.

It shouldn't be a problem here. It's pretty slow path. We often wait
memory to be compacted before page for khugepaged gets allocated.
Double-prep shouldn't have visible impact.

> My overall concern with prep_encrypted_page() in this patch set is that
> it's inserted pretty ad-hoc.  It seems easy to miss spots where it
> should be.  I'm also unsure of the failure mode and anything we've done
> to ensure that if we get this wrong, we scream clearly and loudly about
> what happened.  Do we do something like that?

I have debugging patch that puts BUG_ONs around set_pte_at() to check if
the page's keyid matches VMA's keyid. But that's not very systematic.
We would need something better than this.

-- 
 Kirill A. Shutemov
