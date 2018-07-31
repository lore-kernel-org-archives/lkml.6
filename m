Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06789C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6626920870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6626920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeGaJmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:42:07 -0400
Received: from verein.lst.de ([213.95.11.211]:56121 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbeGaJmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:42:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 36AF768D40; Tue, 31 Jul 2018 10:07:23 +0200 (CEST)
Date:   Tue, 31 Jul 2018 10:07:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common
        code
Message-ID: <20180731080723.GA23303@lst.de>
References: <20180730073842.16092-1-hch@lst.de> <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:17:13PM -0500, Bjorn Helgaas wrote:
> [+cc Joerg]
> 
> On Mon, Jul 30, 2018 at 09:38:42AM +0200, Christoph Hellwig wrote:
> > There is nothing arch specific about PCI or dma-debug, so move this
> > call to common code just after registering the bus type.
> 
> I assume that previously, even if the user set CONFIG_DMA_API_DEBUG=y
> we only got PCI DMA debug on powerpc, sh, and x86.  And after this
> patch, we'll get PCI DMA debug on *all* arches?

Yes.  Note that this only covers the actual bus related part, that
is warning about outstanding dma mappings on unload.  The rest of the
dma api debugging already is entirely generic.
