Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A74E2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vw2Yui0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A74E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbeHWMOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:14:34 -0400
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:38963
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732945AbeHWMOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slUofPlVaQPWV7ke8u4HwrAygDLr3Re32wh9WwC0TcI=;
 b=Vw2Yui0/H9Xyk9TKkK1M+5AWgg/TxuyAjawi6q5tVdXqrC/FeczC8v/v4Y04qaP299UvmFaRKoOwmLATB52p3e13cmD6LUzObGYK3dL8QoQBdqwVg0CcyfAI2duoub6fT4SEUrOY8DEmq6bS3NEBS/13rLlphJz3eRnSVwIJOrk=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3918.eurprd04.prod.outlook.com (2603:10a6:803:22::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Thu, 23 Aug
 2018 08:45:48 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        stefan.wahren@i2se.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] ARM: dts: imx6ull-14x14-evk: correct machine model name
Date:   Thu, 23 Aug 2018 16:41:13 +0800
Message-Id: <1535013674-21356-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:203:72::25) To VI1PR0402MB3918.eurprd04.prod.outlook.com
 (2603:10a6:803:22::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffdc13ab-f87a-4992-d087-08d608d4d56d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3918;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;3:N+ZJmd+yfRXcHLuM6h5MxcvBtKGhASxsOCA3r58jPptmN3TNGa9EGS7GuuN4LmDNtW+taV0bFdMMTjcbojtSqcPndxZrYR+pix8HXvLoywS5l1FTgupfxt/qMiMFsQEqSmksphJtJcDwGTD5bvYeEEaJJtWwjAJtnRPyYNMRH9/uiJ8B41ZhLzDAaMWxuluFVBiWukhsFduYQEBOXPRUD/z7O129djazh/pjErLevtrciuE+WW0stWap79Idvyia;25:Bza4wPKyJRkawynCodKnHTZ+HTWK/lIJktpz7zLbjjoBZcequuTcCVhEUrQFsvbDpJTIToILGeaeiWre2QqGDOdjNMveOPtwqURFQLFUlvHwqrnLtc2cusZRtoSzrH4KL0LL12SYBjb/KZUhItQ5RLXGw2nRzSFrGv/0HC5L+EmRq47g5NhWhc1mVU7A4cvwYJ6sGQSaw4rBrVN3EL6op5h3Ilhl11FbqI9KcZrwSB7+tJWaBV/xOiixbLbUjHMG7RN7ie1TFwGwfu6gLMVt49T2ZH3mY1F51Tj40AV06pZmXEYLyedIn6NUicL30NhgGKXkyPN465iYbbWWiB98OQ==;31:SOHF2YnHvfNMjUQRqjpzoCMxdmFhDRVw49Z22d9LokQRhD37Pp2qxWqScYyrO1rxjc/a/B8SxVlkjpTFU01Am5JgNMzKSZ9fhWs/fHeg2BBKVcXM/mkcB+iIpiulQ8+iFhpfy7DdSVl/0Clo0zE47lc57+nPRchC7/YRiEPaRyRZ6IwualFUcT716JLYrbZyI0C4hwzuZB1enrZ8//AVsvGRL8bTnjxqmLWtOnx56Yk=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3918:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;20:5Y9f3Usa0e+GqTc4UGt1lR8U6GFUvWJBxvMqg1+2JTbQJXIxz8K1OFF7k4mPEK3Weyin3FhYitHC7SSfCHMSE2VbcI6iOYjto3dJIUQbbHpZr5tp0kP4TuzXsajFjohikOaRpgIwMjnYfz47GMJW0o5wqeYzRkJisAT9+Z4ZY/Uyla9TRN9ZN+UXiVQs4H0faaYrO+OhtanVDi+yAh35YURQ4vnKeIV9aVVsyO+3AHwWvhqYOqTXxCXtre9MfM38TyuJ66HHVWGqR9fg0ng/vyFTXhgzP2dbC2JktibFUsPvcZf8nHIANXWe4jcbR9Az5HDqpullv5PvG1iNMxwkZlkh8ZQ7ir1l6n/a2wsI8d5EbYmxV2i28DTKFlsm6YYstymR54/8boMcVthIITN5PKHIq9+uUnyq3L8ilDunsV57+kGLSY31Euq5jeRvHih+HqI309keZ4qjIBC6mjCt/EqhCqOBDvzKSC30lyD5Yq/t81myPrw2o01HucEfheDT;4:uMUfGdMnS4T42uS0jePSaV2nCCJ7qMKOmql3wrSV7Nm02//YyEbI0w1wgKIxW2kBBsn8eaUh6IFVvtNjFrmb3IDkHJkgaiwGd5nKB8awO8DMxZz1EQjqQ7NW4XF0r+O04l8BEmiYK9cOGCQKCLWC3Ax694zQ3V7/7oChMEqtu1fdJ7djn5qTC5kAJH8g/fuvJNDj9NcJKDNPxG0GCY2CM8lGtHndFSpA7gbQ8OrNXe4EDuXMxa73jtCIsRzxYnYk5HYzPMQTho+sLF/j1uH/j5ZNWUzEoS98LXPT3XQZFxfGALUow9MXy2H28MU9jlLy
X-Microsoft-Antispam-PRVS: <VI1PR0402MB39188BD76A140E69DE907D3FF5370@VI1PR0402MB3918.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:VI1PR0402MB3918;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3918;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(6512007)(6666003)(186003)(16586007)(16526019)(305945005)(478600001)(25786009)(53936002)(6486002)(8676002)(86362001)(7736002)(386003)(6346003)(51416003)(26005)(6506007)(14444005)(52116002)(316002)(2906002)(486006)(5660300001)(36756003)(956004)(2616005)(476003)(105586002)(97736004)(106356001)(68736007)(81166006)(8936002)(50226002)(81156014)(47776003)(4326008)(48376002)(66066001)(50466002)(3846002)(6116002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3918;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3918;23:iWNBh9z09xz7HNDjFezGVhm0bgR0AtrEjUAI9zx?=
 =?us-ascii?Q?3tXjuNhfiqo6oJb2yp2Gj/gJoSIDk9dniOJHvqNhbgN4w2ty+hmyJHGlP1uv?=
 =?us-ascii?Q?0a1dZa7M2AnJBB1t30cntlxoIolTuiiQT/D6KSho90jb7DQqg5cDfk8VztrV?=
 =?us-ascii?Q?GWbyUUH/HOKeaKSTjqJR7O5E50pdoNAGoNARnnYJyxAJ5gPlLZEpJr+DNBBd?=
 =?us-ascii?Q?5uY6V5Euk09wW5JUYiVTrqQU0YbI7OlS5Q16F3hgouLq1V76KZ4Kyp8otRTl?=
 =?us-ascii?Q?7ph3qXymXwoaZXUVJXuW/zK7mFc5dsJLkl0fyTKkfVb1OJwAr6qm3dVC7nkJ?=
 =?us-ascii?Q?st/ZIY/P+KTXj8Be7vnJEpvgFzIT8GwboUaOLBa3ddXR0RUL+gaagMjqktd1?=
 =?us-ascii?Q?7LYaWAFaHLIVbQOAgS1PXvRDaJxFdaTFG3sNiDt7WXX86VH6e4GUPNs+x19a?=
 =?us-ascii?Q?tvD8WJmBq+DJQ/Nbadt3VgwoqvaNlrcODqczwHFX5FHPAwbrZvyIiwcMpU/b?=
 =?us-ascii?Q?3lzmntjj/lpAUr5EBVa/q9BzgG9pbHKmNYfgi/ef3mJQR8ZLTSw1YP7OlzLC?=
 =?us-ascii?Q?Q6uCLNL22VthKZzdPVAq6d3nVTT93XGI/wEQxWQWppFpBHwTYdnkht8qC5qA?=
 =?us-ascii?Q?nlh9K6eV1MNOpJWvUuoftNs4mhYO2RChswiiVHUEKDz13wTLVCjxu0qju0l/?=
 =?us-ascii?Q?z7JDQFKp4oQEvYHaLilAnDUR7RfHH66QwSbhHEdWQA301dsbfnqxnCJZYR1F?=
 =?us-ascii?Q?tTN4HzdGhQj3+dqYDZheFrjdXx609SfEZVLInYUhx3HOu6/ut5/1ZHHw+DMK?=
 =?us-ascii?Q?QmlPpBIivT/oq5ALxT2VmpVjwGNafvkWQQTloDh1tDZi7NctlJ2GwWYm2UM8?=
 =?us-ascii?Q?BjcFksrRZ0V/OVG+oIr1jVIWwrq6uTW9cjYRYGqpe+3T6lyyOU17fkHDcjxE?=
 =?us-ascii?Q?Swtf1gAz35toONzCTHxLpxxR/5/2j1/6i6x0iG1WNFpzRj/RsfrwTgFWHev2?=
 =?us-ascii?Q?rYGDBHUp0effdNPBzdZhXDQiuv5UX2ly2fqrwbWBtg9fh5yi7KqT19jhbBFU?=
 =?us-ascii?Q?xbdgWlCGFegp9xH+3oS18v5VMipLZesn6nOBO7W7Yp6NEFluwzsGrCDrQGUJ?=
 =?us-ascii?Q?1dVvjzeKdNobRRf6v1hXpLmKT17kIuzgsCc+TNHz5lEJ3A8F3Sll+EkEBN60?=
 =?us-ascii?Q?GW2Ac6Px6sXT67RM=3D?=
X-Microsoft-Antispam-Message-Info: ftw4RCDcqYiufkBGf5iMbuVGsahICqSLZOBvVPRwwRUWWjxG0SvOnVPnydhUQ7omZfH6g5efQqzl+738Q17ikluk+ybyY1qLsa2MwwItK26petLxhKXW7jf1/S0u/8F2E45KRzN/ymWKdGdepiwtOpYr/UR8WXAB5HejZ8BuSBkHtXvFai9y8JDG03l9g45b62WWFZp3eb+juBMt936OV3eZFo57dmrAHV608HkbgrI4bQW4BMr1um9DP/OyzXv7xp8dCigDZaj0pwIc279DXs8X2DKkr7HWAmyYO+fI2+icWxqDil7IcQbJ+TKHMthQhXs3VHNOwigdnVokraB0uGGsQpWSpmx/a1B51/GNQvE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3918;6:N595iKSiPTOamEFxCDsJOEoy2QOiOdmGcl5uck67YFhszx93GdlUPnzS390GvGnqZ1U0rgRPVld/JIYFaMmFaQ60CSD4h004xFnQq19lSoQAaCRemH1e0mt6sSaKyfDLFbmHb6zJbQJCeVccJE+pzypgeumggfrWweSZr/33xknUHx7XwXHy1Y7Hgyy0+ZqmFWseDKLkFOJxwUdy3LqynCQFvHfq7CpkQbQPUAb1KmWYoN+/chDTiwDwiRwRxRwl76ZxBCnG+os7Rb5UCMSbodtROY5E+oQUEdw3EOBS4DjrGM71gNui44l0jdYnhUGyoOn74dN2gyquPx/OrsL6sezxmmChoUEzM2+4r0SFG5tt9TVZRKtZ1T9gxpshPulsNH9lqSyW+XWxRaLWUtWXNtOGIyrlxqaYZJ4O6QPM3bbOFL/2QGAluebRnlVpCjmaK5509swW6amEHc+AsVfTGw==;5:LwbrZeAU7oVyUI8duaCzByQuYZoXC9Q5rKehqLoKqfqSJaQpZLaC90cjn8adGCaPgY/Qx0fBZcZpvx3O6rAPgdPNAj1YVlZDry1zMCXUMJ9+bCNWtOB3LRdwyzTA6LEkt6IQwA3eh+L6EqmOkoPYB0tQmSBFtNos0mjwDpXNHGA=;7:aFtCDIHOlRajEmXDMvwt+6q/xbYjGXYKG1oxKXYj6BLG0dtwZhyWvAaEkKp6gHUWlCCTjaVeVVAfGkOq2IWpEfSReNCduDTIm3Q/j8a5ycex4uiRTU3I/IIOX5KD5GfyBf3LVgUW04AmcMbd02w0y2CdTtCZ1zeghjY6ZdBnyIINIHgjstU6ElhQDDW5F68BfuOTe47I805xth7kSNNclgXLSl/PKQO2a+wuiDfRtrZIhPxJY31QqCNsh3usz4SU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 08:45:48.7743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdc13ab-f87a-4992-d087-08d608d4d56d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULL is a lite version of i.MX6UL, its full name
is i.MX6 UltraLiteLite, NOT UlltraLite.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ull-14x14-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
index 30ef603..0ba6454 100644
--- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
@@ -45,7 +45,7 @@
 #include "imx6ul-14x14-evk.dtsi"
 
 / {
-	model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
+	model = "Freescale i.MX6 UltraLiteLite 14x14 EVK Board";
 	compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
 };
 
-- 
2.7.4

