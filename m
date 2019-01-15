Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2215C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE5820651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fV5cxcoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfAOKFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:05:42 -0500
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:38816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfAOKFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXGCWNDxM8RawqSl8SpvNauvyjgeoRTco8+iqiQVGsQ=;
 b=fV5cxcoLOkcR3KvbTiv8xrVVfITeguBHdt0BWMwhn1ccGX1Jl5AZ2H5KtGEQt+vMpECHRz75BlKMvzbxOSlkzyEl1vKtoD6wUsG6FpyZt9+bSgd84Pz9mBhIn8dalLxfXjpglUzIf42/Wsm8x7p5jRC6X2/R4uaN+QzltdXwevM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1SPR01MB10.eurprd04.prod.outlook.com (10.170.239.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:16 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:16 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v7 2/5] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUrLnQgJgrUdZwrUut3L5z4nyOUQ==
Date:   Tue, 15 Jan 2019 10:05:16 +0000
Message-ID: <1547546584-5254-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR01MB10;6:HKIo2rKDCzsGWT8/5toYFJCzaGL8IHeGb70tWJnKibq/TwyKxVK9HylsoCQlt5a/HbLHgGg2SvBEUOXWNvRprOODZLXumXKMDCBLtUbq4XY+zh2ziXkG7IAUYOrG/nxpjBJL1bzuoQag3ONAaBp5DSHVgQUllsYIz/YEUsL/oMgrw2gC7IgKCyXW2uDleEn19VloPxMj3vxlxUJuhhtl/nbLA3hNBZQdKLWau4Vp2M2oTY0JGJXdQDAFE4G3xXiOCuDZ02ds6Hw3S4XlGiSzruMZmkndc61vCoNlQyJAtYh8n+aHUwT/FRAz/tSSmAt5sb1u/Iotr08DAvRWRDcvlm9G6hvFdyE5ahmWmYeOQEt8L5JWH3u0tmmXC7EfnU8QlPzFmDK9Rx8K74h0am0xFptb1wadJq0QOz+wSqric6lX+yd9vep+YWnIQlNpPpWb0doiEy2lScAk1ofd6iGszg==;5:rJypuP3J7Y6O7Cr0yfT3i+K0wQ3NWhtKGuIHI3Zwzx4Ss3oR3OLnxeMnATpge8RIQz7G4uRVRds3YuWXBiZ1ifnuVaTrTMOaHeC3qtm60Sd6I62LnvRPTHgXOBHOrtRPrVvVSN+S6gee/7fEJYtfLRu3AwjV3Ac/1MxuYLIOeeFXiK9YA1Dxi+7wvk+R/589jjX9a+cYUDuuJTcnBUhg+w==;7:7eZ+5Vf3aPpAUDxIRwgFd9vrrJXok91K4rmxwFH+gJ4XP7RVSepl4B+0VRogJ5zw03tIBTPDpfEtgSmJ3VHBbOTcQThwza49EQe5iLFYNcXHUwknz/izLbXM2KLEeyAe5cu2302kpLCrYnBw53bXKg==
x-ms-office365-filtering-correlation-id: 970eebdf-4930-4835-63d2-08d67ad0f2ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1SPR01MB10;
x-ms-traffictypediagnostic: VI1SPR01MB10:
x-microsoft-antispam-prvs: <VI1SPR01MB105EB7E5480FDC245F611499810@VI1SPR01MB10.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(6486002)(97736004)(2501003)(6506007)(386003)(316002)(53936002)(55236004)(102836004)(5660300001)(106356001)(4744005)(105586002)(68736007)(52116002)(36756003)(76176011)(86362001)(11346002)(71200400001)(3846002)(71190400001)(2906002)(446003)(6512007)(256004)(486006)(14454004)(2616005)(476003)(7416002)(78486014)(99286004)(25786009)(8676002)(6346003)(81166006)(81156014)(186003)(4326008)(2201001)(14444005)(6436002)(8936002)(26005)(478600001)(66066001)(54906003)(305945005)(39060400002)(6116002)(110136005)(50226002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB10;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8enKZ8NK0Iebp5efXrx/8WyQ4gFG9QY2CU/Vd0x2JRZD53YqD5iyFMkBoQxK0MU78tLD315InKUBuibTUd7IKbC4W//waEOQVxUo3ENLdoXizcjfwvTclUoopD+LsESABct9U0aUFsPJthZzChJRIz7NKHphKGVmDGa8k5a3m0qpuhsov4WQ4p9esBRW2Zo7/AMSl6Wu5UHXqquUWtUqD7C5Pie0jmEp1XAgWMmSPNanaownSNxX6v+a0/6lhZDdmDDxd4/u4y5Ca3XvBDCJLmwol+nQ7Nv1AK7LGFYRuqwOFctsB5cqXBh2hLczwgUL1G9IgeQFv+/RYrsqTHSho0D2x/LaSWLCTbWv9zRImvkI+4kOyU7av+qGaLrk+Imw8K7esofXQuOCXOTnvDTBHGdKD+lcxFb76n7r38epZxQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970eebdf-4930-4835-63d2-08d67ad0f2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:05:10.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB10
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
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 872d70722672..53a3bcc6a55b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1877,7 +1877,8 @@ static const struct flash_info spi_nor_ids[] =3D {
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
2.17.1

