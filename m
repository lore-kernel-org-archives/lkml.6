Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC0BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3EE5208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PhfuvGeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EE5208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441120AbeKXEu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:50:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46669 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395334AbeKXEu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:50:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so3638077pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mLGXK/dNfwHeDavvB2GkmSK7lW9Am0Mpj9z7LI5hfcs=;
        b=PhfuvGeD4ynaoG65V78SUvVrPLZBjzuP75HjRch8zj7cXNnxHZSQ3Q0Mg8njg+h3Hm
         ANzyvIKOosxGcus8upBqCnQANEpJO44u78ywb2CcF3MaBndvbuAgzrqkm5K/5HSbmKZw
         mPzdNV33jPtRHYuhFLREfiqOBKXqmkG9nRG8pIQWaNNEQPZCt2pfK4FwtNphZbamdc3F
         jZisWY9WzProZQ8CA0c1hPdJ61Ww6i8TlCl3nJsqoL/JE7XvHJk8gbX/05lJsJKPBmuy
         azfpCRBHkRSJRi6KzMeMrZ7D/Rrje7aPACpBBLkvZHiDeQyGQE99fQ7ixEs83wNrb1Ib
         bTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mLGXK/dNfwHeDavvB2GkmSK7lW9Am0Mpj9z7LI5hfcs=;
        b=f82sVHjiIX90qYu7+XBaMwqMI5B2ktSPIOkZsxviiJVZEhLLS6KZDwuDm0ZhzIkuyv
         1rqeODnqcTHXTevL2w6LeKMBdp3D6DC+nzaXhWzSBBP0d8kw0VoQdvhJWaBLQaJ7ZnpG
         Lun71gHFIk6rU+5y/046GheL0iAXTBMneNQC2d2e7m91OwN4ktcrEasRhy7FzxYJEc5T
         TiQCtAc8oLAkjb+P0ks8i/TzL88pdSLnqwjpbCcJQWz4RxXHtpf6OGtx6Be4YBPdOa/q
         xVIw7tG+NQza3HCHKCHMj4rjRWxAYEGcwJlcxsIq6JOuZghHYbcvWPzWc0nJ8QVS6gir
         x+OQ==
X-Gm-Message-State: AGRZ1gK4G9bGW/MKKVbEtJhopYpNj3qL5Jf3MacZsTQ31oqLheEL33X3
        foy/xdZAsaMFTjYGBeUFBkPmQw==
X-Google-Smtp-Source: AJdET5dDBQNia6LXDIQX62ME2WBEBJM6uPAKstP1IiGmP41sf6kjlzX49fbzukD9GpZhj5Z3GcAF3g==
X-Received: by 2002:a62:434d:: with SMTP id q74-v6mr17128683pfa.242.1542996307316;
        Fri, 23 Nov 2018 10:05:07 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k15sm8514470pfb.147.2018.11.23.10.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 10:05:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gQFpA-0001tq-VG; Fri, 23 Nov 2018 11:05:04 -0700
Date:   Fri, 23 Nov 2018 11:05:04 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kenneth Lee <liguozhu@hisilicon.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Zaibo Xu <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com,
        linuxarm@huawei.com, haojian.zhuang@linaro.org,
        Christoph Lameter <cl@linux.com>,
        Hao Fang <fanghao11@huawei.com>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Kershner <david.kershner@unisys.com>,
        Johan Hovold <johan@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, guodong.xu@linaro.org,
        linux-netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-crypto@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
Message-ID: <20181123180504.GA3395@ziepe.ca>
References: <20181114160017.GI3759@mtr-leonro.mtl.com>
 <20181115085109.GD157308@Turing-Arch-b>
 <20181115145455.GN3759@mtr-leonro.mtl.com>
 <20181119091405.GE157308@Turing-Arch-b>
 <20181119184954.GB4890@ziepe.ca>
 <20181120030702.GH157308@Turing-Arch-b>
 <20181120032939.GR4890@ziepe.ca>
 <20181121060805.GJ157308@Turing-Arch-b>
 <20181122025840.GB19938@ziepe.ca>
 <20181123080242.GK157308@Turing-Arch-b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123080242.GK157308@Turing-Arch-b>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 04:02:42PM +0800, Kenneth Lee wrote:

> It is already part of Jean's patchset. And that's why I built my solution on
> VFIO in the first place. But I think the concept of SVA and PASID is not
> compatible with the original VFIO concept space. You would not share your whole
> address space to a device at all in a virtual machine manager,
> wouldn't you?

Why not? That seems to fit VFIO's space just fine to me.. You might
need a new upcall to create a full MM registration, but that doesn't
seem unsuited.

Part of the point here is you should try to make sensible revisions to
existing subsystems before just inventing a new thing...

VFIO is deeply connected to the IOMMU, so enabling more general IOMMU
based approache seems perfectly fine to me..

> > Once the VFIO driver knows about this as a generic capability then the
> > device it exposes to userspace would use CPU addresses instead of DMA
> > addresses.
> > 
> > The question is if your driver needs much more than the device
> > agnostic generic services VFIO provides.
> > 
> > I'm not sure what you have in mind with resource management.. It is
> > hard to revoke resources from userspace, unless you are doing
> > kernel syscalls, but then why do all this?
> 
> Say, I have 1024 queues in my accelerator. I can get one by opening the device
> and attach it with the fd. If the process exit by any means, the queue can be
> returned with the release of the fd. But if it is mdev, it will still be there
> and some one should tell the allocator it is available again. This is not easy
> to design in user space.

?? why wouldn't the mdev track the queues assigned using the existing
open/close/ioctl callbacks?

That is basic flow I would expect:

 open(/dev/vfio)
 ioctl(unity map entire process MM to mdev with IOMMU)

 // Create a HQ queue and link the PASID in the HW to this HW queue
 struct hw queue[..];
 ioctl(create HW queue)

 // Get BAR doorbell memory for the queue
 bar = mmap()

 // Submit work to the queue using CPU addresses
 queue[0] = ...
 writel(bar [..], &queue);

 // Queue, SVA, etc is cleaned up when the VFIO closes
 close()

Presumably the kernel has to handle the PASID and related for security
reasons, so they shouldn't go to userspace?

If there is something missing in vfio to do this is it looks pretty
small to me..

Jason
