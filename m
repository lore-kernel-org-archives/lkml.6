Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9EEC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA662084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5ie3ZtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA662084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeJEDMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:12:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35284 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEDMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:12:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so5713224plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DRWXQwbaliKlq4Q4fGXtjROvaifpiIon+ksWJndx7Hc=;
        b=Z5ie3ZtMW/PzE7ePnAM4IPViOYJ1DzOH+xV4LjejwL2ufXtSedDcMRTSSFZtNE5+Pu
         KXDPMRZ6+DugonrTdHBPkwKJf2O2ChfVsX46Fyce2smenyyfEgRq91wn8mgaPE3kYay4
         PSX9exyu52nGNA1VXbCK5jPDNr66VdzPdPFHOGQKNXBmgTcw/FyatDCP574HFX/scE1O
         X8xFH8RdBsLkpc1NBE5wxBV/vH9m0P8Qi03K0YySS55BXfnlgr3KahK9Ai+bkq6/fGvx
         DsSHHZrMOyqscSPWbV2VQMjSM04lYjCKBslk3zeOe4U75qxLAhHX81EpnFzi/zHey3bc
         DiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DRWXQwbaliKlq4Q4fGXtjROvaifpiIon+ksWJndx7Hc=;
        b=EiDG2kvBGU2uNafE/eGuSsgOlbJhfDwdx2MWREuJUYHTJcPhMzfx+1ETRcvD57wfNN
         lwCS1WK19L2YngL0RhSPHT/jfYrxt9Qe+1VoLad9sa/acyeLwubgtBWzjvXPZDahGCxD
         4fbi88bwApZEpytcfK2BAx7houLj9NZtAu07nKFXAq2U4hYcX8YdtZ/U9dZzJ7SYUloW
         2ncH6CACl5f/koqXPwwv7yxCTYNHLhLEKjCJ9SjS1LFLUhJiOFzsdQC3B+bTLsYbJVRs
         +RE0577lJLywE/6q2BfdyS/Ei+ki5KJfh+wwa0RRbhYcPG0kl5OrZmr3rPQVOWYfwAPS
         /dRA==
X-Gm-Message-State: ABuFfojGh4JvWf+018OcmAOsGCRRSsb20nkp0R8yQ9nX2KbhKfTRv9yb
        MzfdiTyqHM0icmn7tx+KFJj9tQ==
X-Google-Smtp-Source: ACcGV615cF6rPSXT32kBqm0h933J6n5iqZtPCOBx9IWijX3yQCPP3bKH5gIaR1nDGLqpc2S+rxkROQ==
X-Received: by 2002:a17:902:292a:: with SMTP id g39-v6mr8196873plb.269.1538684273724;
        Thu, 04 Oct 2018 13:17:53 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s78-v6sm21317260pfd.138.2018.10.04.13.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 13:17:52 -0700 (PDT)
Date:   Thu, 4 Oct 2018 13:17:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, thp: consolidate THP gfp handling into
 alloc_hugepage_direct_gfpmask
In-Reply-To: <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
Message-ID: <alpine.DEB.2.21.1810041317010.16935@chino.kir.corp.google.com>
References: <20180925120326.24392-1-mhocko@kernel.org> <20180925120326.24392-3-mhocko@kernel.org> <20180926133039.y7o5x4nafovxzh2s@kshutemo-mobl1>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018, Kirill A. Shutemov wrote:

> On Tue, Sep 25, 2018 at 02:03:26PM +0200, Michal Hocko wrote:
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index c3bc7e9c9a2a..c0bcede31930 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -629,21 +629,40 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> >   *	    available
> >   * never: never stall for any thp allocation
> >   */
> > -static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
> > +static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma, unsigned long addr)
> >  {
> >  	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
> > +	gfp_t this_node = 0;
> > +
> > +#ifdef CONFIG_NUMA
> > +	struct mempolicy *pol;
> > +	/*
> > +	 * __GFP_THISNODE is used only when __GFP_DIRECT_RECLAIM is not
> > +	 * specified, to express a general desire to stay on the current
> > +	 * node for optimistic allocation attempts. If the defrag mode
> > +	 * and/or madvise hint requires the direct reclaim then we prefer
> > +	 * to fallback to other node rather than node reclaim because that
> > +	 * can lead to excessive reclaim even though there is free memory
> > +	 * on other nodes. We expect that NUMA preferences are specified
> > +	 * by memory policies.
> > +	 */
> > +	pol = get_vma_policy(vma, addr);
> > +	if (pol->mode != MPOL_BIND)
> > +		this_node = __GFP_THISNODE;
> > +	mpol_cond_put(pol);
> > +#endif
> 
> I'm not very good with NUMA policies. Could you explain in more details how
> the code above is equivalent to the code below?
> 

It breaks mbind() because new_page() is now using numa_node_id() to 
allocate migration targets for instead of using the mempolicy.  I'm not 
sure that this patch was tested for mbind().
