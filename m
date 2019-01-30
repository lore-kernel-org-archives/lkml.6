Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C2C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7700221473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfA3IEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:04:25 -0500
Received: from verein.lst.de ([213.95.11.211]:50789 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfA3IEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:04:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4A33868CEC; Wed, 30 Jan 2019 09:04:23 +0100 (CET)
Date:   Wed, 30 Jan 2019 09:04:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/11] mmc: s3cmci: handle highmem pages
Message-ID: <20190130080423.GA29937@lst.de>
References: <20190114095804.27978-1-hch@lst.de> <20190114095804.27978-6-hch@lst.de> <CAPDyKFpcHv7KwuVpWcKjxj--n4YOFADWD5WzOCJ6Dca_JjqnAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpcHv7KwuVpWcKjxj--n4YOFADWD5WzOCJ6Dca_JjqnAw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:57:47AM +0100, Ulf Hansson wrote:
> On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Instead of setting up a kernel pointer to track the current PIO address,
> > track the offset in the current page, and do an atomic kmap for the page
> > while doing the actual PIO operations.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Nitpick: This one have some trailing whitespace errors, which git
> complains about when I apply it.
> 
> No need to re-spin due to this, I can fix it  up.

I'll need to respin to limit the segment size to a page anyway, so I
will take this into account as well for v2.
