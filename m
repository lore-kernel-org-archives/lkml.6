Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3EBC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E815D20863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E815D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439673AbeKWXrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:47:22 -0500
Received: from 8bytes.org ([81.169.241.247]:49334 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388506AbeKWXrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:47:21 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7979B1A4; Fri, 23 Nov 2018 14:03:13 +0100 (CET)
Date:   Fri, 23 Nov 2018 14:03:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, jdmason@kudzu.us,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Message-ID: <20181123130313.GI1586@8bytes.org>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
 <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <20181123104918.GE1586@8bytes.org>
 <20181123110155.GR30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123110155.GR30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:01:55AM +0000, Russell King - ARM Linux wrote:
> Yuck.  So, if we have a 4GB non-PAE 32-bit system, or a PAE system
> where we have valid memory across the 4GB boundary and no IOMMU,
> we have to reserve the top 4K page in the first 4GB of RAM?

But that is only needed when dma_addr_t is 32bit anyway, no?

> Rather than inventing magic cookies like this, I'd much rather we
> sanitised the API so that we have functions that return success or
> an error code, rather than trying to shoe-horn some kind of magic
> error codes into dma_addr_t and subtly break systems in the process.

Sure, but is has the obvious downside that we need to touch every driver
that uses these functions, and that are probably a lot of drivers.


Regards,

	Joerg
