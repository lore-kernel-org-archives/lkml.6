Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA4AC282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F4A21721
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="s+7j1lWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfBBEHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:32 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:42703 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfBBEH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:27 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="24146369"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 Feb 2019 21:07:27 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elFA1QcfrZEA30XZgpuZss4fkHSkW428lF/kU4mXt5k=;
 b=s+7j1lWdDfA5tftMOQEVRdKfLlgsesIWsR5r6hmy/0dIpZdgPaFQ+GBm6xQ4ma6oua8Aqnd28W+pX+dJiHDjT0rPyfwJRuWGKZ+xY/bKKbFwDlnT8ED7Vg4KEwhzGLFW6P66eJDpsFr9fTuEeZnEJlmZ4Qs1nKaFnboY8mk2/Ls=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1300.namprd11.prod.outlook.com (10.173.26.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:25 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 05/13] spi: atmel-quadspi: remove unnecessary cast
Thread-Topic: [PATCH v3 05/13] spi: atmel-quadspi: remove unnecessary cast
Thread-Index: AQHUuqzNPvd1FHWArUOezVdRhueNxQ==
Date:   Sat, 2 Feb 2019 04:07:25 +0000
Message-ID: <20190202040653.1217-6-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1300;6:IQ+RPlTChpG1otdsYPJYM1hL3ZnfBWrnKAb4MImo5Cln50e9FeORkENSVeKXlO60GAY34krSEg+JTRuGaP2nFeEcUcSvraikEsnA9hSKl17DrFImNJbpWKm/py0Yei0pdPQfDTevNXZlH3ZEQ7y6WOrSQtACvkMnQZDD1eme0qa304NFSUmaCfdOUl+xQASijy2ipgne0E8MLJ7o2d+vzs5tTiccS05l9IbWgUT3M4j1BTC5qV0oxa/Qc9xTbdQq1PJh/RqUGDOtANRx8hNRl2/YjHVrlr0Eh7ItbhgZUPtayjN8jTAY8BqawHsyf1ob5D3TvWB7zno1h9H4TZMzcNKgMM9jWN2sANBQgAtoiLDysemZ8bqPF5uD1ddCAXqCfSVV7d8LfebIIDBTLZgPCSkmL1inJxgg0yYJ+a/vR4aNV1oiaudjKt5D/aITD6E8wqCx5d0QO+FaeQlNO275yw==;5:bapbVdrcCWYtUCFATkhaLPm5xSvRP1FIOXkB58izFSv82OXS9MLuJz0t3WfKg5Po/4pGPpQBzIQODfgX7EUGdwb0A79PuCW95nHS33SCSrG9EiqMey8JqevWti5KMXe9c1iVY6t1ZnLpYikMzt73ipM2hDnatGI1VdeOiG0R2VaapgxbKOHIPM7ndqAl2E57XMPEeBYT0Ak3RjYOt1wrVA==;7:hn0C/pd/joVsImnx8/JsC4M08QrZVowopk3YV+rAMS5XTUgFK8H2KFDrPJEpQR0G4ZfwceSZwZeADcAZPY/bX8SoSEa/d+jl7BHJ/y0u4sX7Ndrv1ckaaRUo0NGB/mMgAaXhF+NeRpNNz7n+XuoLmw==
x-ms-office365-filtering-correlation-id: e393039e-741c-4d09-c359-08d688c3f00c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1300;
x-ms-traffictypediagnostic: BN6PR11MB1300:
x-microsoft-antispam-prvs: <BN6PR11MB1300AAFD58CCBCF50A811453F0930@BN6PR11MB1300.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(14454004)(52116002)(50226002)(105586002)(6436002)(102836004)(72206003)(81156014)(81166006)(2906002)(26005)(7736002)(478600001)(3846002)(6116002)(53936002)(256004)(14444005)(106356001)(8936002)(68736007)(36756003)(97736004)(76176011)(107886003)(4326008)(39060400002)(2616005)(99286004)(476003)(446003)(86362001)(66066001)(71200400001)(11346002)(7416002)(71190400001)(6486002)(4744005)(6512007)(316002)(110136005)(1076003)(305945005)(186003)(8676002)(2501003)(25786009)(486006)(54906003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1300;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5WQ0HTODt+8GoaCfxOhZgd80JndGXzIB8B5o+p1p3UOzGltc/wCBDpr9NyciG2Ez7+Zv79xpKFY2rHsNSJsaKErenUNmtpBXR2e1qIrA0LA0FAGHvZJKjtnbx+6E55DIbhfmM/l7y9g0BYswHDo0vz0ROBpTOE/u1Kb92nri2KyfYXMtWARJfxVrbKMBjw93A35MzTKnb1hKUpbamVz/jTL/CSfoD2BTh7zf6GnHlzH7vHQ+Q0qgjH+Hbxc/UPt+yzz9BtOyn5EIDBHYUOl7SxcjuCduMq+6QaL9gDQgiVdIN4XaT4vYiS5irdkuls7v9zwKJzMeSiyMoLYXYI/FmXCqC8g6FruyBNRnfW3vcFQe9zF1IfLkOB4cmo9GF40T4405NTGAAflM1t2pU1P05AvGVKnfc6nxNKrz3nQG604=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e393039e-741c-4d09-c359-08d688c3f00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:22.3773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1300
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The cast is done implicitly.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 47ed751a91e7..dbc2c65abc86 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -385,7 +385,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
=20
 static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 {
-	struct atmel_qspi *aq =3D (struct atmel_qspi *)dev_id;
+	struct atmel_qspi *aq =3D dev_id;
 	void __iomem *base =3D aq->regs;
 	u32 status, mask, pending;
=20
--=20
2.9.5

