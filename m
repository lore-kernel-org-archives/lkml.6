Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5579C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D12A2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PCTuqgZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D12A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJKPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:41:59 -0400
Received: from mail-db5eur01on0077.outbound.protection.outlook.com ([104.47.2.77]:22493
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeJKPl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORW5dttqvxEtE7UbsULv0fhvwbYBR/4+gYj48A10zeA=;
 b=PCTuqgZ92NrpYUbdfZUQYEqKMVAdCtG6RG56axKTUeNX8nwYd6edz9MGeAREorjF+tv1kb57ra0jlXYWXfqJG8Tyz4TIAWa8GTuPDPCoCg955zaWqmeg3BxMutt2fXwxtZ36JhJZAfSBi9clIcwG7W4///xy5NKk53T2nCgfnoc=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1294.eurprd04.prod.outlook.com (10.162.121.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Thu, 11 Oct 2018 08:15:45 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 08:15:45 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Topic: [PATCH v2 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Index: AQHUYTqbs6sSLLIYmE2VBnAqytu3EQ==
Date:   Thu, 11 Oct 2018 08:15:45 +0000
Message-ID: <1539245630-26611-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539245630-26611-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539245630-26611-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0088.apcprd06.prod.outlook.com
 (2603:1096:3:14::14) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1294;6:bSeWnt3t7fKb+CJuFEqJc2ICz81DZI1VFYWnirFXKhorHMn0AzzJ4NTPGW7WP+5IH5qNkAEL0rCT0AfBLGqIVEMORo0h36TxG7NXOihXNC+zt4OjqVWONVmQJLzz+TnFfY4EwSfNF9wg6UXypCRXN7C6jZ2Vq+3c6dE+m4UfBPmekfw5q2j4ZSKJzKzPU2yvgVGn9gBMZc9waw2pNiFAYI8eSzKQFjOE+Ehj6zEvC00TvSwAYbfUot94TuQqNFjuGAC3ehlrDOzWlRE295z5zIGrzzhglm6UA/j5+EYU1ZMB5g21Kllj5J0HQ5vYXe4ycEMbiFoIF2bhU2s+YTSxwsvnrd35fO9gVvjt/eItG9Ij/HhvSYrEdtNt+MYFqXTLMPsDNv0konoCfmJv8ZG+ytJpLvdYPOxeGmC5tzo7pW6JCTWjhiyLxBMYbiMW4uaZ83UBRe4OsV7+zXmrg2bc7w==;5:/sWa8uU22S5AAJJwb4/0ILqJLSBV+L9M91arb4gqa0NeeNOOb9rf7nQYKypcYGWmECHZ07m2r1lKujwUxTolI3tttYvy+HxsHHM+IrWJGUkCCvDuSr6/+vjJX0aN9Uq/rRWJFW33yS3ieJfGaSj+1+ctd5nAohkWfjghkc4VQp0=;7:EiRGkMWIl5TgdPpdln/u38vx0LlyyvFaYd3A6l3xRJrvtVw8bc7UQvnz11fNgC8aDm3aC7+/JIy8WzqvcATxDXSbzw6P8VKF+bNkSdgwbal/BdkuMqsAC5BlvFs4JdLs0W9Sgg8+TAnZ7gibkNMu7zQe6rhaB3tLxeYQWftcVCt1sm6c3UpP5L+Uv7qpc0Lr3UYtsXKc/MtBjGgKfhB+aWLlN8vbYQX4eFygauhSvgEES9bYzGUJOi1xpQLT7fA2
x-ms-office365-filtering-correlation-id: ffb787c9-9826-4ffa-884e-08d62f51be09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1294;
x-ms-traffictypediagnostic: VI1PR04MB1294:
x-microsoft-antispam-prvs: <VI1PR04MB129405D76BC6B18A3A4C234F99E10@VI1PR04MB1294.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB1294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1294;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(6116002)(7736002)(36756003)(305945005)(7416002)(97736004)(3846002)(316002)(6486002)(4326008)(39060400002)(106356001)(25786009)(66066001)(14454004)(2501003)(5250100002)(2900100001)(110136005)(76176011)(105586002)(256004)(478600001)(6512007)(186003)(14444005)(6346003)(102836004)(54906003)(5660300001)(26005)(52116002)(55236004)(11346002)(8936002)(99286004)(6506007)(575784001)(81166006)(81156014)(2616005)(446003)(71190400001)(68736007)(2201001)(86362001)(6436002)(2906002)(53936002)(8676002)(386003)(71200400001)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1294;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-microsoft-antispam-message-info: JSqM0hnrw08Wslz0xDs4LGzxNb2J7qcsRjUIyI11gM1eSdfy/hTjJK0dyYkKlx67/3jFxAHEhCv2IFytomK/fH1bZnnreKnQsl9maLgE0R2+8msVVyYZSq1eCzROH87Oz7IjBMIaEWvCgsxpYBo1Ho7aA583xW7EaElvjCcXztMNM6MLEqdDkc4/ulkValNtZKnEuNE/3ds4+eBTO/gCWFVheqelM7DEAj6+DEBTGBCx5Q8hZTJNbX8i/DCi63yyveHHRoGBkyHwnT8U0e+q4zo5JfizjoQpGoLkl9zW4iq0HCU0hNiE9wVA0j56+Zgd1+A1ASudAC7wAO2o5agjw9IRp1gG9ff3THPosxSlFQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb787c9-9826-4ffa-884e-08d62f51be09
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 08:15:45.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for mt35xu512aba Micron NOR flash.
This flash is having uniform sector erase size of 128KB, have
support of FSR(flag status register), flash size is 64MB and
supports 4-byte commands.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
- Removed checkpatch warning, 80 character limit.

 drivers/mtd/spi-nor/spi-nor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b8b494f..e0d95ac 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1405,6 +1405,10 @@ static const struct flash_info spi_nor_ids[] =3D {
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | S=
PI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | S=
PI_NOR_QUAD_READ | NO_CHIP_ERASE) },
=20
+	/* Micron */
+	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
+		SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES) },
+
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
 	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4, SECT_4K_PMC) },
--=20
2.7.4

