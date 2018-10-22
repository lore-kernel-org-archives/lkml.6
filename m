Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77122ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F2A20779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F2A20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeJVR1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:27:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43912 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJVR1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:27:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DB5AB207A3; Mon, 22 Oct 2018 11:09:19 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7809F20711;
        Mon, 22 Oct 2018 11:09:19 +0200 (CEST)
Date:   Mon, 22 Oct 2018 11:09:19 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
Message-ID: <20181022110919.2b44f0e6@bbrezillon>
In-Reply-To: <VI1PR04MB1038A95F9378AAEAC8D75CB399F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
        <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017090724.12f2cd79@bbrezillon>
        <20181017091045.124e0266@bbrezillon>
        <20181017092941.3658bd9a@bbrezillon>
        <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017115237.07310b74@bbrezillon>
        <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022100152.05da1b6c@bbrezillon>
        <VI1PR04MB1038A95F9378AAEAC8D75CB399F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 08:32:21 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> HI,
> 
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Monday, October 22, 2018 1:32 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Tudor Ambarus
> > <tudor.ambarus@microchip.com>; marek.vasut@gmail.com;
> > dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> > linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; linux-arm-
> > kernel@lists.infradead.org; Cristian.Birsan@microchip.com; Mark Brown
> > <broonie@kernel.org>
> > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
> > NOR flash memories
> > 
> > On Mon, 22 Oct 2018 06:04:13 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >   
> > > -static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const
> > > u32 *smpt)
> > > +static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const
> > > +u32 *smpt, u32 smpt_len)
> > >  {
> > >         const u32 *ret = NULL;
> > > -       u32 i, addr;
> > > +       u32 i, addr, nmaps;
> > >         int err;
> > >         u8 addr_width, read_opcode, read_dummy;
> > >         u8 read_data_mask, data_byte, map_id;
> > > +       bool map_id_is_valid = false;
> > >
> > >         addr_width = nor->addr_width;
> > >         read_dummy = nor->read_dummy;
> > >         read_opcode = nor->read_opcode;
> > >
> > > +       for (i = 0; i<smpt_len; i++)
> > > +               pr_info("%s:%i smpt[%d]=%08x\n", __func__, __LINE__,
> > > + i, smpt[i]);
> > > +
> > >         map_id = 0;
> > > -       i = 0;
> > >         /* Determine if there are any optional Detection Command Descriptors */
> > > -       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> > > +       for (i = 0; i< smpt_len; i++) {
> > > +               if (!(smpt[i] & SMPT_DESC_TYPE_MAP))
> > > +                       break;
> > > +
> > >                 read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
> > >                 nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
> > >                 nor->read_dummy = spi_nor_smpt_read_dummy(nor,
> > > smpt[i]);  
> > 
> > Could you also print the ->addr_width, ->read_dummy and ->read_opcode here?
> >   
> It didn't showing any print messages here, did above line "         if (!(smpt[i] & SMPT_DESC_TYPE_MAP))" also needs to be changes to "    if ((smpt[i] & SMPT_DESC_TYPE_MAP))"?

Yes.

> 
> Below is the log, with the suggested change of modifying as
> > +       for (nmaps = 0; nmaps< smpt_len; nmaps++) {
> > +               if((smpt[nmaps] & SMPT_DESC_TYPE_MAP))  
> 
> [    1.625992] m25p80 spi0.0: found s25fl512s, expected m25p80                                                                   
> [    1.631681] spi_nor_get_map_in_use:2880 smpt[0]=08ff65fc                                                                      
> [    1.636988] spi_nor_get_map_in_use:2880 smpt[1]=00000004                                                                      
> [    1.642292] spi_nor_get_map_in_use:2880 smpt[2]=04ff65fc                                                                      
> [    1.647596] spi_nor_get_map_in_use:2880 smpt[3]=00000002                                                                      
> [    1.652898] spi_nor_get_map_in_use:2880 smpt[4]=02ff65fd                                                                      
> [    1.658200] spi_nor_get_map_in_use:2880 smpt[5]=00000004                                                                      
> [    1.663503] spi_nor_get_map_in_use:2880 smpt[6]=ff0201fe                                                                      
> [    1.668806] spi_nor_get_map_in_use:2880 smpt[7]=00007ff1                                                                      
> [    1.674108] spi_nor_get_map_in_use:2880 smpt[8]=00037ff4                                                                      
> [    1.679412] spi_nor_get_map_in_use:2880 smpt[9]=03fbfff4                                                                      
> [    1.684715] spi_nor_get_map_in_use:2880 smpt[10]=ff0203fe                                                                     
> [    1.690105] spi_nor_get_map_in_use:2880 smpt[11]=03fbfff4                                                                     
> [    1.695495] spi_nor_get_map_in_use:2880 smpt[12]=00037ff4                                                                     
> [    1.700886] spi_nor_get_map_in_use:2880 smpt[13]=00007ff1                                                                     
> [    1.706275] spi_nor_get_map_in_use:2880 smpt[14]=ff0005ff                                                                     
> [    1.711664] spi_nor_get_map_in_use:2880 smpt[15]=03fffff4                                                                     
> [    1.717053] spi_nor_get_map_in_use:2910 NO map_id                                                                             
> [    1.721777] m25p80 spi0.0: s25fl512s (65536 Kbytes)                
> 
> Didn't throw any return error.
> 
> --
> Regards,
> Yogesh Gaur
> 
> 
> > > @@ -2894,18 +2900,35 @@ static const u32 *spi_nor_get_map_in_use(struct  
> > spi_nor *nor, const u32 *smpt)  
> > >                  * Configuration that is currently in use.
> > >                  */
> > >                 map_id = map_id << 1 | !!(data_byte & read_data_mask);
> > > +               map_id_is_valid = true;
> > >                 i = i + 2;
> > >         }  
> 

