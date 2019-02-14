Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7E52229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbfBNHaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:30:10 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56470 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbfBNHaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:30:10 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 263DD6085CA6669C385D;
        Thu, 14 Feb 2019 15:30:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 15:29:57 +0800
Subject: Re: [PATCH v6 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum
 162001800 quirk
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
CC:     <andrew.murray@arm.com>, <jean-philippe.brucker@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <john.garry@huawei.com>, <pabba@codeaurora.org>,
        <vkilari@codeaurora.org>, <rruigrok@codeaurora.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
 <20190204121324.11460-5-shameerali.kolothum.thodi@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <91fa1e08-a905-90a9-3577-fa3486bb951f@huawei.com>
Date:   Thu, 14 Feb 2019 15:29:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190204121324.11460-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/4 20:13, Shameer Kolothum wrote:
> HiSilicon erratum 162001800 describes the limitation of
> SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.
> 
> On these platforms, the PMCG event counter registers
> (SMMU_PMCG_EVCNTRn) are read only and as a result it
> is not possible to set the initial counter period value
> on event monitor start.
> 
> To work around this, the current value of the counter
> is read and used for delta calculations. OEM information
> from ACPI header is used to identify the affected hardware
> platforms.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c     | 16 ++++++++++++++-
>  drivers/perf/arm_smmuv3_pmu.c | 48 ++++++++++++++++++++++++++++++++++++-------
>  include/linux/acpi_iort.h     |  1 +
>  3 files changed, 57 insertions(+), 8 deletions(-)

For this patch,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

