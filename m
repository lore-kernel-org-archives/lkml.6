Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE86FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC55206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC55206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeINS02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:26:28 -0400
Received: from verein.lst.de ([213.95.11.211]:57695 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbeINS02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:26:28 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A4A4668D40; Fri, 14 Sep 2018 15:12:04 +0200 (CEST)
Date:   Fri, 14 Sep 2018 15:12:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-renesas-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] dma-mapping: clear dma_ops pointer also on ARM
Message-ID: <20180914131204.GA27141@lst.de>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com> <20180913151716.6333-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913151716.6333-3-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:17:15PM +0200, Wolfram Sang wrote:
> The generic fallback of arch_teardown_dma_ops() clears the dma_ops
> pointer but the ARM specific version does not. Rename the generic one,
> so it can be called from ARM specific one, too. This will ensure
> consistent behaviour.

Hmm.  I'd rather remove your new generic version entirely and move
the ops clearing into the two callers.
