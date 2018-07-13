Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CC62124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MSe0srai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CC62124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbeGMIQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:16:47 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:49760
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730339AbeGMIQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD9MQS6F7J/WA+7opoF5FxdKwYAR6eTmMSIEWis2YEk=;
 b=MSe0sraiEyLhGJ/+DkD1TEQd9xHpknaSHnkPaiXgQlGWDXqEyAKQ+mi5+FOj2lTV1Zl5eUCMDVaLEgmrjSrSPTG7LXN5eEQF2Uu+7X71JxanTFa3wuZ+20psknBeAGsWD+b1nnssL8a9e9Z8GMavX5R+cCizfLHi1rtXy98Exw0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1327.eurprd04.prod.outlook.com (2a01:111:e400:5187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Fri, 13 Jul
 2018 08:03:06 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] ARM: dts: imx6sll-evk: correct lcd regulator GPIO pin
Date:   Fri, 13 Jul 2018 15:58:26 +0800
Message-Id: <1531468707-25737-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
References: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca046c22-8984-4e8f-f25e-08d5e8971291
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:bb/o+uu1oNEuMicgU4591t7/PFXARTCL1S2TWNHB8qxzOJIRAe22Ul0CfXfq8YL6dGCW3z/aE03RS6FVYagKSV1XS102hpZL3VUQdK+QBHGhIfyrsri9wVJbRS7xSqwTuxNdZ+NQLufi89LB6oqspWMtpFQVV14eb/auSnZm/wk6bHE8JQso64BgxqH28rcJROVQKejpBQAihk1kNe+uXWejEx+sezGhfESsZllvITOYcHYf4zgP80x8BKUtGUIU;25:GzJvZnaP5u+ZgnDAUVdWuhhOkPeJqdvPmC3I9kvgtTEQvVqUc5pQy4p05jDkT/HD5GJEL+kyXa8EvClKGjlM1iYi09FDHaSXEBycT/jdGbuhgPSjT4krc1wsEerQxS9cRj0qF1Kv/+Ji8+O2iOt5AF7Sp6344SgQquk+T4pRrNfn87pjKsOMAOiCvqUIyWDH+WTduXFvd1BxzHygR10u8i34M+/VKN/YWRbEkU66g1fTw6ku2czCCO6hl7p8LJOztEku/yxAS9lL9OW5krYtEgefqZkGvNjDZbUMW4cVQoPYtTwv0M38aftYG5KlVixViqzexxMw2uTdXI5nOPwdLg==;31:2EwWXvxmwhWLozLFCkT94o6l0eId0xJ0priGoopX48l96dNs4q2kPQIHSS3Xb8qOIRj5/EKlclAamgr1K2YTHsf+PuQHbn4+DuOLn9opP/QlAEnRSU9hBDoyKR5ZsPfDox0TW2S//e7XGtskVWJ6ykDsMlCHbS27dRzTx60lo/Mi/m6l88iKYdt2R7rocVeBKkz3HyhKHU8TJ0ghQ2iIunAkuJE7Q9Ln9vyvRG2GCkg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:/CjfSJVKEB8y5vZNzCcDbVIbxQspohgOtzideEgYb/WL71yllNOCHl4b469Jno9ZcOx0MlKDFMOiKtbjsL0bgTnlXGoMH7hRI+7felpw1Z7jBcZz6a2WTHrybWfmrEfEStX708meMUfr5pptKKzkMZy4i+Gnym2FQGCrRHCrvAliA8MpzXAwLGNpyNVy3mSjEmIdwXucFw/77/E1/+4rOEcclTHnPnf4rvYRYWJ2GdMLanAb2n5u85ZLkYkoktwPrEP7b2kFft+8JO+3snrl6QC7yyaPjEhmnVNM3Lh5q8VWvRql2+w9tl1/XtPhv8r2mBZCj4PiAuAh5C3lcY/5kLBoe6rgk6ee/7lFVMCpRqEJPUy1MJrqjp7CY5veCa2Zaz4FyquN3yRnFMmQilEYGNJN+qWTrwwq0NvCgWcWPs6mgBd8EWndsBDM+qPcILZuohXp3K9eC1z19nAun+nAuSRq+Rl955EYee+fJnEf6LuIbEEQMm+r7VYlUGDO72LM;4:cIofjWVJY+9emfG2a0UN+txw1zU+896ZJ3XKRYdyVpYubl9693C5BLuw+TAzbls4ljwAbNyxGpE4etN3lGp9GN+yu6+XbneFd0fycAa+T4zFNuayCFpCcaIEpK/y5eDufgi6Q7TYhGwDrmAcBE6cl6xTzFuTsDxOhTbNDmO2yYSeG6FjPctW1eMuvtgoVfRVeyzSC2NHu/4eCHqAr6Kcsk0cVRVNe2q9pIYpW8Iu0x4nk+A5pK1p1cfAV7ZrXgdd4HOmnOoboCTdoHQc48Yh9nvwExrr8pv/VI3j1jlOOva7CQOlebCWKRn5+/Vq5eZt
X-Microsoft-Antispam-PRVS: <VI1PR04MB1327D937D46741A49C5463A1F5580@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(25786009)(305945005)(81166006)(86362001)(8676002)(97736004)(81156014)(6486002)(316002)(5660300001)(66066001)(68736007)(8936002)(2906002)(16526019)(7736002)(48376002)(446003)(50466002)(4326008)(6512007)(52116002)(50226002)(16586007)(478600001)(51416003)(47776003)(476003)(6666003)(2616005)(956004)(11346002)(36756003)(26005)(76176011)(186003)(486006)(53936002)(6506007)(3846002)(105586002)(6116002)(106356001)(386003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:3h2pcuTFhd682/NG6J5E+JwFVjrRdGiDgxCWLKjce?=
 =?us-ascii?Q?78OQaycne0pZUiU7SCmnl/+K0ZClisLhOtkpnifz/tEJS45AJNcNqbggyVlT?=
 =?us-ascii?Q?g5C6gYqV6HisV93ONpdSGrAANBzoj7ZNL6u+nbAKIR6iDpU7b403HOQJCwj5?=
 =?us-ascii?Q?62Pzk2nmCyYsusoTW5Ui5q+1uEgon+V2pUT0X0iVjyhgX2TDDRhwGmhOz1o5?=
 =?us-ascii?Q?3RAdtVGBNWk/OJDiF1J+oIr5ei++H0mXLwySQquR4gdsmXVKPW1oReJ3zpsq?=
 =?us-ascii?Q?ZnfEgVWActLLiwrIxYd7fHRMTaKPt62cdJ06AcQcWRC7GY25hFI8EbhTaX/s?=
 =?us-ascii?Q?VorbT7jWvP/nPJaR3uowSRI4VJUEdYaV0E3WOaA5wSrKanB/I6d25/xYnWUJ?=
 =?us-ascii?Q?weY62V1e4j7hut7YFz56aL1++ZTkIe8EYXbN5rlJsbCRHW54Y7aHkOcn3UFm?=
 =?us-ascii?Q?RlyjkYka9Qkhr9WULMRNB7KooJBWwJZy7TPQJRh++jx/JT1B0nCmB0zJu0nH?=
 =?us-ascii?Q?gVDm9zyrS4G2meIO8v8SGKW57M3dxyHj6hcBi/Ivf+POzIum9Lc+qycfdWwb?=
 =?us-ascii?Q?AfmXhYzkIox2QGoIPQOMxH7PVkbpqWc5bFobG5/cj46byzM86I5jsYuxhWDU?=
 =?us-ascii?Q?2KBVjhL89QbuK3dCZ7QcoZOShaIJF++SynQmN4jW9XYfHXDOuL9UhDwhw5H2?=
 =?us-ascii?Q?1c0PVJBFXffLHFwo78W/Dkwg/2Rl5e62E4VOXSZO3Y02IRkWUMM0vOVykMSE?=
 =?us-ascii?Q?JurWwhUeeTXxTwLY8PI98hmx/tFNt09xHWPENyBF1ghH5AmoTQY1GYEAYDJm?=
 =?us-ascii?Q?ihpx5vKOZgitcpAOgz9b34OSxwRdoBB030b5DbdIUizD/HKLCqjn3/VG2+a9?=
 =?us-ascii?Q?V/fiheRW3Ta8jrqr01WPDGmOXDwdx9tm6HfrRUKJ48kOTpFtHT9itlJtpzBM?=
 =?us-ascii?Q?3aBtU17fXZPwb1ROtT1pMlwIIH6ZQehOJGPJrMPJYJdyG3bqGYcQiG3jhO8g?=
 =?us-ascii?Q?8zHUZLPCL45uGKERoamPRKWHqYJQRdcsHOb3W3LEaoTd9SMRL3YgkC1d1YNz?=
 =?us-ascii?Q?G9kNDMDeRGR+/L8n7xwK2OB8E3yx4UHc1/LgNgLXKgmVJ2ifrsjVTKRdZRc4?=
 =?us-ascii?Q?naqqxJxFdk/fgooteXK9UTQMrk0zpfbXCG1T4S5Q60L8UtLZb7Pvg=3D=3D?=
X-Microsoft-Antispam-Message-Info: LNtLypZJTbhLkpPfXbtPapOePViHFrAvm6nQF7Z+6ByqwqsTS2p8xvog+nzdVttpOtMHdf1vFjMVi7lu6A9iTOjwUoKPoAynZVukkDGfqilryYqBAaF3A9W5y+2IFzobzTmvPuV4dkUK70J87i0/iYsAiXn69CAWogH/D86J9v/fJN6KGnF/PEB4I2MdqnqiDaUHtXQopd2rZ6COjAuzsWBfCnfPn4aL97JonBGWXBAo6kx22kpGPnGyI73hC2BZPYtFv0NU81x4KzlI7KQArs7ik/M2UW+5dwYF3ZjQs8GoDyBQPJ2ICAXPIuHW1jBokt8jveFdP9ipT33kc1Ug8DUiQkgpsIDNDAhGthFzNrc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:dRWeYtBRFqN1En5XVljUwXIgvGBeJ9Zn+epuGtimljur9/iJ2YEi9nO+k1oPpu9iWjY5ZQvcRkJjsmjPHOctUvpexwlvwMr3ysbiNI5I850NSshpowZ8Xw3UUrDgx9PHL1q1uVYVZ2o13TLbnx1DK5B22PswU4J5AtIZDiUiYtMq8MsWfOsA3ePCOMB1uDF48o7RU/DfJzoOqXL46ojCxlWrdCOtdS6OFIZ0dgGa4J6Ts0yxfex0so0J9lxpuERZGZ44GydgC9w817wiCBcfGUdds5CP8D86rumkxD/YkMV2m1g2QBY3eauG73g8KMp5v6Hvm8AwjJsIxSxxrrlaor634yy8ZjSBIwirJM8VSXkK3ijIIdOO0gdHYzKp/Yy8Zsf8xZCFGeXGInBstGHRwx1aFNTwCXyMqarVgd5mtkCwWSg1dFL1Gg/o3PV+tW6G+/55sSy1jXlMmvY3QDWGlQ==;5:C8zeXADjzYKrGANVSEDnU4TPtC0XtE2YAB1EyLvh0cT+jnnP+N9hIBsYmM1NcPquzCs17EHUIlG1HpLOYwIYnJafP3iXd1xCN0O3re7pqM3QgWi7bS11kIswfrpoSsQqBfXu8g8GLdzNpawVtFfw8iBTlmEBxgi960tiMKGOjho=;24:/NkEev5uwJmDUSKBmNlsS6M2GTrU+jiSPIpvq4Q7t8TSFAfLLl32ioa4Qoh/79Ab0pvFM2akKe0HOyoRMMUA1pui7Wasx8N/hpGh7UwZsiE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:o6RZd+XQOvjIa7BumEzrUJlEAUOFzUh/HFkcdaBQHDHIlvVFzKhZbSYKuWfZmVXB12driujDqAXe1RNlSrl8m9zUI36o1KJsV0RzwGsDeuIyx2jJ2V/c1BZXWbHEJFywLXJNQBoqsqKo73oBU52X3ZTRw+KxI8FA0SXszfZLqsPHn0mPKalXb9xl1mLeOLTFPdiHcPMnxiPE1BoThJohg7EHHf876bG5JqXxXf4P5QwcShtue0UYHkEC6P4EbpZZ
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 08:03:06.1585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca046c22-8984-4e8f-f25e-08d5e8971291
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SLL EVK board, lcd regulator is controlled
by GPIO4 IO03 using MX6SLL_PAD_KEY_ROW5__GPIO4_IO03 pin,
NOT MX6SLL_PAD_ECSPI1_SCLK__GPIO4_IO08, correct it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index cc5cf5e..41e87e6 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -74,7 +74,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_lcd>;
 		regulator-name = "lcd-pwr";
-		gpio = <&gpio4 8 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
@@ -289,7 +289,7 @@
 
 	pinctrl_reg_lcd: reglcdgrp {
 		fsl,pins = <
-			MX6SLL_PAD_ECSPI1_SCLK__GPIO4_IO08 0x17059
+			MX6SLL_PAD_KEY_ROW5__GPIO4_IO03 0x17059
 		>;
 	};
 
-- 
2.7.4

