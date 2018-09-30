Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B853C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C492D2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F8NXbmc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C492D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeI3KIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 06:08:35 -0400
Received: from mail-he1eur01on0050.outbound.protection.outlook.com ([104.47.0.50]:29776
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbeI3KIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 06:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/LCzsrJidPpSED7GaNJqGq2TGnXZ/GF/q6KfCmlOao=;
 b=F8NXbmc/PqcJ2y4HTmfglAc22DXTP59lF4gE1bxCY+FHVQbZAeMWgh09nE5VSE+tXNkhcuz0qyY+hFRg36NIjZks7eKL1PPuxHB6lnHK6DgawzIlT+Mcu3bawRN5e4wia7ssnUrrOxGnBD4f7aJEpdpxu997HSVSHzQGJrctsbw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3909.eurprd04.prod.outlook.com (2603:10a6:209:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Sun, 30 Sep
 2018 03:37:11 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 2/3] dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
Date:   Sun, 30 Sep 2018 11:32:27 +0800
Message-Id: <1538278348-7716-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
References: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:203:36::35) To AM6PR0402MB3909.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b223c50-d71c-4d82-f658-08d62686043c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;3:6oV0hbeCpeqHndh2ulzxvbYYyqs7ZuP5YMVkq5UUMkVP8FS9obzF9aENFCB37RmgU8XY8SYCbklMoXZ2LWGvL9JPndju7UsmlCK4Jh417VLpK1GNfsFoxpQHJZpR7F+dyGUST58V41SK9gi2iUcTv7kxSV2NtKHMmdpbIafktYSCEGHh9B/GeV8YeVJx5zrr2gTWSJiRmeystsoizrZenXhlU7o+ML5m8RtgiEWKZaxfbPQdNSjOu0mp0zAfK14u;25:Dr8Rcsr4OzUyGgTG1kXAP+6H9QlwHQRQHKRklWnsPU7Gd81o1aa5/A1Sg9IGCsIjEFB0Z0MguttA3iLH52YF/9PZ+fK9XROwO1c6twMlIuxxaLu+/rln9Nb/peDquuSB64Mf6G5LSX84k34Xlrp+3MWP9F1JUZl2dDJ8JmExLjUFufe87Y5W0uzWsNWm+rfeQI+Y6vGxrfz5SPM9NTL5zaRW4pg6X8zltk5Zhvt6b8J1ebKKUHTwJPknlkONxTCQ7EsVTtE00Qa4sOCg1aT7FvOV+2cFUvsP0ApzE6qqLiJUn8xFFY9A9MoOaC4y0jog29JxfDd5Rm9o01e8qb8vDA==;31:FS3WMujS+FbnFaeTYpySltgm1X3XPz0zZr3DhnuKv/I439D9XoA9zJ3Vv8w3b9kkv1U45gmzsXcg3KescxYNZDep6212X/zfYBaDqMWvsYNxvMKh1ExOBaB2ZUU4ORuQjNY6PuMxyP3KTIocUqOjrxTxrKa0UNCJEu3x13E2Z9Meeq4Lo38jP8B2cThgFXBw++JTxBEtadVTXdFq5s6fKg0Rk65KEcdnUrU5ZWfFzhY=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;20:W5RVc//YsduBJvn69NpebOZQw+R86MMfUom6uip03jRNaUZroGh+YIV4S60vk+PAFH5AO8/ya36bEWgzfgrA7C64HbwiUv7Z9QXCBdWxag392qu/bGIS42EikuIhQ7z9FG+fqaLbdaO3qFWNmZp8xBBI+bJ3PI4gnK+0ZsY8gd0mMEd3n/FB11B0eBl4JgJNCvb4pzVIhismtAs/ZcpY5hKtbLDv3fzQNMfEKCrUpuJQ9FZMDE1KeapS955vTrkyIgXOWyxQkgrNuvIsTdanFxck4A277OuEx5AnjDhPikwCSpMMpnvSwyw/jn0NlqaDnQrUD5FiWxH2p5ShkCGCQ7S9jd2Hqj2xORceb0ypULIwGTNNy0JSH9GzdRzSN0DD3ek8uaGLJqk43iKi2lmiMwsFbD7Tn+dA5nk3BL78ikDCmBZoCWaxpcuCZ13zk69HK8Kjr3NjiHX/J+n6bSRQRhO2Swj84TQ5EBHUNVEJh2blOrzcbiQgBD53asceu95n;4:/guULurnoL2UDUCDBZ87V1zMi6paYbXKMtDAUECEbVg23oOqKShI2zczPFI5bGGIyiUhO+spRKNxHafu/6XLgtPGpBvmcUYN+wfNfvJXlPX9guvAJTz+QRrpJ9MikL3g/Hhwvd9k/AdmumtBtrmAwfXvaRf624Xm9QtYiYWYYZph4K6YfWJSGQq7g13hkLySviUzocU2wVb0HxNJ4+LXD/MoFnID9sWd+DDXt/HxeEkS2LyToM1tzGxwVjOw612P+wLAlEVV8v8hLALdezm1FPG8mCb/ObQDnr03jH7WDZN5Yv1FvJ4o0frhhlHcibRS
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3909DF67886253FB4851E9C0F5EE0@AM6PR0402MB3909.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM6PR0402MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3909;
X-Forefront-PRVS: 08118EFC2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(86362001)(476003)(11346002)(446003)(186003)(26005)(2616005)(956004)(16526019)(81156014)(81166006)(105586002)(486006)(106356001)(50226002)(34290500001)(76176011)(52116002)(25786009)(4326008)(8936002)(478600001)(51416003)(2906002)(66066001)(8676002)(305945005)(6486002)(16586007)(47776003)(97736004)(53936002)(68736007)(6116002)(3846002)(48376002)(6666003)(6506007)(386003)(5660300001)(6512007)(7736002)(316002)(36756003)(50466002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3909;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3909;23:EDo3AUKF/vXSvD0C+2jtI3Mx+11B9mHwhcyCHlc?=
 =?us-ascii?Q?gmccSUxb2E+X9T+iLN9/cN/j8MD1/xJu2CqDpGNUWiAHs3Xior6PON1uB5SB?=
 =?us-ascii?Q?jvgwa+Av/XqDRPPa6y3e6CLNe/sQZgMI1VZ3YITWStQD0W1CWtX/serW5Q95?=
 =?us-ascii?Q?4h8c3fbdD5nX0JrNBvO+eJo9EeoIysXXdqVLC5BjRl629iZFaBsf4g5c30rE?=
 =?us-ascii?Q?9tHESSt5qy7io4np2PIRfy8ZSTp2OJseuJaqet+4YmejhUJFiSsDRTITwM0S?=
 =?us-ascii?Q?vVLZp3rW40a/gNJcL9fQaol+K56spgaCigA2ycWmtIyLcXVisnwmPtySqhBX?=
 =?us-ascii?Q?Ml0QTzrEavFqv8/DR/zfa9xdh5himvxrEwX4z/hW1ibkGj5a2XjeOSTC/P+g?=
 =?us-ascii?Q?xCyA/6LK9aCsNio8kWBWUL/bgW2P3HMIBduAblKfcXJtHX9xgRQgloudQDEy?=
 =?us-ascii?Q?z3fbz5YkNhAPiBbb2PNII7MXx+cd9OPxTC0w1V0uUWErfIO1VT61Ke2G7neV?=
 =?us-ascii?Q?b6f10+EJObCqsQlYshOfyrrlccuEtbwK6ldBJ2sVP9EeNEB90whBCxyZfti3?=
 =?us-ascii?Q?S4cKJMFtSqkpAwCcZg6I3kg92sq1/5J10qULH4uoeWM7MdSPRNisFBKnYIcQ?=
 =?us-ascii?Q?Dv+jSTAeaGZSDdmLr4tBQ5adyBfgIHxdt7baaL6lFzguSEwFjffgNhQMXVE2?=
 =?us-ascii?Q?LefqZpoxhyvUvH4DyCHZOgpyXfN/yJYz/IwVngKfxdby4bc5roFC2ogOUf2x?=
 =?us-ascii?Q?yIz/DD4OgRfuo5fwBEg2x2TbSGmcgH0yRiQpK0qyS8eP0RTlOncsUu43y4ig?=
 =?us-ascii?Q?+ZLbaqRfz5xfCeGnq+iswQWVi6rX2HjZo0BCVDUB7B6MrNgDJ+jHC7RBDkfl?=
 =?us-ascii?Q?8YlHpMK1QkVs1mDCrTDF52WPiA7Dc+UqRDuOFKFsKkH4CPHVRoZY2rBMvljI?=
 =?us-ascii?Q?XdDH9YEKbA2tMCT9MtpHdw6hfvhe8ROL0VI/XDoTU3xwdIaV1FihbQdDlp6I?=
 =?us-ascii?Q?Qke0FrDdXl55chPcC58BM0XS7l1tGL/VC/LqfP5QIY0usa1n0Putg4444q8A?=
 =?us-ascii?Q?xaxCAqpGKtel3XTikJdyZyNTv+UEqlzSyxWS8W70N97AQQF3qnqXpIqMEZyG?=
 =?us-ascii?Q?7GoazKyvxj2HROUlFO+hWu+DT1MXtkj/NYpEBSz+32ECldEEYYdSKTaMzCmC?=
 =?us-ascii?Q?rmyL4lHe1jQ6pRQPBUaIGwXISaOh+kz/OuJtt?=
X-Microsoft-Antispam-Message-Info: QEhL8CTrRddPFJTWopGD51GwytWRBwagEkwBrHyDkZ3zpHvNYaphFoCz+bvs/6GlOxjuLGVWe1bzLn+lLR0JTXa3xW7neRGax9EBUWMmPrqTAfC48Qe/pAHuqrVmXEwEXI018Izs68C/YCZApbsf4XNFGo5v2Q0CLHS4nIHw/LC9WfutSms4zvnkvkXMaq8QYOpwQcHennr4Bpe14uAd6Pk/eiU0+EVOwvo2YGn2pRL6QiLXng8hCF1Vkdfg58w+cv0ZTuGvB/NYA9e73B+eU6cWgXtmJYLjHxx6lNnVpMVDjle+4gvXqAmO9tBd2bHtpIm8gT35uuqX9MzTJ+hcYxEpNZumXJdFP71rECa+BNQ=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;6:xzaH/5/5INNvtRzGUdLdEHuxTKLLJPHwlN+jxyqg+MhrFTHNtXU7yAkvRPeyCxFwI3MYY7OGzim0S42Gh8ucwDbttek79PPvAk20+yJsQ62vbeZdGAhNXjg7IFfCDksexcqgLmKPptgk8CLdnU6dw8nex3LJ2I1Km/BCs3Z/gGBPNl5aQ4p9ftnwj8rruv+G9JFZxzjJgywYrEATNTqf7dUkFjpcjvlXhGo4sh8BuDDzutul/0ZEF/wKydXZztOl8sTMNBBsfcPLZMT6u/Mzdrev9DahSXnCkl4VJqTjRPvaKq9ic9EAEn/tRdyEtOjXKYejmO9hOL1PwwwGrZRC2eRAIZCI5MIndfVv3MlEPIEi2LemDJwQpEtEbexZA7KoKwe8U22ev05FzykQYeOmyL7SkglNLjTrLKQLPM2BUg0tmyGWLUfOFywgI60U9tMRBy0cPzMHDZ1L/l/6U0UwrA==;5:zRBVT0P+tiOPBW6gDh1P+z7sN0qlTsTnYNTuTIlCorsOv+qEc+larDoZyGuPcdDpTRol53O9CsxYqD2B3jXO3fiv+IJnz4gVHWTyQICjqWmIdbe/hXkC5Jx77vgbpfzm1/Uzn+ETL90UWk2/CL1tnhszvsCX/FLt0P4dU3RjhNo=;7:PB/79QMotPOkD/EJfH210QyWvVg5Bv85NuYFQHfzsv7f7eDs+Kd0rPMAzlDSx4EUO5K45uOQtmkDRHQ/W1bu5YCMKCwFXFeOi8iPSp0GxcSpD7LYBGrwhxh0Bn8Zpmg51ZTSThBlrYCmbfIeuyymwHwkf8UgXqOLRf+ad0+xQR7FEINI5OmyGfklcniXCU91jUMnF86sDlurEoIQzVlurPxGN2UhvAcszuoWLCbZKjZroBpxHifMXl1U2M2saI5q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2018 03:37:11.9994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b223c50-d71c-4d82-f658-08d62686043c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible for i.MX6ULZ 14x14 EVK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	Add "fsl,imx6ull" according to dts change.
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 968f238..7b964d8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -85,6 +85,10 @@ i.MX6 UltraLiteLite 14x14 EVK Board
 Required root node properties:
     - compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
 
+i.MX6 ULZ 14x14 EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ull", "fsl,imx6ulz";
+
 i.MX6 SoloX SDB Board
 Required root node properties:
     - compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
-- 
2.7.4

