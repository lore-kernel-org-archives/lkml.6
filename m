Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1525519-1519995688-2-2885339196326040829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519995687; b=rvbwnXz6sYxL9E4hgC6AF1Eg3i3jYY0hb1OWFqsc8hgR4Om
    rKFYb8JsR+oExHbdElYBQhf7Cv086u+Mg/DA+QU8vvARKQidO7srCaru+4TpdUNn
    K9EhRwml/XxIfqkI1Yn4dE0kgE8MfR0BPUkIYhDEk3bM7KVa0ul8ow7rmcLDYUqY
    qvOSwq+RxIeJ5lKRcbvflzt5OJHfeKy5qg+xUHvBqQl7yC39QbLjCdKS9Dq8pPPj
    k7be8KO64UChRBmXtqWubYc2fp2He1KPR/ArrQVcjqhWcK70LGFLvQVnjAmQ8xTM
    XAsDwwE3L3He7JM2a0gA0/p2G9NIgTXMPC7bJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519995687; bh=Yzu+K66kupk8PnCvbdm/1b6r4z
    f2EbSLlkDB10TTyrU=; b=QQSSw5oAqEqCbMtmfD6aVGQL2p2pJSwMxpwRWRTdsm
    J45x7XEMnNWsRBMwiXII+sLd74y/57xeQ68aUC4crBomW6H69U62tIaNECPjv0vK
    N/UGpXK3X98/5q4Ly74qnBRyYosTgo98Y6D4sWU8A4305WcblegSsaf0Oj/pnA9Z
    Bnyv/3UiEe3EWhy7lxe7ebXIVGCGwp2QSGtRYXIrnecLYI57MKZPWdjo3IcrTdSd
    xFl+aI6CljL9cA+l131IBKkeGFky17aioeoimpRG7t2i0/htkSixC/PjqKzDqcbv
    J2yPyGghnyvo4vJxrRAkdhXM7xPHX/zX69ybr+xkhq0w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422981AbeCBNBY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 08:01:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:50396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164700AbeCBNBW (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 08:01:22 -0500
Date: Fri, 2 Mar 2018 14:01:20 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
Message-ID: <20180302130052.GN15057@dhcp22.suse.cz>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <20180301131033.GH15057@dhcp22.suse.cz>
 <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
 <20180301152729.GM15057@dhcp22.suse.cz>
 <CACjP9X8hFDhkKUHRu2K5WgEp9YFHh2=vMSyM6KkZ5UZtxs7k-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACjP9X8hFDhkKUHRu2K5WgEp9YFHh2=vMSyM6KkZ5UZtxs7k-w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 01-03-18 17:20:04, Daniel Vacek wrote:
> On Thu, Mar 1, 2018 at 4:27 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Thu 01-03-18 16:09:35, Daniel Vacek wrote:
> > [...]
> >> $ grep 7b7ff000 /proc/iomem
> >> 7b7ff000-7b7fffff : System RAM
> > [...]
> >> After commit b92df1de5d28 machine eventually crashes with:
> >>
> >> BUG at mm/page_alloc.c:1913
> >>
> >> >         VM_BUG_ON(page_zone(start_page) != page_zone(end_page));
> >
> > This is an important information that should be in the changelog.
> 
> And that's exactly what my seven very first words tried to express in
> human readable form instead of mechanically pasting the source code. I
> guess that's a matter of preference. Though I see grepping later can
> be an issue here.

Do not get me wrong I do not want to nag just for fun of it. The
changelog should be really clear about the problem. What might be clear
to you based on the debugging might not be so clear to others. And the
struct page initialization code is far from trivial especially when we
have different alignment requirements by the memory model and the page
allocator.

Therefore being as clear as possible is really valuable. So I would
really love to see the changelog to contain.
- What is going on - VM_BUG_ON in move_freepages along with the crash
  report
- memory ranges exported by BIOS/FW
- explain why is the pageblock alignment the proper one. How does the
  range look from the memory section POV (with SPARSEMEM).
- What about those unaligned pages which are not backed by any memory?
  Are they reserved so that they will never get used?

And just to be clear. I am not saying your patch is wrong. It just
raises more questions than answers and I suspect it just papers over
some more fundamental problem. I might be clearly wrong and I cannot
deserve this more time for the next week because I will be offline
but I would _really_ appreciate if this all got explained.

Thanks!
-- 
Michal Hocko
SUSE Labs
