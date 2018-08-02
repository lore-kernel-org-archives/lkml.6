Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51688C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5EB20894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5EB20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeHBEsi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:48:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:28638 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeHBEsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:48:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 19:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,434,1526367600"; 
   d="scan'208";a="71882317"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2018 19:59:42 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 19:59:36 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 19:59:36 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Thu, 2 Aug 2018 10:59:33 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Topic: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Index: AQHUKYHSUTvc9I1u4EGviW0yiW9YHKSrv1Ww
Date:   Thu, 2 Aug 2018 02:59:33 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191290EB3@SHSMSX101.ccr.corp.intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
In-Reply-To: <20180801102221.5308-1-nek.in.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjZhMmE1MmItZDAyMS00NDRkLTllZTItNDIxOTNkZjRhNzJkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRmtrRWhDTG9GbVZOclNBbFE4U0NYeEd0aHE0VTQ4ODA4K3BkNnFHSVpueXZibXlxYXc1aVwvQTRQRitxY0JrRmkifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kenneth Lee
> Sent: Wednesday, August 1, 2018 6:22 PM
> 
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> WarpDrive is an accelerator framework to expose the hardware capabilities
> directly to the user space. It makes use of the exist vfio and vfio-mdev
> facilities. So the user application can send request and DMA to the
> hardware without interaction with the kernel. This remove the latency
> of syscall and context switch.
> 
> The patchset contains documents for the detail. Please refer to it for more
> information.
> 
> This patchset is intended to be used with Jean Philippe Brucker's SVA
> patch [1] (Which is also in RFC stage). But it is not mandatory. This
> patchset is tested in the latest mainline kernel without the SVA patches.
> So it support only one process for each accelerator.

If no sharing, then why not just assigning the whole parent device to
the process? IMO if SVA usage is the clear goal of your series, it
might be made clearly so then Jean's series is mandatory dependency...

> 
> With SVA support, WarpDrive can support multi-process in the same
> accelerator device.  We tested it in our SoC integrated Accelerator (board
> ID: D06, Chip ID: HIP08). A reference work tree can be found here: [2].
> 
> We have noticed the IOMMU aware mdev RFC announced recently [3].
> 
> The IOMMU aware mdev has similar idea but different intention comparing
> to
> WarpDrive. It intends to dedicate part of the hardware resource to a VM.

Not just to VM, though I/O Virtualization is in the name. You can assign
such mdev to either VMs, containers, or bare metal processes. It's just
a fully-isolated device from user space p.o.v.

> And the design is supposed to be used with Scalable I/O Virtualization.
> While spimdev is intended to share the hardware resource with a big
> amount
> of processes.  It just requires the hardware supporting address
> translation per process (PCIE's PASID or ARM SMMU's substream ID).
> 
> But we don't see serious confliction on both design. We believe they can be
> normalized as one.

yes there are something which can be shared, e.g. regarding to
the interface to IOMMU.

Conceptually I see them different mindset on device resource sharing:

WarpDrive more aims to provide a generic framework to enable SVA
usages on various accelerators, which lack of a well-abstracted user
API like OpenCL. SVA is a hardware capability - sort of exposing resources
composing ONE capability to user space through mdev framework. It is
not like a VF which naturally carries most capabilities as PF.

Intel Scalable I/O virtualization is a thorough design to partition the
device into minimal sharable copies (queue, queue pair, context), 
while each copy carries most PF capabilities (including SVA) similar to
VF. Also with IOMMU scalable mode support, the copy can be 
independently assigned to any client (process, container, VM, etc.)

Thanks
Kevin
