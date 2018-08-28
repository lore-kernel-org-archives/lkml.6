Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533B1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F264D2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="jFXGne4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F264D2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeH1NkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:40:09 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com ([40.107.7.90]:27616
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbeH1NkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgHTJEx4dGpTaNTF2ryiZd73XZtUspcdQ5ylQHnQno4=;
 b=jFXGne4zMEzS9CiOzH9i3/RSJSRUh2aNbvyTGxdrLjTwPnWTN/9JzdNEvsZYWVCinLlFc6WItUJPZrME5oIXsU0ZwpLNPo6g5JHQ4FMjclt6eFlpr8fNd+IkgeBFO9ZoPSjYulXmzHgSRUbF5QOtgwowHAEiHU/ULws6cy0VQKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 09:49:13 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: at91: nattis: set the PRLUD and HIPOW signals low
Date:   Tue, 28 Aug 2018 11:48:40 +0200
Message-Id: <20180828094844.10018-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180828094844.10018-1-peda@axentia.se>
References: <20180828094844.10018-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b55b3ff-d396-4df7-b031-08d60ccb8349
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:0wAgTWkeLquf4cd1HdnLXH3AYM/cYRrbvZseC05VlsbbPufIDoOILVlsa+BW/clRsMVQomlSMTJvM9pRZh6y0X4rQ1UghvfUgkeHa+ms4/ZB29N3XgO7zYb5QftsL2DkIxtUzpxzod63Wq0/rwmW1YiGVdK2t6xFXWpHJvTdiiEmsjXDrQGXoMmRcfeRc2Davak4P6+yqZKewRwe+C1lnmj3DsVHCA9IBScu1J0cf3ulRf8v8yVP8AYtCsYEH9r8;25:OIbGLqa34eXru+xVbffylFKSFRisKySGqrfv/+1hw7XQ9FlEaQpfKdRXogn1YYGNP/g4Ghu6wB5LJIDVrbQjykPcFjrrVU81SM4SFu1QySl9AI7IXi64K202NcZcmAVjD27nAPl+5eRISIej9HfjzrV5Pz6M+aLGQ5Eg8kN2jg0NRJW+CtEp2vZBCa/VGZGPguM7JvfUHN8UXCNmMxf6TCNQhr0sa18oT+Su+qaXHTk1Mf75y1N+SFT2cUiHgadroUTbYS+eX6nQ/5To3ZA0IrIOeJ7gRTz6UQjRGqRZnHlorshd3NfnMO3Hh5m+Fgf4cSqjmIkYg5bI2KeDUrunAw==;31:0H6hfYqlcq3dKikD7ZsS22fjYXBodtj3mhIbzz4PgvfDBdOg2frs7cpXo6Lo6tQdORIykVBKiwIwPaF0n9DdE0xrURwfAqXdmml0rfuiCDzLtwhxNWebK6AEMzHUAQUyvL1liU6LigvgJrUNSvY97xzx6NzomYnNx3UA8EWn2fz+HVTz7G6TvkjXFpFIfcypm6CuWZeC7MZNR8mFqCwS8XJANhOEKbwDtsRkHWSRITc=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB24492FBA549487B1E0ED93CFBC0A0@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:e/Wx5MzCd51RlYvdzXIjq/qLR+d7aezfjK/1Np3TvEOpwvTq6yobp79a/FS9UzfZpeo3OaGOt+M0oxsa5ou+f9aqlrdnuDAv/Em8fo6H0PJtEHVS6zSmPTGcItumj7kDBQyNiIRVapzcXDY+F5SNvuDGrEmarXjl3vGU627yzjfLsCFuxlpyaQ6lemGSuiGscB7v6fmJ1Og8jXerLBIsqbT1RxCFTOEc/VwqjmuvHtw4l3R42+T9vX6AFFI+seVtvZTZLxczQLyAd8onGHKXqw==
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39830400003)(199004)(189003)(74482002)(16586007)(54906003)(26005)(4326008)(2351001)(6506007)(478600001)(316002)(386003)(16526019)(186003)(2361001)(36756003)(2616005)(476003)(50226002)(11346002)(956004)(446003)(6116002)(97736004)(8936002)(3846002)(1076002)(52116002)(25786009)(86362001)(51416003)(76176011)(6916009)(5660300001)(6666003)(486006)(50466002)(48376002)(81166006)(53936002)(6486002)(6512007)(105586002)(81156014)(66066001)(106356001)(305945005)(8676002)(7736002)(47776003)(68736007)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2449;23:SEzs+ZRoWhYZo65hZRvV1mY/58Izg02ILlcJuoy?=
 =?us-ascii?Q?G7E05ZJbtjrFkw+kEPG+M0s36eatFOjSAOIc7Mj8S049Nl/w9U5gxX+30T9X?=
 =?us-ascii?Q?UHUphfp7YAUWHOQYnnGpdfL5f63jn4EVN9qlfBsSDpZ6C98GNeHfiqAOkaX6?=
 =?us-ascii?Q?d2YGIzf2FD+dK0VX5TTaVB3yaFSD60EufKsFI5hOv2GexrhB1xqu28Tprhz3?=
 =?us-ascii?Q?hkFH+tpGr2+v6rWTJqQ31//RQCDKK+bm3CMy4vMqGrQsx+iJBlyF6iWhYu8i?=
 =?us-ascii?Q?SIvsE6xZOiOt7C5X4Me34y9qqxgdRklmDpIDhhQqXe++xAzaf2A3lFOtmsze?=
 =?us-ascii?Q?7yDuC4nAkGXIKYtprSgFuwCHj/H/qpxBHxxpFEkyLbLlPKdoKqq8ZwGrypvp?=
 =?us-ascii?Q?pMUaKxqdBYefz1K6d3DJ9Zf2AypR36y7iGwhb8gMkfv2f4fJMhZoGrIPC33p?=
 =?us-ascii?Q?xqFOdrRMrKMd2FnFWhGQ5dCizwcqfS9lqBMFlYONtFfAuyurpvZ3imYoSxUG?=
 =?us-ascii?Q?u5UcNpZORtF5Jg2I9ME7GHFTL3JjmaByACG21eSFGV+RzcEkEJr/T7k6aJoP?=
 =?us-ascii?Q?EzjSKZJFfKDroqY6Es37RRqKnQ6TADNHBOk7e2aAcWj4jiZ2ArXaGb1tw2em?=
 =?us-ascii?Q?G9CS+EIsbbRode+MYEa4RJijz26Oh4RMsvslAAkcmuJzDu3ow/HZAk6ITQLI?=
 =?us-ascii?Q?Ayu+30pICCpIfl3dIdLi4prbtFPT0qZozHaRc2jCE4y9UxbXRaS7Z0JcBQw1?=
 =?us-ascii?Q?pZBS5SMXUZa2AWb7ihHhleYB+k87F568TUFXj/EKhgxOL4s5ydhSpT3/k6G6?=
 =?us-ascii?Q?uGEXN+YXo94Wum8K8k7eyU9oxGv1BQ42Iv+BIkxNnV05ge8Hp/5axx3SGgsd?=
 =?us-ascii?Q?Vi2sY2BCZTH7GHrSEPvWTcUjAY0zOUXUE0xDCnCeAFurgngEwn1gCRixQOcq?=
 =?us-ascii?Q?d5rCjAdEuNbw1Gyq1gK9qNY7wwajjCG2sgDVu1Vz7gnBQrf9wgFH+Rxjslva?=
 =?us-ascii?Q?CeUreFX79DMd7ficGYfFLYRoelkw06fkAtWBquKlkWWB/lmfQ0h/gW7YLRKE?=
 =?us-ascii?Q?BgollBx8nuSXEYD2dCNd26CMwIbcPC2B2l6pMa8s0bH/i76/oGyMPj4E/l6B?=
 =?us-ascii?Q?yuhUHFjE/FXOGQ+xhP7mW1z7+wYtUnqCSowFlDU+fCVFdwNI5GkwcR7PxF9f?=
 =?us-ascii?Q?pUSaApLRa7lvu9xzMtz+ci7YxgLriKqdWdOMzVyv36RH9vrw7DWQxVBWcLmM?=
 =?us-ascii?Q?eNkBJfc2SvDLVB6wCW2W95+nAIWWhp+aMwcyFmMTxFyBN4wPrhBmYlFSs9n+?=
 =?us-ascii?Q?C1Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: Sp23QxRDrbMgr7fFGo/0CM9SeEoZNj8bznl2W+5x+GcbpOh/W972YKdtpWMBTHyhJbZH7wxNXUDB8gczm1LF0joJng2euO6rd2Bcon/GO24+eEjccR78QUsjXhPlHDAFCLT0JMMrFqv8ZCSQXKv7uD5Cd4sndkLRU2ra8FCCOXoXnrssk4RoSpMpsLujfeEXh6EpAcPyt+FjJzxK82OFzUh/qzIYEGFI7lmOZzMal9vIY4ak66oxBSctYGCQVOZSaN9kspjK4U+IDGihYEtA7rTJBsbQqYRggrao1C8bxvLkUCk+CJ1oZYr5wNo2TgZqWOuerCL5yiPo8tn0LbllqW20Ar/uzicxIo1IlGBRedg=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:Ty1LhtHVB7cVGtj7D6hFeLS135D0FhVTpLBxv3A0LgirFXrwBKGmmgnoLqRHRp0vJyH64gJhshVUT7goVtlRfXtRESUGramnd6RJ03YazrJcBDmSDS+Vf50Z9tFa4sS1cEgoxaMoTYV86pIJhr5KA2JpYgPSu6LToAvmVvxN+F8aXzCkg0hjT9O4BnBNTYl1i2gWT8ug43VeCfvlqlmxyGakp1SzPwaLIHGImVNnGprHbEE4qFwXbB5I0M0cAhZSifPgMpZBkO3q9qNYxQRwtXu8Rz3U79Rl+UycXnykcyZ7sWFNPHZsk2Gfr3ZfjGw3/PlNXVvVNji6SiVGyVLr0KEXFCQghojWxGIfQ/HlUUghJr+/PA8bKjGkd5pZv1Umha/3nRbVxKA8VlbRxuLcBV4USQWKdceQ7cQI0535YXHeTQMkM84L1Q7c4OHLsy7RcSdSWfY8THeINDpEUgTWxg==;5:qcrL+jhGgO2akTrmfuEGx5I8fLA3OAfknm/crejpS8vIvDWezPj15bAaru2/PSbqELFChuOCRqd94dDm1PTIve/sWY/AlDL6idAr4ZJBYgk8FOBamhRpqiMYxjJ0Wzob8WYqYnwACsQEkEGCVbyQQCqhgKMfxLo5Iqu+3rZ+nVY=;7:+MmwAFA0DUCgebRm881tb7HxWZ7XqeGPijkRRLu1BnZ9Apn9H4UggKT8pZ3mXDlM/35YgL5Fkr8Zjcruy8t5IB+WeXJRRY3C4GVy+R8CN30ZeU2czwTnXUATTS+WJ1Oe21CaJGs69slj9ZWvj5koAc8dcfUzWrLXWgzlWANsdRYs35YFJdVJ9OOUKvDJIJz1dpGADdgUaUErrr24Vguj8RdH3aJs3eORxKgGzqY9DxHYpS5l0O2qAohtGZEx/Hug
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:49:13.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b55b3ff-d396-4df7-b031-08d60ccb8349
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AT91_PINCTRL_OUTPUT_VAL(0) without AT91_PINCTRL_OUTPUT is a no-op, so
make sure the pins really output a zero.

Fixes: 0e4323899973 ("ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index af9f38456d04..bfa5815a0721 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -38,14 +38,16 @@
 						atmel,pins =
 							<AT91_PIOA 21
 							 AT91_PERIPH_GPIO
-							 AT91_PINCTRL_OUTPUT_VAL(0)>;
+							 (AT91_PINCTRL_OUTPUT |
+							  AT91_PINCTRL_OUTPUT_VAL(0))>;
 					};
 
 					pinctrl_lcd_hipow0: lcd_hipow0 {
 						atmel,pins =
 							<AT91_PIOA 23
 							 AT91_PERIPH_GPIO
-							 AT91_PINCTRL_OUTPUT_VAL(0)>;
+							 (AT91_PINCTRL_OUTPUT |
+							  AT91_PINCTRL_OUTPUT_VAL(0))>;
 					};
 				};
 			};
-- 
2.11.0

