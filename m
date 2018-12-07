Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4B6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F88420838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UJCkoy7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F88420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGW1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:27:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35209 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:27:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so2446959plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 14:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PZD9rNqXHpyLqQ9/SyAFyoxq5uk/uHW0TGcsAg0pITo=;
        b=UJCkoy7Z9/3o3PGUFf/Nm1nrOZc/+G5dsLbgJJvkpija3l1otpPcrs0d8cXUmJvm8A
         ckkQEd5qPQZcGnyyipmTF3CFB8fFoFv3IifjnqAo/rPetFovhMkTBWsXnm1bSlgUJN7A
         VvJDwIf4Xgs+HEiPUByb1llI8f9azHfBM0XIEA/4oVd43zYijuJ17hLjTpBtuoWU7y9g
         XwIpUIK8wTtdj43NdDBIPb6FcUMjH+FqbJSjUcH7W4D+208+wuv+qsSFIRypLhkVzvVM
         xNaVswlwPyRAE03GSgWp0TUj4Tu6/DNKuJBV3k7+3vxsnt6NpxPZtDlfM78YpBK8xtbQ
         WTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PZD9rNqXHpyLqQ9/SyAFyoxq5uk/uHW0TGcsAg0pITo=;
        b=Lf5CqyON3LCXG+x0n5SLLDq77BjLb8Tu94+ie+c+gmWf4yAytqhH+em3+mEz7gCYvu
         FXVSjOWgOVORWH2VMbHNd1TTXVD/Uwyu3v+nLcpGfovpytmUktPRRo115rrVRY1Y1zqP
         avWdw2JkPz4CQjmz5BziLjSCmoJA9tUUXPT1/Uo84Xf1Fd3qb1aCzsAIgvfaYLedonWC
         V7mQ53ZLAuA8pUJep1Jlbptcg+Q4SSNl/sSrvvumgTh4GN4IFfhivaO/9LzNp6pp9ag3
         cQmtt+NbJsEe8TvTma43QXoK4KNPKWrhd6hBw0QCeod1N3wtKBA/9kTrGaRA/VLO+GpN
         zijw==
X-Gm-Message-State: AA+aEWYrMri4DqvZxh4lNuGw1pbnRzS5f9lnrALU4jdi6qc3iOE5AyR/
        eh6qVxVkLFaWFBFx01UEQgkLdA==
X-Google-Smtp-Source: AFSGD/VkIyh4dUtYg03xGinKhTzZi+pk2A0mvViqZamq9qjk9/mRn4il/SsLS+1pJK8CHsymu63EUQ==
X-Received: by 2002:a17:902:6502:: with SMTP id b2mr3762490plk.44.1544221643942;
        Fri, 07 Dec 2018 14:27:23 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x2sm5509976pfx.78.2018.12.07.14.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:27:23 -0800 (PST)
Date:   Fri, 7 Dec 2018 14:27:22 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, mhocko@kernel.org,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [patch for-4.20] Revert "mm, thp: consolidate THP gfp handling
 into alloc_hugepage_direct_gfpmask"
In-Reply-To: <296d9813-1dfe-f27c-8d2c-6f140d8a5b0d@suse.cz>
Message-ID: <alpine.DEB.2.21.1812071421030.148470@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1812051445390.35948@chino.kir.corp.google.com> <alpine.DEB.2.21.1812061341130.144733@chino.kir.corp.google.com> <alpine.DEB.2.21.1812061343240.144733@chino.kir.corp.google.com> <296d9813-1dfe-f27c-8d2c-6f140d8a5b0d@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018, Vlastimil Babka wrote:

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
> AFAICS 2f0799a0ffc0 removed the policy check in
> alloc_hugepage_direct_gfpmask() comlpetely, so it's not racy and the
> warning will always trigger for a MPOL_BIND policy right now?
> 

Yup, looks like you hit it on the head.  This revert should have been done 
alongside 2f0799a0ffc0 ("mm, thp: restore node-local hugepage 
allocations"), I didn't appreciate how invasive the consolidation patch 
was.

I noticed the race in 89c83fb539f9 ("mm, thp: consolidate THP gfp handling 
into alloc_hugepage_direct_gfpmask") that is fixed by the revert, but as 
you noted it didn't cleanup the second part which is the balancing act for 
gfp flags between alloc_hugepage_direct_gfpmask() and alloc_pages_vma().  
Syzbot found this to trigger the WARN_ON_ONCE() you mention.

So we certainly need this patch for 4.20 as a follow-up to 2f0799a0ffc0.  
It's likely better to regroup and discuss NUMA aspects of all thp 
allocations separately with a stable 4.20.
