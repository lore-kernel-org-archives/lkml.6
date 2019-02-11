Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86031C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB20218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbfBKP7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:59:43 -0500
Received: from verein.lst.de ([213.95.11.211]:58072 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbfBKP7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:59:40 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5762868DD6; Mon, 11 Feb 2019 16:59:38 +0100 (CET)
Date:   Mon, 11 Feb 2019 16:59:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/19] dma-iommu: cleanup dma-iommu.h
Message-ID: <20190211155938.GA27745@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-3-hch@lst.de> <3f78b779-4360-1204-e942-39a8a81759c7@arm.com> <20190201161305.GI6532@lst.de> <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf081c2-2b8c-d3d1-c93e-468c8f3cef67@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:08:26PM +0000, Robin Murphy wrote:
> Other than dma-iommu.c itself, none of them *require* it - only arch/arm64 
> selects it (the one from MTK_IOMMU is just bogus), and a lot of the drivers 
> also build for at least one other architecture (and/or arm64 with 
> !IOMMU_API).
>
> Either way, I have no vehement objection to the change, I just don't see 
> any positive value in it.

I've moved the idef back down below the includes.
