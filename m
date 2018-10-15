Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E04A2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEu7ZYo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E04A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJPGRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:17:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37206 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbeJPGRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:17:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so10383490pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5qzMBKe4hSVql0JShje0PfcoYUllIIBgPg7evooeAXg=;
        b=YEu7ZYo1QAMbwT7oFD5vxJIrTdQ+XZcqR9o4V8iS6OzbdoQE1WAPer9ZqKqJmwrVpy
         kGsBLkgLzf4YP4VtwnRrowLmzzqsbhFRYVc6f2F9K1pfi1AOcAm/cdAdgG/NqBIqnHF7
         5YhXm6+H4Lwt99CCBx5+dfaEFLSszXw0NBuw/KyeTGQtd5Zf9qlGz12UXjoLEIgLayak
         U4sRSeY6Ev0ikA8f7IqF42CCujjT941KidAIhr7rdMZ5WupKsmfO744ko3Rs8q8wRpG2
         vtvlcLYqgB6z9nrm/LVf8qSM11V2A6R6edaAUjAkPCaw8Fg91kWIECSeneu4vgebi2q3
         jH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5qzMBKe4hSVql0JShje0PfcoYUllIIBgPg7evooeAXg=;
        b=LwQCHHOo0SjeiALrT5gfXeoHEet5edSYOL1XPTUwUnFPxAoXVPbFnd/Qfc5E3x9Bkk
         tC+l+hMeXWHlPqnlaaGCbknOCfumBAmK+b/VVr2j5+2mwFc8Y8ol8g7i/jXe+GFoZOiP
         JcoamgGPTpFeeUBDJ5s4owFRZMjHSR3IoYvy3PlqSWu7MpUJORAmDw6CCvzK7+hmeteO
         J+p6PcF464TlCMTEL0SyxskiybWZ/ogKSXmDzSfhLtAyqGngZ33cSTpZ9hV1MzaZ/LO7
         OARbAlqVLqecOXllExrwzY4fb5GAvBCoDIzT1hXLlW0UpjGoMDGJLG0pD1dzukEuuzQG
         FpUg==
X-Gm-Message-State: ABuFfogSyoV9E0AWPdSoySQ4FsXO5woQ43DmNxdjwYvyTiJVMPRdzfj9
        HVXTML1Dd/LpCGQrxbjH3PEHCQ==
X-Google-Smtp-Source: ACcGV60RgwIGk/zsAVW6E6+f8pvdUxj+JCU37YIBZqN5boRYAJ+PZ8ZBmGDM+EluP2SIA/RKLROzBw==
X-Received: by 2002:a63:4745:: with SMTP id w5-v6mr18144960pgk.377.1539642618604;
        Mon, 15 Oct 2018 15:30:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14033929pgm.79.2018.10.15.15.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:30:17 -0700 (PDT)
Date:   Mon, 15 Oct 2018 15:30:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
References: <20180925120326.24392-2-mhocko@kernel.org> <alpine.DEB.2.21.1810041302330.16935@chino.kir.corp.google.com> <20181005073854.GB6931@suse.de> <alpine.DEB.2.21.1810051320270.202739@chino.kir.corp.google.com> <20181005232155.GA2298@redhat.com>
 <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com> <20181009094825.GC6931@suse.de> <20181009122745.GN8528@dhcp22.suse.cz> <20181009130034.GD6931@suse.de> <20181009142510.GU8528@dhcp22.suse.cz> <20181009230352.GE9307@redhat.com>
 <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018, David Rientjes wrote:

> > I think "madvise vs mbind" is more an issue of "no-permission vs
> > permission" required. And if the processes ends up swapping out all
> > other process with their memory already allocated in the node, I think
> > some permission is correct to be required, in which case an mbind
> > looks a better fit. MPOL_PREFERRED also looks a first candidate for
> > investigation as it's already not black and white and allows spillover
> > and may already do the right thing in fact if set on top of
> > MADV_HUGEPAGE.
> > 
> 
> We would never want to thrash the local node for hugepages because there 
> is no guarantee that any swapping is useful.  On COMPACT_SKIPPED due to 
> low memory, we have very clear evidence that pageblocks are already 
> sufficiently fragmented by unmovable pages such that compaction itself, 
> even with abundant free memory, fails to free an entire pageblock due to 
> the allocator's preference to fragment pageblocks of fallback migratetypes 
> over returning remote free memory.
> 
> As I've stated, we do not want to reclaim pointlessly when compaction is 
> unable to access the freed memory or there is no guarantee it can free an 
> entire pageblock.  Doing so allows thrashing of the local node, or remote 
> nodes if __GFP_THISNODE is removed, and the hugepage still cannot be 
> allocated.  If this proposed mbind() that requires permissions is geared 
> to me as the user, I'm afraid the details of what leads to the thrashing 
> are not well understood because I certainly would never use this.
> 

At the risk of beating a dead horse that has already been beaten, what are 
the plans for this patch when the merge window opens?  It would be rather 
unfortunate for us to start incurring a 14% increase in access latency and 
40% increase in fault latency.  Would it be possible to test with my 
patch[*] that does not try reclaim to address the thrashing issue?  If 
that is satisfactory, I don't have a strong preference if it is done with 
a hardcoded pageblock_order and __GFP_NORETRY check or a new 
__GFP_COMPACT_ONLY flag.

I think the second issue of faulting remote thp by removing __GFP_THISNODE 
needs supporting evidence that shows some platforms benefit from this (and 
not with numa=fake on the command line :).

 [*] https://marc.info/?l=linux-kernel&m=153903127717471
