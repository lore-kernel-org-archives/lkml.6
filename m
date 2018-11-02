Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5692081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5692081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeKCC5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:57:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbeKCC5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:57:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312FAA78;
        Fri,  2 Nov 2018 10:49:54 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F063F71E;
        Fri,  2 Nov 2018 10:49:52 -0700 (PDT)
Date:   Fri, 2 Nov 2018 17:49:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] arm64: hide unused swiotlb functions
Message-ID: <20181102174949.GJ218059@arrakis.emea.arm.com>
References: <20181102152624.1189250-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102152624.1189250-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:26:07PM +0100, Arnd Bergmann wrote:
> After a good chunk of the swiotlb code has been replaced with the generic
> version, two functions are only used from inside of an #ifdef:
> 
> arch/arm64/mm/dma-mapping.c:174:12: error: '__swiotlb_mmap_pfn' defined but not used [-Werror=unused-function]
>  static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
>             ^~~~~~~~~~~~~~~~~~
> arch/arm64/mm/dma-mapping.c:163:12: error: '__swiotlb_get_sgtable_page' defined but not used [-Werror=unused-function]
>  static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
> 
> Move them into the same #ifdef section to avoid that warning.
> 
> Fixes: 886643b76632 ("arm64: use the generic swiotlb_dma_ops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Christoph already proposed a fix here:

https://marc.info/?l=linux-arm-kernel&m=154091441602535

-- 
Catalin
