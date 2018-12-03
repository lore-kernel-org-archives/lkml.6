Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7353C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A80F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A80F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLCUMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:12:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeLCUMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:12:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CCB63082125;
        Mon,  3 Dec 2018 20:12:18 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DC82194AE;
        Mon,  3 Dec 2018 20:12:15 +0000 (UTC)
Date:   Mon, 3 Dec 2018 15:12:14 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181203201214.GB3540@redhat.com>
References: <20181127205737.GI16136@redhat.com>
 <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 03 Dec 2018 20:12:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:28:07AM -0800, Linus Torvalds wrote:
> On Mon, Dec 3, 2018 at 10:59 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > You are misinterpreting my words. I haven't dismissed anything. I do
> > recognize both usecases under discussion.
> >
> > I have merely said that a better THP locality needs more work and during
> > the review discussion I have even volunteered to work on that.
> 
> We have two known patches that seem to have no real downsides.
> 
> One is the patch posted by Andrea earlier in this thread, which seems
> to target just this known regression.

For the short term the important thing is to fix the VM regression one
way or another, I don't personally mind which way.

> The other seems to be to revert commit ac5b2c1891  and instead apply
> 
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com/
> 
> which also seems to be sensible.

In my earlier review of David's patch, it looked runtime equivalent to
the __GFP_COMPACT_ONLY solution. It has the only advantage of adding a
new gfpflag until we're sure we need it but it's the worst solution
available for the long term in my view. It'd be ok to apply it as
stop-gap measure though.

The "order == pageblock_order" hardcoding inside the allocator to
workaround the __GFP_THISNODE flag passed from outside the allocator
in the THP MADV_HUGEPAGE case, didn't look very attractive because
it's not just THP allocating order >0 pages.

It'd be nicer if whatever compaction latency optimization that applies
to THP could also apply to all other allocation orders too and the
hardcoding of the THP order prevents that.

On the same lines if __GFP_THISNODE is so badly needed by
MADV_HUGEPAGE, all other larger order allocations should also be able
to take advantage of __GFP_THISNODE without ending in the same VM
corner cases that required the "order == pageblock_order" hardcoding
inside the allocator.

If you prefer David's patch I would suggest pageblock_order to be
replaced with HPAGE_PMD_ORDER so it's more likely to match the THP
order in all archs.

Thanks,
Andrea
