Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E44C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE80D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE80D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbeGaJnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:43:42 -0400
Received: from verein.lst.de ([213.95.11.211]:56131 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbeGaJnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:43:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D6F9368D40; Tue, 31 Jul 2018 10:08:57 +0200 (CEST)
Date:   Tue, 31 Jul 2018 10:08:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Subject: Re: [PATCH v2 4/4] ARC: don't check for HIGHMEM pages in
        arch_dma_alloc
Message-ID: <20180731080857.GB23303@lst.de>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com> <20180730162636.3556-5-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730162636.3556-5-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 07:26:36PM +0300, Eugeniy Paltsev wrote:
> __GFP_HIGHMEM flag is cleared by upper layer functions
> (in include/linux/dma-mapping.h) so we'll never get a
> __GFP_HIGHMEM flag in arch_dma_alloc gfp argument.
> That's why alloc_pages will never return highmem page
> here.
> 
> Get rid of highmem pages handling and cleanup arch_dma_alloc
> and arch_dma_free functions.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
