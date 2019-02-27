Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6056C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762D0218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 03:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfB0DZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 22:25:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729128AbfB0DZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 22:25:53 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A38B7C429708B956B1C0;
        Wed, 27 Feb 2019 11:25:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 11:25:45 +0800
Subject: Re: [PATCH 0/5] iommu/arm-smmu-v3: make smmu can be enabled in kdump
 kernel
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5C760337.2070504@huawei.com>
Date:   Wed, 27 Feb 2019 11:25:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Robin:
   Do you have time to review these patches? Hope you can give me some opinions.


On 2019/2/19 15:54, Zhen Lei wrote:
> This patch series include two parts:
> 1. Patch1-2 use dummy STE tables with "ste abort" hardware feature to abort unexpected
>    devices accessing. For more details, see the description in patch 2.
> 2. If the "ste abort" feature is not support, force the unexpected devices in the
>    secondary kernel to use the memory maps which it used in the first kernel. For more
>    details, see patch 5.
> 
> 
> Zhen Lei (5):
>   iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
>   iommu/arm-smmu-v3: make smmu can be enabled in kdump kernel
>   iommu/arm-smmu-v3: add macro xxx_SIZE to replace xxx_DWORDS shift
>   iommu/arm-smmu-v3: move arm_smmu_get_step_for_sid() a little ahead
>   iommu/arm-smmu-v3: workaround for STE abort in kdump kernel
> 
>  drivers/iommu/arm-smmu-v3.c | 243 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 194 insertions(+), 49 deletions(-)
> 

-- 
Thanks!
BestRegards

