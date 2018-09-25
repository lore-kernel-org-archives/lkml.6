Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ABFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077462089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpOBYIz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077462089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIZCBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:01:30 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43990 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeIZCB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:01:29 -0400
Received: by mail-pf1-f169.google.com with SMTP id j26-v6so11934853pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=msPZT6yhuttYFJUAHbqdJPwbKh5JV89OKwVLkUu20YA=;
        b=HpOBYIz0LNJFjXQy0PSg6znffqYUCaqf2K/CzG37eVqY5+gZjFRLcyI9G+KMD5LaTJ
         dxW7OS1IFR97ek8qBhanYX/abX2HV5ixhIh7DtizkV0rmnpm0wxAMKXkmLtmlhEGt9Bn
         2iXWuujhay8vHWGkY0wUizj0jsLnhAE4EnFQmxg8XQMo7N7pHw+SXJF0ATIaYePBu/NE
         xtYSBoPdERXNOlTEY8QDfu1OnyIrLyNnjTnnle8z7PF5QBndbeyGwgWJJZctWqz19DU1
         L3h3bdL5tJcfa1Kwbu8r6QX7j4grh4zEmvGion5EA1YEqfi31mjf6Qbm9A+xDs/fs6cG
         37Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=msPZT6yhuttYFJUAHbqdJPwbKh5JV89OKwVLkUu20YA=;
        b=rdXYMWSZt/IZZ49DdWKBAD2b0HEm/hERW9gIi9gOyHLQZ1El71HA1qVVsdAvq0AsYS
         G9ZsbF4TCLmnVIHwjsTSQpU3HhHGhh6nyXbDipbokAzuSaiRLTrK3pGA50tCUGq2WCNQ
         TRcyYb84RrtQgQ/bFsGTeFkDG4DBpWh6/xDN4cDc9X8x1mfXuy9j3hd3wGgLwHpDXJ9j
         FEsWi4o90K9Mo5bXnvfXk4xFw2BiNcg8rkT2qbeTQ2I5MJZfgaBjuGxeBtc2RUBDmk/8
         0TVhnVNyovQgZVnt3FTr3fzNYmQxOlI0ipJdzy15aWnBpb5v+8XWLdJp8+sEXVy9w2O/
         e7mg==
X-Gm-Message-State: ABuFfohPZk7rzE/FkRmHwQXjXR+aomNJ+/Rn7TXlgskoP57sWlEe/FQD
        38gdTX+cI4g17ic9EsU44v9l3g==
X-Google-Smtp-Source: ACcGV61egPjly1h0+T8H0gh4hubItQfQX4BZ0z1127JNbGnNCwCG1YKCGhyKvaOnRysB6/6g/gFOeA==
X-Received: by 2002:a17:902:7689:: with SMTP id m9-v6mr2485637pll.295.1537905139678;
        Tue, 25 Sep 2018 12:52:19 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l3-v6sm3879470pff.8.2018.09.25.12.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:52:18 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:52:09 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [patch v2] mm, thp: always specify ineligible vmas as nh in
 smaps
In-Reply-To: <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
Message-ID: <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com> <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz> <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com> <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
 <20180924195603.GJ18685@dhcp22.suse.cz> <20180924200258.GK18685@dhcp22.suse.cz> <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018, Vlastimil Babka wrote:

> On 9/24/18 10:02 PM, Michal Hocko wrote:
> > On Mon 24-09-18 21:56:03, Michal Hocko wrote:
> >> On Mon 24-09-18 12:30:07, David Rientjes wrote:
> >>> Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
> >>> introduced a regression in that userspace cannot always determine the set
> >>> of vmas where thp is ineligible.
> >>>
> >>> Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
> >>> to determine if a vma is eligible to be backed by hugepages.
> >>
> >> I was under impression that nh resp hg flags only tell about the madvise
> >> status. How do you exactly use these flags in an application?
> >>

This is used to identify heap mappings that should be able to fault thp 
but do not, and they normally point to a low-on-memory or fragmentation 
issue.  After commit 1860033237d4, our users of PR_SET_THP_DISABLE no 
longer show "nh" for their heap mappings so they get reported as having a 
low thp ratio when in reality it is disabled.  It is also used in 
automated testing to ensure that vmas get disabled for thp appropriately 
and we used "nh" since that is how PR_SET_THP_DISABLE previously enforced 
this, and those tests now break.

> >> Your eligible rules as defined here:
> >>
> >>> + [*] A process mapping is eligible to be backed by transparent hugepages (thp)
> >>> +     depending on system-wide settings and the mapping itself.  See
> >>> +     Documentation/admin-guide/mm/transhuge.rst for default behavior.  If a
> >>> +     mapping has a flag of "nh", it is not eligible to be backed by hugepages
> >>> +     in any condition, either because of prctl(PR_SET_THP_DISABLE) or
> >>> +     madvise(MADV_NOHUGEPAGE).  PR_SET_THP_DISABLE takes precedence over any
> >>> +     MADV_HUGEPAGE.
> >>
> >> doesn't seem to match the reality. I do not see all the file backed
> >> mappings to be nh marked. So is this really about eligibility rather
> >> than the madvise status? Maybe it is just the above documentation that
> >> needs to be updated.
> 
> Yeah the change from madvise to eligibility in the doc seems to go too far.
> 

I'll reword this to explicitly state that "hg" and "nh" mappings either 
allow or disallow thp backing.
