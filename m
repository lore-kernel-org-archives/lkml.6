Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7292073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 05:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J/mdaEmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7292073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeH3JZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 05:25:01 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:21760
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3JZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvW5USMBqsDNYzLEA8Dbpi9W7pO7PYXlkMhC9vn95Mk=;
 b=J/mdaEmQrzwi2FfpLHbaVJ+fS+FEFzN12FeqrQHX3hmiK3S/ozHasuWZNswbVnZgVCIj8WeKWzGRVmvY8EmXcE2u99s8hE6wltH2hUJLVpMhB5uSWM2qHq0arRPPJe8xIY85ObNT+08ZIs7KmKqSdAeaXDIUH9o+JUmlmkIiCBU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3909.eurprd04.prod.outlook.com (2603:10a6:209:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Thu, 30 Aug
 2018 05:24:30 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6ull: update iomux header
Date:   Thu, 30 Aug 2018 13:20:05 +0800
Message-Id: <1535606405-8099-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::14) To AM6PR0402MB3909.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28e50d10-919d-4344-fc96-08d60e38def6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;3:3HjgJozhNA1lVd3+u+sugHX1hrZ9XN0V812XOjEnOvskcvM6UA8p1ZdwyaWHE2s4vy9wdRf1KfBSENVRqoMSOTKckvfJeRLybTxD/i5HBeCztTnzx4Mypt+AyVUnkhUzjD77Y4nxQfI27+5OeuYgbjevE6bJfgiaCROZiRBFCWBew05t9pDdvZr9MfHILXxlhXgK7i53I1yOaJSg5LcN+UolCUaJKNceDcVJSuj6gL/nPJ94BM5AAF2J8Y4wYnPN;25:lPGAZ/pk7kxZW8MceYSRem99mIhaCAc6WJfa7/KfbCSYDYGmp1jKBhhi7d4yDhqnIvvIU9xRFK2XWYhcORQkPuW9lOOu0kK4HEAdCja1rjnoUAsX6QLuurUq3big/Tfmn17+Z+frGdL7TqTcLSM6FXZX8UvxWpAVp/xKT4ji+g/T9Ij0cmQKNx3UJLn1P/vpMogxShTk9afy5ES4xskG2h/kGrQqYkddMWgpFj49HwiQzZkeVrvErXDftNRmdWMUmLtVfJK8woCAZwZ5vayYO34UCLYj5EPB2DX8zEmNQOJvRnOX5tlnvJBvFdGa/lOFnahsLQi9Tf24U3R+PbG0rw==;31:TNVNMwO9XGspq+DTi1pgdf19pYrUDkoezr4eBrHarQuSoEDd8WkR1wzvX68/AoaxKEFukZc8zTA+yvUAAJ0g2gDkqqqBw1RLptn8u1wyvejVPCd4kFN477yMI0AKQvA/eQNh3oRxG1v9EnhjvpuTbA7C21pV2X/wXqHJ5Qtbwj2YQAgeRZAfB24ETdwf2UZ6u+lHm5x83nb7Ihs9cF+fDsWL7/ov1XbtlWDY8pA61/8=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;20:vU1STimVPrDHquMLqtm1vzTObW6sH2DYRprRa2JOpKdKDz3wiHCiPcCks4WluokKTplpthoew/C+Rs/NgwNrzVwZHL5av5oxDzswWFvdxKsyXGZmewdGhs89uAlJRQHMMgDG02XkN7xOfhJYc17Gzj1rTu4xL19akNFZnn8dCX/oGD4A44WKNg3OBmlKuPjg+W6ccfY3QDKcd4JiWGxcJO1dj95AEK+pzKaTEQZYSxmfdrANKQj3t38FAGj9RyJWmm6QDGI9+r6gXC4BJbsRgzhpuQ35OXUuEvmLbyNW+kiZIDPI40RL5uNmNUC4Ge+jBw/HdrCUlIND3qpa0Ku0enNUppkABvKSkwgMfJgv23CDCe8+xkX51tuxtcSHoxkxlR19EFMR7b7efYg5oJjBjQtCoNIhclTyHZNRCirgQKcaSK5iX6ELk1u0SpJhpIacoFR3FPKItfCqQgZ+prTystTI72kjBtxYva4BNlYAxJxH7tbRciRZ5GGwT42ws/1D;4:Ml4pZ9eYKcgWf2DhuqdE8m15LbWxIP21wo6UxJBcjLKTsdwKhLnB17baBoY4iqGMr56+L9yeOSijI9gOhg9VWuTt9Xiu/Y5SryFNyqONxeVKbSiL7NpV3gxo6N1RKw3xWDNbZBw2oQuNPskYpqcOQxpD2LObwPPnK4Fx+B1IJGkYzTKgwoUFw9DBu10e9XMy9S619oUHpNKQbN6mpb7t9oqu4IXLZU24Sicc6H7Kx4N1psGKOiW/NDlemcurXu01nyZtr7jPOwIYqLIYcxhFwiYVRbxjeerUnW6ZZZ05k13W0/YPE5YtqPSLKRDHq7qw
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3909F1655F30FE64B7946789F5080@AM6PR0402MB3909.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:AM6PR0402MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3909;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(97736004)(66066001)(50466002)(105586002)(36756003)(48376002)(86362001)(25786009)(106356001)(14444005)(305945005)(7736002)(6486002)(68736007)(47776003)(16586007)(5660300001)(476003)(50226002)(2616005)(486006)(6666003)(81166006)(81156014)(956004)(8676002)(53936002)(6506007)(8936002)(4326008)(15650500001)(386003)(52116002)(26005)(51416003)(16526019)(316002)(3846002)(6116002)(6512007)(186003)(2906002)(478600001)(1857600001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3909;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3909;23:8WAcsK/Ru9OSUHEbAxRSEv33jg+Mb1CN+FRQF9B?=
 =?us-ascii?Q?DouKLZPl5dgX8WgRr3lZZRFCFwVX/BZA80KrUKOmliS3r5u1w6yGUcPv7IBl?=
 =?us-ascii?Q?PHd5DVPWgQC/XVCuT3c1zbQi8+MuRqNWa1bCpfJm0zSojRuEtq4o4TsVmNig?=
 =?us-ascii?Q?lltCoT2F9oGT4MYi59d3e9bh63iNNma45cpp60gIH78/qyfBcAMMzp6Nl5A5?=
 =?us-ascii?Q?8qMhDbmePVZTcBaOGhAlBVzaCzBjPDTHOvW7w2w/U7sAnprpTK8v3ADdVt7+?=
 =?us-ascii?Q?NfRMMWE6nFQ2KVuW+44kQvgOW3LQEq1V8uSnSbKbko4aSaF+u6+1/DwfA6sq?=
 =?us-ascii?Q?FI7scF/YO46S9NXn0uRRWnbpFSHl7OPjBVgSKbUJusbIIhjLLK5X6pM12mfz?=
 =?us-ascii?Q?/tfVBSN7Y5VdqAuWY6g6q4WsP21JIfyezEBaQlq70SZ2E5xG/jvSmyCsNYJs?=
 =?us-ascii?Q?81j3Q7dB8tYgKJrSYcYN+vPr2+YJ5spS18ntDttBO119FRn5sd9cth1d1xsd?=
 =?us-ascii?Q?vSi7SLvI+o+5Ed2S9xuBFaP8Gsa3wLE1d4MDmmOTUQQFC3C5vyvQgNgo7LOj?=
 =?us-ascii?Q?vtAaEC183ZUQZCyqODoHNzULDvdJIi1Y1yf84Q0E4J3kVSStngSIJfA/N/tw?=
 =?us-ascii?Q?jiJD+ivXyyySPkmQWRccOyMF57xaGp4Bqj10PoTqiDCc9E4eVAuYgHxqtfFh?=
 =?us-ascii?Q?4Kdj0jV45ed0waJAiBJ/FqxBJUT9GXWg1bd7CpWOSDYhiIY5YpO6EBUopXmz?=
 =?us-ascii?Q?KPTMMd+6FhM9tQXiCFXHg0gki1jpet4F5P33mcYRLp2NcpQ99HQnSIk3WkBK?=
 =?us-ascii?Q?Gf/RDxA1qw7lqAYXe4l2QWdlXGbt7+9IH/Gz7RY8JXMbG41XuWLmToYbf+1k?=
 =?us-ascii?Q?aTGwTU6BieoWV2qas1uANZS+jnyO2HfW6c0Nf1Hqcqn8jgcAkqB+sbhMeEnc?=
 =?us-ascii?Q?+MkfFHySpgNZrE7RVBQwZ+B5vOBcCpNSmmH85l+Q5woNBHATv8cl4x6hYtq1?=
 =?us-ascii?Q?8ImFf4mIUjTNvrvGGoftmhUBLuW8lfqLNVTyJVYb6rBCu+TkKOhDeokbKo5v?=
 =?us-ascii?Q?WdV5ZJLqgt7bFw/cEpD0JTnONzmCfH5bjz7YQIK82/cSYuPcP9aOQYksRRRL?=
 =?us-ascii?Q?JNXwPqoDeQdZ/i/RTRsXZUd/utrzt/5xyMtxNqS8mpIMv+eSaRLKduDi50O3?=
 =?us-ascii?Q?X4XBNghgob+n68co=3D?=
X-Microsoft-Antispam-Message-Info: llkk23X5B+WKRGwcifJKcJtQbMDMWzDXrDWI/M65HPAWKpiW0RLLwG0AKH5k8Y5GS3Z1DR5BMyVroyXKmmr1DGLh/bHHgU62mKU1el0NdwAlFkMQB7ir6X26yYRDYNigBRQs/Xv5gfgN4Pyb7CakURxcnDe+BFBKyZflbDpOXFaVtaQWzDQlMZTJCmsdZiFw3ANL0mBXAxD83AcdBcv5AXLSyg1ol3VeLX2bI2DvkNuyntaLF9sOt1kq8DK5tBkFejHr9pJ6lGaBodDjn1mv/1t5n5i3pUbTzv95sGoxzXdR/C+u7zhWQuZpk6Ui3l90pUaKj0hoe8b1DzX+5fmsDzJKKIHpN7Oaw3GqKKiScPA=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;6:JTVoCRt1Dex7OxXFE++Wp8q93KtxEREHn53/YIX6jRG8KP66RXO1ej+fpKjQKJ0DdA2L5Sn1ALLIqhN/NF5DkljxkkYHsu0ZNjwJxswwHtF/2NzzHBaRtCHKClu4KLTcAvKnodd15TkW0EWRoLooQGlibS1R4WDjUjd6xVmEAY6eNnGbGhlzxqgS7sR4uFoUypl94sGhcj2NhG28iVZkaaLgUvn1RCjix9fDqmxL4cP3tNlwnltjHLjiF4hFxnYZIj2vV9sWFnxadcgn4o0uPeSQBY5k/8DEOnEE5EfucY7++VI7HlQjEFuzyrOY2IF4oCHRf5+zFBUbQx/ZsdwUP4HVpnRk/+5K4OSXlOYxrOUZYyfJa7gUyJG2QyMiQl1fh/REF71nkx4Xki2vbzor9/pIevXhv3hXD+tdYoGkzZoSbOME6sDgxY4XInVpmeX0DsKKLk2AkOrEzd4ywT+IOA==;5:1OrpFY4ilxBxhRMx9ztn/4mVwQdyZI1O2uIUHnTEGNTFPbCOrm+5oT5qB97HRP+Uwy3Q9mcha4QDNBqx4x5Yoox/xD5Mq6Q51uuGrFerax+Q6pK3SnVRGe0eL86Q//vqdkbFQPE3OV3/gR6waEIUihAIXsbXKZBqJiYv1gRXiGc=;7:8xoQ1hbulzCi5eIod/kTPGvrI7uwB0+73RzSS+aPRGGKsqMRd1pC2BMMq8MkIW5GmbOD/mE/leYgPFUT189yc/tu5zy1UPYj9Na8VctGWRfZaI3OCi4S+M2nvi1BNe0So6XPrlXcXwoEgTjWjAUJIFki32hzLTaSYj4Tdxcf3wOv8Doe4NXe25rmL3t/mnmAA+r4ftF4S1bcUljttjK1a/5CgkyZA6Y7VLeDvPaivGssUcUrRRGp/LiiQ33vdz6/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 05:24:30.7085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e50d10-919d-4344-fc96-08d60e38def6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update i.MX6ULL iomux header according to latest reference
manual Rev.1, 11/2017.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ull-pinfunc.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
index 3c12a6f..a282a31 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -27,10 +27,25 @@
 #define MX6UL_PAD_CSI_DATA02__UART5_DCE_RTS                      0x01EC 0x0478 0x0640 0x8 0x7
 
 /* signals for i.MX6ULL only */
+#define MX6ULL_PAD_UART1_TX_DATA__UART5_DCE_TX                    0x0084 0x0310 0x0000 0x9 0x0
 #define MX6ULL_PAD_UART1_TX_DATA__UART5_DTE_RX                    0x0084 0x0310 0x0644 0x9 0x4
 #define MX6ULL_PAD_UART1_RX_DATA__UART5_DCE_RX                    0x0088 0x0314 0x0644 0x9 0x5
-#define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
-#define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
+#define MX6ULL_PAD_UART1_RX_DATA__UART5_DTE_TX                    0x0088 0x0314 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART1_CTS_B__UART5_DCE_CTS                     0x008C 0x0318 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART1_CTS_B__UART5_DTE_RTS                     0x008C 0x0318 0x0640 0x9 0x3
+#define MX6ULL_PAD_UART1_RTS_B__UART5_DCE_RTS                     0x0090 0x031C 0x0640 0x9 0x4
+#define MX6ULL_PAD_UART1_RTS_B__UART5_DTE_CTS                     0x0090 0x031C 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART4_RX_DATA__EPDC_PWRCTRL01                  0x00B8 0x0344 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART5_TX_DATA__EPDC_PWRCTRL02                  0x00BC 0x0348 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART5_RX_DATA__EPDC_PWRCTRL03                  0x00C0 0x034C 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_RX_DATA0__EPDC_SDCE04                    0x00C4 0x0350 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_RX_DATA1__EPDC_SDCE05                    0x00C8 0x0354 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_RX_EN__EPDC_SDCE06                       0x00CC 0x0358 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_TX_DATA0__EPDC_SDCE07                    0x00D0 0x035C 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_TX_DATA1__EPDC_SDCE08                    0x00D4 0x0360 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_TX_EN__EPDC_SDCE09                       0x00D8 0x0364 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_TX_CLK__EPDC_SDOED                       0x00DC 0x0368 0x0000 0x9 0x0
+#define MX6ULL_PAD_ENET1_RX_ER__EPDC_SDOEZ                        0x00E0 0x036C 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_DATA0__EPDC_SDDO08                    0x00E4 0x0370 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_DATA1__EPDC_SDDO09                    0x00E8 0x0374 0x0000 0x9 0x0
 #define MX6ULL_PAD_ENET2_RX_EN__EPDC_SDDO10                       0x00EC 0x0378 0x0000 0x9 0x0
@@ -57,6 +72,8 @@
 #define MX6ULL_PAD_LCD_DATA16__EPDC_GDCLK                         0x0158 0x03E4 0x0000 0x9 0x0
 #define MX6ULL_PAD_LCD_DATA17__EPDC_GDSP                          0x015C 0x03E8 0x0000 0x9 0x0
 #define MX6ULL_PAD_LCD_DATA21__EPDC_SDCE1                         0x016C 0x03F8 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA22__EPDC_SDCE02                        0x0170 0x03FC 0x0000 0x9 0x0
+#define MX6ULL_PAD_LCD_DATA23__EPDC_SDCE03                        0x0174 0x0400 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_MCLK__ESAI_TX3_RX2                         0x01D4 0x0460 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_PIXCLK__ESAI_TX2_RX3                       0x01D8 0x0464 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_VSYNC__ESAI_TX4_RX1                        0x01DC 0x0468 0x0000 0x9 0x0
-- 
2.7.4

