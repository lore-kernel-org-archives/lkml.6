Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FEAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF56820877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VaLs24Q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF56820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeIYRm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:42:58 -0400
Received: from 8bytes.org ([81.169.241.247]:34832 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbeIYRm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:42:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8A7866FB; Tue, 25 Sep 2018 13:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537875349; bh=MhFZM7FKpfFs2A4YRFtLdNrJoOYgnYz+qs9s8jvtE4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaLs24Q6XUdt1hEtE7Dn1kuav7ykSy8jXGtDgxhwHIAM/SPHtSBi09mzbRN0q0DlQ
         5rybmDQboeAvmrxnJy6Rpsqy7Qzm9MZlHewt0vpSvupkeyn4fy6/luxylUvU5EWqEE
         xDrRS4oXO3siUJl9aDDy40rBA1LzrHxX8iqzBs8nr4+hiE6UbXMiJpVk/+UfBzehCN
         pK7vSgYDjSlCVwIcqNGhh9jgxPbjvh33fyI2B2ruviXK7/4CBBr0mrRkp+WBesVS7K
         2/7F0dJSiEMgDD2td2eru1Deca0dafJsavPj5JfjYEuWkqyGAR67z9CdMDvwRLvbjn
         2leghMv+LBJwg==
Date:   Tue, 25 Sep 2018 13:35:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Handle memory shortage on pasid table
 allocation
Message-ID: <20180925113549.GB18287@8bytes.org>
References: <20180901062416.6107-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901062416.6107-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 02:24:16PM +0800, Lu Baolu wrote:
> Pasid table memory allocation could return failure due to memory
> shortage. Limit the pasid table size to 1MiB because current 8MiB
> contiguous physical memory allocation can be hard to come by. W/o
> a PASID table, the device could continue to work with only shared
> virtual memory impacted. So, let's go ahead with context mapping
> even the memory allocation for pasid table failed.
> 
> Fixes: cc580e41260d ("iommu/vt-d: Per PCI device pasid table interfaces")
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reported-and-tested-by: Pelton Kyle D <kyle.d.pelton@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 6 +++---
>  drivers/iommu/intel-pasid.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.
