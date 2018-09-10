Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD59EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F8920645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F8920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeIJTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:48:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728282AbeIJTs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:48:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB341401EF0F;
        Mon, 10 Sep 2018 14:54:28 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 477A5112D184;
        Mon, 10 Sep 2018 14:54:24 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:54:23 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Kenneth Lee <liguozhu@hisilicon.com>
Cc:     Kenneth Lee <nek.in.cn@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, kvm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Hao Fang <fanghao11@huawei.com>, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180910145423.GA3488@redhat.com>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180904150019.GA4024@redhat.com>
 <20180904101509.62314b67@t450s.home>
 <20180906094532.GG230707@Turing-Arch-b>
 <20180906133133.GA3830@redhat.com>
 <20180907040138.GI230707@Turing-Arch-b>
 <20180907165303.GA3519@redhat.com>
 <20180910032809.GJ230707@Turing-Arch-b>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910032809.GJ230707@Turing-Arch-b>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 14:54:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 14:54:29 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:28:09AM +0800, Kenneth Lee wrote:
> On Fri, Sep 07, 2018 at 12:53:06PM -0400, Jerome Glisse wrote:
> > On Fri, Sep 07, 2018 at 12:01:38PM +0800, Kenneth Lee wrote:
> > > On Thu, Sep 06, 2018 at 09:31:33AM -0400, Jerome Glisse wrote:
> > > > On Thu, Sep 06, 2018 at 05:45:32PM +0800, Kenneth Lee wrote:
> > > > > On Tue, Sep 04, 2018 at 10:15:09AM -0600, Alex Williamson wrote:
> > > > > > On Tue, 4 Sep 2018 11:00:19 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> > > > > > > On Mon, Sep 03, 2018 at 08:51:57AM +0800, Kenneth Lee wrote:

[...]

> > > I took a look at i915_gem_execbuffer_ioctl(). It seems it "copy_from_user" the
> > > user memory to the kernel. That is not what we need. What we try to get is: the
> > > user application do something on its data, and push it away to the accelerator,
> > > and says: "I'm tied, it is your turn to do the job...". Then the accelerator has
> > > the memory, referring any portion of it with the same VAs of the application,
> > > even the VAs are stored inside the memory itself.
> > 
> > You were not looking at right place see drivers/gpu/drm/i915/i915_gem_userptr.c
> > It does GUP and create GEM object AFAICR you can wrap that GEM object into a
> > dma buffer object.
> > 
> 
> Thank you for directing me to this implementation. It is interesting:).
> 
> But it is not yet solve my problem. If I understand it right, the userptr in
> i915 do the following:
> 
> 1. The user process sets a user pointer with size to the kernel via ioctl.
> 2. The kernel wraps it as a dma-buf and keeps the process's mm for further
>    reference.
> 3. The user pages are allocated, GUPed or DMA mapped to the device. So the data
>    can be shared between the user space and the hardware.
> 
> But my scenario is: 
> 
> 1. The user process has some data in the user space, pointed by a pointer, say
>    ptr1. And within the memory, there may be some other pointers, let's say one
>    of them is ptr2.
> 2. Now I need to assign ptr1 *directly* to the hardware MMIO space. And the
>    hardware must refer ptr1 and ptr2 *directly* for data.
> 
> Userptr lets the hardware and process share the same memory space. But I need
> them to share the same *address space*. So IOMMU is a MUST for WarpDrive,
> NOIOMMU mode, as Jean said, is just for verifying some of the procedure is OK.

So to be 100% clear should we _ignore_ the non SVA/SVM case ?
If so then wait for necessary SVA/SVM to land and do warp drive
without non SVA/SVM path.

If you still want non SVA/SVM path what you want to do only works
if both ptr1 and ptr2 are in a range that is DMA mapped to the
device (moreover you need DMA address to match process address
which is not an easy feat).

Now even if you only want SVA/SVM, i do not see what is the point
of doing this inside VFIO. AMD GPU driver does not and there would
be no benefit for them to be there. Well a AMD VFIO mdev device
driver for QEMU guest might be useful but they have SVIO IIRC.

For SVA/SVM your usage model is:

Setup:
    - user space create a warp drive context for the process
    - user space create a device specific context for the process
    - user space create a user space command queue for the device
    - user space bind command queue

    At this point the kernel driver has bound the process address
    space to the device with a command queue and userspace

Usage:
    - user space schedule work and call appropriate flush/update
      ioctl from time to time. Might be optional depends on the
      hardware, but probably a good idea to enforce so that kernel
      can unbind the command queue to bind another process command
      queue.
    ...

Cleanup:
    - user space unbind command queue
    - user space destroy device specific context
    - user space destroy warp drive context
    All the above can be implicit when closing the device file.

So again in the above model i do not see anywhere something from
VFIO that would benefit this model.


> > > And I don't understand why I should avoid to use VFIO? As Alex said, VFIO is the
> > > user driver framework. And I need exactly a user driver interface. Why should I
> > > invent another wheel? It has most of stuff I need:
> > > 
> > > 1. Connecting multiple devices to the same application space
> > > 2. Pinning and DMA from the application space to the whole set of device
> > > 3. Managing hardware resource by device
> > > 
> > > We just need the last step: make sure multiple applications and the kernel can
> > > share the same IOMMU. Then why shouldn't we use VFIO?
> > 
> > Because tons of other drivers already do all of the above outside VFIO. Many
> > driver have a sizeable userspace side to them (anything with ioctl do) so they
> > can be construded as userspace driver too.
> > 
> 
> Ignoring if there are *tons* of drivers are doing that;), even I do the same as
> i915 and solve the address space problem. And if I don't need to with VFIO, why
> should I spend so much effort to do it again?

Because you do not need any code from VFIO, nor do you need to reinvent
things. If non SVA/SVM matters to you then use dma buffer. If not then
i do not see anything in VFIO that you need.


> > So there is no reasons to do that under VFIO. Especialy as in your example
> > it is not a real user space device driver, the userspace portion only knows
> > about writting command into command buffer AFAICT.
> > 
> > VFIO is for real userspace driver where interrupt, configurations, ... ie
> > all the driver is handled in userspace. This means that the userspace have
> > to be trusted as it could program the device to do DMA to anywhere (if
> > IOMMU is disabled at boot which is still the default configuration in the
> > kernel).
> > 
> 
> But as Alex explained, VFIO is not simply used by VM. So it need not to have all
> stuffs as a driver in host system. And I do need to share the user space as DMA
> buffer to the hardware. And I can get it with just a little update, then it can
> service me perfectly. I don't understand why I should choose a long route.

Again this is not the long route i do not see anything in VFIO that
benefit you in the SVA/SVM case. A basic character device driver can
do that.


> > So i do not see any reasons to do anything you want inside VFIO. All you
> > want to do can be done outside as easily. Moreover it would be better if
> > you define clearly each scenario because from where i sit it looks like
> > you are opening the door wide open to userspace to DMA anywhere when IOMMU
> > is disabled.
> > 
> > When IOMMU is disabled you can _not_ expose command queue to userspace
> > unless your device has its own page table and all commands are relative
> > to that page table and the device page table is populated by kernel driver
> > in secure way (ie by checking that what is populated can be access).
> > 
> > I do not believe your example device to have such page table nor do i see
> > a fallback path when IOMMU is disabled that force user to do ioctl for
> > each commands.
> > 
> > Yes i understand that you target SVA/SVM but still you claim to support
> > non SVA/SVM. The point is that userspace can not be trusted if you want
> > to have random program use your device. I am pretty sure that all user
> > of VFIO are trusted process (like QEMU).
> > 
> > 
> > Finaly i am convince that the IOMMU grouping stuff related to VFIO is
> > useless for your usecase. I really do not see the point of that, it
> > does complicate things for you for no reasons AFAICT.
> 
> Indeed, I don't like the group thing. I believe VFIO's maintains would not like
> it very much either;). But the problem is, the group reflects to the same
> IOMMU(unit), which may shared with other devices.  It is a security problem. I
> cannot ignore it. I have to take it into account event I don't use VFIO.

To me it seems you are making a policy decission in kernel space ie
wether the device should be isolated in its own group or not is a
decission that is up to the sys admin or something in userspace.
Right now existing user of SVA/SVM don't (at least AFAICT).

Do we really want to force such isolation ?


> > > And personally, I believe the maturity and correctness of a framework are driven
> > > by applications. Now the problem in accelerator world is that we don't have a
> > > direction. If we believe the requirement is right, the method itself is not a
> > > big problem in the end. We just need to let people have a unify platform to
> > > share their work together.
> > 
> > I am not against that but it seems to me that all you want to do is only
> > a matter of simplifying discovery of such devices and sharing few common
> > ioctl (DMA mapping, creating command queue, managing command queue, ...)
> > and again for all this i do not see the point of doing this under VFIO.
> 
> It is not a problem of device management, it is a problem of sharing address
> space.

This ties back to IOMMU SVA/SVM group isolation above.

Jérôme
