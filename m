Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2483AC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99AA2159B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdOMWNVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99AA2159B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJUAlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 20:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbeJUAlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 20:41:03 -0400
Received: from localhost (unknown [109.144.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52132157C;
        Sat, 20 Oct 2018 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540053003;
        bh=TkGO0Mth4UDODXhjIxtBr+f3eVKSFjCVTp0Etv/SWE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdOMWNVwrAKm3B0w5sGCPFWhVS7BDw/79j4x5N5TxAkFtS8nXG/JFqNWStxdZVFm/
         cuNCbDKAzdlUk5UyrD0sAJnOyBLSS0bhvmdBjxV60OpsVDvOoe9+tXTNLqoQ0dXXKO
         PQGInrPdtqjwa4C3nMW2FL9H9+0vjUjorBp2JM1c=
Date:   Sat, 20 Oct 2018 22:00:00 +0530
From:   Vinod <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Add some fixes and new feature for SPRD DMA
Message-ID: <20181020163000.GD2894@vkoul-mobl>
References: <cover.1538199697.git.baolin.wang@linaro.org>
 <CAMz4kuKFtbLMmNEbQ0oVgW87HPRwJuwFJH9cXVymz=6jH7xzOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuKFtbLMmNEbQ0oVgW87HPRwJuwFJH9cXVymz=6jH7xzOA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-18, 17:29, Baolin Wang wrote:
> Hi Vinod,
> 
> On 29 September 2018 at 13:48, Baolin Wang <baolin.wang@linaro.org> wrote:
> > This patchset removes the direction usage from struct dma_slave_config,
> > and add one new field to save the direction. It also fixes some issues
> > for link-list transfer. Moreover this patchset adds new 2-stage transfer
> > support for our DMA.
> 
> Do you have any comments for this patchset? Thanks a lot.

Sorry bit busy with things and ELC, I should be able to review this
after monday..

> 
> >
> > Baolin Wang (1):
> >   dmaengine: sprd: Remove direction usage from struct dma_slave_config
> >
> > Eric Long (6):
> >   dmaengine: sprd: Get transfer residue depending on the transfer
> >     direction
> >   dmaengine: sprd: Fix the last link-list configuration
> >   dmaengine: sprd: Set cur_desc as NULL when free or terminate one dma
> >     channel
> >   dmaengine: sprd: Support DMA link-list cyclic callback
> >   dmaengine: sprd: Support DMA 2-stage transfer mode
> >   dmaengine: sprd: Add me as one of the module authors
> >
> >  drivers/dma/sprd-dma.c       |  152 +++++++++++++++++++++++++++++++++++++-----
> >  include/linux/dma/sprd-dma.h |   62 ++++++++++++++++-
> >  2 files changed, 194 insertions(+), 20 deletions(-)
> >
> > --
> > 1.7.9.5
> >
> 
> 
> 
> -- 
> Baolin Wang
> Best Regards

-- 
~Vinod
