Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343B1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D267F2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AqY2h8Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D267F2150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbeIUQMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:21 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:60704
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389870AbeIUQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=429ZX9eFBzg1t5DP2UflMt7Kj0Dwc3xn1uvWa976AUA=;
 b=AqY2h8Nm+Wtv70pXGfJn33fQZ20dA2jMxuEMKdUpWDdxqyyPXGInCxLrZZSba8tZqRehi7pEcy3j+KBqiKSqZ0YsmXHV2+Byu9XPX87ZfeCO3n4j4UgdDhpanBjeR0jcAnnwTstA9A+Id8q/rquIm+srWdY3L9TcNF89uBcCNKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1028.eurprd04.prod.outlook.com (2a01:111:e400:8443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Fri, 21 Sep
 2018 10:23:55 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 2/5] dt-bindings: spi: add binding file for NXP FlexSPI controller
Date:   Fri, 21 Sep 2018 15:52:00 +0530
Message-Id: <1537525323-20730-3-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To AM2PR04MB1028.eurprd04.prod.outlook.com
 (2a01:111:e400:8443::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c605dab-9089-49b9-072d-08d61fac58b8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1028;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;3:m1lOM7t4/H/3Yqt0jc8PGswDK+0GzMUKy5NZ671IpWNJwbqWqZ7z+PO2x1aqidE6RnhRp9TuHBZBWSF27BLBFZvS33Qn1vf0SQyH3w65R+i/2T1T6wzyJma0Nelq9AtDEdeKrSOj6CBelseZy1f0YeupmA0InEdVzt9qndLqE2pZoZmCK9SCpffNR8p5VKzBerJJ62IMdHq/MIGEXqaSAIzZLyN2UD6h+azeWBGYpml4q4eVAb26QqQ/pvLYZlM5;25:JD73hV+qrYhS4v9NWA+zg82wqbJI6S6Dd1R/vilENHgfzVBhY/ub03fcEzcTgRJmA2ljBGjFqdCPWIkHqfXqNapRbxJfu/FTlUY6uy+NFOT2BTINEN0q6hEAtiAjFJTIgHA8Lkn6HsTsUcZoS4M5WYTGLhbdqGOGZGOPmlrqW90y1sUGYPpkOXYxo6Wvo8org90R1q8m9nJcIrrxiumBJ5YLFQmy0zB08s+BBC7AenP2XFrYLpjBPzoHaI6gxYpBjJjB7FrQqczL7/Th3NjzURW+FtHWYCRXT8JYjvDPT67GcxKCOa8IOCLsnJTePWcz9JO8JNz7+heXYg0McoUwYQ==;31:uuzrnNawL6uYmoHCtVuNHpxBdRIY94fkLbm7byUR6ATfC64sZ351k7GYH31ON6ESCRoDpltjY6BbIaFMbwxhj8WFUgpJ4j6QNv3iWrfQlWvXrEJdekKOYFdI5cCQyf2alRfA9iuCe8OqOFxP4JoqvzqeVeItGxjQGtkbijCCekGlPdX9t6KXqRev3KXcIZzX3/0ZQrcXUc9CBXRq5g4vKkpR3px3UByPPvsg+1w2FNE=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1028:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;20:18o2IYrHnqn7MzxwoisR3EO/s56d66GEnvW6kmDRtLXbFtsxzxjs1d6rMvUnJ5Yom2w//Zvu0CEM19dA5WXk+WFdlQ+TVjQq7uydKxrS9yKnDYdud9RB1r0LV0QXq4PDbwjvRZJjjyTgthrzFPJU7wALSSEKQlpRUTXIcDg7VrSgm8rBPQu4umZ4aN3ebobVGkOiVcbP91Ypdei1CVk6GgMXWOGCBtb25w6QwhOCErQHcKKYO9FxWa1zmRGiTzWvRl5nIVtd0+7jw3hKGaWbLEPGyqC2hFlTictx3mXtI2PveQCeIU0D/0Pg1mXCJBLDi8x4TilsATcKrasfNuL2j4bV8Trf/rD3zStSmufAW1RTPYTgrQn7CRdRx7mTrw+Ebs3S8uV0TnoNayDgLdY/ZJXkNx4cAaYUPHCc1YFqS+ZyGKI5R66BZ1SkGXdVAZSM23JHXLJSspvYDx8/5bddB00nhOGDRGFasRp3FcQ2sqpuJx0w3gamauM5Iz+L5PTi;4:lf88bprbqHysXmw1XOBOXwTQ4yteZwpWDJMP22OSOrkZAYGAsQh9KBc2rjz6vCiIR2KfDrvyCeZvnDh4in82A+mTk2ptEUBISGgiJqiFrjPZX0wJDI5r8FVBW0yNqqLUAsBT4qn5M4bmVRcTHvtLDKQnhPKna71JdOW2RfjiX8CPPnjTsxkx4+DePM2wDDFKZT7TuLoCQaw/Wq5sOdBEkleOmiaGlb9duuZCU6Pc/0zU1rIuXnchIRQJ/JBb4Q0fY+ZA6GBLBXvlf+IYOY4ZfWenC2RiujfY1GdGqODMiblDzLujhU0u7xJxFDBl7Tq9
X-Microsoft-Antispam-PRVS: <AM2PR04MB102871680FDE61F47F71C5D999120@AM2PR04MB1028.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1028;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1028;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(48376002)(105586002)(305945005)(2906002)(6506007)(25786009)(16526019)(186003)(81166006)(66066001)(81156014)(8676002)(316002)(2616005)(39060400002)(956004)(86362001)(476003)(50226002)(26005)(16586007)(11346002)(486006)(6486002)(386003)(5660300001)(6666003)(52116002)(5009440100003)(47776003)(51416003)(4326008)(76176011)(68736007)(97736004)(478600001)(6512007)(50466002)(7736002)(8936002)(36756003)(446003)(53936002)(106356001)(6116002)(3846002)(7416002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1028;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1028;23:1RuylPGPe02ZslPRq0bFKB816aaVl4oKHGB8DhIdB?=
 =?us-ascii?Q?PYcR56jgoMGzJtjhdK9PVZyWU1HXqxbUfdb8h/IPPlq8B0f1hcVjThznNVIq?=
 =?us-ascii?Q?NT0me55tuGWYwmtVzw7xMYlvNRzGvlRhWjEYSM6WO/2PE0TKHqIdN+B/qmlr?=
 =?us-ascii?Q?PApEOEzJ2hgWfBAtxd//rt7P8wZIqqkNKokPGMQeZjiAYi/EhMrw9EZfcDhM?=
 =?us-ascii?Q?SzbDAgkYhrR96mea+GjUluQFphFNec2bNBo2l87+2+oSydiaYvhzMxHkUwhC?=
 =?us-ascii?Q?GyqLxllIaj5crtfK6K2H8j5bZC+qpwmrkehF3ngwHXxb6tZmshFJEc/oNIN+?=
 =?us-ascii?Q?1vxjvDBWfp6JhmlQZLE2Y2RdEWMRGFaN+LCS2+HfeL682UBAlu5iHM09KrGx?=
 =?us-ascii?Q?lGIp/HaImkulnOrZpVlDiYxjBhi+1L1rgKAeUgt5IO4iGKNqTaA6YpuOr7iE?=
 =?us-ascii?Q?zB4D1Rujuj5iQnmzO+IQgVIPhcdLbC/pc+pt2PS8Nj9MqrlMHTtcUXTvyqNM?=
 =?us-ascii?Q?KfH5SsUjB3GqTIhvpxdVeEyoGMKhekbhYwHmZEfXkelB82NAv8Ms7caWKKKr?=
 =?us-ascii?Q?97cYEGpbAsNN8lIMOjY5eJGVFEQdVfLic77Vc4+2vBsYqJfy7xyUWKDAFiQ1?=
 =?us-ascii?Q?vxLcLyKdObb9u1s4J4WZXeCWLj6UFMqXMu8QBKqzjsvXf4uXfWiTtUyWfta+?=
 =?us-ascii?Q?VUIgiEqtdie6aiuDOZmejdLKVkk1NPcqzvKK+mtqrCZrTncV0KnV9X8lUsq4?=
 =?us-ascii?Q?aXEv1mzapSiB/jeFbDoEzRzwJf/eDydMNA5WcL3hEfIYA2WrtFJLcWJS9TmL?=
 =?us-ascii?Q?UmrEFppUPa5bKD7r3e3SE7dqMevlgBXFU83DRmO1s2Ih0FeojUXHmMBeTnOj?=
 =?us-ascii?Q?WS8Gu713BvMfOzQgDhW0y8JRMm1pT5X2ppkKo1T05kP6MQDBbtHoIyzYNtb4?=
 =?us-ascii?Q?qqdKyiw7y2wxdOu82conHzOHa6Gaxu8O+d5gMkh+wgPCiK93OS9RlgMtrQhA?=
 =?us-ascii?Q?W5+nrTuqulMjJZh15aUz33DrXxpJPjOkpiKJK/MY/I1BXzti0L+pm8nmkm2j?=
 =?us-ascii?Q?1IJ4HAFBLxfnoc8p/draeDbJUrDwHHr9ayRxc2z+YaPK2FJ8mGB/OK3BuZpo?=
 =?us-ascii?Q?H27umPkUhXmnpUbLDjOE3wmrzExCNsXnQQrofL9g3rFX+WfyzdAU2EwNkLF8?=
 =?us-ascii?Q?X7co+J6QgirICU89LbOGqWN36lazA+d1afX13bUMNyphp6Hcg+lXhLSbSZZw?=
 =?us-ascii?Q?Kb9r9Yf7yMCZEzDBFM=3D?=
X-Microsoft-Antispam-Message-Info: KC3YtuDIMMQtVb2BZXz+R0NddCWhY7tO/nr6eNyCw/lC4NnEYe+g1uBFHcjXjyG26Kmdn5fkCdGvuGG7i+efovzNft0SE9mCiT+AgI1FBKwrCTLFaPyuO+fIuvbeS0KTq76lwqQyfMQS0JClKsNOLrbqH/Jfa4c87NTlHYwFNB3yAoZ3QaJkfGAnVhoR7WiYtuS01saY1A29oKIvSh9mrijiDT2sIMIoJBeRpKJcuRxq5kNjQXywtdkx8thk3ghvSZzIRxObdxgyLFUftoB3PRavV5iDsX5MkTzgSMY7QWDsooMISPsD4pRtbrlndQHkm9+wHdyAs0TDdfXZaSM2NV9jRmjs9VEp8R4QiNgDYSs=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;6:L7HBkw/HQtMjD1VyAx6NmetJwzNNEx0hyjdKBa4nnvfb/6XzGJ+uHhjWlxJ6YILFekiJncdy5h8WhE1mWOq9x3fVemO+NE44XKh36nHU4XLOVqWEtv7wPjUt1bNP4vs0F8sXEP/G0/19nSqOZHhnu0WTxg65VwXexmQQ7fJgvM9awqFWdeYkdo+kRYWmM8dBDNFzJIQFVmyKS1mIY2OeNQVJ5UvjgymBcArFuh9IRPOzCbXOnfIKq4h41ua/FicDKCBOJAlwSV4AyzL0XfUqCQ0qfaRE3ouix3i7uYWKTDLzxQW3PZQRVgZFFDeab8d3EJUDfz9kK94tb13Zbhqy2oJsTYiJuXxnCfs23WfnxiEpUyY4beE5OZv4Z7UlP/das2SPppFSRxA8gENQ4bOLj7vf3tVTWjIMNOaoiY9tzPWPYTOmdg0QhAJkcMerbjNYxinjNMZjN4tP3lfNd3mNAA==;5:EvEKwMhbp26jbpGEAY5qKX6ds6V80nCM0w6jJdlndFqqdiv+X1D8tgm/YOkeM3UxHlqirq7t5uyt4ZdGVxAaD9x/zHcq+tXIZ6SlvMS/AfgV4OS4PusZk00fx3TsWWGFHncfM0oPdBocxBf8tIahXyh2hDHs3noBwe09L4Oe1NA=;7:oPu5rstK61NSPvCEGVr29VFIfHAnSQ+V83vGkp1oBosaBuAajzrZgwqGgwGDPeOldkaeUqdWIIasXiIgKbCNAhG8WzbaYwxA6+sBMvvAxQBfWxzR1O7hpE18Ixga3nNNZpqQJHGrnGZSADH9cqj57cvJyk6Sg94Bu6AvY5CY2k+P2jilN0wFfYFwTGSrPZ1atmjQRSQ9lQ3h2t9nDmameOSRe/Mi/9o3V2D2KokgSy+L9E51VIC9F15KhGDnUt9N
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 10:23:55.8481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c605dab-9089-49b9-072d-08d61fac58b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- None
Changes for v2:
- Incorporated Rob review comments.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 0000000..94b5203
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -0,0 +1,42 @@
+* NXP Flex Serial Peripheral Interface (FSPI)
+
+Required properties:
+  - compatible : Should be "nxp,lx2160a-fspi"
+  - reg :        First contains the register location and length,
+                 Second contains the memory mapping address and length
+  - reg-names :  Should contain the resource reg names:
+	         - fspi_base: configuration register address space
+                 - fspi_mmap: memory mapped address space
+  - interrupts : Should contain the interrupt for the device
+
+Optional properties:
+  - big-endian : See common-properties.txt.
+
+Required SPI slave node properties:
+  - reg :        There are two buses (A and B) with two chip selects each.
+                 This encodes to which bus and CS the flash is connected:
+                 - <0>: Bus A, CS 0
+                 - <1>: Bus A, CS 1
+                 - <2>: Bus B, CS 0
+                 - <3>: Bus B, CS 1
+
+Example showing the usage of two SPI NOR slave devices on bus A:
+
+fspi@0: flexspi@20c0000 {
+	compatible = "nxp,lx2160a-fspi";
+	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
+	reg-names = "fspi_base", "fspi_mmap";
+	interrupts = <0 25 0x4>; /* Level high type */
+	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names = "fspi_en", "fspi";
+
+	flash@0: mt35xu512aba@0 {
+		reg = <0>;
+		....
+	};
+
+	flash@1: mt35xu512aba@1 {
+		reg = <1>;
+		....
+	};
+};
-- 
2.7.4

