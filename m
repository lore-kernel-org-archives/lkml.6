Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8AFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35F82083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35F82083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeKGHTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:19:18 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:46574 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeKGHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:19:17 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-84-88-nat.elisa-mobile.fi [85.76.84.88])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id E996C4002C;
        Tue,  6 Nov 2018 23:51:57 +0200 (EET)
Date:   Tue, 6 Nov 2018 23:51:57 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] OCTEON MMC driver failure with v4.19
Message-ID: <20181106215157.GD14958@darkstar.musicnaut.iki.fi>
References: <20181026205423.GD3792@darkstar.musicnaut.iki.fi>
 <20181105220632.GA5083@darkstar.musicnaut.iki.fi>
 <20181106062724.GA12413@lst.de>
 <20181106090511.GA14958@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106090511.GA14958@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 06, 2018 at 11:05:11AM +0200, Aaro Koskinen wrote:
> On Tue, Nov 06, 2018 at 07:27:24AM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 06, 2018 at 12:06:32AM +0200, Aaro Koskinen wrote:
> > > With the below change, the MMC card probe seems to with v4.19. But it
> > > feels a bit hackish, don't you think... Is there some obvious simple
> > > fix that I'm missing? Any comments?
> > 
> > Please just use dma_coerce_mask_and_coherent in the platform drivers
> > instead.
> 
> Tried, but that doesn't help with v4.19:
> 
> [    1.290698] octeon_mmc 1180000002000.mmc: dma_coerce_mask_and_coherent(): -5
> [    1.297825] octeon_mmc: probe of 1180000002000.mmc failed with error -5
> 
> A.

Just for the archives, the fix is: https://patchwork.kernel.org/patch/10670177/

A.
