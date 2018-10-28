Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010DEC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FDD20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiLj1jAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FDD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeJ2GbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 02:31:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42241 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbeJ2GbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 02:31:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so2888975pgq.9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 14:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bn/yM4Z8LJic6gupcZse/sA0oCa3d10eVaI5C4D53NM=;
        b=NiLj1jAirwZ8g/S+PveamliyOuQ7XW3bBrqkQtB2E2E1OU481H7PnpMYP+0wEPiCrA
         kvkSfD3I4xw7fGv2sOH6FDWq9Vc6WqxOAbyK+vwP+eRxIyQu7OfCag7rvK4Vz/m2+dVP
         B2NJv0CsAOXNDqbVliBeS3Uxvs8IJqSwjWVjpQ0kLSuejFmW+Hy4Ir90Wh26RuWKSr9X
         UYWLUuFRJujsfVdmO2eO77HzQdb5Lb8eAH8vm40ytZ/kU8jjOI1U5IWxRnkpZpxmE5mZ
         lMwlfzu7f/b+sDB+9rpfxA3IC2LriiaEFjH4ynMNRL7CW42WEtMyJGqcnyYj77MyCcbJ
         mRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bn/yM4Z8LJic6gupcZse/sA0oCa3d10eVaI5C4D53NM=;
        b=KjpUlod5ztZl2Cx2/ylECP4d8YugT+Ujmj+XiYCb4zfAG9BuURVmioWMZ0Tonw/B57
         bli/MXXkDgZavlurqV43rnsxGvm23R71JBRdwozZqB2a0NuM0Zwbdqn6GZktL2dHrLqp
         FOk/qqLqWHmwACK4xfk0OKpU/PSRSnUkPwrwws5C8SAnoBk7NEMLk76Xl3YqVVGK5Hyy
         q7i26sAqKenGoT4HPappJ21t4t6kNYsWGEB8KYU+NGSvP3GJgcksVjbSON6n3ceCXz1v
         cIRMVRUY4Wktqmw56UEdqQhDjl20ia03eIbYQyDFNy6iaZcvaeQ09x3E9qCy27GCsZaF
         eozg==
X-Gm-Message-State: AGRZ1gKDGhxdfQmH6DjMBZ+3uc2VeHdP3zJMvCgSTSG/rFc2bT9yG9ST
        suHFlD4Qy/lX1inT3+CBMX1dyQ==
X-Google-Smtp-Source: AJdET5c03Mh1cu2+zobg732TNDR+3MR6qhiDe+sPqy6mBF2lIyaTW8usCmVImVy+++EIweWdx9+scg==
X-Received: by 2002:a63:2643:: with SMTP id m64mr11149602pgm.35.1540763106867;
        Sun, 28 Oct 2018 14:45:06 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m25-v6sm10754623pgb.67.2018.10.28.14.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 14:45:05 -0700 (PDT)
Date:   Sun, 28 Oct 2018 14:45:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Zi Yan <zi.yan@cs.rutgers.edu>
cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <0BA54BDA-D457-4BD8-AC49-1DD7CD032C7F@cs.rutgers.edu>
Message-ID: <alpine.DEB.2.21.1810281426260.129745@chino.kir.corp.google.com>
References: <20181005232155.GA2298@redhat.com> <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com> <20181009094825.GC6931@suse.de> <20181009122745.GN8528@dhcp22.suse.cz> <20181009130034.GD6931@suse.de> <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com> <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com> <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com> <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org> <20181016074606.GH6931@suse.de>
 <alpine.DEB.2.21.1810221355050.120157@chino.kir.corp.google.com> <0BA54BDA-D457-4BD8-AC49-1DD7CD032C7F@cs.rutgers.edu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018, Zi Yan wrote:

> Hi David,
> 

Hi!

> On 22 Oct 2018, at 17:04, David Rientjes wrote:
> 
> > On Tue, 16 Oct 2018, Mel Gorman wrote:
> > 
> > > I consider this to be an unfortunate outcome. On the one hand, we have a
> > > problem that three people can trivially reproduce with known test cases
> > > and a patch shown to resolve the problem. Two of those three people work
> > > on distributions that are exposed to a large number of users. On the
> > > other, we have a problem that requires the system to be in a specific
> > > state and an unknown workload that suffers badly from the remote access
> > > penalties with a patch that has review concerns and has not been proven
> > > to resolve the trivial cases.
> > 
> > The specific state is that remote memory is fragmented as well, this is
> > not atypical.  Removing __GFP_THISNODE to avoid thrashing a zone will only
> > be beneficial when you can allocate remotely instead.  When you cannot
> > allocate remotely instead, you've made the problem much worse for
> > something that should be __GFP_NORETRY in the first place (and was for
> > years) and should never thrash.
> > 
> > I'm not interested in patches that require remote nodes to have an
> > abundance of free or unfragmented memory to avoid regressing.
> 
> I just wonder what is the page allocation priority list in your environment,
> assuming all memory nodes are so fragmented that no huge pages can be
> obtained without compaction or reclaim.
> 
> Here is my version of that list, please let me know if it makes sense to you:
> 
> 1. local huge pages: with compaction and/or page reclaim, you are willing
> to pay the penalty of getting huge pages;
> 
> 2. local base pages: since, in your system, remote data accesses have much
> higher penalty than the extra TLB misses incurred by the base page size;
> 
> 3. remote huge pages: at least it is better than remote base pages;
> 
> 4. remote base pages: it performs worst in terms of locality and TLBs.
> 

I have a ton of different platforms available.  Consider a very basic 
access latency evaluation on Broadwell on a running production system: 
remote hugepage vs remote PAGE_SIZE pages had about 5% better access 
latency.  Remote PAGE_SIZE pages vs local pages is a 12% degradation.  On 
Naples, remote hugepage vs remote PAGE_SIZE had 2% better access latency 
intrasocket, no better access latency intersocket.  Remote PAGE_SIZE pages 
vs local is a 16% degradation intrasocket and 38% degradation intersocket.

My list removes (3) from your list, but is otherwise unchanged.  I remove 
(3) because 2-5% better access latency is nice, but we'd much rather fault 
local base pages and then let khugepaged collapse it into a local hugepage 
when fragmentation is improved or we have freed memory.  That is where we 
can get a much better result, 41% better access latency on Broadwell and 
52% better access latncy on Naples.  I wouldn't trade that for 2-5% 
immediate remote hugepages.

It just so happens that prior to this patch, the implementation of the 
page allocator matches this preference.

> In addition, to prioritize local base pages over remote pages,
> the original huge page allocation has to fail, then kernel can
> fall back to base page allocations. And you will never get remote
> huge pages any more if the local base page allocation fails,
> because there is no way back to huge page allocation after the fallback.
> 

That is exactly what we want, we want khugepaged to collapse memory into 
local hugepages for the big improvement rather than persistently access a 
hugepage remotely; the win of the remote hugepage just isn't substantial 
enough, and the win of the local hugepage is just too great.

> > I'd like to know, specifically:
> > 
> >  - what measurable affect my patch has that is better solved with removing
> >    __GFP_THISNODE on systems where remote memory is also fragmented?
> > 
> >  - what platforms benefit from remote access to hugepages vs accessing
> >    local small pages (I've asked this maybe 4 or 5 times now)?
> > 
> >  - how is reclaiming (and possibly thrashing) memory helpful if compaction
> >    fails to free an entire pageblock due to slab fragmentation due to low
> >    on memory conditions and the page allocator preference to return node-
> >    local memory?
> > 
> >  - how is reclaiming (and possibly thrashing) memory helpful if compaction
> >    cannot access the memory reclaimed because the freeing scanner has
> >    already passed by it, or the migration scanner has passed by it, since
> >    this reclaim is not targeted to pages it can find?
> > 
> >  - what metrics can be introduced to the page allocator so that we can
> >    determine that reclaiming (and possibly thrashing) memory will result
> >    in a hugepage being allocated?
> 
> The slab fragmentation and whether reclaim/compaction can help form
> huge pages seem to orthogonal to this patch, which tries to decide
> the priority between locality and huge pages.
> 

It's not orthogonal to the problem being reported which requires local 
memory pressure.  If there is no memory pressure, compaction often can 
succeed without reclaim because the freeing scanner can find target 
memory and the migration scanner can make a pageblock free.  Under memory 
pressure, however, where Andrea is experiencing the thrashing of the local 
node, by this time it can be inferred that slab pages have already fallen 
bcak to MIGRATE_MOVABLE pageblocks.  There is nothing preventing it under 
memory pressure because of the preference to return local memory over 
fragmenting pageblocks.

So the point of slab fragmentation, which typically exists locally when 
there is memory pressure, is that we cannot ascertain whether memory 
compaction even with reclaim will be successful.  Not only because the 
freeing scanner cannot access reclaimed memory, but also because we have 
no feedback from compaction to determine whether the work will be useful.  
Thrashing the local node, migrating COMPACT_CLUSTER_MAX pages, finding one 
slab page sitting in the pageblock, and continuing is not a good use of 
the allocator's time.  This is true of both MADV_HUGEPAGE and 
non-MADV_HUGEPAGE regions.

For reclaim to be considered, we should ensure that work is useful to 
compaction.  That ability is non-existant.  The worst case scenario is you 
thrash the local node and still cannot allocate a hugepage.
