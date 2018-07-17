Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F98ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF94A20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF94A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nocrew.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGQRHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:07:03 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:40682 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729620AbeGQRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:07:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 594D83F428;
        Tue, 17 Jul 2018 18:33:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id suxv1dsbpikH; Tue, 17 Jul 2018 18:33:32 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1BB013F32B;
        Tue, 17 Jul 2018 18:33:31 +0200 (CEST)
Date:   Tue, 17 Jul 2018 18:33:30 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        Geoff Levand <geoff@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        JuergenUrban@gmx.de
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180717163330.GE2342@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
 <20180705193613.GA28905@lst.de>
 <20180715122826.GB2342@localhost.localdomain>
 <20180717145725.GA22109@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717145725.GA22109@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, Geoff,

[ CC-ing Geoff to give him an opportunity to chime in about the PS3 part. ]

> > Here are three other regressions related to the coherent mask WARN_ON_ONCE:
> 
> They are a pretty strong indication that yes, you should really set
> the coherent mask if you ever do coherent allocations..

I'm unfortunately unfamiliar with the USB drivers for the PS3. Geoff, what
do you think about setting a coherent mask?

Christoph, what mask value would you suggest for the PS2 driver? Typical
DMA addresses 0-0x200000 are mapped to 0x1c000000-0x1c200000 and is memory
managed exclusively by the IOP. Robin indicated that DMA_BIT_MASK(20) or a
nonzero but useless value such as 1 are possibly candidates. It seems quite
unclear what the coherent mask actually means in this case, doesn't it?

Fredrik
