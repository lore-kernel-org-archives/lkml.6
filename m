Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E32AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C85F218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C3ya1lIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfBKWWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:22:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46373 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfBKWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:22:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so212849pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xdkSFtkXI2U9rILZa0OLPibj9Ly6nXCAyBPxVjPqxVk=;
        b=C3ya1lIkET7B0U5gcbeCUe1y0Gh1eANZFR2GVVA06FR4dychps4f5xAXwwn+RUT3KS
         rCUYYspMMPl5cOI3Rj0TobbZYURtvSEHzR9DYTIHVqrDbrimv7ulWx9vjEaVi+k2WrAr
         UK14ouUMB4UNsY/c7qiTfBE/Wz42BgP9X6oZLVX/9pisMzhgp3lhsLXGWX8ikwzdtJn0
         QWb4KFB1F4fMRDxqD8DjgaB/qW85iPXcp8oOXGNsd4NvBa6eLN3luBJQMmr8KVy0tO/+
         3hxHhSkliZu4xmI2bPusnBUX8HLKGjG63DBkCshUQIYGgALQHI1Ha7816zP8kP0qfizK
         8Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdkSFtkXI2U9rILZa0OLPibj9Ly6nXCAyBPxVjPqxVk=;
        b=Y66uIrG71LRyeIV/Vxxt+D25ovM+syuQJls4o0ZgEuoRwW0+zPfFTR+zdY27nTX4eS
         Se4yJvyG+nx40YdRtoIFCe5vHHEdE0CC3sdTSKFsru+Bb40aGGSHad9X49Uhl0+EFfoN
         3UDBEniER7B3Gx0oyrLaqSAFmbI+wfBwnXQ84O73+CdUn/E1rRkQ+bOC6ylCpwGHSTAi
         +vvSJs6s2DKhob0b35fGwksiniJJns9RbvC/vr9VFQAyq56E7TPGZPOUNSY0g1VoUqnp
         rRS535t8+86VNghxWH4FKIgQ7q3ej1NHTBHQBU2MjN/STKzOS4KxFnlybhtEpwB6iP5o
         2bwA==
X-Gm-Message-State: AHQUAuZbUZMmOs+dF4Vbt9Q04/WTMqw2MJr1DN+BAIwrR7rpTm6P0+ZA
        OwLZZ+jcOpueUkCro0bheVYBtw==
X-Google-Smtp-Source: AHgI3IYw7BALaGSULNv+3bUMQP+ikh8t2IwpZG1CncFiHzfzaPM812aozbs4PkbsejgksaVI4K2aBQ==
X-Received: by 2002:a17:902:a588:: with SMTP id az8mr536627plb.77.1549923730086;
        Mon, 11 Feb 2019 14:22:10 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id h15sm13896692pgl.43.2019.02.11.14.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:22:09 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtJxo-0003WM-EN; Mon, 11 Feb 2019 15:22:08 -0700
Date:   Mon, 11 Feb 2019 15:22:08 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Borkmann <daniel@iogearbox.net>,
        netdev@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Message-ID: <20190211222208.GJ24692@ziepe.ca>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211203417.a2c2kbmjai43flyz@linux-r8p5>
 <20190211204710.GE24692@ziepe.ca>
 <20190211214257.GA7891@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211214257.GA7891@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:42:57PM -0800, Ira Weiny wrote:
> On Mon, Feb 11, 2019 at 01:47:10PM -0700, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 12:34:17PM -0800, Davidlohr Bueso wrote:
> > > On Mon, 11 Feb 2019, ira.weiny@intel.com wrote:
> > > > Ira Weiny (3):
> > > >  mm/gup: Change "write" parameter to flags
> > > >  mm/gup: Introduce get_user_pages_fast_longterm()
> > > >  IB/HFI1: Use new get_user_pages_fast_longterm()
> > > 
> > > Out of curiosity, are you planning on having all rdma drivers
> > > use get_user_pages_fast_longterm()? Ie:
> > > 
> > > hw/mthca/mthca_memfree.c:       ret = get_user_pages_fast(uaddr & PAGE_MASK, 1, FOLL_WRITE, pages);
> > 
> > This one is certainly a mistake - this should be done with a umem.
> 
> It looks like this is mapping a page allocated by user space for a
> doorbell?!?!

Many drivers do this, the 'doorbell' is a PCI -> CPU thing of some sort

> This does not seem to be allocating memory regions.  Jason, do you
> want a patch to just convert these calls and consider it legacy
> code?

It needs to use umem like all the other drivers on this path.
Otherwise it doesn't get the page pinning logic right

There is also something else rotten with these longterm callsites,
they seem to have very different ideas how to handle RLIMIT_MEMLOCK.

ie vfio doesn't even touch pinned_vm.. and rdma is applying
RLIMIT_MEMLOCK to mm->pinned_vm, while vfio is using locked_vm.. No
idea which is right, but they should be the same, and this pattern
should probably be in core code someplace.

Jason
