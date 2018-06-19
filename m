Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B99DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF17A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eftIlb0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF17A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756398AbeFSIOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:14:09 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44476 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755972AbeFSIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:14:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id p21-v6so8802031pgd.11;
        Tue, 19 Jun 2018 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JBv/2cDEKc6ZVrTO+cM2IvSnV0jVonOT+gNssO73Pf4=;
        b=eftIlb0OgivDD09D1VFf2xvU485q+z+lqyqrzDeQBMYyNQMILKdCQSVj+yLbS1FLpj
         /JpBzL0tbJLvkC521gDjupQRM3m712U3OHWIZfivnfV5DR5AMiK11Xos95UZsme6UauV
         kDMRRrx2DeaUms2aR8ZIa7hJIxNw422YYYxBtHSq73A4MCUpGOrpfAXyzqet8jAqzsCW
         Ov9nBweSlxAzjADl5stXAazacYwVAsZ8rgcXs5dAeyDdGvBBvhS0YwWgkEkAXxmK/HBJ
         hdGv102jxfuypW1DN8i7fvokf6zQldhzZV0kpfwq7BqUaOdJ+GOgyQ8EvvbBQjYJJfOr
         g68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JBv/2cDEKc6ZVrTO+cM2IvSnV0jVonOT+gNssO73Pf4=;
        b=HGflxcTKTXIOzG8BOsf5Jb5wucsWoCCqxm3k6hyEY8iKoowPx3iDlUkDeOhsZHJ0CD
         yXgUDGYdnZRkaep59cBkCsTyzTvA4VSi2syRxnJnXp+luOw1H82ZvGS5PwYUD9bb/Kbv
         juPNhurMM9ZSczGz8CRGrKdvj0Ng1eBwyrpsKqNyFXndsUoNiH7kFLKjoPYvzPsTRvQl
         l+QZalcPGo1k3EjMXNC6oJsjMRnW3zGtBs9Z3TMIuV1YPQEeUquZEVjQqyVXmqOlQnnq
         qRlRYoGiyMB2H8ojESLwump2ufeb0Dr4WpEY5iKg+f0S/XiaOns+1nv9IZKTI0Y42dZ0
         YGyg==
X-Gm-Message-State: APt69E3m8ztY7sZC1hPSOwrUTTXORoQV8qNDcppCnrXPdlH9IdgRuyDm
        TZApoh3f7sy6mTZvS4XudAw=
X-Google-Smtp-Source: ADUXVKLeBhoEHJ/1R0ZSDvPKAY7Vb3UsFwfKh8I9cjc/oYLUgR5Toi9sX2WzJbZkMJBBGFnPNC4aFg==
X-Received: by 2002:a62:808f:: with SMTP id j137-v6mr17051741pfd.91.1529396043845;
        Tue, 19 Jun 2018 01:14:03 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id c191-v6sm26819355pfg.48.2018.06.19.01.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 01:14:02 -0700 (PDT)
From:   Minchan Kim <minchan.kernel@gmail.com>
X-Google-Original-From: Minchan Kim <minchan@kernel.org>
Date:   Tue, 19 Jun 2018 17:13:57 +0900
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-api@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 6/7] mm, proc: add KReclaimable to /proc/meminfo
Message-ID: <20180619081357.GA95482@rodete-desktop-imager.corp.google.com>
References: <20180618091808.4419-1-vbabka@suse.cz>
 <20180618091808.4419-7-vbabka@suse.cz>
 <20180618143317.eb8f5d7b6c667784343ef902@linux-foundation.org>
 <650c3fab-3137-4fe6-272a-f4ec104855a7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650c3fab-3137-4fe6-272a-f4ec104855a7@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:30:03AM +0200, Vlastimil Babka wrote:
> On 06/18/2018 11:33 PM, Andrew Morton wrote:
> > On Mon, 18 Jun 2018 11:18:07 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> > 
> >> The vmstat NR_KERNEL_MISC_RECLAIMABLE counter is for kernel non-slab
> >> allocations that can be reclaimed via shrinker. In /proc/meminfo, we can show
> >> the sum of all reclaimable kernel allocations (including slab) as
> >> "KReclaimable". Add the same counter also to per-node meminfo under /sys
> > 
> > Why do you consider this useful enough to justify adding it to
> > /pro/meminfo?  How will people use it, what benefit will they see, etc?
> 
> Let's add this:
> 
> With this counter, users will have more complete information about
> kernel memory usage. Non-slab reclaimable pages (currently just the ION
> allocator) will not be missing from /proc/meminfo, making users wonder
> where part of their memory went. More precisely, they already appear in
> MemAvailable, but without the new counter, it's not obvious why the
> value in MemAvailable doesn't fully correspond with the sum of other
> counters participating in it.

Hmm, if we could get MemAvailable with sum of other counters participating
in it, MemAvailable wouldn't be meaninful. IMO, MemAvailable don't need to
be matched with other counters.

The benefit of ION KReclaimable in real field is there are some sluggish
problem bugreport under memory pressure and found ION page pool is too
much without shrinking. In that case, that meminfo would be useful to
know something was broken in the system.

In that point of view, a concern to me is if we put more KReclaimable
pages(e.g., binder is candidate), it ends up we couldn't identify what
caches are too much among them. That means we needs KReclaimableInfo(like
slabinfo) to show each type's KReclaimable pages in future.

Anyway, it's good for first step.

> 
> > Maybe you've undersold this whole patchset, but I'm struggling a bit to
> > see what the end-user benefits are.  What would be wrong with just
> > sticking with what we have now?
> 
> Fair enough, I will add more info in reply to the cover letter.
> 
