Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA4AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCE8208B0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCE8208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeHBG0K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 02:26:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:32025 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbeHBG0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 02:26:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 21:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,434,1526367600"; 
   d="scan'208";a="250400694"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2018 21:36:55 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 21:36:55 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 21:36:55 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0319.002;
 Thu, 2 Aug 2018 12:36:53 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Kenneth Lee <liguozhu@hisilicon.com>
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
Subject: RE: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Topic: [RFC PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Index: AQHUKYHSUTvc9I1u4EGviW0yiW9YHKSrv1Ww//+MjACAAJKKgA==
Date:   Thu, 2 Aug 2018 04:36:52 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19129105A@SHSMSX101.ccr.corp.intel.com>
References: <20180801102221.5308-1-nek.in.cn@gmail.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D191290EB3@SHSMSX101.ccr.corp.intel.com>
 <20180802034006.GJ160746@Turing-Arch-b>
In-Reply-To: <20180802034006.GJ160746@Turing-Arch-b>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGI0ZTRiYWQtMjNiNS00YmNjLWIyNDYtYTAyNDY5MzM0NDRiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVEtzK3E3NU93bWN0NFRyWnNXdjNLa0V1bjVcL2l1QWpub3ppaTNhZVVFNnRPclF0M2dnamZGTmJubnRVZFE5Rk4ifQ==
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
> Sent: Thursday, August 2, 2018 11:40 AM
> 
> On Thu, Aug 02, 2018 at 02:59:33AM +0000, Tian, Kevin wrote:
> > > From: Kenneth Lee
> > > Sent: Wednesday, August 1, 2018 6:22 PM
> > >
> > > From: Kenneth Lee <liguozhu@hisilicon.com>
> > >
> > > WarpDrive is an accelerator framework to expose the hardware
> capabilities
> > > directly to the user space. It makes use of the exist vfio and vfio-mdev
> > > facilities. So the user application can send request and DMA to the
> > > hardware without interaction with the kernel. This remove the latency
> > > of syscall and context switch.
> > >
> > > The patchset contains documents for the detail. Please refer to it for
> more
> > > information.
> > >
> > > This patchset is intended to be used with Jean Philippe Brucker's SVA
> > > patch [1] (Which is also in RFC stage). But it is not mandatory. This
> > > patchset is tested in the latest mainline kernel without the SVA patches.
> > > So it support only one process for each accelerator.
> >
> > If no sharing, then why not just assigning the whole parent device to
> > the process? IMO if SVA usage is the clear goal of your series, it
> > might be made clearly so then Jean's series is mandatory dependency...
> >
> 
> We don't know how SVA will be finally. But the feature, "make use of
> per-PASID/substream ID IOMMU page table", should be able to be enabled
> in the
> kernel. So we don't want to enforce it here. After we have this serial ready,
> it
> can be hooked to any implementation.

"any" or "only queue-based" implementation? some devices may not
have queue concept, e.g. GPU.

> 
> Further more, even without "per-PASID IOMMU page table", this series has
> its
> value. It is not simply dedicate the whole device to the process. It "shares"
> the device with the kernel driver. So you can support crypto and a user
> application at the same time.

OK.

Thanks
Kevin
