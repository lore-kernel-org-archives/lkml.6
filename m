Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7091FC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEB620658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FKgLKxZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEB620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeJVUFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:05:19 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:20544
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727550AbeJVUFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwJmO9BIkpaelGIRoAQOlEorsUjDwjUfL6iccRg58YY=;
 b=FKgLKxZc6knC5lt15IpvIKJrFzLI+JEpe2XC1ZzAD1OUb5pdgODlUGHySYOgZhybXhIbbeRQ6AJETrzeLzSTdYHNSLO+KfC0KNYETFalvL9cZSsGJhG5vVc8cvOEkiIeKgqcIiyLTt86LU3E/xFXaMaXmC99HPkoIBRUlj6FLvI=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4974.eurprd04.prod.outlook.com (20.177.49.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 11:46:55 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 11:46:55 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
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
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAABzqAgAAC3GCAAAKVgIAAAdOAgAACLYCAAAvpAIAAAL7Q
Date:   Mon, 22 Oct 2018 11:46:55 +0000
Message-ID: <VI1PR04MB1038E072BFFD09C7C19AD2F899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
        <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
        <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017090724.12f2cd79@bbrezillon>    <20181017091045.124e0266@bbrezillon>
        <20181017092941.3658bd9a@bbrezillon>
        <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181017115237.07310b74@bbrezillon>
        <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022111543.2a607efc@bbrezillon>
        <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022122659.0675942e@bbrezillon>
        <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022124627.2c6c3b93@bbrezillon>    <20181022125259.42df83ea@bbrezillon>
        <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022134324.2c1bd248@bbrezillon>
In-Reply-To: <20181022134324.2c1bd248@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4974;6:O/ua2XLco5Koy7/3T7IVZCjmtAtQITCcvAfeV9mtM81hmrXz0PCEUl0ZtnDLhpKl7wIgSd+11ol94K2H+JSC1zFb45DErGTs8Nzo5aSgIztCJZwjQ7jLo06sZgkCGTB8EZ1hjHfiv2PD7XISd/MG2D2bpiOj3hIyKbv4+p5tJ4ucB3U/WGaYaSZBd5SjbV4S9kfrAGAYXbTuyBUFBdi+wV1hp0+HyH+9yq3JTGIqTBNDQB8fhaQ3nXgxqteQsyJCxAmncPATuGbk3arhyPikYLO09UNOunGNJcr1JLaspLUBcPMXkdX0AW1r1hVb2KmNNnXE8AFbhtBiyzmRCEHJBHvC3pejF4WtH/TpXjnUujeQKN12J7lepZFUajYZS/gDRyzDfAi2+5M8u3sTfyHBjKWUSlPchVns3LT7Y5SNmhBi5M7TLhgzE3Wqs/RdH3aPwLmsKmgSfzNTDBfcCLMKBg==;5:z56Z/3KtmsW2zkBBoJgfcaHhWj+yJ1mGLfE1vVU/r17HSD//TPTlsL4lyCZjP1td/v4CoOM3TabxcdylcH2IRZajYmUcfP+mstVOiW/NDEg+uXoMWxNIA+/ahrNOF0vk7PZYxfpNmCc+2EfUnLTY2KKqU+yGCwYBKvbkSu7Wo9M=;7:6uRQtyDbv9E0T0o9bxsCdOc69ZEVHgwITY0zAvdLMiEeDfq3wtcNlrt27GrSDLjjSgQcI8SC54wy+CkLuXzarmbMDZNT49IUO+MhLUWwtePe5O1R5hwUUqRJ4IK50iuCOt+NW8vPlLjVY9Yo56MweUvspPbmI0hO0nsfdPr0QZzYHd3Rul5xVZg2gfC1fj+uUTi0BrperTnyB1IKD4LVOl7ee9WuCnULgsiqHzNfUc/a0rQe2niF+Rn7ZLSnPDk7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a805f640-6b5f-4bfb-7ddc-08d63814113c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4974;
x-ms-traffictypediagnostic: VI1PR04MB4974:
x-microsoft-antispam-prvs: <VI1PR04MB49747B3E6D197634DCBE3FE099F40@VI1PR04MB4974.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4974;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4974;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(396003)(136003)(13464003)(199004)(189003)(68736007)(7696005)(33656002)(316002)(305945005)(8676002)(217873002)(229853002)(86362001)(14454004)(74316002)(93886005)(97736004)(7416002)(78486010)(6116002)(6916009)(478600001)(71190400001)(71200400001)(5250100002)(5660300001)(9686003)(6436002)(8936002)(102836004)(446003)(55016002)(106356001)(105586002)(486006)(4326008)(99286004)(2906002)(11346002)(66066001)(55236004)(3846002)(6506007)(53546011)(2900100001)(476003)(186003)(81156014)(81166006)(256004)(7736002)(6246003)(53936002)(54906003)(76176011)(25786009)(26005)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4974;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xf+xb19DLOBawL4drpSB8lhBufNZjcxy1McPeto9vWnEs+gQMZa1DWosdPV8c7jyZY/2UyHwCuVWZqItf08IVJBrYvGsYWEavbire75YOLgncmPt0PS4pEoP0BnBo8cWxk7O9OF3V1qZTPHt90jy+H7S/2t2/1zRsSz5llsFex6lCAop/SfbljS73NrqOga6TQ0aU21SYZWGXNrvZ7JriPkxT6xUh/dF8slCdVRiZ8SVr7+J1Y3MDaXFZnJi/m4TfNynuO5LjG8uBUzn+HqIIznAPYiXWyRl+3pH/kuORUfjBtEN5zfMCUzG2Z2GjkPJ3UB+i6NTMFjHgx3hAjSWR4sVKWgYPu2jf8uNslvs3EY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a805f640-6b5f-4bfb-7ddc-08d63814113c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 11:46:55.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4974
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, October 22, 2018 5:13 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Cristian.Birsan@microchip.com; Tudor Ambarus
> <tudor.ambarus@microchip.com>; richard@nod.at; Mark Brown
> <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; Cyrille Pit=
chen
> <cyrille.pitchen@wedev4u.fr>; computersforpeace@gmail.com;
> dwmw2@infradead.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Mon, 22 Oct 2018 11:03:09 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Monday, October 22, 2018 4:23 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> > > Cristian.Birsan@microchip.com
> > > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>; richard@nod.at;
> > > Mark Brown <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > > Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>;
> > > computersforpeace@gmail.com; dwmw2@infradead.org;
> > > linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform
> > > SFDP SPI NOR flash memories
> > >
> > > On Mon, 22 Oct 2018 12:46:27 +0200
> > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >
> > > > On Mon, 22 Oct 2018 10:39:48 +0000 Yogesh Narayan Gaur
> > > > <yogeshnarayan.gaur@nxp.com> wrote:
> > > >
Patch used

--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2863,26 +2863,39 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_=
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

+       pr_info("Start [addr_width:%08x, read_dumy:%08x, read_opcode:%08x]\=
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
-               nor->read_dummy =3D spi_nor_smpt_read_dummy(nor, smpt[i]);
+               if (!nor->addr_width)
+                       nor->addr_width =3D 3;
+
+               nor->read_dummy =3D 8; //spi_nor_smpt_read_dummy(nor, smpt[=
i]);
                nor->read_opcode =3D SMPT_CMD_OPCODE(smpt[i]);
+               pr_info("smpt[%d]=3D[addr_width:%08x, read_dumy:%08x, read_=
opcode:%08x]\n", i, nor->addr_width, nor->read_dummy, nor->read_opcode);
+
                addr =3D smpt[i + 1];

                err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
@@ -2894,18 +2907,37 @@ static const u32 *spi_nor_get_map_in_use(struct spi=
_nor *nor, const u32 *smpt)
                 * Configuration that is currently in use.
                 */
                map_id =3D map_id << 1 | !!(data_byte & read_data_mask);
-               i =3D i + 2;
+               map_id_is_valid =3D true;
        }

-       /* Find the matching configuration map */
-       while (SMPT_MAP_ID(smpt[i]) !=3D map_id) {
-               if (smpt[i] & SMPT_DESC_END)
-                       goto out;
+       if (map_id_is_valid)
+               pr_info("%s:%i map_id=3D%d smpt_len:%d i=3D:%d\n", __func__=
, __LINE__, map_id, smpt_len, i);
+       else
+               pr_info("%s:%i NO map_id\n", __func__, __LINE__);
+
+       for (nmaps =3D 0; i< smpt_len; nmaps++) {
+               if(!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
+                       i +=3D 2;
+                       continue;
+               }
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
+       pr_info("End [addr_width:%08x, read_dumy:%08x, read_opcode:%08x]\n"=
, nor->addr_width, nor->read_dummy, nor->read_opcode);
        /* fall through */
 out:
        nor->addr_width =3D addr_width;
@@ -3027,8 +3059,9 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
        for (i =3D 0; i < smpt_header->length; i++)
                smpt[i] =3D le32_to_cpu(smpt[i]);

-       sector_map =3D spi_nor_get_map_in_use(nor, smpt);
+       sector_map =3D spi_nor_get_map_in_use(nor, smpt, smpt_header->lengt=
h);
        if (!sector_map) {
+               pr_info("%s:%i\n", __func__, __LINE__);
                ret =3D -EINVAL;
                goto out;
        }
