Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8610C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C09C20883
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfATABZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 19:01:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46910 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfATABZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 19:01:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BF36A78;
        Sat, 19 Jan 2019 16:01:24 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6972C3F6A8;
        Sat, 19 Jan 2019 16:01:22 -0800 (PST)
Date:   Sun, 20 Jan 2019 00:01:18 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
 table mappings
Message-ID: <20190120000117.GH26876@brain-police>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
 <20190117092718.1396-3-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117092718.1396-3-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> Adding a device tree option for arm smmu to enable non-cacheable
> memory for page tables.
> We already enable a smmu feature for coherent walk based on
> whether the smmu device is dma-coherent or not. Have an option
> to enable non-cacheable page table memory to force set it for
> particular smmu devices.

Hmm, I must be missing something here. What is the difference between this
new property, and simply omitting dma-coherent on the SMMU?

Will
