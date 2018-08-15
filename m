Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66074C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220F215FB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Qa7S5naG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1220F215FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeHOLjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:39:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39781 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbeHOLjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 07:39:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so260006pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJPKkJkop3euu8b82V++ZcM6zc0GYGA8Tzb0kTCLE5Q=;
        b=Qa7S5naGXxQrbrtd/QfA5+kw5ru/49NCViBOKT34yRPnZgBJzC+B/Pa0N1quPykT3Z
         mXC8HKl0C74NBpYZv65kvDkht6cxtcrgCXJrYlc7rkLBm5FVZSNXUCOaJ2UFUzK/kDr5
         RK9rMu08vYly8ZPcFmSAFo3xrsCIgUqOqZ3BXsklqDuqphnIxjMuZLS7zvoSe7tqFFQA
         cpGDKLTuisvjCGWA2GeExE/4p2H2HbXKW1EC36QIo7U2Q30W2D2MYcuYhi7lOvFVgi/h
         VcUdtJpEOjJ/1iiFPECUE+nA5Zw+QxatkWQoiEKtO3Ou+YcC6cLEOBkymxkM/BGrk8XB
         it6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJPKkJkop3euu8b82V++ZcM6zc0GYGA8Tzb0kTCLE5Q=;
        b=JQ2TuXZpua08RY33uglst/NAis/leZNJtH+/kEJoRVVbZJp7AkbzyulgFLiImSMwmQ
         crt8f+qidLt3B75m4fgPpV4rBVNZjlyb/a8iJlg1b3kj0lCqzTo82vyepjgy2LahDzqz
         PjtfXT12eU7+aldyiCoMELVV+ln0KxnDYddtyaQ5VIW9DTkUucnWbl9RoIqxyvsh5CBY
         IjMACr2cjwjkzzKwSynEXMuX0+223WNUrfz6XEg3txe51PZtVJy8mxiy8csmxaWmFy5a
         0NiLityHTwM7zLdmfAMbe04b9wErVDxSly9ti0IX1Btd9+dtq233AdmCF5bA/1WC48Xs
         LZiQ==
X-Gm-Message-State: AOUpUlFbikhUOK7A1G7kXajP0EZhBMZ3iqI3pCIEGj1q7XhWNSaPOWm1
        TeRi4cgEFImIaq1Lg3Sandn/wQ==
X-Google-Smtp-Source: AA+uWPyXGV8anljNFzDKeaIl6/Fo+QfOqVHg6Qpi1r2a1oWYPioniV146sOr6dBG+PikxrJQQPn72Q==
X-Received: by 2002:a62:cc4d:: with SMTP id a74-v6mr27246511pfg.200.1534322880376;
        Wed, 15 Aug 2018 01:48:00 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id e26-v6sm25917816pfi.70.2018.08.15.01.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 01:47:59 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 12C513000A7; Wed, 15 Aug 2018 11:47:54 +0300 (+03)
Date:   Wed, 15 Aug 2018 11:47:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: migration: fix migration of huge PMD shared pages
Message-ID: <20180815084754.6ea4z4pzjkcwepsv@kshutemo-mobl1>
References: <20180813034108.27269-1-mike.kravetz@oracle.com>
 <20180813105821.j4tg6iyrdxgwyr3y@kshutemo-mobl1>
 <d4cf0f85-e010-36f2-3fae-f7983e4f6505@oracle.com>
 <20180814084837.nl7dkea7aov2pzao@black.fi.intel.com>
 <17bfe24d-957f-2985-f134-3ebe2648aecb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17bfe24d-957f-2985-f134-3ebe2648aecb@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 05:15:57PM -0700, Mike Kravetz wrote:
> On 08/14/2018 01:48 AM, Kirill A. Shutemov wrote:
> > On Mon, Aug 13, 2018 at 11:21:41PM +0000, Mike Kravetz wrote:
> >> On 08/13/2018 03:58 AM, Kirill A. Shutemov wrote:
> >>> On Sun, Aug 12, 2018 at 08:41:08PM -0700, Mike Kravetz wrote:
> >>>> I am not %100 sure on the required flushing, so suggestions would be
> >>>> appreciated.  This also should go to stable.  It has been around for
> >>>> a long time so still looking for an appropriate 'fixes:'.
> >>>
> >>> I believe we need flushing. And huge_pmd_unshare() usage in
> >>> __unmap_hugepage_range() looks suspicious: I don't see how we flush TLB in
> >>> that case.
> >>
> >> Thanks Kirill,
> >>
> >> __unmap_hugepage_range() has two callers:
> >> 1) unmap_hugepage_range, which wraps the call with tlb_gather_mmu and
> >>    tlb_finish_mmu on the range.  IIUC, this should cause an appropriate
> >>    TLB flush.
> >> 2) __unmap_hugepage_range_final via unmap_single_vma.  unmap_single_vma
> >>   has three callers:
> >>   - unmap_vmas which assumes the caller will flush the whole range after
> >>     return.
> >>   - zap_page_range wraps the call with tlb_gather_mmu/tlb_finish_mmu
> >>   - zap_page_range_single wraps the call with tlb_gather_mmu/tlb_finish_mmu
> >>
> >> So, it appears we are covered.  But, I could be missing something.
> > 
> > My problem here is that the mapping that moved by huge_pmd_unshare() in
> > not accounted into mmu_gather and can be missed on tlb_finish_mmu().
> 
> Ah, I think I now see the issue you are concerned with.
> 
> When huge_pmd_unshare succeeds we effectively unmap a PUD_SIZE area.
> The routine __unmap_hugepage_range may only have been passed a range
> that is a subset of PUD_SIZE.  In the case I was trying to address,
> try_to_unmap_one() the 'range' will certainly be less than PUD_SIZE.
> Upon further thought, I think that even in the case of try_to_unmap_one
> we should flush PUD_SIZE range.
> 
> My first thought would be to embed this flushing within huge_pmd_unshare
> itself.  Perhaps, whenever huge_pmd_unshare succeeds we should do an
> explicit:
> flush_cache_range(PUD_SIZE)
> flush_tlb_range(PUD_SIZE)
> mmu_notifier_invalidate_range(PUD_SIZE)
> That would take some of the burden off the callers of huge_pmd_unshare.
> However, I am not sure if the flushing calls above play nice in all the
> calling environments.  I'll look into it some more, but would appreciate
> additional comments.

I don't think it would work: flush_tlb_range() does IPI and calling it
under spinlock will not go well. I think we need to find a way to account
it properly in the mmu_gather. It's not obvious to me how.

-- 
 Kirill A. Shutemov
