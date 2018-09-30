Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F0C64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090F7206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h13wgNZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090F7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbeI3KIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 06:08:39 -0400
Received: from mail-he1eur01on0050.outbound.protection.outlook.com ([104.47.0.50]:29776
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728043AbeI3KIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 06:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZc8kEs/xN8up2xsD6v+zPd87Erurq/S01UxOzmGzjM=;
 b=h13wgNZn7FOnsMBaJWt+c8CEhioapF9ywh+H/0zQdCTzy/XDczU+1zSKqG3XLEEJhfzyAvoDs35rGe43OsIYqQIYNmvS/LzcA7g+C5rjE4ouoB/w/Y3KfqvgTcuRWBClb1ejremGxcCDMgmog919rPfZz9nUgNgnHFJpinKYPCM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3909.eurprd04.prod.outlook.com (2603:10a6:209:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Sun, 30 Sep
 2018 03:37:16 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 3/3] ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support
Date:   Sun, 30 Sep 2018 11:32:28 +0800
Message-Id: <1538278348-7716-4-git-send-email-Anson.Huang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8c57d09-0ec3-486a-eab1-08d6268606e4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;3:hsDKMBSB9b9x+DpQ50Nw3V/eW60JSYD1oCo3Re5yphy0i6Hoic0CGWdzE0uaWiJf+N3JdxyBbVFow9KBGIeaV622qwRrjF45xsey3LDZ52/d3BD67I5UFmVXNYiNHHdRT5UXPNhltxNl7hxx/F1BdhH7kGTAxQh7auQxzSRUkeilLdK1s6L4YxqL29TAkAMqMC9LPF0BNqEsuBpQvP4qETC4wQqlDlPnHnxe9DZ5Jt4HBmrtNSDlxNOdXo5R3h1s;25:LeDGakjEeES57DDD7Q1TP0m/Myv64T/aey6NGKAlmKHNIi4Q/vLzPQ57ZgyEvZYWtZxAWVT/Kr7csy7OmSww2Bg/DzsPU7DYIMAKiRf2NXB4qz1+87ytRxvXSvRYISXDKwFrz29gQcfqfW4ejQ/p2f5fumljQj93uZoQ0O9ubx9J86NMDFd5i8E/NzAdZGcQhvf4FO5+DT8otgFbOaUj24DDlyoyv/8vY7GstPO5BArAlA0ucGtEAYHNAyCrwYMIcIHsSB2ktEx6m77tK3FpC61+lboNKB+JMZAMgiIgysWFw0U1rgOLPNIjXuG4kDrxp5mz9/rL71+UHTYORFhSuA==;31:A5MTVPLTckpTK7tcVZbDXvOXot7ZrVL+hdC+cdddCwKTD0WIgPGE/Wxnok8T47rVxGG93zuwuhZQ4SHdP+gABX4ein+3dN3YMqZJ6iwOooFKe0pqSycTozd8jEyZ9PguUQw4Ziy6CLwenRp9gfhv8NxHxyOluNZF6DrhybRPCTmRkIqx1SJqPTs0bqw+IDlw4vgmQZnc7QT4uz0KOFJeiNqlMI0Yzxz7/8zOdoimf6w=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;20:yv+gMiadUqlQSGXH1fO3pK3+L9hpJL/BlqYOGzlTQiwJ7lXbOZj6+H9BOqLfSHRbsp8J4lvUAYXqcLbuHK7WhhtpJybuX5JxV5dMr89noPuJQ2iEBo5aA3F0mdfGGeGHL518tcRbsPGUqg5hZKVitXLJ3VjqRNR9O866+9zvEBT13YzyU30n1dbRGYDX56AIF4Qg/R87bp8d7gTKg+dCPi5b5DO4lX5jX82fYzww7IORI/LJxwGxfG/tHw7Hp134cgaAQ9rDrOEKBSBZw2BmFWql+4F4ZVeXhcmefhJOGuXFrW/3dvQPqoIF+BFWADKXt7IG4URdrKpcFFClzLjkOoJ81Q2Wie0VZrqAt9QOHl9C91YfuGcopX+tq4W7y8qVtva+r6Q7nwhaMoueMJf7QbU8EV1r3U2X4hJhDyuk5lJbKQKRTNG8x1FsrW/pVV27RaUHLFCisDrXwX/VEMof3Z1yh4zbnyGvqCoojfl+0rcEczjo/pCHtE1jpcXpIXCe;4:NGmK5POGZK4/FORNOG2GXc2exIN8FvpIwUEBV7Iuud2NoqHTqHnxWLnzwa88Fh3z3XAy+H8lu8sIYkXCZhjreKAmx65elj3bAStK6AUwdB/2lTzlwnGLp82XtLgrGNBvcpXYzGQZJhOm6wAmHexrn5rn7NMFGWj87Sk72aWI9uBvUsAXH2XCC4QMa1Hp1Koa6+ucJCzuLw5YiacvaJzmisMYtVMRIeLYRRcVfZQK9aTrpvraIKpdXmTlotAGPdIVcETgVxydBQWAXOJIaUrjtSR22hKyg4fYZaoRBhGM28qs36dve/tYaYtGRZz8v0Yh
X-Microsoft-Antispam-PRVS: <AM6PR0402MB39090B041E9507A78C2BD56FF5EE0@AM6PR0402MB3909.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM6PR0402MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3909;
X-Forefront-PRVS: 08118EFC2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(86362001)(476003)(11346002)(446003)(186003)(26005)(2616005)(956004)(16526019)(81156014)(81166006)(105586002)(486006)(106356001)(50226002)(14444005)(34290500001)(76176011)(52116002)(25786009)(4326008)(8936002)(478600001)(51416003)(2906002)(66066001)(8676002)(305945005)(6486002)(16586007)(47776003)(97736004)(53936002)(68736007)(6116002)(3846002)(48376002)(6666003)(6506007)(386003)(5660300001)(6512007)(7736002)(316002)(36756003)(50466002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3909;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3909;23:bq56gOT50Sf8M7KpWv4XLKi0U1hCK+YEHY2Xvyv?=
 =?us-ascii?Q?FXUdpIrItSRFv6gP+0l7WwLN++feaz2gnbbH+QiXDU9mpIFqPo8ST6KHmnvj?=
 =?us-ascii?Q?zZ90q4xNz4Vn4c/8yBDhCov+WUUqhaSHpJFxs4CON7tt316KuZmf4AT3o3eD?=
 =?us-ascii?Q?bDt6v1JEuuyZZvbLr3Xp+n3l0sew40HqbtVf2b/OBLGr2R0n1FLrS1HbrOSb?=
 =?us-ascii?Q?6B30HQl3CuqP3QzZSQ50AaFVWZ5MNo1AZ9V1IVPAtonx0XVtdAtysvUG9Mjw?=
 =?us-ascii?Q?4V+4897DVy77T905xTErFsOC5aQrVLPMvZVWrsFU4r/q6e9KRWEBwuyJZYow?=
 =?us-ascii?Q?Laa6EgB0FfBW2VKl9eFs7ECqHZg26zfL7EyOorCjpWt/cuxeGWofR1sdgt8k?=
 =?us-ascii?Q?LoketPUq44Xdj6tDGRbqRLNQZzi8hjtJjE+Tj0+MExRkFp0+nG8HhBISi68f?=
 =?us-ascii?Q?ytJoAv1OVDRHfXo5h9rGDpYW4oQfPAC0mf0vf3hgYlBvWzvPu41+lF+Bx7Sp?=
 =?us-ascii?Q?W4Gob0RrYktcbMxmNbJG8IodOTvJA+iZI1xBhjNiHHyyFY0AayK/+GYOG794?=
 =?us-ascii?Q?j1H3H9TIcqhLKo/3XMJTWgYfKL5/nooJkw26uX35MGxev7gioYVg3eJrQVPT?=
 =?us-ascii?Q?6TrcdwDGi2xLdIXQaZ85WHZqFAeY3ws6v0a/WGJqx0TDZd5P4KG56+w1GO4l?=
 =?us-ascii?Q?zFUkc6+YbFSELCUNlYm4uYnPkPw1TE4as5aHlIWdb4EIPJvG2FeAeoKTy7nD?=
 =?us-ascii?Q?YsOYsET2eYn3Pb5gcKhQfuY79NMpjwXShqNyfm6wbANChSXYHeMayNNWztPk?=
 =?us-ascii?Q?uUiysITkK1l31BpT80bqVfOvV6ykzumi0YhhZ+4QvOVlx7AC1UveeWqWDOHO?=
 =?us-ascii?Q?xLnA4Vn2abHBEY92H06Dm/xG8TRLLsNjVzibk5auC0GS7NjerB0kkqPo5XYJ?=
 =?us-ascii?Q?dpro2yV2j/jA6YTXfLvWuW/jnao8Z8fqgjn7xV3e03lWWG47+I4gaJQP0pil?=
 =?us-ascii?Q?rBHn77H1wu9iN8Iz4F4/yRDYKGW0As8QpEhFZNK/q9QLiUrV/YvsbAJS/+YA?=
 =?us-ascii?Q?YnrOiCTKxeX2kIMna2TSSTxh6KbyQJubApOPFJTv1dIBHpsmfxaKP+Z+oqaH?=
 =?us-ascii?Q?DOVaAE1PF0a4OnZxjT/NxnxW9SRI7stRZG3E3Muae1hwonjWroVkXjZV/AFB?=
 =?us-ascii?Q?e8TmraKKATzitBKvJxYgaAxJXhHzwyFi0ENGavsC7WnzspEP/xQIb0oh+Iw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0XUb/Cdovr6m2L+InxeGIgqK0gVpXdqPxdFszhmkIDM7Btt74J5rP1R5ecpe4akrevfRaXdvZyMr+s7i3K8A2uJv1eYeW+rr/ROq01we0GfaHOlUJMP0ZHIAeACxHhAb1ITjmxsVW15BquioaNZONyi2k4n6tiZW+lYvQJ3j1gfIJQRuPzevEpisKHfiyuSMx5s7s6+FCDRir11SS+jIvFpNwcHF71WPENSkyn1rTVLRSRyq2+7stquH6UsxbgQAVbo0Y832/Km+ToKTedRXnAHb1goCJA89+qaG5khomDreAL2IjisWYnLw+CeWmjRLVG8lboXQSCK8dCxspeiINepU6DamR8XVTwO4+UGssDg=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;6:0DOs486Gv4CfPLmFvAiMSygpKq3KnaK8gY2OBLHjVpVk8vZFqgwdVNoFsHDTMGmiBD+FVsvi+1P3xB0o2/5ZoGciHeYophv0YMfE8u2xy1zbZhftl4U9JLXNjg3rNlVuh9/6IZIb7ZUE5oN1/608RyILC1904ErnGZfAsaBVMeLm5oT2bbpMUppHIMIRoZ63QsmDw8M6reh8wJcKbN37Sdro3AENqHpf2XP7IRGU+TkZS8CKnTJH2L5/Yg5UBcfrzgpQyxamz23Oo1g6xZV0OGi9wahPRspT3fAyXYFwzR+LPZ7CLI3xsZnv0l+o/vKi1mZDFzwgWTuI97s5THHek2maPmKyw1N92B2UjhZ/igaSa89KuFs24JTvFoeD/MoryMeBun2Zh37RnJm0qsDM7PKPx0MLyjoSYvUyVYAFKFP11q9qokAnD8cYVDxuliUsvYzHOrn+R3H15vDWruzCNA==;5:5Nyfd/mG12nkWKT6PuzdKljbTK/U2kHEs5IO3/x2o0KCo4tyrItTvF1XHeyxRLMfL4b5oWdqXRazd6FMIwuUtlplKU2mrJp+YBynbaxVvnZBdPD2iUEn0hQPJgp+gLabXHNHNM0HS73a3EwZ/1dAaysDkB5uKQn9/x+ndki3cXk=;7:gzYGRBOpIUMtNRH4k+oHOmcHvYFtJaT9Gp4yqPXI4t80pB3RtjGaZDTpvZfKqhWjsIJ2U3io/PcE+AJqQvQBBnOQcoQhtyY5j3b3w6xjuWHxwmh/UDW6elybHITAHUA8yVNgtwl01MGof3FsschWI7d0Dcc/3+Pi0dnx1605fEhrUE72Agc4p9r69A5h+VLbywi54mC1PRoVKiUFHBM/Q0MPIflFyRil3Msy9KfhzWnT//cpy0ihcZNueilWqFTC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2018 03:37:16.4805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c57d09-0ec3-486a-eab1-08d6268606e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULZ is new SoC of i.MX6 family, compared to i.MX6ULL,
it removes below modules:

- UART5/UART6/UART7/UART8;
- PWM5/PWM6/PWM7/PWM8;
- eCSPI3/eCSPI4;
- CAN1/CAN2;
- FEC1/FEC2;
- I2C3/I2C4;
- EPIT2;
- LCDIF;
- GPT2;
- ADC1;
- TSC;

This patch adds support for i.MX6ULZ and i.MX6ULZ 14x14 EVK
board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	Add "fsl,imx6ull" to DT compatible.
 arch/arm/boot/dts/Makefile              |  3 ++-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts | 20 +++++++++++++++++
 arch/arm/boot/dts/imx6ulz.dtsi          | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b3ec70d..d7268ae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -560,7 +560,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-mainboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
-	imx6ull-colibri-wifi-eval-v3.dtb
+	imx6ull-colibri-wifi-eval-v3.dtb \
+	imx6ulz-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ulz-14x14-evk.dts b/arch/arm/boot/dts/imx6ulz-14x14-evk.dts
new file mode 100644
index 0000000..6f1af24
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz-14x14-evk.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2018 NXP.
+
+/dts-v1/;
+
+#include "imx6ulz.dtsi"
+#include "imx6ul-14x14-evk.dtsi"
+
+/delete-node/ &fec1;
+/delete-node/ &fec2;
+/delete-node/ &lcdif;
+/delete-node/ &tsc;
+
+/ {
+	model = "Freescale i.MX6 ULZ 14x14 EVK Board";
+	compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ull", "fsl,imx6ulz";
+
+	/delete-node/ panel;
+};
diff --git a/arch/arm/boot/dts/imx6ulz.dtsi b/arch/arm/boot/dts/imx6ulz.dtsi
new file mode 100644
index 0000000..ae6d7e5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2018 NXP.
+
+#include "imx6ull.dtsi"
+
+/ {
+	aliases {
+		/delete-property/ ethernet0;
+		/delete-property/ ethernet1;
+		/delete-property/ i2c2;
+		/delete-property/ i2c3;
+		/delete-property/ serial4;
+		/delete-property/ serial5;
+		/delete-property/ serial6;
+		/delete-property/ serial7;
+		/delete-property/ spi2;
+		/delete-property/ spi3;
+	};
+};
+
+/delete-node/ &adc1;
+/delete-node/ &can1;
+/delete-node/ &can2;
+/delete-node/ &ecspi3;
+/delete-node/ &ecspi4;
+/delete-node/ &epit2;
+/delete-node/ &gpt2;
+/delete-node/ &i2c3;
+/delete-node/ &i2c4;
+/delete-node/ &pwm5;
+/delete-node/ &pwm6;
+/delete-node/ &pwm7;
+/delete-node/ &pwm8;
+/delete-node/ &uart5;
+/delete-node/ &uart6;
+/delete-node/ &uart7;
+/delete-node/ &uart8;
-- 
2.7.4

