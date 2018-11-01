Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F0EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60ED2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60ED2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeKAOPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:15:24 -0400
Received: from verein.lst.de ([213.95.11.211]:42293 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbeKAOPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:15:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 954DA6F9B7; Thu,  1 Nov 2018 06:13:59 +0100 (CET)
Date:   Thu, 1 Nov 2018 06:13:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma-mapping: merge direct and noncoherent ops
Message-ID: <20181101051359.GA4164@lst.de>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de> <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 08:50:53PM +0000, Maciej W. Rozycki wrote:
> On Wed, 31 Oct 2018, Christoph Hellwig wrote:
> 
> > Can you send me your .config?
> 
>  Sure, attached.
> 
>  This is an updated 4.19 defconfig I was going to submit as I tripped over 
> this problem, so just rename it to .config and use `make olddefconfig' to 
> regenerate a full version.

Fails to compile for me with:

cc1: error: ‘-march=r3000’ requires ‘-mfp32’

using the x86_64 corss gcc 8 from Debian testing.

Either way the config looks like we have all the required bits for
non-coherent dma support.  The only guess is that somehow
dma_cache_wback_inv aren't hooked up to the right functions for some
reason, but I can't really think off why.
