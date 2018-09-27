Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3965AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38392168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38392168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeI0Wql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:46:41 -0400
Received: from verein.lst.de ([213.95.11.211]:46225 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbeI0Wql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:46:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9131268B02; Thu, 27 Sep 2018 18:27:37 +0200 (CEST)
Date:   Thu, 27 Sep 2018 18:27:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask
 handling
Message-ID: <20180927162737.GA11974@lst.de>
References: <20180920185247.20037-1-hch@lst.de> <20180920185247.20037-5-hch@lst.de> <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com> <20180927153252.GE10566@lst.de> <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 05:14:56PM +0100, Robin Murphy wrote:
>> This just seemed more readable to me than min_not_zero, but if others
>> prefer min_not_zero I can switch.
>
> Nah, just checking whether there were any intentionally different 
> assumptions compared to the couple of other places in the patch where 
> min_not_zero() *is* used. If it's purely a style thing then no worries 
> (personally I'd have written it yet another way anyway).

I'm curious: how would you have written it?
