Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0082CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90AF208D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90AF208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeHBF4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:56:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59105 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbeHBF4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:56:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A15245EE55BE4;
        Thu,  2 Aug 2018 12:07:21 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 2 Aug 2018
 12:07:15 +0800
Date:   Thu, 2 Aug 2018 12:05:57 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        "Hao Fang" <fanghao11@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180802040557.GL160746@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 02:33:12AM +0000, Tian, Kevin wrote:
> Date: Thu, 2 Aug 2018 02:33:12 +0000
> From: "Tian, Kevin" <kevin.tian@intel.com>
> To: Jerome Glisse <jglisse@redhat.com>, Kenneth Lee <nek.in.cn@gmail.com>
> CC: Hao Fang <fanghao11@huawei.com>, Herbert Xu
>  <herbert@gondor.apana.org.au>, "kvm@vger.kernel.org"
>  <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg
>  Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-doc@vger.kernel.org"
>  <linux-doc@vger.kernel.org>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
>  "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
>  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
>  "linuxarm@huawei.com" <linuxarm@huawei.com>, Alex Williamson
>  <alex.williamson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
>  "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, Philippe
>  Ombredanne <pombredanne@nexb.com>, Zaibo Xu <xuzaibo@huawei.com>, Kenneth
>  Lee <liguozhu@hisilicon.com>, "David S . Miller" <davem@davemloft.net>,
>  "linux-accelerators@lists.ozlabs.org"
>  <linux-accelerators@lists.ozlabs.org>
> Subject: RE: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
> Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
> 
> > From: Jerome Glisse
> > Sent: Thursday, August 2, 2018 12:57 AM
> > 
> > On Wed, Aug 01, 2018 at 06:22:14PM +0800, Kenneth Lee wrote:
> > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > >
> > > WarpDrive is an accelerator framework to expose the hardware
> > capabilities
> > > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > > facilities. So the user application can send request and DMA to the
> > > hardware without interaction with the kernel. This remove the latency
> > > of syscall and context switch.
> > >
> > > The patchset contains documents for the detail. Please refer to it for
> > more
> > > information.
> > >
> > > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > > patch [1] (Which is also in RFC stage). But it is not mandatory. This
> > > patchset is tested in the latest mainline kernel without the SVA patches.
> > > So it support only one process for each accelerator.
> > >
> > > With SVA support, WarpDrive can support multi-process in the same
> > > accelerator device.  We tested it in our SoC integrated Accelerator (board
> > > ID: D06, Chip ID: HIP08). A reference work tree can be found here: [2].
> > 
> > I have not fully inspected things nor do i know enough about
> > this Hisilicon ZIP accelerator to ascertain, but from glimpsing
> > at the code it seems that it is unsafe to use even with SVA due
> > to the doorbell. There is a comment talking about safetyness
> > in patch 7.
> > 
> > Exposing thing to userspace is always enticing, but if it is
> > a security risk then it should clearly say so and maybe a
> > kernel boot flag should be necessary to allow such device to
> > be use.
> > 

But doorbell is just a notification. Except for DOS (to make hardware busy) it
cannot actually take or change anything from the kernel space. And the DOS
problem can be always taken as the problem that a group of processes share the
same kernel entity.

In the coming HIP09 hardware, the doorbell will come with a random number so
only the process who allocated the queue can knock it correctly.
> > 
> > My more general question is do we want to grow VFIO to become
> > a more generic device driver API. This patchset adds a command
> > queue concept to it (i don't think it exist today but i have
> > not follow VFIO closely).
> > 

The thing is, VFIO is the only place to support DMA from user land. If we don't
put it here, we have to create another similar facility to support the same.

> > Why is that any better that existing driver model ? Where a
> > device create a device file (can be character device, block
> > device, ...). Such models also allow for direct hardware
> > access from userspace. For instance see the AMD KFD driver
> > inside drivers/gpu/drm/amd
> 
> One motivation I guess, is that most accelerators lack of a 
> well-abstracted high level APIs similar to GPU side (e.g. OpenCL 
> clearly defines Shared Virtual Memory models). VFIO mdev
> might be an alternative common interface to enable SVA usages 
> on various accelerators...
> 
Yes.
> > 
> > So you can already do what you are doing with the Hisilicon
> > driver today without this new infrastructure. This only need
> > hardware that have command queue and doorbell like mechanisms.
> > 
> > 
> > Unlike mdev which unify a very high level concept, it seems
> > to me spimdev just introduce low level concept (namely command
> > queue) and i don't see the intrinsic value here.
> > 
As I have said, VFIO is the only place support DMA from user space now.
> > 
> > Cheers,
> > Jérôme
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu

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

