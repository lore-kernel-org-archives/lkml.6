Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744D1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BB0213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BB0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeKUNdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:33:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbeKUNdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 08:33:37 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BF0F62A6DDDA3;
        Wed, 21 Nov 2018 11:01:07 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 21 Nov
 2018 11:01:01 +0800
Date:   Wed, 21 Nov 2018 11:02:45 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Kenneth Lee <nek.in.cn@gmail.com>,
        "Tim Sell" <timothy.sell@unisys.com>, <linux-doc@vger.kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Zaibo Xu <xuzaibo@huawei.com>, <zhangfei.gao@foxmail.com>,
        <linuxarm@huawei.com>, <haojian.zhuang@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        Hao Fang <fanghao11@huawei.com>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Kershner <david.kershner@unisys.com>,
        Johan Hovold <johan@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, <guodong.xu@linaro.org>,
        linux-netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-accelerators@lists.ozlabs.org>
Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
Message-ID: <20181121030245.GI157308@Turing-Arch-b>
References: <20181112075807.9291-2-nek.in.cn@gmail.com>
 <20181113002354.GO3695@mtr-leonro.mtl.com>
 <95310df4-b32c-42f0-c750-3ad5eb89b3dd@gmail.com>
 <20181114160017.GI3759@mtr-leonro.mtl.com>
 <20181115085109.GD157308@Turing-Arch-b>
 <20181115145455.GN3759@mtr-leonro.mtl.com>
 <20181119091405.GE157308@Turing-Arch-b>
 <20181119184954.GB4890@ziepe.ca>
 <20181120030702.GH157308@Turing-Arch-b>
 <20181120051743.GD25178@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120051743.GD25178@mtr-leonro.mtl.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:17:44AM +0200, Leon Romanovsky wrote:
> Date: Tue, 20 Nov 2018 07:17:44 +0200
> From: Leon Romanovsky <leon@kernel.org>
> To: Kenneth Lee <liguozhu@hisilicon.com>
> CC: Jason Gunthorpe <jgg@ziepe.ca>, Kenneth Lee <nek.in.cn@gmail.com>, Tim
>  Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org, Alexander
>  Shishkin <alexander.shishkin@linux.intel.com>, Zaibo Xu
>  <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com, linuxarm@huawei.com,
>  haojian.zhuang@linaro.org, Christoph Lameter <cl@linux.com>, Hao Fang
>  <fanghao11@huawei.com>, Gavin Schenk <g.schenk@eckelmann.de>, RDMA mailing
>  list <linux-rdma@vger.kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
>  Doug Ledford <dledford@redhat.com>, Uwe Kleine-König
>  <u.kleine-koenig@pengutronix.de>, David Kershner
>  <david.kershner@unisys.com>, Johan Hovold <johan@kernel.org>, Cyrille
>  Pitchen <cyrille.pitchen@free-electrons.com>, Sagar Dharia
>  <sdharia@codeaurora.org>, Jens Axboe <axboe@kernel.dk>,
>  guodong.xu@linaro.org, linux-netdev <netdev@vger.kernel.org>, Randy Dunlap
>  <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Vinod Koul
>  <vkoul@kernel.org>, linux-crypto@vger.kernel.org, Philippe Ombredanne
>  <pombredanne@nexb.com>, Sanyog Kale <sanyog.r.kale@intel.com>, "David S.
>  Miller" <davem@davemloft.net>, linux-accelerators@lists.ozlabs.org
> Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
> User-Agent: Mutt/1.10.1 (2018-07-13)
> Message-ID: <20181120051743.GD25178@mtr-leonro.mtl.com>
> 
> On Tue, Nov 20, 2018 at 11:07:02AM +0800, Kenneth Lee wrote:
> > On Mon, Nov 19, 2018 at 11:49:54AM -0700, Jason Gunthorpe wrote:
> > > Date: Mon, 19 Nov 2018 11:49:54 -0700
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > To: Kenneth Lee <liguozhu@hisilicon.com>
> > > CC: Leon Romanovsky <leon@kernel.org>, Kenneth Lee <nek.in.cn@gmail.com>,
> > >  Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org, Alexander
> > >  Shishkin <alexander.shishkin@linux.intel.com>, Zaibo Xu
> > >  <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com, linuxarm@huawei.com,
> > >  haojian.zhuang@linaro.org, Christoph Lameter <cl@linux.com>, Hao Fang
> > >  <fanghao11@huawei.com>, Gavin Schenk <g.schenk@eckelmann.de>, RDMA mailing
> > >  list <linux-rdma@vger.kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
> > >  Doug Ledford <dledford@redhat.com>, Uwe Kleine-König
> > >  <u.kleine-koenig@pengutronix.de>, David Kershner
> > >  <david.kershner@unisys.com>, Johan Hovold <johan@kernel.org>, Cyrille
> > >  Pitchen <cyrille.pitchen@free-electrons.com>, Sagar Dharia
> > >  <sdharia@codeaurora.org>, Jens Axboe <axboe@kernel.dk>,
> > >  guodong.xu@linaro.org, linux-netdev <netdev@vger.kernel.org>, Randy Dunlap
> > >  <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Vinod Koul
> > >  <vkoul@kernel.org>, linux-crypto@vger.kernel.org, Philippe Ombredanne
> > >  <pombredanne@nexb.com>, Sanyog Kale <sanyog.r.kale@intel.com>, "David S.
> > >  Miller" <davem@davemloft.net>, linux-accelerators@lists.ozlabs.org
> > > Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
> > > User-Agent: Mutt/1.9.4 (2018-02-28)
> > > Message-ID: <20181119184954.GB4890@ziepe.ca>
> > >
> > > On Mon, Nov 19, 2018 at 05:14:05PM +0800, Kenneth Lee wrote:
> > >
> > > > If the hardware cannot share page table with the CPU, we then need to have
> > > > some way to change the device page table. This is what happen in ODP. It
> > > > invalidates the page table in device upon mmu_notifier call back. But this cannot
> > > > solve the COW problem: if the user process A share a page P with device, and A
> > > > forks a new process B, and it continue to write to the page. By COW, the
> > > > process B will keep the page P, while A will get a new page P'. But you have
> > > > no way to let the device know it should use P' rather than P.
> > >
> > > Is this true? I thought mmu_notifiers covered all these cases.
> > >
> > > The mm_notifier for A should fire if B causes the physical address of
> > > A's pages to change via COW.
> > >
> > > And this causes the device page tables to re-synchronize.
> >
> > I don't see such code. The current do_cow_fault() implemenation has nothing to
> > do with mm_notifer.
> >
> > >
> > > > In WarpDrive/uacce, we make this simple. If you support IOMMU and it support
> > > > SVM/SVA. Everything will be fine just like ODP implicit mode. And you don't need
> > > > to write any code for that. Because it has been done by IOMMU framework. If it
> > >
> > > Looks like the IOMMU code uses mmu_notifier, so it is identical to
> > > IB's ODP. The only difference is that IB tends to have the IOMMU page
> > > table in the device, not in the CPU.
> > >
> > > The only case I know if that is different is the new-fangled CAPI
> > > stuff where the IOMMU can directly use the CPU's page table and the
> > > IOMMU page table (in device or CPU) is eliminated.
> > >
> >
> > Yes. We are not focusing on the current implementation. As mentioned in the
> > cover letter. We are expecting Jean Philips' SVA patch:
> > git://linux-arm.org/linux-jpb.
> >
> > > Anyhow, I don't think a single instance of hardware should justify an
> > > entire new subsystem. Subsystems are hard to make and without multiple
> > > hardware examples there is no way to expect that it would cover any
> > > future use cases.
> >
> > Yes. That's our first expectation. We can keep it with our driver. But because
> > there is no user driver support for any accelerator in mainline kernel. Even the
> > well known QuickAssit has to be maintained out of tree. So we try to see if
> > people is interested in working together to solve the problem.
> >
> > >
> > > If all your driver needs is to mmap some PCI bar space, route
> > > interrupts and do DMA mapping then mediated VFIO is probably a good
> > > choice.
> >
> > Yes. That is what is done in our RFCv1/v2. But we accepted Jerome's opinion and
> > try not to add complexity to the mm subsystem.
> >
> > >
> > > If it needs to do a bunch of other stuff, not related to PCI bar
> > > space, interrupts and DMA mapping (ie special code for compression,
> > > crypto, AI, whatever) then you should probably do what Jerome said and
> > > make a drivers/char/hisillicon_foo_bar.c that exposes just what your
> > > hardware does.
> >
> > Yes. If no other accelerator driver writer is interested. That is the
> > expectation:)
> >
> > But we really like to have a public solution here. Consider this scenario:
> >
> > You create some connections (queues) to NIC, RSA, and AI engine. Then you got
> > data direct from the NIC and pass the pointer to RSA engine for decryption. The
> > CPU then finish some data taking or operation and then pass through to the AI
> > engine for CNN calculation....This will need a place to maintain the same
> > address space by some means.
> 
> You are using NIC terminology, in the documentation, you wrote that it is needed
> for DPDK use and I don't really understand, why do we need another shiny new
> interface for DPDK.
> 

I'm not a DPDK expert. But we had some discussion with LNG of Linaro. They were
considering to create something similar to simplify the user driver. In most of
case, we use DPDK or ODP (open data plane) just for faster data plane data flow.
But many logic such as setting the hardware mode, mac address and so on is not
necessary. So they were looking for a way to keep the driver in the kernel and
just the ring buffer of some queues to the user space. This may simplified the
user space design.

> >
> > It is not complex, but it is helpful.
> >
> > >
> > > If you have networking involved in here then consider RDMA,
> > > particularly if this functionality is already part of the same
> > > hardware that the hns infiniband driver is servicing.
> > >
> > > 'computational MRs' are a reasonable approach to a side-car offload of
> > > already existing RDMA support.
> >
> > OK. Thanks. I will spend some time on it. But personally, I really don't like
> > RDMA's complexity. I cannot even try one single function without a...some
> > expensive hardwares and complexity connection in the lab. This is not like a
> > open source way.
> 
> It is not very accurate. We have RXE driver which is virtual RDMA device
> which is implemented purely in SW. It struggles from bad performance and
> sporadic failures, but it is enough to try RDMA on your laptop in VM.

Woo. This will be helpful. Thank you very much.

> 
> Thanks
> 
> >
> > >
> > > Jason
> >



-- 
			-Kenneth(Hisilicon)

================================================================================
本邮件及其附件含有华为公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁
止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中
的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！
This e-mail and its attachments contain confidential information from HUAWEI,
which is intended only for the person or entity whose address is listed above.
Any use of the 
information contained herein in any way (including, but not limited to, total or
partial disclosure, reproduction, or dissemination) by persons other than the
intended 
recipient(s) is prohibited. If you receive this e-mail in error, please notify
the sender by phone or email immediately and delete it!

