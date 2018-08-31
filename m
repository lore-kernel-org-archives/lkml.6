Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9040CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C0E204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="RiycdMzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C0E204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeIAAxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:53:41 -0400
Received: from mail-he1eur01on0111.outbound.protection.outlook.com ([104.47.0.111]:18768
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbeIAAxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtcoSk9x2gY2CL4AOX18JPWEaWah3zMXwhyIdZLyviI=;
 b=RiycdMzb4szSkOiT8C6XRsOKh+tFWyLxtrWnFUJqTC/b4lz1WQ7rsN6HtPJuJjjIeG4qW/KUF/I/Cibhsuh5Hp+gMKI1kXaYz8vxp+5I0PXlp/1mG9WIJ2Wrm7gAxvRN3ydQypdabzKXE/bOJTIeLn3UbVnn5jt/J0pE2huRz7o=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 20:44:25 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: at91: tse850: drop three indentation levels
Date:   Fri, 31 Aug 2018 22:44:03 +0200
Message-Id: <20180831204403.14653-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180831204403.14653-1-peda@axentia.se>
References: <20180831204403.14653-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::31) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fc66bde-8e59-4e20-3bf1-08d60f828a80
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:nhUZ0LDWTsaTA/L89VDoy+PN3b82LN6RdVy5aKfove0jJsxLcJc7juSIWYTEtyj2vv0+TyCFK2Gg11UzZZlJyJPT1S3lpxX3vARBJ676cND2HSl133NRYjVKFroO5xmbQn+w5TMZIOy1mVRZFVjbhlqDW+T3TzNVmkJwzCmYelEN97LvEITwjzIBwGp7Kqk44cpFdYEM1f+/KjlXbRND/SdERZgH8hA0FvTvJ2TzSbBf/SYp25ThWblbKIB9QviQ;25:l3jG4hanlnb9+UXDdxXAZx8nETFig3aZnzVGwHU/M656CGdLWWVE35Vv39Qixa3EtkoChue0PMqMtvvuZrDp3IzDBOx04pgFMqP8Dkzl4cAfqzh2fb8dpRM4YO6i08ax9ryaUyAlY/8U+HmxjsvLsY6d33VLwmjdz914lWbr8g8kioDXANtG+UKASmpF0au4kxSCaNde5ntkgk52eVU1Qlj0Yrq0AgrhgOtE8UGd/IrOpD5qsaFjDFGZXVj8hiNZecj2oPsQhr4jHmyjw1xrQRfx+ljAqCEBv8q6IQSKHvyS8J3T90XLL5jTJntHDcjywY2/TZc338eatBpt7mdPDg==;31:BSLtkdJSPbfsr7v2oN3ushTodexN/Ax8yfoaY2rSKzj/ssbjHgM+0AiR14nZ2M0MIjK+qjRC8yeWWzyrCKUIuoa31LeKJldwpJqkkInhhrINNIyIvInz9NpLey9ERxnU/dcpo61kA7yUSOQ8WimsDplaTLtuRLWVr5UIXCQE8XFDV3Sy6HfyUDf4czALrXSLl/s8CrFY8qyOyETkeHYwxHe3NIgZhPL5pzyC0068O2Y=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452955C97929F56650AA48BBC0F0@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:UyRMxVDcFjTT3P0u465DGfIHvRAmWJa7ka1zyDMgohNfQRWmLca4Gef9HZf4plpBuewcaSWvsMqZPALUAB/NngTJybF8J/YvwNzgm9r4g7avnw660F40HeZ/JUDmmLJQEQhQz2h6EfThsUVmssAY6WhHxEtRM9DFvRj8gAyMLwk2TxkzsMGw5z5ZUaHLpKmgGwy3pXw4XfGIMOpKw+PvkfF2mrF2nQT7IV+sF9AvhAnzFLuqBO/bblgHXo5PXM86sO4HvdzQFVS2z+YTrUCM1w==
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(376002)(366004)(346002)(396003)(199004)(189003)(6346003)(7736002)(2361001)(305945005)(76176011)(48376002)(97736004)(6512007)(74482002)(51416003)(5660300001)(52116002)(53936002)(6666003)(8676002)(68736007)(16526019)(1076002)(8936002)(50226002)(86362001)(6506007)(6916009)(386003)(186003)(26005)(6116002)(3846002)(956004)(2616005)(446003)(476003)(4326008)(54906003)(11346002)(47776003)(25786009)(486006)(66066001)(16586007)(106356001)(105586002)(2351001)(50466002)(478600001)(2906002)(316002)(36756003)(6486002)(81156014)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:uVizNzVbAlp8Oyj63+Sop/QIRgfc77VuXXfxlv/?=
 =?us-ascii?Q?02gwcnF+6okNhErx2nYXne1Qu0HsIaXqdZWlh/+nqnGMlmW2X7OpOfy4UHkH?=
 =?us-ascii?Q?EwPDnToMB/HkAtGsgejpTS52xQlqxzWx4fOxmgXAG7EJ7v1S3vDAMZ5QjwuL?=
 =?us-ascii?Q?ORQ2yYbxIJe4FhR7ML/5PqOjogIIY5Dnrr0i6B9BGFCi1zjmYpfWEyL9kkLJ?=
 =?us-ascii?Q?dJyHlQUk7w6nX46Qfvb8cVGYB0btODX2/q4Z0TiJa4nHwDKL8lqoslNhLDxk?=
 =?us-ascii?Q?W0EbwGsgM5Oolz4NgwiYudtKzp0XrjJAFxBhKhC9+OFnI6QS5/2Xl1xtaCkd?=
 =?us-ascii?Q?Jadjt0jiVYHGmpr4/tNa4JqwQ+aFbo7DtJ80fKZdC/O/YW0KaLzlMfoS5eHW?=
 =?us-ascii?Q?T2Y0QeuABJBgCVW6qSChj68d4oIrsc0hcZQz7CrZ9YXFjyQbqzqRRYcv9rsL?=
 =?us-ascii?Q?oN0fc4MiUmVI5qv/nRJ1iz7E6gaJizgyYxq6fMEShds7MfONlwfXffSm8Hgo?=
 =?us-ascii?Q?rRwrDA8CT5lbF+nnBftZKYEVdm9Z1ObIWTtl7Zluc1+G26mC2OtQjTMyzzDt?=
 =?us-ascii?Q?P6HAyaxY/szxwT8ED0O8tgO50i27cwHM3iZ4qCFXzW6RJImxpcGeDcQx9NPH?=
 =?us-ascii?Q?0ntoddXLpYJz8rzlOt5UHl9aHQSRgo2oEdTshCTFHOY9UsFIkamRGd1OWgB2?=
 =?us-ascii?Q?BqmOwTh8V4t2Sf3PRd/Kg3+Mj1wQkCv0QiVeYtMWyLGpNKzfHaKpL1TyHsPy?=
 =?us-ascii?Q?MuvtyQzj3zp7YWpalUedXTIcu7cHD6/Ap9Yc6ubOVpMxOwMWw/0gCklzQ56X?=
 =?us-ascii?Q?nkeQDbuqNFJ+UxlxykTcP3g0DTRnvvpj9vioDXqTXc7JNN9Uvq50FdMRgVjt?=
 =?us-ascii?Q?dMWAHQGH3bVeZU0vMerbYASrJoj03QDKli4LgMOJL/ijQ74q3kRhWPExS49Y?=
 =?us-ascii?Q?WG7eanXYI0NoOSRkIFokKrYa0JozXNifRHgronM+0cIablk8WOgkOotoMUMD?=
 =?us-ascii?Q?DrrcXWnAksdE1EHHLpSJhdMzxXHzZHE4HvspwnlMAMJwGmt0vWDOKv8fn/38?=
 =?us-ascii?Q?RtQVI61nMfG0XInOI54+ftJF6s0wS+gRAornlkb+63E8Ux25i8+6/MF5jkd6?=
 =?us-ascii?Q?mZzgHHL2W6EUb4rm1UgUl21/xqB7QdXHXwQwL9QRUUpWLEEhmtcXLXfJh1I3?=
 =?us-ascii?Q?iV25qaVt3M51kFS61UDDptElOFnTLNfM1Oo9An/HaJToXhpN7/2hmEyrjrrv?=
 =?us-ascii?Q?0w1jWcYI8JXUlLpE64CTb+3cJdfEv6sZneQblDpbK+rEa5H4ocxJ3S/Pfn/U?=
 =?us-ascii?Q?vLK6tjpvxRc8R7qWOInmHyd0=3D?=
X-Microsoft-Antispam-Message-Info: 4SOv5AfFt1nmVHUwH96m0rpY7UO+gGxiTwodIgx+8m2KBSWF3Qh21CdpYco0Gogrf/PkEqvlJpELaXLcx4ThcghjlYJENjMHdPQmdCpsRYW9LO0f1vMhad1TW3NOLRBaoUvHJHb8D35LIhAo0ISFVzh1RQgbX0opYsAVe4yre4yNr6GUEKbif2m0CTj04dDtta3exNPqesElODEZpGfbBk3SesGhAotoYU797Qmia6NZWfQQRM2CLISMv9Ja1rNThjlKZIuVVHvp+PQ7juf8F4xce+CI3NcnC/JnOqqH/eIShCum3eYYiEeeLEmtyLXYc6lbvsKEE9Q8etHCBzrvP4cS0Ry7mgpvzHaN1SOKSvM=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:Uj7gNHNc1lZkAPhyhPQ63mXk0bC8R1CObdAFgqpX25hWmq9GKbAJ7jT9VR8rufexSDr0P5vqgRZgH13ZKGXI0xOFr2bqCGHw+V6dpY/A1rtouNGJW19LKUHZ/szantAdl5HjQSsbxigemieHJJJ6mYQXRASKLYa/bKcAz+4HScrHU2h3Qc7WHmsA2IGa4H53iKdyZet3Kyqdmuznlh3xZTWmaGyl73LIPE5W8AcD68v0EGJbxtJsUh4s7HDcMLXxmgmNNKV2zY2WNA7O4bf4E0EesneSsTTj8xNNR6ZYkssyNBA1ZCzsoa3+rp2PwFCUKZemIsA6iA/gH/FKzLytlWsDNmJ+vtEdU4X2iu3UR1TN86DhsM8O1Ifpm8xd6pCiHMji7QVW+LezOkLic4qjbDRO6R9oJDsh/D9Cuor3k6JtFoq0R15+47J1FzEG8uCOuQJ/Msqf1DerPk/Jud2wWQ==;5:vSwnLoBcY5e4VrT7n0ni9XpXLf4GNOICAnA4pn7wmAvuKumVYaI9BboYr+l3tSRJbe5u+xHOCM8g8+FAWxTsHj0ouo+A/YqpCKMAW7uE4+jl2lb5xYlbxDStNc/EBcg6vlPmjikjx6s0PkmchzCMPfkEusfqA19SDJ6sYwZcOoc=;7:1xs0bMjieorhtPqMNkAiG9FM4Z5jr2PQ09Q07lcsJYSBnokCWT0VT3d0GzDq4td1Wb2A8BNQ4tnoIN8CRTbh+lnXs7s1o591sCZ+5/Cb/9cPb1uyg1C3ZwCbg89vj2aqRFKUV71aB62sBDRK+wGroCa0xEQ6GlFpQqa3fVCshNX727ZThJVRt+iLjiDos2Zdp+C6otSC0DtVRLi3KSJkqYF0jD9vO+G1/rudJsRe9zxNsOyM9hxjt52E5Go4ga4H
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 20:44:25.8444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc66bde-8e59-4e20-3bf1-08d60f828a80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the recently added &pinctrl and &watchdog labels. This
makes the whole file consistent and knowledge of the ahb/apb structure
is hidden.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-tse850-3.dts | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index 2fbec69d9cd6..fe8876eaf917 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -16,25 +16,6 @@
 	compatible = "axentia,tse850v3", "axentia,linea",
 		     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
 
-	ahb {
-		apb {
-			pinctrl@fffff200 {
-				tse850 {
-					pinctrl_usba_vbus: usba-vbus {
-						atmel,pins =
-							<AT91_PIOC 31
-							 AT91_PERIPH_GPIO
-							 AT91_PINCTRL_DEGLITCH>;
-					};
-				};
-			};
-
-			watchdog@fffffe40 {
-				status = "okay";
-			};
-		};
-	};
-
 	sck: oscillator {
 		compatible = "fixed-clock";
 
@@ -253,6 +234,19 @@
 	};
 };
 
+&pinctrl {
+	tse850 {
+		pinctrl_usba_vbus: usba-vbus {
+			atmel,pins = <AT91_PIOC 31 AT91_PERIPH_GPIO
+				      AT91_PINCTRL_DEGLITCH>;
+		};
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
 &usart0 {
 	status = "okay";
 
-- 
2.11.0

