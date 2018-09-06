Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA96C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01686206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01686206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeIFNsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:48:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728035AbeIFNsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:48:01 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0CBEB5BDB6669;
        Thu,  6 Sep 2018 17:13:28 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 6 Sep 2018
 17:13:23 +0800
Date:   Thu, 6 Sep 2018 17:11:35 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
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
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kvm@vger.kernel.org>, <linux-accelerators@lists.ozlabs.org>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, <linuxarm@huawei.com>
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180906091135.GF230707@Turing-Arch-b>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <81edb8ff-d046-34e5-aee7-d8564e2517c2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81edb8ff-d046-34e5-aee7-d8564e2517c2@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 10:32:16AM +0800, Lu Baolu wrote:
> Date: Mon, 3 Sep 2018 10:32:16 +0800
> From: Lu Baolu <baolu.lu@linux.intel.com>
> To: Kenneth Lee <nek.in.cn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
>  Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
>  <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>, Alex Williamson
>  <alex.williamson@redhat.com>, Kenneth Lee <liguozhu@hisilicon.com>, Hao
>  Fang <fanghao11@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>, Zaibo Xu
>  <xuzaibo@huawei.com>, Philippe Ombredanne <pombredanne@nexb.com>, Greg
>  Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
>  <tglx@linutronix.de>, linux-doc@vger.kernel.org,
>  linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
>  iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
>  linux-accelerators@lists.ozlabs.org, Sanjay Kumar
>  <sanjay.k.kumar@intel.com>
> CC: baolu.lu@linux.intel.com, linuxarm@huawei.com
> Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
>  Thunderbird/52.9.1
> Message-ID: <81edb8ff-d046-34e5-aee7-d8564e2517c2@linux.intel.com>
> 
> Hi,
> 
> On 09/03/2018 08:51 AM, Kenneth Lee wrote:
> >From: Kenneth Lee <liguozhu@hisilicon.com>
> >
> >WarpDrive is an accelerator framework to expose the hardware capabilities
> >directly to the user space. It makes use of the exist vfio and vfio-mdev
> >facilities. So the user application can send request and DMA to the
> >hardware without interaction with the kernel. This removes the latency
> >of syscall.
> >
> >WarpDrive is the name for the whole framework. The component in kernel
> >is called SDMDEV, Share Domain Mediated Device. Driver driver exposes its
> >hardware resource by registering to SDMDEV as a VFIO-Mdev. So the user
> >library of WarpDrive can access it via VFIO interface.
> >
> >The patchset contains document for the detail. Please refer to it for more
> >information.
> >
> >This patchset is intended to be used with Jean Philippe Brucker's SVA
> >patch [1], which enables not only IO side page fault, but also PASID
> >support to IOMMU and VFIO.
> >
> >With these features, WarpDrive can support non-pinned memory and
> >multi-process in the same accelerator device.  We tested it in our SoC
> >integrated Accelerator (board ID: D06, Chip ID: HIP08). A reference work
> >tree can be found here: [2].
> >
> >But it is not mandatory. This patchset is tested in the latest mainline
> >kernel without the SVA patches.  So it supports only one process for each
> >accelerator.
> >
> >We have noticed the IOMMU aware mdev RFC announced recently [3].
> >
> >The IOMMU aware mdev has similar idea but different intention comparing to
> >WarpDrive. It intends to dedicate part of the hardware resource to a VM.
> >And the design is supposed to be used with Scalable I/O Virtualization.
> >While sdmdev is intended to share the hardware resource with a big amount
> >of processes.  It just requires the hardware supporting address
> >translation per process (PCIE's PASID or ARM SMMU's substream ID).
> >
> >But we don't see serious confliction on both design. We believe they can be
> >normalized as one.
> >
> >The patch 1 is document of the framework. The patch 2 and 3 add sdmdev
> >support. The patch 4, 5 and 6 is drivers for Hislicon's ZIP Accelerator
> >which is registered to both crypto and warpdrive(sdmdev) and can be
> >used from kernel or user space at the same time. The patch 7 is a user
> >space sample demonstrating how WarpDrive works.
> >
> >
> >Change History:
> >V2 changed from V1:
> >	1. Change kernel framework name from SPIMDEV (Share Parent IOMMU
> >	   Mdev) to SDMDEV (Share Domain Mdev).
> >	2. Allocate Hardware Resource when a new mdev is created (While
> >	   it is allocated when the mdev is openned)
> >	3. Unmap pages from the shared domain when the sdmdev iommu group is
> >	   detached. (This procedure is necessary, but missed in V1)
> >	4. Update document accordingly.
> >	5. Rebase to the latest kernel (4.19.0-rc1)
> >	
> >	According the review comment on RFCv1, We did try to use dma-buf
> >	as back end of WarpDrive. It can work properly with the current
> >	solution [4], but it cannot make use of process's
> >	own memory address space directly. This is important to many
> >	acceleration scenario. So dma-buf will be taken as a backup
> >	alternative for noiommu scenario, it will be added in the future
> >	version.
> >
> >
> >Refernces:
> >[1] https://www.spinics.net/lists/kernel/msg2651481.html
> >[2] https://github.com/Kenneth-Lee/linux-kernel-warpdrive/tree/warpdrive-sva-v0.5
> >[3] https://lkml.org/lkml/2018/7/22/34
> 
> Please refer to the latest version posted here for discussion.
> 
> https://lkml.org/lkml/2018/8/30/107

Sure. Thank you.

> 
> Best regards,
> Lu Baolu

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

