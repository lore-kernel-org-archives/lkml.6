Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC78C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA1E20883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 09:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="V77SztHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA1E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeKJTUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 14:20:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38859 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbeKJTUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 14:20:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id q186-v6so3625507ljb.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 01:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HhhNo9CR6UySljH23CGNEy307fi0cCtUJm1yqOuixP8=;
        b=V77SztHvHPobcqvj2ZEg+Aj/I3x9ucxMB+6C8UZx+hG1pVr28liOxmcJ/1F/IS0Dtc
         GIfSIHBldqQl9xLmMm44LI48yfzzDep9oTmlx0mlZEoxjqn6AyO/5u8TcQ5GG6UjkbCp
         pxSVq3f08fWL+7GDSFApcYdZNrnqr7hUXtJAcjzpEgObMNz74NMO1ErMTkRNIZcqN0Gx
         3PJUOycuLBJfuVtFjPlZKZ//U+p9FM0EeiXKVoz+oJGUFnC7na2ty0E1JSrWK4ITjZtW
         KnaJ5UynbdGEOJQDUb+coABzMxuV+lMOkboLEg9BsD8J4/hXW1pMUHgDyFKgUNLKyvy3
         1C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HhhNo9CR6UySljH23CGNEy307fi0cCtUJm1yqOuixP8=;
        b=j92ydk8YH1XunDRvRMHiwKIDBIr5awJmBn3otIKXf4eY8deRafiNn3f1U29vS985Pj
         ffTgd5n3HwPkR057vhPu0TSA/HvDs8aHn3+V8/+t/SHB89s9Tovc9Dcl/3wsusL3XTpX
         usgD7nyjXMSdilZfoBRnM9067FXXYGuC1SAD3ztgfCmKo8UNiWdGW9ACUiv4nR2PuucV
         nfoxuQw0Q/sekdG12BSO8nbxCOSx31IW1BqNH2u0YVXaahUCNyZCPGjaPPyiIV2Fx8mv
         c5vrhEBT6J0BzVc7KolOZ1HqbvO0G56JbifrFk5/olXoNMRfmVL7x+Xu5GDJ3OkSwBq1
         GG8Q==
X-Gm-Message-State: AGRZ1gJ3NvbgQ/I5506q/xjMNIa3aFcsPKuvnpVbNdAyIjy6z/liA61z
        J3cA6FZyvLyhTqCwAvdVzHwO0w==
X-Google-Smtp-Source: AJdET5fjVgCBCaXAhstGfOROjBFHpFyHu9dcJL8ipoESnNLaeUFx+6pw1ZCdtbwzPnrJqNv+F4adXA==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr6582873lje.115.1541842537948;
        Sat, 10 Nov 2018 01:35:37 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-34-243-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.243.34])
        by smtp.gmail.com with ESMTPSA id j18-v6sm1870517ljc.52.2018.11.10.01.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 01:35:36 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8FDE43002A1; Sat, 10 Nov 2018 12:35:34 +0300 (+03)
Date:   Sat, 10 Nov 2018 12:35:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <zi.yan@cs.rutgers.edu>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        jglisse@redhat.com, khandual@linux.vnet.ibm.com,
        kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        minchan@kernel.org, peterz@infradead.org, rientjes@google.com,
        vbabka@suse.cz, willy@infradead.org, ying.huang@intel.com,
        nitingupta910@gmail.com
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
Message-ID: <20181110093534.upaq6tfxxtoquq3p@kshutemo-mobl1>
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
 <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
 <20181109131128.GE23260@techsingularity.net>
 <EEBCAF4D-138C-4CF7-B4B7-C55F1192A026@cs.rutgers.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EEBCAF4D-138C-4CF7-B4B7-C55F1192A026@cs.rutgers.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:34:07AM -0500, Zi Yan wrote:
> On 9 Nov 2018, at 8:11, Mel Gorman wrote:
> 
> > On Fri, Nov 09, 2018 at 03:13:18PM +0300, Kirill A. Shutemov wrote:
> >> On Thu, Nov 08, 2018 at 10:48:58PM -0800, Anthony Yznaga wrote:
> >>> The basic idea as outlined by Mel Gorman in [2] is:
> >>>
> >>> 1) On first fault in a sufficiently sized range, allocate a huge page
> >>>    sized and aligned block of base pages.  Map the base page
> >>>    corresponding to the fault address and hold the rest of the pages in
> >>>    reserve.
> >>> 2) On subsequent faults in the range, map the pages from the reservation.
> >>> 3) When enough pages have been mapped, promote the mapped pages and
> >>>    remaining pages in the reservation to a huge page.
> >>> 4) When there is memory pressure, release the unused pages from their
> >>>    reservations.
> >>
> >> I haven't yet read the patch in details, but I'm skeptical about the
> >> approach in general for few reasons:
> >>
> >> - PTE page table retracting to replace it with huge PMD entry requires
> >>   down_write(mmap_sem). It makes the approach not practical for many
> >>   multi-threaded workloads.
> >>
> >>   I don't see a way to avoid exclusive lock here. I will be glad to
> >>   be proved otherwise.
> >>
> >
> > That problem is somewhat fundamental to the mmap_sem itself and
> > conceivably it could be alleviated by range-locking (if that gets
> > completed). The other thing to bear in mind is the timing. If the
> > promotion is in-place due to reservations, there isn't the allocation
> > overhead and the hold times *should* be short.
> >
> 
> Is it possible to convert all these PTEs to migration entries during
> the promotion and replace them with a huge PMD entry afterwards?
> AFAIK, migrating pages does not require holding a mmap_sem.
> Basically, it will act like migrating 512 base pages to a THP without
> actually doing the page copy.

You'll still need down_write(mmap_sem) to convert PTE page table full of
migration entires to PMD entry. It's required at least to protect against
parallel MADV_DONTNEED that can zap migration entries under you.

-- 
 Kirill A. Shutemov
