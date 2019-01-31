Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7623CC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B372085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hXPj5B1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfAaQPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:15:36 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:55702 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbfAaQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:15:34 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="25990724"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 09:15:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:15:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXT5CAqJqrsddP0v+H9j3bI2zNh1ct0eXs+9RFMdhK4=;
 b=hXPj5B1u0wH78iYsyQyBHlTq+tTiGWxE9cjPMkYZdj0fEqTF/BF4tErrQ7m2ngkZTd0ZEp8wEjA3DymQo31CltIAclIObk+RXNIfIvhmsbGZZpv6sFp35mGVI9wNGc9FNLO/Z1rkiUcEfQ4p53ZARmvZNyPzxM8ngeWT7gQtXOs=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1874.namprd11.prod.outlook.com (10.175.101.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 16:15:31 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 16:15:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 02/10] spi: atmel-quadspi: order header files inclusion
 alphabetically
Thread-Topic: [PATCH v2 02/10] spi: atmel-quadspi: order header files
 inclusion alphabetically
Thread-Index: AQHUuYAw8ZDPknGqbUSbsvPqrU2nUg==
Date:   Thu, 31 Jan 2019 16:15:31 +0000
Message-ID: <20190131161515.21605-3-tudor.ambarus@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1874;6:XkBaC8fBFY/HU46E2m2kgbMzINQiEFUCIwI1CeTKKLa1TCmiybyC2TojPANp0jtVWoadbdLFqHAscwcvo+bImMNBztSoXFtBtDmssXcVSwEvmatDzPzn+gJzEptlrGDa2aBqLD7Pf5Xks/6/REPsUKilxmOOqnnmlSRPS5xt52Nv38ESXnr+BfTYqXkzY8JSwWNzTh/PLw19fFSWngzX7qPS574x70NJDG+31hTbfwM7/g2JeUhxNwF8U2aeL9HzpCi1x435Jo0+2cI/OmhVkCGn3sPZtLsTOiBbdpeWpayVEbyvzRQVgncWMtzP70DFm0vV6f7qWH4pbqTBKC4W4l1a7p88QtXmtKotBeBdA1Q6RlHRuqaASfLqg02y+5DmxdDIRr2rMdJTx4PjyxqV2T7/7wjI5KNpF0+oJH5Jsa1X3W7qFxMrv2rmijZL8wl72dcpkwg+n8pmjyqJn3v5DQ==;5:YYw3XCQPiaOn2aOoRGfjAWmhnBKc2l2GWGqdCVBJPrTO5fIzk+5tFyAJYKtsZ6siXVdpzQ6f4YPfjZqk5js+hqYn394l7KNCzNRYQ6efVYiI0kO7xeetC72EsFn6QMvHb9CeEu1srzEPUins/obwtsEdKRPs3D++UinYCzAIFviA4mBWJDkB414BJQu4i1gstlDSai3D6zb+HSIzLeiHWw==;7:JSB1iQReViLklKhtTg+2QejBps+n8rcXn/co74rRnlXbI1oTfgsJiDdXAuOdu9JGqivzdObdC/v2SqUmQyFaqaeLpwiFY+mnuvR3gVJjnWBjcnrL7vA7qG2hr46MHry6E3EigCwbAUkBiefTBrMrTQ==
x-ms-office365-filtering-correlation-id: 317180e5-4011-4735-5dd2-08d68797525e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1874;
x-ms-traffictypediagnostic: BN6PR11MB1874:
x-microsoft-antispam-prvs: <BN6PR11MB1874FC83A9DF6E8E96548586F0910@BN6PR11MB1874.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(186003)(107886003)(26005)(4326008)(68736007)(97736004)(72206003)(478600001)(256004)(106356001)(105586002)(36756003)(99286004)(54906003)(50226002)(8936002)(7416002)(6116002)(3846002)(7736002)(8676002)(4744005)(81156014)(81166006)(71200400001)(71190400001)(76176011)(52116002)(2906002)(1076003)(305945005)(2501003)(14454004)(102836004)(6436002)(66066001)(11346002)(446003)(25786009)(476003)(486006)(2616005)(110136005)(316002)(86362001)(53936002)(6486002)(6506007)(386003)(6512007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1874;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kp7AXn88HvCprD0m7QJiiiISghbNStqIT716qwkFI2IBax4+CklazfpSFBwzK2Dx4TZL3EBXAH7diDavV5fHhIb6wQygT/DR/zqIX+OUY68R3nEfKN+n1O3k7xwe3el4iowBtvnBOlmU7POheALBc6IKtc4Gy4x7YbfOtDDMIZav1yX2o/i7491CWU64GOc3HvG861a9gN6sL00PmfG5WilN2RKLoP/KM2nSrlLPPMRqmvYALtyRhVfu/bba+noQeY/68qzmq4U2pwRVQclEzhn9jODKVnxt/I0ExdJiwAd1d8o/M7pdOUexsJoNTAdZEY7C5jGCg/J9PsgI+WNJ2PQB0q561xCCEg4pc1CL3ycoSomhubxzO4T3gBEoeC0nfFQ785y7Hh9KuHqOEMFPncRe/vqTsZJZ18v2ZMnOan4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 317180e5-4011-4735-5dd2-08d68797525e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:15:29.1544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Cosmetic change, no functional change.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index fe05aee5d845..c986daa895a1 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -22,16 +22,15 @@
  * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescal=
e.
  */
=20
-#include <linux/kernel.h>
 #include <linux/clk.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
-#include <linux/of.h>
-
 #include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/spi/spi-mem.h>
=20
 /* QSPI register offsets */
--=20
2.9.5

