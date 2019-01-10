Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24976C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F035020675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfAJSW0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:22:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:38188 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbfAJSWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:22:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 10:22:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="124942571"
Received: from irsmsx154.ger.corp.intel.com ([163.33.192.96])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2019 10:22:23 -0800
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 IRSMSX154.ger.corp.intel.com (163.33.192.96) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 10 Jan 2019 18:22:22 +0000
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.161]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.157]) with mapi id 14.03.0415.000;
 Thu, 10 Jan 2019 18:22:22 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Thread-Topic: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Thread-Index: AQHUpBr45+ywfuPymUCoKimWscsUMaWolJGAgAAe2YCAACZR0A==
Date:   Thu, 10 Jan 2019 18:22:21 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C431572@IRSMSX106.ger.corp.intel.com>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
 <a960e9a7-ff86-b000-1319-df85741fb380@intel.com>
 <20190110160157.GA27895@ulmo>
In-Reply-To: <20190110160157.GA27895@ulmo>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTBmZjE0OTAtNGUxZi00ZTJmLWI2NDgtM2NiODk3MjM3M2JmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ0V0OE1sTXRLWXpYMXFabHN5RWdwbkhYT1lOK2Y5ZjVURlllbElvVjdjbExcL3BrWEhla0tyY0xONWxGMFhKM0QifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Thierry Reding [mailto:thierry.reding@gmail.com]
> Sent: Thursday, January 10, 2019 6:02 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Jonathan Hunter
> <jonathanh@nvidia.com>; Sowjanya Komatineni
> <skomatineni@nvidia.com>; Krishna Reddy <vdumpa@nvidia.com>; linux-
> mmc@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
> 
> On Thu, Jan 10, 2019 at 04:11:33PM +0200, Adrian Hunter wrote:
> > On 4/01/19 12:47 PM, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > The implementation of sdhci_set_dma_mask() is conflating two things:
> > > on one hand it uses the SDHCI_USE_64_BIT_DMA flag to determine
> > > whether or not to use the 64-bit addressing capability of the
> > > controller and on the other hand it also uses that flag to set a DMA
> > > mask for the controller's parent device.
> > >
> > > However, a controller supporting 64-bit addressing doesn't mean that
> > > it needs to support addressing 64 bits of address range. It's
> > > perfectly acceptable to use 64-bit addressing for a 32-bit address
> > > range or even smaller, even if that makes little sense, considering
> > > the extra overhead of the 64-bit addressing descriptors.
> > >
> > > But it is fairly common for hardware to support somewhere between 32
> > > and
> > > 64 bits of address range. Tegra124 and Tegra210, for example,
> > > support 34 bits and the newer Tegra186 and Tegra194 support 40 bits.
> > > The latter can also use an IOMMU for address translation, which has
> > > an input address range of 48 bits. This causes problems with the
> > > current algorithm in the SDHCI core for choosing the DMA mask. If
> > > the DMA mask is set to 64 bits, the DMA memory allocations can (and
> > > usually do because the allocator starts from the top) end up beyond
> > > the 40 bit boundary addressable by the SDHCI controller, causing IOMMU
> faults.
> > >
> > > For Tegra specifically this problem is currently worked around by
> > > setting the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk. This causes the
> > > DMA mask to always be set to 32 bits and therefore all allocations
> > > will fit within the range addressable by the controller.
> > >
> > > This commit reworks the code in sdhci_set_dma_mask() to fix the
> > > above issue. The rationale behind this change is that the SDHCI
> > > controller driver should be the authoritative source of the DMA mask
> > > setting. The SDHCI core has no way of knowing what the individual
> > > SDHCI controllers are capable of. So instead of overriding the DMA
> > > mask depending on whether or not 64-bit addressing mode is used, the
> > > DMA mask is only modified if absolutely necessary. On one hand, if
> > > the controller can only address 32 bits of memory or less, we
> > > disable use of 64-bit addressing mode because it is not needed. On
> > > the other hand, we also want to make sure that if we don't support
> > > 64-bit addressing mode, such as in the case where the
> > > BROKEN_64_BIT_DMA quirk is set, we do restrict the DMA mask to fit
> > > the capabilities. The latter is an inconsistency by the driver, so
> > > we warn about it to make sure it will be addressed in the driver.
> >
> > sdhci_set_dma_mask() was added because people did want sdhci to set
> > the DMA mask.  Also using 64-bit DMA even with 32-bit systems has the
> > advantage of reducing exposure to problems i.e. the same logic is used
> > with the same SoC irrespective of whether or not it is in 32-bit
> > compatibility mode.  So the policy for sdhci is always to use 64-bit DMA if it
> is supported.
> >
> > I suggest we add a new sdhci op for ->set_dma_mask() and call that
> > instead of sdhci_set_dma_mask() if it is not NULL.
> 
> Some drivers are already doing something similar by overriding the DMA
> mask again in ->enable_dma(). I had briefly considered doing that for Tegra,
> but after thinking about it, it just became clear to me that we shouldn't need
> to override this in every driver. I just don't think it's correct for the MMC core
> to muck with the DMA mask. Just because the hardware supports the SDHCI
> 64-bit addressing mode doesn't mean that all
> 64 bits can be addressed by the hardware. The DMA mask defines what the
> valid address range is for the device and it's already conventional for drivers
> to set this early in their ->probe() implementation (or have the bus set it up).
> It seems wasteful to have to redo that in a custom callback.

What do you suggest?

