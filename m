Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5D3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B2321473
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gb/GQkcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B2321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeLCIjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:39:40 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:28530
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbeLCIjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba50Ajsom308Fg+wGmvSmyjyiBF/sabuHpSIY8OQ4rk=;
 b=Gb/GQkcpTf+8xIoxW4IUCWmYfPInjIzcqbv6XKU/2vmjbExnOFrD5Krg1msq/jkQ7WlTEi3PETWNu4RAaznIywtYbdN7V54DQj4n85zCC1/unCwZ/qlmFIvIOt4nc9NPmAyqLyswVJM0KN0If2ZA/Dk1Btx6yRW72k+zNbQLlhM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4718.eurprd04.prod.outlook.com (20.177.48.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 08:39:29 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:29 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v5 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v5 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUiuOxFPwCvKBFZESsU4tLrDaSzQ==
Date:   Mon, 3 Dec 2018 08:39:24 +0000
Message-ID: <1543826226-30898-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0143.apcprd04.prod.outlook.com
 (2603:1096:3:16::27) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4718;6:VnZjg6QPTpyxHX2ok7qXWy9il1KqKdYYK0kPEv3vsyuc9BkgZQwon/jwGmTNZcI+VtMoJKsOkaLbivLDUC5UHKOtpAcewBjBWSfzj+GTnJae8olwZuk9fc3ajAPHxRmgXGcrOoaTmaXO+A0C2CpLe3BwIRsSwtb02j1jcOb4YiEm/uZz3hekpSOwcCM/qRWxLrP7byVpFEh8O4ZhogotZJow7CGMqnUF0C6g7rzXNKolZhEHjKPdxB8nOMu3RsoGkT5tjRnBerqN0i5e81KEpE9ACr8VPRwEnxTNls8s9DCvSZRmazA+fTyPTULSJFjQvZMGU/AHW1hX2TtC+NHNkupVcI1vUDjG4WsCh8GHOj21TngeqMR7yyNt5tcsP70eOoQvb95X3g+uCk62Spz+h0nkT8JF+xw7Ezc18lYhtbsG7gogSze1Qh2HXrEs6jDWvjLX85jPm0XGqNnjaqTpOw==;5:pCmNL92N4r1kx3jbekIYmixOgEdTFUSeVHnx0nlsodxQbIaLbiYnTMx/wWhfGw3XFlUJhPnf1ToyEmbBV+nNQKWXTYhQ0mzlP75GwXmd+rnAVdwN6lyCJdLF+F3fC6uCoZKIH0//KLCoagdjArGfSH/SxVWprk/61ZGCkdEfU4E=;7:m2ld70cdQK15U5SovBy0FWdgq0a9VCjN9cxKVQZzt7HPgg+OvHeIOuZ/C/r9bTh4tBUk3xi2K6ckPPLa3vL4DkNEkE1kRoQNVApR2Ig+tvdG0CJP3fsMknsKyarWLe0t8eCVKCZk42Z0F2mzfOIMwQ==
x-ms-office365-filtering-correlation-id: 16318705-d4e6-4aa4-d5a3-08d658fad403
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4718;
x-ms-traffictypediagnostic: VI1PR04MB4718:
x-microsoft-antispam-prvs: <VI1PR04MB4718CBF5FAB6AEC9A5BA04C699AE0@VI1PR04MB4718.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4718;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4718;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(199004)(189003)(7736002)(99286004)(6486002)(76176011)(305945005)(6512007)(6506007)(53936002)(66066001)(386003)(105586002)(106356001)(68736007)(256004)(71190400001)(71200400001)(5660300001)(110136005)(55236004)(14444005)(54906003)(7416002)(14454004)(86362001)(478600001)(6116002)(3846002)(25786009)(186003)(6666004)(2201001)(2501003)(97736004)(2906002)(81156014)(81166006)(6436002)(8676002)(4326008)(486006)(78486014)(36756003)(102836004)(52116002)(26005)(39060400002)(2616005)(8936002)(446003)(11346002)(316002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4718;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8NdIX4mKYmczFGmNl67NTebkLGS302lH4ymOy7ho1bj9kd+f+8yYpeV8aqoaKA7dBjXlEuSqweqHwWiViO3EGbo//S/X13SFpJXw2V0hIRB3kSiXlrAYZA6ChEhrxLgYvpZr1tu+9Vef6dnal/QPqaBX0rEzJZHoqpWp4/wqzxLLaEiieKPfSxhhoFM+sT4NcLHLLTYiWARc9x1GEZd0Ij/mJ1t47Lz/r78ilAS/bN0zsNxHUFPtkqvBUnrz1PGEA3OXOSTHuTbK1PmkKAUNs94hxB3KCjqw3uidPNqKBoSYFj+wAurhOIr2IGFE/oEsWh/2TfJRdWquQcgdwD39FqVb9KXuj2LcVqgbT1InT3k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16318705-d4e6-4aa4-d5a3-08d658fad403
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:25.0379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octal read flag for flash mt35xu512aba.
This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
not seem to support newer JESD216C standard that provides auto
detection of Octal mode capabilities and opcodes. Therefore, this
capability is manually added using new SPI_NOR_OCTAL_READ flag.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7a2176d..41ba90b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1413,7 +1413,8 @@ static const struct flash_info spi_nor_ids[] =3D {
 	/* Micron */
 	{
 		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			SPI_NOR_4B_OPCODES)
 	},
=20
 	/* PMC */
--=20
2.7.4

