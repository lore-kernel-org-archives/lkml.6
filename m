Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB66FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D92120659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D92120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeIFMog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:44:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727203AbeIFMog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:44:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A9597446D93F2;
        Thu,  6 Sep 2018 16:10:18 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 6 Sep 2018
 16:10:11 +0800
Date:   Thu, 6 Sep 2018 16:08:24 +0800
From:   Kenneth Lee <liguozhu@hisilicon.com>
To:     Randy Dunlap <rdunlap@infradead.org>
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
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 3/7] vfio: add sdmdev support
Message-ID: <20180906080824.GA230707@Turing-Arch-b>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180903005204.26041-4-nek.in.cn@gmail.com>
 <0574e7dc-bed2-d2d0-3aa6-93590d54ce81@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0574e7dc-bed2-d2d0-3aa6-93590d54ce81@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 07:11:12PM -0700, Randy Dunlap wrote:
> Date: Sun, 2 Sep 2018 19:11:12 -0700
> From: Randy Dunlap <rdunlap@infradead.org>
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
>  linux-accelerators@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
>  Sanjay Kumar <sanjay.k.kumar@intel.com>
> CC: linuxarm@huawei.com
> Subject: Re: [PATCH 3/7] vfio: add sdmdev support
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
>  Thunderbird/52.9.1
> Message-ID: <0574e7dc-bed2-d2d0-3aa6-93590d54ce81@infradead.org>
> 
> On 09/02/2018 05:52 PM, Kenneth Lee wrote:
> > diff --git a/drivers/vfio/sdmdev/Kconfig b/drivers/vfio/sdmdev/Kconfig
> > new file mode 100644
> > index 000000000000..51474272870d
> > --- /dev/null
> > +++ b/drivers/vfio/sdmdev/Kconfig
> > @@ -0,0 +1,10 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config VFIO_SDMDEV
> > +	tristate "Support for Share Domain MDEV"
> > +	depends on VFIO_MDEV_DEVICE
> > +	help
> > +	  Support for VFIO Share Domain MDEV, which enables the kernel to
> > +	  support light weight hardware accelerator framework, WarpDrive.
> 
> 	          lightweight
> 
Thank you, will fix it.
> > +
> > +	  To compile this as a module, choose M here: the module will be called
> > +	  sdmdev.
> 
> 
> thanks,
> -- 
> ~Randy

-- 
			-Kenneth(Hisilicon)

