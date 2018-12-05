Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3882082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNslt+2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3882082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeLEAHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:07:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32923 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLEAHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:07:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so9055381pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9vokIOQlMIV2EDFPoXLEssYrFZVmjeTmBWYKh9Xni8M=;
        b=rNslt+2qIpaZItdiP94cjTbTw0yZR4tWceGI6MxAdRU7R9Ujv6bdqc3QLfAHQZMbGi
         UbSvAunwrZmGe+tLreZAj3UCf7CyCEDD/MLQR2hzWVLT6zddns4otIoPS02Mlu49q8lH
         65MtnwiuFmBuArmrTbz57Fy++f84ZRu1k9dSNcd70hAWpLXRQkvRuKG9DIadaohDp1bJ
         8KEK/Cj39f3lFLfeQvubqRGS5UAJZZrnQweGX5c8P41T65u/VpDHTUx1Hjxxn98GZT5O
         vzBMepWxY7rIuFHhX/UVULk0DJHRRUUCp/7qN71zysdkMYca0ab7hXwfz/s/QQ60wStK
         rTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9vokIOQlMIV2EDFPoXLEssYrFZVmjeTmBWYKh9Xni8M=;
        b=BDUWdzA36TiZh1/s/ZpZDVazz/yRDKGSWhcaCF3cqgeDFtpJs7O444qXwb99QUo5mL
         J+E/wGLJvByU6TfheeNoCnUJDfsiFpX4vG4vbdoFjQ7DDxhEiYpcLfhlNp59jPIWWI/z
         LIajnEU/rXqYLSkUTpFrjLp7Te+olYrOPaIz2V1+gvKl6ICwND/7dPKog5NviKGDNyWW
         pHWrojVosME9qtFVj/Gzw5jEdy2sBY0K3dysuuyojoqU+Bzo+5RsLf+Zr1p6qtmB9gqu
         h8AogxV/l8wmPgHlTu/ViD/ycu+UbaCFcYeNeU6VOKkeYUb37ORC7SvqeDrvdTnbh/Bb
         UO+A==
X-Gm-Message-State: AA+aEWbREA8HWAz6JYTnn+jPjyYUXXDbPvQrM8bEJigUFFUqKnwrm1Gp
        Gwk6iWpSK6qD0QVCnTenn5NDsQ==
X-Google-Smtp-Source: AFSGD/UNOSXs2xhl5IUBMHC+eRIK+y4oNyXcYKiQDQg5Zt3UJq4Qniuk/JcHArR3mRXBoXOXBr8kUA==
X-Received: by 2002:a63:2bc4:: with SMTP id r187mr17140144pgr.306.1543968450022;
        Tue, 04 Dec 2018 16:07:30 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 19sm31739973pfs.108.2018.12.04.16.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 16:07:28 -0800 (PST)
Date:   Tue, 4 Dec 2018 16:07:27 -0800 (PST)
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
In-Reply-To: <20181204084821.GB1286@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812041551170.213718@chino.kir.corp.google.com>
References: <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com> <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com> <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz> <alpine.DEB.2.21.1812031237340.192288@chino.kir.corp.google.com> <20181203212539.GR31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812031345180.224765@chino.kir.corp.google.com> <20181204084821.GB1286@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Michal Hocko wrote:

> The thing I am really up to here is that reintroduction of
> __GFP_THISNODE, which you are pushing for, will conflate madvise mode
> resp. defrag=always with a numa placement policy because the allocation
> doesn't fallback to a remote node.
> 

It isn't specific to MADV_HUGEPAGE, it is the policy for all transparent 
hugepage allocations, including defrag=always.  We agree that 
MADV_HUGEPAGE is not exactly defined: does it mean try harder to allocate 
a hugepage locally, try compaction synchronous to the fault, allow remote 
fallback?  It's undefined.

The original intent was to be used when thp is disabled system wide 
(enabled set to "madvise") because its possible the rss of the process 
increases if backed by thp.  That occurs either if faulting on a hugepage 
aligned area or based on max_ptes_none.  So we have at least three 
possible policies that have evolved over time: preventing increased rss, 
direct compaction, remote fallback.  Certainly not something that fits 
under a single madvise mode.

> And that is a fundamental problem and the antipattern I am talking
> about. Look at it this way. All normal allocations are utilizing all the
> available memory even though they might hit a remote latency penalty. If
> you do care about NUMA placement you have an API to enforce a specific
> placement.  What is so different about THP to behave differently. Do
> we really want to later invent an API to actually allow to utilize all
> the memory? There are certainly usecases (that triggered the discussion
> previously) that do not mind the remote latency because all other
> benefits simply outweight it?
> 

What is different about THP is that on every platform I have measured, 
NUMA matters more than hugepages.  Obviously if on Broadwell, Haswell, and 
Rome, remote hugepages were a performance win over local pages, this 
discussion would not be happening.  Faulting local pages rather than 
local hugepages, if possible, is easy and doesn't require reclaim.  
Faulting remote pages rather than reclaiming local pages is easy in your 
scenario, it's non-disruptive.

So to answer "what is so different about THP?", it's the performance data.  
The NUMA locality matters more than whether the pages are huge or not.  We 
also have the added benefit of khugepaged being able to collapse pages 
locally if fragmentation improves rather than being stuck accessing a 
remote hugepage forever.

> That being said what should users who want to use all the memory do to
> use as many THPs as possible?

If those users want to accept the performance degradation of allocating 
remote hugepages instead of local pages, that should likely be an 
extension, either madvise or prctl.  That's not necessarily the usecase 
Andrea would have, I don't believe: he'd still prefer to compact memory 
locally and avoid the swap storm than allocate remotely.  If impossible to 
reclaim locally for regular pages, remote hugepages may be more beneficial 
than remote pages.
