Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164595AbeCBD4Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:56:16 -0500
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:63072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163864AbeCBDzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:55:48 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <leonard.crestez@nxp.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux@armlinux.org.uk>
CC: <Linux-imx@nxp.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V6 2/2] thermal: imx: add i.MX7 thermal sensor support
Date: Fri, 2 Mar 2018 09:59:30 +0800
Message-ID: <1519955970-11365-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519955970-11365-1-git-send-email-Anson.Huang@nxp.com>
References: <1519955970-11365-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131644365446981783;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(6666003)(2950100002)(4326008)(305945005)(110136005)(54906003)(77096007)(450100002)(5660300001)(50466002)(47776003)(97736004)(2870700001)(105606002)(316002)(68736007)(2906002)(86362001)(72206003)(2201001)(26826003)(508600001)(53936002)(26005)(76176011)(8936002)(8676002)(81156014)(85426001)(81166006)(336012)(50226002)(106466001)(59450400001)(107886003)(5820100001)(36756003)(104016004)(23676004)(356003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB479;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD031;1:KK+GwY0n9bTJ3/bjILiCPSJYNi2ifYHRcMdP+PGpH1K3+GvlQTOaq3hExAHyaIEKnX9za6QYVE9fZDX34aH6UjHf/ao2Ug0soE6/OQWJ2NM92X6/X5jnKWTVvC0H3fNx
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 346bbf7c-ef5a-4b2a-5acd-08d57ff17985
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:DM2PR03MB479;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB479;3:OOWcr/gYZx/+ujCQSFyYBqp5sWI95BoXFrAIHxKvkYaKUwtcdWipIk8GH3G7c6BfR9Ph0Q06Vxnc+QriDEabk/ajgRBcjB6HW19JU9ptwqgRLH0lWV5TkzDJLhf5egpjzrVp6tFXrhYTyANMWMxWENb5PLgS/fuiQEgt7UVcLC8UeuNBLE4/JgtLOO4xnE9KGvmkeygl7LQ240+ctDzHu2OM5uCELLns89yPJBKhRLf5Po02G5HHcakSG8v/imOhc3MQzOcV0DHxAzfsFq0tZkok2JOrh9TVCJFXCSOxOEjIUcqNFi/XErt093Ku6eyJDCGbPO80ITWvOh2g2QftStdyuQiEdxYy+L67Iv329zg=;25:7BhLndsV08WyAwW6808VCzmUCNqwgvdEC79SwpiLvFQUGJ8q5PmsFydPqIdHvlE9rmwHuJLGCUTgSZz/UMsjcOtP1xZs8OoclovV3VhMIomul/rNxLx8bC7amndmbWcMCP6d2axgDbJftViS2JSHrhJCY+RUVtkATqzJfs81H4xCaO/gSJsOIuW9TPrmD7oI5yfYcHnrxLEi/Nn0wAtsdoZBPZdtwSxx7cuNAbdQPmkvF+OYjSqJifMfWBp8/YQArq57/jPdYJXVb4l8EcIkZFHGS9WLaTWPduYdULeNtX8SLNOAjnWD/4kU7KRcVuArovSj15bQxmhXHvYk8DPPuA==
X-MS-TrafficTypeDiagnostic: DM2PR03MB479:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB479;31:77fFEsAYhYcGkcH2PwFf1Me4J+ZhLjsQ/ftfOFrmfKJKHRCwPDaxZce3qQCVrhEiYEH61WbHz6p87Hc7z7f3Hwa57qtJS42Etl+SaSTfPOfyRipKARd7TmOegECpwJYLHkUBf6KSU8YeTD6rPlX0ALrhd49iR9gD1i2a587nJYSmXobnyvwZ+ZBot44P4kwGwDDueedwBBkWf57OuZYu2mrSmvZPdcpQNOj4CtmRYB8=;4:NIhXwC3gFxh9ZrjmoyeBBXbK4y43Wadm1QO7XOTSbVxx0qRO/9hEaS3YkEOfg2S5hSPVfCqyjhlDRpShmXgouqIyXyUV8BeIAcSl4rt1ZbpqYpQPTs7X6dnyVxXEgO5dnR02Zr2W8J8ZGU8V4L7eyPt2KRXTBncFLIGCNntXPtdEjSZVLF/PWtPLU8lYM3S9JuklmqBtFiZ6viRPHrXc719croCbHLrIxTAfVPzODzIB2TZygavxwVXstLVqDbU/I2ljumVkG05P/vM3rKTY8zl53sR8/F8SX3qYoJ0uZEBW+C8TIw/9yhbv7Cyp5BJI
X-Microsoft-Antispam-PRVS: <DM2PR03MB4794AED53FA75B44A59EB1FF5C50@DM2PR03MB479.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501224)(52105095)(6055026)(6096035)(20161123559100)(20161123565025)(201703131430075)(201703131433075)(201703131441075)(201703131448075)(20161123556025)(20161123561025)(20161123563025)(201708071742011);SRVR:DM2PR03MB479;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR03MB479;
X-Forefront-PRVS: 05991796DF
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAzTUI0Nzk7MjM6Y0puMHNBM00yVzRvMnJPZjNRQUdGMzYzY1BT?=
 =?utf-8?B?UGtham1ZbEVCZzNKcUFLUFBFbXY4TEN4Y3MvblA4cDVtTGpRL0NFSzEvOWZO?=
 =?utf-8?B?anJLVnBYM3RoUDhkY3RRSFdXN3ZxWTFrakxhOUZTM21saTVxdVJSR2I3TldN?=
 =?utf-8?B?YWw1K2RQVmhFbHZNekF3dm5nbDNwRzY3R0ppcVJLVE1hMmovdFJHTExzeHlu?=
 =?utf-8?B?TURURk12eHJvMTN1NlhVc1FqbEVYTE5LZXoyQ0NJRGNHN2JqcXhvcXZ4RndK?=
 =?utf-8?B?YUpIcTBNL3c4alF5Qzg3ZU5CcjVGMGR2bUU5OWdNdldRb3gvUWNrRUk4Zk9X?=
 =?utf-8?B?VGc4Y2trVG1PRUdkd2QrTy9qU2xJTk9BamV2VXY3QzlTM0kzRVNZejFMcnlp?=
 =?utf-8?B?Z3UvbitEZy82OFMybHhDWm1BQk9xUTZpUWFLc2x6Q1pnQlJXY0xmb0gxbGRH?=
 =?utf-8?B?U2xvSFdaZWJBeC82ZFBpcGFxd0xWemZhb3pzcXVpMXgzSThjZ0JoQUFQUGEr?=
 =?utf-8?B?bXNaMHJBby92dFg2Yjgxc1hheCtvOW9xeGt6R3FkeHZwSjJyWldXZWw3Rks4?=
 =?utf-8?B?N1lIQ0RjWVJjSktvK1pQTEhrMGtGVzVxVzBPWFVIdFU4Z3c3TG5salRPMHRT?=
 =?utf-8?B?UmxkVEEyay9LUysvb3h4ZGkxMmNNZ3VQSWVZUDY2cUxER0dmRmg4a0dxbHg1?=
 =?utf-8?B?MVpKN0pVNXBtdTlUdUFFRVJBQzVWYVRORmNWMktNK01NdGtTQkxoQkVFOGl6?=
 =?utf-8?B?N2JiK3UycU9xZDdWK1dnY0Z0WWxPTDdFQjhIVTNpTVE5Qlo0cnhXV0tSQXBi?=
 =?utf-8?B?Y2Mzb3JjMllCOU1XVy9IbnRjT09RYm03QmRPcWhaeThnSmpLZXBEM3NicmhE?=
 =?utf-8?B?NXYxMUFvNXAxMWRFbXNOalIwb0x6RzhZdWdBZTdBM08xTzRnOThWSWtmZzJ1?=
 =?utf-8?B?MytoMTJJdjNIaUl3cHFmVDhsRUx0VnVVS093blR1WFZRdjlxUnNiVmdCUXlz?=
 =?utf-8?B?SUlkbVFRaHBuYytVcnp4OG5wbmtqOW83akpxd3d5K2tPTGZHWTlvSDNzenNx?=
 =?utf-8?B?QVBKVlkxb0I1T28xY2U5Y2tVTWpUUFJ3QXphUjNZQnF5eC81SEdVdUVFRUJM?=
 =?utf-8?B?dzNaRjBJWTBsQ1Nha2RkcDVhZTRyQUE1b3B0RTRBdjNmbi9RWEcySXhoU2ZD?=
 =?utf-8?B?cFp3OEJBODJFZHlTVVkzSmFHa0VodlpnQ01XODZDK0xsdTUvQzRzMTVzSnVM?=
 =?utf-8?B?S20rdG9YdVRuYUFEUitWKzIrR2xxeUZqN3BrZXE2aFFML0dBenFSK3JMWS9a?=
 =?utf-8?B?aUhFTFl5VEcxT3ZKRFl1VGd4ejNKL1Jub2lOQ1JkRytGcHk5dXhCSXhIYWtR?=
 =?utf-8?B?bVdmekthWDdxVEV4Yi9CeVd3dy9yRjFSMWQ1KzYyYzFvOFdwQ0xVZVhlYnIy?=
 =?utf-8?B?c2MzUllNVWRSclJBWHdrMnY0dGhnNzdPTEpJQWZJOEhQTW5iN3h5U0tUamlO?=
 =?utf-8?B?NE1rTS9oK2FPV3htbnZRT0htRUhDK2hzaENRNWVhZ01oaWRlS0RveE13QzVz?=
 =?utf-8?B?MklMbXo0blZYenMzYktWUVFzc3pPVGhCU3JyQTVkVlFVRmFxUmQvbks3QUJL?=
 =?utf-8?B?OGdnaTdPaUxLSFdsUWw0dDZFbUp1Tit1L2RteGdtdFdYaW01SHU2Rnc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB479;6:NeRiTOMgJTog1N7HtLAie8rQCHzcTyBTtoYzDLsndA1XIhqkN2s5T2iCygHwuUs/3Sw99JqqA16ou2BzXe5u+/O3IKaItsPU5HQAE5k7o4k4vHYribQKrNTdWutO1+QihIWv0rkRjxP137Q7InwDbh+5PZIzZWwkHMpLhjraglKjQYTX+sCf3bqi4pblAl/gMJmxwUNgHJO0LZHkzvA8BG/+Nrff/00jN7VrRCglEHRnjmdanYflQndgw8CXuJbWxXwIY1qGqn4j/Tdk+PJPpTNcSVehrP3yNAHLOD14kMynPOfSzAvt40tvWSxe738rN/3skjY1Hj88ghRP+JvEuInrlHchH/4FDAkDPy8Fdu4=;5:K1bn0fwrWFFPVfDxyojYTVAB0unkEM/IbiDyn9wXqP3qZg2soHRhc/UIn1ew+s1GJYOVQvfemuq8dDEhXqxSsMdUyRZyjZ4ZGxuKE2csxBCd+bq2oHBUB4gcsaUD4muk1sjj+o5q7fXCESXxfArzlj2d3ZzcCsVRLoi1A3ZZ3tg=;24:SpofhHa3ENVtLYpKeoKblEAxxrSMkX784sjYatrQigpNsG5oyzOkHCcg9wLlPzYLHbEhJ9B8W3XDeDf822oFBbN7on1L/eY87v4oZxFhx+I=;7:ppqQO8ltIsTugMZYUAUHc66oFH5d3PQhJVY5M3ce3fsSDfZk3oL7sUC9NM2L9Dj7OhASUDn4EsyQetrYkxDcCYEXiXykRgetbOthImVM3zsJlIwX5rfy7JJkEyGTfvzlTW5/83O9L7aP/rxibIb7VQzOd7ebECcPQwL5OPw0mIJiSjAj2bMvkATS1+JVBU4t2b9kVJ4BtRE0e94OLDz8qxvULG8P28OC2Jxdeq1UiTNxkwcsG6LGpFVl0heuVKya
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 03:55:44.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 346bbf7c-ef5a-4b2a-5acd-08d57ff17985
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB479
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds i.MX7 thermal sensor support, most
of the i.MX7 thermal sensor functions are same with
i.MX6 except the registers offset/layout, so we move
those registers offset/layout definitions to soc data
structure.

i.MX7 uses single calibration data @25C, the calibration
data is located at OCOTP offset 0x4F0, bit[17:9], the
formula is as below:

Tmeas = (Nmeas - n1) + 25; n1 is the fuse value for 25C.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Bai Ping <ping.bai@nxp.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes since V5:
	no code change, just add Reviewed-by.
 .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
 drivers/thermal/imx_thermal.c                      | 295 ++++++++++++++++-----
 2 files changed, 239 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
index 28be51a..38bffcc 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
@@ -1,8 +1,13 @@
 * Temperature Monitor (TEMPMON) on Freescale i.MX SoCs
 
 Required properties:
-- compatible : "fsl,imx6q-tempmon" for i.MX6Q, "fsl,imx6sx-tempmon" for i.MX6SX.
-  i.MX6SX has two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
+- compatible : must be one of following:
+  - "fsl,imx6q-tempmon" for i.MX6Q,
+  - "fsl,imx6sx-tempmon" for i.MX6SX,
+  - "fsl,imx7d-tempmon" for i.MX7S/D.
+- interrupts : the interrupt output of the controller:
+  i.MX6Q has one IRQ which will be triggered when temperature is higher than high threshold,
+  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
   when temperature is below than low threshold, IRQ_LOW will be triggered, when temperature
   is higher than panic threshold, system will auto reboot by SRC module.
 - fsl,tempmon : phandle pointer to system controller that contains TEMPMON
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a67781b..569d41b 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -31,35 +31,57 @@
 #define REG_CLR		0x8
 #define REG_TOG		0xc
 
-#define MISC0				0x0150
-#define MISC0_REFTOP_SELBIASOFF		(1 << 3)
-#define MISC1				0x0160
-#define MISC1_IRQ_TEMPHIGH		(1 << 29)
+/* i.MX6 specific */
+#define IMX6_MISC0				0x0150
+#define IMX6_MISC0_REFTOP_SELBIASOFF		(1 << 3)
+#define IMX6_MISC1				0x0160
+#define IMX6_MISC1_IRQ_TEMPHIGH			(1 << 29)
 /* Below LOW and PANIC bits are only for TEMPMON_IMX6SX */
-#define MISC1_IRQ_TEMPLOW		(1 << 28)
-#define MISC1_IRQ_TEMPPANIC		(1 << 27)
-
-#define TEMPSENSE0			0x0180
-#define TEMPSENSE0_ALARM_VALUE_SHIFT	20
-#define TEMPSENSE0_ALARM_VALUE_MASK	(0xfff << TEMPSENSE0_ALARM_VALUE_SHIFT)
-#define TEMPSENSE0_TEMP_CNT_SHIFT	8
-#define TEMPSENSE0_TEMP_CNT_MASK	(0xfff << TEMPSENSE0_TEMP_CNT_SHIFT)
-#define TEMPSENSE0_FINISHED		(1 << 2)
-#define TEMPSENSE0_MEASURE_TEMP		(1 << 1)
-#define TEMPSENSE0_POWER_DOWN		(1 << 0)
-
-#define TEMPSENSE1			0x0190
-#define TEMPSENSE1_MEASURE_FREQ		0xffff
-/* Below TEMPSENSE2 is only for TEMPMON_IMX6SX */
-#define TEMPSENSE2			0x0290
-#define TEMPSENSE2_LOW_VALUE_SHIFT	0
-#define TEMPSENSE2_LOW_VALUE_MASK	0xfff
-#define TEMPSENSE2_PANIC_VALUE_SHIFT	16
-#define TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
+#define IMX6_MISC1_IRQ_TEMPLOW			(1 << 28)
+#define IMX6_MISC1_IRQ_TEMPPANIC		(1 << 27)
+
+#define IMX6_TEMPSENSE0				0x0180
+#define IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT	20
+#define IMX6_TEMPSENSE0_ALARM_VALUE_MASK	(0xfff << 20)
+#define IMX6_TEMPSENSE0_TEMP_CNT_SHIFT		8
+#define IMX6_TEMPSENSE0_TEMP_CNT_MASK		(0xfff << 8)
+#define IMX6_TEMPSENSE0_FINISHED		(1 << 2)
+#define IMX6_TEMPSENSE0_MEASURE_TEMP		(1 << 1)
+#define IMX6_TEMPSENSE0_POWER_DOWN		(1 << 0)
+
+#define IMX6_TEMPSENSE1				0x0190
+#define IMX6_TEMPSENSE1_MEASURE_FREQ		0xffff
+#define IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT	0
 
 #define OCOTP_MEM0			0x0480
 #define OCOTP_ANA1			0x04e0
 
+/* Below TEMPSENSE2 is only for TEMPMON_IMX6SX */
+#define IMX6_TEMPSENSE2				0x0290
+#define IMX6_TEMPSENSE2_LOW_VALUE_SHIFT		0
+#define IMX6_TEMPSENSE2_LOW_VALUE_MASK		0xfff
+#define IMX6_TEMPSENSE2_PANIC_VALUE_SHIFT	16
+#define IMX6_TEMPSENSE2_PANIC_VALUE_MASK	0xfff0000
+
+/* i.MX7 specific */
+#define IMX7_ANADIG_DIGPROG			0x800
+#define IMX7_TEMPSENSE0				0x300
+#define IMX7_TEMPSENSE0_PANIC_ALARM_SHIFT	18
+#define IMX7_TEMPSENSE0_PANIC_ALARM_MASK	(0x1ff << 18)
+#define IMX7_TEMPSENSE0_HIGH_ALARM_SHIFT	9
+#define IMX7_TEMPSENSE0_HIGH_ALARM_MASK		(0x1ff << 9)
+#define IMX7_TEMPSENSE0_LOW_ALARM_SHIFT		0
+#define IMX7_TEMPSENSE0_LOW_ALARM_MASK		0x1ff
+
+#define IMX7_TEMPSENSE1				0x310
+#define IMX7_TEMPSENSE1_MEASURE_FREQ_SHIFT	16
+#define IMX7_TEMPSENSE1_MEASURE_FREQ_MASK	(0xffff << 16)
+#define IMX7_TEMPSENSE1_FINISHED		(1 << 11)
+#define IMX7_TEMPSENSE1_MEASURE_TEMP		(1 << 10)
+#define IMX7_TEMPSENSE1_POWER_DOWN		(1 << 9)
+#define IMX7_TEMPSENSE1_TEMP_VALUE_SHIFT	0
+#define IMX7_TEMPSENSE1_TEMP_VALUE_MASK		0x1ff
+
 /* The driver supports 1 passive trip point and 1 critical trip point */
 enum imx_thermal_trip {
 	IMX_TRIP_PASSIVE,
@@ -72,17 +94,114 @@ enum imx_thermal_trip {
 
 #define TEMPMON_IMX6Q			1
 #define TEMPMON_IMX6SX			2
+#define TEMPMON_IMX7D			3
 
 struct thermal_soc_data {
 	u32 version;
+
+	u32 sensor_ctrl;
+	u32 power_down_mask;
+	u32 measure_temp_mask;
+
+	u32 measure_freq_ctrl;
+	u32 measure_freq_mask;
+	u32 measure_freq_shift;
+
+	u32 temp_data;
+	u32 temp_value_mask;
+	u32 temp_value_shift;
+	u32 temp_valid_mask;
+
+	u32 panic_alarm_ctrl;
+	u32 panic_alarm_mask;
+	u32 panic_alarm_shift;
+
+	u32 high_alarm_ctrl;
+	u32 high_alarm_mask;
+	u32 high_alarm_shift;
+
+	u32 low_alarm_ctrl;
+	u32 low_alarm_mask;
+	u32 low_alarm_shift;
 };
 
 static struct thermal_soc_data thermal_imx6q_data = {
 	.version = TEMPMON_IMX6Q,
+
+	.sensor_ctrl = IMX6_TEMPSENSE0,
+	.power_down_mask = IMX6_TEMPSENSE0_POWER_DOWN,
+	.measure_temp_mask = IMX6_TEMPSENSE0_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX6_TEMPSENSE1,
+	.measure_freq_shift = IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX6_TEMPSENSE1_MEASURE_FREQ,
+
+	.temp_data = IMX6_TEMPSENSE0,
+	.temp_value_mask = IMX6_TEMPSENSE0_TEMP_CNT_MASK,
+	.temp_value_shift = IMX6_TEMPSENSE0_TEMP_CNT_SHIFT,
+	.temp_valid_mask = IMX6_TEMPSENSE0_FINISHED,
+
+	.high_alarm_ctrl = IMX6_TEMPSENSE0,
+	.high_alarm_mask = IMX6_TEMPSENSE0_ALARM_VALUE_MASK,
+	.high_alarm_shift = IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT,
 };
 
 static struct thermal_soc_data thermal_imx6sx_data = {
 	.version = TEMPMON_IMX6SX,
+
+	.sensor_ctrl = IMX6_TEMPSENSE0,
+	.power_down_mask = IMX6_TEMPSENSE0_POWER_DOWN,
+	.measure_temp_mask = IMX6_TEMPSENSE0_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX6_TEMPSENSE1,
+	.measure_freq_shift = IMX6_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX6_TEMPSENSE1_MEASURE_FREQ,
+
+	.temp_data = IMX6_TEMPSENSE0,
+	.temp_value_mask = IMX6_TEMPSENSE0_TEMP_CNT_MASK,
+	.temp_value_shift = IMX6_TEMPSENSE0_TEMP_CNT_SHIFT,
+	.temp_valid_mask = IMX6_TEMPSENSE0_FINISHED,
+
+	.high_alarm_ctrl = IMX6_TEMPSENSE0,
+	.high_alarm_mask = IMX6_TEMPSENSE0_ALARM_VALUE_MASK,
+	.high_alarm_shift = IMX6_TEMPSENSE0_ALARM_VALUE_SHIFT,
+
+	.panic_alarm_ctrl = IMX6_TEMPSENSE2,
+	.panic_alarm_mask = IMX6_TEMPSENSE2_PANIC_VALUE_MASK,
+	.panic_alarm_shift = IMX6_TEMPSENSE2_PANIC_VALUE_SHIFT,
+
+	.low_alarm_ctrl = IMX6_TEMPSENSE2,
+	.low_alarm_mask = IMX6_TEMPSENSE2_LOW_VALUE_MASK,
+	.low_alarm_shift = IMX6_TEMPSENSE2_LOW_VALUE_SHIFT,
+};
+
+static struct thermal_soc_data thermal_imx7d_data = {
+	.version = TEMPMON_IMX7D,
+
+	.sensor_ctrl = IMX7_TEMPSENSE1,
+	.power_down_mask = IMX7_TEMPSENSE1_POWER_DOWN,
+	.measure_temp_mask = IMX7_TEMPSENSE1_MEASURE_TEMP,
+
+	.measure_freq_ctrl = IMX7_TEMPSENSE1,
+	.measure_freq_shift = IMX7_TEMPSENSE1_MEASURE_FREQ_SHIFT,
+	.measure_freq_mask = IMX7_TEMPSENSE1_MEASURE_FREQ_MASK,
+
+	.temp_data = IMX7_TEMPSENSE1,
+	.temp_value_mask = IMX7_TEMPSENSE1_TEMP_VALUE_MASK,
+	.temp_value_shift = IMX7_TEMPSENSE1_TEMP_VALUE_SHIFT,
+	.temp_valid_mask = IMX7_TEMPSENSE1_FINISHED,
+
+	.panic_alarm_ctrl = IMX7_TEMPSENSE1,
+	.panic_alarm_mask = IMX7_TEMPSENSE0_PANIC_ALARM_MASK,
+	.panic_alarm_shift = IMX7_TEMPSENSE0_PANIC_ALARM_SHIFT,
+
+	.high_alarm_ctrl = IMX7_TEMPSENSE0,
+	.high_alarm_mask = IMX7_TEMPSENSE0_HIGH_ALARM_MASK,
+	.high_alarm_shift = IMX7_TEMPSENSE0_HIGH_ALARM_SHIFT,
+
+	.low_alarm_ctrl = IMX7_TEMPSENSE0,
+	.low_alarm_mask = IMX7_TEMPSENSE0_LOW_ALARM_MASK,
+	.low_alarm_shift = IMX7_TEMPSENSE0_LOW_ALARM_SHIFT,
 };
 
 struct imx_thermal_data {
@@ -107,31 +226,42 @@ struct imx_thermal_data {
 static void imx_set_panic_temp(struct imx_thermal_data *data,
 			       int panic_temp)
 {
+	const struct thermal_soc_data *soc_data = data->socdata;
 	struct regmap *map = data->tempmon;
 	int critical_value;
 
 	critical_value = (data->c2 - panic_temp) / data->c1;
-	regmap_write(map, TEMPSENSE2 + REG_CLR, TEMPSENSE2_PANIC_VALUE_MASK);
-	regmap_write(map, TEMPSENSE2 + REG_SET, critical_value <<
-			TEMPSENSE2_PANIC_VALUE_SHIFT);
+
+	regmap_write(map, soc_data->panic_alarm_ctrl + REG_CLR,
+		     soc_data->panic_alarm_mask);
+	regmap_write(map, soc_data->panic_alarm_ctrl + REG_SET,
+		     critical_value << soc_data->panic_alarm_shift);
 }
 
 static void imx_set_alarm_temp(struct imx_thermal_data *data,
 			       int alarm_temp)
 {
 	struct regmap *map = data->tempmon;
+	const struct thermal_soc_data *soc_data = data->socdata;
 	int alarm_value;
 
 	data->alarm_temp = alarm_temp;
-	alarm_value = (data->c2 - alarm_temp) / data->c1;
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_ALARM_VALUE_MASK);
-	regmap_write(map, TEMPSENSE0 + REG_SET, alarm_value <<
-			TEMPSENSE0_ALARM_VALUE_SHIFT);
+
+	if (data->socdata->version == TEMPMON_IMX7D)
+		alarm_value = alarm_temp / 1000 + data->c1 - 25;
+	else
+		alarm_value = (data->c2 - alarm_temp) / data->c1;
+
+	regmap_write(map, soc_data->high_alarm_ctrl + REG_CLR,
+		     soc_data->high_alarm_mask);
+	regmap_write(map, soc_data->high_alarm_ctrl + REG_SET,
+		     alarm_value << soc_data->high_alarm_shift);
 }
 
 static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct imx_thermal_data *data = tz->devdata;
+	const struct thermal_soc_data *soc_data = data->socdata;
 	struct regmap *map = data->tempmon;
 	unsigned int n_meas;
 	bool wait;
@@ -139,16 +269,18 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	if (data->mode == THERMAL_DEVICE_ENABLED) {
 		/* Check if a measurement is currently in progress */
-		regmap_read(map, TEMPSENSE0, &val);
-		wait = !(val & TEMPSENSE0_FINISHED);
+		regmap_read(map, soc_data->temp_data, &val);
+		wait = !(val & soc_data->temp_valid_mask);
 	} else {
 		/*
 		 * Every time we measure the temperature, we will power on the
 		 * temperature sensor, enable measurements, take a reading,
 		 * disable measurements, power off the temperature sensor.
 		 */
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			    soc_data->power_down_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			    soc_data->measure_temp_mask);
 
 		wait = true;
 	}
@@ -160,22 +292,28 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (wait)
 		usleep_range(20, 50);
 
-	regmap_read(map, TEMPSENSE0, &val);
+	regmap_read(map, soc_data->temp_data, &val);
 
 	if (data->mode != THERMAL_DEVICE_ENABLED) {
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->measure_temp_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->power_down_mask);
 	}
 
-	if ((val & TEMPSENSE0_FINISHED) == 0) {
+	if ((val & soc_data->temp_valid_mask) == 0) {
 		dev_dbg(&tz->device, "temp measurement never finished\n");
 		return -EAGAIN;
 	}
 
-	n_meas = (val & TEMPSENSE0_TEMP_CNT_MASK) >> TEMPSENSE0_TEMP_CNT_SHIFT;
+	n_meas = (val & soc_data->temp_value_mask)
+		>> soc_data->temp_value_shift;
 
 	/* See imx_init_calib() for formula derivation */
-	*temp = data->c2 - n_meas * data->c1;
+	if (data->socdata->version == TEMPMON_IMX7D)
+		*temp = (n_meas - data->c1 + 25) * 1000;
+	else
+		*temp = data->c2 - n_meas * data->c1;
 
 	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
 	if (data->socdata->version == TEMPMON_IMX6Q) {
@@ -219,21 +357,26 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 {
 	struct imx_thermal_data *data = tz->devdata;
 	struct regmap *map = data->tempmon;
+	const struct thermal_soc_data *soc_data = data->socdata;
 
 	if (mode == THERMAL_DEVICE_ENABLED) {
 		tz->polling_delay = IMX_POLLING_DELAY;
 		tz->passive_delay = IMX_PASSIVE_DELAY;
 
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->power_down_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->measure_temp_mask);
 
 		if (!data->irq_enabled) {
 			data->irq_enabled = true;
 			enable_irq(data->irq);
 		}
 	} else {
-		regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-		regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+		regmap_write(map, soc_data->sensor_ctrl + REG_CLR,
+			     soc_data->measure_temp_mask);
+		regmap_write(map, soc_data->sensor_ctrl + REG_SET,
+			     soc_data->power_down_mask);
 
 		tz->polling_delay = 0;
 		tz->passive_delay = 0;
@@ -355,6 +498,15 @@ static int imx_init_calib(struct platform_device *pdev, u32 ocotp_ana1)
 	}
 
 	/*
+	 * On i.MX7D, we only use the calibration data at 25C to get the temp,
+	 * Tmeas = ( Nmeas - n1) + 25; n1 is the fuse value for 25C.
+	 */
+	if (data->socdata->version == TEMPMON_IMX7D) {
+		data->c1 = (ocotp_ana1 >> 9) & 0x1ff;
+		return 0;
+	}
+
+	/*
 	 * The sensor is calibrated at 25 °C (aka T1) and the value measured
 	 * (aka N1) at this temperature is provided in bits [31:20] in the
 	 * i.MX's OCOTP value ANA1.
@@ -492,6 +644,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 static const struct of_device_id of_imx_thermal_match[] = {
 	{ .compatible = "fsl,imx6q-tempmon", .data = &thermal_imx6q_data, },
 	{ .compatible = "fsl,imx6sx-tempmon", .data = &thermal_imx6sx_data, },
+	{ .compatible = "fsl,imx7d-tempmon", .data = &thermal_imx7d_data, },
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
@@ -523,14 +676,15 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
 	/* make sure the IRQ flag is clear before enabling irq on i.MX6SX */
 	if (data->socdata->version == TEMPMON_IMX6SX) {
-		regmap_write(map, MISC1 + REG_CLR, MISC1_IRQ_TEMPHIGH |
-			MISC1_IRQ_TEMPLOW | MISC1_IRQ_TEMPPANIC);
+		regmap_write(map, IMX6_MISC1 + REG_CLR,
+			IMX6_MISC1_IRQ_TEMPHIGH | IMX6_MISC1_IRQ_TEMPLOW
+			| IMX6_MISC1_IRQ_TEMPPANIC);
 		/*
 		 * reset value of LOW ALARM is incorrect, set it to lowest
 		 * value to avoid false trigger of low alarm.
 		 */
-		regmap_write(map, TEMPSENSE2 + REG_SET,
-			TEMPSENSE2_LOW_VALUE_MASK);
+		regmap_write(map, data->socdata->low_alarm_ctrl + REG_SET,
+			     data->socdata->low_alarm_mask);
 	}
 
 	data->irq = platform_get_irq(pdev, 0);
@@ -557,11 +711,17 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	}
 
 	/* Make sure sensor is in known good state for measurements */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
-	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->measure_temp_mask);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
+		     data->socdata->measure_freq_mask);
+	if (data->socdata->version != TEMPMON_IMX7D)
+		regmap_write(map, IMX6_MISC0 + REG_SET,
+			IMX6_MISC0_REFTOP_SELBIASOFF);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 
 	data->policy = cpufreq_cpu_get(0);
 	if (!data->policy) {
@@ -626,16 +786,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		 data->temp_passive / 1000);
 
 	/* Enable measurements at ~ 10 Hz */
-	regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_CLR,
+		     data->socdata->measure_freq_mask);
 	measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
-	regmap_write(map, TEMPSENSE1 + REG_SET, measure_freq);
+	regmap_write(map, data->socdata->measure_freq_ctrl + REG_SET,
+		     measure_freq << data->socdata->measure_freq_shift);
 	imx_set_alarm_temp(data, data->temp_passive);
 
 	if (data->socdata->version == TEMPMON_IMX6SX)
 		imx_set_panic_temp(data, data->temp_critical);
 
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->measure_temp_mask);
 
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
@@ -661,7 +825,8 @@ static int imx_thermal_remove(struct platform_device *pdev)
 	struct regmap *map = data->tempmon;
 
 	/* Disable measurements */
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 	if (!IS_ERR(data->thermal_clk))
 		clk_disable_unprepare(data->thermal_clk);
 
@@ -684,8 +849,10 @@ static int imx_thermal_suspend(struct device *dev)
 	 * temperature will be read as the thermal sensor is powered
 	 * down.
 	 */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_MEASURE_TEMP);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->measure_temp_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 	data->mode = THERMAL_DEVICE_DISABLED;
 	clk_disable_unprepare(data->thermal_clk);
 
@@ -702,8 +869,10 @@ static int imx_thermal_resume(struct device *dev)
 	if (ret)
 		return ret;
 	/* Enabled thermal sensor after resume */
-	regmap_write(map, TEMPSENSE0 + REG_CLR, TEMPSENSE0_POWER_DOWN);
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_MEASURE_TEMP);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_CLR,
+		     data->socdata->power_down_mask);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->measure_temp_mask);
 	data->mode = THERMAL_DEVICE_ENABLED;
 
 	return 0;
-- 
2.7.4
