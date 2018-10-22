Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABDCC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25C2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L2SyFbyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE25C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeJVSVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:21:54 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:15968
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbeJVSVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsoiL83gGyhfktQGT3EOILUg9YMS7Y7ct5fuIiBuCIY=;
 b=L2SyFbyhMddnupVlQhz89yQxkTHwvjwW+0MDxwH9NQuMlYToBSXCG6H65E+fwQ3oU6Lc6Tn9VB7U1RoyCmjeCvL3yZd6ck8xwcRQWtQEUT+Eu3g3/RBicJIo4gT77OaePMaY5JivVD+qDAwVZaI9VgkaKFXQS4e/7qFpb1XOorM=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4574.eurprd04.prod.outlook.com (20.177.55.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 10:03:56 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 10:03:55 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
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
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0A==
Date:   Mon, 22 Oct 2018 10:03:55 +0000
Message-ID: <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20180911154007.17195-2-tudor.ambarus@microchip.com>
        <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
        <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017090724.12f2cd79@bbrezillon>    <20181017091045.124e0266@bbrezillon>
        <20181017092941.3658bd9a@bbrezillon>
        <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017115237.07310b74@bbrezillon>
        <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022111543.2a607efc@bbrezillon>
In-Reply-To: <20181022111543.2a607efc@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4574;6:7CDrh2KumrpvsxzGpWffpqNHIo9CUMzshjJfJ+3nzaZPS6aVHr9wuXNDkIX1TyI64JwY28HejxfG8Am750ukHp8KxVyQIJBO+ppwIFqrQx6JaJGejrH3lrFnjJk4Q/LFVTsi2iPLbE39If8t7kym4UEGDZsfNDnEqs6S8pqjhN3lNRS7kRggPiL94k0EoKDaw/nceliMVHOhejbydAP9G+Uc0+YcFJX4iCraSwUU/XSKlBt+hoGkzqeV+kVjO6VvoJQ96U+4UyhBcJ7t7NFENW4sByZcsL45SSL5mA1y1yCdcrPIGT12iefV5KL+m5aZZQywJnnD/KRr/8GSepHQ9ner4eOafdPNjtZAnvBKoySkzJtUplq9K9jErRv1ENt0kv26M0HSWLM0sS7sWkxgNQ4yMMGPUgNHprS6P6n5r9NCVnMaZPMo82edA+it8Ow36/2ikRCkT2pyrB7Bcea33Q==;5:CZnvxdKu+16vEcjHXOKIzg1YYo3o3xTx0vmVzPB5vscWT1OZm8d2SPbw01QwMl2pfXeKMjYUFAsFJNvd/Ll8cnsXM7DRRnv940rygrPDjJrLH4FfIkwzLOpYS7gcFZNHfNVibmdYugu9x5yh9A/zBWZmMERsmkyzKov8TtduhJ4=;7:T0iutP5qQP166BF09mYA6+nH6E3jeX6u4+RiVePVIeJRXYnv4lFWxJtXyR1DLE4gcBVFIJ4O2KJ0RHN0IVv/y/ZZuMlsPk2Cgv/rophiiuAkuxxkenHRpVnvR8wynddQDDdBsmfmAUrBDnvJIzplsNIz7Jx1lBSuEK83MFUduwies2FmOoDBKshFbgqkOrcI3B7LwwDqF55uIHWfFWbCHvLzkXF8yLyJ3MIbXa5HnuY67oDcBmMaioIwM3dy97hx
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 33c63e52-ee19-4917-1be9-08d63805ada8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4574;
x-ms-traffictypediagnostic: VI1PR04MB4574:
x-microsoft-antispam-prvs: <VI1PR04MB457441A19CB3AEF327A10C5D99F40@VI1PR04MB4574.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4574;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4574;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(13464003)(66066001)(33656002)(106356001)(86362001)(105586002)(5660300001)(5250100002)(97736004)(8676002)(81156014)(81166006)(8936002)(53936002)(78486010)(6436002)(39060400002)(55016002)(305945005)(74316002)(7416002)(2906002)(25786009)(217873002)(4326008)(256004)(7736002)(6116002)(3846002)(478600001)(6506007)(53546011)(76176011)(99286004)(446003)(7696005)(93886005)(6916009)(14454004)(6246003)(2900100001)(68736007)(476003)(229853002)(11346002)(9686003)(71190400001)(71200400001)(26005)(486006)(316002)(54906003)(186003)(102836004)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4574;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dPMpclwFzrhCtk1j/D2kswTZeoH/8owwxWAg4OMPMkUGDxXZkpHbcwQmnwfN3AAg+kiGi3xnA1/4iSEGv6eAPctGXBcwroIiwBfldZ7L3EiEjZ+NBQJIGuWTBy2Vr39qWp9ZOEOHURrG/QtZowQJ6lTMD+D9ulmWR/mzMT/TMDTUkPO3TMcBkKoc7fw4bEI7zEdX2Movgxp9vA1fgP1CY2EGs4+T8RhHJuBc6l+2K9fYrTBHNAg9NTPn6K/SIr16p193rUl6ikKNy6VlGMR69Ii5ySy7x7JiHmOPBIJAsv8Fjfo3JNfNmHU7JGcwdLt1Eg+s1VCCErwkJY4G/dLiCIYncLK9FsXtEkhNY6/4P0w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c63e52-ee19-4917-1be9-08d63805ada8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 10:03:55.7440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 22, 2018 2:46 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard@nod.at; Mark
> Brown <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> Cristian.Birsan@microchip.com; Cyrille Pitchen <cyrille.pitchen@wedev4u.f=
r>;
> computersforpeace@gmail.com; dwmw2@infradead.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Mon, 22 Oct 2018 06:04:13 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
>=20
With below patch, it gets stuck in for loop of "+       for (nmaps =3D 0; i=
< smpt_len; nmaps++) {".

[    1.624684] m25p80 spi0.0: found s25fl512s, expected m25p80
[    1.630377] Start [addr_width:00000000, read_dumy:08, read_opcode:000000=
00]
[    1.637335] spi_nor_get_map_in_use:2882 smpt[0]=3D08ff65fc
[    1.642641] spi_nor_get_map_in_use:2882 smpt[1]=3D00000004
[    1.647945] spi_nor_get_map_in_use:2882 smpt[2]=3D04ff65fc
[    1.653248] spi_nor_get_map_in_use:2882 smpt[3]=3D00000002
[    1.658551] spi_nor_get_map_in_use:2882 smpt[4]=3D02ff65fd
[    1.663855] spi_nor_get_map_in_use:2882 smpt[5]=3D00000004
[    1.669158] spi_nor_get_map_in_use:2882 smpt[6]=3Dff0201fe
[    1.674461] spi_nor_get_map_in_use:2882 smpt[7]=3D00007ff1
[    1.679766] spi_nor_get_map_in_use:2882 smpt[8]=3D00037ff4
[    1.685070] spi_nor_get_map_in_use:2882 smpt[9]=3D03fbfff4
[    1.690375] spi_nor_get_map_in_use:2882 smpt[10]=3Dff0203fe
[    1.695768] spi_nor_get_map_in_use:2882 smpt[11]=3D03fbfff4
[    1.701158] spi_nor_get_map_in_use:2882 smpt[12]=3D00037ff4
[    1.706550] spi_nor_get_map_in_use:2882 smpt[13]=3D00007ff1
[    1.711940] spi_nor_get_map_in_use:2882 smpt[14]=3Dff0005ff
[    1.717330] spi_nor_get_map_in_use:2882 smpt[15]=3D03fffff4
[    1.722720] smpt[0]=3D[addr_width:00000000, read_dumy:08, read_opcode:00=
000065]
[    1.729861] spi_nor_get_map_in_use:2912 map_id=3D1


--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2863,26 +2863,36 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_=
nor *nor, const u32 settings)
  * @nor:       pointer to a 'struct spi_nor'
  * @smpt:      pointer to the sector map parameter table
  */
-static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *s=
mpt)
+static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *s=
mpt, u32 smpt_len)
 {
        const u32 *ret =3D NULL;
-       u32 i, addr;
+       u32 i, addr, nmaps;
        int err;
        u8 addr_width, read_opcode, read_dummy;
        u8 read_data_mask, data_byte, map_id;
+       bool map_id_is_valid =3D false;

        addr_width =3D nor->addr_width;
        read_dummy =3D nor->read_dummy;
        read_opcode =3D nor->read_opcode;

+       pr_info("Start [addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\=
n", nor->addr_width, nor->read_dummy, nor->read_opcode);
+
+       for (i =3D 0; i<smpt_len; i++)
+               pr_info("%s:%i smpt[%d]=3D%08x\n", __func__, __LINE__, i, s=
mpt[i]);
+
        map_id =3D 0;
-       i =3D 0;
        /* Determine if there are any optional Detection Command Descriptor=
s */
-       while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
+       for (i =3D 0; i< smpt_len; i++) {
+               if ((smpt[i] & SMPT_DESC_TYPE_MAP))
+                       break;
+
                read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
                nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i]);
                nor->read_dummy =3D spi_nor_smpt_read_dummy(nor, smpt[i]);
                nor->read_opcode =3D SMPT_CMD_OPCODE(smpt[i]);
+               pr_info("smpt[%d]=3D[addr_width:%08x, read_dumy:%0x8, read_=
opcode:%08x]\n", i, nor->addr_width, nor->read_dummy, nor->read_opcode);
+
                addr =3D smpt[i + 1];

                err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
@@ -2894,18 +2904,36 @@ static const u32 *spi_nor_get_map_in_use(struct spi=
_nor *nor, const u32 *smpt)
                 * Configuration that is currently in use.
                 */
                map_id =3D map_id << 1 | !!(data_byte & read_data_mask);
+               map_id_is_valid =3D true;
                i =3D i + 2;
        }

-       /* Find the matching configuration map */
-       while (SMPT_MAP_ID(smpt[i]) !=3D map_id) {
-               if (smpt[i] & SMPT_DESC_END)
-                       goto out;
+       if (map_id_is_valid)
+               pr_info("%s:%i map_id=3D%d\n", __func__, __LINE__, map_id);
+       else
+               pr_info("%s:%i NO map_id\n", __func__, __LINE__);
+
+       for (nmaps =3D 0; i< smpt_len; nmaps++) {
+               if((smpt[i] & SMPT_DESC_TYPE_MAP))
+                       continue;
+
+               if(!map_id_is_valid) {
+                       if (nmaps) {
+                               ret =3D NULL;
+                               break;
+                       }
+
+                       ret =3D smpt+i;
+               } else if (map_id =3D=3D SMPT_MAP_ID(smpt[i])) {
+                       ret =3D smpt+i;
+                       break;
+               }
+
                /* increment the table index to the next map */
                i +=3D SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
        }

-       ret =3D smpt + i;
+       pr_info("End [addr_width:%08x, read_dumy:%0x8, read_opcode:%08x]\n"=
, nor->addr_width, nor->read_dummy, nor->read_opcode);
        /* fall through */
 out:
        nor->addr_width =3D addr_width;
