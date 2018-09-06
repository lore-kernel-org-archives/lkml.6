Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D5DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1B920876
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1B920876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIFNp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:45:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727817AbeIFNp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:45:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ECB658CFFD7F5;
        Thu,  6 Sep 2018 17:11:23 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 6 Sep 2018
 17:11:18 +0800
Date:   Thu, 6 Sep 2018 17:09:31 +0800
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
Subject: Re: [PATCH 6/7] crypto: add sdmdev support to Hisilicon QM
Message-ID: <20180906090931.GD230707@Turing-Arch-b>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180903005204.26041-7-nek.in.cn@gmail.com>
 <46e57b2b-756e-e256-5b3c-30749d865512@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46e57b2b-756e-e256-5b3c-30749d865512@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 07:19:03PM -0700, Randy Dunlap wrote:
> Date: Sun, 2 Sep 2018 19:19:03 -0700
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
> Subject: Re: [PATCH 6/7] crypto: add sdmdev support to Hisilicon QM
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
>  Thunderbird/52.9.1
> Message-ID: <46e57b2b-756e-e256-5b3c-30749d865512@infradead.org>
> 
> On 09/02/2018 05:52 PM, Kenneth Lee wrote:
> > diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
> > index 1d155708cd69..b85fab48fdab 100644
> > --- a/drivers/crypto/hisilicon/Kconfig
> > +++ b/drivers/crypto/hisilicon/Kconfig
> > @@ -17,6 +17,16 @@ config CRYPTO_DEV_HISI_SEC
> >  	  To compile this as a module, choose M here: the module
> >  	  will be called hisi_sec.
> >  
> > +config CRYPTO_DEV_HISI_SDMDEV
> > +	bool "Enable SDMDEV interface"
> > +	depends on CRYPTO_DEV_HISILICON
> > +	select VFIO_SDMDEV
> > +	help
> > +	  Enable this enable the SDMDEV, "shared IOMMU Domain Mediated Device"
> 
> At a minimum:
> 	  Enable this to enable the SDMDEV,
> 
> although that could be done better.  Maybe just:
> 	  Enable the SDMDEV "shared IOMMU Domain Mediated Device"
> 
> 	  
> > +	  interface for all Hisilicon accelerators if they can. The SDMDEV
> 
> probably drop "if they can":          accelerators.  The SDMDEV interface
> 
> > +	  enable the WarpDrive user space accelerator driver to access the
> 
> 	  enables

Thank you, will change them all in the coming version.

> 
> > +	  hardware function directly.
> > +
> 
> 
> -- 
> ~Randy

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

