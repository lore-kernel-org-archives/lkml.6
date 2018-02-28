Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965417AbeCAA4L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:56:11 -0500
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:19360
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965286AbeCAA4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:56:07 -0500
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
Subject: [PATCH V5 2/2] thermal: imx: add i.MX7 thermal sensor support
Date: Thu, 1 Mar 2018 07:09:40 +0800
Message-ID: <1519859380-15878-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519859380-15878-1-git-send-email-Anson.Huang@nxp.com>
References: <1519859380-15878-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131643393558411983;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(346002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(59450400001)(336011)(8676002)(81156014)(8936002)(81166006)(5660300001)(36756003)(450100002)(4326008)(106466001)(53936002)(107886003)(104016004)(86362001)(2906002)(77096007)(2201001)(26005)(5820100001)(2870700001)(50226002)(305945005)(356003)(23676004)(76176011)(54906003)(316002)(110136005)(2950100002)(105606002)(498600001)(6666003)(47776003)(50466002)(26826003)(72206003)(85426001)(97736004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB0731;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD017;1:qyEIJgrkuPqlQv6nd9scHTJVGHAbalh1L5T58Cx8YPmmS8apL0Kd2NwzoqjIPQfXBUoWfeT3mAMdGUQaol5yfqTZtC90vKC3yeEk5vz3Mr5QkG6JCiRnfQ2XkAZxVV7L
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ed93bc0-62e1-49e6-0e66-08d57f0f3075
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:CY1PR0301MB0731;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB0731;3:DChYBD4J9Jo5yjpfZhTujsDVrmxFfuFDdwDz21X3+wVuTZG4QWnZSTC/Rs0Peu+YFoA7tRqRyeAMgNm32mWQWUwmaZkDpJWAfFu9kIRQliCA7nsjSz4cwBYFvKso7FfGwgVFfR3P1BqYfC46Ob1ZdyuvB2av/KSewl6VtHxA4QvuXrk1ZyhwEzzKgVkZv6EzKY23tfpGSfZqixNY/wxFwvdDLap/5QRLQwN6wAaO9aDNUQFKBWSdmQ6k68UqhuAQVX/2wK75MX0SB4bn/G7WVrPaICulK9gCjj3pGZjkDua/XEShDGFSeYEEmkxtodqrb+/PAbq87CainPExo7zmAyuv8+l8ui32y/eSMSbrRxw=;25:GInEesWJXHW810udE2IhcW2gfCU3wJAnC+eCA6yNnQ+nIH7Sd7iXSsb/+84bG6j784VDsEwG68I1R0iHyr70jZuHcso86B7GhFqUVDZ2PJqf24HMkjMkV7xnLCzTdIPvnpIbzdUWc7iNBYbTbUlq3woQF394CwTMAEv7PsGe8lj8jg4Mqw/zkUWOtgwnMi0qxScGAUQNUPXUq8shNc2S6qsi0b4kSnOFcecBsj1wNKIXrRUwWXrkzzP0Fx8w1XxpDV1gfGDLfMZuj0KSodgEpMICBshiYrkJRuZNE4cVWqm5PDPWVQBh4H1Zjh4fYnNwmSZqVn/60nMZZBC/o0l/RA==
X-MS-TrafficTypeDiagnostic: CY1PR0301MB0731:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB0731;31:9FuKYzKvKcQxcmmx9LsdO3mCs2CKZ2YREswAeqnO6a63KorBn9URsqDyL3vw8c0mG/uSTZ/1eBC1A/IblTzxzk+rMeK6ltKK3JRRqpOp1by1xWl677A4fP83zfUHomkI5wcV53gP6q64dX+BYuyvs4iVTLjVOOZjsSMFZfJSKuEv2A66dxLcikk2n9Uhs1AuPoUedXkFt/j+AdPs18mOXBrMcGLY6aqU1r6eJqNe9Jk=;4:zE8rxQzM0dKf26p3yTfAwY0mhnaG8MOOV2IJg2IGHXtutjaFoUWhwYpY6F7Yu34VZcLjLvtfQCbkZeVBQMtqTObRI07O5nh2bIO+nvUyskkjQIIy0xgiM3HJkkfejuj5pK8/KvZtFnrIrhmBjr5xQyuVMly8IeJddezNb4+4rG+9wxmDG9KsHQxh68iVwjGHRNMSUPyjbV54wB/aLIXv0XoeItmoR551QgW0VD6f6g7xR6dyHEFfDKuHzwndnBZh9iMdGGO3SQI4LURze79X7i8Z+EmOlams5cD7rlK5e78zzd9+z8tglpa6jzpbmxee
X-Microsoft-Antispam-PRVS: <CY1PR0301MB07319949D0BA5FCC9E673501F5C60@CY1PR0301MB0731.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501221)(52105095)(93006095)(93001095)(6055026)(6096035)(20161123563025)(20161123561025)(20161123565025)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(20161123559100)(20161123556025)(201708071742011);SRVR:CY1PR0301MB0731;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR0301MB0731;
X-Forefront-PRVS: 05986C03E0
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAzMDFNQjA3MzE7MjM6SHhYR3ZtK0J5WFhoTXdSUEM3cW4yam90?=
 =?utf-8?B?SnBWdTNQYlg4MVBYSmxFSTBHbnhZaUZ4NDFDY2FqKzd4am1oZTlkeU55K2FT?=
 =?utf-8?B?OFhuZlhOUUtsSFRtd1pOamRWeVZ1Ti9ZeHFEU2hwZlkwOWkyY25DbjNYL2NF?=
 =?utf-8?B?Z3YwZVhqREIrR24yc25meXNBQXlWOGdoR0JHQ0duNDJpMk4zaVZlcG5haWJy?=
 =?utf-8?B?V1lLei9CUms2OGRVbGNsQ1FFc2grM3U3SDAzWUFxY2pXdG1CYkJUS0lnTzBt?=
 =?utf-8?B?ZG00d042eGlIZWdlSWhLemFKMTBwNlkzYzBtQnZJVGVNdndQTGVodG93V0RY?=
 =?utf-8?B?cVVHbFc5aVRjYjhCRlF2NVQyRFp0Ym9GY293aVVqa2MydnE5V1l3N1hYbmhL?=
 =?utf-8?B?cDRCUCsrM1U2TFdwZjlxS29lZEVrZGF4VWhhN1AxRkpwbzlobVBUNjBoTEFZ?=
 =?utf-8?B?c0V4MVZZeWh3SDQycWN6RUhSa2daR0dMRU1aaHdyUW9BNVY1dVg5TW5lYUN4?=
 =?utf-8?B?WE1EUC8vRlJmVjJWVGRTUVc0NnF0elFSY0tSMzJKc283WFJzN2JBRzhYTXEv?=
 =?utf-8?B?cmNBcTdKKytTMVdCeG4wNjZqSHdjYVQ2RFFLS3NGNXFuUjIwVVVmN09IL1ds?=
 =?utf-8?B?ZThGZS92L2J1U3A0ckRKMkpBZzFjUHMydTVBc1VpTFoxaGtoSXJRcnE5WUFU?=
 =?utf-8?B?Z1BsVmpXd0duN1diZzdBWDlTVW9YLzBOY2hqb3NYRXFtL0hyTCtCUHgxeXFK?=
 =?utf-8?B?Nm9mNlArZVZzdk9HRmlkeGJXQTNzak8ybkJ3aFRIRnF2ZFh3Um5IdVNmalo4?=
 =?utf-8?B?V21maEtIZityc2NRaVBPRlBFemVrS3kvSUIxWHFnT1NLNlRxOHdOZTBEUjgx?=
 =?utf-8?B?elFOdDJpWVQ0NkwwdWFtRE5qN3ZmNnRjRUdPOUs0UWRiTHFneDlsRURmc3JN?=
 =?utf-8?B?U3hoZlBsNmZaQ0gvY2U0RHJGYTJ0Zmp0NFpZc3BFR3U2RW85OGJ6K2VqMGFp?=
 =?utf-8?B?MFl0NWNjK2FjOG04KzMxVTNTZFBPMlFCUE1KQmpHRjc3N0xBVlY2ZVF1M0lV?=
 =?utf-8?B?L1prRU9ac1M2MC9UTzlLT1JXK3RKcDZaOWxIM1gwYmVEUktMaUtJeGczR0Q3?=
 =?utf-8?B?Y1ZIZW1icjMxN01Jc3BDZmhVcU5jQkJUMFRCbWM4WDNsT0I5UzRZdkM2a2Ev?=
 =?utf-8?B?dyt4Z0hxUUdJcTBncCs3ckh3ZlZwMHJzbkI0YXNIZ0lXZG00MXU0NzBTblZ6?=
 =?utf-8?B?RzdkN1pEbGFuckt0MEdZZ21nTXhPNmxRNnpGR2dBZ1ovOXVYM0prbER0VFlq?=
 =?utf-8?B?bkFtaERuTnlFUlk0RDFhSTFxd0xVZEZ4WTB4ZXBoMlZIU24vaUcySnd1QmRV?=
 =?utf-8?B?czh3VW1tNDl1ZmZBWVJ5NlhXdXNqT0JadGlXZEFxK3IzMGJ1eHIvTGpScFpC?=
 =?utf-8?B?OFd2T2tPQ3JKa2k5UWZ0b0R0MmplZXU1RUpEMkQrUjErbG9oOERCTHd6WjAv?=
 =?utf-8?B?NG1ob3hCWEhCZWxQNjk3cUU4Mm55TGJHWTRJUmgxdW8yalhWMkxVakRoSktl?=
 =?utf-8?B?dGVMRXpMbE1JKzhKTEFjVnZ0bG9MQmplVEM4dnUzNlU1NWMybURJWW5WNFhs?=
 =?utf-8?Q?K9Xj9UUAKMeIlMTXkdkwG6?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB0731;6:siAcq6Ej/+B67hcrWCy10Gu8Ae8PvWV3fcnvDje3ovItOrVamwqBKs58vbMiUSQ8DouFsJpOxbufZxH9EcOK3Hg1GLBEUyuaYw9JZMBOUyQzSJtco03UPfyy9k6JTob9X0aCbwuWkiTDNR8FFZCefPszy7Qr4OCwQpIM+bmRT5sKB+WoRT1DgvCWXRaLWXCsqgClvMANwnI96QVKPd/Thfes9Umha0OapKrHkYreXVOq6tINpsqNemVtuVNbiF6NI/Jo20NlwEPbp1KoI4NdeKtOEBf9ChmhBQMxwJZT5b5RVz7pp16qgMZjiXHkuPtz8nRLNcYcxnWx8u4KKD6XaxLnqMAVZrLhxjlDjVrQvrQ=;5:HYmkH6mKPTG+UMcAWtz83bL1mIiCKps7ALkNRqXoudvKE2x8UhVc2xsG00cz7ja43jAzt2d11lR4QKO6JoPRf2QX8Tdc8Y86P3eNfR6GnVs9fxKylGX76yiXfCqq2rpTN54hoZkgUBnRYp1OYM2KwqkkuhzDM3G0k6sb2CquWjw=;24:Z/Aj96qz8AWc8tbkOa+PGphTOiXQOeDlg0jUBnVzFrJoBoMZHOj8ZzbhKyeVlO4FuaZrHW/Qmtoq3buRcd9+Qj/gljtD7kexcFgfKpv/oQY=;7:4PTMLyuyL1jtKMioSxclpGaidblsistaStANjtrDYQ/xyuuo9r9h/TFlXdUY1b0nJMdnK5VKtvUkMafkOcyTczoq0kQ/gbcNNwPAbsWe7uklHw3UOX7v2Vv/5SlpwrvSlI7QjCAQWqc3AJhfHqATb5qC6eLn6Ps65FfajFjcp9OIKkm3vOFvZdwJ6kYKEwGq41KWqAsDTuy6rLXKOlSsLzHAaKcyjjxzApQBXlkk7ZJpmXv8n5WDrlvtNDbum64f
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 00:55:44.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed93bc0-62e1-49e6-0e66-08d57f0f3075
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB0731
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
---
changes since V4:
	drop direct OCOTP register access for i.mx7d since it is a new added platform,
	only support reading ocotp values through the ocotp nvmem driver which handles clock.
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
