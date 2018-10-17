Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B35ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D580521526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D580521526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeJQQnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:43:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44821 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbeJQQnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:43:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5F74420736; Wed, 17 Oct 2018 10:48:58 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id E9D3A20723;
        Wed, 17 Oct 2018 10:48:57 +0200 (CEST)
Date:   Wed, 17 Oct 2018 10:48:58 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
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
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
Message-ID: <20181017104858.5f889634@bbrezillon>
In-Reply-To: <VI1PR04MB1038987B053C31099A76344699FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
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
        <47586729-d711-cd38-a4b2-bef09f64cba3@microchip.com>
        <VI1PR04MB1038987B053C31099A76344699FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 08:20:19 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Tudor,
> 
> > -----Original Message-----
> > From: Tudor Ambarus [mailto:tudor.ambarus@microchip.com]
> > Sent: Wednesday, October 17, 2018 1:31 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Boris Brezillon
> > <boris.brezillon@bootlin.com>
> > Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; marek.vasut@gmail.com;
> > dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> > linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; linux-arm-
> > kernel@lists.infradead.org; Cristian.Birsan@microchip.com
> > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
> > NOR flash memories
> > 
> > Hi, Yogesh,
> > 
> > On 10/17/2018 10:46 AM, Yogesh Narayan Gaur wrote:  
> > > Hi Boris,
> > >  
> > >> -----Original Message-----
> > >> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > >> Sent: Wednesday, October 17, 2018 1:00 PM
> > >> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > >> Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Tudor Ambarus
> > >> <tudor.ambarus@microchip.com>; marek.vasut@gmail.com;
> > >> dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> > >> linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> > >> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > >> linux-arm- kernel@lists.infradead.org; Cristian.Birsan@microchip.com
> > >> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform
> > >> SFDP SPI NOR flash memories
> > >>
> > >> On Wed, 17 Oct 2018 09:10:45 +0200
> > >> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >>  
> > >>> On Wed, 17 Oct 2018 09:07:24 +0200
> > >>> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >>>  
> > >>>> On Wed, 17 Oct 2018 02:07:43 +0000
> > >>>> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >>>>  
> > >>>>>>  
> > >>>>> Actually there is no entry of s25fs512s in current spi-nor.c file.
> > >>>>> For my connected flash part, jedec ID read points to s25fl512s. I
> > >>>>> have asked my board team to confirm the name of exact connected
> > >>>>> flash part. When I check the data sheet of s25fs512s, it also
> > >>>>> points to the same Jedec ID information. { "s25fl512s",
> > >>>>> INFO(0x010220, 0x4d00, 256
> > >>>>> * 1024, 256, ....}
> > >>>>>
> > >>>>> But as stated earlier, if I skip reading SFDP or read using 1-1-1
> > >>>>> protocol then read are always correct. For 1-4-4 protocol read are
> > >>>>> wrong and on further debugging found that Read code of 0x6C is
> > >>>>> being send as opcode instead of 0xEC.
> > >>>>>
> > >>>>> If I revert this patch, reads are working fine.  
> > >>>>
> > >>>> Can you try with the following patch?
> > >>>>  
> > >>>
> > >>> Hm, nevermind. The problem is actually not related to 4B vs non-4B
> > >>> mode but 1-1-4 vs 1-4-4 modes.  
> > > Yes, that's only I have stated in my first mail that instead of 1-4-4 mode read  
> > opcode is being sent for 1-1-4 mode.  
> > >>>  
> > >>
> > >> Can you try with this patch applied?
> > >>  
> > > With suggested patch, read for protocol 1-4-4 working correctly.
> > >
> > > 	[    1.625360] m25p80 spi0.0: found s25fl512s, expected m25p80
> > > 	[    1.631094] m25p80 spi0.0: failed to parse SMPT (err = -22)
> > > 	[    1.636661] 261 8c4c780 opcode(read:eb, pp:2, erase:d8)
> > > 	[    1.641878] 266 8c4c780 opcode(read:ec, pp:12, erase:dc)
> > > 	[    1.647200] m25p80 spi0.0: s25fl512s (65536 Kbytes)
> > >
> > > Without this patch, param_headers are getting freed and restoring previous  
> > erase map i.e. opcode related to 1-1-4 protocol.  
> > >  
> > 
> > Can you add some prints in spi_nor_parse_smpt() to isolate what's failing? We
> > should understand whether it's something wrong in spi_nor_parse_smpt() or the
> > s25fs512s smpt table does not respect the standard.
> >   
> 
> It's returning failure from below point in func spi_nor_get_map_in_use()
> 
>         /* Find the matching configuration map */
>         while (SMPT_MAP_ID(smpt[i]) != map_id) {
>                 if (smpt[i] & SMPT_DESC_END) {
>                         printk("%d %s \n", __LINE__, __func__);
>                         goto out;
>                 }

Can you dump the smpt array just before calling
spi_nor_get_map_in_use()?

> --
> Regards
> Yogesh Gaur.
> 
> > Thanks,
> > ta
> >   
> 

