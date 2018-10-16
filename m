Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0E9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E06C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MWBMhSRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E06C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJPRlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:41:40 -0400
Received: from mail-ve1eur01on0061.outbound.protection.outlook.com ([104.47.1.61]:36192
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbeJPRlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovURP5O1hjDquM26QPqxWIidvNWxsD/f4Q9TT0Ss9m8=;
 b=MWBMhSRLeKG6x72HKPZGOSIO0HCYBanjmq/XT2sdIYfi0+rbND3RFjykLdFhZgziFS7J83SFE9bGS46rQFXnwWtwsILAbrHp7+UEQ7q4K/Htx52Hl99ac/FkxBXnutrZ1uX2VFAmG74L5dCb8bnc37wXEs8NxgE7iK3PRDUNf5M=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1005.eurprd04.prod.outlook.com (10.161.108.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Tue, 16 Oct 2018 09:51:49 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 09:51:47 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUw
Date:   Tue, 16 Oct 2018 09:51:47 +0000
Message-ID: <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
In-Reply-To: <20180911154007.17195-2-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1005;6:GLEzcbu+ZhlexY4XEihVhXd9hbDMqVIPiv4WuHhjREXD0ZTWAj1vtb4wAMe3+zExGdQ3TWUGCtkoMzPj0rlPj21j0ULtiO40YWnx/RzLjg3JSFLGZjIiu3qnfxhH2Jc9kuZROQwN3UPr7yZKjlU/yKWZi6gQfg3S1eDW/czXhteLFbQa4Q6U4EAw/WrHmyUPPLHqvDR2SUYZ3oz013Ff4Yd68M7TyAV93sGmvniAUv5H7KXyQi+KfbfnWVhfd/b5fMLw+HWgslqQAYmFUzDGglCr6Mquh00bmTtWpArLy4wd+V+K8dJO8/n9zaWPr4EBmn2AAwwmuxeIcP09d0hswT4UY2DX1HpX2FLsOoN/U9prqNVEK+9d/PmwpkR/czRrOmR5aNCk23zF9kU0675mI6DXZU4UgsaKI7J9A7bQ2Xc3fX0bXMiSetOwLWaQBLEZFPRmNQaNQ+5eU4nW97CZog==;5:vV7A4AASfA1MbDtpAwPsWTbabPnXxhsNGB6pgswCWuWuXPLeEGSCU1jvyDoTobQqoD84hs4hqZkUn7RCbAxTV6zZN7F0ouU4vEZZ2UDZN9uFwnDGZBX5kQXnGcqTFfl4R0CVtF2yUM1OpwI6Ir4nrh5R+xXeIb2ipty86pFSBVM=;7:fOgzKxgIYfhctH0AO7BfRw4SOHZMKvtn6BTP/bmOTVxV0ocmXWfleBNqly3mZBoSI4LmKdH+Ygy5Beh2OQtnTAA9DuuKYut/rrE9TmlEI67YRCWyHbWzkY1JOpiVRWSLZU81YGsToPHwFlYdD6Lo4oPLm9ZpSuLsUFOB/WsjNsywowtKijmyCrqzaOAZwb58Eiv3y4dP6zmx0A0rEVlUQ3ykg/W6eYQupubQUDQfvZYRtCP8XHdGCvEMCjdd1ouL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ee64e724-accd-4f00-fa2c-08d6334cfd2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1005;
x-ms-traffictypediagnostic: VI1PR04MB1005:
x-microsoft-antispam-prvs: <VI1PR04MB10056D0A0BFB61D7322E19B399FE0@VI1PR04MB1005.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(9452136761055)(45079756050767)(189930954265078)(131327999870524)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(4982022)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB1005;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1005;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(396003)(136003)(346002)(199004)(189003)(13464003)(25786009)(6436002)(26005)(8936002)(102836004)(186003)(110136005)(54906003)(45080400002)(2501003)(5250100002)(8676002)(55016002)(81156014)(81166006)(229853002)(575784001)(86362001)(74316002)(305945005)(2201001)(7736002)(14444005)(256004)(7416002)(316002)(217873002)(3846002)(6116002)(71190400001)(4744004)(71200400001)(68736007)(106356001)(446003)(105586002)(486006)(2906002)(7696005)(966005)(11346002)(476003)(76176011)(5660300001)(97736004)(33656002)(6506007)(53546011)(478600001)(2900100001)(55236004)(99286004)(39060400002)(53936002)(16200700003)(53946003)(6306002)(9686003)(66066001)(14454004)(6246003)(4326008)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1005;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hnqlSA0UVrXMbYnf9yXYEwNhrD3oIPlOuyi/WCvihvQV856PqSnjgh2gSuGevS3TSiLdgv02vTyaeQhMTU+iIM/Zqo7/rSthZXWeD839rA3tN51jTZmaaVL+lPFueFq6YduUm4W9R1L4aesAVcawqGLILYCBK0JoiKnzI/+p1u24OyFUwP/vJ5DbqnM/NbViYQx9lOScXmmDNmmFAoSRw3fbzSyJ59Yr3PVABrZtiYZJjnndm1AAwURUKNLwGON+hHTTLnuSOvO8m5v6pyyvfDEg08o2NXYAEeD2O9h6D+d/MHAyjetyM4YLEkF3GM0IRv4Dl9Jp6vcVZDLwgnb5WehOEeQbkSLctJuFW4LpPgk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee64e724-accd-4f00-fa2c-08d6334cfd2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 09:51:47.5417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

This patch is breaking the 1-4-4 Read protocol for the spansion flash "s25f=
l512s".

Without this patch read request command for Quad mode, 4-byte enable, is co=
ming as 0xEC i.e. SPINOR_OP_READ_1_4_4_4B.
But after applying this patch, read request command for Quad mode is coming=
 as 0x6C i.e. SPINOR_OP_READ_1_1_4_4B.

This flash also supports non-uniform erase.
Can you please check and provide some suggestion?

--
Regards
Yogesh Gaur

> -----Original Message-----
> From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On Behalf =
Of
> Tudor Ambarus
> Sent: Tuesday, September 11, 2018 9:10 PM
> To: marek.vasut@gmail.com; dwmw2@infradead.org;
> computersforpeace@gmail.com; boris.brezillon@bootlin.com; richard@nod.at
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; linux-
> kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org; Cristian.Birsan@microchip.com
> Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI=
 NOR
> flash memories
>=20
> Based on Cyrille Pitchen's patch
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml=
.or
> g%2Flkml%2F2017%2F3%2F22%2F935&amp;data=3D02%7C01%7Cyogeshnarayan.
> gaur%40nxp.com%7C3c782e52b7fd4a8b9af008d617fd5154%7C686ea1d3bc2b4
> c6fa92cd99c5c301635%7C0%7C0%7C636722774108718782&amp;sdata=3Dszyc%
> 2FTumG6eYAmBd0oW3IL7v1yLh9E1SAZqL%2BCWczOA%3D&amp;reserved=3D0.
>=20
> This patch is a transitional patch in introducing  the support of SFDP SP=
I
> memories with non-uniform erase sizes like Spansion s25fs512s.
> Non-uniform erase maps will be used later when initialized based on the S=
FDP
> data.
>=20
> Introduce the memory erase map which splits the memory array into one or
> many erase regions. Each erase region supports up to 4 erase types, as de=
fined
> by the JEDEC JESD216B (SFDP) specification.
>=20
> To be backward compatible, the erase map of uniform SPI NOR flash memorie=
s
> is initialized so it contains only one erase region and this erase region=
 supports
> only one erase command. Hence a single size is used to erase any sector/b=
lock
> of the memory.
>=20
> Besides, since the algorithm used to erase sectors on non-uniform SPI NOR=
 flash
> memories is quite expensive, when possible, the erase map is tuned to com=
e
> back to the uniform case.
>=20
> The 'erase with the best command, move forward and repeat' approach was
> suggested by Cristian Birsan in a brainstorm session, so:
>=20
> Suggested-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 594
> +++++++++++++++++++++++++++++++++++++++---
>  include/linux/mtd/spi-nor.h   | 107 ++++++++
>  2 files changed, 659 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c index
> dc8757e..4687345 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -18,6 +18,7 @@
>  #include <linux/math64.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/sort.h>
>=20
>  #include <linux/mtd/mtd.h>
>  #include <linux/of_platform.h>
> @@ -261,6 +262,18 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor
> *nor,
>  	nor->read_opcode =3D spi_nor_convert_3to4_read(nor->read_opcode);
>  	nor->program_opcode =3D spi_nor_convert_3to4_program(nor-
> >program_opcode);
>  	nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor->erase_opcode);
> +
> +	if (!spi_nor_has_uniform_erase(nor)) {
> +		struct spi_nor_erase_map *map =3D &nor->erase_map;
> +		struct spi_nor_erase_type *erase;
> +		int i;
> +
> +		for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++) {
> +			erase =3D &map->erase_type[i];
> +			erase->opcode =3D
> +				spi_nor_convert_3to4_erase(erase->opcode);
> +		}
> +	}
>  }
>=20
>  /* Enable/disable 4-byte addressing mode. */ @@ -499,6 +512,275 @@ stati=
c
> int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)  }
>=20
>  /*
> + * spi_nor_div_by_erase_size() - calculate remainder and update new divi=
dend
> + * @erase:	pointer to a structure that describes a SPI NOR erase type
> + * @dividend:	dividend value
> + * @remainder:	pointer to u32 remainder (will be updated)
> + *
> + * Returns two values: remainder and the new dividend  */ static u64
> +spi_nor_div_by_erase_size(const struct spi_nor_erase_type *erase,
> +				     u64 dividend, u32 *remainder)
> +{
> +	/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> +	*remainder =3D (u32)dividend & erase->size_mask;
> +	return dividend >> erase->size_shift;
> +}
> +
> +/*
> + * spi_nor_find_best_erase_type() - find the best erase type for the
> +given
> + * offset in the serial flash memory and the number of bytes to erase.
> +The
> + * region in which the address fits is expected to be provided.
> + * @map:	the erase map of the SPI NOR
> + * @region:	pointer to a structure that describes a SPI NOR erase region
> + * @addr:	offset in the serial flash memory
> + * @len:	number of bytes to erase
> + *
> + * Returns a pointer to the best fitted erase type, NULL otherwise.
> + */
> +static const struct spi_nor_erase_type *
> +spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
> +			     const struct spi_nor_erase_region *region,
> +			     u64 addr, u32 len)
> +{
> +	const struct spi_nor_erase_type *erase;
> +	u32 rem;
> +	int i;
> +	u8 erase_mask =3D region->offset & SNOR_ERASE_TYPE_MASK;
> +
> +	/*
> +	 * Erase types are ordered by size, with the biggest erase type at
> +	 * index 0.
> +	 */
> +	for (i =3D SNOR_ERASE_TYPE_MAX - 1; i >=3D 0; i--) {
> +		/* Does the erase region support the tested erase type? */
> +		if (!(erase_mask & BIT(i)))
> +			continue;
> +
> +		erase =3D &map->erase_type[i];
> +
> +		/* Don't erase more than what the user has asked for. */
> +		if (erase->size > len)
> +			continue;
> +
> +		/* Alignment is not mandatory for overlaid regions */
> +		if (region->offset & SNOR_OVERLAID_REGION)
> +			return erase;
> +
> +		spi_nor_div_by_erase_size(erase, addr, &rem);
> +		if (rem)
> +			continue;
> +		else
> +			return erase;
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * spi_nor_region_next() - get the next spi nor region
> + * @region:	pointer to a structure that describes a SPI NOR erase region
> + *
> + * Returns the next spi nor region or NULL if last region.
> + */
> +static struct spi_nor_erase_region *
> +spi_nor_region_next(struct spi_nor_erase_region *region) {
> +	if (spi_nor_region_is_last(region))
> +		return NULL;
> +	region++;
> +	return region;
> +}
> +
> +/*
> + * spi_nor_find_erase_region() - find the region of the serial flash
> +memory in
> + * which the offset fits
> + * @map:	the erase map of the SPI NOR
> + * @addr:	offset in the serial flash memory
> + *
> + * Returns pointer to the spi_nor_erase_region struct, ERR_PTR(-errno)
> + * otherwise.
> + */
> +static struct spi_nor_erase_region *
> +spi_nor_find_erase_region(const struct spi_nor_erase_map *map, u64
> +addr) {
> +	struct spi_nor_erase_region *region =3D map->regions;
> +	u64 region_start =3D region->offset & ~SNOR_ERASE_FLAGS_MASK;
> +	u64 region_end =3D region_start + region->size;
> +
> +	while (addr < region_start || addr >=3D region_end) {
> +		region =3D spi_nor_region_next(region);
> +		if (!region)
> +			return ERR_PTR(-EINVAL);
> +
> +		region_start =3D region->offset & ~SNOR_ERASE_FLAGS_MASK;
> +		region_end =3D region_start + region->size;
> +	}
> +
> +	return region;
> +}
> +
> +/*
> + * spi_nor_init_erase_cmd() - initialize an erase command
> + * @region:	pointer to a structure that describes a SPI NOR erase region
> + * @erase:	pointer to a structure that describes a SPI NOR erase type
> + *
> + * Returns the pointer to the allocated erase command, ERR_PTR(-errno)
> + * otherwise.
> + */
> +static struct spi_nor_erase_command *
> +spi_nor_init_erase_cmd(const struct spi_nor_erase_region *region,
> +		       const struct spi_nor_erase_type *erase) {
> +	struct spi_nor_erase_command *cmd;
> +
> +	cmd =3D kmalloc(sizeof(*cmd), GFP_KERNEL);
> +	if (!cmd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&cmd->list);
> +	cmd->opcode =3D erase->opcode;
> +	cmd->count =3D 1;
> +
> +	if (region->offset & SNOR_OVERLAID_REGION)
> +		cmd->size =3D region->size;
> +	else
> +		cmd->size =3D erase->size;
> +
> +	return cmd;
> +}
> +
> +/*
> + * spi_nor_destroy_erase_cmd_list() - destroy erase command list
> + * @erase_list:	list of erase commands
> + */
> +static void spi_nor_destroy_erase_cmd_list(struct list_head
> +*erase_list) {
> +	struct spi_nor_erase_command *cmd, *next;
> +
> +	list_for_each_entry_safe(cmd, next, erase_list, list) {
> +		list_del(&cmd->list);
> +		kfree(cmd);
> +	}
> +}
> +
> +/*
> + * spi_nor_init_erase_cmd_list() - initialize erase command list
> + * @nor:	pointer to a 'struct spi_nor'
> + * @erase_list:	list of erase commands to be executed once we validate t=
hat
> the
> + *		erase can be performed
> + * @addr:	offset in the serial flash memory
> + * @len:	number of bytes to erase
> + *
> + * Builds the list of best fitted erase commands and verifies if the
> +erase can
> + * be performed.
> + *
> + * Returns 0 on success, -errno otherwise.
> + */
> +static int spi_nor_init_erase_cmd_list(struct spi_nor *nor,
> +				       struct list_head *erase_list,
> +				       u64 addr, u32 len)
> +{
> +	const struct spi_nor_erase_map *map =3D &nor->erase_map;
> +	const struct spi_nor_erase_type *erase, *prev_erase =3D NULL;
> +	struct spi_nor_erase_region *region;
> +	struct spi_nor_erase_command *cmd =3D NULL;
> +	u64 region_end;
> +	int ret =3D -EINVAL;
> +
> +	region =3D spi_nor_find_erase_region(map, addr);
> +	if (IS_ERR(region))
> +		return PTR_ERR(region);
> +
> +	region_end =3D spi_nor_region_end(region);
> +
> +	while (len) {
> +		erase =3D spi_nor_find_best_erase_type(map, region, addr, len);
> +		if (!erase)
> +			goto destroy_erase_cmd_list;
> +
> +		if (prev_erase !=3D erase ||
> +		    region->offset & SNOR_OVERLAID_REGION) {
> +			cmd =3D spi_nor_init_erase_cmd(region, erase);
> +			if (IS_ERR(cmd)) {
> +				ret =3D PTR_ERR(cmd);
> +				goto destroy_erase_cmd_list;
> +			}
> +
> +			list_add_tail(&cmd->list, erase_list);
> +		} else {
> +			cmd->count++;
> +		}
> +
> +		addr +=3D cmd->size;
> +		len -=3D cmd->size;
> +
> +		if (len && addr >=3D region_end) {
> +			region =3D spi_nor_region_next(region);
> +			if (!region)
> +				goto destroy_erase_cmd_list;
> +			region_end =3D spi_nor_region_end(region);
> +		}
> +
> +		prev_erase =3D erase;
> +	}
> +
> +	return 0;
> +
> +destroy_erase_cmd_list:
> +	spi_nor_destroy_erase_cmd_list(erase_list);
> +	return ret;
> +}
> +
> +/*
> + * spi_nor_erase_multi_sectors() - perform a non-uniform erase
> + * @nor:	pointer to a 'struct spi_nor'
> + * @addr:	offset in the serial flash memory
> + * @len:	number of bytes to erase
> + *
> + * Build a list of best fitted erase commands and execute it once we
> + * validate that the erase can be performed.
> + *
> + * Returns 0 on success, -errno otherwise.
> + */
> +static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr,
> +u32 len) {
> +	LIST_HEAD(erase_list);
> +	struct spi_nor_erase_command *cmd, *next;
> +	int ret;
> +
> +	ret =3D spi_nor_init_erase_cmd_list(nor, &erase_list, addr, len);
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry_safe(cmd, next, &erase_list, list) {
> +		nor->erase_opcode =3D cmd->opcode;
> +		while (cmd->count) {
> +			write_enable(nor);
> +
> +			ret =3D spi_nor_erase_sector(nor, addr);
> +			if (ret)
> +				goto destroy_erase_cmd_list;
> +
> +			addr +=3D cmd->size;
> +			cmd->count--;
> +
> +			ret =3D spi_nor_wait_till_ready(nor);
> +			if (ret)
> +				goto destroy_erase_cmd_list;
> +		}
> +		list_del(&cmd->list);
> +		kfree(cmd);
> +	}
> +
> +	return 0;
> +
> +destroy_erase_cmd_list:
> +	spi_nor_destroy_erase_cmd_list(&erase_list);
> +	return ret;
> +}
> +
> +/*
>   * Erase an address range on the nor chip.  The address range may extend
>   * one or more erase sectors.  Return an error is there is a problem era=
sing.
>   */
> @@ -512,9 +794,11 @@ static int spi_nor_erase(struct mtd_info *mtd, struc=
t
> erase_info *instr)
>  	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
>  			(long long)instr->len);
>=20
> -	div_u64_rem(instr->len, mtd->erasesize, &rem);
> -	if (rem)
> -		return -EINVAL;
> +	if (spi_nor_has_uniform_erase(nor)) {
> +		div_u64_rem(instr->len, mtd->erasesize, &rem);
> +		if (rem)
> +			return -EINVAL;
> +	}
>=20
>  	addr =3D instr->addr;
>  	len =3D instr->len;
> @@ -553,7 +837,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct
> erase_info *instr)
>  	 */
>=20
>  	/* "sector"-at-a-time erase */
> -	} else {
> +	} else if (spi_nor_has_uniform_erase(nor)) {
>  		while (len) {
>  			write_enable(nor);
>=20
> @@ -568,6 +852,12 @@ static int spi_nor_erase(struct mtd_info *mtd, struc=
t
> erase_info *instr)
>  			if (ret)
>  				goto erase_err;
>  		}
> +
> +	/* erase multiple sectors */
> +	} else {
> +		ret =3D spi_nor_erase_multi_sectors(nor, addr, len);
> +		if (ret)
> +			goto erase_err;
>  	}
>=20
>  	write_disable(nor);
> @@ -2190,6 +2480,113 @@ static const struct sfdp_bfpt_erase
> sfdp_bfpt_erases[] =3D {
>=20
>  static int spi_nor_hwcaps_read2cmd(u32 hwcaps);
>=20
> +/*
> + * spi_nor_set_erase_type() - set a SPI NOR erase type
> + * @erase:	pointer to a structure that describes a SPI NOR erase type
> + * @size:	the size of the sector/block erased by the erase type
> + * @opcode:	the SPI command op code to erase the sector/block
> + */
> +static void spi_nor_set_erase_type(struct spi_nor_erase_type *erase,
> +				   u32 size, u8 opcode)
> +{
> +	erase->size =3D size;
> +	erase->opcode =3D opcode;
> +	/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> +	erase->size_shift =3D ffs(erase->size) - 1;
> +	erase->size_mask =3D (1 << erase->size_shift) - 1; }
> +
> +/*
> + * spi_nor_set_erase_settings_from_bfpt() - set erase type settings from=
 BFPT
> + * @erase:	pointer to a structure that describes a SPI NOR erase type
> + * @size:	the size of the sector/block erased by the erase type
> + * @opcode:	the SPI command op code to erase the sector/block
> + * @i:		erase type index as sorted in the Basic Flash Parameter Table
> + *
> + * The supported Erase Types will be sorted at init in ascending order,
> +with
> + * the smallest Erase Type size being the first member in the
> +erase_type array
> + * of the spi_nor_erase_map structure. Save the Erase Type index as
> +sorted in
> + * the Basic Flash Parameter Table since it will be used later on to
> + * synchronize with the supported Erase Types defined in SFDP optional t=
ables.
> + */
> +static void
> +spi_nor_set_erase_settings_from_bfpt(struct spi_nor_erase_type *erase,
> +				     u32 size, u8 opcode, u8 i)
> +{
> +	erase->idx =3D i;
> +	spi_nor_set_erase_type(erase, size, opcode); }
> +
> +/* spi_nor_map_cmp_erase_type() - compare the map's erase types by size
> + * @l:	member in the left half of the map's erase_type array
> + * @r:	member in the right half of the map's erase_type array
> + *
> + * Comparison function used in the sort() call to sort in ascending
> +order the
> + * map's erase types, the smallest erase type size being the first
> +member in the
> + * sorted erase_type array.
> + */
> +static int spi_nor_map_cmp_erase_type(const void *l, const void *r) {
> +	const struct spi_nor_erase_type *left =3D l, *right =3D r;
> +
> +	return left->size - right->size;
> +}
> +
> +/*
> + * spi_nor_regions_sort_erase_types() - sort erase types in each region
> + * @map:	the erase map of the SPI NOR
> + *
> + * Function assumes that the erase types defined in the erase map are
> +already
> + * sorted in ascending order, with the smallest erase type size being
> +the first
> + * member in the erase_type array. It replicates the sort done for the
> +map's
> + * erase types. Each region's erase bitmask will indicate which erase
> +types are
> + * supported from the sorted erase types defined in the erase map.
> + * Sort the all region's erase type at init in order to speed up the
> +process of
> + * finding the best erase command at runtime.
> + */
> +static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map
> +*map) {
> +	struct spi_nor_erase_region *region =3D map->regions;
> +	struct spi_nor_erase_type *erase_type =3D map->erase_type;
> +	int i;
> +	u8 region_erase_mask, sorted_erase_mask;
> +
> +	while (region) {
> +		region_erase_mask =3D region->offset &
> SNOR_ERASE_TYPE_MASK;
> +
> +		/* Replicate the sort done for the map's erase types. */
> +		sorted_erase_mask =3D 0;
> +		for (i =3D 0; i < SNOR_ERASE_TYPE_MAX; i++)
> +			if (erase_type[i].size &&
> +			    region_erase_mask & BIT(erase_type[i].idx))
> +				sorted_erase_mask |=3D BIT(i);
> +
> +		/* Overwrite erase mask. */
> +		region->offset =3D (region->offset & ~SNOR_ERASE_TYPE_MASK)
> |
> +				 sorted_erase_mask;
> +
> +		region =3D spi_nor_region_next(region);
> +	}
> +}
> +
> +/*
> + *spi_nor_init_uniform_erase_map() - Initialize uniform erase map
> + * @map:		the erase map of the SPI NOR
> + * @erase_mask:		bitmask encoding erase types that can erase
> the entire
> + *			flash memory
> + * @flash_size:		the spi nor flash memory size
> + */
> +static void spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map=
,
> +					   u8 erase_mask, u64 flash_size)
> +{
> +	/* Offset 0 with erase_mask and SNOR_LAST_REGION bit set */
> +	map->uniform_region.offset =3D (erase_mask &
> SNOR_ERASE_TYPE_MASK) |
> +				     SNOR_LAST_REGION;
> +	map->uniform_region.size =3D flash_size;
> +	map->regions =3D &map->uniform_region;
> +	map->uniform_erase_type =3D erase_mask;
> +}
> +
>  /**
>   * spi_nor_parse_bfpt() - read and parse the Basic Flash Parameter Table=
.
>   * @nor:		pointer to a 'struct spi_nor'
> @@ -2224,12 +2621,14 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor=
,
>  			      const struct sfdp_parameter_header *bfpt_header,
>  			      struct spi_nor_flash_parameter *params)  {
> -	struct mtd_info *mtd =3D &nor->mtd;
> +	struct spi_nor_erase_map *map =3D &nor->erase_map;
> +	struct spi_nor_erase_type *erase_type =3D map->erase_type;
>  	struct sfdp_bfpt bfpt;
>  	size_t len;
>  	int i, cmd, err;
>  	u32 addr;
>  	u16 half;
> +	u8 erase_mask;
>=20
>  	/* JESD216 Basic Flash Parameter Table length is at least 9 DWORDs. */
>  	if (bfpt_header->length < BFPT_DWORD_MAX_JESD216) @@ -2298,7
> +2697,12 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>  		spi_nor_set_read_settings_from_bfpt(read, half, rd->proto);
>  	}
>=20
> -	/* Sector Erase settings. */
> +	/*
> +	 * Sector Erase settings. Reinitialize the uniform erase map using the
> +	 * Erase Types defined in the bfpt table.
> +	 */
> +	erase_mask =3D 0;
> +	memset(&nor->erase_map, 0, sizeof(nor->erase_map));
>  	for (i =3D 0; i < ARRAY_SIZE(sfdp_bfpt_erases); i++) {
>  		const struct sfdp_bfpt_erase *er =3D &sfdp_bfpt_erases[i];
>  		u32 erasesize;
> @@ -2313,18 +2717,25 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor=
,
>=20
>  		erasesize =3D 1U << erasesize;
>  		opcode =3D (half >> 8) & 0xff;
> -#ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
> -		if (erasesize =3D=3D SZ_4K) {
> -			nor->erase_opcode =3D opcode;
> -			mtd->erasesize =3D erasesize;
> -			break;
> -		}
> -#endif
> -		if (!mtd->erasesize || mtd->erasesize < erasesize) {
> -			nor->erase_opcode =3D opcode;
> -			mtd->erasesize =3D erasesize;
> -		}
> +		erase_mask |=3D BIT(i);
> +		spi_nor_set_erase_settings_from_bfpt(&erase_type[i],
> erasesize,
> +						     opcode, i);
>  	}
> +	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
> +	/*
> +	 * Sort all the map's Erase Types in ascending order with the smallest
> +	 * erase size being the first member in the erase_type array.
> +	 */
> +	sort(erase_type, SNOR_ERASE_TYPE_MAX, sizeof(erase_type[0]),
> +	     spi_nor_map_cmp_erase_type, NULL);
> +	/*
> +	 * Sort the erase types in the uniform region in order to update the
> +	 * uniform_erase_type bitmask. The bitmask will be used later on when
> +	 * selecting the uniform erase.
> +	 */
> +	spi_nor_regions_sort_erase_types(map);
> +	map->uniform_erase_type =3D map->uniform_region.offset &
> +				  SNOR_ERASE_TYPE_MASK;
>=20
>  	/* Stop here if not JESD216 rev A or later. */
>  	if (bfpt_header->length < BFPT_DWORD_MAX) @@ -2480,6 +2891,9
> @@ static int spi_nor_init_params(struct spi_nor *nor,
>  			       const struct flash_info *info,
>  			       struct spi_nor_flash_parameter *params)  {
> +	struct spi_nor_erase_map *map =3D &nor->erase_map;
> +	u8 i, erase_mask;
> +
>  	/* Set legacy flash parameters as default. */
>  	memset(params, 0, sizeof(*params));
>=20
> @@ -2519,6 +2933,28 @@ static int spi_nor_init_params(struct spi_nor *nor=
,
>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
>  				SPINOR_OP_PP, SNOR_PROTO_1_1_1);
>=20
> +	/*
> +	 * Sector Erase settings. Sort Erase Types in ascending order, with the
> +	 * smallest erase size starting at BIT(0).
> +	 */
> +	erase_mask =3D 0;
> +	i =3D 0;
> +	if (info->flags & SECT_4K_PMC) {
> +		erase_mask |=3D BIT(i);
> +		spi_nor_set_erase_type(&map->erase_type[i], 4096u,
> +				       SPINOR_OP_BE_4K_PMC);
> +		i++;
> +	} else if (info->flags & SECT_4K) {
> +		erase_mask |=3D BIT(i);
> +		spi_nor_set_erase_type(&map->erase_type[i], 4096u,
> +				       SPINOR_OP_BE_4K);
> +		i++;
> +	}
> +	erase_mask |=3D BIT(i);
> +	spi_nor_set_erase_type(&map->erase_type[i], info->sector_size,
> +			       SPINOR_OP_SE);
> +	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
> +
>  	/* Select the procedure to set the Quad Enable bit. */
>  	if (params->hwcaps.mask & (SNOR_HWCAPS_READ_QUAD |
>  				   SNOR_HWCAPS_PP_QUAD)) {
> @@ -2546,20 +2982,20 @@ static int spi_nor_init_params(struct spi_nor *no=
r,
>  			params->quad_enable =3D info->quad_enable;
>  	}
>=20
> -	/* Override the parameters with data read from SFDP tables. */
> -	nor->addr_width =3D 0;
> -	nor->mtd.erasesize =3D 0;
>  	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) &&
>  	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
>  		struct spi_nor_flash_parameter sfdp_params;
> +		struct spi_nor_erase_map prev_map;
>=20
>  		memcpy(&sfdp_params, params, sizeof(sfdp_params));
> -		if (spi_nor_parse_sfdp(nor, &sfdp_params)) {
> -			nor->addr_width =3D 0;
> -			nor->mtd.erasesize =3D 0;
> -		} else {
> +		memcpy(&prev_map, &nor->erase_map, sizeof(prev_map));
> +
> +		if (spi_nor_parse_sfdp(nor, &sfdp_params))
> +			/* restore previous erase map */
> +			memcpy(&nor->erase_map, &prev_map,
> +			       sizeof(nor->erase_map));
> +		else
>  			memcpy(params, &sfdp_params, sizeof(*params));
> -		}
>  	}
>=20
>  	return 0;
> @@ -2668,29 +3104,103 @@ static int spi_nor_select_pp(struct spi_nor *nor=
,
>  	return 0;
>  }
>=20
> -static int spi_nor_select_erase(struct spi_nor *nor,
> -				const struct flash_info *info)
> +/*
> + * spi_nor_select_uniform_erase() - select optimum uniform erase type
> + * @map:		the erase map of the SPI NOR
> + * @wanted_size:	the erase type size to search for. Contains the value o=
f
> + *			info->sector_size or of the "small sector" size in case
> + *			CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is defined.
> + *
> + * Once the optimum uniform sector erase command is found, disable all
> +the
> + * other.
> + *
> + * Return: pointer to erase type on success, NULL otherwise.
> + */
> +static const struct spi_nor_erase_type *
> +spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
> +			     const u32 wanted_size)
>  {
> -	struct mtd_info *mtd =3D &nor->mtd;
> +	const struct spi_nor_erase_type *tested_erase, *erase =3D NULL;
> +	int i;
> +	u8 uniform_erase_type =3D map->uniform_erase_type;
>=20
> -	/* Do nothing if already configured from SFDP. */
> -	if (mtd->erasesize)
> -		return 0;
> +	for (i =3D SNOR_ERASE_TYPE_MAX - 1; i >=3D 0; i--) {
> +		if (!(uniform_erase_type & BIT(i)))
> +			continue;
> +
> +		tested_erase =3D &map->erase_type[i];
> +
> +		/*
> +		 * If the current erase size is the one, stop here:
> +		 * we have found the right uniform Sector Erase command.
> +		 */
> +		if (tested_erase->size =3D=3D wanted_size) {
> +			erase =3D tested_erase;
> +			break;
> +		}
>=20
> +		/*
> +		 * Otherwise, the current erase size is still a valid canditate.
> +		 * Select the biggest valid candidate.
> +		 */
> +		if (!erase && tested_erase->size)
> +			erase =3D tested_erase;
> +			/* keep iterating to find the wanted_size */
> +	}
> +
> +	if (!erase)
> +		return NULL;
> +
> +	/* Disable all other Sector Erase commands. */
> +	map->uniform_erase_type &=3D ~SNOR_ERASE_TYPE_MASK;
> +	map->uniform_erase_type |=3D BIT(erase - map->erase_type);
> +	return erase;
> +}
> +
> +static int spi_nor_select_erase(struct spi_nor *nor, u32 wanted_size) {
> +	struct spi_nor_erase_map *map =3D &nor->erase_map;
> +	const struct spi_nor_erase_type *erase =3D NULL;
> +	struct mtd_info *mtd =3D &nor->mtd;
> +	int i;
> +
> +	/*
> +	 * The previous implementation handling Sector Erase commands
> assumed
> +	 * that the SPI flash memory has an uniform layout then used only one
> +	 * of the supported erase sizes for all Sector Erase commands.
> +	 * So to be backward compatible, the new implementation also tries to
> +	 * manage the SPI flash memory as uniform with a single erase sector
> +	 * size, when possible.
> +	 */
>  #ifdef CONFIG_MTD_SPI_NOR_USE_4K_SECTORS
>  	/* prefer "small sector" erase if possible */
> -	if (info->flags & SECT_4K) {
> -		nor->erase_opcode =3D SPINOR_OP_BE_4K;
> -		mtd->erasesize =3D 4096;
> -	} else if (info->flags & SECT_4K_PMC) {
> -		nor->erase_opcode =3D SPINOR_OP_BE_4K_PMC;
> -		mtd->erasesize =3D 4096;
> -	} else
> +	wanted_size =3D 4096u;
>  #endif
> -	{
> -		nor->erase_opcode =3D SPINOR_OP_SE;
> -		mtd->erasesize =3D info->sector_size;
> +
> +	if (spi_nor_has_uniform_erase(nor)) {
> +		erase =3D spi_nor_select_uniform_erase(map, wanted_size);
> +		if (!erase)
> +			return -EINVAL;
> +		nor->erase_opcode =3D erase->opcode;
> +		mtd->erasesize =3D erase->size;
> +		return 0;
>  	}
> +
> +	/*
> +	 * For non-uniform SPI flash memory, set mtd->erasesize to the
> +	 * maximum erase sector size. No need to set nor->erase_opcode.
> +	 */
> +	for (i =3D SNOR_ERASE_TYPE_MAX - 1; i >=3D 0; i--) {
> +		if (map->erase_type[i].size) {
> +			erase =3D &map->erase_type[i];
> +			break;
> +		}
> +	}
> +
> +	if (!erase)
> +		return -EINVAL;
> +
> +	mtd->erasesize =3D erase->size;
>  	return 0;
>  }
>=20
> @@ -2737,7 +3247,7 @@ static int spi_nor_setup(struct spi_nor *nor, const
> struct flash_info *info,
>  	}
>=20
>  	/* Select the Sector Erase command. */
> -	err =3D spi_nor_select_erase(nor, info);
> +	err =3D spi_nor_select_erase(nor, info->sector_size);
>  	if (err) {
>  		dev_err(nor->dev,
>  			"can't select erase settings supported by both the SPI
> controller and memory.\n"); diff --git a/include/linux/mtd/spi-nor.h
> b/include/linux/mtd/spi-nor.h index 09a10fd..a873a0b 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -240,6 +240,94 @@ enum spi_nor_option_flags {  };
>=20
>  /**
> + * struct spi_nor_erase_type - Structure to describe a SPI NOR erase typ=
e
> + * @size:		the size of the sector/block erased by the erase type.
> + *			JEDEC JESD216B imposes erase sizes to be a power of 2.
> + * @size_shift:		@size is a power of 2, the shift is stored in
> + *			@size_shift.
> + * @size_mask:		the size mask based on @size_shift.
> + * @opcode:		the SPI command op code to erase the sector/block.
> + * @idx:		Erase Type index as sorted in the Basic Flash Parameter
> + *			Table. It will be used to synchronize the supported
> + *			Erase Types with the ones identified in the SFDP
> + *			optional tables.
> + */
> +struct spi_nor_erase_type {
> +	u32	size;
> +	u32	size_shift;
> +	u32	size_mask;
> +	u8	opcode;
> +	u8	idx;
> +};
> +
> +/**
> + * struct spi_nor_erase_command - Used for non-uniform erases
> + * The structure is used to describe a list of erase commands to be
> +executed
> + * once we validate that the erase can be performed. The elements in
> +the list
> + * are run-length encoded.
> + * @list:		for inclusion into the list of erase commands.
> + * @count:		how many times the same erase command should be
> + *			consecutively used.
> + * @size:		the size of the sector/block erased by the command.
> + * @opcode:		the SPI command op code to erase the sector/block.
> + */
> +struct spi_nor_erase_command {
> +	struct list_head	list;
> +	u32			count;
> +	u32			size;
> +	u8			opcode;
> +};
> +
> +/**
> + * struct spi_nor_erase_region - Structure to describe a SPI NOR erase r=
egion
> + * @offset:		the offset in the data array of erase region start.
> + *			LSB bits are used as a bitmask encoding flags to
> + *			determine if this region is overlaid, if this region is
> + *			the last in the SPI NOR flash memory and to indicate
> + *			all the supported erase commands inside this region.
> + *			The erase types are sorted in ascending order with the
> + *			smallest Erase Type size being at BIT(0).
> + * @size:		the size of the region in bytes.
> + */
> +struct spi_nor_erase_region {
> +	u64		offset;
> +	u64		size;
> +};
> +
> +#define SNOR_ERASE_TYPE_MAX	4
> +#define SNOR_ERASE_TYPE_MASK
> 	GENMASK_ULL(SNOR_ERASE_TYPE_MAX - 1, 0)
> +
> +#define SNOR_LAST_REGION	BIT(4)
> +#define SNOR_OVERLAID_REGION	BIT(5)
> +
> +#define SNOR_ERASE_FLAGS_MAX	6
> +#define SNOR_ERASE_FLAGS_MASK
> 	GENMASK_ULL(SNOR_ERASE_FLAGS_MAX - 1, 0)
> +
> +/**
> + * struct spi_nor_erase_map - Structure to describe the SPI NOR erase ma=
p
> + * @regions:		array of erase regions. The regions are consecutive in
> + *			address space. Walking through the regions is done
> + *			incrementally.
> + * @uniform_region:	a pre-allocated erase region for SPI NOR with a unif=
orm
> + *			sector size (legacy implementation).
> + * @erase_type:		an array of erase types shared by all the regions.
> + *			The erase types are sorted in ascending order, with the
> + *			smallest Erase Type size being the first member in the
> + *			erase_type array.
> + * @uniform_erase_type:	bitmask encoding erase types that can erase
> the
> + *			entire memory. This member is completed at init by
> + *			uniform and non-uniform SPI NOR flash memories if
> they
> + *			support at least one erase type that can erase the
> + *			entire memory.
> + */
> +struct spi_nor_erase_map {
> +	struct spi_nor_erase_region	*regions;
> +	struct spi_nor_erase_region	uniform_region;
> +	struct spi_nor_erase_type	erase_type[SNOR_ERASE_TYPE_MAX];
> +	u8				uniform_erase_type;
> +};
> +
> +/**
>   * struct flash_info - Forward declaration of a structure used internall=
y by
>   *		       spi_nor_scan()
>   */
> @@ -263,6 +351,7 @@ struct flash_info;
>   * @write_proto:	the SPI protocol for write operations
>   * @reg_proto		the SPI protocol for read_reg/write_reg/erase
> operations
>   * @cmd_buf:		used by the write_reg
> + * @erase_map:		the erase map of the SPI NOR
>   * @prepare:		[OPTIONAL] do some preparations for the
>   *			read/write/erase/lock/unlock operations
>   * @unprepare:		[OPTIONAL] do some post work after the
> @@ -298,6 +387,7 @@ struct spi_nor {
>  	bool			sst_write_second;
>  	u32			flags;
>  	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> +	struct spi_nor_erase_map	erase_map;
>=20
>  	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
>  	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops); @@ -
> 318,6 +408,23 @@ struct spi_nor {
>  	void *priv;
>  };
>=20
> +static u64 __maybe_unused
> +spi_nor_region_is_last(const struct spi_nor_erase_region *region) {
> +	return region->offset & SNOR_LAST_REGION; }
> +
> +static u64 __maybe_unused
> +spi_nor_region_end(const struct spi_nor_erase_region *region) {
> +	return (region->offset & ~SNOR_ERASE_FLAGS_MASK) + region->size; }
> +
> +static bool __maybe_unused spi_nor_has_uniform_erase(const struct
> +spi_nor *nor) {
> +	return !!nor->erase_map.uniform_erase_type;
> +}
> +
>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
>  					  struct device_node *np)
>  {
> --
> 2.9.4
>=20
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists=
.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-
> mtd%2F&amp;data=3D02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C3c782e5
> 2b7fd4a8b9af008d617fd5154%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C636722774108718782&amp;sdata=3DcSpHUDMi0LDV%2FxAYj6i6piSi3gn%
> 2BDGAMWKoOx3%2F5%2BsU%3D&amp;reserved=3D0
