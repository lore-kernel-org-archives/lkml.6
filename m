Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E788C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7556920854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfAVOie convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:38:34 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32833 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728773AbfAVOib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:38:31 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id C3AEFCCC0BD1864EED60;
        Tue, 22 Jan 2019 14:38:29 +0000 (GMT)
Received: from LHREML524-MBB.china.huawei.com ([169.254.3.138]) by
 lhreml707-cah.china.huawei.com ([10.201.108.48]) with mapi id 14.03.0415.000;
 Tue, 22 Jan 2019 14:38:24 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 0/4] arm64 SMMUv3 PMU driver with IORT support
Thread-Topic: [PATCH v5 0/4] arm64 SMMUv3 PMU driver with IORT support
Thread-Index: AQHUiMRc6YrtMxIxCUishushjyv1/KW7rRdg
Date:   Tue, 22 Jan 2019 14:38:23 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8392939DF@lhreml524-mbb.china.huawei.com>
References: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20181130154751.28580-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.94.162]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin/Lorenzo,

A gentle reminder on this series. Please take a look.

Thanks,
Shameer

> -----Original Message-----
> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of Shameer
> Kolothum
> Sent: 30 November 2018 15:48
> To: lorenzo.pieralisi@arm.com; robin.murphy@arm.com
> Cc: mark.rutland@arm.com; vkilari@codeaurora.org;
> neil.m.leeder@gmail.com; jean-philippe.brucker@arm.com;
> pabba@codeaurora.org; will.deacon@arm.com; rruigrok@codeaurora.org;
> Linuxarm <linuxarm@huawei.com>; linux-kernel@vger.kernel.org;
> linux-acpi@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH v5 0/4] arm64 SMMUv3 PMU driver with IORT support
> 
> This adds a driver for the SMMUv3 PMU into the perf framework.
> It includes an IORT update to support PM Counter Groups.
> 
> This is based on the initial work done by Neil Leeder[1]
> 
> SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page>
> where <phys_addr_page> is the physical page address of the SMMU PMCG.
> For example, the PMCG at 0xff88840000 is named smmuv3_pmcg_ff88840
> 
> Usage example:
> For common arch supported events:
> perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
>  filter_span=1,filter_stream_id=0x42/ -a netperf
> 
> For IMP DEF events:
> perf stat -e smmuv3_pmcg_ff88840/event=id/ -a netperf
> 
> This is sanity tested on a HiSilicon platform that requires
> a quirk to run  it properly. As per HiSilicon erratum  #162001800,
> PMCG event counter registers (SMMU_PMCG_EVCNTRn) on HiSilicon Hip08
> platforms are read only and this prevents the software from setting
> the initial period on event start. Unfortunately we were a bit late
> in the cycle to detect this issue and now require software workaround
> for this. Patch #4 is added to this series to provide a workaround
> for this issue.
> 
> Further testing on supported platforms are very much welcome.
> 
> v4 ---> v5
> -IORT code is modified to pass the option/quirk flags to the driver
>  through platform_data (patch #4), based on Robin's comments.
> -Removed COMPILE_TEST (patch #2).
> 
> v3 --> v4
> 
> -Addressed comments from Jean and Robin.
> -Merged dma config callbacks as per Lorenzo's comments(patch #1).
> -Added handling of Global(Counter0) filter settings mode(patch #2).
> -Added patch #4 to address HiSilicon erratum  #162001800
> -
> v2 --> v3
> 
> -Addressed comments from Robin.
> -Removed iort helper function to retrieve the PMCG reference smmu.
> -PMCG devices are now named using the base address
> 
> v1 --> v2
> 
> - Addressed comments from Robin.
> - Added an helper to retrieve the associated smmu dev and named PMUs
>   to make the association visible to user.
> - Added MSI support  for overflow irq
> 
> [1]https://www.spinics.net/lists/arm-kernel/msg598591.html
> 
> Neil Leeder (2):
>   acpi: arm64: add iort support for PMCG
>   perf: add arm64 smmuv3 pmu driver
> 
> Shameer Kolothum (2):
>   perf/smmuv3: Add MSI irq support
>   perf/smmuv3_pmu: Enable HiSilicon Erratum 162001800 quirk
> 
>  drivers/acpi/arm64/iort.c     | 127 +++++--
>  drivers/perf/Kconfig          |   9 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_smmuv3_pmu.c | 859
> ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi_iort.h     |   3 +
>  5 files changed, 975 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/perf/arm_smmuv3_pmu.c
> 
> --
> 2.7.4
> 
> 
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
