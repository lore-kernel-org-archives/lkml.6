Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE79C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D1720862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D1720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeHBE5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:57:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52859 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbeHBE5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:57:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CB5FCB90D79D;
        Thu,  2 Aug 2018 11:08:29 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 2 Aug 2018
 11:08:21 +0800
Date:   Thu, 2 Aug 2018 11:07:01 +0800
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
Subject: Re: [RFC PATCH 3/7] vfio: add spimdev support
Message-ID: <20180802030701.GI160746@Turing-Arch-b>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
 <20180801102221.5308-4-nek.in.cn@gmail.com>
 <d11c7745-2f31-0f33-1bd8-78379dc66e6e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d11c7745-2f31-0f33-1bd8-78379dc66e6e@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 09:23:52AM -0700, Randy Dunlap wrote:
> Date: Wed, 1 Aug 2018 09:23:52 -0700
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
> Subject: Re: [RFC PATCH 3/7] vfio: add spimdev support
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
>  Thunderbird/52.9.1
> Message-ID: <d11c7745-2f31-0f33-1bd8-78379dc66e6e@infradead.org>
> 
> On 08/01/2018 03:22 AM, Kenneth Lee wrote:
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> > 
> > SPIMDEV is "Share Parent IOMMU Mdev". It is a vfio-mdev. But differ from
> > the general vfio-mdev:
> > 
> > 1. It shares its parent's IOMMU.
> > 2. There is no hardware resource attached to the mdev is created. The
> > hardware resource (A `queue') is allocated only when the mdev is
> > opened.
> > 
> > Currently only the vfio type-1 driver is updated to make it to be aware
> > of.
> > 
> > Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> > Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> > Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> > ---
> >  drivers/vfio/Kconfig                |   1 +
> >  drivers/vfio/Makefile               |   1 +
> >  drivers/vfio/spimdev/Kconfig        |  10 +
> >  drivers/vfio/spimdev/Makefile       |   3 +
> >  drivers/vfio/spimdev/vfio_spimdev.c | 421 ++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_iommu_type1.c     | 136 ++++++++-
> >  include/linux/vfio_spimdev.h        |  95 +++++++
> >  include/uapi/linux/vfio_spimdev.h   |  28 ++
> >  8 files changed, 689 insertions(+), 6 deletions(-)
> >  create mode 100644 drivers/vfio/spimdev/Kconfig
> >  create mode 100644 drivers/vfio/spimdev/Makefile
> >  create mode 100644 drivers/vfio/spimdev/vfio_spimdev.c
> >  create mode 100644 include/linux/vfio_spimdev.h
> >  create mode 100644 include/uapi/linux/vfio_spimdev.h
> > 
> > diff --git a/drivers/vfio/spimdev/Kconfig b/drivers/vfio/spimdev/Kconfig
> > new file mode 100644
> > index 000000000000..1226301f9d0e
> > --- /dev/null
> > +++ b/drivers/vfio/spimdev/Kconfig
> > @@ -0,0 +1,10 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config VFIO_SPIMDEV
> > +	tristate "Support for Share Parent IOMMU MDEV"
> > +	depends on VFIO_MDEV_DEVICE
> > +	help
> > +	  Support for VFIO Share Parent IOMMU MDEV, which enable the kernel to
> 
> 	                                                  enables
> 
> > +	  support for the light weight hardware accelerator framework, WrapDrive.
> 
> 	  support the lightweight hardware accelerator framework, WrapDrive.
> 
> > +
> > +	  To compile this as a module, choose M here: the module will be called
> > +	  spimdev.
> 
> 
> -- 
> ~Randy

Thanks, I will update it in next version.

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

