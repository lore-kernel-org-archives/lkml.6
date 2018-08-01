Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57BEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87A120840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87A120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbeHAKxY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:53:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728321AbeHAKxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:53:24 -0400
X-Greylist: delayed 955 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Aug 2018 06:53:23 EDT
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 12E898B56B3C4;
        Wed,  1 Aug 2018 09:52:45 +0100 (IST)
Received: from FRAEMA707-CHM.china.huawei.com (10.206.14.56) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Wed, 1 Aug 2018 09:52:46 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.135]) by
 FRAEMA707-CHM.china.huawei.com ([169.254.7.74]) with mapi id 14.03.0399.000;
 Wed, 1 Aug 2018 10:52:37 +0200
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
Thread-Topic: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
Thread-Index: AQHUI0QCc0QcIjFmMUeVhGYdpXMqdaSqojWw
Date:   Wed, 1 Aug 2018 08:52:36 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838755908@FRAEML521-MBX.china.huawei.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo/Robin,

Just a  gentle ping on this series. This is a v2 for smmu pmcg support
based on Neil Leeder's v1[1]. 

Main changes include,
-an helper function to IORT to retrieve the associated SMMU info.
-MSI support to the PMU driver.

Please take a look and let me know your thoughts.

Thanks,
Shameer

[1]https://www.spinics.net/lists/arm-kernel/msg598591.html

> -----Original Message-----
> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of
> Shameer Kolothum
> Sent: 24 July 2018 12:45
> To: lorenzo.pieralisi@arm.com; robin.murphy@arm.com
> Cc: mark.rutland@arm.com; vkilari@codeaurora.org;
> neil.m.leeder@gmail.com; pabba@codeaurora.org; will.deacon@arm.com;
> rruigrok@codeaurora.org; Linuxarm <linuxarm@huawei.com>; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
> 
> This adds a driver for the SMMUv3 PMU into the perf framework.
> It includes an IORT update to support PM Counter Groups.
> 
> This is based on the initial work done by Neil Leeder[1]
> 
> SMMUv3 PMCG devices are named as arm_smmu_v3_x_pmcg_y where x
> denotes the associated smmuv3 dev id(if any) and y denotes the
> pmu dev id.
> 
> Usage example:
> For common arch supported events:
> perf stat -e arm_smmu_v3_0_pmcg_6/transaction,filter_enable=1,
>  filter_span=1,filter_stream_id=0x42/ -a pwd
> 
> For IMP DEF events:
> perf stat -e arm_smmu_v3.0_pmcg.6/event=id/ -a pwd
> 
> Sanity tested on HiSilicon platform. Further testing on supported
> platforms are very much welcome.
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
>   acpi: arm64: iort helper to find the associated smmu of pmcg node
>   perf/smmuv3: Add MSI irq support
> 
>  drivers/acpi/arm64/iort.c     | 179 +++++++--
>  drivers/perf/Kconfig          |   9 +
>  drivers/perf/Makefile         |   1 +
>  drivers/perf/arm_smmuv3_pmu.c | 901
> ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi_iort.h     |   4 +
>  5 files changed, 1063 insertions(+), 31 deletions(-)
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
