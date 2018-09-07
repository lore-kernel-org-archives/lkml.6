Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B250B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B250B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeIGVfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:35:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbeIGVfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 974AA401D780;
        Fri,  7 Sep 2018 16:53:12 +0000 (UTC)
Received: from redhat.com (ovpn-123-145.rdu2.redhat.com [10.10.123.145])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EDD5FA99E;
        Fri,  7 Sep 2018 16:53:07 +0000 (UTC)
Date:   Fri, 7 Sep 2018 12:53:06 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Kenneth Lee <liguozhu@hisilicon.com>
Cc:     Kenneth Lee <nek.in.cn@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, kvm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Hao Fang <fanghao11@huawei.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-crypto@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180907165303.GA3519@redhat.com>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180904150019.GA4024@redhat.com>
 <20180904101509.62314b67@t450s.home>
 <20180906094532.GG230707@Turing-Arch-b>
 <20180906133133.GA3830@redhat.com>
 <20180907040138.GI230707@Turing-Arch-b>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907040138.GI230707@Turing-Arch-b>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 16:53:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 16:53:12 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:01:38PM +0800, Kenneth Lee wrote:
> On Thu, Sep 06, 2018 at 09:31:33AM -0400, Jerome Glisse wrote:
> > Date: Thu, 6 Sep 2018 09:31:33 -0400
> > From: Jerome Glisse <jglisse@redhat.com>
> > To: Kenneth Lee <liguozhu@hisilicon.com>
> > CC: Alex Williamson <alex.williamson@redhat.com>, Kenneth Lee
> >  <nek.in.cn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Herbert Xu
> >  <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
> >  Joerg Roedel <joro@8bytes.org>, Hao Fang <fanghao11@huawei.com>, Zhou Wang
> >  <wangzhou1@hisilicon.com>, Zaibo Xu <xuzaibo@huawei.com>, Philippe
> >  Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
> >  <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
> >  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
> >  linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
> >  kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org, Lu Baolu
> >  <baolu.lu@linux.intel.com>, Sanjay Kumar <sanjay.k.kumar@intel.com>,
> >  linuxarm@huawei.com
> > Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
> > User-Agent: Mutt/1.10.0 (2018-05-17)
> > Message-ID: <20180906133133.GA3830@redhat.com>
> > 
> > On Thu, Sep 06, 2018 at 05:45:32PM +0800, Kenneth Lee wrote:
> > > On Tue, Sep 04, 2018 at 10:15:09AM -0600, Alex Williamson wrote:
> > > > Date: Tue, 4 Sep 2018 10:15:09 -0600
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > To: Jerome Glisse <jglisse@redhat.com>
> > > > CC: Kenneth Lee <nek.in.cn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
> > > >  Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
> > > >  <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>, Kenneth Lee
> > > >  <liguozhu@hisilicon.com>, Hao Fang <fanghao11@huawei.com>, Zhou Wang
> > > >  <wangzhou1@hisilicon.com>, Zaibo Xu <xuzaibo@huawei.com>, Philippe
> > > >  Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
> > > >  <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
> > > >  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
> > > >  linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
> > > >  kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org, Lu Baolu
> > > >  <baolu.lu@linux.intel.com>, Sanjay Kumar <sanjay.k.kumar@intel.com>,
> > > >  linuxarm@huawei.com
> > > > Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
> > > > Message-ID: <20180904101509.62314b67@t450s.home>
> > > > 
> > > > On Tue, 4 Sep 2018 11:00:19 -0400
> > > > Jerome Glisse <jglisse@redhat.com> wrote:
> > > > 
> > > > > On Mon, Sep 03, 2018 at 08:51:57AM +0800, Kenneth Lee wrote:
> > > > > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > > > > > 
> > > > > > WarpDrive is an accelerator framework to expose the hardware capabilities
> > > > > > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > > > > > facilities. So the user application can send request and DMA to the
> > > > > > hardware without interaction with the kernel. This removes the latency
> > > > > > of syscall.
> > > > > > 
> > > > > > WarpDrive is the name for the whole framework. The component in kernel
> > > > > > is called SDMDEV, Share Domain Mediated Device. Driver driver exposes its
> > > > > > hardware resource by registering to SDMDEV as a VFIO-Mdev. So the user
> > > > > > library of WarpDrive can access it via VFIO interface.
> > > > > > 
> > > > > > The patchset contains document for the detail. Please refer to it for more
> > > > > > information.
> > > > > > 
> > > > > > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > > > > > patch [1], which enables not only IO side page fault, but also PASID
> > > > > > support to IOMMU and VFIO.
> > > > > > 
> > > > > > With these features, WarpDrive can support non-pinned memory and
> > > > > > multi-process in the same accelerator device.  We tested it in our SoC
> > > > > > integrated Accelerator (board ID: D06, Chip ID: HIP08). A reference work
> > > > > > tree can be found here: [2].
> > > > > > 
> > > > > > But it is not mandatory. This patchset is tested in the latest mainline
> > > > > > kernel without the SVA patches.  So it supports only one process for each
> > > > > > accelerator.
> > > > > > 
> > > > > > We have noticed the IOMMU aware mdev RFC announced recently [3].
> > > > > > 
> > > > > > The IOMMU aware mdev has similar idea but different intention comparing to
> > > > > > WarpDrive. It intends to dedicate part of the hardware resource to a VM.
> > > > > > And the design is supposed to be used with Scalable I/O Virtualization.
> > > > > > While sdmdev is intended to share the hardware resource with a big amount
> > > > > > of processes.  It just requires the hardware supporting address
> > > > > > translation per process (PCIE's PASID or ARM SMMU's substream ID).
> > > > > > 
> > > > > > But we don't see serious confliction on both design. We believe they can be
> > > > > > normalized as one.
> > > > > >   
> > > > > 
> > > > > So once again i do not understand why you are trying to do things
> > > > > this way. Kernel already have tons of example of everything you
> > > > > want to do without a new framework. Moreover i believe you are
> > > > > confuse by VFIO. To me VFIO is for VM not to create general device
> > > > > driver frame work.
> > > > 
> > > > VFIO is a userspace driver framework, the VM use case just happens to
> > > > be a rather prolific one.  VFIO was never intended to be solely a VM
> > > > device interface and has several other userspace users, notably DPDK
> > > > and SPDK, an NVMe backend in QEMU, a userspace NVMe driver, a ruby
> > > > wrapper, and perhaps others that I'm not aware of.  Whether vfio is
> > > > appropriate interface here might certainly still be a debatable topic,
> > > > but I would strongly disagree with your last sentence above.  Thanks,
> > > > 
> > > > Alex
> > > > 
> > > 
> > > Yes, that is also my standpoint here.
> > > 
> > > > > So here is your use case as i understand it. You have a device
> > > > > with a limited number of command queues (can be just one) and in
> > > > > some case it can support SVA/SVM (when hardware support it and it
> > > > > is not disabled). Final requirement is being able to schedule cmds
> > > > > from userspace without ioctl. All of this exists already exists
> > > > > upstream in few device drivers.
> > > > > 
> > > > > 
> > > > > So here is how every body else is doing it. Please explain why
> > > > > this does not work.
> > > > > 
> > > > > 1 Userspace open device file driver. Kernel device driver create
> > > > >   a context and associate it with on open. This context can be
> > > > >   uniq to the process and can bind hardware resources (like a
> > > > >   command queue) to the process.
> > > > > 2 Userspace bind/acquire a commands queue and initialize it with
> > > > >   an ioctl on the device file. Through that ioctl userspace can
> > > > >   be inform wether either SVA/SVM works for the device. If SVA/
> > > > >   SVM works then kernel device driver bind the process to the
> > > > >   device as part of this ioctl.
> > > > > 3 If SVM/SVA does not work userspace do an ioctl to create dma
> > > > >   buffer or something that does exactly the same thing.
> > > > > 4 Userspace mmap the command queue (mmap of the device file by
> > > > >   using informations gather at step 2)
> > > > > 5 Userspace can write commands into the queue it mapped
> > > > > 6 When userspace close the device file all resources are release
> > > > >   just like any existing device drivers.
> > > 
> > > Hi, Jerome,
> > > 
> > > Just one thing, as I said in the cover letter, dma-buf requires the application
> > > to use memory created by the driver for DMA. I did try the dma-buf way in
> > > WrapDrive (refer to [4] in the cover letter), it is a good backup for NOIOMMU
> > > mode or we cannot solve the problem in VFIO.
> > > 
> > > But, in many of my application scenario, the application already has some memory
> > > in hand, maybe allocated by the framework or libraries. Anyway, they don't get
> > > memory from my library, and they pass the poiter for data operation. And they
> > > may also have pointer in the buffer. Those pointer may be used by the
> > > accelerator. So I need hardware fully share the address space with the
> > > application. That is what dmabuf cannot do.
> > 
> > dmabuf can do that ... it is call uptr you can look at i915 for
> > instance. Still this does not answer my question above, why do
> > you need to be in VFIO to do any of the above thing ? Kernel has
> > tons of examples that does all of the above and are not in VFIO
> > (including usinng existing user pointer with device).
> > 
> > Cheers,
> > Jérôme
> 
> I took a look at i915_gem_execbuffer_ioctl(). It seems it "copy_from_user" the
> user memory to the kernel. That is not what we need. What we try to get is: the
> user application do something on its data, and push it away to the accelerator,
> and says: "I'm tied, it is your turn to do the job...". Then the accelerator has
> the memory, referring any portion of it with the same VAs of the application,
> even the VAs are stored inside the memory itself.

You were not looking at right place see drivers/gpu/drm/i915/i915_gem_userptr.c
It does GUP and create GEM object AFAICR you can wrap that GEM object into a
dma buffer object.

> 
> And I don't understand why I should avoid to use VFIO? As Alex said, VFIO is the
> user driver framework. And I need exactly a user driver interface. Why should I
> invent another wheel? It has most of stuff I need:
> 
> 1. Connecting multiple devices to the same application space
> 2. Pinning and DMA from the application space to the whole set of device
> 3. Managing hardware resource by device
> 
> We just need the last step: make sure multiple applications and the kernel can
> share the same IOMMU. Then why shouldn't we use VFIO?

Because tons of other drivers already do all of the above outside VFIO. Many
driver have a sizeable userspace side to them (anything with ioctl do) so they
can be construded as userspace driver too.

So there is no reasons to do that under VFIO. Especialy as in your example
it is not a real user space device driver, the userspace portion only knows
about writting command into command buffer AFAICT.

VFIO is for real userspace driver where interrupt, configurations, ... ie
all the driver is handled in userspace. This means that the userspace have
to be trusted as it could program the device to do DMA to anywhere (if
IOMMU is disabled at boot which is still the default configuration in the
kernel).

So i do not see any reasons to do anything you want inside VFIO. All you
want to do can be done outside as easily. Moreover it would be better if
you define clearly each scenario because from where i sit it looks like
you are opening the door wide open to userspace to DMA anywhere when IOMMU
is disabled.

When IOMMU is disabled you can _not_ expose command queue to userspace
unless your device has its own page table and all commands are relative
to that page table and the device page table is populated by kernel driver
in secure way (ie by checking that what is populated can be access).

I do not believe your example device to have such page table nor do i see
a fallback path when IOMMU is disabled that force user to do ioctl for
each commands.

Yes i understand that you target SVA/SVM but still you claim to support
non SVA/SVM. The point is that userspace can not be trusted if you want
to have random program use your device. I am pretty sure that all user
of VFIO are trusted process (like QEMU).


Finaly i am convince that the IOMMU grouping stuff related to VFIO is
useless for your usecase. I really do not see the point of that, it
does complicate things for you for no reasons AFAICT.


> 
> And personally, I believe the maturity and correctness of a framework are driven
> by applications. Now the problem in accelerator world is that we don't have a
> direction. If we believe the requirement is right, the method itself is not a
> big problem in the end. We just need to let people have a unify platform to
> share their work together.

I am not against that but it seems to me that all you want to do is only
a matter of simplifying discovery of such devices and sharing few common
ioctl (DMA mapping, creating command queue, managing command queue, ...)
and again for all this i do not see the point of doing this under VFIO.


Cheers,
Jérôme
