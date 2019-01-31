Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DEAC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1D3218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NJFMH0Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbfAaQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:15:48 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62809 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388275AbfAaQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:15:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="26148213"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 09:15:43 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnm0Ix2qZTFlK+yyhthyBJnay1ftPjIohP/CngqClso=;
 b=NJFMH0SjO/qHbBZO+y6bnMQ7Lo488QB0tSo1AjWUubHpQaD95hcwEvDzdzEM3Je8cnToYYmtam+oPHDCLi3jAQyBSA9WGOgYbLRaMqz1CnJJ8iNAJc4xnWmFCReg1kIZ1GhqCVszU/r/2URRGjZ0zUkAsDTwLW1YgVKpraX9OWk=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB0004.namprd11.prod.outlook.com (10.161.155.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 16:15:39 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 05/10] spi: atmel-quadspi: remove unnecessary cast
Thread-Topic: [PATCH v2 05/10] spi: atmel-quadspi: remove unnecessary cast
Thread-Index: AQHUuYA0NCso3fwOiUe6LPiLrInzfw==
Date:   Thu, 31 Jan 2019 16:15:38 +0000
Message-ID: <20190131161515.21605-6-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190131161515.21605-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0046.eurprd02.prod.outlook.com
 (2603:10a6:802:14::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB0004;6:+TSqhdPclHMHE1OjChv3q1YI7fG+zR/8gdk2nOAJ6GcuxJ2pZUZbeJyvRR9Je57TTBOyLNJwsBSwpY7DWJgUmlwOdcb8+m646OIKhGWS+rUZmCl8Qo8kqrhIjSJvxqK0D7xhbpbYcltMNbeEs3bYdlARUYlL8noBuJ0BiunOTBDoawDbx8ZebTcO+W1t3olR0Aag9Eq95V9vbeONAQht5tEkBTPvvZ/bdgH/Qffu48xDt9jVhvPDmnBAQh3V708zyQAGnV1oxF2FSSASZn7uX5EcmSgsXIsW2mFyYziIxM4MPf5doQZX1g8k3IauqvytQtMmJ80J88n6R5MIkmOn+fDoEdn/q/vbd9Ecuich8zEqGOoQyvoGkwykhlY1ffehafVao10xI18FpP135HNdk13RBvNx5V1ZYpBPZQ56P70N+R0Q4PQQOpUFsUQxMCcgCD6cYWrorek5VFO819pdHQ==;5:YAwo25diRUN0TCyfhxqzZpCUVspCBDQuMdZ9N5qSzy3nSgFn7NTQ85YhojHbtXAax0ssGwlaISmJsMnf+welhasaGhZ0cOmKfhE89dq7rGxG9z2OKQtbMA69nEuSLb5YE2gN6XnPV8QR8QNYd2p1P8FVs5WHCHNh/28fCeTdkoMhI4M31AYNcGexUU9Qnfy3LQaN0rQSjp5RYnKUWRuQww==;7:XICLIMRP4bJNkY+rp8Q1Z0v1BAwL1ZoAO+4uHIZ+flI4Icqqz0VJZRD8qjbhbyhqqJvF8xw1zdZ3n64k74MFn0lltat5aemzMKuj/cG5p4ahwWbV6qv8lTgSxvM/Mpamo50edlV9roemNwjYi6khMA==
x-ms-office365-filtering-correlation-id: 2715e26f-5819-44fc-9db9-08d6879756c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB0004;
x-ms-traffictypediagnostic: BN6PR11MB0004:
x-microsoft-antispam-prvs: <BN6PR11MB0004BCD96288D94963F954BEF0910@BN6PR11MB0004.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(14454004)(186003)(86362001)(36756003)(1076003)(4744005)(76176011)(68736007)(81166006)(256004)(7416002)(8936002)(72206003)(14444005)(52116002)(6486002)(386003)(6506007)(305945005)(11346002)(2906002)(2616005)(102836004)(50226002)(6436002)(66066001)(71190400001)(486006)(316002)(6512007)(4326008)(446003)(107886003)(71200400001)(476003)(97736004)(26005)(6116002)(3846002)(105586002)(478600001)(25786009)(53936002)(54906003)(99286004)(7736002)(2501003)(106356001)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0004;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +BipufEDubzaNeILkGBKQlfeDUG83ybVRyqnZbBTLWLGKpUNw9zRgJT9IZpZB2itAPQ4kNfDFHyWRLuKqXjk1/W9IDXHn9bjf3CLazSPjvqAvIXK4QBezgsVNhu/9qWkp4F+QCFlrl7FflSQNtbQXsRzwONKysrcUeKKmZlT78FJBea5msf1L3vnF8TU6LQIkXdeWoet7VqNEGVUHRXTLZ/TYZkEb9CeUjZ68OcRo0kHLurE6upNJZRuPZ75lJsokEMSRHIz4el5jaF5zM1Nqwbl3WuYRYw6HHz6VdKB//ovmyV5AU3BYAUG3YpJ+jdhZ/2GFR3Zu4N46+lmm7y2PnMiOMW1nFkSPOy2uXsuiqsGvgu19WHfhIQfxqRvj0yazM6gTYnLXHLIE6tBmoO0yLz3iNgm/cFgFS/dg8amJJo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2715e26f-5819-44fc-9db9-08d6879756c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:36.2114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0004
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
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 4105ded68f44..2db935488270 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -383,7 +383,7 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
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

