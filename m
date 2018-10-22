Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA38C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFD420658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFD420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeJVUIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:08:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48627 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbeJVUIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:08:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 679C9208C7; Mon, 22 Oct 2018 13:50:26 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id E48142079D;
        Mon, 22 Oct 2018 13:50:15 +0200 (CEST)
Date:   Mon, 22 Oct 2018 13:50:15 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20181022135015.1b13cdbd@bbrezillon>
In-Reply-To: <VI1PR04MB1038034CFABEE936C6892D7D99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <VI1PR04MB1038034CFABEE936C6892D7D99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 11:43:40 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> + Mark Brown
> 
> Complete patch series[1]
> [1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70210

Please resend the patch series with a "PATCH RESEND v4" prefix and
explain why you resend it in the cover letter.

> 
> --
> Regards,
> Yogesh Gaur
> 
> > -----Original Message-----
> > From: Yogesh Narayan Gaur [mailto:yogeshnarayan.gaur@nxp.com]
> > Sent: Thursday, October 11, 2018 4:30 PM
> > To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> > marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> > arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh Narayan
> > Gaur <yogeshnarayan.gaur@nxp.com>
> > Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
> > 
> > - Add driver for NXP FlexSPI host controller
> > 
> >  FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,  which
> > supports two SPI channels and up to 4 external devices.
> >  Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8
> > bidirectional data lines)  i.e. FlexSPI acts as an interface to external devices,
> > maximum 4, each with up to 8  bidirectional data lines.
> > 
> > - Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
> > filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS
> > targets.
> >  LX2160ARDB is having two NOR slave device connected on single bus A  i.e. A0
> > and A1 (CS0 and CS1).
> >  LX2160AQDS is having two NOR slave device connected on separate buses  one
> > flash on A0 and second on B1 i.e. (CS0 and CS3).
> >  Verified this driver on following SPI NOR flashes:
> >    Micron, mt35xu512aba[3], [Read - 1 bit mode]
> >    Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> > 
> > [1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
> > [2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=26689
> > [3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70179
> > 
> > Yogesh Gaur (5):
> >   spi: spi-mem: Add driver for NXP FlexSPI controller
> >   dt-bindings: spi: add binding file for NXP FlexSPI controller
> >   arm64: dts: lx2160a: add FlexSPI node property
> >   arm64: defconfig: enable NXP FlexSPI driver
> >   MAINTAINERS: add maintainers for the NXP FlexSPI driver
> > 
> > Changes for v4:
> > - Incorporated review comments for
> >   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > - Incorporated binding file review comments.
> > Changes for v3:
> > - Incorporated review comments for
> >   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > Changes for v2:
> > - Incorporated Boris review comments and drop below patches as per the
> > comments.
> >  - Patch 'spi: add slave device size in spi_device struct'
> >  - Patch 'spi: add flags for octal I/O data transfer'
> > - Incorporated DTS and Binding file review comments of Shawn Guo and Rob
> > Herring.
> > 
> >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   39 +
> >  MAINTAINERS                                        |    6 +
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   22 +
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
> >  arch/arm64/configs/defconfig                       |    1 +
> >  drivers/spi/Kconfig                                |   10 +
> >  drivers/spi/Makefile                               |    1 +
> >  drivers/spi/spi-nxp-fspi.c                         | 1158 ++++++++++++++++++++
> >  8 files changed, 1249 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> >  create mode 100644 drivers/spi/spi-nxp-fspi.c
> > 
> > --
> > 2.7.4  
> 

