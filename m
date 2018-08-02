Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EC8C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBB120C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBB120C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeHBJ0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:26:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbeHBJ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:26:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 990301EDCCE92;
        Thu,  2 Aug 2018 15:36:08 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 2 Aug 2018
 15:35:59 +0800
Date:   Thu, 2 Aug 2018 15:34:40 +0800
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
Subject: Re: [RFC PATCH 3/7] vfio: add spimdev support
Message-ID: <20180802073440.GA91035@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-4-nek.in.cn@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191290F7B@SHSMSX101.ccr.corp.intel.com>
 <20180802034727.GK160746@Turing-Arch-b>
 <AADFC41AFE54684AB9EE6CBC0274A5D19129102C@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19129102C@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:24:22AM +0000, Tian, Kevin wrote:
> Date: Thu, 2 Aug 2018 04:24:22 +0000
> From: "Tian, Kevin" <kevin.tian@intel.com>
> To: Kenneth Lee <liguozhu@hisilicon.com>
> CC: Kenneth Lee <nek.in.cn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
>  Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
>  <davem@davemloft.net>, Joerg Roedel <joro@8bytes.org>, Alex Williamson
>  <alex.williamson@redhat.com>, Hao Fang <fanghao11@huawei.com>, Zhou Wang
>  <wangzhou1@hisilicon.com>, Zaibo Xu <xuzaibo@huawei.com>, Philippe
>  Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
>  <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
>  "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
>  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
>  "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
>  "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
>  "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
>  "linux-accelerators@lists.ozlabs.org"
>  <linux-accelerators@lists.ozlabs.org>, Lu Baolu
>  <baolu.lu@linux.intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
>  "linuxarm@huawei.com" <linuxarm@huawei.com>
> Subject: RE: [RFC PATCH 3/7] vfio: add spimdev support
> Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19129102C@SHSMSX101.ccr.corp.intel.com>
> 
> > From: Kenneth Lee [mailto:liguozhu@hisilicon.com]
> > Sent: Thursday, August 2, 2018 11:47 AM
> > 
> > >
> > > > From: Kenneth Lee
> > > > Sent: Wednesday, August 1, 2018 6:22 PM
> > > >
> > > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > > >
> > > > SPIMDEV is "Share Parent IOMMU Mdev". It is a vfio-mdev. But differ
> > from
> > > > the general vfio-mdev:
> > > >
> > > > 1. It shares its parent's IOMMU.
> > > > 2. There is no hardware resource attached to the mdev is created. The
> > > > hardware resource (A `queue') is allocated only when the mdev is
> > > > opened.
> > >
> > > Alex has concern on doing so, as pointed out in:
> > >
> > > 	https://www.spinics.net/lists/kvm/msg172652.html
> > >
> > > resource allocation should be reserved at creation time.
> > 
> > Yes. That is why I keep telling that SPIMDEV is not for "VM", it is for "many
> > processes", it is just an access point to the process. Not a device to VM. I
> > hope
> > Alex can accept it:)
> > 
> 
> VFIO is just about assigning device resource to user space. It doesn't care
> whether it's native processes or VM using the device so far. Along the direction
> which you described, looks VFIO needs to support the configuration that
> some mdevs are used for native process only, while others can be used
> for both native and VM. I'm not sure whether there is a clean way to
> enforce it...

I had the same idea at the beginning. But finally I found that the life cycle
of the virtual device for VM and process were different. Consider you create
some mdevs for VM use, you will give all those mdevs to lib-virt, which
distribute those mdev to VMs or containers. If the VM or container exits, the
mdev is returned to the lib-virt and used for next allocation. It is the
administrator who controlled every mdev's allocation.

But for process, it is different. There is no lib-virt in control. The
administrator's intension is to grant some type of application to access the
hardware. The application can get a handle of the hardware, send request and get
the result. That's all. He/She dose not care which mdev is allocated to that
application. If it crashes, it should be the kernel's responsibility to withdraw
the resource, the system administrator does not want to do it by hand.

> 
> Let's hear from Alex's thought.

Sure:)

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

