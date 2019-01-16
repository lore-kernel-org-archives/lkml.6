Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0FDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D51206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392967AbfAPNDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:03:37 -0500
Received: from 8bytes.org ([81.169.241.247]:57960 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390275AbfAPNDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:03:37 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D389B273; Wed, 16 Jan 2019 14:03:35 +0100 (CET)
Date:   Wed, 16 Jan 2019 14:03:34 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Mark translation invalid during device detach
Message-ID: <20190116130334.svrjkyr3dnfcj3u6@8bytes.org>
References: <20190116041432.3484-1-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116041432.3484-1-Suravee.Suthikulpanit@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Wed, Jan 16, 2019 at 04:15:10AM +0000, Suthikulpanit, Suravee wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> When a device switches domain, IOMMU driver detach device from the old
> domain, and attach device to the new domain. During this period
> the host table root pointer is not set, which means DMA translation
> should be marked as invalid (clear TV bit).
> 
> So, clear the TV bit when detach the device. The TV bit will be set
> again when attaching device to the new domain.

Is there a specific problem with setting the TV bit?

Note that the update will clear all other fields in the first 128 bits
of the DTE, which means that IR, IW and Mode are all set to 0. This
effectivly blocks all DMA requests from the device, which is by design.

Regards,

	Joerg
