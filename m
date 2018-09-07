Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA67C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084E92075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 04:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084E92075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIGImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:42:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbeIGImc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:42:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 03710FFF01337;
        Fri,  7 Sep 2018 12:03:31 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 7 Sep 2018
 12:03:27 +0800
Date:   Fri, 7 Sep 2018 12:01:38 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kvm@vger.kernel.org>, <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, <linuxarm@huawei.com>
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180907040138.GI230707@Turing-Arch-b>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180904150019.GA4024@redhat.com>
 <20180904101509.62314b67@t450s.home>
 <20180906094532.GG230707@Turing-Arch-b>
 <20180906133133.GA3830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180906133133.GA3830@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 09:31:33AM -0400, Jerome Glisse wrote:
> Date: Thu, 6 Sep 2018 09:31:33 -0400
> From: Jerome Glisse <jglisse@redhat.com>
> To: Kenneth Lee <liguozhu@hisilicon.com>
> CC: Alex Williamson <alex.williamson@redhat.com>, Kenneth Lee
>  <nek.in.cn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Herbert Xu
>  <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
>  Joerg Roedel <joro@8bytes.org>, Hao Fang <fanghao11@huawei.com>, Zhou Wang
>  <wangzhou1@hisilicon.com>, Zaibo Xu <xuzaibo@huawei.com>, Philippe
>  Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
>  <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
>  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
>  linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
>  kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org, Lu Baolu
>  <baolu.lu@linux.intel.com>, Sanjay Kumar <sanjay.k.kumar@intel.com>,
>  linuxarm@huawei.com
> Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
> User-Agent: Mutt/1.10.0 (2018-05-17)
> Message-ID: <20180906133133.GA3830@redhat.com>
> 
> On Thu, Sep 06, 2018 at 05:45:32PM +0800, Kenneth Lee wrote:
> > On Tue, Sep 04, 2018 at 10:15:09AM -0600, Alex Williamson wrote:
> > > Date: Tue, 4 Sep 2018 10:15:09 -0600
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > To: Jerome Glisse <jglisse@redhat.com>
> > > CC: Kenneth Lee <nek.in.cn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
> > >  Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
> > >  <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>, Kenneth Lee
> > >  <liguozhu@hisilicon.com>, Hao Fang <fanghao11@huawei.com>, Zhou Wang
> > >  <wangzhou1@hisilicon.com>, Zaibo Xu <xuzaibo@huawei.com>, Philippe
> > >  Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
> > >  <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
> > >  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
> > >  linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
> > >  kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org, Lu Baolu
> > >  <baolu.lu@linux.intel.com>, Sanjay Kumar <sanjay.k.kumar@intel.com>,
> > >  linuxarm@huawei.com
> > > Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
> > > Message-ID: <20180904101509.62314b67@t450s.home>
> > > 
> > > On Tue, 4 Sep 2018 11:00:19 -0400
> > > Jerome Glisse <jglisse@redhat.com> wrote:
> > > 
> > > > On Mon, Sep 03, 2018 at 08:51:57AM +0800, Kenneth Lee wrote:
> > > > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > > > > 
> > > > > WarpDrive is an accelerator framework to expose the hardware capabilities
> > > > > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > > > > facilities. So the user application can send request and DMA to the
> > > > > hardware without interaction with the kernel. This removes the latency
> > > > > of syscall.
> > > > > 
> > > > > WarpDrive is the name for the whole framework. The component in kernel
> > > > > is called SDMDEV, Share Domain Mediated Device. Driver driver exposes its
> > > > > hardware resource by registering to SDMDEV as a VFIO-Mdev. So the user
> > > > > library of WarpDrive can access it via VFIO interface.
> > > > > 
> > > > > The patchset contains document for the detail. Please refer to it for more
> > > > > information.
> > > > > 
> > > > > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > > > > patch [1], which enables not only IO side page fault, but also PASID
> > > > > support to IOMMU and VFIO.
> > > > > 
> > > > > With these features, WarpDrive can support non-pinned memory and
> > > > > multi-process in the same accelerator device.  We tested it in our SoC
> > > > > integrated Accelerator (board ID: D06, Chip ID: HIP08). A reference work
> > > > > tree can be found here: [2].
> > > > > 
> > > > > But it is not mandatory. This patchset is tested in the latest mainline
> > > > > kernel without the SVA patches.  So it supports only one process for each
> > > > > accelerator.
> > > > > 
> > > > > We have noticed the IOMMU aware mdev RFC announced recently [3].
> > > > > 
> > > > > The IOMMU aware mdev has similar idea but different intention comparing to
> > > > > WarpDrive. It intends to dedicate part of the hardware resource to a VM.
> > > > > And the design is supposed to be used with Scalable I/O Virtualization.
> > > > > While sdmdev is intended to share the hardware resource with a big amount
> > > > > of processes.  It just requires the hardware supporting address
> > > > > translation per process (PCIE's PASID or ARM SMMU's substream ID).
> > > > > 
> > > > > But we don't see serious confliction on both design. We believe they can be
> > > > > normalized as one.
> > > > >   
> > > > 
> > > > So once again i do not understand why you are trying to do things
> > > > this way. Kernel already have tons of example of everything you
> > > > want to do without a new framework. Moreover i believe you are
> > > > confuse by VFIO. To me VFIO is for VM not to create general device
> > > > driver frame work.
> > > 
> > > VFIO is a userspace driver framework, the VM use case just happens to
> > > be a rather prolific one.  VFIO was never intended to be solely a VM
> > > device interface and has several other userspace users, notably DPDK
> > > and SPDK, an NVMe backend in QEMU, a userspace NVMe driver, a ruby
> > > wrapper, and perhaps others that I'm not aware of.  Whether vfio is
> > > appropriate interface here might certainly still be a debatable topic,
> > > but I would strongly disagree with your last sentence above.  Thanks,
> > > 
> > > Alex
> > > 
> > 
> > Yes, that is also my standpoint here.
> > 
> > > > So here is your use case as i understand it. You have a device
> > > > with a limited number of command queues (can be just one) and in
> > > > some case it can support SVA/SVM (when hardware support it and it
> > > > is not disabled). Final requirement is being able to schedule cmds
> > > > from userspace without ioctl. All of this exists already exists
> > > > upstream in few device drivers.
> > > > 
> > > > 
> > > > So here is how every body else is doing it. Please explain why
> > > > this does not work.
> > > > 
> > > > 1 Userspace open device file driver. Kernel device driver create
> > > >   a context and associate it with on open. This context can be
> > > >   uniq to the process and can bind hardware resources (like a
> > > >   command queue) to the process.
> > > > 2 Userspace bind/acquire a commands queue and initialize it with
> > > >   an ioctl on the device file. Through that ioctl userspace can
> > > >   be inform wether either SVA/SVM works for the device. If SVA/
> > > >   SVM works then kernel device driver bind the process to the
> > > >   device as part of this ioctl.
> > > > 3 If SVM/SVA does not work userspace do an ioctl to create dma
> > > >   buffer or something that does exactly the same thing.
> > > > 4 Userspace mmap the command queue (mmap of the device file by
> > > >   using informations gather at step 2)
> > > > 5 Userspace can write commands into the queue it mapped
> > > > 6 When userspace close the device file all resources are release
> > > >   just like any existing device drivers.
> > 
> > Hi, Jerome,
> > 
> > Just one thing, as I said in the cover letter, dma-buf requires the application
> > to use memory created by the driver for DMA. I did try the dma-buf way in
> > WrapDrive (refer to [4] in the cover letter), it is a good backup for NOIOMMU
> > mode or we cannot solve the problem in VFIO.
> > 
> > But, in many of my application scenario, the application already has some memory
> > in hand, maybe allocated by the framework or libraries. Anyway, they don't get
> > memory from my library, and they pass the poiter for data operation. And they
> > may also have pointer in the buffer. Those pointer may be used by the
> > accelerator. So I need hardware fully share the address space with the
> > application. That is what dmabuf cannot do.
> 
> dmabuf can do that ... it is call uptr you can look at i915 for
> instance. Still this does not answer my question above, why do
> you need to be in VFIO to do any of the above thing ? Kernel has
> tons of examples that does all of the above and are not in VFIO
> (including usinng existing user pointer with device).
> 
> Cheers,
> Jérôme

I took a look at i915_gem_execbuffer_ioctl(). It seems it "copy_from_user" the
user memory to the kernel. That is not what we need. What we try to get is: the
user application do something on its data, and push it away to the accelerator,
and says: "I'm tied, it is your turn to do the job...". Then the accelerator has
the memory, referring any portion of it with the same VAs of the application,
even the VAs are stored inside the memory itself.

And I don't understand why I should avoid to use VFIO? As Alex said, VFIO is the
user driver framework. And I need exactly a user driver interface. Why should I
invent another wheel? It has most of stuff I need:

1. Connecting multiple devices to the same application space
2. Pinning and DMA from the application space to the whole set of device
3. Managing hardware resource by device

We just need the last step: make sure multiple applications and the kernel can
share the same IOMMU. Then why shouldn't we use VFIO?

And personally, I believe the maturity and correctness of a framework are driven
by applications. Now the problem in accelerator world is that we don't have a
direction. If we believe the requirement is right, the method itself is not a
big problem in the end. We just need to let people have a unify platform to
share their work together.

Cheers
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

