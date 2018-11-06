Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB44FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB742085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB742085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbeKFPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:51:04 -0500
Received: from verein.lst.de ([213.95.11.211]:40974 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387399AbeKFPvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:51:04 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E330468C1D; Tue,  6 Nov 2018 07:27:24 +0100 (CET)
Date:   Tue, 6 Nov 2018 07:27:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] OCTEON MMC driver failure with v4.19
Message-ID: <20181106062724.GA12413@lst.de>
References: <20181026205423.GD3792@darkstar.musicnaut.iki.fi> <20181105220632.GA5083@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105220632.GA5083@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 12:06:32AM +0200, Aaro Koskinen wrote:
> With the below change, the MMC card probe seems to with v4.19. But it
> feels a bit hackish, don't you think... Is there some obvious simple
> fix that I'm missing? Any comments?

Please just use dma_coerce_mask_and_coherent in the platform drivers
instead.
