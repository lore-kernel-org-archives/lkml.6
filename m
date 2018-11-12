Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92FDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F09C223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F09C223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbeKMACB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:02:01 -0500
Received: from 8bytes.org ([81.169.241.247]:39850 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeKMACB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:02:01 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9B467533; Mon, 12 Nov 2018 15:08:34 +0100 (CET)
Date:   Mon, 12 Nov 2018 15:08:33 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Filippo Sironi <sironi@amazon.de>, Wei Wang <wawei@amazon.de>
Subject: Re: [PATCH] amd/iommu: Fix Guest Virtual APIC Log Tail Address
 Register
Message-ID: <20181112140833.uctt6mfi6lxb37fn@8bytes.org>
References: <20181112122611.129219-1-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112122611.129219-1-Suravee.Suthikulpanit@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:26:30PM +0000, Suthikulpanit, Suravee wrote:
> From: Filippo Sironi <sironi@amazon.de>
> 
> This register should have been programmed with the physical address
> of the memory location containing the shadow tail pointer for
> the guest virtual APIC log instead of the base address.
> 
> Fixes: 8bda0cfbdc1a  ('iommu/amd: Detect and initialize guest vAPIC log')
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> Signed-off-by: Wei Wang <wawei@amazon.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd_iommu_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to iommu/fixes, thanks.

