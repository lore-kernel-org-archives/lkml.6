Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8AECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D81320779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jXczhc5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D81320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJVOV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:21:26 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:18656
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbeJVOV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPwn77UcI+alp9web/fmCobIMO4YOqdb5G3zbPrJ29I=;
 b=jXczhc5NXHUCpAZuiuWlcGENqlbjuMgMX0JMPuQxEBuxJxxV+5LpyY/dyKIuQPkQJrr22EwOn4v/+kSzyLIfXOg51Z3KJbZWsPqQ02tqhWGr13+0K1oE6yxxxEzc3m3Tvy0XE4fF4fepBSLN+Z7gcu3dsLlp82MI9n79DMvIOxg=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 06:04:14 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Mon, 22 Oct 2018
 06:04:13 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
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
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMg
Date:   Mon, 22 Oct 2018 06:04:13 +0000
Message-ID: <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
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
In-Reply-To: <20181017115237.07310b74@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5040;6:88I1szX82EFm9N4NCBGtfA2Paa21tU9C1UbRSx0YXMlpGUPUncL7y6NgsWSne/c42/CZ3/4y5FDhJJPoMT/ipkeA30l6IWnc43sVBjsRrT+tUiG8kkohO3QWExp6Hwgs/cCRebjZ/j40V0H2h2b7M+6pPH/PLezc7BoCpe0cOpWXMGDE7eJ0CWHoKC/1PMLJs5aGWtB99cQjmPtZ43tCEnPYTTqm7Gg4Uhe4oNkmEAFNzJjjhtDRwJqcWZHIIggyiUUfI7VlyoePQ8or9yvT/qRs4bkHyOFLMdLC5wwv+3bCgWWfMVyRJo+734/aBr5P3E+D+33eyaBnnaTlFPXuPvVgw452kaDgsRQLbWgB1qOFwPpU8V8B/SdqwPTKlxkPKN1YQMdTABHuzV4i86EYeufKhrqkpfWtT0/lQ6HcxadMRNxmacGzAY0shzxsWIbhCKyff+0RTtYjb0p+HNaoLQ==;5:vvN/FcbFtP1AxNKQRmLIcu73Cm8dram9WdOo5ntH7niykM51w3cOjoqJaJhN+F/Ua2V/lQqSLpszw0Gn7UhRMhdEmK8Oeo5+cTrC0aexGqwpPZ0AZkaXCnv1YpOIJhAwOCaX/SEGyVGxC77xiNr7p3Mj2ARP+7lhW1BYnMD3uKI=;7:B9+0EK9nrc6jH98WFWRd1cuLvwagJhBnINq6jDQTmsIE6YXHtABHxXarTUtWZGqv8Tft80LTEymWXbjFfCl/E82rCjNBsq4UspVgx9OwjJyZdkruTSFvJkbyMZm3J1BcgY7hI9EY9qBWcTvwHFxM6BsrlLZrk7iVd08B3Xaqtkdy33qM/Lob02kiwo77q2XhNFz/Ox9hrNsYkCgdlUx6y6iQqGNQA5beECL9EUeBLwRi/Cks5WH8yHtMmXUbO3lR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 08f633bf-ac03-44be-1caa-08d637e430f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5040;
x-ms-traffictypediagnostic: VI1PR04MB5040:
x-microsoft-antispam-prvs: <VI1PR04MB5040A1C655F78DC53F46C15299F40@VI1PR04MB5040.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(9452136761055)(258649278758335)(261952635957900)(258095267146985)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(4982022)(52105095)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5040;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5040;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(13464003)(189003)(4326008)(26005)(81156014)(7696005)(25786009)(478600001)(7736002)(74316002)(6436002)(76176011)(446003)(93886005)(217873002)(966005)(53546011)(6506007)(2900100001)(55236004)(256004)(1720100001)(476003)(14454004)(99286004)(97736004)(86362001)(39060400002)(186003)(68736007)(9686003)(71190400001)(71200400001)(53936002)(5660300001)(6116002)(3846002)(33656002)(2906002)(5250100002)(6246003)(66066001)(14444005)(6916009)(78486010)(102836004)(105586002)(316002)(11346002)(229853002)(8676002)(6306002)(305945005)(106356001)(7416002)(8936002)(486006)(55016002)(54906003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5040;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HtsakipMtf5ALgV8bJ6k7E3/7MhgmVxjmPRQntA6LWeTzl6HsdSjPVkiSi7NvLh8f5C/OULxIXW7iMFjCPDnLEh3wXY6ocOxD57rprJFhYIaIEogKS9eJfU8jp19WZMgXsUg6qrfsYmBGiKt2cL4Aljtbqw9uK3/d2CxNJGGmnpa4NlO8BLdhNAMM+XuHvQWHvG/Qle+64OsfQIYwbszy7d1zASVgao09MBbnKI3UXL63jFum4f1+2cRZzyxbLSbHjAVieAKuUN3IEWZ3Bs2Mqum8dw6GkDFjDYhyMpfUHndvAQwTvFXL3mYamugwqeBMyDAj/vLEgeFmEZFvrLwrxWnFYbkXARs1zR5TRs8v8s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f633bf-ac03-44be-1caa-08d637e430f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 06:04:13.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, Tudor,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Wednesday, October 17, 2018 3:23 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Tudor Ambarus
> <tudor.ambarus@microchip.com>; marek.vasut@gmail.com;
> dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org; Cristian.Birsan@microchip.com
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Wed, 17 Oct 2018 07:46:30 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Wednesday, October 17, 2018 1:00 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>; Tudor Ambarus
> > > <tudor.ambarus@microchip.com>; marek.vasut@gmail.com;
> > > dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at;
> > > linux-kernel@vger.kernel.org; nicolas.ferre@microchip.com;
> > > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > > linux-arm- kernel@lists.infradead.org; Cristian.Birsan@microchip.com
> > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform
> > > SFDP SPI NOR flash memories
> > >
> > > On Wed, 17 Oct 2018 09:10:45 +0200
> > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >
> > > > On Wed, 17 Oct 2018 09:07:24 +0200 Boris Brezillon
> > > > <boris.brezillon@bootlin.com> wrote:
> > > >
> > > > > On Wed, 17 Oct 2018 02:07:43 +0000 Yogesh Narayan Gaur
> > > > > <yogeshnarayan.gaur@nxp.com> wrote:
> > > > >
> > > > > > >
> > > > > > Actually there is no entry of s25fs512s in current spi-nor.c fi=
le.
> > > > > > For my connected flash part, jedec ID read points to
> > > > > > s25fl512s. I have asked my board team to confirm the name of
> > > > > > exact connected flash part. When I check the data sheet of
> > > > > > s25fs512s, it also points to the same Jedec ID information. {
> > > > > > "s25fl512s", INFO(0x010220, 0x4d00, 256
> > > > > > * 1024, 256, ....}
> > > > > >
> > > > > > But as stated earlier, if I skip reading SFDP or read using
> > > > > > 1-1-1 protocol then read are always correct. For 1-4-4
> > > > > > protocol read are wrong and on further debugging found that
> > > > > > Read code of 0x6C is being send as opcode instead of 0xEC.
> > > > > >
> > > > > > If I revert this patch, reads are working fine.
> > > > >
> > > > > Can you try with the following patch?
> > > > >
> > > >
> > > > Hm, nevermind. The problem is actually not related to 4B vs non-4B
> > > > mode but 1-1-4 vs 1-4-4 modes.
> > Yes, that's only I have stated in my first mail that instead of 1-4-4 m=
ode read
> opcode is being sent for 1-1-4 mode.
> > > >
> > >
> > > Can you try with this patch applied?
> > >
> > With suggested patch, read for protocol 1-4-4 working correctly.
> >
> > 	[    1.625360] m25p80 spi0.0: found s25fl512s, expected m25p80
> > 	[    1.631094] m25p80 spi0.0: failed to parse SMPT (err =3D -22)
> > 	[    1.636661] 261 8c4c780 opcode(read:eb, pp:2, erase:d8)
> > 	[    1.641878] 266 8c4c780 opcode(read:ec, pp:12, erase:dc)
> > 	[    1.647200] m25p80 spi0.0: s25fl512s (65536 Kbytes)
> >
>=20
> Okay, let's try this one to see why the SMPT parsing fails.
>=20

Please find the below info for the SMPT table read from the flash
[    1.631085] spi_nor_get_map_in_use:2880 smpt[0]=3D08ff65fc  =20
[    1.636393] spi_nor_get_map_in_use:2880 smpt[1]=3D00000004  =20
[    1.641696] spi_nor_get_map_in_use:2880 smpt[2]=3D04ff65fc  =20
[    1.646998] spi_nor_get_map_in_use:2880 smpt[3]=3D00000002  =20
[    1.652302] spi_nor_get_map_in_use:2880 smpt[4]=3D02ff65fd  =20
[    1.657606] spi_nor_get_map_in_use:2880 smpt[5]=3D00000004  =20
[    1.662911] spi_nor_get_map_in_use:2880 smpt[6]=3Dff0201fe  =20
[    1.668215] spi_nor_get_map_in_use:2880 smpt[7]=3D00007ff1  =20
[    1.673520] spi_nor_get_map_in_use:2880 smpt[8]=3D00037ff4  =20
[    1.678825] spi_nor_get_map_in_use:2880 smpt[9]=3D03fbfff4  =20
[    1.684128] spi_nor_get_map_in_use:2880 smpt[10]=3Dff0203fe  =20
[    1.689519] spi_nor_get_map_in_use:2880 smpt[11]=3D03fbfff4  =20
[    1.694911] spi_nor_get_map_in_use:2880 smpt[12]=3D00037ff4  =20
[    1.700303] spi_nor_get_map_in_use:2880 smpt[13]=3D00007ff1  =20
[    1.705693] spi_nor_get_map_in_use:2880 smpt[14]=3Dff0005ff  =20
[    1.711081] spi_nor_get_map_in_use:2880 smpt[15]=3D03fffff4  =20
[    1.716470] spi_nor_get_map_in_use:2910 NO map_id          =20
[    1.721165] spi_nor_parse_smpt:3055                        =20
[    1.724645] m25p80 spi0.0: failed to parse SMPT (err =3D -22)

I have checked that all these information are matching with the fields spec=
ified in this flash data sheet [1], page 131-133.

Below is the full debug patch.

--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2863,22 +2863,28 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_=
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
+               if (!(smpt[i] & SMPT_DESC_TYPE_MAP))
+                       break;
+
                read_data_mask =3D SMPT_CMD_READ_DATA(smpt[i]);
                nor->addr_width =3D spi_nor_smpt_addr_width(nor, smpt[i]);
                nor->read_dummy =3D spi_nor_smpt_read_dummy(nor, smpt[i]);
@@ -2894,18 +2900,35 @@ static const u32 *spi_nor_get_map_in_use(struct spi=
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
+       for (nmaps =3D 0; nmaps< smpt_len; nmaps++) {
+               if(!(smpt[nmaps] & SMPT_DESC_TYPE_MAP))
+                       continue;
+
+               if(!map_id_is_valid) {
+                       if (nmaps) {
+                               ret =3D NULL;
+                               break;
+                       }
+
+                       ret =3D smpt+nmaps;
+               } else if (map_id =3D=3D SMPT_MAP_ID(smpt[nmaps])) {
+                       ret =3D smpt+nmaps;
+                       break;
+               }
+
                /* increment the table index to the next map */
-               i +=3D SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
+               nmaps +=3D SMPT_MAP_REGION_COUNT(smpt[nmaps]) + 1;
        }

-       ret =3D smpt + i;
        /* fall through */
 out:
        nor->addr_width =3D addr_width;
@@ -3027,8 +3050,9 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
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
@@ -3139,6 +3167,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
                switch (SFDP_PARAM_HEADER_ID(param_header)) {
                case SFDP_SECTOR_MAP_ID:
                        err =3D spi_nor_parse_smpt(nor, param_header);
+                       if (err) {
+                               dev_warn(dev,
+                               "failed to parse SMPT (err =3D %d)\n",
+                               err);
+                               /*
+                                * SMPT parsing is optional, let's not drop
+                                * all information we extracted so far just
+                                * because it failed.
+                                */
+                               err =3D 0;
+                       }
                        break;

                default:
[1] http://www.cypress.com/documentation/datasheets/s25fs512s-512-mbit-18-v=
-serial-peripheral-interface-multi-io-non-volatile

--
Regards
Yogesh Gaur
[...]
