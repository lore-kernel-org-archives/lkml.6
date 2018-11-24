Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A68C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 04:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ECD2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 04:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ECD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbeKXO6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 09:58:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731053AbeKXO6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 09:58:48 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 49C1D629875E0;
        Sat, 24 Nov 2018 12:11:47 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 24 Nov
 2018 12:11:41 +0800
Date:   Sat, 24 Nov 2018 12:13:21 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Kenneth Lee <nek.in.cn@gmail.com>,
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
Message-ID: <20181124041321.GL157308@Turing-Arch-b>
References: <20181115085109.GD157308@Turing-Arch-b>
 <20181115145455.GN3759@mtr-leonro.mtl.com>
 <20181119091405.GE157308@Turing-Arch-b>
 <20181119184954.GB4890@ziepe.ca>
 <20181120030702.GH157308@Turing-Arch-b>
 <20181120032939.GR4890@ziepe.ca>
 <20181121060805.GJ157308@Turing-Arch-b>
 <20181122025840.GB19938@ziepe.ca>
 <20181123080242.GK157308@Turing-Arch-b>
 <20181123180504.GA3395@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123180504.GA3395@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:05:04AM -0700, Jason Gunthorpe wrote:
> Date: Fri, 23 Nov 2018 11:05:04 -0700
> From: Jason Gunthorpe <jgg@ziepe.ca>
> To: Kenneth Lee <liguozhu@hisilicon.com>
> CC: Leon Romanovsky <leon@kernel.org>, Kenneth Lee <nek.in.cn@gmail.com>,
>  Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org, Alexander
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
> User-Agent: Mutt/1.9.4 (2018-02-28)
> Message-ID: <20181123180504.GA3395@ziepe.ca>
> 
> On Fri, Nov 23, 2018 at 04:02:42PM +0800, Kenneth Lee wrote:
> 
> > It is already part of Jean's patchset. And that's why I built my solution on
> > VFIO in the first place. But I think the concept of SVA and PASID is not
> > compatible with the original VFIO concept space. You would not share your whole
> > address space to a device at all in a virtual machine manager,
> > wouldn't you?
> 
> Why not? That seems to fit VFIO's space just fine to me.. You might
> need a new upcall to create a full MM registration, but that doesn't
> seem unsuited.

Because the VM manager (such as qemu) do not want to share its whole space to
the device. It is a security problem.

> 
> Part of the point here is you should try to make sensible revisions to
> existing subsystems before just inventing a new thing...
> 
> VFIO is deeply connected to the IOMMU, so enabling more general IOMMU
> based approache seems perfectly fine to me..
> 
> > > Once the VFIO driver knows about this as a generic capability then the
> > > device it exposes to userspace would use CPU addresses instead of DMA
> > > addresses.
> > > 
> > > The question is if your driver needs much more than the device
> > > agnostic generic services VFIO provides.
> > > 
> > > I'm not sure what you have in mind with resource management.. It is
> > > hard to revoke resources from userspace, unless you are doing
> > > kernel syscalls, but then why do all this?
> > 
> > Say, I have 1024 queues in my accelerator. I can get one by opening the device
> > and attach it with the fd. If the process exit by any means, the queue can be
> > returned with the release of the fd. But if it is mdev, it will still be there
> > and some one should tell the allocator it is available again. This is not easy
> > to design in user space.
> 
> ?? why wouldn't the mdev track the queues assigned using the existing
> open/close/ioctl callbacks?
> 
> That is basic flow I would expect:
> 
>  open(/dev/vfio)
>  ioctl(unity map entire process MM to mdev with IOMMU)
> 
>  // Create a HQ queue and link the PASID in the HW to this HW queue
>  struct hw queue[..];
>  ioctl(create HW queue)
> 
>  // Get BAR doorbell memory for the queue
>  bar = mmap()
> 
>  // Submit work to the queue using CPU addresses
>  queue[0] = ...
>  writel(bar [..], &queue);
> 
>  // Queue, SVA, etc is cleaned up when the VFIO closes
>  close()

This is not the way that you can use mdev. To use mdev, you have to:

1. unbind kernel driver from the device, and rebind it to vfio driver
2. for 0 to 1204: uuid > /sys/.../the_dev/mdev/create to create all the mdev
3. a virtual iommu_group will be created in /dev/vfio/* from every mdev

now you can do this in you application (even without considering the pasid) :

	container = open(/dev/vfio);
	ioctl(container, settting);
	group = open(/dev/vfio/my_group_for_particular_mdev);
	ioctl(container, attach_group, group);
	device = ioctl(group, get_device);
	mmap(device);
	ioctl(container, set_dma_operation);

Then you have to make a decision, how can you find a available mdev for use and
how to return it.

We have considered creating only one mdev and allocating queue when the device
is openned. But the VFIO maintainer, Alex, did not agree and said it broke the
VFIO origin idea.

-Kenneth
> 
> Presumably the kernel has to handle the PASID and related for security
> reasons, so they shouldn't go to userspace?
> 
> If there is something missing in vfio to do this is it looks pretty
> small to me..
> 
> Jason

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

