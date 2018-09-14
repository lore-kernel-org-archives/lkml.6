Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1BCC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB92220866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB92220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeINMEC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:04:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:48783 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeINMEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:04:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 23:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,372,1531810800"; 
   d="scan'208";a="85948567"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2018 23:50:58 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 13 Sep 2018 23:50:58 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 13 Sep 2018 23:50:58 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.143]) with mapi id 14.03.0319.002;
 Fri, 14 Sep 2018 14:50:56 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>
CC:     Kenneth Lee <nek.in.cn@gmail.com>,
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
Subject: RE: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Topic: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Thread-Index: AQHUQyBoMyXI/RBW1UKE39r7bd5lp6Tfs6CAgAAU6YCAArfOAIAAPyaAgADzGQCAANeMAIAD1hiAgAC/u4CAAMW/gIAADnyAgAA0LICAAHU2AIACzrEAgABp+gCAAYngAA==
Date:   Fri, 14 Sep 2018 06:50:55 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191303A7F@SHSMSX101.ccr.corp.intel.com>
References: <20180906133133.GA3830@redhat.com>
 <20180907040138.GI230707@Turing-Arch-b> <20180907165303.GA3519@redhat.com>
 <20180910032809.GJ230707@Turing-Arch-b> <20180910145423.GA3488@redhat.com>
 <20180911024209.GK230707@Turing-Arch-b> <20180911033358.GA4730@redhat.com>
 <20180911064043.GA207969@Turing-Arch-b> <20180911134013.GA3932@redhat.com>
 <20180913083232.GB207969@Turing-Arch-b> <20180913145149.GB3576@redhat.com>
In-Reply-To: <20180913145149.GB3576@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjA2ZmUyNTktOTViZC00OWFjLTk4ODMtMWM1ZmVkOTRhZTcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiM0FiTXlsbm8zUnA4QVo0MEZmeDZPVlRMSkJ4QmVLYTdKT1lyYlNvalZzdTBRbElGMEhBWEozNlZ3TUthaEhYcyJ9
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

> From: Jerome Glisse
> Sent: Thursday, September 13, 2018 10:52 PM
>
[...]
 > AFAIK, on x86 and PPC at least, all PCIE devices are in the same group
> by default at boot or at least all devices behind the same bridge.

the group thing reflects physical hierarchy limitation, not changed
cross boot. Please note iommu group defines the minimal isolation
boundary - all devices within same group must be attached to the
same iommu domain or address space, because physically IOMMU
cannot differentiate DMAs out of those devices. devices behind
legacy PCI-X bridge is one example. other examples include devices
behind a PCIe switch port which doesn't support ACS thus cannot
route p2p transaction to IOMMU. If talking about typical PCIe 
endpoint (with upstreaming ports all supporting ACS), you'll get
one device per group.

One iommu group today is attached to only one iommu domain.
In the future one group may attach to multiple domains, as the
aux domain concept being discussed in another thread.

> 
> Maybe they are kernel option to avoid that and userspace init program
> can definitly re-arrange that base on sysadmin policy).

I don't think there is such option, as it may break isolation model
enabled by IOMMU.

[...]
> > > That is why i am being pedantic :) on making sure there is good reasons
> > > to do what you do inside VFIO. I do believe that we want a common
> frame-
> > > work like the one you are proposing but i do not believe it should be
> > > part of VFIO given the baggages it comes with and that are not relevant
> > > to the use cases for this kind of devices.
> >

The purpose of VFIO is clear - the kernel portal for granting generic 
device resource (mmio, irq, etc.) to user space. VFIO doesn't care
what exactly a resource is used for (queue, cmd reg, etc.). If really
pursuing VFIO path is necessary, maybe such common framework
should lay down in user space, which gets all granted resource from
kernel driver thru VFIO and then provides accelerator services to 
other processes?

Thanks
Kevin
