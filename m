Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35728C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23CA20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23CA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJDTFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:05:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35320 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeJDTFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:05:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9717020719; Thu,  4 Oct 2018 14:12:04 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 32ABF20618;
        Thu,  4 Oct 2018 14:12:04 +0200 (CEST)
Date:   Thu, 4 Oct 2018 14:12:04 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] spi: add support for octal I/O data transfer
Message-ID: <20181004141204.04168a22@bbrezillon>
In-Reply-To: <VI1PR04MB10384B74E6E27435313CC73099EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181004110446.5e1bb255@bbrezillon>
        <VI1PR04MB10380FD9CE99E34BA27E55B699EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181004111941.0da33ec0@bbrezillon>
        <VI1PR04MB1038E23CBFE9CFD5C2ECCD3299EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <VI1PR04MB10384B74E6E27435313CC73099EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018 12:07:17 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
> 
> > -----Original Message-----
> > From: Yogesh Narayan Gaur
> > Sent: Thursday, October 4, 2018 2:56 PM
> > To: 'Boris Brezillon' <boris.brezillon@bootlin.com>
> > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com;
> > linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> > mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> > kernel@lists.infradead.org; computersforpeace@gmail.com;
> > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH 1/4] spi: add support for octal I/O data transfer
> > 
> > Hi Boris,
> >   
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Thursday, October 4, 2018 2:50 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > vigneshr@ti.com; linux-spi@vger.kernel.org;
> > > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > > shawnguo@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > computersforpeace@gmail.com; frieder.schrempf@exceet.de;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH 1/4] spi: add support for octal I/O data transfer
> > >
> > > On Thu, 4 Oct 2018 09:14:36 +0000
> > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >  
> > > > Hi Boris,
> > > >  
> > > > > -----Original Message-----
> > > > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > > > Sent: Thursday, October 4, 2018 2:35 PM
> > > > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > > > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > > > vigneshr@ti.com; linux-spi@vger.kernel.org;
> > > > > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > > > > shawnguo@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > > > computersforpeace@gmail.com; frieder.schrempf@exceet.de;
> > > > > linux-kernel@vger.kernel.org Subject: Re: [PATCH 1/4] spi: add
> > > > > support for octal I/O data transfer
> > > > >
> > > > > Hi Yogesh,
> > > > >  
> [...]
> > > > > > +#define	SPI_RX_OCTAL
> > > > > > 0x2000			/* receive with 8 wires  
> > > > > */  
> > > > > >  	int			irq;
> > > > > >  	void			*controller_state;
> > > > > >  	void			*controller_data;  
> > > > >
> > > > > You're still not updating spi-mem.c to check those flags and
> > > > > SPI_MEM_MAX_BUSWIDTH is not updated to match the new limit (8
> > > > > instead of 4).
> > > > >  
> > > > Yes and its strange that my octal mode communication is working fine
> > > > without adding support in spi-mem.c and that's why this has been
> > > > missed from me.  
> > >
> > > Are you based on top of spi-next?  
> > 
> > Ok, that might be the reason. I have rebased few days back.
> > Would rebase with current tip and add support in spi-mem interface too.  
> 
> I have rebased spi-next and currently on top but still my octal command support is working fine without any issue with current shared patch series, performed data sanity.
> 
> =>  git log  --pretty=oneline -3  
> 	496c415717b8bb7d37181127fcfad0ba450eb10d mtd: spi-nor: fsl-quadspi: Don't let -EINVAL on the bus
> 	2336d3a7b125683c9e8b25d6efa6064310d19dbe mtd: devices: m25p80: Make sure WRITE_EN is issued before each write
> 	e55841874471282d32eec595997afce43a5f55c0 mtd: spi-nor: Support controllers with limited TX FIFO size
> 
> GIT Repo - 	git://git.infradead.org/linux-mtd.git
> Branch -	remotes/origin/spi-nor/next
> 
> Also, I am not able to find string SPI_MEM_MAX_BUSWIDTH in current source code, can you share the GIT details where these changes are pushed.

It's in Mark's tree [1] (spi-next != spi-nor/next).

[1]https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/log/?h=for-next
