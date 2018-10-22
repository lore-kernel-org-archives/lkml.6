Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796DEC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A0120663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzTUXRck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A0120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeJWFOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:14:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35986 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeJWFOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:14:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id l81-v6so20511507pfg.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=S9B+aSN/dIMGBX39YxxuZ/oHFrMoDdlIR8nN13WzIB0=;
        b=UzTUXRckqG09UTcK26iNGeldrG1AYLKUD28TOzOpdsFjnaw2h4o6D2WT+7HdR2iRL7
         ONlUTNZQ5+LWAxmABOeUPfvVQFxMAkFRySage/iIra4vHIB2kWqwWsgZQSDSXkXmYn4G
         wNVcKEJXPgqgD5fsaZjMFK0Y8Osd+yqlt2GZHnMWAosu0qG1FgGDKVdXtKBpEY3qjoLs
         0ErT0MvqFOs2AcZYpJQkXUgnLkNF1BuaVmcGDXk/oD7M0t6qMN7U2Xavr6ZvJ/ZSgYwo
         NsNUjFhF3l1IYAlx4GYirzo4Oft/lPzU4DZS0rYCt4ekZHi60AwAsIiBn1OsSDD40yCX
         HOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=S9B+aSN/dIMGBX39YxxuZ/oHFrMoDdlIR8nN13WzIB0=;
        b=PUK+Iu8Ug383FUg9YAt0FOR/ba+79scW5LqmhttF1k506dJ26g+MOV3+9+bG2gRBgH
         5DPgthdiL/vHiW3fSZqn+O/Hdk2x5qKvYt0aDzDbisp8vWJE48fMcJwvPtjRhwkTLuyn
         eFGIPsg2eLTp27+//saidAfg7s43Br6woxOZCmBnsvBXfe0/yOHGOrbdYXIOqXHRdGrR
         lHLVbPV5tQK0qQmiFA3P6lnm6678OY0ZNpxYiJBZpCqc0OA2BngCrNE6VBPg1G56M1MZ
         SrQs6z2nNJvGNz6HcjjRAFmJQo+/cxo1SfcBDT3o7OaPWSZFLNtrAVW5wBgruw/elwy+
         jRiw==
X-Gm-Message-State: ABuFfojJin18x68NEN18BNotXVj0pnQrFCtwxrvSjUv0dCjDGwkWMAON
        EYhRMC+MAdvZX4WWAxuMGobOPA==
X-Google-Smtp-Source: ACcGV605A1ontbdvYmGqkyWSgcpNKDenQnStYkIhqwBSuxtX6+femrdjXrLTacWQfqCRbWn+j7Su1A==
X-Received: by 2002:a63:1a1c:: with SMTP id a28-v6mr43362200pga.157.1540241675409;
        Mon, 22 Oct 2018 13:54:35 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p7-v6sm41989160pfb.101.2018.10.22.13.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 13:54:34 -0700 (PDT)
Date:   Mon, 22 Oct 2018 13:54:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20181015231953.GC30832@redhat.com>
Message-ID: <alpine.DEB.2.21.1810221346130.120157@chino.kir.corp.google.com>
References: <20181005232155.GA2298@redhat.com> <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com> <20181009094825.GC6931@suse.de> <20181009122745.GN8528@dhcp22.suse.cz> <20181009130034.GD6931@suse.de> <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com> <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com> <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com> <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
 <20181015231953.GC30832@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Andrea Arcangeli wrote:

> > On Mon, 15 Oct 2018 15:30:17 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> > >  Would it be possible to test with my 
> > > patch[*] that does not try reclaim to address the thrashing issue?
> > 
> > Yes please.
> 
> It'd also be great if a testcase reproducing the 40% higher access
> latency (with the one liner original fix) was available.
> 

I never said 40% higher access latency, I said 40% higher fault latency.  

The higher access latency is 13.9% as measured on Haswell.

The test case is rather trivial: fragment all memory with order-4 memory 
to replicate a fragmented local zone, use sched_setaffinity() to bind to 
that node, and fault a reasonable number of hugepages (128MB, 256, 
whatever).  The cost of faulting remotely in this case was measured to be 
40% higher than falling back to local small pages.  This occurs quite 
obviously because you are thrashing the remote node trying to allocate 
thp.

> We don't have a testcase for David's 40% latency increase problem, but
> that's likely to only happen when the system is somewhat low on memory
> globally.

Well, yes, but that's most of our systems.  We can't keep around gigabytes 
of memory free just to work around this patch.  Removing __GFP_THISNODE to 
avoid thrashing the local node obviously will incur a substantial 
performance degradation if you thrash the remote node as well.  This 
should be rather straight forward.

> When there's 75% or more of the RAM free (not even allocated as easily
> reclaimable pagecache) globally, you don't expect to hit heavy
> swapping.
> 

I agree there is no regression introduced by your patch when 75% of memory 
is free.

> The 40% THP allocation latency increase if you use MADV_HUGEPAGE in
> such window where all remote zones are fully fragmented is somehow
> lesser of a concern in my view (plus there's the compact deferred
> logic that should mitigate that scenario). Furthermore it is only a
> concern for page faults in MADV_HUGEPAGE ranges. If MADV_HUGEPAGE is
> set the userland allocation is long lived, so such higher allocation
> latency won't risk to hit short lived allocations that don't set
> MADV_HUGEPAGE (unless madvise=always, but that's not the default
> precisely because not all allocations are long lived).
> 
> If the MADV_HUGEPAGE using library was freely available it'd also be
> nice.
> 

You scan your mappings for .text segments, map a hugepage-aligned region 
sufficient in size, mremap() to that region, and do MADV_HUGEPAGE.
