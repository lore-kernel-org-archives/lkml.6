Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67339C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF0F2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ry9/2ZOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF0F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeLFASR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:18:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45072 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFASR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:18:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so10845868plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=S0pZYoW+A1NJpap2WE+SRihOA3n3XafUr5L27VPmVX8=;
        b=ry9/2ZODpdViOPpqM9HnnSfDFjkxIsJqlTJp/wV508tDnyLXckxvOsOtnmoeU2M5+D
         ySVH81L5y84RhKN0YRJAgsDNupN+3guHL9jBBiB2DN0qFvWRs1XBP1Y2HX2nvvMuu15a
         1wOTZFCqmY73E/LgGWMNhkveTIMNE6MX9CPolIjiBhSmg17CShidJkhaCqMSZCsH64Gh
         rZ3nO3yBwOPdyyl8JrOitffJXcZKgx4uJJzZBFGOkqk/UzBnB3l6fW7/I+mJ6vnvKyNE
         2QGgsRnd+VgncFW82Zs9D3n2X1pVREa+o3PpjCK9By0lRhcP5EcoW1cWllMh6dOzwFGg
         XDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=S0pZYoW+A1NJpap2WE+SRihOA3n3XafUr5L27VPmVX8=;
        b=Es3aPtUKMmrRm7hiXDvSlLE0YIbdy8nKV/ScorOTqTJ27XIDuNUygTm88OkYmajdJW
         +B+bAyy3uOY9cTZ772M6kYLFekjNnB+jHSq7y7LaI6DMPpOxMLaDH8Zd6W95dTvhXjwL
         jg0uceO+6NVRQU94wfJcoI8eMtUtkuAuy4Ly+yBjzG3n3CbLNFMHWUXfqZ8apOQFbt0T
         NAImkml/1GnAs7IIqns2p06JBIpDFW8nGnSNxdg+JcfrwEtq4ITU7V8WhGE9OHGYAe8L
         1s5kw51O74GCn8Trde8LOf+pKie7i/5Yh6GjRFWFOc1f5tQzuRfIvxT+dNYyjXorX0lm
         Bn9w==
X-Gm-Message-State: AA+aEWZ16oN/DK+eLRIqc3OikY4nX62v9ePdpwKMOxhIoooyXjsJirjw
        P23uLZne7Q9474ZxkE13LahBEA==
X-Google-Smtp-Source: AFSGD/XU4Vj6FNnw5/3SSRHK6vvTO2DhbkzPdgkUdLGNOHuvpJKfKVs3NWtyp67QQ/AyFALbZfKMTg==
X-Received: by 2002:a17:902:6848:: with SMTP id f8mr25541642pln.300.1544055496060;
        Wed, 05 Dec 2018 16:18:16 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e86sm29048890pfb.6.2018.12.05.16.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 16:18:15 -0800 (PST)
Date:   Wed, 5 Dec 2018 16:18:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181205233632.GE11899@redhat.com>
Message-ID: <alpine.DEB.2.21.1812051614410.50028@chino.kir.corp.google.com>
References: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com> <20181203185954.GM31738@dhcp22.suse.cz> <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com> <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com> <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com> <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz> <20181204104558.GV23260@techsingularity.net> <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com> <20181205233632.GE11899@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018, Andrea Arcangeli wrote:

> __GFP_COMPACT_ONLY gave an hope it could give some middle ground but
> it shows awful compaction results, it basically destroys compaction
> effectiveness and we know why (COMPACT_SKIPPED must call reclaim or
> compaction can't succeed because there's not enough free memory in the
> node). If somebody used MADV_HUGEPAGE compaction should still work and
> not fail like that. Compaction would fail to be effective even in the
> local node where __GFP_THISNODE didn't fail. Worst of all it'd fail
> even on non-NUMA systems (that would be easy to fix though by making
> the HPAGE_PMD_ORDER check conditional to NUMA being enabled at
> runtime).
> 

Note that in addition to COMPACT_SKIPPED that you mention, compaction can 
fail with COMPACT_COMPLETE, meaning the full scan has finished without 
freeing a hugepage, or COMPACT_DEFERRED, meaning that doing another scan 
is unlikely to produce a different result.  COMPACT_SKIPPED makes sense to 
do reclaim if it can become accessible to isolate_freepages() and 
hopefully another allocator does not allocate from these newly freed pages 
before compaction can scan the zone again.  For COMPACT_COMPLETE and 
COMPACT_DEFERRED, reclaim is unlikely to ever help.
