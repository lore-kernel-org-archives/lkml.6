Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E9FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6980320853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6980320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeINSWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:22:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727013AbeINSWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:22:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1460CF14D8EFD;
        Fri, 14 Sep 2018 21:07:51 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 14 Sep
 2018 21:07:28 +0800
Date:   Fri, 14 Sep 2018 21:05:35 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
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
        "David S . Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Philippe Ombredanne" <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Message-ID: <20180914130535.GD207969@Turing-Arch-b>
References: <20180907165303.GA3519@redhat.com>
 <20180910032809.GJ230707@Turing-Arch-b>
 <20180910145423.GA3488@redhat.com>
 <20180911024209.GK230707@Turing-Arch-b>
 <20180911033358.GA4730@redhat.com>
 <20180911064043.GA207969@Turing-Arch-b>
 <20180911134013.GA3932@redhat.com>
 <20180913083232.GB207969@Turing-Arch-b>
 <20180913145149.GB3576@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191303A7F@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191303A7F@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 06:50:55AM +0000, Tian, Kevin wrote:
> Date: Fri, 14 Sep 2018 06:50:55 +0000
> From: "Tian, Kevin" <kevin.tian@intel.com>
> To: Jerome Glisse <jglisse@redhat.com>, Kenneth Lee <liguozhu@hisilicon.com>
> CC: Kenneth Lee <nek.in.cn@gmail.com>, Alex Williamson
>  <alex.williamson@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>,
>  "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet
>  <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zaibo
>  Xu <xuzaibo@huawei.com>, "linux-doc@vger.kernel.org"
>  <linux-doc@vger.kernel.org>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
>  Hao Fang <fanghao11@huawei.com>, "linux-kernel@vger.kernel.org"
>  <linux-kernel@vger.kernel.org>, "linuxarm@huawei.com"
>  <linuxarm@huawei.com>, "iommu@lists.linux-foundation.org"
>  <iommu@lists.linux-foundation.org>, "David S . Miller"
>  <davem@davemloft.net>, "linux-crypto@vger.kernel.org"
>  <linux-crypto@vger.kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
>  Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner
>  <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>,
>  "linux-accelerators@lists.ozlabs.org"
>  <linux-accelerators@lists.ozlabs.org>, Lu Baolu <baolu.lu@linux.intel.com>
> Subject: RE: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
> Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191303A7F@SHSMSX101.ccr.corp.intel.com>
> 
> > From: Jerome Glisse
> > Sent: Thursday, September 13, 2018 10:52 PM
> >
> [...]
>  > AFAIK, on x86 and PPC at least, all PCIE devices are in the same group
> > by default at boot or at least all devices behind the same bridge.
> 
> the group thing reflects physical hierarchy limitation, not changed
> cross boot. Please note iommu group defines the minimal isolation
> boundary - all devices within same group must be attached to the
> same iommu domain or address space, because physically IOMMU
> cannot differentiate DMAs out of those devices. devices behind
> legacy PCI-X bridge is one example. other examples include devices
> behind a PCIe switch port which doesn't support ACS thus cannot
> route p2p transaction to IOMMU. If talking about typical PCIe 
> endpoint (with upstreaming ports all supporting ACS), you'll get
> one device per group.
> 
> One iommu group today is attached to only one iommu domain.
> In the future one group may attach to multiple domains, as the
> aux domain concept being discussed in another thread.
> 
> > 
> > Maybe they are kernel option to avoid that and userspace init program
> > can definitly re-arrange that base on sysadmin policy).
> 
> I don't think there is such option, as it may break isolation model
> enabled by IOMMU.
> 
> [...]
> > > > That is why i am being pedantic :) on making sure there is good reasons
> > > > to do what you do inside VFIO. I do believe that we want a common
> > frame-
> > > > work like the one you are proposing but i do not believe it should be
> > > > part of VFIO given the baggages it comes with and that are not relevant
> > > > to the use cases for this kind of devices.
> > >
> 
> The purpose of VFIO is clear - the kernel portal for granting generic 
> device resource (mmio, irq, etc.) to user space. VFIO doesn't care
> what exactly a resource is used for (queue, cmd reg, etc.). If really
> pursuing VFIO path is necessary, maybe such common framework
> should lay down in user space, which gets all granted resource from
> kernel driver thru VFIO and then provides accelerator services to 
> other processes?

Yes. I think this is exactly what WarpDrive is now doing. This patch is just let
the type1 driver use parent IOMMU for mdev.

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

