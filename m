Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC15DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC9920672
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC9920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeLFNxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:53:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:57180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbeLFNxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:53:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4936AEBA;
        Thu,  6 Dec 2018 13:53:11 +0000 (UTC)
Date:   Thu, 6 Dec 2018 14:53:10 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] ACPI/IORT: Use helper functions to access
 dev->iommu_fwspec
Message-ID: <20181206135310.lj5aiosr5ldno72g@suse.de>
References: <20181204163002.15800-1-joro@8bytes.org>
 <20181204163002.15800-3-joro@8bytes.org>
 <ecfaa990-9257-0592-ee4d-ca3f8537783d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecfaa990-9257-0592-ee4d-ca3f8537783d@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Dec 05, 2018 at 05:50:23PM +0000, Robin Murphy wrote:
> This needs to reload the new fwspec initialised by iort_iommu_xlate(), in
> the same manner as the OF code. I think the best thing to do is encapsulate
> the dev_iommu_fwspec_get() call in iort_fwspec_iommu_ops(), and have that
> take dev as its argument directly.

Yeah, that makes sense. I changed the patch this way.

Thanks,

	Joerg
