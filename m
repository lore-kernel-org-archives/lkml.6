Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948F9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4544C208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4544C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeHBEWP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:22:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:1702 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeHBEWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:22:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 19:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,434,1526367600"; 
   d="scan'208";a="78001840"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2018 19:33:15 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 19:33:15 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 19:33:14 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.173]) with mapi id 14.03.0319.002;
 Thu, 2 Aug 2018 10:33:12 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Kenneth Lee <nek.in.cn@gmail.com>
CC:     Hao Fang <fanghao11@huawei.com>,
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
        Kenneth Lee <liguozhu@hisilicon.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>
Subject: RE: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Topic: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Index: AQHUKYHSUTvc9I1u4EGviW0yiW9YHKSqmCAAgAElIaA=
Date:   Thu, 2 Aug 2018 02:33:12 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191290E1A@SHSMSX101.ccr.corp.intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801165644.GA3820@redhat.com>
In-Reply-To: <20180801165644.GA3820@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzgyNTFlMTUtNTFkNi00NjAyLWE0YTctMjZmNzIxMjQ3NmE3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRFNmcW5FQ2t4eUxqSjZrOVlqOWxRdkMyK0R6RGtCZ29sM3VEYURrazh3M0xudkhOaXpEK3dSd3ZBcW9NSW43OSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jerome Glisse
> Sent: Thursday, August 2, 2018 12:57 AM
> 
> On Wed, Aug 01, 2018 at 06:22:14PM +0800, Kenneth Lee wrote:
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> >
> > WarpDrive is an accelerator framework to expose the hardware
> capabilities
> > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > facilities. So the user application can send request and DMA to the
> > hardware without interaction with the kernel. This remove the latency
> > of syscall and context switch.
> >
> > The patchset contains documents for the detail. Please refer to it for
> more
> > information.
> >
> > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > patch [1] (Which is also in RFC stage). But it is not mandatory. This
> > patchset is tested in the latest mainline kernel without the SVA patches.
> > So it support only one process for each accelerator.
> >
> > With SVA support, WarpDrive can support multi-process in the same
> > accelerator device.  We tested it in our SoC integrated Accelerator (board
> > ID: D06, Chip ID: HIP08). A reference work tree can be found here: [2].
> 
> I have not fully inspected things nor do i know enough about
> this Hisilicon ZIP accelerator to ascertain, but from glimpsing
> at the code it seems that it is unsafe to use even with SVA due
> to the doorbell. There is a comment talking about safetyness
> in patch 7.
> 
> Exposing thing to userspace is always enticing, but if it is
> a security risk then it should clearly say so and maybe a
> kernel boot flag should be necessary to allow such device to
> be use.
> 
> 
> My more general question is do we want to grow VFIO to become
> a more generic device driver API. This patchset adds a command
> queue concept to it (i don't think it exist today but i have
> not follow VFIO closely).
> 
> Why is that any better that existing driver model ? Where a
> device create a device file (can be character device, block
> device, ...). Such models also allow for direct hardware
> access from userspace. For instance see the AMD KFD driver
> inside drivers/gpu/drm/amd

One motivation I guess, is that most accelerators lack of a 
well-abstracted high level APIs similar to GPU side (e.g. OpenCL 
clearly defines Shared Virtual Memory models). VFIO mdev
might be an alternative common interface to enable SVA usages 
on various accelerators...

> 
> So you can already do what you are doing with the Hisilicon
> driver today without this new infrastructure. This only need
> hardware that have command queue and doorbell like mechanisms.
> 
> 
> Unlike mdev which unify a very high level concept, it seems
> to me spimdev just introduce low level concept (namely command
> queue) and i don't see the intrinsic value here.
> 
> 
> Cheers,
> Jérôme
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
