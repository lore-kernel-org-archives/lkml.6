Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2DEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8680420813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8680420813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeJWOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:01:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36856 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbeJWOBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:01:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A74D3208C7; Tue, 23 Oct 2018 07:39:56 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 349B8208B9;
        Tue, 23 Oct 2018 07:39:46 +0200 (CEST)
Date:   Tue, 23 Oct 2018 07:39:46 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
Message-ID: <20181023073946.138b287e@bbrezillon>
In-Reply-To: <VI1PR04MB1038B9A5A8C59E6CB0863FF599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20181017091045.124e0266@bbrezillon>
        <20181017092941.3658bd9a@bbrezillon>
        <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017115237.07310b74@bbrezillon>
        <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022111543.2a607efc@bbrezillon>
        <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022122659.0675942e@bbrezillon>
        <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022124627.2c6c3b93@bbrezillon>
        <20181022125259.42df83ea@bbrezillon>
        <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022134324.2c1bd248@bbrezillon>
        <VI1PR04MB1038E072BFFD09C7C19AD2F899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022135211.1978c25d@bbrezillon>
        <VI1PR04MB1038B9A5A8C59E6CB0863FF599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 04:47:33 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi,
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Monday, October 22, 2018 5:22 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: Cristian.Birsan@microchip.com; Tudor Ambarus
> > <tudor.ambarus@microchip.com>; richard@nod.at; Mark Brown
> > <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; Cyrille Pitchen
> > <cyrille.pitchen@wedev4u.fr>; computersforpeace@gmail.com;
> > dwmw2@infradead.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
> > NOR flash memories
> > 
> > On Mon, 22 Oct 2018 11:46:55 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >   
> > > Hi,
> > >  
> > > > -----Original Message-----
> > > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > > Sent: Monday, October 22, 2018 5:13 PM
> > > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > > Cc: Cristian.Birsan@microchip.com; Tudor Ambarus
> > > > <tudor.ambarus@microchip.com>; richard@nod.at; Mark Brown
> > > > <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > > > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > > > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > > > Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>;
> > > > computersforpeace@gmail.com; dwmw2@infradead.org;
> > > > linux-arm-kernel@lists.infradead.org
> > > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform
> > > > SFDP SPI NOR flash memories
> > > >
> > > > On Mon, 22 Oct 2018 11:03:09 +0000
> > > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > > >  
> > > > > Hi,
> > > > >  
> > > > > > -----Original Message-----
> > > > > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > > > > Sent: Monday, October 22, 2018 4:23 PM
> > > > > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> > > > > > Cristian.Birsan@microchip.com
> > > > > > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard@nod.at;
> > > > > > Mark Brown <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > > > > > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > > > > > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > > > > > Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>;
> > > > > > computersforpeace@gmail.com; dwmw2@infradead.org;
> > > > > > linux-arm-kernel@lists.infradead.org
> > > > > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to
> > > > > > non-uniform SFDP SPI NOR flash memories
> > > > > >
> > > > > > On Mon, 22 Oct 2018 12:46:27 +0200 Boris Brezillon
> > > > > > <boris.brezillon@bootlin.com> wrote:
> > > > > >  
> > > > > > > On Mon, 22 Oct 2018 10:39:48 +0000 Yogesh Narayan Gaur
> > > > > > > <yogeshnarayan.gaur@nxp.com> wrote:
> > > > > > >  
> > > Patch used
> > >
> > > --- a/drivers/mtd/spi-nor/spi-nor.c
> > > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > > @@ -2863,26 +2863,39 @@ static u8 spi_nor_smpt_read_dummy(const struct
> > > spi_nor *nor, const u32 settings)  
> >   
> > >         /* Determine if there are any optional Detection Command Descriptors */
> > > -       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> > > +       for (i = 0; i< smpt_len; i++) {  
> > 
> > See, you should have i += 2 here, not i++.  
> 
> Ok
> >   
> > > +               if ((smpt[i] & SMPT_DESC_TYPE_MAP))
> > > +                       break;
> > > +
> > >                 read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
> > >                 nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
> > > -               nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
> > > +               if (!nor->addr_width)
> > > +                       nor->addr_width = 3;
> > > +
> > > +               nor->read_dummy = 8; //spi_nor_smpt_read_dummy(nor,
> > > + smpt[i]);
> > >                 nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
> > > +               pr_info("smpt[%d]=[addr_width:%08x, read_dumy:%08x,
> > > + read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy,
> > > + nor->read_opcode);
> > > +
> > >                 addr = smpt[i + 1];
> > >
> > >                 err = spi_nor_read_raw(nor, addr, 1, &data_byte);  
> > 
> > And add a trace here to print data_byte and addr.
> >   
> Logs:
> [    1.625840] m25p80 spi0.0: found s25fl512s, expected m25p80                                                                   
> [    1.631536] Start [addr_width:00000000, read_dumy:00000000, read_opcode:00000000]                                             
> [    1.639013] spi_nor_get_map_in_use:2882 smpt[0]=08ff65fc                                                                      
> [    1.644317] spi_nor_get_map_in_use:2882 smpt[1]=00000004                                                                      
> [    1.649621] spi_nor_get_map_in_use:2882 smpt[2]=04ff65fc                                                                      
> [    1.654924] spi_nor_get_map_in_use:2882 smpt[3]=00000002                                                                      
> [    1.660229] spi_nor_get_map_in_use:2882 smpt[4]=02ff65fd                                                                      
> [    1.665532] spi_nor_get_map_in_use:2882 smpt[5]=00000004                                                                      
> [    1.670836] spi_nor_get_map_in_use:2882 smpt[6]=ff0201fe                                                                      
> [    1.676140] spi_nor_get_map_in_use:2882 smpt[7]=00007ff1                                                                      
> [    1.681444] spi_nor_get_map_in_use:2882 smpt[8]=00037ff4                                                                      
> [    1.686748] spi_nor_get_map_in_use:2882 smpt[9]=03fbfff4                                                                      
> [    1.692052] spi_nor_get_map_in_use:2882 smpt[10]=ff0203fe                                                                     
> [    1.697441] spi_nor_get_map_in_use:2882 smpt[11]=03fbfff4                                                                     
> [    1.702830] spi_nor_get_map_in_use:2882 smpt[12]=00037ff4                                                                     
> [    1.708220] spi_nor_get_map_in_use:2882 smpt[13]=00007ff1                                                                     
> [    1.713608] spi_nor_get_map_in_use:2882 smpt[14]=ff0005ff                                                                     
> [    1.718999] spi_nor_get_map_in_use:2882 smpt[15]=03fffff4                                                                     
> [    1.724388] smpt[0]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065]                                           
> [    1.732050] smpt_read[1] addr[00000004], data_byte[00000000] err:00000000                                                     
> [    1.738830] smpt[2]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065]                                           
> [    1.746491] smpt_read[3] addr[00000002], data_byte[00000002] err:00000000                                                     
> [    1.753270] smpt[4]=[addr_width:00000003, read_dumy:00000008, read_opcode:00000065]                                           
> [    1.760930] smpt_read[5] addr[00000004], data_byte[00000000] err:00000000  

Ok, so now the opcode and address are matching the values in the spec.
Can you check what's sent to the SPI controller side (in your
->exec_op() implementation), just to make sure the m25p80 propagates
the information correctly? When you do that, make sure you also print
the buswidth of each element (op->cmd.buswidth, op->addr.buswidth,
op->dummy.buswidth and op->data.buswidth).

Can you also print the read_data_mask value here.

Next thing you can do is read the CR2NV reg (using the RDAR command) and
check the RL (Read Latency) and AL (Address Length) values.

> [    1.767710] spi_nor_get_map_in_use:2915 map_id=0 smpt_len:16 i=:6                                                             
> [    1.773794] End [addr_width:00000003, read_dumy:00000008, read_opcode:00000065] ReturnVal:00000000                                
> [    1.781092] spi_nor_parse_smpt:3065                                                                                           
> [    1.784573] m25p80 spi0.0: failed to parse SMPT (err = -22)                                                                   
> [    1.790153] m25p80 spi0.0: s25fl512s (65536 Kbytes)  
> 
> 
> Code:
>         for (i = 0; i< smpt_len; i+=2) {
>                 if ((smpt[i] & SMPT_DESC_TYPE_MAP))
>                         break;
> 
>                 read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
>                 nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
>                 if (!nor->addr_width)
>                         nor->addr_width = 3;
> 
>                 nor->read_dummy = 8; 
>                 nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
>                 pr_info("smpt[%d]=[addr_width:%08x, read_dumy:%08x, read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy, nor->read_opcode);
> 
>                 addr = smpt[i + 1];
> 
>                 err = spi_nor_read_raw(nor, addr, 1, &data_byte);
>                 pr_info("smpt_read[%d] addr[%08x], data_byte[%08x] err:%08x\n", (i+1), addr, data_byte, err);
>                 if (err)
>                         goto out;
> 
>                 /*
>                  * Build an index value that is used to select the Sector Map
>                  * Configuration that is currently in use.
>                  */
>                 map_id = map_id << 1 | !!(data_byte & read_data_mask);
>                 map_id_is_valid = true;
>         }
> 
>         if (map_id_is_valid)
>                 pr_info("%s:%i map_id=%d smpt_len:%d i=:%d\n", __func__, __LINE__, map_id, smpt_len, i);
>         else
>                 pr_info("%s:%i NO map_id\n", __func__, __LINE__);
> 
>         for (nmaps = 0; i< smpt_len; nmaps++) {
>                 if(!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
>                         i += 2;
>                         continue;
>                 }
> 
>                 if(!map_id_is_valid) {
>                         if (nmaps) {
>                                 ret = NULL;
>                                 break;
>                         }
> 
>                         ret = smpt+i;
>                 } else if (map_id == SMPT_MAP_ID(smpt[i])) {
>                         ret = smpt+i;
>                         break;
>                 }
> 
>                 /* increment the table index to the next map */
>                 i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
>         }
> 
>         pr_info("End [addr_width:%08x, read_dumy:%08x, read_opcode:%08x] ReturnVal:%08x\n", nor->addr_width, nor->read_dummy, nor->read_opcode, ret);
> 
> --
> Thanks
> Yogesh Gaur.
> 
> > Thanks,
> > 
> > Boris  

