Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE51BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920782082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO/InZd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920782082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeLCU0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:26:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33560 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLCU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:26:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so6250486pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GFASv4k38eUe55JTn7Xs8Ag9VKnmgbHychIvl/jNOAg=;
        b=EO/InZd/dNwl5W6+zVMfPVfRFw11pqr4EtqvABf1URkuchkrWU6m5PoV8k/z+CnUlt
         W/P/e4JJTF3kgD7bAoVKhZSoQ4RoPPjR7TgFPaOr3QUfiCn/BnlUy7HKHPRwWfYuZVqb
         xHJueHFm709e6qSWG/K7VtqcsqcXNAPr7Hfy6lD8LFS7HKHsjleFmgQXhU7H+EbH+Ztr
         6aJLlUKrtkUTZYbjhe6xSNvpPYErrySTTRXVYl6FYNY3lQxqL5QvRE6zTAZJyVQK+euH
         C1hvH8/tTPjFMcY90RaHLqZwPFQu68v12+wV4rBOFzkMM9snMajRpEM1lgSm62o5wvB+
         TpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GFASv4k38eUe55JTn7Xs8Ag9VKnmgbHychIvl/jNOAg=;
        b=EjzfETZeg4wrb/0Bqlriv8epgzSjSXW4S/v9ZhRxA3Eo/e+guX3m+MqI92rAyDkA/4
         Norwz79H+c7hrxbUv1CNRde7NiXSidKsEQLqUI1t4rTzN9W34ikolPpQ6s6b0E71LAZ4
         MVUyAClFhXPuvV8HU4okN7etNGohebUIDrP+JCQ+LlVoR+jsmdoedWQG31sFwbONZXaV
         W4FPGI1vpqDzTNJAPRrxrpLKmW7BVCt6OwAopxhxdxsZOA4SFRLRjoDWx9/3gMdmeLIQ
         ulK0CquU08DoIRuHWHV9MQz0JRCY19yZV2JwZEysnbMequxgpyamwuLqqIN6mvSjyI6H
         8kIg==
X-Gm-Message-State: AA+aEWaSNZc15tx+91xDpjWOIRXRhMTqOIXopL7jUVBWRU/WgCqeQ5xH
        G/IF9oOHpMW3UfaAKSVoA5wQjw==
X-Google-Smtp-Source: AFSGD/WgRLPR1I/b33wMnprBvL9uz80Usm55zpAFD5/fk361ehaHfGEX2rAt+URHNT+mx/kA075G8A==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr4564172pgm.126.1543868790813;
        Mon, 03 Dec 2018 12:26:30 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v89sm22872289pfk.12.2018.12.03.12.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:26:29 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:26:28 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181203192344.GA2986@redhat.com>
Message-ID: <alpine.DEB.2.21.1812031210490.192288@chino.kir.corp.google.com>
References: <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com> <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com> <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com> <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz> <20181203192344.GA2986@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018, Andrea Arcangeli wrote:

> It's trivial to reproduce the badness by running a memhog process that
> allocates more than the RAM of 1 NUMA node, under defrag=always
> setting (or by changing memhog to use MADV_HUGEPAGE) and it'll create
> swap storms despite 75% of the RAM is completely free in a 4 node NUMA
> (or 50% of RAM free in a 2 node NUMA) etc..
> 
> How can it be ok to push the system into gigabytes of swap by default
> without any special capability despite 50% - 75% or more of the RAM is
> free? That's the downside of the __GFP_THISNODE optimizaton.
> 

The swap storm is the issue that is being addressed.  If your remote 
memory is as low as local memory, the patch to clear __GFP_THISNODE has 
done nothing to fix it: you still get swap storms and memory compaction 
can still fail if the per-zone freeing scanner cannot utilize the 
reclaimed memory.  Recall that this patch to clear __GFP_THISNODE was 
measured by me to have a 40% increase in allocation latency for fragmented 
remote memory on Haswell.  It makes the problem much, much worse.

> __GFP_THISNODE helps increasing NUMA locality if your app can fit in a
> single node which is the common David's workload. But if his workload
> would more often than not fit in a single node, he would also run into
> an unacceptable slowdown because of the __GFP_THISNODE.
> 

Which is why I have suggested that we do not do direct reclaim, as the 
page allocator implementation expects all thp page fault allocations to 
have __GFP_NORETRY set, because no amount of reclaim can be shown to be 
useful to the memory compaction freeing scanner if it is iterated over by 
the migration scanner.

> I think there's lots of room for improvement for the future, but in my
> view that __GFP_THISNODE as it was implemented was an incomplete hack,
> that opened the door for bad VM corner cases that should not happen.
> 

__GFP_THISNODE is intended specifically because of the remote access 
latency increase that is encountered if you fault remote hugepages over 
local pages of the native page size.
