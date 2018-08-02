Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21D8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CC3208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CC3208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeHBH0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 03:26:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42597 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbeHBH0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 03:26:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 354B3FD63C14B;
        Thu,  2 Aug 2018 13:37:26 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 2 Aug 2018
 13:37:17 +0800
Date:   Thu, 2 Aug 2018 13:35:58 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Kenneth Lee <nek.in.cn@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Hao Fang <fanghao11@huawei.com>,
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
Message-ID: <20180802053558.GO160746@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290EB3@SHSMSX101.ccr.corp.intel.com>
 <20180802034006.GJ160746@Turing-Arch-b>
 <AADFC41AFE54684AB9EE6CBC0274A5D19129105A@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19129105A@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:36:52AM +0000, Tian, Kevin wrote:
> Date: Thu, 2 Aug 2018 04:36:52 +0000
> From: "Tian, Kevin" <kevin.tian@intel.com>
> To: Kenneth Lee <liguozhu@hisilicon.com>
> CC: Kenneth Lee <nek.in.cn@gmail.com>, Herbert Xu
>  <herbert@gondor.apana.org.au>, "kvm@vger.kernel.org"
>  <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg
>  Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-doc@vger.kernel.org"
>  <linux-doc@vger.kernel.org>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
>  Hao Fang <fanghao11@huawei.com>, "iommu@lists.linux-foundation.org"
>  <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
>  <linux-kernel@vger.kernel.org>, "linuxarm@huawei.com"
>  <linuxarm@huawei.com>, Alex Williamson <alex.williamson@redhat.com>,
>  Thomas Gleixner <tglx@linutronix.de>, "linux-crypto@vger.kernel.org"
>  <linux-crypto@vger.kernel.org>, Philippe Ombredanne
>  <pombredanne@nexb.com>, Zaibo Xu <xuzaibo@huawei.com>, "David S . Miller"
>  <davem@davemloft.net>, "linux-accelerators@lists.ozlabs.org"
>  <linux-accelerators@lists.ozlabs.org>
> Subject: RE: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
> Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19129105A@SHSMSX101.ccr.corp.intel.com>
> 
> > From: Kenneth Lee
> > Sent: Thursday, August 2, 2018 11:40 AM
> > 
> > On Thu, Aug 02, 2018 at 02:59:33AM +0000, Tian, Kevin wrote:
> > > > From: Kenneth Lee
> > > > Sent: Wednesday, August 1, 2018 6:22 PM
> > > >
> > > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > > >
> > > > WarpDrive is an accelerator framework to expose the hardware
> > capabilities
> > > > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > > > facilities. So the user application can send request and DMA to the
> > > > hardware without interaction with the kernel. This remove the latency
> > > > of syscall and context switch.
> > > >
> > > > The patchset contains documents for the detail. Please refer to it for
> > more
> > > > information.
> > > >
> > > > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > > > patch [1] (Which is also in RFC stage). But it is not mandatory. This
> > > > patchset is tested in the latest mainline kernel without the SVA patches.
> > > > So it support only one process for each accelerator.
> > >
> > > If no sharing, then why not just assigning the whole parent device to
> > > the process? IMO if SVA usage is the clear goal of your series, it
> > > might be made clearly so then Jean's series is mandatory dependency...
> > >
> > 
> > We don't know how SVA will be finally. But the feature, "make use of
> > per-PASID/substream ID IOMMU page table", should be able to be enabled
> > in the
> > kernel. So we don't want to enforce it here. After we have this serial ready,
> > it
> > can be hooked to any implementation.
> 
> "any" or "only queue-based" implementation? some devices may not
> have queue concept, e.g. GPU.

Here, "any implementation" refer to the "per PASID page table" implementatin:)

> 
> > 
> > Further more, even without "per-PASID IOMMU page table", this series has
> > its
> > value. It is not simply dedicate the whole device to the process. It "shares"
> > the device with the kernel driver. So you can support crypto and a user
> > application at the same time.
> 
> OK.
> 
> Thanks
> Kevin

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

