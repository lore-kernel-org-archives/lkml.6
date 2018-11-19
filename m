Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C548EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C53220831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C53220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeKTFm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:42:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbeKTFm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:42:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FAEC309EFF4;
        Mon, 19 Nov 2018 19:17:27 +0000 (UTC)
Received: from redhat.com (ovpn-124-1.rdu2.redhat.com [10.10.124.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7136BBAAC;
        Mon, 19 Nov 2018 19:17:23 +0000 (UTC)
Date:   Mon, 19 Nov 2018 14:17:21 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Kenneth Lee <liguozhu@hisilicon.com>,
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Kershner <david.kershner@unisys.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
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
Message-ID: <20181119191721.GC4593@redhat.com>
References: <20181114160017.GI3759@mtr-leonro.mtl.com>
 <20181115085109.GD157308@Turing-Arch-b>
 <20181115145455.GN3759@mtr-leonro.mtl.com>
 <20181119091405.GE157308@Turing-Arch-b>
 <20181119091910.GF157308@Turing-Arch-b>
 <20181119104801.GF8268@mtr-leonro.mtl.com>
 <20181119164853.GA4593@redhat.com>
 <20181119182752.GA4890@ziepe.ca>
 <20181119184215.GB4593@redhat.com>
 <20181119185333.GC4890@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119185333.GC4890@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 19 Nov 2018 19:17:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:53:33AM -0700, Jason Gunthorpe wrote:
> On Mon, Nov 19, 2018 at 01:42:16PM -0500, Jerome Glisse wrote:
> > On Mon, Nov 19, 2018 at 11:27:52AM -0700, Jason Gunthorpe wrote:
> > > On Mon, Nov 19, 2018 at 11:48:54AM -0500, Jerome Glisse wrote:
> > > 
> > > > Just to comment on this, any infiniband driver which use umem and do
> > > > not have ODP (here ODP for me means listening to mmu notifier so all
> > > > infiniband driver except mlx5) will be affected by same issue AFAICT.
> > > > 
> > > > AFAICT there is no special thing happening after fork() inside any of
> > > > those driver. So if parent create a umem mr before fork() and program
> > > > hardware with it then after fork() the parent might start using new
> > > > page for the umem range while the old memory is use by the child. The
> > > > reverse is also true (parent using old memory and child new memory)
> > > > bottom line you can not predict which memory the child or the parent
> > > > will use for the range after fork().
> > > > 
> > > > So no matter what you consider the child or the parent, what the hw
> > > > will use for the mr is unlikely to match what the CPU use for the
> > > > same virtual address. In other word:
> > > > 
> > > > Before fork:
> > > >     CPU parent: virtual addr ptr1 -> physical address = 0xCAFE
> > > >     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE
> > > > 
> > > > Case 1:
> > > >     CPU parent: virtual addr ptr1 -> physical address = 0xCAFE
> > > >     CPU child:  virtual addr ptr1 -> physical address = 0xDEAD
> > > >     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE
> > > > 
> > > > Case 2:
> > > >     CPU parent: virtual addr ptr1 -> physical address = 0xBEEF
> > > >     CPU child:  virtual addr ptr1 -> physical address = 0xCAFE
> > > >     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE
> > > 
> > > IIRC this is solved in IB by automatically calling
> > > madvise(MADV_DONTFORK) before creating the MR.
> > > 
> > > MADV_DONTFORK
> > >   .. This is useful to prevent copy-on-write semantics from changing the
> > >   physical location of a page if the parent writes to it after a
> > >   fork(2) ..
> > 
> > This would work around the issue but this is not transparent ie
> > range marked with DONTFORK no longer behave as expected from the
> > application point of view.
> 
> Do you know what the difference is? The man page really gives no
> hint..
> 
> Does it sometimes unmap the pages during fork?

It is handled in kernel/fork.c look for DONTCOPY, basicaly it just
leave empty page table in the child process so child will have to
fault in new page. This also means that child will get 0 as initial
value for all memory address under DONTCOPY/DONTFORK which breaks
application expectation of what fork() do.

> 
> I actually wonder if the kernel is a bit broken here, we have the same
> problem with O_DIRECT and other stuff, right?

No it is not, O_DIRECT is fine. The only corner case i can think
of with O_DIRECT is one thread launching an O_DIRECT that write
to private anonymous memory (other O_DIRECT case do not matter)
while another thread call fork() then what the child get can be
undefined ie either it get the data before the O_DIRECT finish
or it gets the result of the O_DIRECT. But this is realy what
you should expect when doing such thing without synchronization.

So O_DIRECT is fine.

> 
> Really, if I have a get_user_pages FOLL_WRITE on a page and we fork,
> then shouldn't the COW immediately be broken during the fork?
> 
> The kernel can't guarentee that an ongoing DMA will not write to those
> pages, and it breaks the fork semantic to write to both processes.

Fixing that would incur a high cost: need to grow struct page, need
to copy potentialy gigabyte of memory during fork() ... this would be
a serious performance regression for many folks just to work around an
abuse of device driver. So i don't think anything on that front would
be welcome.

umem without proper ODP and VFIO are the only bad user i know of (for
VFIO you can argue that it is part of the API contract and thus that
it is not an abuse but it is not spell out loud in documentation). I
have been trying to push back on any people trying to push thing that
would make the same mistake or at least making sure they understand
what is happening.

What really need to happen is people fixing their hardware and do the
right thing (good software engineer versus evil hardware engineer ;))

Cheers,
Jérôme
