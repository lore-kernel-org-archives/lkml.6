Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED12C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFA02082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFA02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeKAXfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:35:18 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:40306 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeKAXfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:35:18 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991034AbeKAOae1ajmS (ORCPT
        <rfc822;stable@vger.kernel.org> + 1 other);
        Thu, 1 Nov 2018 15:30:34 +0100
Date:   Thu, 1 Nov 2018 14:30:34 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a non-coherent
 allocation
In-Reply-To: <20181101083346.GA7136@lst.de>
Message-ID: <alpine.LFD.2.21.1811011405530.20378@eddie.linux-mips.org>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de>
 <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org> <20181101051359.GA4164@lst.de> <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org> <20181101083346.GA7136@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018, Christoph Hellwig wrote:

> Oops, yes this looks good:

 BTW, for anyone missing hardware suitable for serious DMA testing I can 
recommend getting a pair of DEFPA cards, the ubiquitous PCI version of 
this board, cheaply available, which is the same except for a different 
host bus bridge ASIC, developed later.  They can be wired back to back 
similarly to Ethernet adapters (or in a loop if you have 2 or more dual 
attachment versions), no other hardware is required save for patch cords.
Version 3 (DEFPA-xC) boards support universal PCI signalling, older ones 
are 5V-only.

 These devices are a stellar example of fine engineering[1].  Our `defxx' 
driver, which I believe has been adapted from the DEC OSF/1 one referred 
in the said document, has some latency and other issues that I plan to 
address sometime, once I have sorted higher-priority issues, however 
hardware itself is excellent.

References:

[1] Chran-Ham Chang et al., "High-performance TCP/IP and UDP/IP Networking 
    in DEC OSF/1 for Alpha AXP", Digital Technical Journal, vol. 5, no. 1 
    (Winter 1993), "Network Adapter Characteristics", p. 7
    <ftp://ftp.linux-mips.org/pub/linux/mips/people/macro/DEC/DTJ/DTJ904/DTJ904PF.PDF>

  Maciej
