Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81FC20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549007873;
	bh=mPW1kdJvdfWF8y1sFgd0mQFVOp3ErO00h4ymz2Z7ngI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=F33maJvPfTapFgem2nB6cxLZJku9mrQYoBP87DBqog+9ZiCPzCBtsnImY3QOphdwJ
	 URs+JiL7FaOgAFNzS9IR5KjYTQBfS0ZJnk0cWc9dxAaFtyDMhAYnaHRWAlD5l8Kg7V
	 YlawJN3E1u74OWtObpSBYGyivVI0+4ZrkGB7njq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfBAH5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:57:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfBAH5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:57:51 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089472084A;
        Fri,  1 Feb 2019 07:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549007870;
        bh=mPW1kdJvdfWF8y1sFgd0mQFVOp3ErO00h4ymz2Z7ngI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=afmZo3YG5x42LIXPyg6Bm3iewdgEtE7goI9bXwIQwsV3K6N1ZexItakuNwT+Jz0a8
         QyACpsKz63wNVbrmy1SOxunh0feg3PF/B7DR6g1dvk55dZJ3N++8KTdXjvWUyMuWR1
         M5vWP2UyMPd6JboVkhANvPPQByydSBi8aN1Hiff8=
Date:   Fri, 1 Feb 2019 08:57:39 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190201085739.775add3f@bbrezillon>
In-Reply-To: <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
        <20190131161515.21605-11-tudor.ambarus@microchip.com>
        <20190131173207.56481a42@bbrezillon>
        <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 07:07:40 +0000
<Tudor.Ambarus@microchip.com> wrote:

> >   
> >>  #define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
> >>  #define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
> >>  #define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)  
> > 
> > Looks like the read/write flag is on bit 13. Can we just add  
> 
> for sama5d2 only

Feel free to prefix macros with the SoC name to make it clear:

#define QSPI_IFR_SAMA5D2_WRITE_TRSFR		BIT(13)

> 
> > 
> > #define QSPI_IFR_TFRTYP_TRSFR_WRITE	BIT(13)
> > 
> > and drop all others def? This way the implementation is consistent
> > between sam9x60 and sama5d2.  
> 
> BIT(13) has no meaning for sam9x60. I can drop the macros with zero value for
> sama5d2 in a separate patch.
> >   
> >> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)

And this one would be

define QSPI_IFR_SAM9X60_READ_TRSFR		BIT(24)

> >>  
> >>  /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
> >>  #define QSPI_SMR_SCREN                  BIT(0)
> >> @@ -137,16 +144,37 @@
> >>  #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
> >>  
> >>  
> >> +/* Describes register values. */
> >> +struct atmel_qspi_cfg {
> >> +	u32 icr;
> >> +	u32 iar;
> >> +	u32 ifr;
> >> +};
> >> +
> >> +struct atmel_qspi_caps;
> >> +
> >>  struct atmel_qspi {
> >>  	void __iomem		*regs;
> >>  	void __iomem		*mem;
> >>  	struct clk		*clk;  
> > 
> > Can we rename that on pclk?  
> 
> will rename it, together with the support for unnamed clock of sama5d2 in a separate
> patch. The dt-bindings patch that imposes "pclk" for sama5d2 should be separated too.

Sounds good.
