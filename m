Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A077C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8AC208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L14wJdt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbeLNVEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:04:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35993 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:04:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so3394324pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2Uj7Evgeh/euHu0e+ne6LFlptqF9tYY/NIu1LST6IPY=;
        b=L14wJdt43ZncO4ON2pUfTxMJYnYkmXLUrPN5n7+eeSsGc+YoMakymaEPxoA53m3pug
         35zxbk7UGOprpM13vTC/gnDaZL1TScdM78rFaq8GO1JSnBZLx/SC0TZAxJmXeLaTzpbj
         lrSuaOG3es5aSvX6VGSSAm5puYlG+fhFbr85K7cFLzmB7iJ68ygMet75FLkDsosEff1B
         OaKR5KF6ChLjO908Ht+soejI5WP0US9zKVaHhP1Lv7TbT6L1Uu1S7tF794XogfQ2lftT
         o6ZP+O5gOymOxD1REhk4h1nA3omyDoSR6K/VBVKwZZVtcpPj3zHLazUKXuVLU21pnv++
         eaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2Uj7Evgeh/euHu0e+ne6LFlptqF9tYY/NIu1LST6IPY=;
        b=f+8TBipOluI1Wd03MVLmlSqXWrkb+xIv9bDm++EXPcTAcvBUp60Zyn2fr0JX3heww7
         PW78SbDno2adyhrI7s9Khb/+IR6VQxEacneMZt9xm3UpQsCTiNXlkNCa0iDODEhr5KPx
         o0Q3Ez0x0M0ynVQuqJ0hh5aEWU8HnDm9Zq27obQi4JcZTcAaSLVSyNSggWlCAgIAhXNC
         dC4/Edg0Nm1M6VnwqZY9GvYwkVfX88aKJpLtljvD3Ru2i1Lm6l3VfqGqqDIvjLr9Y7JP
         XFcj9rcYRDkadLNrELZkLyOUaK4onWcAm+FXaUztEnoSGQHd+FNTbGyUXw5HyYgcNGgz
         rGWQ==
X-Gm-Message-State: AA+aEWaMBbvr6bGb7B05yD8uvh9ojjO46b56yuTrbVBEGDtphz4Hmb0R
        cHRtZwCoZVNEAVO9Z1uNpBOw7A==
X-Google-Smtp-Source: AFSGD/W9QTVK0hXubb4VB6fd1+Oa3DxH7a8SmFCfQxAt6Kwf283Z5tkiiUaBrUfRVwUTIE7XpgPXig==
X-Received: by 2002:a63:ed15:: with SMTP id d21mr4014285pgi.305.1544821453997;
        Fri, 14 Dec 2018 13:04:13 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m67sm7709126pfm.73.2018.12.14.13.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 13:04:12 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:04:11 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Michal Hocko <mhocko@kernel.org>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <0bbf4202-6187-28fb-37b7-da6885b89cce@suse.cz>
Message-ID: <alpine.DEB.2.21.1812141244450.186427@chino.kir.corp.google.com>
References: <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net> <20181205204034.GB11899@redhat.com> <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com> <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com> <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com> <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com> <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com>
 <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com> <20181210044916.GC24097@redhat.com> <alpine.DEB.2.21.1812111609060.255489@chino.kir.corp.google.com> <0bbf4202-6187-28fb-37b7-da6885b89cce@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Vlastimil Babka wrote:

> > Regarding the role of direct reclaim in the allocator, I think we need 
> > work on the feedback from compaction to determine whether it's worthwhile.  
> > That's difficult because of the point I continue to bring up: 
> > isolate_freepages() is not necessarily always able to access this freed 
> > memory.
> 
> That's one of the *many* reasons why having free base pages doesn't
> guarantee compaction success. We can and will improve on that. But I
> don't think it would be e.g. practical to check the pfns of free pages
> wrt compaction scanner positions and decide based on that.

Yeah, agreed.  Rather than proposing that memory is only reclaimed if its 
known that it can be accessible to isolate_freepages(), I'm wondering 
about the implementation of the freeing scanner entirely.

In other words, I think there is a lot of potential stranding that occurs 
for both scanners that could otherwise result in completely free 
pageblocks.  If there a single movable page present near the end of the 
zone in an otherwise fully free pageblock, surely we can do better than 
the current implementation that would never consider this very easy to 
compact memory.

For hugepages, we don't care what pageblock we allocate from.  There are 
requirements for MAX_ORDER-1, but I assume we shouldn't optimize for these 
cases (and if CMA has requirements for a migration/freeing scanner 
redesign, I think that can be special cased).

The same problem occurs for the migration scanner where we can iterate 
over a ton of free memory that is never considered a suitable migration 
target.  The implementation that attempts to migrate all memory toward the 
end of the zone penalizes the freeing scanner when it is reset: we just 
iterate over a ton of used pages.

Reclaim likely could be deterministically useful if we consider a redesign 
of how migration sources and targets are determined in compaction.

Has anybody tried a migration scanner that isn't linearly based, rather 
finding the highest-order free page of the same migratetype, iterating the 
pages of its pageblock, and using this to determine whether the actual 
migration will be worthwhile or not?  I could imagine pageblock_skip being 
repurposed for this as the heuristic.

Finding migration targets would be more tricky, but if we iterate the 
pages of the pageblock for low-order free pages and find them to be mostly 
used, that seems more appropriate than just pushing all memory to the end 
of the zone?

It would be interesting to know if anybody has tried using the per-zone 
free_area's to determine migration targets and set a bit if it should be 
considered a migration source or a migration target.  If all pages for a 
pageblock are not on free_areas, they are fully used.

> > otherwise we fail and defer because it wasn't able 
> > to make a hugepage available.
> 
> Note that THP fault compaction doesn't actually defer itself, which I
> think is a weakness of the current implementation and hope that patch 3
> in my series from yesterday [1] can address that. Because defering is
> the general feedback mechanism that we have for suppressing compaction
> (and thus associated reclaim) in cases it fails for any reason, not just
> the one you mention. Instead of inspecting failure conditions in detail,
> which would be costly, it's a simple statistical approach. And when
> compaction is improved to fail less, defering automatically also happens
> less.
> 

I couldn't get the link to work, unfortunately, I don't think the patch 
series made it to LKML :/  I do see it archived for linux-mm, though, so 
I'll take a look, thanks!

> [1] https://lkml.kernel.org/r/20181211142941.20500-1-vbabka@suse.cz
> 
