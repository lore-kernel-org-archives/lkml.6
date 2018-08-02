Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F11C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0166921501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0166921501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbeHBQOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:14:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732202AbeHBQOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DAE772627;
        Thu,  2 Aug 2018 14:22:47 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D65AF2026D69;
        Thu,  2 Aug 2018 14:22:44 +0000 (UTC)
Date:   Thu, 2 Aug 2018 10:22:43 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Kenneth Lee <liguozhu@hisilicon.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <20180802142243.GA3481@redhat.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
 <20180802040557.GL160746@Turing-Arch-b>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180802040557.GL160746@Turing-Arch-b>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 14:22:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 14:22:47 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 12:05:57PM +0800, Kenneth Lee wrote:
> On Thu, Aug 02, 2018 at 02:33:12AM +0000, Tian, Kevin wrote:
> > Date: Thu, 2 Aug 2018 02:33:12 +0000
> > > From: Jerome Glisse
> > > On Wed, Aug 01, 2018 at 06:22:14PM +0800, Kenneth Lee wrote:
> > > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > > >
> > > > WarpDrive is an accelerator framework to expose the hardware
> > > capabilities
> > > > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > > > facilities. So the user application can send request and DMA to the
> > > > hardware without interaction with the kernel. This remove the latency
> > > > of syscall and context switch.
> > > >
> > > > The patchset contains documents for the detail. Please refer to it for
> > > more
> > > > information.
> > > >
> > > > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > > > patch [1] (Which is also in RFC stage). But it is not mandatory. This
> > > > patchset is tested in the latest mainline kernel without the SVA patches.
> > > > So it support only one process for each accelerator.
> > > >
> > > > With SVA support, WarpDrive can support multi-process in the same
> > > > accelerator device.  We tested it in our SoC integrated Accelerator (board
> > > > ID: D06, Chip ID: HIP08). A reference work tree can be found here: [2].
> > > 
> > > I have not fully inspected things nor do i know enough about
> > > this Hisilicon ZIP accelerator to ascertain, but from glimpsing
> > > at the code it seems that it is unsafe to use even with SVA due
> > > to the doorbell. There is a comment talking about safetyness
> > > in patch 7.
> > > 
> > > Exposing thing to userspace is always enticing, but if it is
> > > a security risk then it should clearly say so and maybe a
> > > kernel boot flag should be necessary to allow such device to
> > > be use.
> > > 
> 
> But doorbell is just a notification. Except for DOS (to make hardware busy) it
> cannot actually take or change anything from the kernel space. And the DOS
> problem can be always taken as the problem that a group of processes share the
> same kernel entity.
> 
> In the coming HIP09 hardware, the doorbell will come with a random number so
> only the process who allocated the queue can knock it correctly.

When doorbell is ring the hardware start fetching commands from
the queue and execute them ? If so than a rogue process B might
ring the doorbell of process A which would starts execution of
random commands (ie whatever random memory value there is left
inside the command buffer memory, could be old commands i guess).

If this is not how this doorbell works then, yes it can only do
a denial of service i guess. Issue i have with doorbell is that
i have seen 10 differents implementations in 10 differents hw
and each are different as to what ringing or value written to the
doorbell does. It is painfull to track what is what for each hw.


> > > My more general question is do we want to grow VFIO to become
> > > a more generic device driver API. This patchset adds a command
> > > queue concept to it (i don't think it exist today but i have
> > > not follow VFIO closely).
> > > 
> 
> The thing is, VFIO is the only place to support DMA from user land. If we don't
> put it here, we have to create another similar facility to support the same.

No it is not, network device, GPU, block device, ... they all do
support DMA. The point i am trying to make here is that even in
your mechanisms the userspace must have a specific userspace
drivers for each hardware and thus there are virtually no
differences between having this userspace driver open a device
file in vfio or somewhere else in the device filesystem. This is
just a different path.

So this is why i do not see any benefit to having all drivers with
SVM (can we please use SVM and not SVA as SVM is what have been use
in more places so far).


Cheers,
Jérôme
