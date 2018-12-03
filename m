Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34FBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD03B20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD03B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeLCReU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:34:20 -0500
Received: from verein.lst.de ([213.95.11.211]:38583 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLCReU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:34:20 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E8BC468AFE; Mon,  3 Dec 2018 18:34:12 +0100 (CET)
Date:   Mon, 3 Dec 2018 18:34:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
Subject: Re: [PATCH 0/4] dma-debug: implement dynamic entry allocation
Message-ID: <20181203173412.GA8509@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543856576.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:28:05PM +0000, Robin Murphy wrote:
> The HNS_ENET discussion got me thinking, why not just make DMA debug
> cleverer so that (in terms of basic functionality at least) we don't
> need to worry about driver- or arch-specific configuration at all?
> 
> Patches #2 and #3 are the real meat here - #1 is just some preparatory
> cleanup motivated by moving printks around, and could be split out if
> desired; I kept #4 separate as a possible nice-to-have depending on
> what people think.

Hah, I just thought of this and suggested it a few seconds ago.
So obviously I think it is a good idea, but let me look at the details.
