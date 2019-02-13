Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EABC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8661E222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390765AbfBMSYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:24:38 -0500
Received: from verein.lst.de ([213.95.11.211]:44559 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728875AbfBMSYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:24:37 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 76AFD68C8E; Wed, 13 Feb 2019 19:24:35 +0100 (CET)
Date:   Wed, 13 Feb 2019 19:24:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
Message-ID: <20190213182435.GA19906@lst.de>
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-7-hch@lst.de> <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 02:40:23PM -0600, Rob Herring wrote:
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index 3607fd2810e4..f8c66a9472a4 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -43,6 +43,7 @@ config OF_FLATTREE
> >
> >  config OF_EARLY_FLATTREE
> >         bool
> > +       select DMA_DECLARE_COHERENT
> 
> Is selecting DMA_DECLARE_COHERENT okay on UML? We run the unittests with UML.

No, that will fail with undefined references to memunmap.

I gues this needs to be

	select DMA_DECLARE_COHERENT if HAS_DMA

> Maybe we should just get rid of OF_RESERVED_MEM. If we support booting
> from DT, then it should always be enabled anyways.

Fine with me.  Do you want me to respin the series to just remove
it?
