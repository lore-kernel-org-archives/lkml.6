Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC02AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988B620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQp9FvYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988B620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeLETQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:16:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32959 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLETQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:16:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so10527528plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 11:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dkWojcqzBp1yJR0b48iQ1xH9QGsAk/+XP8G5S+2k5Bk=;
        b=fQp9FvYYXSucRU98yPjqoIryRcgSDwD+cgSaFAfbmKWAe6hUNpf+GykoyTPejD8PGa
         F2XMD4/RP6rbKhDFzQMdaxR9gPh/dXK5Bs8WzC3v0MQq5zRDnt7hJj4844l5EuSk1hyy
         GYdpHLuvlB4MwvNyNDsqIqG28Tf+bWyRiqxrUJH+wrXVG9E43WPE9Llko7vfd1XcjKyj
         321IYrhbZwrhUoGGW6omEfWWqnj/Czckp/bkZZM89obSQD83u+TjbZBj0HlBl9qxE+Ap
         S88fPISoBglvE9s72JfndjMzCi1sIxzAMCXrCSg8eKDJjZAYAsGR44qRH2htPr/uCfdz
         qqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dkWojcqzBp1yJR0b48iQ1xH9QGsAk/+XP8G5S+2k5Bk=;
        b=NXiDDmQBOX+MEdv9hi2V8moHLcukhrDAUQ5UTUZ4nq/AHzVssumo2I0gknrE/QJsUp
         jOeNmqcR6TpV+cNcJxNKpdXEoooAVmoSo1BXgsKm1V3GZrVNjTsuliV9NvjTpMh7O8nB
         qPL1zrC4o5AuxP3zU6ElBYNfTIF9Nv830kv7ANsxPi9tx8FYdCanZfpWeKdTkU7lCOJG
         pkq6RX7Q/K4EKfm8EOGJTM8aDybty/ut0Cc5w3P8Fym/qyVUamvQ70rMgQCWPsAdshx+
         RaLynQ6lBrIa8DocHcezFaOjPYNKHVTo4UUoaGpSyNKLw+wXiiDLnaJe7GMvYIHnZ1+F
         hlHg==
X-Gm-Message-State: AA+aEWYVGxGbVuVi1EotWatIBEOcyXo1BhhO+H8fAF79Ee8WpDHmy+Rv
        OXUylzoDMJfCE4eAORywkayHPg==
X-Google-Smtp-Source: AFSGD/Un+WzBt34Ri1tu6lEy2RPgMJjKkuqelCWWrFhGew+1F/4fI4DSvbHS+zUwSb9LHfecQZISVA==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr25500348plb.79.1544037367050;
        Wed, 05 Dec 2018 11:16:07 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j9sm25378264pfi.86.2018.12.05.11.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 11:16:05 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:16:05 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181205101836.GF1286@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812051103560.240991@chino.kir.corp.google.com>
References: <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812031237340.192288@chino.kir.corp.google.com> <20181203212539.GR31738@dhcp22.suse.cz> <alpine.DEB.2.21.1812031345180.224765@chino.kir.corp.google.com> <20181204084821.GB1286@dhcp22.suse.cz> <alpine.DEB.2.21.1812041551170.213718@chino.kir.corp.google.com>
 <20181205101836.GF1286@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Michal Hocko wrote:

> > It isn't specific to MADV_HUGEPAGE, it is the policy for all transparent 
> > hugepage allocations, including defrag=always.  We agree that 
> > MADV_HUGEPAGE is not exactly defined: does it mean try harder to allocate 
> > a hugepage locally, try compaction synchronous to the fault, allow remote 
> > fallback?  It's undefined.
> 
> Yeah, it is certainly underdefined. One thing is clear though. Using
> MADV_HUGEPAGE implies that the specific mapping benefits from THPs and
> is willing to pay associated init cost. This doesn't imply anything
> regarding NUMA locality and as we have NUMA API it shouldn't even
> attempt to do so because it would be conflating two things.

This is exactly why we use MADV_HUGEPAGE when remapping our text segment 
to be backed by transparent hugepages, we want to pay the cost at startup 
to fault thp and that involves synchronous memory compaction rather than 
quickly falling back to remote memory.  This is making the case for me.

> > So to answer "what is so different about THP?", it's the performance data.  
> > The NUMA locality matters more than whether the pages are huge or not.  We 
> > also have the added benefit of khugepaged being able to collapse pages 
> > locally if fragmentation improves rather than being stuck accessing a 
> > remote hugepage forever.
> 
> Please back your claims by a variety of workloads. Including mentioned
> KVMs one. You keep hand waving about access latency completely ignoring
> all other aspects and that makes my suspicious that you do not really
> appreciate all the complexity here even stronger.
> 

I discussed the tradeoff of local hugepages vs local pages vs remote 
hugepages in https://marc.info/?l=linux-kernel&m=154077010828940 on 
Broadwell, Haswell, and Rome.  When a single application does not fit on a 
single node, we obviously need to extend the API to allow it to fault 
remotely.  We can do that without changing long-standing behavior that 
prefers to only fault locally and causing real-world users to regress.  
Your suggestions about how we can extend the API are all very logical.

 [ Note that is not the regression being addressed here, however, which is 
   massive swap storms due to a fragmented local node, which is why the
   __GFP_COMPACT_ONLY patch was also proposed by Andrea.  The ability to
   prefer faulting remotely is a worthwhile extension but it does no
   good whatsoever if we can encounter massive swap storms because we
   didn't set __GFP_NORETRY appropriately (which both of our patches do)
   both locally and now remotely. ]
