Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B19C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0DD2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gk3rmcDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0DD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJLJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:53:20 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:27149
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbeJLJxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgM0NeK4m42vbC7iep2nKW8Cfpz9iz9kL72HJoMhb68=;
 b=gk3rmcDeIRWo8GTzbbyI2KDaNOHDswoX+9CZuCfMYkpvv/Vo404bgQkcib8B0AxoBY76mAblv1yYkDR3n3jnm2AANh51X/9Bc811auFl0qmLvuYxlwqEHc6+xgMqG2OVj2zSmj0h0ZR3ZRm7RmrmEH8hKlKcfdc/mASZ1zETy5o=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1166.eurprd04.prod.outlook.com (10.162.121.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 02:23:13 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Fri, 12 Oct 2018
 02:23:13 +0000
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
Subject: [PATCH v3 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Topic: [PATCH v3 2/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Index: AQHUYdKGKD+kbaBkdUSmApnPC/zheg==
Date:   Fri, 12 Oct 2018 02:23:13 +0000
Message-ID: <1539310881-17438-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1166;6:Pt0voHeET52gRzk+z6uHJxL5Vf0fdY8SEnUQe+vyRpO50QXuRnFiOAqgg3vyB+MwohVMCmg7/79d2uhMYiD/MUTEKVu1gW4kiPtB4pBDXUoe/akWwus854p7aKf+vcJy+8tB8GyDJ3QEVVNZ/A8YP56NuTeYgiJt9ms6/TP1ebwFHpVJu4vLTUmKuay3ZCRbbQHJsqxZXk7SAUNzpIJp5uexkqH8bSawGKUPopqIba8+CtpTqsdQqJcqymjpoHJ/5JbWr6Kxb30aQAqVv0A+++FUfqWnCUCktUcJgjMzmH4xKDdy5eB5mWYVvtS86iGCdtnR3LbtDOW4deSAmBpG80QGwhsvjcFcj3gZyIc9B8f9lCh+TKjgu65yW14rakOTwCkgHeGXr7kHnOFCGQLKFgSsv+j+eIHAJqqN7IF8wqevUd2AYpiLfHJ9M2pCqsjQFGTVPcfx2Y7eME6WQvQc1Q==;5:tx7rR6KU7WDYwNcfWLfZSiRETpu4PtaHjel89w9DNQioMe8t1UFgfj4Wx7KpZBfq/TndMrV2XRo3O0PljawyaIpBXc6a/wMrApey/Jq+/cvw/HJF9/b9kx8X6+bsBewL+wSPrM47eqKYWlJu2GhBNZ+rcmmwzGHQngb3SxHn0iY=;7:nyAC2wFgA6fo05Z1SS4FnkGTsqzM0V3fC9khVSHa8Ck097WRUC0376d71tUWhwRWx7qkEOf9ZS7axXtPNIAzGV73wBMcYYr5Jiav3t1mT+AKomIeCegOl5+PIrtok+W25+tvXufH82PLRtzYsRf45quRLPqJsT424i1p9+1euPWqvLOx0y5jcigxr1S8w7XR3PXrSTrYKYdrPUIayaB8YblbgBK6OTl8Y+Z4Qy+j36fEXGD22nst22O9opnfcUKc
x-ms-office365-filtering-correlation-id: f071b39b-fc30-4e3e-62af-08d62fe9a8cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1166;
x-ms-traffictypediagnostic: VI1PR04MB1166:
x-microsoft-antispam-prvs: <VI1PR04MB116688AD93BF28C314C24EB799E20@VI1PR04MB1166.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1166;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1166;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(446003)(386003)(6506007)(486006)(55236004)(4326008)(53936002)(52116002)(11346002)(476003)(6436002)(25786009)(110136005)(54906003)(102836004)(99286004)(2616005)(6512007)(316002)(76176011)(66066001)(3846002)(2906002)(6116002)(97736004)(5660300001)(86362001)(2201001)(2900100001)(5250100002)(2501003)(39060400002)(68736007)(305945005)(26005)(14454004)(36756003)(6486002)(81166006)(81156014)(256004)(8676002)(14444005)(8936002)(478600001)(71200400001)(7416002)(186003)(7736002)(106356001)(105586002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1166;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ngIr0p/+YOB4CB8NORhusQpj4ZVeMX5WA7XaP5UWVvFu+kFJjxxdMZs0iHZRWSJk/B29fnkLu/akOIHUov6LBgcABQhpqlxihGBoo8XKl/yGGnkbACqyL+4Vzk+i1F5VzKSMGwxLa6weFIA4Po0OdHUZNlXd0hFDj8lXa8OrrTDuycH0TPhG91aQLxNZjiZHhOOZmQuFGNakrkwKZ27x/0JxB/Z5GQMUN3HVRB4p12V8rgZoLotXVE808ZXR8PrNOvn5Kg8UA67LMbhYXfwf43Hi0XTTYv4DYMT1z887uflYCD7QSeB6d4q4+sFPM1X2xzhrqQKogY+b6BW3HsxKy9ZfyhqhyxKx60uNqa+3HHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f071b39b-fc30-4e3e-62af-08d62fe9a8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 02:23:13.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for mt35xu512aba Micron NOR flash.
This flash is having uniform sector erase size of 128KB, have
support of FSR(flag status register), flash size is 64MB and
supports 4-byte commands.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
Changes for v3:
- Modified flash node style as suggested by Tudor.
Changes for v2:
- Removed checkpatch warning, 80 character limit.
 drivers/mtd/spi-nor/spi-nor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b8b494f..0b8a6e0 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1405,6 +1405,12 @@ static int spi_nor_is_locked(struct mtd_info *mtd, l=
off_t ofs, uint64_t len)
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | S=
PI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | S=
PI_NOR_QUAD_READ | NO_CHIP_ERASE) },
=20
+	/* Micron */
+	{
+		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
+			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
+	},
+
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
 	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4, SECT_4K_PMC) },
--=20
1.9.1

