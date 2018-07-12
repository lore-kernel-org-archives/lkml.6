Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6654C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0A120C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0A120C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeGLH1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:27:18 -0400
Received: from verein.lst.de ([213.95.11.211]:57047 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbeGLH1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:27:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5B03B6FB7B; Thu, 12 Jul 2018 09:20:51 +0200 (CEST)
Date:   Thu, 12 Jul 2018 09:20:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org
Subject: Re: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
Message-ID: <20180712072051.GC15624@lst.de>
References: <cover.1531239284.git.robin.murphy@arm.com> <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com> <20180710180433.GB26285@lst.de> <868cead9-88a7-e58d-3452-a78e19be5f47@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868cead9-88a7-e58d-3452-a78e19be5f47@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 05:56:40PM +0100, Robin Murphy wrote:
> Indeed, once we've found an approach that everyone's happy with we can have 
> a more thorough audit of exactly where else it needs to be applied. FWIW 
> I'm not aware of any 32-bit Arm systems affected by this*, but if they do 
> exist then at least there's no risk of regression since they've always been 
> busted.

Ok, great.  I just assumed arm might be affected due to the fact that
it currently parses dma-ranges DT properties.
