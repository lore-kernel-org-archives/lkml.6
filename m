Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF78FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B142320892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B142320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLGJcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:32:01 -0500
Received: from 8bytes.org ([81.169.241.247]:52344 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeLGJcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:32:01 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 042FA32E; Fri,  7 Dec 2018 10:31:58 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:31:58 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/of: Use device_iommu_mapped()
Message-ID: <20181207093158.GL16835@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-3-joro@8bytes.org>
 <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
 <20181206153512.GG16835@8bytes.org>
 <42cb32df-5358-f00d-12f5-eb3135ec680a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42cb32df-5358-f00d-12f5-eb3135ec680a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:42:16PM +0000, Robin Murphy wrote:
> For sure - although I am now wondering whether "mapped" is perhaps a little
> ambiguous in the naming, since the answer to "can I use the API" is yes even
> when the device may currently be attached to an identity/passthrough domain
> or blocked completely, neither of which involve any "mapping". Maybe simply
> "device_has_iommu()" would convey the intent better?

The name is shorter version of:

	device_is_behind_an_iommu_remapping_its_dma_transactions()
	:)

The name is not perfect, but device_has_iommu() is not better because it
might be considered as a check whether the device itself has an IOMMU
built-in.

In the end an identity-mapping is also still a mapping (if the iommu
needs a page-table for that is an implementation detail), as is a
mapping with no page-table entries at all (blocking). So I think
device_iommu_mapped() is a reasonable choice.

Regards,

	Joerg
