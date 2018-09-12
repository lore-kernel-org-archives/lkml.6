Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C311C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE4220880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE4220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeILWCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:02:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36024 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeILWCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:02:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB7587A9;
        Wed, 12 Sep 2018 09:56:43 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B9503F557;
        Wed, 12 Sep 2018 09:56:43 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 857EF1AE3231; Wed, 12 Sep 2018 17:57:00 +0100 (BST)
Date:   Wed, 12 Sep 2018 17:57:00 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LinuxArm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v5 0/5] add non-strict mode support for arm-smmu-v3
Message-ID: <20180912165700.GC16071@arm.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, Aug 15, 2018 at 09:28:25AM +0800, Zhen Lei wrote:
> v4 -> v5:
> 1. change the type of global variable and struct member named "non_strict" from
>    "int" to "bool".
> 2. cancel the unnecessary parameter "strict" of __arm_lpae_unmap which was added
>    in v4.
> 3. change boot option "arm_iommu" to "iommu.non_strict".
> 4. convert __iommu_dma_unmap to use iommu_unmap_fast()/iommu_tlb_sync(), because
>    non-leaf unmaps still need to be synchronous.
> 
> Thanks for Robin's review comments.

Since this is 90% of the way there now, I suggest Robin picks up what's here
and incorporates his remaining review comments directly (especially since it
sounded like Zhen Lei hasn't got much free time lately). With that, I can
queue this lot via my smmu branch, which already has some stuff queued
for SMMUv3 and io-pgtable.

Please shout if you have any objections, but I'm keen for this not to
languish on the lists given how close it is!

Will
