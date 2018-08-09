Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4238C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44B721B34
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44B721B34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbeHIDd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:33:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730262AbeHIDd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 23:33:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 03EFDD5A49D14;
        Thu,  9 Aug 2018 09:11:11 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 9 Aug 2018
 09:11:02 +0800
Date:   Thu, 9 Aug 2018 09:09:38 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kvm@vger.kernel.org>, <linux-accelerators@lists.ozlabs.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for
 spimdev
Message-ID: <20180809010938.GH91035@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-3-nek.in.cn@gmail.com>
 <20180808091354.ppqgineql3pufwwr@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180808091354.ppqgineql3pufwwr@8bytes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 11:13:54AM +0200, Joerg Roedel wrote:
> Date: Wed, 8 Aug 2018 11:13:54 +0200
> From: Joerg Roedel <joro@8bytes.org>
> To: Kenneth Lee <nek.in.cn@gmail.com>
> CC: Jonathan Corbet <corbet@lwn.net>, Herbert Xu
>  <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
>  Alex Williamson <alex.williamson@redhat.com>, Kenneth Lee
>  <liguozhu@hisilicon.com>, Hao Fang <fanghao11@huawei.com>, Zhou Wang
>  <wangzhou1@hisilicon.com>, Zaibo Xu <xuzaibo@huawei.com>, Philippe
>  Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
>  <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
>  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
>  linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
>  kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org, Lu Baolu
>  <baolu.lu@linux.intel.com>, Sanjay Kumar <sanjay.k.kumar@intel.com>,
>  linuxarm@huawei.com
> Subject: Re: [RFC PATCH 2/7] iommu: Add share domain interface in iommu for
>  spimdev
> User-Agent: NeoMutt/20170421 (1.8.2)
> Message-ID: <20180808091354.ppqgineql3pufwwr@8bytes.org>
> 
> On Wed, Aug 01, 2018 at 06:22:16PM +0800, Kenneth Lee wrote:
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> > 
> > This patch add sharing interface for a iommu_group. The new interface:
> > 
> > 	iommu_group_share_domain()
> > 	iommu_group_unshare_domain()
> > 
> > can be used by some virtual iommu_group (such as iommu_group for spimdev)
> > to share their parent's iommu_group.
> > 
> > When the domain of the group is shared, it cannot be changed before
> > unshared.  In the future, notification can be added if update is required.
> 
> >From the description or the patch I don't really get why this is needed.
> Please update the description and make a case for this API addition.
> 

Yes, I will add more description in next version.

The idea here is:

1. iommu_domain is the setting of the IOMMU(the unit) of an iommu_group.

2. The iommu_group originally uses a default domain or a created one (e.g. by vfio)
   as its effective domain. There is only one user for a domain. If a device is
   bound to vfio driver, it uses the new created domain. And if it is unbound from
   vfio driver, it is switched back to the default domain.

3. But for spimdev, we create an mdev which share it parent device's IOMMU. That
   means, the parent device (along with its iommu group) will continue use its
   iommu_domain, and the mdev will use the same at the same time.

4. This API, is to tell the iommu_group that the domain is shared by the
   spimdev. And it should be changed before it is unshared.

Cheers

> 
> 	Joerg

-- 
			-Kenneth(Hisilicon)
