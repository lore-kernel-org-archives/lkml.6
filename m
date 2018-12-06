Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02358C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DB420878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DB420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeLFOYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:24:24 -0500
Received: from verein.lst.de ([213.95.11.211]:57371 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeLFOYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:24:24 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5757A68AA6; Thu,  6 Dec 2018 15:24:23 +0100 (CET)
Date:   Thu, 6 Dec 2018 15:24:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, cai@gmx.us, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/8] dma-debug: Dynamically expand the
 dma_debug_entry pool
Message-ID: <20181206142423.GB24642@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com> <8ba34734842beb3ef72260c4ab822dba7c588e4c.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba34734842beb3ef72260c4ab822dba7c588e4c.1544037783.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -47,6 +47,8 @@
>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>  #endif

FYI, I think we should drop the potential arch hook with the ifndef
here once we support the dynamic adjustment.

> +		if (dma_debug_create_entries(DMA_DEBUG_DYNAMIC_ENTRIES, GFP_ATOMIC)) {

Overly long line.
