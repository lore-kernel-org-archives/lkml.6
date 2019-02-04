Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D26C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416C52175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549303322;
	bh=TjG4HUkAADk42AAK27ZRSoEg2BgJhIuaDibAYBZ2v4c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DTV6v0MsuviaXpgO7QeqOJhOriIp3YGzRyVMcon5nGfQT6r6qIe1ib2pHMLnnIqVT
	 HRQ19hLzQJXOcUXCJlUYDbrSxHwUPXEEQC3j7b3KOT0x2m6mdSqEFfSJPyPqmSdYnq
	 BcwqeH4PTnXjBi6ssM4uSE71/7CgFo6CZipEY8Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfBDSCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbfBDSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:02:00 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DD320820;
        Mon,  4 Feb 2019 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549303318;
        bh=TjG4HUkAADk42AAK27ZRSoEg2BgJhIuaDibAYBZ2v4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h6s/eTQMxygcrrtkDftsR4y9kMUVk9kAicTwYz52ddCpuNBmmemtp+8gxiPPWGeIh
         /kp1rAekG+wHl2UuTJawTRJWftd6H9pmse9jw+WlH+nZkxsz16gqzQIzMbqHbucE1e
         OdUP43rsP1NEChqFdisC0ncfEZZGx2IrA/suHnxc=
Date:   Mon, 4 Feb 2019 19:01:51 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Schrempf Frieder <frieder.schrempf@kontron.De>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Bean Huo \(beanhuo\)" <beanhuo@micron.com>
Subject: Re: [PATCH 2/2] mtd: spinand: micron: Support for all Micron SPI
 NAND flashes
Message-ID: <20190204190151.2c7987b7@bbrezillon>
In-Reply-To: <MN2PR08MB5951FD3B8244ABBA72FF7430B86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB5951FD3B8244ABBA72FF7430B86D0@MN2PR08MB5951.namprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shivamurthy,

On Mon, 4 Feb 2019 11:17:51 +0000
"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote:

> Driver is redesigned using parameter page to support all the Micron
> SPI NAND flashes.

Do all Micron SPI NANDs really expose a valid ONFI param page? If
that's not the case, then relying on ONFi parsing only sounds like a
bad idea.

> 
> Parameter page of Micron flashes is similar to ONFI parameter table and
> functionality is same, so copied some of the common functions like crc16
> and bit_wise_majority from nand_onfi.c.

Most of the code is generic and does not depend on the spinand layer,
plus, we already have ONFI param page parsing code in
drivers/mtd/nand/raw/ which you're intentionally duplicating in a
version that will not be re-usable by the raw NAND layer even after
converting it to use the generic NAND layer.

Please move ONFi parsing code to drivers/mtd/nand/onfi.c and make it
generic.

> 
> This driver is tested using MT29F2G01ABXGD, MT29F4G01ABXFD, MT29F8G01ADXFD,
> MT29F1G01ABXFD.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> Reviewed-by: Bean Huo <beanhuo@micron.com>

I wish this code review had happened publicly.

> ---
>  drivers/mtd/nand/spi/micron.c | 172 +++++++++++++++++++++++++++-------
>  drivers/mtd/nand/spi/micron.h |  83 ++++++++++++++++
>  2 files changed, 221 insertions(+), 34 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/micron.h
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 9c4381d6847b..c9c53fd0aa01 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -10,13 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mtd/spinand.h>
>  
> -#define SPINAND_MFR_MICRON		0x2c
> -
> -#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
> -#define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
> -#define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
> -#define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
> -#define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
> +#include "micron.h"
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
> @@ -34,38 +28,38 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
>  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
> -static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int section,
> -					struct mtd_oob_region *region)
> +static int ooblayout_ecc(struct mtd_info *mtd, int section,
> +			 struct mtd_oob_region *region)
>  {
>  	if (section)
>  		return -ERANGE;
>  
> -	region->offset = 64;
> -	region->length = 64;
> +	region->offset = mtd->oobsize / 2;
> +	region->length = mtd->oobsize / 2;
>  
>  	return 0;
>  }
>  
> -static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int section,
> -					 struct mtd_oob_region *region)
> +static int ooblayout_free(struct mtd_info *mtd, int section,
> +			  struct mtd_oob_region *region)
>  {
>  	if (section)
>  		return -ERANGE;
>  
>  	/* Reserve 2 bytes for the BBM. */
>  	region->offset = 2;
> -	region->length = 62;
> +	region->length = (mtd->oobsize / 2) - 2;
>  
>  	return 0;
>  }
>  
> -static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout = {
> -	.ecc = mt29f2g01abagd_ooblayout_ecc,
> -	.free = mt29f2g01abagd_ooblayout_free,
> +static const struct mtd_ooblayout_ops ooblayout = {
> +	.ecc = ooblayout_ecc,
> +	.free = ooblayout_free,
>  };
>  
> -static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
> -					 u8 status)
> +static int ecc_get_status(struct spinand_device *spinand,
> +			  u8 status)
>  {
>  	switch (status & MICRON_STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -90,22 +84,53 @@ static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
>  	return -EINVAL;
>  }
>  
> -static const struct spinand_info micron_spinand_table[] = {
> -	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
> -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 2, 1, 1),
> -		     NAND_ECCREQ(8, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> -					      &write_cache_variants,
> -					      &update_cache_variants),
> -		     0,
> -		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
> -				     mt29f2g01abagd_ecc_get_status)),
> -};
> +static u16 spinand_crc16(u16 crc, u8 const *p, size_t len)
> +{
> +	int i;
> +
> +	while (len--) {
> +		crc ^= *p++ << 8;
> +		for (i = 0; i < 8; i++)
> +			crc = (crc << 1) ^ ((crc & 0x8000) ? 0x8005 : 0);
> +	}
> +
> +	return crc;
> +}
> +
> +static void bit_wise_majority(const void **srcbufs,
> +			      unsigned int nsrcbufs,
> +				   void *dstbuf,
> +				   unsigned int bufsize)
> +{
> +	int i, j, k;
> +
> +	for (i = 0; i < bufsize; i++) {
> +		u8 val = 0;
> +
> +		for (j = 0; j < 8; j++) {
> +			unsigned int cnt = 0;
> +
> +			for (k = 0; k < nsrcbufs; k++) {
> +				const u8 *srcbuf = srcbufs[k];
> +
> +				if (srcbuf[i] & BIT(j))
> +					cnt++;
> +			}
> +
> +			if (cnt > nsrcbufs / 2)
> +				val |= BIT(j);
> +		}
> +
> +		((u8 *)dstbuf)[i] = val;
> +	}
> +}
>  
>  static int micron_spinand_detect(struct spinand_device *spinand)
>  {
> +	struct spinand_info deviceinfo;
> +	struct micron_spinand_params *params;
>  	u8 *id = spinand->id.data;
> -	int ret;
> +	int ret, i;
>  
>  	/*
>  	 * Micron SPI NAND read ID need a dummy byte,
> @@ -114,16 +139,95 @@ static int micron_spinand_detect(struct spinand_device *spinand)
>  	if (id[1] != SPINAND_MFR_MICRON)
>  		return 0;
>  
> -	ret = spinand_match_and_init(spinand, micron_spinand_table,
> -				     ARRAY_SIZE(micron_spinand_table), id[2]);
> +	params = kzalloc(sizeof(*params) * 3, GFP_KERNEL);
> +	if (!params)
> +		return -ENOMEM;
> +
> +	ret = spinand_parameter_page_read(spinand, PARAMETER_PAGE, params,
> +					  sizeof(*params) * 3);
>  	if (ret)
> -		return ret;
> +		goto free_params;
> +
> +	for (i = 0; i < 3; i++) {
> +		if (spinand_crc16(0x4F4E, (u8 *)&params[i], 254) ==
> +				le16_to_cpu(params->crc)) {
> +			if (i)
> +				memcpy(params, &params[i], sizeof(*params));
> +			break;
> +		}
> +	}
> +
> +	if (i == 3) {
> +		const void *srcbufs[3] = {params, params + 1, params + 2};
> +
> +		pr_warn("No valid parameter page, trying bit-wise majority to recover it\n");
> +		bit_wise_majority(srcbufs, ARRAY_SIZE(srcbufs), params,
> +				  sizeof(*params));
> +
> +		if (spinand_crc16(0x4F4E, (u8 *)params, 254) !=
> +				le16_to_cpu(params->crc)) {
> +			pr_err("Parameter page recovery failed, aborting\n");
> +			goto free_params;
> +		}
> +	}
> +
> +	params->model[sizeof(params->model) - 1] = 0;
> +	strim(params->model);
> +
> +	deviceinfo.model = kstrdup(params->model, GFP_KERNEL);
> +	if (!deviceinfo.model) {
> +		ret = -ENOMEM;
> +		goto free_params;
> +	}
> +
> +	deviceinfo.devid = id[2];
> +	deviceinfo.flags = 0;
> +	deviceinfo.memorg.bits_per_cell = params->bits_per_cell;
> +	deviceinfo.memorg.pagesize = params->byte_per_page;
> +	deviceinfo.memorg.oobsize = params->spare_bytes_per_page;
> +	deviceinfo.memorg.pages_per_eraseblock = params->pages_per_block;
> +	deviceinfo.memorg.eraseblocks_per_lun =
> +		params->blocks_per_lun * params->lun_count;
> +	deviceinfo.memorg.planes_per_lun = params->lun_count;

As pointed by Emil, this is wrong, params->lun_count should be used to
fill luns_per_target. ->planes_per_lun should be extracted from
->interleaved_bits.

> +	deviceinfo.memorg.luns_per_target = 1;
> +	deviceinfo.memorg.ntargets = 1;
> +	deviceinfo.eccreq.strength = params->ecc_max_correct_ability;
> +	deviceinfo.eccreq.step_size = 512;
> +	deviceinfo.eccinfo.get_status = ecc_get_status;
> +	deviceinfo.eccinfo.ooblayout = &ooblayout;

Are all devices really using the same get_status method and the same
layout. Sounds risky to me to assume this is the case.

> +	deviceinfo.op_variants.read_cache = &read_cache_variants;
> +	deviceinfo.op_variants.write_cache = &write_cache_variants;
> +	deviceinfo.op_variants.update_cache = &update_cache_variants;
> +
> +	ret = spinand_match_and_init(spinand, &deviceinfo,
> +				     1, id[2]);

Please don't abuse the spinand_match_and_init() function. Fill the
nand_device object directly instead of creating a temporary spinand_info
instance with the expected id.

> +	if (ret)
> +		goto free_model;
> +
> +	kfree(params);
>  
>  	return 1;
> +
> +free_model:
> +	kfree(deviceinfo.model);
> +free_params:
> +	kfree(params);
> +
> +	return ret;
> +}
> +
> +static int micron_spinand_init(struct spinand_device *spinand)
> +{
> +	/*
> +	 * Some of the Micron flashes enable this BIT by default,
> +	 * and there is a chance of read failure due to this.
> +	 */
> +	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
>  }
>  
>  static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
>  	.detect = micron_spinand_detect,
> +	.init = micron_spinand_init,
>  };
>  
>  const struct spinand_manufacturer micron_spinand_manufacturer = {
> diff --git a/drivers/mtd/nand/spi/micron.h b/drivers/mtd/nand/spi/micron.h
> new file mode 100644
> index 000000000000..c2cf3bee6f7e
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/micron.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 Micron Technology, Inc.
> + *
> + * Authors:
> + *	Shivamurthy Shastri <sshivamurthy@micron.com>
> + */
> +
> +#ifndef __MICRON_H
> +#define __MICRON_H
> +
> +#define SPINAND_MFR_MICRON		0x2c
> +
> +#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
> +#define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
> +#define MICRON_STATUS_ECC_1TO3_BITFLIPS	BIT(4)
> +#define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
> +#define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
> +
> +#define UNIQUE_ID_PAGE	0x00
> +#define PARAMETER_PAGE	0x01
> +
> +/*
> + * Micron SPI NAND has parameter table similar to ONFI
> + */
> +struct micron_spinand_params {
> +	/* rev info and features block */
> +	u8 sig[4];
> +	__le16 revision;
> +	__le16 features;
> +	__le16 opt_cmd;
> +	u8 reserved0[22];
> +
> +	/* manufacturer information block */
> +	char manufacturer[12];
> +	char model[20];
> +	u8 manufact_id;
> +	__le16 date_code;
> +	u8 reserved1[13];
> +
> +	/* memory organization block */
> +	__le32 byte_per_page;
> +	__le16 spare_bytes_per_page;
> +	__le32 data_bytes_per_ppage;
> +	__le16 spare_bytes_per_ppage;
> +	__le32 pages_per_block;
> +	__le32 blocks_per_lun;
> +	u8 lun_count;
> +	u8 addr_cycles;
> +	u8 bits_per_cell;
> +	__le16 bb_per_lun;
> +	__le16 block_endurance;
> +	u8 guaranteed_good_blocks;
> +	__le16 guaranteed_block_endurance;
> +	u8 programs_per_page;
> +	u8 ppage_attr;
> +	u8 ecc_bits;
> +	u8 interleaved_bits;
> +	u8 interleaved_ops;
> +	u8 reserved2[13];
> +
> +	/* electrical parameter block */
> +	u8 io_pin_capacitance_max;
> +	__le16 async_timing_mode;
> +	__le16 program_cache_timing_mode;
> +	__le16 t_prog;
> +	__le16 t_bers;
> +	__le16 t_r;
> +	__le16 t_ccs;
> +	u8 reserved3[23];
> +
> +	/* vendor */
> +	__le16 vendor_revision;
> +	u8 vendor_specific[14];
> +	u8 reserved4[68];
> +	u8 ecc_max_correct_ability;
> +	u8 die_select_feature;
> +	u8 reserved5[4];
> +
> +	__le16 crc;
> +} __packed;
> +

Please use the nand_onfi_params definition (include/linux/mtd/onfi.h).

> +#endif /* __MICRON_H */


Regards,

Boris
