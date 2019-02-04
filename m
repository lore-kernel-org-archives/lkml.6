Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8502087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rzdKneSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfBDKJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:09:31 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:59630 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfBDKJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:09:28 -0500
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="26111683"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Feb 2019 03:09:27 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 4 Feb 2019 03:09:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR7fQ5aqYpuxmi7PdNrJSi0RGaLoIH/OxMiPCd6Rdqw=;
 b=rzdKneSnow7fLhUI3ny8j+/xtifrkmSnLRjP+wV28GwzsgVivtDMbgSJ3qaBEQ4kg97CgQIsfnIXwCGbOrZ1FS2B3S8k0DF1bH1dpNqT9MZJPupsffMVfbaYJ6ZA77Q4Vk3XZpMgBQN7xwgm+RXJ55+T6h8Gf5ofKH10IleQ4dc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1473.namprd11.prod.outlook.com (10.172.21.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Mon, 4 Feb 2019 10:09:26 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 10:09:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v4 02/13] spi: atmel-quadspi: order header files inclusion
 alphabetically
Thread-Topic: [PATCH v4 02/13] spi: atmel-quadspi: order header files
 inclusion alphabetically
Thread-Index: AQHUvHG16z+TW/c7n0q4+zU3WNe8eg==
Date:   Mon, 4 Feb 2019 10:09:25 +0000
Message-ID: <20190204100910.26701-3-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190204100910.26701-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0270.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::43) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1473;6:E0ywOX2vkTLBA/reHzXd6UCMW7xKlodCernp/v5XlJH7bQTGF5wK7nTRhzD4LEYp2qtHzD2BEaa8yGpInQ/tSX3yLWKW3BdPzyDU4ZSFtR15mB6d6Cqxf1wFAkWzc+W8mVRpRQezcyb5yKKWYoDe1oiBxMzSEgqJLDlOXu6bI/UJFdQCP804PDTzOy5ZaS8B3OUPTyaiEtl+AWe8wsEHCvsMpg7c/yuWXYbUHdQjSAwwg0hoCz55UYKDCrrvVXBKMj/Hr7tHsU/An8tHUn25/KuTGR4Cgw6v+RextrPS0GHd7gXUIMZ7EtsyVGapOg+BY6B7AUdcloHsE151dFW8suhcyky53dfjK6ouChCJ0CZuMNIE6WfEaFtzwST6iyHcDNcLJNOeo4mXYMc1k5OdpQiWPagCPqhrzCUOhC/tZNj9E80kH06YmKb1SOJes+VBQEwqQrmG9ODvsZqA2XECnQ==;5:WLaH6f4LnRd4eLi7KzzHWnajyJhi9xkhXoghG1EQ0h/M3uifpJjs2QsVoKls6bqfsdjYuZRivcGHf07k6JVqygfrrhwdRPlscNjy/NjyjdYLEd0CoJnonzniIjpPr7nkQ7lqU7aP7tWR2DnPoNQt1/d8Up2wOVQtNoHq+HpsQA7sS86oPOmgLe8Jd5J11DMWJ3zKxyDdp25CtmflK9d/Vw==;7:6UmSVqD9vvEwmbx/VFBue/OQg4pyYr2r0C6071jh8ydEam1AXwzQ+jrVINt1+4AJFawFQsWV6nJW+HGrNTGQrGkuKrea6Ayj6FZyikW1iqkjI4hOV4KkebElcKMZk3uh8IDVKXuGPcqDpnb5t8lGFw==
x-ms-office365-filtering-correlation-id: 30212ffe-04b2-4f5c-cbf2-08d68a88d775
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1473;
x-ms-traffictypediagnostic: BN6PR11MB1473:
x-microsoft-antispam-prvs: <BN6PR11MB1473CC1EA3F36BEA8DCE298CF06D0@BN6PR11MB1473.namprd11.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(52116002)(8676002)(478600001)(2906002)(26005)(2501003)(186003)(50226002)(53936002)(4326008)(81156014)(316002)(66066001)(8936002)(3846002)(81166006)(6116002)(1076003)(386003)(6506007)(106356001)(68736007)(6436002)(6512007)(39060400002)(76176011)(102836004)(107886003)(71200400001)(54906003)(71190400001)(105586002)(476003)(99286004)(36756003)(7736002)(6486002)(97736004)(446003)(11346002)(14454004)(2616005)(86362001)(305945005)(7416002)(256004)(72206003)(486006)(110136005)(4744005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1473;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Or0c5X+j3YNJHlVvvXPW4CWehZoxaeNIJPHDRtDojGiO3kih0kSseemQ/C74NY1j79kKVo06MDfYKEkpRLn08l12cc/vMtydDpsDOVVLGCt+NbpHwR+jMOWUm4Yuz2DyxsjX9aQNxsMVwTlIfa5C1N03m58Zx4EcTxuRjoJVxA9rKfHzhK/WCvfB+i6gmXCKqZZNynKLI4eCSmTZu9amLLTXpfRo9B4dw0oZmCuhC4AXkuKgRiigWn+DB6UdSz6qN0cfwoxNU2+OY9yG1NDU8IOVwrJ84S4VCtDMdrfRc21hOPm4ZATjfK3BbkzI105ej1gCQ0MjIHRfEJXSsdgc8k5CwzIC1ywty/sMECPPHHGGNvHoxkFFpqSMLHgws5biAA+kZuND7ksYsLRyjf6bs+2ULj0Jd1u1sr90Y8OdL8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30212ffe-04b2-4f5c-cbf2-08d68a88d775
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 10:09:23.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1473
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
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index d6864d29f294..7d83ce8747e8 100644
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

