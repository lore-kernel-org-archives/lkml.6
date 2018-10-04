Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D72C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDCF21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VpjiaiwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDCF21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeJDNns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:43:48 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:30450
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726899AbeJDNnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twkahazTH0Ti4wqkBQX5MmwPda037BSCkcewYIPvlzY=;
 b=VpjiaiwYmdJVuLBmuKuYgvcDG/BBG4KOljkYK0LCCsRVe3ZYOvUcI5X9+EISZZx7Ey014MZUlP1R5LTf/49aBQyUD1HB1B1WMxwfOd0IEbKE+xHDSCELJzCrjDF7cPdO7uv15Mz3OIpY0ClHBPgDOVVOQGaKc6rx6xGW3O9NDrM=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4093.eurprd04.prod.outlook.com (52.133.12.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Thu, 4 Oct 2018 06:51:41 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb%4]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 06:51:41 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Vignesh R <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Brian Norris <computersforpeace@gmail.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512aba
Thread-Topic: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for
 mt35xu512aba
Thread-Index: AQHUWzpebO9UjE7y3ESdBwkaF5y7X6UOpRKg
Date:   Thu, 4 Oct 2018 06:51:41 +0000
Message-ID: <VI1PR04MB1038C20CA97E453FC4C9CEAE99EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-2-vigneshr@ti.com>
In-Reply-To: <20181003165603.2579-2-vigneshr@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4093;6:5YR6IJhQ0Q4u53xIEKrFsAqzDk19evmBwa5rEaa9FiogQlHAj8pF6EJe2Tpnr8qiQ5wAbPhx6LJx+mVe1vq3hvW7+WJw4eJLF2mSU6xyBHVauRgu2l6h1nrmtS7S/XEt1NbUnHtjbaRRPBZhCLpMYAXK3m7HwJFgdoeqozd3eafAdpDpIYy7mXoyvz5uXwoMcWdUqDXrk4UbkiU/oJTtiWoWi+NZxHgN/+a1G0Dvv/VJqzFtfv35WJx8ZsHEi4f+IMpQAtkj4aPFk3wOg9Gb6CM6Rr+aaDBPNwZgq2XUy6gFBfrpgGYwGd0M3239iYSL1+csd11SuX6OX6rIvfTcBc2hfo0IICLN9j8Y2RbvQIGXkGbrhI64G7kwsSC/6kR+R2rSh6n/A56rhpZZxybxO+7yPzGmcrRQ7m/hbTOSqyYgvaAhulWpDxEVM6aYiCbGQ8GwYtniKxTZiIg4UjufSQ==;5:fIhT6Em4x8P6AHBOG4siAHtilOUW9JshnrXCaD7nODNVYMXYNUU4vRcKKmHgzuvsDKeruEV4NrTjzs6m8qdfO4txbsR+6uhC1uGUmhfGqhLxp0ulr/ySySC7ceFt9BQoueXbJ3KLym831dz/WKFdRkc1e0/uhU5VRzXk0nCmtEY=;7:AQqzl2xb5HM6/RnVhS7BYXOFNM6okT26jhkBgYOJcp5D3XP4O9H9tufm2FMObXkQ4jHwFrcRm0NjQFuYhU9X+GxOo0Ih8JcUgDCnLfS3qm10zTmr50f8YWbx+w5GiDvOtQigPKVi2XGKWIUchDY08tFKpbvO4jkfkqbYKPQrZWR5gB5NUJrhWwkHlK8zy6XJikbBaJuFeJ3RK2maUdXhxri6EKkBmrc+j6Uj92048lQl2VqayQ1h9vTUW2NPiZEL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 944464f4-0fcc-47ea-9850-08d629c5d73a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4093;
x-ms-traffictypediagnostic: VI1PR04MB4093:
x-microsoft-antispam-prvs: <VI1PR04MB4093F997BFE795B265F5ABA699EA0@VI1PR04MB4093.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(258649278758335)(9452136761055)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:VI1PR04MB4093;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4093;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(13464003)(74316002)(7736002)(6116002)(575784001)(6436002)(3846002)(8936002)(305945005)(25786009)(97736004)(478600001)(33656002)(86362001)(2900100001)(105586002)(66066001)(486006)(8676002)(26005)(476003)(186003)(6246003)(81166006)(11346002)(5660300001)(102836004)(81156014)(7696005)(68736007)(229853002)(4326008)(446003)(53546011)(2906002)(55236004)(14454004)(53936002)(6506007)(54906003)(106356001)(39060400002)(76176011)(110136005)(316002)(99286004)(71190400001)(71200400001)(14444005)(256004)(55016002)(5250100002)(9686003)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4093;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W4Jlz3hJorWUCu2xZG1LFGW9MYbSQQfBWdRzzTkUD0EzLFe3KALn7EAiwFQbjdUO36uvQJaVN3jSO9zezq+8MUpFH0MsYtwoLC4GyrG8trtc3dmAZrDp5/o1tSqztl1mlDx7pTBwDSnDpMbnWrplT0Qu2Vqi8g01ZfRvRXpg6BVpiEmGRGVKg4f7NulRrBP8VPW8TTbXEXuV/lYfZnvln/ZLXYniloAisbZlct96krMKiP+2zUyNRsxa2x5kT0aIYD+T0pQDNnWtltvCUgEhiTy76Dm7KrlGpeuphFxZmxld/Gg3xXBqFFKmEc99w55sylrNBZuV/RNyhY7bqX9ER6GH88q5LBWHrPxKZZEMQOw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944464f4-0fcc-47ea-9850-08d629c5d73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 06:51:41.4179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

> -----Original Message-----
> From: Vignesh R [mailto:vigneshr@ti.com]
> Sent: Wednesday, October 3, 2018 10:26 PM
> To: Boris Brezillon <boris.brezillon@bootlin.com>; Marek Vasut
> <marek.vasut@gmail.com>; Rob Herring <robh+dt@kernel.org>
> Cc: Brian Norris <computersforpeace@gmail.com>; Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com>; Linux ARM Mailing List <linux-arm-
> kernel@lists.infradead.org>; linux-mtd@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Vignesh R
> <vigneshr@ti.com>
> Subject: [PATCH 1/3] mtd: spi-nor: Add Octal mode support for mt35xu512ab=
a
>=20
> Micron's mt35xu512aba flash is an Octal flash that has x8 IO lines. It su=
pports
> read/write over 8 IO lines simulatenously. Add support for Octal read mod=
e for
> Micron mt35xu512aba.
> Unfortunately, this flash is only complaint to SFDP JESD216B and does not=
 seem
> to support newer JESD216C standard that provides auto detection of Octal
> mode capabilities and opcodes. Therefore, this capability is manually add=
ed
> using new SPI_NOR_OCTAL_READ flag.
>=20

Thanks for sending the patch-set of adding octal support.
If possible, can you share the MT35x datasheet?

I also have the patch ready in which I have added support for Read (1-1-8 a=
nd 1-8-8) protocol and Write (1-1-8 and 1-8-8).
Also have added support of Octal in driver/spi/spi.c framework.

IMO, we would collaborate our patches.
--
Regards
Yogesh Gaur

> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 11 ++++++++++-
>  include/linux/mtd/spi-nor.h   |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c index
> aff5e6ff0b2c..4926e805a8cb 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -90,6 +90,7 @@ struct flash_info {
>  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip
> erase */
>  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
>  #define USE_CLSR		BIT(14)	/* use CLSR command */
> +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
>=20
>  	int	(*quad_enable)(struct spi_nor *nor);
>  };
> @@ -209,6 +210,7 @@ static inline u8 spi_nor_convert_3to4_read(u8 opcode)
>  		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
>  		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
>  		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
> +		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
>=20
>  		{ SPINOR_OP_READ_1_1_1_DTR,
> 	SPINOR_OP_READ_1_1_1_DTR_4B },
>  		{ SPINOR_OP_READ_1_2_2_DTR,
> 	SPINOR_OP_READ_1_2_2_DTR_4B },
> @@ -1406,7 +1408,7 @@ static const struct flash_info spi_nor_ids[] =3D {
>  	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K |
> USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>=20
>  	/* Micron */
> -	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K |
> USE_FSR | SPI_NOR_4B_OPCODES) },
> +	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K |
> USE_FSR
> +| SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
>=20
>  	/* PMC */
>  	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
> @@ -3199,6 +3201,13 @@ static int spi_nor_init_params(struct spi_nor *nor=
,
>  					  SNOR_PROTO_1_1_4);
>  	}
>=20
> +	if (info->flags & SPI_NOR_OCTAL_READ) {
> +		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
> +		spi_nor_set_read_settings(&params-
> >reads[SNOR_CMD_READ_1_1_8],
> +					  0, 8, SPINOR_OP_READ_1_1_8,
> +					  SNOR_PROTO_1_1_8);
> +	}
> +
>  	/* Page Program settings. */
>  	params->hwcaps.mask |=3D SNOR_HWCAPS_PP;
>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h in=
dex
> 8b1acf68b7ac..ae9861ed7e0f 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -50,6 +50,7 @@
>  #define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O
> SPI) */
>  #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad
> Output SPI) */
>  #define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O
> SPI) */
> +#define SPINOR_OP_READ_1_1_8	0x8b	/* Read data bytes (Octal
> Output SPI) */
>  #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_PP_1_1_4	0x32	/* Quad page program */
>  #define SPINOR_OP_PP_1_4_4	0x38	/* Quad page program */
> @@ -73,6 +74,7 @@
>  #define SPINOR_OP_READ_1_2_2_4B	0xbc	/* Read data bytes (Dual I/O
> SPI) */
>  #define SPINOR_OP_READ_1_1_4_4B	0x6c	/* Read data bytes (Quad
> Output SPI) */
>  #define SPINOR_OP_READ_1_4_4_4B	0xec	/* Read data bytes (Quad I/O
> SPI) */
> +#define SPINOR_OP_READ_1_1_8_4B	0x7c	/* Read data bytes (Octal
> Output SPI) */
>  #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256
> bytes) */
>  #define SPINOR_OP_PP_1_1_4_4B	0x34	/* Quad page program */
>  #define SPINOR_OP_PP_1_4_4_4B	0x3e	/* Quad page program */
> --
> 2.19.0

