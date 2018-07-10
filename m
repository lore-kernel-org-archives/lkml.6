Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C15BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218942086E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjpFJbPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218942086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbeGJBho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:37:44 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45920 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754634AbeGJBhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:37:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id i26-v6so3485786pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 18:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=N9lTUNJbmEygNdM7QxQ6EuDJkR7qxn4y0BRpBlBRvVk=;
        b=cjpFJbPxNYK40QdXsf6uWyD9yO5d8YyyNKVWRPQ7/MKaucqt10QR7x7HiVgcUc5sVP
         F0o6l80g/WtDYP9Vzwdly72kYmjNx8C7mL3zWvGAk9oViewTQc9KEIDdZBRSzqq9h8K4
         yO93zmqDsu8L5zt/ZJEVgXhHD6vxT5nNphiSIwGerK2fR3ykIr5qrZsMl239KmbeLPpw
         VOPzAGPeW7P7kKZrCmWRCSAVVt5maB608dPlQGOKs350Y8wIq0fHkXStFgcH2DaytnLB
         kZ6kSnP4ikqQZHgibJ11ty/t3pVnJ/S0uHuNf4ey6GXqEECUmADmjvbJwPui3FFV+wWp
         Y83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=N9lTUNJbmEygNdM7QxQ6EuDJkR7qxn4y0BRpBlBRvVk=;
        b=Jr5DFCzxruuvk/pB+iypBv5ROYSZxRWwPo49Y1hepZHeeuLYglCP85OXgu2YH0qLWJ
         icuKDpex9rHRpfwKrs8Oz3pdg/S/Hp5bCwFG0V3LnEjQEpRMrvOwp42rrYonyYN4k/zo
         HGWmBAWQoDVDhfiZzAo1+pH0JnTPgkiTtn4I99DJ2Z4F1Cl37oJE07lIWSUPzFZogl17
         vbaLhp9ClWPcp9iEZaQQRuWoWSFr1C4SfxGTXFYWVmMXdBmoqqJ47NbrY4XOna0Z1n4b
         xccUgOHYk/5hHfenZkVVjEoWlfnACb7jaqElgl8XCPoWqYanx+27Iz9KGPu0QWRl3BzD
         2Wcw==
X-Gm-Message-State: APt69E2G/DN01TeGOGfLi0tAcI4JJp0AGzRe5WC3agDUbC3hoJVrYlfe
        l7TFgmr+AGL3MgFiSpSnGETH6i3OpqE=
X-Google-Smtp-Source: AAOMgpf4aCXOc/dhnq7J1q+sCfoHY5jYUPgfJap+jrUCjjwIj1lAWzG1GaqDqlbOaGKfpMN+MW5lKg==
X-Received: by 2002:a63:5421:: with SMTP id i33-v6mr21090563pgb.417.1531186659078;
        Mon, 09 Jul 2018 18:37:39 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a15-v6sm4713282pfe.32.2018.07.09.18.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 18:37:38 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:37:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, vmacache: hash addresses based on pmd
In-Reply-To: <20180709180841.ebfb6cf70bd8dc08b269c0d9@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1807091822460.130281@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1807091749150.114630@chino.kir.corp.google.com> <20180709180841.ebfb6cf70bd8dc08b269c0d9@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Andrew Morton wrote:

> > When perf profiling a wide variety of different workloads, it was found
> > that vmacache_find() had higher than expected cost: up to 0.08% of cpu
> > utilization in some cases.  This was found to rival other core VM
> > functions such as alloc_pages_vma() with thp enabled and default
> > mempolicy, and the conditionals in __get_vma_policy().
> > 
> > VMACACHE_HASH() determines which of the four per-task_struct slots a vma
> > is cached for a particular address.  This currently depends on the pfn,
> > so pfn 5212 occupies a different vmacache slot than its neighboring
> > pfn 5213.
> > 
> > vmacache_find() iterates through all four of current's vmacache slots
> > when looking up an address.  Hashing based on pfn, an address has
> > ~1/VMACACHE_SIZE chance of being cached in the first vmacache slot, or
> > about 25%, *if* the vma is cached.
> > 
> > This patch hashes an address by its pmd instead of pte to optimize for
> > workloads with good spatial locality.  This results in a higher
> > probability of vmas being cached in the first slot that is checked:
> > normally ~70% on the same workloads instead of 25%.
> 
> Was the improvement quantifiable?
> 

I've run page fault testing to answer this question on Haswell since the 
initial profiling was done over a wide variety of user-controlled 
workloads and there's no guarantee that such profiling would be a fair 
comparison either way.  For page faulting it's either falling below our 
testing levels of 0.02%, or is right at 0.02%.  Running without the patch 
it's 0.05-0.06% overhead.

> Surprised.  That little array will all be in CPU cache and that loop
> should execute pretty quickly?  If it's *that* sensitive then let's zap
> the no-longer-needed WARN_ON.  And we could hide all the event counting
> behind some developer-only ifdef.
> 

Those vmevents are only defined for CONFIG_DEBUG_VM_VMACACHE, so no change 
needed there.  The WARN_ON() could be moved under the same config option.  
I assume that if such a config option exists that at least somebody is 
interested in debugging mm/vmacache.c once in a while.

> Did you consider LRU-sorting the array instead?
> 

It adds 40 bytes to struct task_struct, but I'm not sure the least 
recently used is the first preferred check.  If I do 
madvise(MADV_DONTNEED) from a malloc implementation where I don't control 
what is free()'d and I'm constantly freeing back to the same hugepages, 
for example, I may always get first slot cache hits with this patch as 
opposed to the 25% chance that the current implementation has (and perhaps 
an lru would as well).

I'm sure that I could construct a workload where LRU would be better and 
could show that the added footprint were worthwhile, but I could also 
construct a workload where the current implementation based on pfn would 
outperform all of these.  It simply turns out that on the user-controlled 
workloads that I was profiling that hashing based on pmd was the win.
