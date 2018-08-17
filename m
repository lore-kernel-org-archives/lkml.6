Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B98CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B77C21857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B77C21857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeHQJnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 05:43:31 -0400
Received: from verein.lst.de ([213.95.11.211]:33882 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeHQJnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 05:43:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E8F0668EEE; Fri, 17 Aug 2018 08:42:22 +0200 (CEST)
Date:   Fri, 17 Aug 2018 08:42:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC] etnaviv: missing dma_mask
Message-ID: <20180817064222.GB10811@lst.de>
References: <20180814141225.6123-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814141225.6123-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 05:12:25PM +0300, Eugeniy Paltsev wrote:
> Hi Lucas, Christoph,
> 
> After switching ARC to generic dma_noncoherent cache ops 
> etnaviv driver start failing on dma maping functions because of
> dma_mask lack.
> 
> So I'm wondering is it valid case to have device which is
> DMA capable and doesn't have dma_mask set?
> 
> If not, then I guess something like that should work
> (at least it works for ARC):

This looks ok is a minimal fix:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But why doesn't this device have a dma-range property in DT?
