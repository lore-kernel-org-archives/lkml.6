Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510EDC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0264120658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0264120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeJVS2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:28:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45485 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeJVS2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:28:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 962C920890; Mon, 22 Oct 2018 12:10:54 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3037E2072D;
        Mon, 22 Oct 2018 12:10:44 +0200 (CEST)
Date:   Mon, 22 Oct 2018 12:10:44 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP
 SPI NOR flash memories
Message-ID: <20181022121044.24039f40@bbrezillon>
In-Reply-To: <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
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
        <20181022111543.2a607efc@bbrezillon>
        <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2018 10:03:55 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi,
> 
> 
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Monday, October 22, 2018 2:46 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard@nod.at; Mark
> > Brown <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > Cristian.Birsan@microchip.com; Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>;
> > computersforpeace@gmail.com; dwmw2@infradead.org; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
> > NOR flash memories
> > 
> > On Mon, 22 Oct 2018 06:04:13 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > 
> >   
> With below patch, it gets stuck in for loop of "+       for (nmaps = 0; i< smpt_len; nmaps++) {".
> 
> [    1.624684] m25p80 spi0.0: found s25fl512s, expected m25p80
> [    1.630377] Start [addr_width:00000000, read_dumy:08, read_opcode:00000000]
> [    1.637335] spi_nor_get_map_in_use:2882 smpt[0]=08ff65fc
> [    1.642641] spi_nor_get_map_in_use:2882 smpt[1]=00000004
> [    1.647945] spi_nor_get_map_in_use:2882 smpt[2]=04ff65fc
> [    1.653248] spi_nor_get_map_in_use:2882 smpt[3]=00000002
> [    1.658551] spi_nor_get_map_in_use:2882 smpt[4]=02ff65fd
> [    1.663855] spi_nor_get_map_in_use:2882 smpt[5]=00000004
> [    1.669158] spi_nor_get_map_in_use:2882 smpt[6]=ff0201fe
> [    1.674461] spi_nor_get_map_in_use:2882 smpt[7]=00007ff1
> [    1.679766] spi_nor_get_map_in_use:2882 smpt[8]=00037ff4
> [    1.685070] spi_nor_get_map_in_use:2882 smpt[9]=03fbfff4
> [    1.690375] spi_nor_get_map_in_use:2882 smpt[10]=ff0203fe
> [    1.695768] spi_nor_get_map_in_use:2882 smpt[11]=03fbfff4
> [    1.701158] spi_nor_get_map_in_use:2882 smpt[12]=00037ff4
> [    1.706550] spi_nor_get_map_in_use:2882 smpt[13]=00007ff1
> [    1.711940] spi_nor_get_map_in_use:2882 smpt[14]=ff0005ff
> [    1.717330] spi_nor_get_map_in_use:2882 smpt[15]=03fffff4
> [    1.722720] smpt[0]=[addr_width:00000000, read_dumy:08, read_opcode:00000065]
> [    1.729861] spi_nor_get_map_in_use:2912 map_id=1
> 
> 
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2863,26 +2863,36 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
>   * @nor:       pointer to a 'struct spi_nor'
>   * @smpt:      pointer to the sector map parameter table
>   */
> -static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
> +static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt, u32 smpt_len)
>  {
>         const u32 *ret = NULL;
> -       u32 i, addr;
> +       u32 i, addr, nmaps;
>         int err;
>         u8 addr_width, read_opcode, read_dummy;
>         u8 read_data_mask, data_byte, map_id;
> +       bool map_id_is_valid = false;
> 
>         addr_width = nor->addr_width;
>         read_dummy = nor->read_dummy;
>         read_opcode = nor->read_opcode;
> 
> +       pr_info("Start [addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\n", nor->addr_width, nor->read_dummy, nor->read_opcode);
> +
> +       for (i = 0; i<smpt_len; i++)
> +               pr_info("%s:%i smpt[%d]=%08x\n", __func__, __LINE__, i, smpt[i]);
> +
>         map_id = 0;
> -       i = 0;
>         /* Determine if there are any optional Detection Command Descriptors */
> -       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> +       for (i = 0; i< smpt_len; i++) {
> +               if ((smpt[i] & SMPT_DESC_TYPE_MAP))
> +                       break;
> +
>                 read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
>                 nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
>                 nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
>                 nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
> +               pr_info("smpt[%d]=[addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\n", i, nor->addr_width, nor->read_dummy, nor->read_opcode);
> +
>                 addr = smpt[i + 1];
> 
>                 err = spi_nor_read_raw(nor, addr, 1, &data_byte);
> @@ -2894,18 +2904,36 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
>                  * Configuration that is currently in use.
>                  */
>                 map_id = map_id << 1 | !!(data_byte & read_data_mask);
> +               map_id_is_valid = true;
>                 i = i + 2;
>         }
> 
> -       /* Find the matching configuration map */
> -       while (SMPT_MAP_ID(smpt[i]) != map_id) {
> -               if (smpt[i] & SMPT_DESC_END)
> -                       goto out;
> +       if (map_id_is_valid)
> +               pr_info("%s:%i map_id=%d\n", __func__, __LINE__, map_id);
> +       else
> +               pr_info("%s:%i NO map_id\n", __func__, __LINE__);
> +
> +       for (nmaps = 0; i< smpt_len; nmaps++) {
> +               if((smpt[i] & SMPT_DESC_TYPE_MAP))
> +                       continue;

Try to Replace the above if block by:

		if (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
			i += 2;
			continue;
		}

> +
> +               if(!map_id_is_valid) {
> +                       if (nmaps) {
> +                               ret = NULL;
> +                               break;
> +                       }
> +
> +                       ret = smpt+i;
> +               } else if (map_id == SMPT_MAP_ID(smpt[i])) {
> +                       ret = smpt+i;
> +                       break;
> +               }
> +
>                 /* increment the table index to the next map */
>                 i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
>         }
> 
> -       ret = smpt + i;
> +       pr_info("End [addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\n", nor->addr_width, nor->read_dummy, nor->read_opcode);
>         /* fall through */
>  out:
>         nor->addr_width = addr_width;

