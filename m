Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeBEJdx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:33:53 -0500
Received: from mail-sn1nam02on0083.outbound.protection.outlook.com ([104.47.36.83]:12000
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752271AbeBEJdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:33:40 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <rui.zhang@intel.com>, <edubezval@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux@armlinux.org.uk>
CC: <Linux-imx@nxp.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V3 2/2] thermal: imx: add i.MX7 thermal sensor support
Date: Mon, 5 Feb 2018 16:12:27 +0800
Message-ID: <1517818347-7436-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517818347-7436-1-git-send-email-Anson.Huang@nxp.com>
References: <1517818347-7436-1-git-send-email-Anson.Huang@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131622968173320131;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(376002)(396003)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(26826003)(110136005)(16586007)(316002)(2201001)(6666003)(51416003)(86362001)(76176011)(498600001)(59450400001)(50466002)(48376002)(97736004)(356003)(5660300001)(54906003)(2950100002)(72206003)(305945005)(53936002)(68736007)(81166006)(2906002)(8936002)(8676002)(81156014)(450100002)(105606002)(106466001)(4326008)(50226002)(36756003)(336011)(77096007)(85426001)(26005)(47776003)(104016004)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB1423;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD026;1:rs2R/245mz67PcbO+UeW4127lRYrjtYNfVCtu2Orepi0k9deUROwv17RSdnK3WX8HCokzqz5P6TsmqOzMn4X8Nv++m+ib+YeCafqlxTlA4viYZASR96T5pGJdeJiUlyK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a43a6c99-0d02-42ea-2e23-08d56c7b88a7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:CY1PR03MB1423;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1423;3:X7UgRWuHu03/bVdIGGzo3U3Qg5nBHsBqIpmmMR4lZaRj7J0iMt/kzXWb6yA292octdSVmxaZNH19V8xZ5g/B5aGcWe5VZE+MakGKoR5k31b2j1SZcssLyoRsGCMyuhP9+nNDrgqWYC31kx5/Km9o7KfMearYufROA5aetjfALIo5e153h4CBCzzApFBxJY+I5HBQdzsuV8c16ltCs5df8Mdi9An+ubJeLKH53s5NLRvPmmZcg1lqYR9/Vx17v/6EcGp4X9hz1SOxf/Siz5JzK/ylPOnB+DuESAfu9HAnyMud3Lj8Jwd3pdQyonf3HHCbTFjz++CHYRoZ8el75O2S73AoXi3UIeK3RneddfXG5FM=;25:NA/bcaZudCdjGEJkW41Ju6CMF4aWszdCJDpuW4xtjY8NAcOh2tASZpm+PyVMVH+nwxhYhCbbk3tE5DfL/hweGE8KHGv4VKu051MN7+YcqE2hu8vyR30kJ+Ov0yJGmykmAzc99haG/NcRvMch/LOqL5PIFGD8jTDe7nOaFpf1Lf7mxI1yBpMeqGxxKc3gSu6DccWGyYJx+dnUl8D0osc5XCknRFd5S64g9xzn4V1/8iwnphyWMs0Yw7Ykg2C3/MFvs66Rpsx0wsr8HEvTlIvGHxWwfX8l9XQzwu1Vs/7Ze2efJ/72cDdShUbK/KUVHlEnROOXKFdZKWzJ2Bn8qDrQzQ==
X-MS-TrafficTypeDiagnostic: CY1PR03MB1423:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1423;31:oInpfuYwq2ZepECtt079wwOS2xTNoIzPWhW2uzCIfi+Vlbbso9ucSB9zORoWv3L9qM5qb+bkYvk6u6D5mrL5sVOkwgHIoH8MbO/DyByC6AQjvOTrQAh2eMr7ouDMHGYxaYoekPTR6QU5YO5i6ptc8DqLLoKI7TjH+irmGSioxDKj9YZjz3vBAEbNVEH3gFVDA+AyUpWO71C0bKhb4LqYW+5emcM45Bas8EYnM4fF9cE=;4:niFSqXK9AuiuFlZA6Gec4yazqNw+7JQ4KN+Da02/g2JE9zuyBcgM550wiP4V06dL4r3yb4g8rHYX/sikpZsPR/DEZn+p+IWF9bb/lRRdZO75ufjUlgrpfBNO6X9gp+OnLy/FsTKJ8isQGHJVOXJwu751Wvwwj2RtEQurBjQ+G8JiYRaLsYdq8GqnLCDNhlhiBgD8iYM9QR28rLHhw4Wkvy00JGUwMhSECblaTyC0P5htnWRtTHrFoZI7dVjlPHykhCOtc0L8kcsmC5E0MPG/Ofq4aZrSLgkd9D/VlJsMpN25m5QAHAIzOubJgJ0qB2zx
X-Microsoft-Antispam-PRVS: <CY1PR03MB14234B45799B64058320C089F5FE0@CY1PR03MB1423.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231101)(2400082)(944501161)(6055026)(6096035)(20161123561025)(20161123559100)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(201708071742011);SRVR:CY1PR03MB1423;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR03MB1423;
X-Forefront-PRVS: 0574D4712B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR03MB1423;23:JYJPA1fxXFvcUjgg3ExAeJLXR5CNamiaVYRiwQkUy?=
 =?us-ascii?Q?ArkvKsbBnnushWtqJ9FVXN9VDvU9RukK9xznDE4pG7xIyb2gLgNJXprARDvx?=
 =?us-ascii?Q?FpbY1LEj5HyGGTv4iYn5aPuRWxXm6FZggXDvc3SsMFtlci8cYpEga7nnNWCu?=
 =?us-ascii?Q?NUZapleSebcuErF5KSWXIZSkEKaPX1mhUGvOPvM9PKdCA2kC9NuRfApBAQZ9?=
 =?us-ascii?Q?up7Evb+QPBqXt7qlJDdA9dPTupJ4Fj+j3GeemKIE7JMrcCTw4CfUBUJs3hhH?=
 =?us-ascii?Q?rieu2Er1yjZAnGNz2Rum6QFtxgtbA+G6ykNfgsIDVXEZ88lshmxh1WwUvlp3?=
 =?us-ascii?Q?WVYOOZSh89Go9u3ih99mlt5CCsXn/c2Ac/SLIcCsPob6Z6hX12WTfM6KJ5mM?=
 =?us-ascii?Q?MX6GNoVxSZxPm8wP6WADOlB3bdnkvpvrMFF3TYN6xd0DDytdI+KaU7rR5gZW?=
 =?us-ascii?Q?1WNB0feeNGmAg3iJlREJ6/wMh1H8HiNz0JBc3WqaKY6bBtMwYI0Jglgsrgp6?=
 =?us-ascii?Q?ePe0DeNpzVmzpHfTwIrOAhuaHA6KO8yAy+mdqoB/gdFYEPieNw5kULTH26VH?=
 =?us-ascii?Q?uyEURjnBCCsMFihCLWHBk8kjt5VkucYR5XaSCiGNGASsZ0/spGVQThhRrb/C?=
 =?us-ascii?Q?4FoNhRgKQlVavJiaujbCtpPaQUXWqQ3qdLeRi8nUgKQE0S6dMXa4sjtkCGCd?=
 =?us-ascii?Q?fPIYiU/WFAIAfZaeVpsSPNsBUcEAcDRQ9Afe8Nye+8UtGcookChOcZc+cTPU?=
 =?us-ascii?Q?J0qMuPz4ME4GuRblh/zYqnRqJuUcMjbKJTARMSKMURJYQPI07s9TM+BqGkSy?=
 =?us-ascii?Q?i4hqOInqU7ramKRyDOusujUXUGrIcXKe5egKEXUfCseRkF663FrwZ0MhTO+c?=
 =?us-ascii?Q?Q0zOy1SNMR5gvGfrX/KDQm8paWRd0IEqMyvzmOPj0ajLn5v9J4K2Sjr7REv+?=
 =?us-ascii?Q?HUXRl6bVR57kiyXp4r6RSS7tAxm4udN/qxmMLOU5MLaAtUNZhebsdxJ03ib8?=
 =?us-ascii?Q?IMNL+4EUJv22noIdOiw6QkKSz1VB8jPhcwBD6v3GIoBNPMfF6S2+shdyWBLg?=
 =?us-ascii?Q?gjfy8kXwe0BUt9QIBhbpNLwNNqjRQRZmXKy2BDWl8jTb3mxMKFHY5qQz/lVx?=
 =?us-ascii?Q?CjQUmTowXXbA/TvqeLfflvUNecMSoLVT5UKCXWuMVYAvNPItATh9MRZcq/eV?=
 =?us-ascii?Q?6Jardhtd4LtMhBum8ujKXSmPVLl6D2iSPpm?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR03MB1423;6:anqDlISfIxLlglG0Cihb3IRSdCLZhu+7DF/7wnKPeaXhsIQfzBbCdLe5ca51v4chpVNaaJ2qT38+nPjFxWC+JvxFa0UAe21s9GdamI8Kc+86u8pxl7nWph7zUW+Gk5S87w9g2/q9dlYbrtXFF8nwhtecSCnwTEkGTy9RQUZP/W+K7ew8CEjRNQu7FHBf6jaByW92x2m3BCzY5ZSOWtY99B/UNLEgd5QfYim7+G1WKh+9JqyUfwUMJpz8Y+qaj6PomjHALaOv7LUREO7PQ29ej5WBB4pE8NDlJlyZrvr6Ku2ulAjxsrSI8U2uWupj4oG0AejfmxOTo/94rMgnDQhC0dkANrQcIq6wemKCHTkcjLc=;5:7YY3/hwLjxAd80MaIHnEBbeDIf/HCtC3H5Cf3HRwJivYYu6VjcW9NP0vrcUXiyfMRxxjMSZPgoh5/e0QA0aqtDQCZ77fPXjy3ZHp2Xe7tciToRaTqOoqgOyaxspUd17TT7FeyfK+iT1BJ3TffKmif25i8drwbGOaeAKAXtKsUw0=;24:zq05LJ768+RujinYrZERMNZPYrQMLDvZGYi/zihx3WloyM0H6nZXpbh1DSDbbT2SkzQzJW/BFkVCIfunnsMdzPjhIQcdwWJHAc9zLr+EuCw=;7:dHYbOOZMQv7sIs9eONJNPrtVkAwv5Iy40sFuBn4XRg1V1WBltxCJlckbmYMQu7SV9dyrCxW/r6nKyPr362cGAnEj0FTGNfcBKBUzIqT1Yph6XKrPUHS03ejwv/Jp/9HyfkevucH5YahzgdVCXmQKjNIx0MOPmn9MxGQcgGJP9rkryzWyBFIolZTysPtLe5NQGneskVNdrMS7WTd83fae4AAdLiwoVq15gLAtilRm73xs0gm0sZ40Jy8OKRb+q0DC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 09:33:32.5272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43a6c99-0d02-42ea-2e23-08d56c7b88a7
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB1423
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
---
changes since V2:
	Add bindind doc changes in this patch according to review comments.
 .../devicetree/bindings/thermal/imx-thermal.txt    |   9 +-
 drivers/thermal/imx_thermal.c                      | 314 ++++++++++++++++-----
 2 files changed, 254 insertions(+), 69 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
index 28be51a..79f97bc 100644
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
+  - "fsl,imx7-tempmon" for i.MX7S/D.
+- interrupts : the interrupt output of the controller:
+  i.MX6Q has one IRQ which will be triggered when temperature is higher than high threshold,
+  i.MX6SX and i.MX7S/D have two more IRQs than i.MX6Q, one is IRQ_LOW and the other is IRQ_PANIC,
   when temperature is below than low threshold, IRQ_LOW will be triggered, when temperature
   is higher than panic threshold, system will auto reboot by SRC module.
 - fsl,tempmon : phandle pointer to system controller that contains TEMPMON
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index e7d4ffc..c95fa82 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -31,34 +31,58 @@
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
 
-#define OCOTP_MEM0			0x0480
-#define OCOTP_ANA1			0x04e0
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
+#define IMX6_OCOTP_MEM0				0x0480
+#define IMX6_OCOTP_ANA1				0x04e0
+#define IMX7_OCOTP_TESTER3			0x0440
+#define IMX7_OCOTP_ANA1				0x04f0
 
 /* The driver supports 1 passive trip point and 1 critical trip point */
 enum imx_thermal_trip {
@@ -76,17 +100,114 @@ enum imx_thermal_trip {
 
 #define TEMPMON_IMX6Q			1
 #define TEMPMON_IMX6SX			2
+#define TEMPMON_IMX7			3
 
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
+static struct thermal_soc_data thermal_imx7_data = {
+	.version = TEMPMON_IMX7,
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
@@ -112,30 +233,41 @@ static void imx_set_panic_temp(struct imx_thermal_data *data,
 			       int panic_temp)
 {
 	struct regmap *map = data->tempmon;
+	const struct thermal_soc_data *soc_data = data->socdata;
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
+	if (data->socdata->version == TEMPMON_IMX7)
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
@@ -143,16 +275,18 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 
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
@@ -164,22 +298,28 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
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
+	if (data->socdata->version == TEMPMON_IMX7)
+		*temp = (n_meas - data->c1 + 25) * 1000;
+	else
+		*temp = data->c2 - n_meas * data->c1;
 
 	/* Update alarm value to next higher trip point for TEMPMON_IMX6Q */
 	if (data->socdata->version == TEMPMON_IMX6Q) {
@@ -223,21 +363,26 @@ static int imx_set_mode(struct thermal_zone_device *tz,
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
@@ -359,6 +504,15 @@ static int imx_init_calib(struct platform_device *pdev, u32 val)
 	}
 
 	/*
+	 * On i.MX7, we only use the calibration data at 25C to get the temp,
+	 * Tmeas = ( Nmeas - n1) + 25; n1 is the fuse value for 25C.
+	 */
+	if (data->socdata->version == TEMPMON_IMX7) {
+		data->c1 = (val >> 9) & 0x1ff;
+		return 0;
+	}
+
+	/*
 	 * Sensor data layout:
 	 *   [31:20] - sensor value @ 25C
 	 * Use universal formula now and only need sensor value @ 25C
@@ -426,6 +580,7 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 val)
 
 static int imx_init_from_tempmon_data(struct platform_device *pdev)
 {
+	const struct imx_thermal_data *data = platform_get_drvdata(pdev);
 	struct regmap *map;
 	int ret;
 	u32 val;
@@ -438,7 +593,11 @@ static int imx_init_from_tempmon_data(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = regmap_read(map, OCOTP_ANA1, &val);
+	if (data->socdata->version == TEMPMON_IMX7)
+		ret = regmap_read(map, IMX7_OCOTP_ANA1, &val);
+	else
+		ret = regmap_read(map, IMX6_OCOTP_ANA1, &val);
+
 	if (ret) {
 		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
 		return ret;
@@ -447,7 +606,11 @@ static int imx_init_from_tempmon_data(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(map, OCOTP_MEM0, &val);
+	/* use OTP for thermal grade */
+	if (data->socdata->version == TEMPMON_IMX7)
+		ret = regmap_read(map, IMX7_OCOTP_TESTER3, &val);
+	else
+		ret = regmap_read(map, IMX6_OCOTP_MEM0, &val);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to read sensor data: %d\n", ret);
 		return ret;
@@ -500,6 +663,7 @@ static irqreturn_t imx_thermal_alarm_irq_thread(int irq, void *dev)
 static const struct of_device_id of_imx_thermal_match[] = {
 	{ .compatible = "fsl,imx6q-tempmon", .data = &thermal_imx6q_data, },
 	{ .compatible = "fsl,imx6sx-tempmon", .data = &thermal_imx6sx_data, },
+	{ .compatible = "fsl,imx7-tempmon", .data = &thermal_imx7_data, },
 	{ /* end */ }
 };
 MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
@@ -531,14 +695,15 @@ static int imx_thermal_probe(struct platform_device *pdev)
 
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
@@ -565,11 +730,17 @@ static int imx_thermal_probe(struct platform_device *pdev)
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
+	if (data->socdata->version != TEMPMON_IMX7)
+		regmap_write(map, IMX6_MISC0 + REG_SET,
+			IMX6_MISC0_REFTOP_SELBIASOFF);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 
 	data->policy = cpufreq_cpu_get(0);
 	if (!data->policy) {
@@ -634,16 +805,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
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
@@ -669,7 +844,8 @@ static int imx_thermal_remove(struct platform_device *pdev)
 	struct regmap *map = data->tempmon;
 
 	/* Disable measurements */
-	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
+	regmap_write(map, data->socdata->sensor_ctrl + REG_SET,
+		     data->socdata->power_down_mask);
 	if (!IS_ERR(data->thermal_clk))
 		clk_disable_unprepare(data->thermal_clk);
 
@@ -692,8 +868,10 @@ static int imx_thermal_suspend(struct device *dev)
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
 
@@ -710,8 +888,10 @@ static int imx_thermal_resume(struct device *dev)
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
