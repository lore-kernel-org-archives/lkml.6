Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B0C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDA120849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bzxf04Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDA120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbeLMNRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:17:52 -0500
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:44700
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbeLMNRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts5BHLDgsoKZD35AmGmHfa1HB1QZfSf++3fOX6LK2JU=;
 b=Bzxf04Fp3q2zfnjXvwLacU/KN7gLl+CGA2hzG/5CW5ICKLr6c9EvkSbYgMAcfgfbMeW85+hhjbkrlyAyR7wNmET+xHP2Q+T63m2vNfis/lvxniZBSUlVOqQGHCpGY5MnV2L6gvO4CkBtZS1aFzmaGtQCseYzjqJxK2r3WGap51E=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 13:17:43 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 13:17:43 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/3] clk: imx: Build imx8mq clocks on arm64 only
Thread-Topic: [PATCH 2/3] clk: imx: Build imx8mq clocks on arm64 only
Thread-Index: AQHUkuY7ymlIARVFUESzY4xLGsSAPQ==
Date:   Thu, 13 Dec 2018 13:17:43 +0000
Message-ID: <1544707047-4417-3-git-send-email-abel.vesa@nxp.com>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0103.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::44) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3692;6:m+yeFiFHdeXehGcgQ5K6y37Ae9hgusBrF3cNgxVbJxTglZiKFLnvlKspaG0yKGXeCTaS/8FM5rDoXaqEd2wRNTj2J1yCQtOQ0D9dXI8OGLPEhRkmzW5FusDKMe5d2ET7SZIazKWpaiwHRPs4OuRMb5fu25QDFKESbiN+seFudGEmu5mr2OegyUfN58WZrt5GLuq3vCM8u8Y4yMdmrAOlRsaI2qjDvm8oNB5OFYL0otjvFwvHzi8avfvPVjP3lzGJlDKNyulvh46MU6k46pQ7FVZcsZ7Stmu1zpgoXMGuGHjXw2lSFdtW3Ew7H232mDmHhy2i8LwH9v7Gxh2UCt/IZe8xCdGkniRu1G4zohI08MCCQoqXgm4T29AUAX95UgleMaslRMY2V/S8tpnASmSZqJU5LGFTjnP93E9JOjgtAJUg3Y4yU4oBt+tJR/TjSBXWv29GCep+4DRMr+omfG3K9Q==;5:hqlV3S5BYQXlg2maxEOcwzI0reHpceOdsb9xOfrAgxBbRkDgP49pHb74MM8Z1aOF5waDxBIlO/lV5UEWaMGwFj1brZBxGnWh9dzktXfCOdvwqxzIq8U4XRfeLbgp6wSHq0Foblgu/hbXKTEo98qvMp7uTrm7UZmKDLvKNQh14S8=;7:fFhFKmeOpTfeNHNEc1ICTKyAwwCVDKVDswl9pNKRt/jKqjeEFuQKqGSeI+N1iJCsF1HNyuRDiRNL3arv5fPhypQilDDnkmp9XvG66o1MNRSQF23ZY8NJgVP5HDqNOHcyjUwBJ/HfO8fNwmYvIoXqmQ==
x-ms-office365-filtering-correlation-id: 550b5d49-8e86-47cd-d834-08d660fd5d7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3692;
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB3692B50FA80D82197AB861FFF6A00@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3692;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3692;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(81166006)(36756003)(8936002)(486006)(186003)(25786009)(305945005)(2616005)(11346002)(446003)(76176011)(476003)(26005)(2906002)(68736007)(8676002)(81156014)(6486002)(14454004)(386003)(7416002)(478600001)(6436002)(6636002)(5660300001)(6506007)(256004)(6512007)(86362001)(66066001)(106356001)(105586002)(7736002)(54906003)(110136005)(102836004)(316002)(71190400001)(71200400001)(44832011)(52116002)(3846002)(6116002)(53936002)(97736004)(99286004)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0kfGOrLHi9p+2YNXRqktJ4MYji1Eq0dcSTfikFRvkmqvwRYtC8LTeL1plPE8b73fEPeKPdo3C2yqvcw0SNWe7YrXFP2mO2+6Oi28juwZeK3ZITWcc0mBIjFH6gkAhep8TIfZfENdo9biNsqwrrAy0icPDmgFCo+STmjU9uLIIK7NWSPBqv7VqTQu7ZP6QALYf1xpfPoSRnlZO8Jyr/f4/0E9BKCiTN2O96nn9wuURnHkXFPTnrNmHnuIJWcBSwq/HOeR/hU8yzikHrKETh6UeAL0sW6bz8neZ8cQjC0os1pdMQBLLtvVbqDzwerYgOTi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550b5d49-8e86-47cd-d834-08d660fd5d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 13:17:43.3991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The composite-8m, frac and sccg clocks are not used by any arm32 IMX SoC,
therefore build them only on arm64. CONFIG_ARCH_MXC is arm64 only,
use that.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 62a1882..cc95744 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,13 +3,11 @@
 obj-y +=3D \
 	clk.o \
 	clk-busy.o \
-	clk-composite-8m.o \
 	clk-cpu.o \
 	clk-composite-7ulp.o \
 	clk-divider-gate.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
-	clk-frac-pll.o \
 	clk-gate-exclusive.o \
 	clk-gate2.o \
 	clk-pfd.o \
@@ -17,8 +15,7 @@ obj-y +=3D \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
-	clk-pllv4.o \
-	clk-sccg-pll.o
+	clk-pllv4.o
=20
 obj-$(CONFIG_SOC_IMX1)   +=3D clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  +=3D clk-imx21.o
@@ -36,4 +33,7 @@ obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
 obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
 obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
=20
-obj-$(CONFIG_ARCH_MXC) +=3D clk-imx8mq.o
+obj-$(CONFIG_ARCH_MXC) +=3D clk-imx8mq.o \
+	clk-composite-8m.o \
+	clk-frac-pll.o \
+	clk-sccg-pll.o
--=20
2.7.4

