Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E5C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfAOH6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:58:08 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:43861 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725869AbfAOH6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:58:08 -0500
X-UUID: 58e05d900cf64d8db2d5414960be55f7-20190115
X-UUID: 58e05d900cf64d8db2d5414960be55f7-20190115
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1134881265; Tue, 15 Jan 2019 15:57:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 15:57:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 15 Jan 2019 15:57:54 +0800
Message-ID: <1547539075.18705.3.camel@mtkswgap22>
Subject: Re: [PATCH v1 3/3] mtd: spi-nor: mtk-quadspi: rename config to a
 common one
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <marek.vasut@gmail.com>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <robh+dt@kernel.org>,
        <weijie.gao@mediatek.com>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 15 Jan 2019 15:57:55 +0800
In-Reply-To: <fc95a69a-6a2e-fc98-d047-b0c93843fc56@microchip.com>
References: <67e650ca4fcaaddbbc98bf4e1cbe04647c990dc3.1547442452.git.ryder.lee@mediatek.com>
         <45dc2817e7f4baf5113de247b1a2cb30bf252d93.1547442452.git.ryder.lee@mediatek.com>
         <fc95a69a-6a2e-fc98-d047-b0c93843fc56@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 07:34 +0000, Tudor.Ambarus@microchip.com wrote:
> Hi, Ryder,
> 
> On 01/14/2019 07:12 AM, Ryder Lee wrote:
> > The quadspi is a generic communication interface which could be shared
> > with other MediaTek SoCs. Hence rename it to a common one.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> > Changes since v1: rebase to v5.0-rc1. 
> 
> The patch doesn't apply on v5.0-rc1 or rc2.
> > ---
> >  drivers/mtd/spi-nor/Kconfig  | 16 ++++++++--------
> >  drivers/mtd/spi-nor/Makefile |  2 +-
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> > index b433e5f..99d9d53 100644
> > --- a/drivers/mtd/spi-nor/Kconfig
> > +++ b/drivers/mtd/spi-nor/Kconfig
> > @@ -7,14 +7,6 @@ menuconfig MTD_SPI_NOR
> >  
> >  if MTD_SPI_NOR
> >  
> > -config MTD_MT81xx_NOR
> > -	tristate "Mediatek MT81xx SPI NOR flash controller"
> > -	depends on HAS_IOMEM
> > -	help
> > -	  This enables access to SPI NOR flash, using MT81xx SPI NOR flash
> > -	  controller. This controller does not support generic SPI BUS, it only
> > -	  supports SPI NOR Flash.
> > -
> >  config MTD_SPI_NOR_USE_4K_SECTORS
> >  	bool "Use small 4096 B erase sectors"
> >  	default y
> > @@ -68,6 +60,14 @@ config SPI_NXP_SPIFI
> >  	  Flash. Enable this option if you have a device with a SPIFI
> >  	  controller and want to access the Flash as a mtd device.
> >  
> > +config SPI_MTK_QUADSPI
> 
> Since you are moving the config into the file, would you mind to put your config
> in an alphabetical order?
> 
> Thanks,
> ta

Okay, I will send a new one to fix them.

Thanks,
Ryder

> > +	tristate "MediaTek Quad SPI controller"
> > +	depends on HAS_IOMEM
> > +	help
> > +	  This enables support for the Quad SPI controller in master mode.
> > +	  This controller does not support generic SPI. It only supports
> > +	  SPI NOR.
> > +
> >  config SPI_INTEL_SPI
> >  	tristate
> >  
> > diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> > index 2adedbe..189a15c 100644
> > --- a/drivers/mtd/spi-nor/Makefile
> > +++ b/drivers/mtd/spi-nor/Makefile
> > @@ -3,7 +3,7 @@ obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
> >  obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
> >  obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= cadence-quadspi.o
> >  obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
> > -obj-$(CONFIG_MTD_MT81xx_NOR)    += mtk-quadspi.o
> > +obj-$(CONFIG_SPI_MTK_QUADSPI)    += mtk-quadspi.o
> >  obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
> >  obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
> >  obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
> > 


