Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64275206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64275206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeIFNrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:47:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728262AbeIFNrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:47:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E36316073E78D;
        Thu,  6 Sep 2018 17:12:28 +0800 (CST)
Received: from localhost (10.67.212.75) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 6 Sep 2018
 17:12:20 +0800
Date:   Thu, 6 Sep 2018 17:10:32 +0800
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
Subject: Re: [PATCH 7/7] vfio/sdmdev: add user sample
Message-ID: <20180906091032.GE230707@Turing-Arch-b>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
 <20180903005204.26041-8-nek.in.cn@gmail.com>
 <ff75ff6a-2cd8-b25e-8d19-52e8f57141da@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff75ff6a-2cd8-b25e-8d19-52e8f57141da@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2018 at 07:25:12PM -0700, Randy Dunlap wrote:
> Date: Sun, 2 Sep 2018 19:25:12 -0700
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
> Subject: Re: [PATCH 7/7] vfio/sdmdev: add user sample
> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
>  Thunderbird/52.9.1
> Message-ID: <ff75ff6a-2cd8-b25e-8d19-52e8f57141da@infradead.org>
> 
> On 09/02/2018 05:52 PM, Kenneth Lee wrote:
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> > 
> > This is the sample code to demostrate how WrapDrive user application
> > should be.
> > 
> > It contains:
> > 
> > 1. wd.[ch], the common library to provide WrapDrive interface.
> 
>                                             WarpDrive
> 
> > 2. drv/*, the user driver to access the hardware upon spimdev
> > 3. test/*, the test application to use WrapDrive interface to access the
> 
>                                          WarpDrive
> 
> >    hardware queue(s) of the accelerator.
> > 
> > The Hisilicon HIP08 ZIP accelerator is used in this sample.
> > 
> > Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> > Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> > Signed-off-by: Hao Fang <fanghao11@huawei.com>
> > Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> > ---
> >  samples/warpdrive/AUTHORS              |   2 +
> >  samples/warpdrive/ChangeLog            |   1 +
> >  samples/warpdrive/Makefile.am          |   9 +
> >  samples/warpdrive/NEWS                 |   1 +
> >  samples/warpdrive/README               |  32 +++
> >  samples/warpdrive/autogen.sh           |   3 +
> >  samples/warpdrive/cleanup.sh           |  13 ++
> >  samples/warpdrive/configure.ac         |  52 +++++
> >  samples/warpdrive/drv/hisi_qm_udrv.c   | 223 ++++++++++++++++++
> >  samples/warpdrive/drv/hisi_qm_udrv.h   |  53 +++++
> >  samples/warpdrive/test/Makefile.am     |   7 +
> >  samples/warpdrive/test/comp_hw.h       |  23 ++
> >  samples/warpdrive/test/test_hisi_zip.c | 206 +++++++++++++++++
> >  samples/warpdrive/wd.c                 | 309 +++++++++++++++++++++++++
> >  samples/warpdrive/wd.h                 | 154 ++++++++++++
> >  samples/warpdrive/wd_adapter.c         |  74 ++++++
> >  samples/warpdrive/wd_adapter.h         |  43 ++++
> >  17 files changed, 1205 insertions(+)
> >  create mode 100644 samples/warpdrive/AUTHORS
> >  create mode 100644 samples/warpdrive/ChangeLog
> >  create mode 100644 samples/warpdrive/Makefile.am
> >  create mode 100644 samples/warpdrive/NEWS
> >  create mode 100644 samples/warpdrive/README
> >  create mode 100755 samples/warpdrive/autogen.sh
> >  create mode 100755 samples/warpdrive/cleanup.sh
> >  create mode 100644 samples/warpdrive/configure.ac
> >  create mode 100644 samples/warpdrive/drv/hisi_qm_udrv.c
> >  create mode 100644 samples/warpdrive/drv/hisi_qm_udrv.h
> >  create mode 100644 samples/warpdrive/test/Makefile.am
> >  create mode 100644 samples/warpdrive/test/comp_hw.h
> >  create mode 100644 samples/warpdrive/test/test_hisi_zip.c
> >  create mode 100644 samples/warpdrive/wd.c
> >  create mode 100644 samples/warpdrive/wd.h
> >  create mode 100644 samples/warpdrive/wd_adapter.c
> >  create mode 100644 samples/warpdrive/wd_adapter.h
> 
> > diff --git a/samples/warpdrive/README b/samples/warpdrive/README
> > new file mode 100644
> > index 000000000000..3adf66b112fc
> > --- /dev/null
> > +++ b/samples/warpdrive/README
> > @@ -0,0 +1,32 @@
> > +WD User Land Demonstration
> > +==========================
> > +
> > +This directory contains some applications and libraries to demonstrate how a
> > +
> > +WrapDrive application can be constructed.
> 
>    WarpDrive
> 
> > +
> > +
> > +As a demo, we try to make it simple and clear for understanding. It is not
> > +
> > +supposed to be used in business scenario.
> > +
> > +
> > +The directory contains the following elements:
> > +
> > +wd.[ch]
> > +	A demonstration WrapDrive fundamental library which wraps the basic
> 
> 	                WarpDrive
> 
> > +	operations to the WrapDrive-ed device.
> 
>                           WarpDrive
> 
> > +
> > +wd_adapter.[ch]
> > +	User driver adaptor for wd.[ch]
> > +
> > +wd_utils.[ch]
> > +	Some utitlities function used by WD and its drivers
> > +
> > +drv/*
> > +	User drivers. It helps to fulfill the semantic of wd.[ch] for
> > +	particular hardware
> > +
> > +test/*
> > +	Test applications to use the wrapdrive library
> 
> 	                             warpdrive
> 
> -- 
> ~Randy

Thank you, will change them all in the coming version.

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

