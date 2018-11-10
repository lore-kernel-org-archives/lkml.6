Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A191FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24C20855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bfhPAdsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A24C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeKJJnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:43:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43586 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeKJJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:43:06 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so4729686qkr.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 16:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=om71kzqtfu8XegvZ2RcYXBdnXr8unvF4YPZDKXPDvx8=;
        b=bfhPAdsano1CRNOGa2YRTAKU55F2NW/fk69HKIY9H8IlFmdkkRMvAfx/J04Duk/vOu
         4P7XOZYzOnqL76/l6vTGuctRrv+RBGW85QxFs0oNSzKVoiSFA3D2FHUnI85jGwf/tdAN
         BMmDnrfLnEXJqJ69BZFcBP95pZlC6OV72ujQVxPHci+1VuAhKhKoCHMDqmCWxKcMMrTb
         RU5RbLnVbGaZ6QveLywF0bvDQ9viCOFs4P+9Htv9bcZPdWjeuhIxdjJybyWleFpTvLg1
         quDbZCz03hzJH1JfTgKfI2goN2oQHJQtFYXMbqVZsJQmSg3sYJbL0jmfyoFDPBLgUzgr
         8FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=om71kzqtfu8XegvZ2RcYXBdnXr8unvF4YPZDKXPDvx8=;
        b=eNwqZ95qMNfdsyhw+EHITv6qzLXGRYjnaXhFodkLH007uUYUzvvWttA/0vNVJolpbZ
         4DedtG4/Nhb7wZx8xpzxBqai+mIz2FwrgGsBdiwckeu/Ab6vkw2UifEuihbwK7pq9Wue
         75au3/xAAizhvsNbKiOKdpLTl0J9oxJuLbxn4uHH34L3ADcNoztW4CwKvMFT5jkQFCh7
         GsMQHatDcpypQG0t1hq5Tl6f1EMpmfo2NA3yCStdUQwXFGugADQQbQlsOIMU6h6qmqd1
         fCyzKlUpQZ3MBs0oiznRozPKvQq4WINTZ1SRkiGkWm/naakx2s3CRWPWwzcFuSB/FEkf
         iuvQ==
X-Gm-Message-State: AGRZ1gJLznu7atIsbTrAj7x2GowHmuKKkk4NCV1SaNd4/6v2Kv0bBuPQ
        GmqMrFOhZ2L1ItlcnnniAckGEQ==
X-Google-Smtp-Source: AJdET5ewUi5Bo4yPyigpFiQVP7skQmo9GQq57IeAExsmmzL5bms4V8pSjWLJqO4AxFxQBabGCEsc1A==
X-Received: by 2002:a37:5cc6:: with SMTP id q189mr10474375qkb.235.1541808009308;
        Fri, 09 Nov 2018 16:00:09 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id e26sm4428579qtg.69.2018.11.09.16.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 16:00:08 -0800 (PST)
Date:   Fri, 9 Nov 2018 19:00:06 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        daniel.m.jordan@oracle.com
Cc:     daniel.m.jordan@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        davem@davemloft.net, pavel.tatashin@microsoft.com, mhocko@suse.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        rppt@linux.vnet.ibm.com, willy@infradead.org, vbabka@suse.cz,
        khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-ID: <20181110000006.tmcfnzynelaznn7u@xakep.localdomain>
References: <20181109211521.5ospn33pp552k2xv@xakep.localdomain>
 <18b6634b912af7b4ec01396a2b0f3b31737c9ea2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b6634b912af7b4ec01396a2b0f3b31737c9ea2.camel@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-09 15:14:35, Alexander Duyck wrote:
> On Fri, 2018-11-09 at 16:15 -0500, Pavel Tatashin wrote:
> > On 18-11-05 13:19:25, Alexander Duyck wrote:
> > > This patchset is essentially a refactor of the page initialization logic
> > > that is meant to provide for better code reuse while providing a
> > > significant improvement in deferred page initialization performance.
> > > 
> > > In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
> > > memory per node I have seen the following. In the case of regular memory
> > > initialization the deferred init time was decreased from 3.75s to 1.06s on
> > > average. For the persistent memory the initialization time dropped from
> > > 24.17s to 19.12s on average. This amounts to a 253% improvement for the
> > > deferred memory initialization performance, and a 26% improvement in the
> > > persistent memory initialization performance.
> > 
> > Hi Alex,
> > 
> > Please try to run your persistent memory init experiment with Daniel's
> > patches:
> > 
> > https://lore.kernel.org/lkml/20181105165558.11698-1-daniel.m.jordan@oracle.com/
> 
> I've taken a quick look at it. It seems like a bit of a brute force way
> to try and speed things up. I would be worried about it potentially

There is a limit to max number of threads that ktasks start. The memory
throughput is *much* higher than what one CPU can maxout in a node, so
there is no reason to leave the other CPUs sit idle during boot when
they can help to initialize.

> introducing performance issues if the number of CPUs thrown at it end
> up exceeding the maximum throughput of the memory.
> 
> The data provided with patch 11 seems to point to issues such as that.
> In the case of the E7-8895 example cited it is increasing the numbers
> of CPUs used from memory initialization from 8 to 72, a 9x increase in
> the number of CPUs but it is yeilding only a 3.88x speedup.

Yes, but in both cases we are far from maxing out the memory throughput.
The 3.88x is indeed low, and I do not know what slows it down.

Daniel,

Could you please check why multi-threading efficiency is so low here?

I bet, there is some atomic operation introduces a contention within a
node. It should be possible to resolve.

> 
> > The performance should improve by much more than 26%.
> 
> The 26% improvement, or speedup of 1.26x using the ktask approach, was
> for persistent memory, not deferred memory init. The ktask patch
> doesn't do anything for persistent memory since it is takes the hot-
> plug path and isn't handled via the deferred memory init.

Ah, I thought in your experiment persistent memory takes deferred init
path. So, what exactly in your patches make this 1.26x speedup?

> 
> I had increased deferred memory init to about 3.53x the original speed
> (3.75s to 1.06s) on the system which I was testing. I do agree the two
> patches should be able to synergistically boost each other though as
> this patch set was meant to make the init much more cache friendly so
> as a result it should scale better as you add additional cores. I know
> I had done some playing around with fake numa to split up a single node
> into 8 logical nodes and I had seen a similar speedup of about 3.85x
> with my test memory initializing in about 275ms.
> 
> > Overall, your works looks good, but it needs to be considered how easy it will be
> > to merge with ktask. I will try to complete the review today.
> > 
> > Thank you,
> > Pasha
> 
> Looking over the patches they are still in the RFC stage and the data
> is in need of updates since it is referencing 4.15-rc kernels as its
> baseline. If anything I really think the ktask patch 11 would be easier
> to rebase around my patch set then the other way around. Also, this
> series is in Andrew's mmots as of a few days ago, so I think it will be
> in the next mmotm that comes out.

I do not disagree, I think these two patch series should complement each
other. But, if your changes make it impossible for ktask, I would strongly argue
against it, as the potential improvements with ktasks are much higher.
But, so far I do not see anything, so I think they can work together. I
am still reviewing your work.

> 
> The integration with the ktask code should be pretty straight forward.
> If anything I think my code would probably make it easier since it gets
> rid of the need to do all this in two passes. The only new limitation
> it would add is that you would probably want to split up the work along
> either max order or section aligned boundaries. What it would

Which is totally OK, it should make ktasks scale even better.

> essentially do is make things so that each of the ktask threads would
> probably look more like deferred_grow_zone which after my patch set is
> actually a fairly simple function.
> 
> Thanks.

Thank you,
Pasha
