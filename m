Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8B1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B7721871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R9MSpGZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeLSKMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:12:01 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:8736
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbeLSKL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTlB/vmPssGHHRhaGN5/85LGX8HSWOGQoAgtr8Bc47g=;
 b=R9MSpGZFfUl0K+YiO/LA2RP3BW31FyMB/p3rhO70Z9Qv9BqGQFzeNN1HFl147bVAxCSVjMXF11LQO1cHINaBq4M9r2h0eKcxTzY01CrHwJy3pH6BFPJ5LNCtcPpOSOyslRWHQcVeX/PP+B58IbvjTogfdzI1kU94WBZVITfEOvY=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6096.eurprd04.prod.outlook.com (20.179.25.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 10:11:55 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:11:55 +0000
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
Subject: [PATCH v6 2/7] spi: spi-mem: add support for octal mode I/O data
 transfer
Thread-Topic: [PATCH v6 2/7] spi: spi-mem: add support for octal mode I/O data
 transfer
Thread-Index: AQHUl4NFOIKJ2LzzYEqWmI5FGNUKVg==
Date:   Wed, 19 Dec 2018 10:11:55 +0000
Message-ID: <1545214186-16987-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6096;6:7BegfY2pqOCfwI3b8GHFd+1+04LX7WBZQK/i8g5mQLEWY386MkJHxzKestbqjAU7mXMr6Z4h7wEXlpzCXfXMB8KyRL5vX5cf9HQJtOa9nQ54NRaljTfC9ZaB0NizuRHtp+moD9WE9gpn0qMeclXHynpa+qbfMQctCmcnJSnzz/aJ76K6Gdl2gASMDue+zk41lCjecow9D45+uOc4yuqa7O8DeVMg/dZUJaC1qtSQdjrFhV0dAlW14dy+JzRbK0TIefJzZrXpTZczniGfqOR2vLQp83Eweh/VZSrog3/PAuqHhGeW+PZ8uZJtBaQKYMGbrU1NFzrKVqHN1QVvC0zbXEA7xVfEobhYu2Td+nkdkfA4pA6kikppivHMRVHb0VNAxINwJ8fzB0SxriZDpHv8AvZH4J+uNjN6BlRKTGesJiBo5sSRaQ1kAYYUMK8qntDW8hSGlTT+2kCGaK0fGHI39A==;5:ZDa+2Co5/8kDqSWEcyNhai5jXdhmeu/VmgK7cy3DfvXoAOI6p75kJIkLIMZa4/PUObjo7Xd2ZZdBCjZxTOPqCrFLXPR5httKH2i2g+03DdAqVC6giFCC6qeurKKEJagMwqExWX56GiCErIqOP9AF0WZ11ausTHcTFOaTDQHCZdg=;7:g7Qm7mj1FP5fyzAHFvigSbFXWquS67SUIDl76lblKMkdunQlwZLuZ4GIqrxVKphAupfwBuxLE2I33Hfcfrq8mXrqttyG8G71G8k2D4shCBGCMdM3uspUgqki8jl0OFx0QxTqga9ATxa9hDB6u3P0rg==
x-ms-office365-filtering-correlation-id: 9f0ed944-b077-462a-04a0-08d6659a675d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6096;
x-ms-traffictypediagnostic: VI1PR04MB6096:
x-microsoft-antispam-prvs: <VI1PR04MB60962C8F45E07C7B54CCF84E99BE0@VI1PR04MB6096.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6096;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6096;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(52116002)(316002)(6116002)(2906002)(76176011)(5660300001)(14444005)(256004)(5024004)(53936002)(305945005)(68736007)(81166006)(6512007)(3846002)(66066001)(7416002)(446003)(2616005)(8676002)(81156014)(11346002)(99286004)(97736004)(476003)(486006)(478600001)(14454004)(8936002)(78486014)(25786009)(36756003)(2501003)(6436002)(2201001)(39060400002)(4326008)(54906003)(6486002)(106356001)(86362001)(105586002)(102836004)(26005)(71190400001)(110136005)(6506007)(7736002)(186003)(386003)(71200400001)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6096;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oRnmGxy+VbcdVVae0g8k9rUDTlVuLZcpnM/e0eNJXZfD95C9xws0dYS1izwheDD6ZD8DYLpa/x7bPEaF5cSJ7VrCFwOT9AuCFp4wJYP7HyLNNwB3isJVziSfe+QwrSLcEzXH/d3l5sqH2XtGIK7Bq17NgE7i4fdazM9iQIja0wSp/gNRgklbl4NtAFVzcGWIu9pCK0JnG8emRptxOF7jFhWLnRalH58F7ZS8JZ6x2mVu48VD50T2kAiOGLSCil9K1NbpbKt08jwf1p7ELdRoSxmb3GOH4t7t0fGnGEqZoAWYv8ne92FiW3JgWmuPPlfJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0ed944-b077-462a-04a0-08d6659a675d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:11:55.6928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode I/O data transfer in spi-mem framework.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Patch added in v2 version.

 drivers/spi/spi-mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 62a7b80..5e15d62 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -12,7 +12,7 @@
=20
 #include "internals.h"
=20
-#define SPI_MEM_MAX_BUSWIDTH		4
+#define SPI_MEM_MAX_BUSWIDTH		8
=20
 /**
  * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
@@ -121,6 +121,13 @@ static int spi_check_buswidth_req(struct spi_mem *mem,=
 u8 buswidth, bool tx)
=20
 		break;
=20
+	case 8:
+		if ((tx && (mode & SPI_TX_OCTAL)) ||
+		    (!tx && (mode & SPI_RX_OCTAL)))
+			return 0;
+
+		break;
+
 	default:
 		break;
 	}
--=20
2.7.4

