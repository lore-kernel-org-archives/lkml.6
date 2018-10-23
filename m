Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB161C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87D320652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87D320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeJWRbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:31:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40948 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeJWRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:31:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C9FA220DB5; Tue, 23 Oct 2018 11:09:12 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 650AF20AA3;
        Tue, 23 Oct 2018 11:09:01 +0200 (CEST)
Date:   Tue, 23 Oct 2018 11:09:01 +0200
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
Message-ID: <20181023110901.310d00c1@bbrezillon>
In-Reply-To: <VI1PR04MB1038AB2711EF5C639E5139BF99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
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
        <20181023073946.138b287e@bbrezillon>
        <VI1PR04MB10381C2DC4052E636BA26ADA99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181023104827.77e7775b@bbrezillon>
        <VI1PR04MB1038AB2711EF5C639E5139BF99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018 08:59:22 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi, 
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Tuesday, October 23, 2018 2:18 PM
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
> > On Tue, 23 Oct 2018 08:18:35 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >   
> > >
> > > I have added the prints in m25p80_read() and in flexspi controller prepare_lut  
> > and read_rxfifo() func.  
> > > In these have added prints for data variable of struct op and data which being  
> > read by the controller from the flash.  
> > >
> > > [    2.091467] smpt[0]=[addr_width:00000003, read_dumy:00000008,  
> > read_opcode:00000065, data_mask:00000008]  
> > > [    2.099113] m25p80_read, nor[op:00000065 addr_width:00000003,  
> > dummy:00000008, len:00000001  
> > > [    2.107367] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3,  
> > bwidth:1]  
> > > [    2.114753] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,  
> > nbytes:1]  
> > > [    2.121706] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4,  
> > nbytes:3, bwidth:1]  
> > > [    2.129786] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]
> > > [    2.136132] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465  
> > 1:24003008      2:0     3:0]  
> > > [    2.144223] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]
> > > [    2.151004] smpt_read[1] addr[00000004], data_byte[00000000]  
> > err:00000000  
> > >
> > >
> > > [    2.157782] smpt[2]=[addr_width:00000003, read_dumy:00000008,  
> > read_opcode:00000065, data_mask:00000004]  
> > > [    2.165429] m25p80_read, nor[op:00000065 addr_width:00000003,  
> > dummy:00000008, len:00000001  
> > > [    2.173683] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:2, nbytes:3,  
> > bwidth:1]  
> > > [    2.181068] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,  
> > nbytes:1]  
> > > [    2.188021] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:2,  
> > nbytes:3, bwidth:1]  
> > > [    2.196101] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]
> > > [    2.202447] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465  
> > 1:24003008      2:0     3:0]  
> > > [    2.210539] nxp_fspi_read_rxfifo, ReadData op.buf[0x02]
> > > [    2.217319] smpt_read[3] addr[00000002], data_byte[00000002]  
> > err:00000000  
> > >
> > >
> > > [    2.224098] smpt[4]=[addr_width:00000003, read_dumy:00000008,  
> > read_opcode:00000065, data_mask:00000002]  
> > > [    2.231744] m25p80_read, nor[op:00000065 addr_width:00000003,  
> > dummy:00000008, len:00000001  
> > > [    2.239998] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3,  
> > bwidth:1]  
> > > [    2.247383] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,  
> > nbytes:1]  
> > > [    2.254336] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4,  
> > nbytes:3, bwidth:1]  
> > > [    2.262416] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]
> > > [    2.268762] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465  
> > 1:24003008      2:0     3:0]  
> > > [    2.276854] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]
> > > [    2.283634] smpt_read[5] addr[00000004], data_byte[00000000]  
> > err:00000000  
> > >
> > >
> > > [    2.290412] spi_nor_get_map_in_use:2915 map_id=0 smpt_len:16 i=:6
> > > [    2.296496] End [addr_width:00000003, read_dumy:00000008,  
> > read_opcode:00000065] ReturnVal:00000000  
> > > [    2.305444] spi_nor_parse_smpt:3065
> > > [    2.308924] m25p80 spi0.0: failed to parse SMPT (err = -22)
> > >
> > >  
> > > >
> > > > Next thing you can do is read the CR2NV reg (using the RDAR command)
> > > > and check the RL (Read Latency) and AL (Address Length) values.  
> > >
> > > Please let me know how to read CR2NV register.  
> > 
> > Actually, RDAR is already what you use to read the map_id, and we need to use
> > it to read the register that contains the number of dummy cycles and the number
> > of address bytes to use for RDAR operations. Looks like we have a chicken and
> > egg situation here :-).
> > 
> > Let's try something else:
> > 
> > 1/ create an u8 array of 16 entries named data_bytes
> > 
> > for each loop iteration (the first for loop):
> > 2/ set ->addr_width to 3 and ->read_dummy to 0 3/ call spi_nor_read_raw(nor,
> > addr, ARRAY_SIZE(data_bytes), data_bytes) 4/ dump the data_bytes buf 5/ set -  
> > >addr_width to 4 6/ call spi_nor_read_raw(nor, addr, ARRAY_SIZE(data_bytes),  
> > data_bytes) 7/ dump the data_bytes buf
> > 
> > If the SPI driver is working correctly, we should be able to figure out the right
> > value for ->addr_width and ->read_dummy.
> >   
> 
> Ok, I would try with the suggested change.
> But till the point we not able to figure out actual failure reason can we have below changes pushed-in

We're not there yet. The change just reached Linus tree, and we have
plenty of time to fix the issue before 4.20 is out. So no, I don't want
to rush this patch in until we figure out what's really going on.

> 
> @@ -3139,6 +3177,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>                 switch (SFDP_PARAM_HEADER_ID(param_header)) {
>                 case SFDP_SECTOR_MAP_ID:
>                         err = spi_nor_parse_smpt(nor, param_header);
> +                       if (err) {
> +                               dev_warn(dev,
> +                               "failed to parse SMPT (err = %d)\n",
> +                               err);
> +                               /*
> +                                * SMPT parsing is optional, let's not drop
> +                                * all information we extracted so far just
> +                                * because it failed.
> +                                */
> +                               err = 0;
> +                       }
> 
> --
> Regards
> Yogesh Gaur.
>  
> > Thanks,
> > 
> > Boris  

