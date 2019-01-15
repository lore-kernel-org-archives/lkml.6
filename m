Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D10C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BD420866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L9ePam4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390385AbfAOVZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:25:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43550 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732860AbfAOVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:25:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so1873812plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Apz0Fm4k3jNkvwhfslGVbEdm48qHu74yHM2ejhg0UU=;
        b=L9ePam4mEmvvQdk3e8UDCNPG1H5jfY5B7qHd8H+CeXpyuA8Din/vpLRt4+KggbG+sJ
         RQCN1HvVJEPE5STMCtuX1bbMdgvV5fB36UEB5fm6FTJEBo6sSHOrV78cGLnU5OpOo9cu
         /6nRD+CqxzNEx4tCjUCFjCObkYPAIrJhSJeLh/a2AWOUE5rI9WVqHwWjcy+BqH2ZsVWD
         KwJfex6pRmHVj/hLQ9L7k1oq7UaDkFhrerAjPP39fr9i+mYV/lrMaihsYM/1NxeZAT68
         A3fWJWbpU7rXjzOq332azBFpK6/gL16m6exgdbhxJ/B7vqIziPYXdVrkz6akcQAqwUjq
         F5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Apz0Fm4k3jNkvwhfslGVbEdm48qHu74yHM2ejhg0UU=;
        b=ZB+X0HpSCq/bQQkgQ7TLeMQz4CjUQg+DA+uctKPVZ96OWZsNuaPo7khen5hBGo+pA4
         kq95RfC0yP3MnxFLwwu4MActYjitDvuMQx9rewbPFtz8EAkQ9AYEX91AOs03BYXLzWfk
         zrL2137E6j9IgF3FeCs6wrVMf6kGqugdUvCdSZCf/OZxKdFLYv16Hq7g4MEyXbOmBAnm
         dHRAAuyk5dIpVA2+M5ckPhMRC35sLH89XleZoFG8HrZXBb1q9ucueuCxmeVh8Q6URgzm
         caue6x0WHHoMqWDKgpTE+Auop+EqSrPEPFhC9Ef/6YjW1t7v2a8KEs5Vn3uqaBBd7SQ8
         /QDA==
X-Gm-Message-State: AJcUukdNR3UbwQGtmZsf7hi51Ssu6o7WElUW7Z2KQ3U+DQMeCyQACD2P
        QSBRh7gTQRD6doJ9e0vP14xuEw==
X-Google-Smtp-Source: ALg8bN7TU76438vgxz0irhnnKqoUjtyPpSuqVoQxQOeuWsoTz1seUV0AKQG66Lsjpt55SiCfNpTgCw==
X-Received: by 2002:a17:902:4225:: with SMTP id g34mr6349957pld.152.1547587502782;
        Tue, 15 Jan 2019 13:25:02 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r76sm6893358pfb.69.2019.01.15.13.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:25:01 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gjWCj-00015B-4g; Tue, 15 Jan 2019 14:25:01 -0700
Date:   Tue, 15 Jan 2019 14:25:01 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yong.zhi@intel.com" <yong.zhi@intel.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "syeh@vmware.com" <syeh@vmware.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "bingbu.cao@intel.com" <bingbu.cao@intel.com>,
        "imre.deak@intel.com" <imre.deak@intel.com>,
        "tian.shu.qiu@intel.com" <tian.shu.qiu@intel.com>,
        "jian.xu.zheng@intel.com" <jian.xu.zheng@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] lib/scatterlist: Provide a DMA page iterator
Message-ID: <20190115212501.GE22045@ziepe.ca>
References: <20190104223531.GA1705@ziepe.ca>
 <20190110234218.GM6890@ziepe.ca>
 <20190114094856.GB29604@lst.de>
 <1fb20ab4b171b281e9994b6c55734c120958530b.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb20ab4b171b281e9994b6c55734c120958530b.camel@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 02:17:26PM +0000, Thomas Hellstrom wrote:
> Hi, Christoph,
> 
> On Mon, 2019-01-14 at 10:48 +0100, Christoph Hellwig wrote:
> > On Thu, Jan 10, 2019 at 04:42:18PM -0700, Jason Gunthorpe wrote:
> > > > Changes since the RFC:
> > > > - Rework vmwgfx too [CH]
> > > > - Use a distinct type for the DMA page iterator [CH]
> > > > - Do not have a #ifdef [CH]
> > > 
> > > ChristophH: Will you ack?
> > 
> > This looks generally fine.
> > 
> > > Are you still OK with the vmwgfx reworking, or should we go back to
> > > the original version that didn't have the type safety so this
> > > driver
> > > can be left broken?
> > 
> > I think the map method in vmgfx that just does virt_to_phys is
> > pretty broken.  Thomas, can you check if you see any performance
> > difference with just doing the proper dma mapping, as that gets the
> > driver out of interface abuse land?
> 
> The performance difference is not really the main problem here. The
> problem is that even though we utilize the streaming DMA interface, we
> use it only since we have to for DMA-Remapping and assume that the
> memory is coherent. To be able to be as compliant as possible and ditch
> the virt-to-phys mode, we *need* a DMA interface flag that tells us
> when the dma_sync_for_xxx are no-ops. If they aren't we'll refuse to
> load for now. I'm not sure, but I think also nouveau and radeon suffer
> from the same issue.

RDMA needs something similar as well, in this case drivers take a
struct page * from get_user_pages() and need to have the DMA map fail
if the platform can't DMA map in a way that does not require any
additional DMA API calls to ensure coherence. (think Userspace RDMA
MR's)

Today we just do the normal DMA map and when it randomly doesn't work
and corrupts data tell those people their platforms don't support RDMA
- it would be nice to have a safer API base solution..

Jason
