Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D824C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90CB20894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90CB20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeHBFak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:30:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34977 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbeHBFaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:30:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4A4AEE14380B;
        Thu,  2 Aug 2018 11:41:32 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 2 Aug 2018
 11:41:24 +0800
Date:   Thu, 2 Aug 2018 11:40:06 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180802034006.GJ160746@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290EB3@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191290EB3@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 02:59:33AM +0000, Tian, Kevin wrote:
> Date: Thu, 2 Aug 2018 02:59:33 +0000
> From: "Tian, Kevin" <kevin.tian@intel.com>
> To: Kenneth Lee <nek.in.cn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
>  Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
>  <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>, Alex Williamson
>  <alex.williamson@redhat.com>, Kenneth Lee <liguozhu@hisilicon.com>, Hao
>  Fang <fanghao11@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>, Zaibo Xu
>  <xuzaibo@huawei.com>, Philippe Ombredanne <pombredanne@nexb.com>, Greg
>  Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
>  <tglx@linutronix.de>, "linux-doc@vger.kernel.org"
>  <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
>  <linux-kernel@vger.kernel.org>, "linux-crypto@vger.kernel.org"
>  <linux-crypto@vger.kernel.org>, "iommu@lists.linux-foundation.org"
>  <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org"
>  <kvm@vger.kernel.org>, "linux-accelerators@lists.ozlabs.org"
>  <linux-accelerators@lists.ozlabs.org>, Lu Baolu
>  <baolu.lu@linux.intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
> CC: "linuxarm@huawei.com" <linuxarm@huawei.com>
> Subject: RE: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
> Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191290EB3@SHSMSX101.ccr.corp.intel.com>
> 
> > From: Kenneth Lee
> > Sent: Wednesday, August 1, 2018 6:22 PM
> > 
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> > 
> > WarpDrive is an accelerator framework to expose the hardware capabilities
> > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > facilities. So the user application can send request and DMA to the
> > hardware without interaction with the kernel. This remove the latency
> > of syscall and context switch.
> > 
> > The patchset contains documents for the detail. Please refer to it for more
> > information.
> > 
> > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > patch [1] (Which is also in RFC stage). But it is not mandatory. This
> > patchset is tested in the latest mainline kernel without the SVA patches.
> > So it support only one process for each accelerator.
> 
> If no sharing, then why not just assigning the whole parent device to
> the process? IMO if SVA usage is the clear goal of your series, it
> might be made clearly so then Jean's series is mandatory dependency...
> 

We don't know how SVA will be finally. But the feature, "make use of
per-PASID/substream ID IOMMU page table", should be able to be enabled in the
kernel. So we don't want to enforce it here. After we have this serial ready, it
can be hooked to any implementation.

Further more, even without "per-PASID IOMMU page table", this series has its
value. It is not simply dedicate the whole device to the process. It "shares"
the device with the kernel driver. So you can support crypto and a user
application at the same time.

> > 
> > With SVA support, WarpDrive can support multi-process in the same
> > accelerator device.  We tested it in our SoC integrated Accelerator (board
> > ID: D06, Chip ID: HIP08). A reference work tree can be found here: [2].
> > 
> > We have noticed the IOMMU aware mdev RFC announced recently [3].
> > 
> > The IOMMU aware mdev has similar idea but different intention comparing
> > to
> > WarpDrive. It intends to dedicate part of the hardware resource to a VM.
> 
> Not just to VM, though I/O Virtualization is in the name. You can assign
> such mdev to either VMs, containers, or bare metal processes. It's just
> a fully-isolated device from user space p.o.v.

Oh, yes. Thank you for clarification.

> 
> > And the design is supposed to be used with Scalable I/O Virtualization.
> > While spimdev is intended to share the hardware resource with a big
> > amount
> > of processes.  It just requires the hardware supporting address
> > translation per process (PCIE's PASID or ARM SMMU's substream ID).
> > 
> > But we don't see serious confliction on both design. We believe they can be
> > normalized as one.
> 
> yes there are something which can be shared, e.g. regarding to
> the interface to IOMMU.
> 
> Conceptually I see them different mindset on device resource sharing:
> 
> WarpDrive more aims to provide a generic framework to enable SVA
> usages on various accelerators, which lack of a well-abstracted user
> API like OpenCL. SVA is a hardware capability - sort of exposing resources
> composing ONE capability to user space through mdev framework. It is
> not like a VF which naturally carries most capabilities as PF.
> 

Yes. But we believe the user abstraction layer will be enabled soon when the
channel is opened. WarpDrive gives the hardware the chance to serve the
application directly. For example, an AI engine can be called by many processes
for inference. The resource need not to be dedicated to one particular process.

> Intel Scalable I/O virtualization is a thorough design to partition the
> device into minimal sharable copies (queue, queue pair, context), 
> while each copy carries most PF capabilities (including SVA) similar to
> VF. Also with IOMMU scalable mode support, the copy can be 
> independently assigned to any client (process, container, VM, etc.)
> 
Yes, we can see this intension.
> Thanks
> Kevin

Thank you.

-- 
			-Kenneth(Hisilicon)
