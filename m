Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C25321A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C25321A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeHHRit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:38:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbeHHRit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:38:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4108E87A77;
        Wed,  8 Aug 2018 15:18:40 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFCB520180F4;
        Wed,  8 Aug 2018 15:18:36 +0000 (UTC)
Date:   Wed, 8 Aug 2018 11:18:35 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Kenneth Lee <nek.in.cn@gmail.com>
Cc:     Kenneth Lee <liguozhu@hisilicon.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zaibo Xu <xuzaibo@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Hao Fang <fanghao11@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180808151835.GA3429@redhat.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802040557.GL160746@Turing-Arch-b>
 <20180802142243.GA3481@redhat.com>
 <20180803034721.GC91035@Turing-Arch-b>
 <20180803143944.GA4079@redhat.com>
 <20180806031252.GG91035@Turing-Arch-b>
 <20180806153257.GB6002@redhat.com>
 <11bace0e-dc14-5d2c-f65c-25b852f4e9ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11bace0e-dc14-5d2c-f65c-25b852f4e9ca@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 08 Aug 2018 15:18:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 08 Aug 2018 15:18:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 09:08:42AM +0800, Kenneth Lee wrote:
> 
> 
> 在 2018年08月06日 星期一 11:32 下午, Jerome Glisse 写道:
> > On Mon, Aug 06, 2018 at 11:12:52AM +0800, Kenneth Lee wrote:
> > > On Fri, Aug 03, 2018 at 10:39:44AM -0400, Jerome Glisse wrote:
> > > > On Fri, Aug 03, 2018 at 11:47:21AM +0800, Kenneth Lee wrote:
> > > > > On Thu, Aug 02, 2018 at 10:22:43AM -0400, Jerome Glisse wrote:
> > > > > > On Thu, Aug 02, 2018 at 12:05:57PM +0800, Kenneth Lee wrote:
> > > > > > > On Thu, Aug 02, 2018 at 02:33:12AM +0000, Tian, Kevin wrote:
> > > > > > > > > On Wed, Aug 01, 2018 at 06:22:14PM +0800, Kenneth Lee wrote:

[...]

> > > > > > > > > My more general question is do we want to grow VFIO to become
> > > > > > > > > a more generic device driver API. This patchset adds a command
> > > > > > > > > queue concept to it (i don't think it exist today but i have
> > > > > > > > > not follow VFIO closely).
> > > > > > > > > 
> > > > > > > The thing is, VFIO is the only place to support DMA from user land. If we don't
> > > > > > > put it here, we have to create another similar facility to support the same.
> > > > > > No it is not, network device, GPU, block device, ... they all do
> > > > > > support DMA. The point i am trying to make here is that even in
> > > > > Sorry, wait a minute, are we talking the same thing? I meant "DMA from user
> > > > > land", not "DMA from kernel driver". To do that we have to manipulate the
> > > > > IOMMU(Unit). I think it can only be done by default_domain or vfio domain. Or
> > > > > the user space have to directly access the IOMMU.
> > > > GPU do DMA in the sense that you pass to the kernel a valid
> > > > virtual address (kernel driver do all the proper check) and
> > > > then you can use the GPU to copy from or to that range of
> > > > virtual address. Exactly how you want to use this compression
> > > > engine. It does not rely on SVM but SVM going forward would
> > > > still be the prefered option.
> > > > 
> > > No, SVM is not the reason why we rely on Jean's SVM(SVA) series. We rely on
> > > Jean's series because of multi-process (PASID or substream ID) support.
> > > 
> > > But of couse, WarpDrive can still benefit from the SVM feature.
> > We are getting side tracked here. PASID/ID do not require VFIO.
> > 
> Yes, PASID itself do not require VFIO. But what if:
> 
> 1. Support DMA from user space.
> 2. The hardware makes use of standard IOMMU/SMMU for IO address translation.
> 3. The IOMMU facility is shared by both kernel and user drivers.
> 4. Support PASID with the current IOMMU facility

I do not see how any of this means it has to be in VFIO.
Other devices do just that. GPUs driver for instance share
DMA engine (that copy data around) between kernel and user
space. Sometime kernel use it to move things around. Evict
some memory to make room for a new process is the common
example. Same DMA engines is often use by userspace itself
during rendering or compute (program moving things on there
own). So they are already kernel driver that do all 4 of
the above and are not in VFIO.


> > > > > > your mechanisms the userspace must have a specific userspace
> > > > > > drivers for each hardware and thus there are virtually no
> > > > > > differences between having this userspace driver open a device
> > > > > > file in vfio or somewhere else in the device filesystem. This is
> > > > > > just a different path.
> > > > > > 
> > > > > The basic problem WarpDrive want to solve it to avoid syscall. This is important
> > > > > to accelerators. We have some data here:
> > > > > https://www.slideshare.net/linaroorg/progress-and-demonstration-of-wrapdrive-a-accelerator-framework-sfo17317
> > > > > 
> > > > > (see page 3)
> > > > > 
> > > > > The performance is different on using kernel and user drivers.
> > > > Yes and example i point to is exactly that. You have a one time setup
> > > > cost (creating command buffer binding PASID with command buffer and
> > > > couple other setup steps). Then userspace no longer have to do any
> > > > ioctl to schedule work on the GPU. It is all down from userspace and
> > > > it use a doorbell to notify hardware when it should go look at command
> > > > buffer for new thing to execute.
> > > > 
> > > > My point stands on that. You have existing driver already doing so
> > > > with no new framework and in your scheme you need a userspace driver.
> > > > So i do not see the value add, using one path or the other in the
> > > > userspace driver is litteraly one line to change.
> > > > 
> > > Sorry, I'd got confuse here. I partially agree that the user driver is
> > > redundance of kernel driver. (But for WarpDrive, the kernel driver is a full
> > > driver include all preparation and setup stuff for the hardware, the user driver
> > > is simply to send request and receive answer). Yes, it is just a choice of path.
> > > But the user path is faster if the request come from use space. And to do that,
> > > we need user land DMA support. Then why is it invaluable to let VFIO involved?
> > Some drivers in the kernel already do exactly what you said. The user
> > space emit commands without ever going into kernel by directly scheduling
> > commands and ringing a doorbell. They do not need VFIO either and they
> > can map userspace address into the DMA address space of the device and
> > again they do not need VFIO for that.
> Could you please directly point out which driver you refer to here? Thank
> you.

drivers/gpu/drm/amd/

Sub-directory of interest is amdkfd

Because it is a big driver here is a highlevel overview of how it works
(this is a simplification):
  - Process can allocate GPUs buffer (through ioclt) and map them into
    its address space (through mmap of device file at buffer object
    specific offset).
  - Process can map any valid range of virtual address space into device
    address space (IOMMU mapping). This must be regular memory ie not an
    mmap of a device file or any special file (this is the non PASID
    path)
  - Process can create a command queue and bind its process to it aka
    PASID, this is done through an ioctl.
  - Process can schedule commands onto queues it created from userspace
    without ioctl. For that it just write command into a ring buffer
    that it mapped during the command queue creation process and it
    rings a doorbell when commands are ready to be consume by the
    hardware.
  - Commands can reference (access) all 3 types of object above ie
    either full GPUs buffer, process regular memory maped as object
    (non PASID) and PASID memory all at the same time ie you can
    mix all of the above in same commands queue.
  - Kernel can evict, unbind any process command queues, unbind commands
    queue are still valid from process point of view but commands
    process schedules on them will not be executed until kernel re-bind
    the queue.
  - Kernel can schedule commands itself onto its dedicated command
    queues (kernel driver create its own command queues).
  - Kernel can control priorities between all the queues ie it can
    decides which queues should the hardware executed first next.

I believe all of the above are the aspects that matters to you. The main
reason i don't like creating a new driver infrastructure is that a lot
of existing drivers will want to use some of the new features that are
coming (memory topology, where to place process memory, pipeline devices,
...) and thus existing drivers are big (GPU drivers are the biggest of
all the kernel drivers).

So rewritting those existing drivers into VFIO or into any new infra-
structure so that they can leverage new features is a no go from my
point of view.

I would rather see a set of helpers so that each features can be use
either by new drivers or existing drivers. For instance a new way to
expose memory topology. A new way to expose how you can pipe devices
from one to another ...


Hence i do not see any value in a whole new infra-structure in which
drivers must be part of to leverage new features.

Cheers,
Jérôme
