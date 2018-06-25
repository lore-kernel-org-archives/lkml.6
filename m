Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6AEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08837260B9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BfGYjNgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08837260B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934740AbeFYUJz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:09:55 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:44992
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755690AbeFYUJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HosYnijvkehpP7huvmYZm4OIwrhZAMYB2DoV/RKqEpQ=;
 b=BfGYjNggcBqauQ995XIbdJ/iQyntCJytxPOhGPJBj45gWzCpw78qg2Tfyw/E7g1ZvO05hF/gosrzcw8tRJquPh1p2HwxO38koOs3/b5CZ54QsmalQnOajDyGVS0t348udmG0fbaPVaQ1A5+ywyJv4mk83DwogBAVDfSEhD+uYGk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Mon, 25 Jun 2018 20:09:47 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx: Add missing chosen/stdout-path
Date:   Mon, 25 Jun 2018 23:09:32 +0300
Message-Id: <75f7fb96d53404152e742d405e2a14c5aa0f4438.1529957171.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM6P193CA0018.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::31) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f5eec22-80ec-4d7b-2d5f-08d5dad79a2c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;3:y49o77NBkiACgoytoYtWEJEW/u0Z+A4AE26ViDzZotGtBZ8hlJ3bwesPMjGUgeobow3YkuPSgMxd3kkBY2waC93/1xdZ7jAhq/zjW24Z25hTrXhY9tVJVKg7bhANKWKqvy/wZrGSvN5kwVCbDpIZfXM5Jtl87ZxIzm+PqjZXSTYP7SKmw+45caFgF+ypF1JJwYi2kJ1H2oaZTUiO5jZeEl+eBInNCa9o2oRBYlsi6cJMUUsJtp+wHPSGe/6tcewE;25:U1EmN7j2RfshSr3m/gULIjVGMyg473S5b69bsD2AxVsevMwniO5nM1dYLspXpVsx05jzSsyIsJRKJ0tbOsevYF2moZNKjbDAcM2KIzkhyM1TtDNdfINEOtfUXFhzAjYxKVwcpugcaTNB+g50ErLJF3iDxNUKMmmtxOz62uV314d5VF01iaht5RZudRTFkKxt/5dASYOGQBjB1hvDwaY3eAe/108EODEI8lkv2z+grHJ/7PoOF9GT07EqhWWd+dcpiB8fGzM8XCodoF79VotFyydzg+a0jMNU6+IhuuGKmx96e2XFPdVRalJPHaAVHl2F3PpPt87rURX8ZG/zBvpehg==;31:oaZn/ScPUqe44O0A4oBzuSsxcgZkqNz0AZAS5hz/3JA13p6TA9bcjNa3es+nzg9yTR1djgfqnx1BI3VibLF5sLERM/4Q7RqbYPvBP/Rp1LJf5i2NGcsr+Ug1sjRs40E597zSIfmBxZk0vvWS2eSi36/z4uzQw9XqoMxDIASTBvj9xw0NTJr0A7A5/WIUbzb+gbSTAk3AJGmogzFxv18B7blPXo+4tnPqIVJm0SXbrYQ=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4290:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;20:2O3cct1BvJreBkdPKknjR/LavtY21FzKAoFIlA/+lNJSLxvwA+8O77Y6BRB7InUzcQb/ocYQ+9ItbiniEVnrSVQG8Z4Jep51KU21C/n9AWSBTtvKpzW/16pQrD0tujMC1Rb2v/HXNvPHrrAeVdvwJHIuEdVn1ONekQIXd3S72TfZ5P61LBhLbDUT1jhuBDbP/wL4e8aTppU4v0d0fq2iwZDLEhkU6L/XMFHrtP1i5VuCHL1s2pMUB9a1pWoZauubKWqSUHfm+QbFWTEWWALHLIMNz5KXhxhMQ5oU49FcltgEm9WMJfzDXthB4LrUnplh+r/IxOZznVwKgMkslLHAskmqnlZ0h6Io+uBv5+HKJ0/hYOn9FfZmfPAa4uqTy72+4IEOXg/UxWPRdnkSe9A6MF7joCdmTFNAi75CwQrNCrKCAVa4lB2PZc4+67mUG2rO2izYVz43KC21iJk15e2OQJTWdZApRtrWuB8BHgRQ+sxu4fsXzJsKFEUwKlZUXHkS;4:Y+MQQSEkX96xA5XQAJ70ID6Cv5Zu0kb5V0cvtqjwKe7TcxHVYZ4qa4bbQCIKHZO06t23ClCJU+7yK0p3tb5w6g1q5KGVU/C/5wteemZuV3jzyn7u0ympAmmKHbEVptusG8dIe1U+C7+IaLuF7dnvKqmgSwlpNRBNBbhkmwJsYtDfCIcoYxZrXFz6pqIXoV1u6pDfH3gZptqSkuW7zBOa7X/E4Eo1AvufWiBmMDohC5pByQKpLsKV/RY9xJkHV19bLYSl64fnNNCtsjBlJowrB9r9SwwLzqe8KYlAETaY+HLTeKT55aqDBtGUrkQfKPyS
X-Microsoft-Antispam-PRVS: <AM0PR04MB4290DFBF62FE9D885C71F806EE4A0@AM0PR04MB4290.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4290;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4290;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(86362001)(6512007)(47776003)(97736004)(8936002)(81166006)(53936002)(81156014)(118296001)(26005)(3846002)(36756003)(25786009)(5660300001)(2906002)(6116002)(575784001)(478600001)(50226002)(6636002)(110136005)(486006)(54906003)(105586002)(106356001)(6666003)(2616005)(476003)(44832011)(186003)(16526019)(50466002)(305945005)(1857600001)(956004)(7736002)(51416003)(48376002)(8676002)(68736007)(6486002)(52116002)(386003)(66066001)(316002)(6506007)(16586007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:ySWrOZEYQVgZnNI/9UcLfMgzGUjbP67F9IbcMJq3N?=
 =?us-ascii?Q?BZauQcHNQnUqTvjxh5/8epHsQOQ2bI1ShXuCzn/zlGL0G+tEOD1Ee2J0sXRR?=
 =?us-ascii?Q?93967+zSsgzM8GM2DuCVJu+ZaMOssw2TydRwxtuTAuRkHg4YtuNXgjP6iBCw?=
 =?us-ascii?Q?IMBwSpmuEnCzbyCaT1ZbbCEcWIzYPou4AmvqnhmqCQ+yvbek45ZlqFb836zo?=
 =?us-ascii?Q?o626ocyw6YcU2xCWEAIoMO1Qz63VZuJJ2E+wJK7Jh1KDQ+1OjIuJyBaPvqBj?=
 =?us-ascii?Q?koFW8ndUwORDXawV6BWIBtiT2T/OfCJQKJRw31aBhtCTCQPnCBoWtXVjiJRJ?=
 =?us-ascii?Q?OuaqAjdKfbXv0sDOsTcbxZl/gR323M5wcmjJ4iQFx8GixAyRWvEurq393c01?=
 =?us-ascii?Q?pXOnjRdExsnlKhNvZOnlhPxvF5MK8fumpqtO5HGi6/GI+3Slw/FKp2I74GTD?=
 =?us-ascii?Q?ecO38kysptR+5neXsMdjQNtzP9nJ7AvhFy/yBlFp96osAH0Q9uHFxG3ioeMu?=
 =?us-ascii?Q?omx50qYYqTHIpDSfUrtYEmjieQirlggIjyQtkJM84V5qBmCYr6XVj/DhH6mj?=
 =?us-ascii?Q?fonZpVtva5DK0Z187Q6riKD/GHORX0BSoeTNU4fXQ77lFi7h469HCkMsHamf?=
 =?us-ascii?Q?a8NVTaX6CGJmwS/mWXU1LA1tTqUTzIoj7S7Vlvi1hMg0ZiKLHm4HUZkO8Ev2?=
 =?us-ascii?Q?XiIfXl1VM47l739484Tuj0k0wDxRvHrQgqe/rLqcOIN9FdkP8GSNp8SGEIHY?=
 =?us-ascii?Q?aQVEQOc1nXHYy3Br74oAFmyteQkj18XV978lPKiKUb1rJGvIM4czusmDPdvV?=
 =?us-ascii?Q?SuTy7Q8SMiAIZBP38jAhWCgfjYr+X/CGfvFD05qVko5qm4OCMJAnc/ysnzwJ?=
 =?us-ascii?Q?s5IuD6lIAfhtU8/rkKLBhVfmw9/x6zoYYHMi6Woh0KOMkPyWd8VwPeZCl+mW?=
 =?us-ascii?Q?gumjLUKdPxea1IPYLdbmFSvwjxxQdx4PErJfOa5FztRAbPhh49hUTUnNHRWK?=
 =?us-ascii?Q?G9cRYn9IYwXOwB8AX9s5MG+2TKC69HgFa6swYO/rDtCfEagXOBulHoyy1xmD?=
 =?us-ascii?Q?+1wRCqjQL77EslZIiKJcTax8wUW97HLFLQH1q5eI8tamdCzqYc+W+rHt+vsl?=
 =?us-ascii?Q?2KFvNmxt97qKh7B6WVM4AuJaM3ctalfytE8UuoHqrOHvJ9uD0iHXlm9zQyUd?=
 =?us-ascii?Q?NuXKAMiOLqePubiOZyULyr8Axo9DnAnmI1Pfqnk99OJH1RqvCS2p3Ah4ANfw?=
 =?us-ascii?Q?25/NbdZhPURnYn3Yc1+4tfNz6E8qXFdelwhmtZg?=
X-Microsoft-Antispam-Message-Info: 7AfBqGtjrSMr+Nx9+GN4qzBVeNyBqzcKwvdZNcdzT7/cYcL9M8Or9mgrm3eVqTrdRPdLfI4zuu4eWNHZqMgP8jtZZjbm1buW5fooVxsiZL/TXZj4JYcXFpD3wgk0oqyuW7opzKhX06aG2KZSowd+pe9gIZ9PL5AavN5VNQTxAs4QQDKJGUy374YBDrmV3wZIPtHyux+N6Uid6YyCiTcrOIQdKzqu8HjnbYytk84DXHblUuZKcVBAFQosEbRPqOERvN4u5iQofMaN66p5fdgrJlWPBj5PWScChj3MCYeHHm8nZkz/1gL6K06/KD2bgLl1SnY8fKejOV7h/Wh1wRPBK+BCkpQQF3aYCfdU+N7YgkU=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;6:w6YkFRPIqM1kGPlwwAs4RRBfT45PQn2T1A+pTfxeFjILmAa1nuoF443mREezxS74S4KYnAke5WuyyGjBfLqZdlIsp9iDD93JbfSBcwlIeY/33yuCSZNZnmr7FM0P1B0iNgWPq8Jc3OD5ERNeZ3WVr8KCttOO+JZUkJ4d2K3SP8niHYnFekwsh6qdj4p19AQ3frN9BvS7hHegin9aUW9lRqjNSkc0QDc8pDZIhJUXHA7g6V77c+EXjJ+UZrDigrCvDFDbROSIY13qHOdng4yTMZW7c+nLJegF9T3WINmyixm8ss4UvFpGMM0jee0J/XcKIuEncWGBqk7fOc5TY1/FJtk3lQh70rfp/k4OXnvDmkr0CB7epN/xJtRsIEvPo/YNia78+YNRb8AyMO7kFYIVlAd0rC5vvwIue1dq7wUSGTZSLapI49ZyYSOBX4W5YpceQEfcz45sLz60zzLaxhezlg==;5:KwfiocIGAMS2fMU9tSn7jFfqeFeZ83KwCFFxdKZSt8Qh/xBVTh2r//IpSKMemtLWeI9GHVjGvtNmLKDO407ClIRe8koof9fI356G67U0StA09YzavnqaasUIVimmTRE7NhYj8Bf5jxYywQZBddP4B4tojVUYNY1f263ZatmliEk=;24:fiCswewFi4o9yLFU4HZbGk1dsgaR/KBT2QlkICK/CC3oqINhMnGN8Zrz7dV9eksgnN1NFnpw4D3mobRkBhYxZ/tPhIPJ13ChSNBJhHa6bN4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4290;7:krRjYCBG8r385Dx4w+vUbVBXRS9+Xk3qtODLsE5GRzwArRMrLoOa0qxDaP8CnQFmOqHUXjGwpdDdbSLGDDhas2n11APn+Fy69xDtRMm/2X55lDaU0DZrK1iS9o284VQE2ElJ2p/v5pN7dFnbcZbPkf5+krWKaQwWDXrsQBIuZzsydQWJnwg6xJvQ8mF1nSDsdk4UJY4/VtIQU8TYSPXaTfoo0Ymgmjf/NEZ6GGJG3sY5vRwkN26XfBGCLXKcUQEw
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 20:09:47.7510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5eec22-80ec-4d7b-2d5f-08d5dad79a2c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to enable earlycon for debugging by just passing
an empty "earlycon" argument on the kernel command-line.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
 arch/arm/boot/dts/imx6sl-evk.dts         | 4 ++++
 arch/arm/boot/dts/imx6sll-evk.dts        | 4 ++++
 arch/arm/boot/dts/imx7d-sdb.dts          | 4 ++++
 4 files changed, 16 insertions(+)

This patch adds stdout-path to some of the basic imx6 evaluation boards
which were missing this property.

Patch against shawnguo/imx/dt because it also touches the newly-added
imx6sll-evk.

Let me know if you want me to split this instead.

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index a59a0fd1eb02..9f11f1fcc3e6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -4,10 +4,14 @@
 // Copyright 2011 Linaro Ltd.
 
 #include <dt-bindings/gpio/gpio.h>
 
 / {
+	chosen {
+		stdout-path = &uart4;
+	};
+
 	memory@10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 92ad01f676e3..50bdc65670a3 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -10,10 +10,14 @@
 
 / {
 	model = "Freescale i.MX6 SoloLite EVK Board";
 	compatible = "fsl,imx6sl-evk", "fsl,imx6sl";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
 	backlight_display: backlight_display {
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 4684ac4a816b..25438ea03092 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -13,10 +13,14 @@
 
 / {
 	model = "Freescale i.MX6SLL EVK Board";
 	compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory@80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
 	backlight {
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 9f9e6a1e3b72..fe61218eec6f 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -8,10 +8,14 @@
 
 / {
 	model = "Freescale i.MX7 SabreSD Board";
 	compatible = "fsl,imx7d-sdb", "fsl,imx7d";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory@80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
 	gpio-keys {
-- 
2.17.1

