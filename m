Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1ACC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F172080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 03:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y5IbkbRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F172080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbeKTN4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:56:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40525 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbeKTN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:56:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so253897pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ItSUQriA9bF4U9+gjIvDJehJFgB1nf+g2U4rrmXi0Eg=;
        b=Y5IbkbRJTK6BEKKzrduOKNEEFVtTBcGKJL3cnIPXFqfP0svPN7SbST0b8nwrCj+J/D
         72dvJOZaGpwzieWfd+gFMoA89pvpx2p5MF9xaByG5yzVnccGMzwe/Rp62x6z600w79Me
         CITbdAa83nG2reZAZeEnVnq4Nq2R1Psji1xV78ZnG2bWhzo+XhNjQGHgVOWXnoYfscBf
         Fg3LjzCNPIdt+3svflaDHczu/N50Ig3OlLpW3BjqWjxaKboJJoDPgAn+uLP6dxO/zhGh
         bbIV00i4Mwmc72AIElPzlWNZkuAvQwyua07HeuI8XK3XWUKxsdFjPrKvUknWCR6zKai8
         wJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ItSUQriA9bF4U9+gjIvDJehJFgB1nf+g2U4rrmXi0Eg=;
        b=lNew4DmY2DgeJvOg/YCpdv4qnkl0r4qPJuVIuJhQpmOjYpFPQ/XN1Zch23Oe5UuTYF
         JqlwxnORGGH0bBarj3rs5KUwC4WARjHJe4Rva/e24yjtaJU+0KJwZhCWVsh9z1JtNEl5
         U/kSgowl1hH2YbmzlwHpzm2eNFrKh0AQwNO4Jm7xjQX8uDwUZYnFEipkJOHeaeGQ3JL2
         92y88k11IY7ZsYTxOlpmWn6SxoE0ui5wQqlWT97zsY/EL7W8zQuFjWT9JCmiU+1J1mDj
         IqRNZq8cbBw0yfiffHaP9BPAupkGwBx22cnP9luwWy1od27z+/ARQZGld76FpbEDIAp5
         7v2w==
X-Gm-Message-State: AGRZ1gLu/jG1fn4TG24rbJdeaAEqnypomIsXowVmczS70jG3GC7x3+rl
        xTIMmHAGuSDy7XDojKL++FJvgw==
X-Google-Smtp-Source: AJdET5c/UxXkrj6dqUiE992DPsDWLJua3FSZBkBSjXoUg9TNUrF8ae3UiyirZMCs3zwB/wsl+jkfUw==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr424493pfn.220.1542684581488;
        Mon, 19 Nov 2018 19:29:41 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 34sm63897988pgp.90.2018.11.19.19.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 19:29:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOwjL-0001ld-JQ; Mon, 19 Nov 2018 20:29:39 -0700
Date:   Mon, 19 Nov 2018 20:29:39 -0700
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
Message-ID: <20181120032939.GR4890@ziepe.ca>
References: <20181112075807.9291-1-nek.in.cn@gmail.com>
 <20181112075807.9291-2-nek.in.cn@gmail.com>
 <20181113002354.GO3695@mtr-leonro.mtl.com>
 <95310df4-b32c-42f0-c750-3ad5eb89b3dd@gmail.com>
 <20181114160017.GI3759@mtr-leonro.mtl.com>
 <20181115085109.GD157308@Turing-Arch-b>
 <20181115145455.GN3759@mtr-leonro.mtl.com>
 <20181119091405.GE157308@Turing-Arch-b>
 <20181119184954.GB4890@ziepe.ca>
 <20181120030702.GH157308@Turing-Arch-b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120030702.GH157308@Turing-Arch-b>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:07:02AM +0800, Kenneth Lee wrote:
> On Mon, Nov 19, 2018 at 11:49:54AM -0700, Jason Gunthorpe wrote:
> > Date: Mon, 19 Nov 2018 11:49:54 -0700
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > To: Kenneth Lee <liguozhu@hisilicon.com>
> > CC: Leon Romanovsky <leon@kernel.org>, Kenneth Lee <nek.in.cn@gmail.com>,
> >  Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org, Alexander
> >  Shishkin <alexander.shishkin@linux.intel.com>, Zaibo Xu
> >  <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com, linuxarm@huawei.com,
> >  haojian.zhuang@linaro.org, Christoph Lameter <cl@linux.com>, Hao Fang
> >  <fanghao11@huawei.com>, Gavin Schenk <g.schenk@eckelmann.de>, RDMA mailing
> >  list <linux-rdma@vger.kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
> >  Doug Ledford <dledford@redhat.com>, Uwe Kleine-König
> >  <u.kleine-koenig@pengutronix.de>, David Kershner
> >  <david.kershner@unisys.com>, Johan Hovold <johan@kernel.org>, Cyrille
> >  Pitchen <cyrille.pitchen@free-electrons.com>, Sagar Dharia
> >  <sdharia@codeaurora.org>, Jens Axboe <axboe@kernel.dk>,
> >  guodong.xu@linaro.org, linux-netdev <netdev@vger.kernel.org>, Randy Dunlap
> >  <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Vinod Koul
> >  <vkoul@kernel.org>, linux-crypto@vger.kernel.org, Philippe Ombredanne
> >  <pombredanne@nexb.com>, Sanyog Kale <sanyog.r.kale@intel.com>, "David S.
> >  Miller" <davem@davemloft.net>, linux-accelerators@lists.ozlabs.org
> > Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
> > User-Agent: Mutt/1.9.4 (2018-02-28)
> > Message-ID: <20181119184954.GB4890@ziepe.ca>
> > 
> > On Mon, Nov 19, 2018 at 05:14:05PM +0800, Kenneth Lee wrote:
> >  
> > > If the hardware cannot share page table with the CPU, we then need to have
> > > some way to change the device page table. This is what happen in ODP. It
> > > invalidates the page table in device upon mmu_notifier call back. But this cannot
> > > solve the COW problem: if the user process A share a page P with device, and A 
> > > forks a new process B, and it continue to write to the page. By COW, the
> > > process B will keep the page P, while A will get a new page P'. But you have
> > > no way to let the device know it should use P' rather than P.
> > 
> > Is this true? I thought mmu_notifiers covered all these cases.
> > 
> > The mm_notifier for A should fire if B causes the physical address of
> > A's pages to change via COW. 
> > 
> > And this causes the device page tables to re-synchronize.
> 
> I don't see such code. The current do_cow_fault() implemenation has nothing to
> do with mm_notifer.

Well, that sure sounds like it would be a bug in mmu_notifiers..

But considering Jean's SVA stuff seems based on mmu notifiers, I have
a hard time believing that it has any different behavior from RDMA's
ODP, and if it does have different behavior, then it is probably just
a bug in the ODP implementation.

> > > In WarpDrive/uacce, we make this simple. If you support IOMMU and it support
> > > SVM/SVA. Everything will be fine just like ODP implicit mode. And you don't need
> > > to write any code for that. Because it has been done by IOMMU framework. If it
> > 
> > Looks like the IOMMU code uses mmu_notifier, so it is identical to
> > IB's ODP. The only difference is that IB tends to have the IOMMU page
> > table in the device, not in the CPU.
> > 
> > The only case I know if that is different is the new-fangled CAPI
> > stuff where the IOMMU can directly use the CPU's page table and the
> > IOMMU page table (in device or CPU) is eliminated.
>
> Yes. We are not focusing on the current implementation. As mentioned in the
> cover letter. We are expecting Jean Philips' SVA patch:
> git://linux-arm.org/linux-jpb.

This SVA stuff does not look comparable to CAPI as it still requires
maintaining seperate IOMMU page tables.

Also, those patches from Jean have a lot of references to
mmu_notifiers (ie look at iommu_mmu_notifier).

Are you really sure it is actually any different at all?

> > Anyhow, I don't think a single instance of hardware should justify an
> > entire new subsystem. Subsystems are hard to make and without multiple
> > hardware examples there is no way to expect that it would cover any
> > future use cases.
> 
> Yes. That's our first expectation. We can keep it with our driver. But because
> there is no user driver support for any accelerator in mainline kernel. Even the
> well known QuickAssit has to be maintained out of tree. So we try to see if
> people is interested in working together to solve the problem.

Well, you should come with patches ack'ed by these other groups.

> > If all your driver needs is to mmap some PCI bar space, route
> > interrupts and do DMA mapping then mediated VFIO is probably a good
> > choice. 
> 
> Yes. That is what is done in our RFCv1/v2. But we accepted Jerome's opinion and
> try not to add complexity to the mm subsystem.

Why would a mediated VFIO driver touch the mm subsystem? Sounds like
you don't have a VFIO driver if it needs to do stuff like that...

> > If it needs to do a bunch of other stuff, not related to PCI bar
> > space, interrupts and DMA mapping (ie special code for compression,
> > crypto, AI, whatever) then you should probably do what Jerome said and
> > make a drivers/char/hisillicon_foo_bar.c that exposes just what your
> > hardware does.
> 
> Yes. If no other accelerator driver writer is interested. That is the
> expectation:)

I don't think it matters what other drivers do. 

If your driver does not need any other kernel code then VFIO is
sensible. In this kind of world you will probably have a RDMA-like
userspace driver that can bring this to a common user space API, even
if one driver use VFIO and a different driver uses something else.

> You create some connections (queues) to NIC, RSA, and AI engine. Then you got
> data direct from the NIC and pass the pointer to RSA engine for decryption. The
> CPU then finish some data taking or operation and then pass through to the AI
> engine for CNN calculation....This will need a place to maintain the same
> address space by some means.

How is this any different from what we have today? 

SVA is not something even remotely new, IB has been doing various
versions of it for 20 years.

Jason
