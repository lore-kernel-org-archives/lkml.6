Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C325321723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C325321723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeHCFnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 01:43:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbeHCFnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 01:43:10 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 15A6A2B347DE4;
        Fri,  3 Aug 2018 11:48:47 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 3 Aug 2018
 11:48:40 +0800
Date:   Fri, 3 Aug 2018 11:47:21 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Hao Fang <fanghao11@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180803034721.GC91035@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802040557.GL160746@Turing-Arch-b>
 <20180802142243.GA3481@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180802142243.GA3481@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 10:22:43AM -0400, Jerome Glisse wrote:
> Date: Thu, 2 Aug 2018 10:22:43 -0400
> From: Jerome Glisse <jglisse@redhat.com>
> To: Kenneth Lee <liguozhu@hisilicon.com>
> CC: "Tian, Kevin" <kevin.tian@intel.com>, Hao Fang <fanghao11@huawei.com>,
>  Alex Williamson <alex.williamson@redhat.com>, Herbert Xu
>  <herbert@gondor.apana.org.au>, "kvm@vger.kernel.org"
>  <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg
>  Kroah-Hartman <gregkh@linuxfoundation.org>, Zaibo Xu <xuzaibo@huawei.com>,
>  "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Kumar, Sanjay K"
>  <sanjay.k.kumar@intel.com>, Kenneth Lee <nek.in.cn@gmail.com>,
>  "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
>  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
>  "linuxarm@huawei.com" <linuxarm@huawei.com>,
>  "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Philippe
>  Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>,
>  "David S . Miller" <davem@davemloft.net>,
>  "linux-accelerators@lists.ozlabs.org"
>  <linux-accelerators@lists.ozlabs.org>
> Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
> User-Agent: Mutt/1.10.0 (2018-05-17)
> Message-ID: <20180802142243.GA3481@redhat.com>
> 
> On Thu, Aug 02, 2018 at 12:05:57PM +0800, Kenneth Lee wrote:
> > On Thu, Aug 02, 2018 at 02:33:12AM +0000, Tian, Kevin wrote:
> > > Date: Thu, 2 Aug 2018 02:33:12 +0000
> > > > From: Jerome Glisse
> > > > On Wed, Aug 01, 2018 at 06:22:14PM +0800, Kenneth Lee wrote:
> > > > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > > > >
> > > > > WarpDrive is an accelerator framework to expose the hardware
> > > > capabilities
> > > > > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > > > > facilities. So the user application can send request and DMA to the
> > > > > hardware without interaction with the kernel. This remove the latency
> > > > > of syscall and context switch.
> > > > >
> > > > > The patchset contains documents for the detail. Please refer to it for
> > > > more
> > > > > information.
> > > > >
> > > > > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > > > > patch [1] (Which is also in RFC stage). But it is not mandatory. This
> > > > > patchset is tested in the latest mainline kernel without the SVA patches.
> > > > > So it support only one process for each accelerator.
> > > > >
> > > > > With SVA support, WarpDrive can support multi-process in the same
> > > > > accelerator device.  We tested it in our SoC integrated Accelerator (board
> > > > > ID: D06, Chip ID: HIP08). A reference work tree can be found here: [2].
> > > > 
> > > > I have not fully inspected things nor do i know enough about
> > > > this Hisilicon ZIP accelerator to ascertain, but from glimpsing
> > > > at the code it seems that it is unsafe to use even with SVA due
> > > > to the doorbell. There is a comment talking about safetyness
> > > > in patch 7.
> > > > 
> > > > Exposing thing to userspace is always enticing, but if it is
> > > > a security risk then it should clearly say so and maybe a
> > > > kernel boot flag should be necessary to allow such device to
> > > > be use.
> > > > 
> > 
> > But doorbell is just a notification. Except for DOS (to make hardware busy) it
> > cannot actually take or change anything from the kernel space. And the DOS
> > problem can be always taken as the problem that a group of processes share the
> > same kernel entity.
> > 
> > In the coming HIP09 hardware, the doorbell will come with a random number so
> > only the process who allocated the queue can knock it correctly.
> 
> When doorbell is ring the hardware start fetching commands from
> the queue and execute them ? If so than a rogue process B might
> ring the doorbell of process A which would starts execution of
> random commands (ie whatever random memory value there is left
> inside the command buffer memory, could be old commands i guess).
> 
> If this is not how this doorbell works then, yes it can only do
> a denial of service i guess. Issue i have with doorbell is that
> i have seen 10 differents implementations in 10 differents hw
> and each are different as to what ringing or value written to the
> doorbell does. It is painfull to track what is what for each hw.
> 

In our implementation, doorbell is simply a notification, just like an interrupt
to the accelerator. The command is all about what's in the queue.

I agree that there is no simple and standard way to track the shared IO space.
But I think we have to trust the driver in some way. If the driver is malicious,
even a simple ioctl can become an attack.

> 
> > > > My more general question is do we want to grow VFIO to become
> > > > a more generic device driver API. This patchset adds a command
> > > > queue concept to it (i don't think it exist today but i have
> > > > not follow VFIO closely).
> > > > 
> > 
> > The thing is, VFIO is the only place to support DMA from user land. If we don't
> > put it here, we have to create another similar facility to support the same.
> 
> No it is not, network device, GPU, block device, ... they all do
> support DMA. The point i am trying to make here is that even in

Sorry, wait a minute, are we talking the same thing? I meant "DMA from user
land", not "DMA from kernel driver". To do that we have to manipulate the
IOMMU(Unit). I think it can only be done by default_domain or vfio domain. Or
the user space have to directly access the IOMMU.

> your mechanisms the userspace must have a specific userspace
> drivers for each hardware and thus there are virtually no
> differences between having this userspace driver open a device
> file in vfio or somewhere else in the device filesystem. This is
> just a different path.
> 

The basic problem WarpDrive want to solve it to avoid syscall. This is important
to accelerators. We have some data here:
https://www.slideshare.net/linaroorg/progress-and-demonstration-of-wrapdrive-a-accelerator-framework-sfo17317

(see page 3)

The performance is different on using kernel and user drivers.

And we also believe the hardware interface can become standard after sometime.
Some companies have started to do this (such ARM's Revere). But before that, we
should have a software channel for it.

> So this is why i do not see any benefit to having all drivers with
> SVM (can we please use SVM and not SVA as SVM is what have been use
> in more places so far).
> 

Personally, we don't care what name to be used. I used SVM when I start this
work. And then Jean said SVM had been used by AMD as Secure Virtual Machine. So
he called it SVA. And now... who should I follow? :)

> 
> Cheers,
> Jérôme

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

