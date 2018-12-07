Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DCDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7529220673
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhkehH1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7529220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLGXFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:05:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47055 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLGXFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:05:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so2594743pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 15:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pvY21zCNq3Q0MSKaFyLObZDxqXWhkh74H8m/h+IpBoE=;
        b=UhkehH1ogHxeR9vHbpLHeXG9xDrnfumxa/wGpCK/SX9ydXjBl6jYJ/60gFznZrLhYL
         OXxiPS6FoEsjdE0TozfcwuKh8oYY6jqQGH5O6gu0IEqWyjtlx1MMiijBya1nrWnq1EiO
         4vVHvjJiBv21G3UhqMsz86cikuYAnValF4rNjMIZDy3yCcaA1JCym5qiFfUYduJAj/jW
         Os9wnILrcMSweRszTgbyp6vbPJgRoGNeAFAig+tL4T22sf5z/Yh/L0ESkknzxfmEj7oF
         rLEFZ/G61VVRrMojFRLHOt9k29PsVgbd18k2pUFPmD1C38GtM2MvPwS08oEsVBQsGE9m
         /C6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pvY21zCNq3Q0MSKaFyLObZDxqXWhkh74H8m/h+IpBoE=;
        b=iilz6tYFfbpy1MwXJ9vu+7i6n31vqnn+YOfdC3jAeT6xLTYD8dhw65TrOEHX2M5+No
         kbdc3Hzm8TQacSHF/NBsByuRfW8tJLc/sZZBEPfdqaFNUhkpwPW4cshdLv5Gb5Xatbrx
         FBLCz3sRphzri6/tWueCgNmizZwRDkHOPD0VGcspfbATwr2Cm+46htuc2OdTcbKnzI7t
         Im59SD5AsV9k8sVVMd/1JqVHXKvqyN9qKdsuKSIvu/4obBCj3Zz/9mNH+HlRMO3Ap1LU
         Y2rEFIE0FCj5CiS5IU6ZR3BwZ0FB65WSyKoPSdcF0TTeMRY6PdOvxymKDqzMCVq6M5cl
         Uofg==
X-Gm-Message-State: AA+aEWZpxBGeT0mJz/JmeLfSGzIfkFL/imTQGVJy3rHbYriF6t1XSwYX
        7b4IitFOwCMp2QvF8ZbfHrETYA==
X-Google-Smtp-Source: AFSGD/VfaynaykLzGnMdEjKpKvFTWvmMIUcUbb5AuFBG8qO69ZvX0JkiujLbDUCb3CO488AO+ZSldw==
X-Received: by 2002:a63:151f:: with SMTP id v31mr3551887pgl.34.1544223929748;
        Fri, 07 Dec 2018 15:05:29 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t87sm12907625pfk.122.2018.12.07.15.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:05:28 -0800 (PST)
Date:   Fri, 7 Dec 2018 15:05:28 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch for-4.20] Revert "mm, thp: consolidate THP gfp handling
 into alloc_hugepage_direct_gfpmask"
In-Reply-To: <20181207080515.GT1286@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812071450270.173448@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com> <alpine.DEB.2.21.1812061341130.144733@chino.kir.corp.google.com> <alpine.DEB.2.21.1812061343240.144733@chino.kir.corp.google.com> <20181207080515.GT1286@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018, Michal Hocko wrote:

> > This reverts commit 89c83fb539f95491be80cdd5158e6f0ce329e317.
> > 
> > There are a couple of issues with 89c83fb539f9 independent of its partial 
> > revert in 2f0799a0ffc0 ("mm, thp: restore node-local hugepage 
> > allocations"):
> > 
> > Firstly, the interaction between alloc_hugepage_direct_gfpmask() and 
> > alloc_pages_vma() is racy wrt __GFP_THISNODE and MPOL_BIND.  
> > alloc_hugepage_direct_gfpmask() makes sure not to set __GFP_THISNODE for 
> > an MPOL_BIND policy but the policy used in alloc_pages_vma() may not be 
> > the same for shared vma policies, triggering the WARN_ON_ONCE() in 
> > policy_node().
> 
> Could you share a test case?
> 

Sorry, as Vlastimil pointed out this race does not exist anymore since 
commit 2f0799a0ffc0 ("mm, thp: restore node-local hugepage allocations") 
since it removed the restructuring of alloc_hugepage_direct_gfpmask().  It 
existed prior to this commit for shared vma policies that could modify the 
policy between alloc_hugepage_direct_gfpmask() and alloc_pages_vma() if 
the policy switches to MPOL_BIND in that window.

> > Secondly, prior to 89c83fb539f9, alloc_pages_vma() implemented a somewhat 
> > different policy for hugepage allocations, which were allocated through 
> > alloc_hugepage_vma().  For hugepage allocations, if the allocating 
> > process's node is in the set of allowed nodes, allocate with 
> > __GFP_THISNODE for that node (for MPOL_PREFERRED, use that node with 
> > __GFP_THISNODE instead).
> 
> Why is it wrong to fallback to an explicitly configured mbind mask?
> 

The new_page() case is similar to the shmem_alloc_hugepage() case.  Prior 
to 89c83fb539f9 ("mm, thp: consolidate THP gfp handling into 
alloc_hugepage_direct_gfpmask"), shmem_alloc_hugepage() did 
alloc_pages_vma() with hugepage == true, which effected a different 
allocation policy: if the node current is running on is allowed by the 
policy, use __GFP_THISNODE (considering ac5b2c18911ff is reverted, which 
it is in Linus's tree).

After 89c83fb539f9, we lose that and can fallback to remote memory.  Since 
the discussion is on-going wrt the NUMA aspects of hugepage allocations, 
it's better to have a stable 4.20 tree while that is being worked out and 
likely deserves separate patches for both new_page() and 
shmem_alloc_hugepage().  For the latter specifically, I assume it would be 
nice to get an Acked-by by Kirill who implemented shmem_alloc_hugepage() 
with hugepage == true back in 4.8 that also had the __GFP_THISNODE 
behavior before the allocation policy is suddenly changed.
