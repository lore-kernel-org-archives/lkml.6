Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFCFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBCA214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SmK3y/gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBCA214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeIQTft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:35:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XwUNcg+Y1N6fDXhaxSJxvB73c5hhtw4SuqyVPzI3JgE=; b=SmK3y/gxIIj9M7Xj4TEEIQCL3
        7i1PPrcr9quu+WxEZpfpWBxKDhiuoHBZQR/lIQ4pbEiZ9T8J8LWHikpjveFvOOZYFwfG1xC+Uk0oe
        SzouTaVwjNa7VhjsYUrGPn+KyXHE5z61JUqgLfnEHzt7U0NHvoTbQLu+hGSKWIWcop9o7tCyz02VS
        UnoiOGzocn/+Cjveai7tFso5a28zGxjavsAcKIV6uYyVkP2R2kuh0vkWBQJhpLW5vtkl1Ux4me6C2
        i1xRe+2hV3e1D5xokdZudzUZfZ2ZE1FhC2nZwZmMQRRakjrz4xMed72nWPiZop5ejji+y9yR3bJbT
        OuoVBrpOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1uCG-0007bN-FV; Mon, 17 Sep 2018 14:08:16 +0000
Date:   Mon, 17 Sep 2018 07:08:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        Damien.LeMoal@wdc.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        terpstra@sifive.com
Subject: Re: [PATCH] RISCV: Fix end PFN for low memory
Message-ID: <20180917140816.GA28689@infradead.org>
References: <1536690618-9157-1-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536690618-9157-1-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:30:18AM -0700, Atish Patra wrote:
> Use memblock_end_of_DRAM which provides correct last low memory
> PFN. Without that, DMA32 region becomes empty resulting in zero
> pages being allocated for DMA32.
> 
> This patch is based on earlier patch from palmer which never
> merged into 4.19. I just edited the commit text to make more
> sense.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Palmer, can you queue this up for 4.19?
