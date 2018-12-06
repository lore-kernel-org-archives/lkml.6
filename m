Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AAD214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AAD214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLFPfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:35:14 -0500
Received: from 8bytes.org ([81.169.241.247]:52148 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLFPfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:35:14 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DFB81209; Thu,  6 Dec 2018 16:35:12 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:35:12 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/of: Use device_iommu_mapped()
Message-ID: <20181206153512.GG16835@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-3-joro@8bytes.org>
 <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Dec 05, 2018 at 05:17:54PM +0000, Robin Murphy wrote:
> FWIW, this check (and its ACPI equivalent in patch #3) is specifically
> asking "has .add_device() already been called?", rather than the more
> general "is this device managed by an IOMMU?" (to which the exact answer at
> this point is "yes, provided we return successfully from here").
> 
> I have no objection to the change as-is - especially if that usage is within
> the intended scope of this API - I just wanted to call it out in case you're
> also planning to introduce something else which would be even more
> appropriate for that.

Yes, the purpose of the device_iommu_mapped() functions is to check
whether the device has been initialized by the IOMMU driver that handles
it, if any.

So it answers the question: Can I use the device in an IOMMU-API call?
And it is more readable than the dev->iommu_group checks everywhere :)

Regards,

	Joerg

