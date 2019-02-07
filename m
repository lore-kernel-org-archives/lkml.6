Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD6DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080632173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d2P+Grqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBGUM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:12:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35920 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBGUM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:12:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id d22so429458pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i3o0Wtmju3HWlOWRjY87xJXCKZCTQhmfuSMisLTGU9Q=;
        b=d2P+GrqslJzvgdlnz6Eav1B+D7I/m8xscyn6kTTJLquPa0IY1GfVTrofH3r1PpWpZd
         vCo+0N+4bTCIYLt25+EFFnmPQTE/UQ69kiIz2AcT2ZEoCh6R3rU5K2mIqdfFC8wlHtGj
         UnwLzL/lJJO/K6JbILjo7a2dvOxUd4s+Ut96LkvCa99faWZnJRCkv9NOa6nDSKkkomJb
         w7ci6Mtgai4+AFaKOT3AL9z5miVuaZtUXLoEI/2QAmxXZ3aBWLiIjkl1Zkemz7sN/bS4
         oupTqM5/m8AWEZgSt8D+PaTtPGYXzaTmFnbgW+nBXEovDTtl3dBqowDMSGhQplyhiX7D
         MzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i3o0Wtmju3HWlOWRjY87xJXCKZCTQhmfuSMisLTGU9Q=;
        b=ADJxByXChMbXoYcOY1thEVuphiMGu8qKgwYC8ylhlQCJG6B9A2O85Hh5BL2Iyh8LIG
         lRHO/NuL0tbAXeiHqFjsrhLp1dvtfAuKbiVj4cJ/Qu5U6a77vs+6ERDGqgsFthCV4Se2
         S74m5mNapMOmKWurD0KYzdXpxkQPspdJ/k+RTV6tHKOlQu2aEO5VP29nfREe+PIGhFIE
         jvevMXitcbpmp5StFmXbW0OlPNCPJUblCwEdyxfYZIeP627QAQVL/qV1XOrnmmjXbAeR
         SPeifoCXsxuFn55Fkpzf4uaaSQwB560Ct3lLkr2ZEVb5Up9UPyfuyuj5nExw2r4TgAuN
         disQ==
X-Gm-Message-State: AHQUAuZW8KYvxnN3HIeynkOn1zIImpsiusVkUokBGWf5VQ6jQkcpWXii
        nLtyCFhf/mSKlUKgo1wof9qEug==
X-Google-Smtp-Source: AHgI3IYm3LSwAFPA/+TRnAO4YDxgSO58WBSy8EHqyXqyWTpaU/2l37yGeO/u9pjsH4R1atqLl5oYLQ==
X-Received: by 2002:a63:4744:: with SMTP id w4mr16295126pgk.110.1549570374762;
        Thu, 07 Feb 2019 12:12:54 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id i74sm6113693pfi.33.2019.02.07.12.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 12:12:53 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grq2W-0007mg-QT; Thu, 07 Feb 2019 13:12:52 -0700
Date:   Thu, 7 Feb 2019 13:12:52 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, dledford@redhat.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] mm: make pinned_vm atomic and simplify users
Message-ID: <20190207201252.GA29842@ziepe.ca>
References: <20190206175920.31082-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206175920.31082-1-dave@stgolabs.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:59:14AM -0800, Davidlohr Bueso wrote:
> Changes from v2 (https://patchwork.kernel.org/cover/10774255/):
>  - Added more reviews for patch 1 and also fixed mm/debug.c to
>    use llx insted of lx so gcc doesn't complain.
> 
>  - Re did patch 3 (qib rdma) such that we still have to take
>    mmap_sem as it now uses gup_longterm(). gup_fast() conversion
>    remains for patch 2 which is not infiniband.
> 
>  - Rebased for rdma tree.
>  
> Changes from v1 (https://patchwork.kernel.org/cover/10764923/):
>  - Converted pinned_vm to atomic64 instead of atomic_long such that
>    infiniband need not worry about overflows.
> 
>  - Rebased patch 1 and added Ira's reviews as well as Parvi's review
>    for patch 5 (thanks!).
>    
> --------
> 
> Hi,
> 
> The following patches aim to provide cleanups to users that pin pages
> (mostly infiniband) by converting the counter to atomic -- note that
> Daniel Jordan also has patches[1] for the locked_vm counterpart and vfio.
> 
> Apart from removing a source of mmap_sem writer, we benefit in that
> we can get rid of a lot of code that defers work when the lock cannot
> be acquired, as well as drivers avoiding mmap_sem altogether by also
> converting gup to gup_fast() and letting the mm handle it. Users
> that do the gup_longterm() remain of course under at least reader mmap_sem.
> 
> Everything has been compile-tested _only_ so I hope I didn't do anything
> too stupid. Please consider for v5.1.
> 
> On a similar topic and potential follow up, it would be nice to resurrect
> Peter's VM_PINNED idea in that the broken semantics that occurred after
> bc3e53f682 ("mm: distinguish between mlocked and pinned pages") are still
> present. Also encapsulating internal mm logic via mm[un]pin() instead of
> drivers having to know about internals and playing nice with compaction are
> all wins.
> 
> Applies against rdma's for-next branch.
> 
> Thanks!
> 
> [1] https://lkml.org/lkml/2018/11/5/854
> 
> Davidlohr Bueso (6):
>   mm: make mm->pinned_vm an atomic64 counter
>   drivers/mic/scif: do not use mmap_sem
>   drivers/IB,qib: optimize mmap_sem usage
>   drivers/IB,hfi1: do not se mmap_sem
>   drivers/IB,usnic: reduce scope of mmap_sem
>   drivers/IB,core: reduce scope of mmap_sem

The surprise 7th patch was mangled, but I recreated it by hand

Otherwise applied to rdma for-next

Thanks,
Jason
